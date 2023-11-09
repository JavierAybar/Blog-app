class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new

    # Define User abilities
    if user.is? :admin
      can :manage, :all
    else
      can :create, Post
      can :create, Comment
      can :read, :all
      can :destroy, Post, author_id: user.id
      can :destroy, Comment, user_id: user.id
    end
  end
end
