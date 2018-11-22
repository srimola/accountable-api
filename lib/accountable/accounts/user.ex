defmodule Accountable.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]
  alias Accountable.Accounts.User


  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :permissions, :map
    field :is_active, :boolean, default: false

    # Virtual field for password
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs \\ :empty) do
    user
    |> cast(attrs, [:email, :password, :is_active, :permissions])
    |> validate_required([:email])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> unique_constraint(:email)

    # Hash passwords before saving to database
    |> put_hashed_password()
    |> put_change(:password, nil)
  end

  def register_changeset(%User{} = user, attrs \\ :empty) do
    user
    |> cast(attrs, [:email, :password, :is_active, :permissions])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> unique_constraint(:email)

    # Hash passwords before saving to database
    |> put_hashed_password()
    |> put_change(:password, nil)
  end

  def put_hashed_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, hashpwsalt(password))
        _ -> changeset
    end
  end
end
