class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post, published: true
    can :read, Comment
    return unless user.present?

    can :manage, Post, user: user # only post owners can manage posts
    can :manage, Comment, user: user # only post owners can manage posts

    return unless user.admin?

    can :manage, :all
  end
end
