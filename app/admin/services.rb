ActiveAdmin.register Service do
  permit_params :name, :price, :commission, :worker_ids => []

  form do |f|
    f.inputs 'Service Details' do
      f.input :name
      f.input :price
      f.input :commission
      f.input :workers, as: :check_boxes, collection: Worker.all
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :price
      row :commission
      row :workers do |service|
        service.workers.map(&:name).join(', ')
      end
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :price
    column :commission
    column :workers do |service|
      service.workers.map(&:name).join(', ')
    end
    actions
  end
end
