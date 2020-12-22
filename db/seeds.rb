Admin.create(email:"admin@admin.com", password:"123456")

puts "### Administratrador has been created ###"
# publishing_company = PublishingCompany.create(name: Faker::Book.publisher)
# author = Author.create(name: Faker::Book.author)
# genre = Genre.create(name: Faker::Book.genre)
# Book.create!(title: Faker::Book.title, genre_id: genre.id, description: "A great Book", publishing_company_id: publishing_company.id, author_id: author.id)

while Genre.count < 10 do
  genre_name = Faker::Book.genre

  Genre.create(name: genre_name)
end

puts "### Genres were created ###"

while Author.count < 10 do
  author_name = Faker::Book.author

  Author.create(name: author_name, avatar: Faker::Avatar.image)
end

puts "### Authors were created ###"

while PublishingCompany.count < 10 do
  publishing_company_name = Faker::Book.publisher

  PublishingCompany.create(name: publishing_company_name)
end

puts "### Publishing Companies were created ###"

while Book.count < 50 do
  Book.create(
    title: Faker::Book.title,
    description: Faker::Marketing.buzzwords,
    image: Faker::Avatar.image,
    author_id: Author.pluck(:id).sample,
    genre_id: Genre.pluck(:id).sample,
    publishing_company_id: PublishingCompany.pluck(:id).sample
  )
end

puts "### Books were created ###"