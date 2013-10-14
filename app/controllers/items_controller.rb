class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all 
    @item = Item.new
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    
    project_url = params[:project_url]
    username = project_url[/\:(.*?)\//, 1]
    reponame = project_url[/\/(.*?).git/, 1]

    repo_info = Octokit.repo("#{username}/#{reponame}")
    parsed_params = { reponame: reponame, user: username, url: project_url, last_push_date: repo_info.updated_at, watchers: repo_info.watchers  }

  
    manifest_data = Octokit.contents("#{username}/#{reponame}", :path => 'sassmanifest.json', :accept => "application/vnd.github-blob.raw")
    manifest_hash = JSON.parse(manifest_data)

    manifest_hash.merge!(parsed_params)

    @item = Item.new(manifest_hash);

    respond_to do |format|
      if @item.save
        format.html { redirect_to items_path, notice: 'Item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @item }
      else
        format.html { render action: 'new' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :version)
    end
end
