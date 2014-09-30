class CreateUsers < ActiveRecord::Migration

  def change
    create_table :users do |t|
      t.string :username

      # The plain-text password is no longer stored.
      #
      # Even though we never directly interact with the password_digest column,
      # we have to add it to our database because ActiveModel::SecurePassword
      # requires it to function properly.

      t.string :password_digest

      t.timestamps
    end
  end

end
