class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :photo
      t.text :bio
      t.integer :post_counter

      t.timestamps
    end
  end
end
User.create(name: 'Jonh Doe', photo: 'https://plus.unsplash.com/premium_photo-1690481529194-6087914e096e?auto=format&fit=crop&q=80&w=1974&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', bio: 'Teacher from Mexico',post_counter: 0)