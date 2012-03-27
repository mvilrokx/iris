class CreateWebServices < ActiveRecord::Migration
  def change
    create_table :web_services do |t|
      t.string :name
      t.string :url
      t.string :version

      t.timestamps
    end
  end
end
