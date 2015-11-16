defmodule HighScore.Router do
  use HighScore.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HighScore do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", HighScore do
    pipe_through :api

    resources "/scores", ScoreController, only: [:index, :create]
  end
end
