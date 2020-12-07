class CarPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
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

  def luxury?
    true
  end

  def sport?
    true
  end

  def off_road?
    true
  end

  def vintage?
    true
  end

end
