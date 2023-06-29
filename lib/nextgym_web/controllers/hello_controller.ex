defmodule NextgymWeb.HelloController do
  use NextgymWeb, :controller

  def index(conn, _params) do
    case Mongo.command(:mongo, ping: 1) do
      {:ok, _res} -> send_resp(conn, 200, "Who is there")
      {:error, _err} -> send_resp(conn, 500, "Something went wrong")
    end
  end
end
