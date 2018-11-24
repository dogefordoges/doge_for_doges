defmodule DogeForDogesWeb.PageController do
  use DogeForDogesWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

end
