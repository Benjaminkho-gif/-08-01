class TagsController < ApplicationController
  before_action :set_tag, only: %i[ show destroy ]

  # GET /tags or /tags.json
  def index
    @tags = Tag.all
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # POST /tags or /tags.json
  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to tags_url, notice: "新しいタグを登録しました" }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1 or /tags/1.json
  def destroy
    @tag.destroy!

    respond_to do |format|
      format.html { redirect_to tags_path, status: :see_other, notice: "タグを削除しました" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tag_params
      params.require(:tag).permit(:tag_name)
    end
end
