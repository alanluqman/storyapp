class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    user || User.new
    if user.admin?
      can :manage, :all
    end

    can :edit, Post do |post|
      post.user_id == user.id
     end
      can :update , Post do |post|
        post.user_id == user.id
      end
      can :destroy , Post do |post|
        post.user_id == user.id
      end
      can :update , Comment do |comment|
        comment.user == user
      end
      can :destroy , Comment do |comment|
        comment.user == user
      end
      can :read, :all
      can :create , Post
      can :create , Comment


      # can :read, Post
      # return unless user.present?
      # can :manage, [Post, Comment]
      # return unless user.admin?
      
    #
  end
end
