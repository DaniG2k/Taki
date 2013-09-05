module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << t('website.name')).join(' - ')
      end
    end
  end
  
  def table_sort(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
    # CSS class needs to be defined for arrowup and arrowdown.
    # Check out: http://railscasts.com/episodes/228-sortable-table-columns
    # The following should work with Twitter Bootstrap
    # link_to "#{title} <i class='#{direction == "desc" ? "icon-chevron-down" : "icon-chevron-up"}'></i>".html_safe, {:sort => column, :direction => direction}, {:class => css_class}
  end
end
