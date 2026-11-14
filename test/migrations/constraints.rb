class RemoveForeignKey < TestMigration
  def change
    remove_foreign_key :users, :orders
  end
end

class RemoveCheckConstraint < TestMigration
  def change
    remove_check_constraint :users, "credit_score > 0"
  end
end

class CreateTableInlineConstraints < TestMigration
  def change
    create_table :new_users do |t|
      t.references :order, foreign_key: true, index: false
      t.integer :score
      t.check_constraint "score > 0", name: "score_check"
    end
  end
end
