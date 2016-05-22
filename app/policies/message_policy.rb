class MessagePolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end


  def index?
    true
  end

  def new?
    user.admin? or (user == record.user)
  end

  def create?
    user.admin? or (user == record.user)
  end

  def show?
    user.admin? or (user == record.user)
  end

  def destroy?
    user.admin?
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end
end
