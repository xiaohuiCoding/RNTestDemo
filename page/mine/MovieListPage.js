import React, {Component} from 'react';

import {
    View,
    FlatList,
    Text,
    StyleSheet
} from 'react-native';

import MovieCell from './MovieCell'

var REQUEST_URL = 'https://raw.githubusercontent.com/facebook/react-native/0.51-stable/docs/MoviesExample.json';

export default class MovieListPage extends Component {

    static xgNavigationBarOptions = {
        pageName: 'MovieListPage',
        title: 'movie list',
    };

    constructor(props) {
        super(props);
        this.state = {
            data: [],
            loaded: false,
            refreshing: false
        };
        // 在ES6中，如果在自定义的函数里使用了this关键字，则需要对其进行“绑定”操作，否则this的指向会变为空
        // 像下面这行代码一样，在constructor中使用bind是其中一种做法（还有一些其他做法，如使用箭头函数等）
        this.fetchData = this.fetchData.bind(this);
    }

    componentDidMount() {
        this.fetchData();
    }

    refreshData = () =>  {
        console.warn('下拉刷新成功！')
        this.fetchData();
    }

    fetchData() {
        this.setState({refreshing: true});
        fetch(REQUEST_URL)
            .then((response) => response.json())
            .then((responseData) => {
                // 注意，这里使用了this关键字，为了保证this在调用时仍然指向当前组件，我们需要对其进行“绑定”操作
                this.setState({
                    data: this.state.data.concat(responseData.movies),
                    loaded: true,
                    refreshing: false
                });
            });
    }

    render() {
        if (!this.state.loaded) {
            return this.renderLoadingView();
        }

        return (
            <FlatList
                style={styles.list}
                data={this.state.data}
                renderItem={this.renderMovieList}
                onRefresh={this.refreshData}
                refreshing={false}
            />
        );
    }

    renderLoadingView() {
        return (
            <View style={styles.container}>
                <Text>
                    Loading movies...
                </Text>
            </View>
        );
    }

    renderMovieList(itemData) {
        return (
            <MovieCell
                imageUrl={itemData.item.posters.thumbnail}
                title={itemData.item.title}
                year={itemData.item.year.toString()}
            />
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        flexDirection: 'row',
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: 'white',
    },
    list: {
        backgroundColor: 'white',
    },
});
