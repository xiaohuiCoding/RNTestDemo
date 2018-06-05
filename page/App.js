import React, {Component} from 'react';
import {
    View,
    Text,
    StyleSheet
} from 'react-native';

import XGNavigation from 'xgrn-navigation';
import LoadingView from 'xgrn-baseview';

export default class App extends Component {
    render() {
        const page = XGNavigation.renderPageByConfig(this.props);
        if (page && page !== 404) {
            return page;
        } else if (page === 404) {
            return (
                <View style={styles.container}>
                    <Text style={styles.welcome}>
                        {`Page not found 404`}
                    </Text>
                </View>
            );
        }
        return (<LoadingView/>);
    };
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#F5FCFF'
    },
    welcome: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10
    }
});
