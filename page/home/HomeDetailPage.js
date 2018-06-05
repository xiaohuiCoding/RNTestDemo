import React, {Component} from 'react';
import {
    View,
    StyleSheet
} from 'react-native';

export default class HomeDetailPage extends Component {

    static xgNavigationBarOptions = {
        pageName: 'HomeDetailPage',
        title: '首页详情',
    };

    render() {
        return (
            <View style={styles.container}>

            </View>
        )
    };
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: 'white'
    }
});