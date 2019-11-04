class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      Scope
    end
  end

  def index?
    true
  end

  def create?
    @user.try(:journalist?)
  end

  def show?
    @user.try(:subscriber?) || @user.try(:journalist?)
  end

  def update?
    @user.try(:journalist?) && ( @user.try(:id) == self.record.journalist_id )
  end
end