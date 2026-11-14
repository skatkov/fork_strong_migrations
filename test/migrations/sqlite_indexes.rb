class AddIndexPopulatedNewTable < TestMigration
  def change
    create_table :new_users do |t|
      t.string :name
    end
    User.connection.execute("INSERT INTO new_users (name) VALUES ('Existing')")
    add_index :new_users, :name
  end
end

class CreateTableInlineIndex < TestMigration
  def change
    create_table :new_users do |t|
      t.string :name
      t.index :name, unique: true
    end
  end
end

class CreateJoinTableInlineIndex < TestMigration
  def change
    create_join_table :cities, :users do |t|
      t.index :user_id
    end
  end
end

class CreateTableAsInlineIndex < TestMigration
  def change
    create_table :new_users, as: "SELECT name FROM users" do |t|
      t.index :name
    end
  end
end

class CreateTableIfNotExistsInlineIndex < TestMigration
  def change
    create_table :users, if_not_exists: true do |t|
      t.string :name
      t.index :name
    end
  end
end

class CreateJoinTableAsInlineIndex < TestMigration
  def change
    create_join_table :cities, :users, as: "SELECT id AS user_id, 1 AS city_id FROM users" do |t|
      t.index :user_id
    end
  end
end

class CreateJoinTableIfNotExistsInlineIndex < TestMigration
  def change
    create_join_table :cities, :users, table_name: :users, if_not_exists: true do |t|
      t.index :name
    end
  end
end
