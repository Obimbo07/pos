ActiveAdmin.register BookingHistory do
  permit_params :user_name, :phone_number, :session_id, :is_paid, :payment_method, service_ids: [], inventory_ids: [], worker_ids: []

  form do |f|
    f.inputs 'Booking History Details' do
      f.input :user_name
      f.input :phone_number
      f.input :services, as: :check_boxes, collection: Service.all
      f.input :session_id
      f.input :inventory, as: :select, collection: Inventory.all
      f.input :workers, as: :check_boxes, collection: Worker.all
      f.input :is_paid
      f.input :payment_method, as: :select, collection: ['Cash', 'Card', 'Mpesa']
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :user_name
    column :phone_number
    column :session_id
    column :is_paid
    column :payment_method
    column :services do |booking_history|
      booking_history.services.map(&:name).join(', ')
    end
    column :inventory do |booking_history|
      booking_history.inventory&.name
    end
    column :workers do |booking_history|
      booking_history.workers.map(&:name).join(', ')
    end
    actions
  end

  show do
    attributes_table do
      row :user_name
      row :phone_number
      row :session_id
      row :is_paid
      row :payment_method
      row :services do |booking_history|
        booking_history.services.map(&:name).join(', ')
      end
      row :inventory do |booking_history|
        booking_history.inventory&.name
      end
      row :workers do |booking_history|
        booking_history.workers.map(&:name).join(', ')
      end
    end
    active_admin_comments
  end

  filter :user_name
  filter :phone_number
  filter :session_id
  filter :is_paid
  filter :payment_method
  filter :services
  filter :inventory
  filter :workers
end
