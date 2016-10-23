module ApplicationHelper
  def editable?
  	visiting?('reward_pages#edit') or
  	visiting?('rewards#create') or
  	visiting?('tasks#create') or
  	visiting?('participants#create')
  end

  private

  def visiting?(string)
  	name, action = string.split('#')
  	controller_name.eql?(name) && action_name.eql?(action)
  end
end
