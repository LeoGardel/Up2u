module ApplicationHelper

  def title(page_title)
    content_for(:title) { " - " + page_title }
  end

  def stylesheet(*stylesheets)
    content_for(:stylesheet) { stylesheet_link_tag *stylesheets }
  end

  def javascript(*javascripts)
    content_for(:javascript) { javascript_include_tag *javascripts }
  end

  def bodyStyle(bodyStyle)
    content_for(:body_style) { bodyStyle }
  end

  def flash_class(level)
    case level
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
  	  when :error then "alert alert-error"
  	  when :alert then "alert alert-error"
      else "alert alert-error"
    end
  end

  def flash_devise_errors
    unless resource.errors.messages.empty?
      i = 0
      resource.errors.messages.each { |field,errors| 
        errors.each { |error| 
          flash.now[(:error.to_s + i.to_s).to_sym] = field.to_s.capitalize + " " + error
          i = i + 1
        }
      }
    end
  end

end
