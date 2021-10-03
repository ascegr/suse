# Notes

## Required software to run

- Erlang
- Elixir
- Nodejs
- PostgreSQL

## Installation

### asdf

You can use [asdf](http://asdf-vm.com/) to install the required software.
Going into the project directory, run `asdf install` and the download of the software should begin. This method requires you to have an existing installation of PostgreSQL.

## Setup of the project

To setup the project, after you have installed the required software, run the following commands:

- `cd suse`
- `mix local.rebar`
- `mix archive.install hex phx_new 1.5.13`
- `mix deps.get`
- `cd assets && npm ci && cd ..`
- `mix ecto.setup`

## Run the server

Now, you can run the server with the `mix phx.server` command in the root directory of the app, and visit `http://localhost:4000` to check the application. The app has two variants, one with standard Phoenix templates, and one using React, you can see the links in the navbar.

## Test

To run the whole test suit, you can run the `mix test` command in the root directory.
