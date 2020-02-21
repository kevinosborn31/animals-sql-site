require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require 'pry'

# DRY up our routes by creating a reusable DB query function
def db_query( sql )

	db = SQLite3::Database.new 'database.db'
	db.results_as_hash = true 
    #Debugging output in the terminal
    puts '=========='
    puts sql
    puts '=========='
	results = db.execute sql 
	db.close 

	results # Return the result of the query
end

# home page
get '/' do
    erb :home
end
# create routes

# 1. Show the blank form to be filled out 
get '/animals/new' do 
	erb :new
end

# 2. Form submits to here with a post request

post '/animals' do
	sql = "INSERT INTO animals (name, species, description, roundness, alive, age, image_url)
		VALUES (
			'#{ params[:name] }',
			'#{ params[:species] }',
			'#{ params[:description] }',
			 #{ params[:roundness] },
			 #{ params[:alive] },
			 #{ params[:age] },
			'#{ params[:image_url] }'
		);"

		# execute the query and ignore the result
		db_query sql

		# redirect to the index of animals - from there we can see the animal was 
		# added; and it also prevents a reload from re-inserting this animal to the DB
		redirect '/animals'


end

# read routes
# 1. Index of all animals in table
get '/animals' do

	@results = db_query "SELECT * FROM animals;"
    erb :index
end

# 2. Details page for a single animal (row)
get '/animals/:id' do 

	@animal = db_query "SELECT * FROM animals WHERE id = #{ params[:id] };"

    # We know there's only one row when we query by ID,	
    @animal = @animal.first

	erb :show

end

# update routes

get '/animals/:id/edit' do 

	#We need to get the details of the animal we're editing so we can pre-fill the form with those
	@animal = db_query "SELECT * FROM animals WHERE id = #{params[:id]};"
	@animal = @animal.first 

	erb :edit
end

# 2. Form submit, update the row
post '/animals/:id' do
	sql = "UPDATE animals SET 
	name = '#{params[:name]}'
	species = '#{params[:species]}
	description = '#{params[:description]}
	roundness = '#{params[:roundness]}
	alive = '#{params[:alive]}
	age = '#{params[:age]}
	image_url = '#{params[:image)url]}
	WHERE id = '#{params[:id]};"

	# execute the query and ignore the result
	db_query sql
	redirect '/animals' 
end
# delete routes