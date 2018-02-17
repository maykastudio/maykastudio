class Ability
  include CanCan::Ability

  def initialize(user, namespace = nil)
    user ||= User.new

    case namespace
    when 'manage'
      if user.administrator?
        can :manage, :all
      end
    end

  end
end