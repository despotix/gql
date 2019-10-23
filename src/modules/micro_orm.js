class mORM {
    constructor(table) {
        this.table = table;
    }

    insert(obj, ignoreExists = true) {
        let placeHolders = Object.keys(obj).map((field, index) => {
            return `$${1 + index}`;
        }).join(',');
        let fields = Object.keys(obj).join(',');
        let values = Object.values(obj);
        let query = `insert into ${this.table} 
            (${fields}) values (${placeHolders})
            returning *`;
        return this._query(query, values)
            .catch(e => {
                if (!ignoreExists) {
                    throw e;
                }
                switch (~~e.code) {
                    case 23505 : // publisher exists
                        return this.fetch(obj);
                        break;
                }
                throw e;
            });
    }

    fetch(obj = {}) {
        let query = this._gen_condition(`select * from ${this.table}`, obj);
        return this._query(query, Object.values(obj));
    }

    remove(obj) {
        let query = this._gen_condition(`delete from ${this.table}`, obj);
        return this._query(query, Object.values(obj));
    }

    update(condition, params){
        let values = Object.keys(params).map( field => {
            return `${field} = ${params[field]}`;
        }).join(', ');
        let query = this._gen_condition(
            `update ${this.table} set ${values}`,
            condition
        );
        return this._query(
            query,
            Object.values(condition)
        );
    }

    _query(query, parameters) {
        return global.pg_client.query(query, parameters);
    }

    _gen_condition(query, obj = {}) {
        if (Object.keys(obj).length) {
            query += ' where ' + Object.keys(obj).map((field, index) => {
                return `(${field} = $${1 + index})`
            }).join(' AND ');
        }
        return query;
    }
}

module.exports = mORM;