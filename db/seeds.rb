# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

puts "Cleaning database"
Cocktail.destroy_all
Ingredient.destroy_all
Dose.destroy_all

puts ""
puts "Starting seeding process..."

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_url = URI.open(url).read
ingredients = JSON.parse(ingredients_url)
array_of_hashes = ingredients['drinks']

array_of_hashes.each do |hash|
  Ingredient.create(name: hash['strIngredient1'])
end

COCKTAILS = ["Long Island Iced Tea", "Tom Collins", "Old Fashioned", "The Snowball", "Red Velvet Shortcake", "Margarita", "Wine Spritzer", "Anita Collins", "Strawberry Martini"]
DOSES = ["1 part", "2 parts", "3 parts", "A handful", "Around the glass rim", "A sprinkle"]
photos = ["https://images.unsplash.com/photo-1546171753-97d7676e4602?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", "https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", "https://images.unsplash.com/photo-1497534446932-c925b458314e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", "https://images.unsplash.com/photo-1520880205996-43e8ed079873?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", "https://images.unsplash.com/photo-1544145945-f90425340c7e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", "https://images.unsplash.com/photo-1517620517090-ab7f8eacbfd8?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60", "https://images.unsplash.com/photo-1542847890-8c4210389b23?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", "https://images.unsplash.com/photo-1438522014717-d7ce32b9bab9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", "https://images.unsplash.com/photo-1536935558068-364dcd7a75b0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", "https://images.unsplash.com/photo-1470338745628-171cf53de3a8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjF9&auto=format&fit=crop&w=668&q=80", "https://images.unsplash.com/photo-1470337458703-46ad1756a187?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60", "https://images.unsplash.com/photo-1536935338788-846bb9981813?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60", "https://images.unsplash.com/photo-1486947799489-3fabdd7d32a6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", "https://images.unsplash.com/photo-1482349212652-744925892164?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60", "https://images.unsplash.com/photo-1473115209096-e0375dd6b3b3?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"]


COCKTAILS.each do |name|
  photo_assigned = photos.sample
  cocktail = Cocktail.new(name: name, photo: photo_assigned)
  photos.delete(photo_assigned)
  puts cocktail.name
  cocktail.save!
  doses_arr = DOSES.dup
  rand((DOSES.length - 2)..DOSES.length).times do
    dose_assigned = doses_arr.sample
    doses_arr.delete(dose_assigned)
    puts dose_assigned
    dose = cocktail.doses.build(description: dose_assigned)
    dose.ingredient = Ingredient.all.sample
    dose.save!
  end
  puts "- created #{cocktail.name} with #{cocktail.doses.map { |dose| "#{dose.ingredient.name} - #{dose.description} " }.join(",") }"
end

puts "Finished seeding process! #{Cocktail.count} cocktails created"
