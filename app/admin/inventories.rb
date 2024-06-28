ActiveAdmin.register Inventory do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #

  permit_params :name, :price, :bought, :supplied, :in_stock, :supplier_name

  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :price, :bought, :supplied, :in_stock, :supplier_name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # form do |f|
  #   f.inputs 'Inventory Details' do
  #     f.input :name
  #     f.input :price
  #     f.input :bought
  #     f.input :bought
  #     f.input :supplied
  #     f.input :in_stock
  #     f.input :supplier_name
  #     f.input :created_at
  #     f.input :updated_at      
  #     f.input :workers, as: :check_boxes, collection: Worker.all
  #   end
  #   f.actions
  # end

  # show do
  #   attributes_table do
  #     row :name
  #     row :price
  #     row :commission
  #     row :workers do |service|
  #       service.workers.map(&:name).join(', ')
  #     end
  #   end
  # end

  # index do
  #   selectable_column
  #   id_column
  #   column :name
  #   column :price
  #   column :commission
  #   column :workers do |service|
  #     service.workers.map(&:name).join(', ')
  #   end
  #   actions
  # end
end
