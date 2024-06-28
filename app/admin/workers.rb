ActiveAdmin.register Worker do
  permit_params :name, :email, :phone, :password, :password_confirmation, service_ids: []

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :phone
    column :encrypted_password
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs 'Worker Details' do
      f.input :name
      f.input :email
      f.input :phone
      f.input :services, as: :check_boxes, collection: Service.all
      f.input :password, input_html: { id: 'worker_password' }
      f.input :password_confirmation, input_html: { id: 'worker_password_confirmation' }
      span do
        icon('eye', class: 'toggle-password', data: { input: 'worker_password' })
      end
      span do
        icon('eye', class: 'toggle-password', data: { input: 'worker_password_confirmation' })
      end
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :phone
      row :encrypted_password do |worker|
        span id: 'encrypted_password', style: 'font-family: monospace' do
          worker.encrypted_password
        end
        span do
          icon('eye', class: 'toggle-password', data: { input: 'encrypted_password' })
        end
      end
      row :created_at
      row :updated_at
      row :services do |worker|
        worker.services.map(&:name).join(', ')
      end
    end
    active_admin_comments
  end

  filter :name
  filter :email
  filter :phone
  filter :services
  filter :created_at
  filter :updated_at
end
