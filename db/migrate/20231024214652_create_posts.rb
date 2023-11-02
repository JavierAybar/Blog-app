class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.integer :author_id, null: false
      t.string :title
      t.text :text
      t.integer :comments_counter
      t.integer :likes_counter

      t.timestamps
    end
    add_foreign_key :posts, :users, column: :author_id
  end
end
Post.create(title: 'post3', author_id: 1, text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas a libero at ex fermentum auctor. Donec ac semper justo. Sed tincidunt quam vel massa consectetur.', comments_counter: 0, likes_counter: 0)