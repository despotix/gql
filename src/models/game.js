const mORM = require('../modules/micro_orm');

class Game {
    constructor() {
        this._publisher = new mORM('publisher');
        this._game = new mORM('game');
        this._game_view = new mORM('game_publisher_view');
    }

    fetch(obj) {
        return this._game_view
            .fetch(obj)
            .then(dbrs => this._transform_view(dbrs.rows));
    }

    fetchOne(obj) {
        return this
            .fetch(obj)
            .then(arr => arr[0]);
    }

    create({game}) {
        let {
            title, price, release, tags,
            publisher: {name, siret, phone}
        } = game;
        return this._publisher.insert(game.publisher, true)
            .then(publisher => {
                return this._game.insert({
                    title, price, release, tags,
                    publisher: publisher.rows[0].id
                }, false);
            })
            .then(ir => (ir.rows[0] || {}).id || null);
    }

    remove({id}) {
        return this
            ._game.remove({id})
            .then(dbrs => dbrs.rowCount);
    }

    update(condition, params) {
        return this
            ._game.update(condition, params)
            .then(() => this.fetchOne(condition));
    }

    _transform_view(game_arr = []) {
        return game_arr.map(g => {
            let {siret, phone, name, publisher_id} = g;
            let {id, title, price, discount, release, tags} = g;
            return {
                id, title, price, discount, release, tags,
                publisher: {
                    siret, phone, name,
                    id : publisher_id
                }
            }
        });
    }
}

module.exports = Game;