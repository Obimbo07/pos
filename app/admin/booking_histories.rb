ActiveAdmin.register BookingHistory do
  permit_params :user_name, :phone_number, :session_id, :is_paid, :payment_method, service_ids: [], inventory_ids: [], worker_ids: []

  form do |f|
    f.inputs 'Booking History Details' do
      f.input :user_name
      f.input :phone_number
      f.input :service_ids, as: :check_boxes, collection: Service.all
      f.input :session_id
      f.input :inventory_ids, as: :check_boxes, collection: Inventory.all
      f.input :worker_ids, as: :check_boxes, collection: Worker.all
      f.input :is_paid
      f.input :payment_method
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :user_name
    column :phone_number
    column :is_paid
    column :payment_method
    column :session_id
    column :workers do |booking_history|
      booking_history.workers.map(&:name).join(', ')
    end
    column :service do |booking_history|
      booking_history.services.each do |service|
        service&.name
      end
    end
    column :inventory do |booking_history|
      booking_history.inventories.each do |inventory|
        inventory&.name
      end
    end
    # column :commissions do |booking_history|
    #   puts booking_history.worker_commissions.inspect
    #   booking_history.worker_commissions.map { |wc| "#{wc.worker.name}: #{wc.commission} (#{wc.timestamp})" }.join(', ')
    # end
    actions
  end

  show do
    attributes_table do
      row :user_name
      row :phone_number
      row :is_paid
      row :payment_method
      row :session_id
      row :workers do |booking_history|
        booking_history.workers.each do |worker|
          worker&.name
        end
      end
      row :service do |booking_history|
        booking_history.services.each do |service|
          service&.name
        end
      end
      row :inventory do |booking_history|
        booking_history.inventories.each do |inventory|
          inventory&.name
        end
      end
      row :commissions do |booking_history|
        booking_history.worker_commissions.map { |wc| "#{wc.worker.name}: #{wc.commission} (#{wc.timestamp})" }.join(', ')
      end
    end
    active_admin_comments
  end

  filter :user_name
  filter :phone_number
  filter :service
  filter :session_id
  filter :inventory
  filter :workers, as: :select, collection: proc { Worker.all }
end
