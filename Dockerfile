FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build ٍٍٍِِِ

WORKDIR /src

COPY .*csproj ./

RUN dotnet restore

COPY  . .

RUN dotnet publish -c release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS runtime

WORKDIR /app

COPY --from=build /app/publish .

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

USER appuser 

ENTRYPOINT ["dotnet", "order.API.dll"]