class PagesController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  
  def show
    @page = Page.find_or_build_by_slug params[:id]
    
    respond_to do |wants|
      wants.html do
        render :action => 'new' if @page.new_record?
      end
    end
  end
  
  def new
    @page = Page.new
    
    respond_to do |wants|
      wants.html
    end
  end
  
  def create
    @page = current_user.pages.build params[:page]
    
    if @page.save
      respond_to do |wants|
        wants.html { redirect_to @page }
      end
    else
      respond_to do |wants|
        wants.html { render :action => 'new' }
      end
    end
  end
  
  def edit
    @page = Page.find_by_slug params[:id]
    
    respond_to do |wants|
      wants.html
    end
  end
  
  def update
    @page = Page.find_by_slug params[:id]
    @page.attributes =  params[:page]
    @page.user = current_user
    
    if @page.save
      respond_to do |wants|
        wants.html { redirect_to @page }
      end
    else
      respond_to do |wants|
        wants.html { render :action => 'edit' }
      end
    end
  end
end
