require 'pry'
class FiguresController < ApplicationController

  #index index
  get '/' do 
    erb :'/application/root'
  end
  # index
  get '/figures' do 
    @figures = Figure.all 
    erb :'/figures/index'
  end

  # new / form
  get '/figures/new' do 
    erb :'/figures/new'
  end

  # create
  post '/figures' do 
    #binding.pry
    @figure = Figure.create(params[:figure])

    if !params[:landmark][:name].empty?
      @landmark = Landmark.create(params[:landmark])
      @figure.landmarks << @landmark
      @figure.save
    end

    if !@params[:title][:name].empty?
      @title = Title.create(params[:title])
      @figure.titles << @title
      @figure.save
    end

    redirect to "/figures/#{@figure.id}"
  end

 #  {"figure"=>
 #  {"name"=>"sdadfsdXXXXXX",
 #   "landmark_ids"=>["2", "3", "4"],
 #   "title_ids"=>["1", "2"]},
 # "landmark"=>{"name"=>"XXX", "year_completed"=>"1928"},
 # "title"=>{"name"=>"Bsass"}}

  # show
  get '/figures/:id' do 
    #binding.pry
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/show'
  end

  # edit view
  get '/figures/:id/edit' do 
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/edit'
  end

  patch '/figures/:id' do 
    #binding.pry
    @figure = Figure.find_by_id(params[:id])
    @figure.update(params[:figure])

    @landmark = Landmark.find_or_create_by(params[:landmark])
    @figure.landmarks << @landmark unless @figure.landmarks.include?(@landmark)

    @title = Title.find_or_create_by(params)
    @figure.titles << @title unless @figure.titles.include?(@title)

    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

    #  if !params[:landmark][:name].empty?
    #   @landmark = Landmark.create(params[:landmark])
    #   @figure.landmarks << @landmark
    #   @figure.save
    # end

    # if !@params[:title][:name].empty?
    #   @title = Title.create(params[:title])
    #   @figure.titles << @title
    #   @figure.save
    # end


end