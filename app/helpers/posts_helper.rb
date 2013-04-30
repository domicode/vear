module PostsHelper
  def color_kind(resource)
    if resource.kind == 1
      content_tag(:div, '', :id => "#{resource.id}", :class => 'post offer') do
        content_tag(:p, resource.message)
      end
    else
      content_tag(:div, '', :id => "#{resource.id}", :class => 'post demand') do
        content_tag(:p, resource.message)
      end
    end
  end
end
