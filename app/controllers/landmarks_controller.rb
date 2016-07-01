require 'pry'

class LandmarksController < ApplicationController

  #index
  get '/landmarks' do 
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  # new / form
  get '/landmarks/new' do 
    erb :'/landmarks/new'
  end

  # create
  post '/landmarks' do 
    @landmark = Landmark.new
    @landmark.name = params[:landmark][:name]
    @landmark.save    

     if !params[:figure][:name].empty?
      @figure = Figure.create(params[:figure])
      @landmark.figures << @figure
      @landmark.save
    end

    redirect to "/landmarks/#{@landmark.id}"
  end

  # show
  get '/landmarks/:id' do 
    #binding.pry
    @landmark = Landmark.find_by_id(params[:id])
    erb :'/landmarks/show'
  end

  # edit view
  get '/landmarks/:id/edit' do 
    @landmark = Landmark.find_by_id(params[:id])
    erb :'/landmarks/edit'
  end

  # edit view
  get '/landmarks/:id/edit' do 
    binding.pry
    @landmark = Landmark.find_by_id(params[:id])
    erb :'/landmarks/edit'
  end

  patch '/landmarks/:id' do 
    #binding.pry
    @landmark = Landmark.find_by_id(params[:id])
    @landmark.update(params[:landmark])

    # @figure = Figure.find_or_create_by(params[:figure])
    # @landmark.figures << @figure unless @landmark.figures.include?(@figure)

    # @landmark.save
    redirect to "/landmarks/#{@landmark.id}"
  end

end

# end