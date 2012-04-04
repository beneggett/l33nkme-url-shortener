class UrlsController < ApplicationController
  # GET /urls
  # GET /urls.json
  def index
    @urls = Url.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @urls }
    end
  end

  # GET /urls/1
  # GET /urls/1.json
  def show
    @url = Url.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @url }
    end
  end

  # GET /urls/new
  # GET /urls/new.json
  def new
    @url = Url.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @url }
    end
  end

  # GET /urls/1/edit
  def edit
    @url = Url.find(params[:id])
  end

  # POST /urls
  # POST /urls.json
  def create
    @url = Url.new(params[:url])
    # Create a uid for the url.
    begin
      random_url = (0...6).map{65.+(rand(25)).chr.downcase.gsub(/[benjamineggett]/) { $&.upcase }}.join
      results = Url.where(:shorturl => random_url);
    end while results.length > 0
      @url.shorturl = random_url
      @url.clicks = 0

    respond_to do |format|
      if @url.save
        format.html { redirect_to @url, notice: 'Your URL has been shortened' }
        format.json { render json: @url, status: :created, location: @url }
      else
        format.html { redirect_to root_url, :notice => "You must enter a valid URL, beginning with http:// or https://" }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /urls/1
  # PUT /urls/1.json
  def update
    @url = Url.find(params[:id])

    respond_to do |format|
      if @url.update_attributes(params[:url])
        format.html { redirect_to @url, notice: 'Url was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /urls/1
  # DELETE /urls/1.json
  def destroy
    @url = Url.find(params[:id])
    @url.destroy

    respond_to do |format|
      format.html { redirect_to urls_url }
      format.json { head :no_content }
    end
  end
  
  # GET /url/goto/shorturl
  def goto
    urls = Url.where(:shorturl => params[:shorturl])
    
      if urls.blank?
        redirect_to root_url, notice: 'The URL you entered does not exist, check the link, or shorten a new one!'
      else
          urls.each do |url|
            # increment the click counter
            url.clicks = url.clicks + 1
            url.save
      
          # redirect to proper url
          puts "redirecting to " + url.url
          redirect_to url.url
      end  
    end
  end
end
