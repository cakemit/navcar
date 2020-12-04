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
    # record.user == user
    false
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
