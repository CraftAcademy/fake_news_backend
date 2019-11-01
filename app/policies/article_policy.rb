class ArticlePolicy < ApplicationPolicy
  def show?
    @user.subscriber?
  end

  def edit?
    @user.journalist?
  end
end