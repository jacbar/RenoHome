# RenoHome

.NET 10 Blazor learning project, intended for hosting on **Azure App Service (Linux)**.

This repository is a clean scaffold: one Blazor Web App with Interactive Server rendering, a `/health` endpoint, and smoke tests.

## Stack

| Layer | Choice |
| --- | --- |
| Runtime | .NET 10 (LTS) |
| UI | Blazor Web App, Interactive Server |
| Tests | xUnit + `Microsoft.AspNetCore.Mvc.Testing` |
| Hosting target | Azure App Service Linux (`.NET 10`) |

## Prerequisites

- [.NET 10 SDK](https://dotnet.microsoft.com/download/dotnet/10.0) (see `global.json`)

## Run locally

```bash
dotnet restore
dotnet run --project src/RenoHome.Web
```

Then open the URL printed by Kestrel (typically `https://localhost:7xxx` or `http://localhost:5xxx`).

- Home: `/`
- Sample Counter: `/counter`
- Sample Weather: `/weather`
- Health: `GET /health`

## Test

```bash
dotnet test
```

## Project layout

```
RenoHome.sln
src/
  RenoHome.Web/                 # Blazor Web App (net10.0)
    Components/                 # Razor components, layout, pages
    wwwroot/                    # Static assets
    Program.cs                  # App startup + /health
tests/
  RenoHome.Web.Tests/           # Smoke tests for home + health
```

## Azure App Service (Linux)

Deploy the publish output of `RenoHome.Web` to an App Service running **.NET 10**.

Interactive Server needs **WebSockets** enabled on the web app.

Example (replace names/region as needed):

```bash
az group create --name rg-renohome --location westeurope

az appservice plan create \
  --name plan-renohome \
  --resource-group rg-renohome \
  --sku B1 \
  --is-linux

az webapp create \
  --name <unique-app-name> \
  --resource-group rg-renohome \
  --plan plan-renohome \
  --runtime "DOTNETCORE:10.0"

az webapp config set \
  --name <unique-app-name> \
  --resource-group rg-renohome \
  --web-sockets-enabled true

dotnet publish src/RenoHome.Web -c Release -o ./publish
# Deploy ./publish (ZIP deploy, GitHub Actions, Visual Studio Publish, etc.)
```

## Next learning steps

- Replace sample pages with RenoHome domain UI
- Add data access (EF Core + Azure SQL / Cosmos)
- Wire CI deploy from GitHub Actions to App Service
- Add authentication when you need signed-in users
