class AddAudioToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :audio, :string
  end
end
