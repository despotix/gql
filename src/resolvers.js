const Game = require('./models/game');

let gameModel = new Game();

module.exports = {
    Query: {
        getGame(root, {id}) {
            return gameModel.fetchOne({id});
        },
        allGames() {
            return gameModel.fetch();
        }
    },
    Mutation: {
        // returns an id of the game added
        createGame(root, {game}) {
            return gameModel.create({game});
        },
        updateGamePrice(root, {id, price}) {
            return gameModel.update({id}, {price});
        },
        // returns a number of rows that were deleted
        deleteGame(root, {id}) {
            return gameModel.remove({id});
        }
    }
};