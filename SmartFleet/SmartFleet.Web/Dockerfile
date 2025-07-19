# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy project files first for better layer caching
COPY SmartFleet/SmartFleet.csproj SmartFleet/
COPY SmartFleet.Tests/SmartFleet.Tests.csproj SmartFleet.Tests/
COPY SmartFleet/SmartFleet.sln SmartFleet/

# Restore dependencies with progress
RUN dotnet restore SmartFleet/SmartFleet.sln --verbosity normal

# Copy the rest of the source code
COPY . .

# Build the solution
RUN dotnet build SmartFleet/SmartFleet.sln -c Release --no-restore

# Publish the main application
WORKDIR /app/SmartFleet
RUN dotnet publish -c Release -o out --no-restore

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copy the published application
COPY --from=build /app/SmartFleet/out ./

# Expose port 80
EXPOSE 80

# Set the entry point
ENTRYPOINT ["dotnet", "SmartFleet.dll"] 