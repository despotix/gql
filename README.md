#[ Live demo](http://gql.despotix.best " Live demo")

# API description

## Get All Games
####Request
```javascript
{
  allGames {
    id
    title
    price
    release
    discount
    publisher{
      name
    }
  }
}
```
####Response
```javascript
{
  "data": {
    "allGames": [
      {
        "id": 48,
        "title": "Battlefield V",
        "price": 1000,
        "release": "2018-10-19T00:00:00.000Z",
        "discount": 200,
        "tags": [
          "First-person",
          "shooter"
        ],
        "publisher": {
          "name": "Electronic Arts"
        }
      }
    ]
  }
}
```

## Get Single Game
####Request
```javascript
{
  getGame(id:1) {
    title,
    publisher {
      name
    }
  }
}
```
####Response
```javascript
{
  "data": {
    "getGame": {
      "title": "BioShock: The Collection",
      "publisher": {
        "name": "Electronic Arts"
      }
    }
  }
}
```

## Create Game
####Request
```javascript
mutation addGame($game: GameInput!) {
  createGame (game: $game)
}
```
####Request Data
```javascript
{
  "game": {
        "title" : "A Way Out",
        "price" : 1000,
        "tags" : [
            "Action-adventure",
            "EA DICE"
        ],
        "release" : "2019-03-23",
      "publisher": {
         "name": "Electronic Arts"
       }
  }
}
```
####Response
Returns an id of created game
```javascript
{
  "data": {
    "createGame": 46
  }
}
```

## Update Game Price
####Request
```javascript
mutation updateGamePrice($id: Int!, $price: Int!) {
  updateGamePrice(id: $id, price: $price) {
    id
    price
  }
}
```
####Request Data
```javascript
{
  "id": 1,
  "price": 950
}
```

####Response
```javascript
{
  "data": {
    "updateGamePrice": {
      "id": 1,
      "price": 950
    }
  }
}
```

## Delete Game
####Request
```javascript
mutation deleteGame($id: Int!) {
  deleteGame (id: $id)
}
```
####Request Data
```javascript
{
  "id": 50
}
```
####Response
Returns a number of deleted games
```javascript
{
  "data": {
    "deleteGame": 1
  }
}
```