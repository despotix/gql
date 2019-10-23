const {makeExecutableSchema} = require('graphql-tools');
const resolvers = require('./resolvers');

const typeDefs = `
    scalar Date
    
    type Query {
        getGame(id: Int!): Game
        allGames: [Game]
    }
    type Mutation {
        createGame(game: GameInput!): Int
        updateGamePrice(id: Int!, price: Int!): Game
        deleteGame(id: Int!): Int
    }
    
    type Publisher {
        id : Int
        name : String!
        siret : Int
        phone : String
    }
    type Game {
        id: Int
        title: String
        price: Int
        discount: Int
        release: Date
        tags : [String]
        publisher : Publisher
    }
    
    input PublisherInput {
        name : String!
        siret : Int
        phone : String
    }
    input GameInput {
        title: String
        price: Int
        release: Date
        tags : [String]
        publisher : PublisherInput
    }
`;

const schema = makeExecutableSchema({
    typeDefs,
    resolvers
});

module.exports = schema;
