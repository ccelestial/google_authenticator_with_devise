class AddTwoFactorColumnInUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :two_factor_authenticated, :boolean, default: false
  end
end
