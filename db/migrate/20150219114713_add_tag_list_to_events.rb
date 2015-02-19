class AddTagListToEvents < ActiveRecord::Migration
  def change
    add_column :events, :tag_list, :string
  end
end
