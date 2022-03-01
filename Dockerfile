FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env

WORKDIR /app

COPY ./source .
RUN dotnet restore
RUN dotnet publish PocConfigurationManagement.csproj -c Release -o out 

FROM mcr.microsoft.com/dotnet/aspnet:6.0
ARG project

WORKDIR /app
 
COPY --from=build-env /app/out .
COPY ./source/MyConfig.json .
ENTRYPOINT ["dotnet", "PocConfigurationManagement.dll"]
