class AddEarningTypeToWorkers < ActiveRecord::Migration[7.1]
  def change
    add_column :workers, :earning_type, :string, default: 'not-earning'

    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE workers
          ADD CONSTRAINT earning_type_check
          CHECK (earning_type IN ('Salary', 'Commission', 'not-earning'))
        SQL
      end

      dir.down do
        execute <<-SQL
          ALTER TABLE workers
          DROP CONSTRAINT earning_type_check
        SQL
      end
    end
  end
end
