FROM mcr.microsoft.com/dotnet/sdk:6.0 AS restore
WORKDIR /app

COPY source/*.sln .
COPY source/PocConfigurationManagement/*.csproj ./PocConfigurationManagement/
COPY source/PocConfigurationManagement.Tests/*.csproj ./PocConfigurationManagement.Tests/
RUN dotnet restore

FROM restore AS build
COPY source/. .
RUN dotnet build -c Release --no-restore

FROM build AS test
RUN dotnet test -c Release --no-build --logger trx

FROM scratch as export-test-results
COPY --from=test app/PocConfigurationManagement.Tests/TestResults/*.trx .

FROM build AS publish
RUN dotnet publish -c Release --no-build -o out

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=publish /app/out .
ENTRYPOINT ["dotnet", "PocConfigurationManagement.dll"]
