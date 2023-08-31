class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :read, :all
      can :destroy, Post, author_id: user.id
      can :destroy, Comment, author_id: user.id
      can :new, Post, author_id: user.id
      can :create, Post, author_id: user.id
      can :create, Comment, author_id: user.id
      can :new, Comment, author_id: user.id
    end
  end
end
