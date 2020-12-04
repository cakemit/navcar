class CarPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      @scope.all
      # para ser uma view só do owner fazer:
      # scope.where(user: user)
    end
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
