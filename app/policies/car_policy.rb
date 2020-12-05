class CarPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      @scope.all
      # para ser uma view só do owner fazer:
      # scope.where(user: user)
    end
  end

  # qualquer um pode criar um novo carro
  def create?
    true
  end

  # qualquer um pode ver um carro
  def show?
    true
  end

  # owner pode editar seu próprio carro
  def update?
    record.user == user
  end

  # owner pode deletar seu próprio carro
  def destroy?
    record.user == user
  end
end
