class CalculatePointsService
  def initialize(trip)
    @trip = trip
  end

  def add_point_by_trip(type)
    User.transaction do
      @trip.users.each do |user|
        add_point_by_user(user, type)
      end
    end
  end

  private
  def add_point_by_user(user, type)
    case type
      when 'view'
        user.increment!(:point)
      when 'clone'
        user.increment!(:point, by = 5)
      when 'published'
        user.increment!(:point, by = 10)
      else
        return
    end
  end
end

