class CarPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      @scope.where(user_id: @user)
    end
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    @user == record.user
  end
end
