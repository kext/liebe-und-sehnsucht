module ApplicationHelper
  def paginate page, num_pages
    p = []
    p << :prev if page > 1
    if page > 6 && page + 6 < num_pages
      p += [1, 2, 3]
      p << :skip
      p += [page - 2, page - 1, page, page + 1, page + 2]
      p << :skip
      p += [num_pages - 2, num_pages - 1, num_pages]
    elsif page > 6
      p += [1, 2, 3]
      p << :skip
      (page - 2..num_pages).each{|i| p << i}
    elsif page + 6 < num_pages
      (1..page + 2).each{|i| p << i}
      p << :skip
      p += [num_pages - 2, num_pages - 1, num_pages]
    else
      p += (1..num_pages).to_a
    end
    p << :next if page < num_pages
    p
  end
end

class Time
  def relative
    today = Time.now.localtime(utc_offset)
    yesterday = today - 1.day
    if year == today.year && month == today.month && day == today.day
      "#{I18n.t(:today)}, #{strftime '%H:%M'}"
    elsif year == yesterday.year && month == yesterday.month && day == yesterday.day
      "#{I18n.t(:yesterday)}, #{strftime '%H:%M'}"
    elsif self > today - 5.days
      "#{I18n.t(:weekdays)[wday]}, #{strftime '%H:%M'}"
    else
      "#{day}. #{I18n.t(:months)[month - 1]} #{year}"
    end
  end
end
