class DiffsController < ApplicationController
  def show
    @page = Page.find_by_slug(params[:page_id])
    @old_version = @page.versions.find_by_version(params[:id])
    @new_version = params[:version_id] ? @page.versions.find_by_version(params[:version_id]) : @page
    
    raise RecordNotFound if @page.nil? or @old_version.nil? or @new_version.nil?
    
    respond_to do |wants|
      wants.html
    end
  end
end
