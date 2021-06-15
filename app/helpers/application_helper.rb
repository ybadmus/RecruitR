module ApplicationHelper
  def navbar
    if logged_in?
      raw("<nav class='navbar navbar-expand-lg navbar-light bg-light'><div class='container-fluid'>
        <a class='navbar-brand' href='#'>RecruitR</a>
        <button class='navbar-toggler' type='button' data-bs-toggle='collapse' data-bs-target='#navbarNav' aria-controls='navbarNav' aria-expanded='false' aria-label='Toggle navigation'><span class='navbar-toggler-icon'></span></button>
        <div class='collapse navbar-collapse justify-content-end' id='navbarNav'>
          <ul class='navbar-nav'>
            <li class='nav-item'>
              #{link_to current_user.username, edit_user_path(current_user.id), class: 'nav-link'}
            </li>
            <li class='nav-item'>
              #{link_to 'Logout', '/logout', method: 'post', class: 'nav-link'}
            </li>
          </ul>
        </div>
        </div>
        </nav>")
    else 
        raw("<nav class='navbar navbar-expand-lg navbar-light bg-light'><div class='container-fluid'>
          <a class='navbar-brand' href='#'>RecruitR</a>
          <button class='navbar-toggler' type='button' data-bs-toggle='collapse' data-bs-target='#navbarNav' aria-controls='navbarNav' aria-expanded='false' aria-label='Toggle navigation'><span class='navbar-toggler-icon'></span></button>
          <div class='collapse navbar-collapse' id='navbarNav'></div>
          </div>
          </nav>")
    end
  end

end

