class RentalPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # CORRIGIR para dar acesso para user que está alugando e car owner:
      scope.where(user: user)
    end
  end

  # qualquer user pode criar new car rental
  # como bloquear se o user for car owner? só na view?
  def create?
    true
  end

  # customer can view his own rental
  # car owner can view his car's rentals
  def show?
    record.user == user || record.car.user == user
  end

  # customer can cancel his own rental
  def destroy?
    record.user == user
  end
end
