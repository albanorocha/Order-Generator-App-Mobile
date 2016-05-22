class VisitorPolicy < Struct.new(:user, :dashboard)

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: @user)
      end
    end
  end

  def index?
    true
  end

end
