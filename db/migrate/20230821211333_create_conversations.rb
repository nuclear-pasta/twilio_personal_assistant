class CreateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|
      t.string :call_sid, :string
      t.index :call_sid, unique: true

      t.timestamps
    end

    add_reference :messages, :conversation


  end
end
