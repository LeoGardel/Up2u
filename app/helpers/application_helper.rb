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
end
