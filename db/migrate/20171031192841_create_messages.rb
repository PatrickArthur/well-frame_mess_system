class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :message_text
      t.references :conversation, index: true
      t.boolean :read, default: false
      t.timestamps
    end
  end
end
