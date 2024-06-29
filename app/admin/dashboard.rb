ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    columns do
      column do
        panel "Booking History" do
          div do
            line_chart BookingHistory.group_by_day(:created_at).count
          end
        end

        panel "Services" do
          div do
            pie_chart Service.group(:name).count
          end
        end
      end

      column do
        panel "Workers Commission" do
          div do
            column_chart WorkerCommission.group_by_day(:timestamp).sum(:commission)
          end
        end
      end

      column do
        panel "Payments" do
          div do
            pie_chart BookingHistory.group(:payment_method).count
          end
        end
      end

    end
  end
end
