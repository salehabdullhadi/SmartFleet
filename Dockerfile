# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy solution and restore as distinct layers
COPY SmartFleet/SmartFleet.sln SmartFleet/
COPY SmartFleet/*.csproj SmartFleet/
COPY SmartFleet.Tests/*.csproj SmartFleet.Tests/
RUN dotnet restore SmartFleet/SmartFleet.sln

# Copy everything else and build
COPY SmartFleet/. SmartFleet/
COPY SmartFleet.Tests/. SmartFleet.Tests/
WORKDIR /app/SmartFleet
RUN dotnet publish -c Release -o out

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/SmartFleet/out ./
EXPOSE 80
ENTRYPOINT ["dotnet", "SmartFleet.dll"] 