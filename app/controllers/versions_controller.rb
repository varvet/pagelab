class VersionsController < ApplicationController
  def show
    @current_page = Page.find_by_slug(params[:page_id])
    @page = @current_page.versions.find_by_version params[:id]
    
    raise RecordNotFound if @page.nil?
    
    respond_to do |wants|
      wants.html
    end
  end
end
