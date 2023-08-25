class AddCallSidToMessage < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :call_sid, :string, index: true
  end
end
