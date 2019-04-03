defmodule Mailbase.AccountsData do
  @moduledoc """
  The AccountsData context.
  """

  import Ecto.Query, warn: false
  alias Mailbase.Repo

  alias Mailbase.AccountsData.UserData

  @doc """
  Returns the list of users_data.

  ## Examples

      iex> list_users_data()
      [%UserData{}, ...]

  """
  def list_users_data do
    Repo.all(UserData)
  end

  @doc """
  Gets a single user_data.

  Raises `Ecto.NoResultsError` if the User data does not exist.

  ## Examples

      iex> get_user_data!(123)
      %UserData{}

      iex> get_user_data!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_data!(id), do: Repo.get_by(UserData, user_id: id)

  @doc """
  Creates a user_data.

  ## Examples

      iex> create_user_data(%{field: value})
      {:ok, %UserData{}}

      iex> create_user_data(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_data(attrs \\ %{}) do
    IO.puts "------------------"
    %UserData{}
    |> IO.inspect
    |> UserData.changeset(attrs)
    |> IO.inspect
    |> Repo.insert()
    IO.puts "------------------"
  end

  @doc """
  Updates a user_data.

  ## Examples

      iex> update_user_data(user_data, %{field: new_value})
      {:ok, %UserData{}}

      iex> update_user_data(user_data, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_data(%UserData{} = user_data, attrs) do
    user_data
    |> UserData.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a UserData.

  ## Examples

      iex> delete_user_data(user_data)
      {:ok, %UserData{}}

      iex> delete_user_data(user_data)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_data(%UserData{} = user_data) do
    Repo.delete(user_data)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_data changes.

  ## Examples

      iex> change_user_data(user_data)
      %Ecto.Changeset{source: %UserData{}}

  """
  def change_user_data(%UserData{} = user_data) do
    UserData.changeset(user_data, %{})
  end
end
