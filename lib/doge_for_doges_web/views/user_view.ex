defmodule DogeForDogesWeb.UserView do
  use DogeForDogesWeb, :view
  alias DogeForDogesWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      address: user.address,
      coordinates: user.coordinates,
      signature: user.signature
    }
  end
end
