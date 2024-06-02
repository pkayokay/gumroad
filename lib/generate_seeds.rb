class GenerateSeeds
  def self.call(count: 1)
    count.times do
      user = User.create!(
        name: Faker::Name.name,
        password: "password",
        email: Faker::Internet.email
      )

      rand(1..7).times do
        product = user.products.create!(
          name: Faker::Book.title,
          description: Faker::Quote.famous_last_words,
          price: rand(1..100),
          is_published: true
        )

        ProductCategory.create!(product: product, category: Category.random)
      end

    rescue
      next
    end
  end
end