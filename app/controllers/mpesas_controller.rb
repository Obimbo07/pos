class MpesasController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :stkpush
    require 'rest-client'
    
    def stkpush
        phoneNumber = params[:phoneNumber]
        amount = params[:amount]
        url = "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest"
        timestamp = "#{Time.now.strftime "%Y%m%d%H%M%S"}"
        business_short_code = ENV["MPESA_SHORT_CODE"]
        password = Base64.strict_encode64("#{business_short_code}#{ENV["MPESA_PASSKEY"]}#{timestamp}")
        payload = {
          'BusinessShortCode': business_short_code,
          'Password': password,
          'Timestamp': timestamp,
          'TransactionType': "CustomerPayBillOnline",
          'Amount': amount,
          'PartyA': phoneNumber,
          'PartyB': business_short_code,
          'PhoneNumber': phoneNumber,
          'CallBackURL': "#{ENV["CALLBACK_URL"]}/callback_url",
          'AccountReference': 'Codearn',
          'TransactionDesc': "Payment for Codearn premium"
        }.to_json
      
        headers = {
          Content_type: 'application/json',
          Authorization: "Bearer #{access_token}"
        }
      
        response = RestClient::Request.new({
          method: :post,
          url: url,
          payload: payload,
          headers: headers
        }).execute do |response, request|
          case response.code
          when 500
            [:error, JSON.parse(response.to_str)]
          when 400
            [:error, JSON.parse(response.to_str)]
          when 200
            [:success, JSON.parse(response.to_str)]
          else
            fail "Invalid response #{response.to_str} received."
          end
        end
      
        if response[0] == :success
          response_data = response[1]
          
          # Extract relevant data from the response
          checkoutRequestID = response_data["CheckoutRequestID"]
          merchantRequestID = response_data["MerchantRequestID"]
      
          # Save data to the database
          Mpesa.create(
            phoneNumber: phoneNumber,
            amount: amount,
            checkoutRequestID: checkoutRequestID,
            merchantRequestID: merchantRequestID
        )

        MpesaQueryJob.set(wait: 1.minutes).perform_later(checkoutRequestID)
        end
      
        puts response[1]    
    end
      

    def stkquery
        @mpesa = Mpesa.find_by(checkoutRequestID: params[:checkoutRequestID])
        return render json: { error: "Transaction not found" }, status: :not_found unless @mpesa

        url = "https://sandbox.safaricom.co.ke/mpesa/stkpushquery/v1/query"
        timestamp = "#{Time.now.strftime "%Y%m%d%H%M%S"}"
        business_short_code = ENV["MPESA_SHORT_CODE"]
        password = Base64.strict_encode64("#{business_short_code}#{ENV["MPESA_PASSKEY"]}#{timestamp}")
        payload = {
            'BusinessShortCode': business_short_code,
            'Password': password,
            'Timestamp': timestamp,
            'CheckoutRequestID': params[:checkoutRequestID]
        }.to_json

        puts payload.to_json

        headers = {
            Content_type: 'application/json',
            Authorization: "Bearer #{ access_token }"
        }

        response = RestClient::Request.new({
            method: :post,
            url: url,
            payload: payload,
            headers: headers
        }).execute do |response, request|
            case response.code
            when 500
                [ :error, JSON.parse(response.to_str) ]
            when 400
                [ :error, JSON.parse(response.to_str) ]
            when 200
                [ :success, JSON.parse(response.to_str) ]
            else
                fail "Invalid response #{response.to_str} received."
            end
        end
       
        if response[0] == :success
            @transaction_status = response[1]
          else
            @transaction_status = response[1]
        end
    end

    private

    def generate_access_token_request
        @url = "https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials"
        @consumer_key = ENV['MPESA_CONSUMER_KEY']
        @consumer_secret = ENV['MPESA_CONSUMER_SECRET']
        @userpass = Base64::strict_encode64("#{@consumer_key}:#{@consumer_secret}")
        headers = {
            Authorization: "Bearer #{@userpass}"
        }
        res = RestClient::Request.execute( url: @url, method: :get, headers: {
            Authorization: "Basic #{@userpass}"
        })
        res
    end

    def access_token
        res = generate_access_token_request()
        if res.code != 200
            r = generate_access_token_request()
            if res.code != 200
                raise MpesaError('Unable to generate access token')
            end
        end
        body = JSON.parse(res, { symbolize_names: true })
        token = body[:access_token]
        AccessToken.destroy_all()
        AccessToken.create!(token: token)
        token
    end
end
