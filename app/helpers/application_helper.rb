module ApplicationHelper
  def page_title
    title = '生つべ'
    title = @page_title + ' | ' + title if @page_title
    title
  end
end
