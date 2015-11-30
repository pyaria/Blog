module PostsHelper
  def generate_stars(number_of_stars)
    if !number_of_stars
      number_of_stars = 0
    end
    content_tag :span do
      (star_html * number_of_stars).html_safe
    end
  end

  def star_html
    content_tag(:span, nil, class: "glyphicon glyphicon-star", html: {"aria-hidden" => "true"})
  end
end
