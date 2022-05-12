# This migration comes from bx_block_comments (originally 20200929113033)
class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :account, foreign_key: true
      t.references :post, foreign_key: true
      t.text :comment
      t.timestamps
    end
  end
end
