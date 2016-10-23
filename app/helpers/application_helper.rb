module ApplicationHelper

  def cookie_has_data?(key)
    begin
      !JSON.parse(cookies[key]).empty?
    rescue TypeError => e
      false
    end
  end

  def is_owner_or_participating?
    cookie_has_data?(:owner) || cookie_has_data?(:participant)
  end

  def owner_pages_from_cookies
    begin
      RewardPage.where('identifier in (?)', JSON.parse(cookies[:owner]))
    rescue TypeError => e
      []
    end
  end

  def participant_pages_from_cookies
    begin
      Participant.where('identifier in (?)', JSON.parse(cookies[:participant]))
    rescue TypeError => e
      []
    end
  end

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
