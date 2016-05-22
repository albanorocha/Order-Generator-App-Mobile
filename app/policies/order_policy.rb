class OrderPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user).where(enable: true)
      end
    end
  end


  def index?
    user.admin?
  end

  def new?
    user.admin?
  end

  def create?
    user.admin?
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

  def approve?
    user.admin? or (user == record.user)
  end



end
