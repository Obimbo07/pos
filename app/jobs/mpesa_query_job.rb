# app/jobs/mpesa_query_job.rb
class MpesaQueryJob < ApplicationJob
  queue_as :default

  def perform(checkoutRequestID, retries = 3, delay = 2.minutes)
    url = "https://sandbox.safaricom.co.ke/mpesa/stkpushquery/v1/query"
    timestamp = "#{Time.now.strftime "%Y%m%d%H%M%S"}"
    business_short_code = ENV["MPESA_SHORT_CODE"]
    password = Base64.strict_encode64("#{business_short_code}#{ENV["MPESA_PASSKEY"]}#{timestamp}")
    payload = {
      'BusinessShortCode': business_short_code,
      'Password': password,
      'Timestamp': timestamp,
      'CheckoutRequestID': checkoutRequestID
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
      # Update the Mpesa record with the response data
      Mpesa.where(checkoutRequestID: checkoutRequestID).update_all(
        mpesaReceiptNumber: response[1]["MpesaReceiptNumber"]
      )
    else
      # Retry the job if retries are left
      if retries > 0
        self.class.set(wait: delay).perform_later(checkoutRequestID, retries - 1, delay)
      else
        Rails.logger.error "MpesaQueryJob failed for CheckoutRequestID: #{checkoutRequestID}"
      end
    end
  end

  private

  def access_token
    # Same implementation as in your controller
    res = generate_access_token_request()
    if res.code != 200
      r = generate_access_token_request()
      if res.code != 200
        raise MpesaError('Unable to generate access token')
      end
    end
    body = JSON.parse(res, { symbolize_names: true })
    body[:access_token]
  end

  def generate_access_token_request
    url = "https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials"
    consumer_key = ENV['MPESA_CONSUMER_KEY']
    consumer_secret = ENV['MPESA_CONSUMER_SECRET']
    userpass = Base64::strict_encode64("#{consumer_key}:#{consumer_secret}")
    headers = {
      Authorization: "Basic #{userpass}"
    }
    RestClient::Request.execute(url: url, method: :get, headers: headers)
  end
end
