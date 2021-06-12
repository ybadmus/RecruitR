module ApplicationHelper
  def navbar
    if logged_in?
      raw("<nav class='nav'>
          
          #{link_to 'Logout', '/logout', method: 'post', class: 'logout-btn'}
          </nav>")
    else
      raw("<nav class='nav'>
        #{link_to raw("<i class='fa fa-arrow-left' aria-hidden='true'></i>"), root_path, class: 'left-btn'}
        </nav>")
    end
  end
end
