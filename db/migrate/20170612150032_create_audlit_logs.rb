class CreateAudlitLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :audlit_logs do |t|
      t.references :user, foreign_key: true
      t.integer :status, default: 0
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
