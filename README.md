// todo trigger game deletion

# Get All Games


<<query>>
mutation addGame($game: GameInput!) {
  addGame (game: $game) {
    title,
    publisher {
      name
    }
  }
}

<<data>>
{
  "game": {
        "title" : "A Way Out",
        "price" : 1000,
        "publisher" : 4,
        "tags" : [
            "Action-adventure",
            "EA DICE"
        ],
        "release" : "2018-03-23",
      "publisher": {
         "name": "Electronic Arts"
       }
  }
}

