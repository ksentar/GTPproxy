import React, { useState, useEffect } from 'react';
import buildHasuraProvider from 'ra-data-hasura';
import { Admin, Resource } from 'react-admin';

import { PostCreate, PostEdit, PostList } from './posts';

const App = () => {
    const [dataProvider, setDataProvider] = useState(null);

    useEffect(() => {
        const buildDataProvider = async () => {
            const dataProvider = await buildHasuraProvider({
                clientOptions: { uri: 'http://gtpproxy.ksentar-dev.lan/v1/graphql' },
            });
            setDataProvider(() => dataProvider);
        };
        buildDataProvider();
    }, []);

    if (!dataProvider) return <p>Loading...</p>;

    return (
        <Admin dataProvider={dataProvider}>
            <Resource
                name="Post"
                list={PostList}
                edit={PostEdit}
                create={PostCreate}
            />
        </Admin>
    );
};

export default App;