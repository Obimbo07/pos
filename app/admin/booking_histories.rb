ActiveAdmin.register BookingHistory do
  permit_params :user_name, :phone_number, :service_id, :session_id, :inventory_id, worker_ids: []

  form do |f|
    f.inputs 'Booking History Details' do
      f.input :user_name
      f.input :phone_number
      f.input :service_id, as: :select, collection: Service.all
      f.input :session_id
      f.input :inventory_id, as: :select, collection: Inventory.all
      f.input :workers, as: :check_boxes, collection: Worker.all
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :user_name
    column :phone_number
    column :service_id
    column :session_id
    column :inventory_id
    column :workers do |booking_history|
      booking_history.workers.map(&:name).join(', ')
    end
    column :service do |booking_history|
      booking_history.service&.name
    end
    column :inventory do |booking_history|
      booking_history.inventory&.name
    end
    column :commissions do |booking_history|
      puts booking_history.worker_commissions.inspect
      booking_history.worker_commissions.map { |wc| "#{wc.worker.name}: #{wc.commission} (#{wc.timestamp})" }.join(', ')
    end
    actions
  end

  show do
    attributes_table do
      row :user_name
      row :phone_number
      row :service_id
      row :session_id
      row :inventory_id
      row :workers do |booking_history|
        booking_history.workers.map(&:name).join(', ')
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
