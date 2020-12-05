class RentalPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # para ser uma view só do owner fazer:
      scope.where(user: user)
    end
  end

  # qualquer user pode criar new car rental
  def create?
    true
  end

  # customer can view his own rental
  # car owner can view his car's rental
  def show?
    record.user == user || record.car.user == user
  end

  # customer can edit his own rental
  def update?
    record.user == user
  end

  # customer can cancel his own rental
  def destroy?
    record.user == user
  end
end
