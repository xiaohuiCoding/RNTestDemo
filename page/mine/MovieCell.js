import React, {Component} from 'react';

import {
    View,
    Image,
    Text,
    StyleSheet
} from 'react-native';

import PropTypes from 'prop-types';

export default class MovieCell extends Component {

    static propTypes = {
        imageUrl: PropTypes.string,
        title: PropTypes.string,
        year: PropTypes.string,
    };

    render() {
        return (
            <View style={styles.container}>
                <Image
                    source={{uri: this.props.imageUrl}}
                    style={styles.imageUrl}
                />
                <View style={styles.rightContainer}>
                    <Text style={styles.title}>{this.props.title}</Text>
                    <Text style={styles.year}>{this.props.year}</Text>
                </View>
            </View>
        )
    };
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        flexDirection: 'row',
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: 'white'
    },
    rightContainer: {
        flex: 1
    },
    imageUrl: {
        marginLeft: 10,
        marginTop: 10,
        marginBottom: 10,
        width: 60,
        height: 60
    },
    title: {
        fontSize: 14,
        marginLeft: 10
    },
    year: {
        fontSize: 14,
        marginLeft: 10,
        marginTop: 8
    }
});
