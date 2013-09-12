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
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
    # CSS class needs to be defined for arrowup and arrowdown.
    # Check out: http://railscasts.com/episodes/228-sortable-table-columns
    # The following should work with Twitter Bootstrap
    # link_to "#{title} <i class='#{direction == "desc" ? "icon-chevron-down" : "icon-chevron-up"}'></i>".html_safe, {:sort => column, :direction => direction}, {:class => css_class}
  end
  
  def distance_of_time_in_words_to_now_with_ago(from_time, include_seconds_or_options = {}) 
    ago = t(:ago, scope: 'datetime.distance_in_words')
    locale = I18n.locale
    locales = [:ja, :ko]
    default_s = "#{distance_of_time_in_words_to_now(from_time, include_seconds_or_options)} #{ago}"
    if locales.include?(locale)
      if(from_time..from_time+60).cover?(Time.zone.now)
        distance_of_time_in_words_to_now(from_time, include_seconds_or_options)
      else
        if locale == :ja
          "#{distance_of_time_in_words_to_now(from_time, include_seconds_or_options)}#{ago}"
        else
          default_s
        end
      end
    else
      default_s
    end
  end
end