class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, Post do |p|
      user == p.user
    end

    can :manage, Comment do |c|
      user == c.user
    end

    can :destroy, Comment do |c|
      user == c.post.user
    end
  end
end
