module ApplicationHelper
  def navbar
    if logged_in?
      raw("<div style='display:flex;flex-direction:row'>
          #{link_to 'Positions', positions_path} | #{link_to 'Interviews', interviews_path} | #{link_to 'Candidates', candidates_path} | #{link_to 'Recruiters', recruiters_path } | #{link_to 'Skills', skills_path }
          <a style='flex-grow:1'></a>
          #{link_to current_user.username, edit_user_path(current_user.id)} | #{link_to 'Logout', '/logout', method: 'post', class: ''}
          </div>")
    end
  end
end
