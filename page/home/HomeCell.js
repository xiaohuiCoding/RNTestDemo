import React, {Component} from 'react';
import {
    View,
    Text,
    CameraRoll,
    TouchableOpacity,
    StyleSheet
} from 'react-native';

import PropTypes from 'prop-types';

import PhotoBrowser from 'xgrn-photobrowser'

export default class HomeCell extends Component {

    //属性类型
    static propTypes = {
        title: PropTypes.string,
        subTitle: PropTypes.string,
        showTestPage: PropTypes.func,
        showAlbumPage: PropTypes.func,
        showHomeDetailPage: PropTypes.func,
    };

    showImage =() => {
        let array = [
            'http://g.hiphotos.baidu.com/image/pic/item/cf1b9d16fdfaaf519d4aa2db805494eef01f7a2c.jpg',
            'http://c.hiphotos.baidu.com/image/pic/item/b21c8701a18b87d65d3311770b0828381f30fd61.jpg',
            'http://d.hiphotos.baidu.com/image/pic/item/bd3eb13533fa828b7d666185f11f4134970a5a0b.jpg',
            'http://g.hiphotos.baidu.com/image/pic/item/1e30e924b899a9011a42d55e11950a7b0208f567.jpg',
            'http://h.hiphotos.baidu.com/image/pic/item/a71ea8d3fd1f41344002e11a291f95cad1c85e99.jpg',
        ];
        let params = {'imageUrls':array,'startIndex':0,'startFrame':{'x':100,'y':'300','width':150,'height':'150'}};
        PhotoBrowser.showPhotoBrowserWithParams(params);
    };

    render() {
        return (
            <TouchableOpacity onPress={this.props.showHomeDetailPage}>
                <View style = {styles.container}>
                    <Text style={styles.first} onPress={this.props.showTestPage}>
                        {this.props.first}
                    </Text>
                    <Text style={styles.second} onPress={this.props.showAlbumPage}>
                        {this.props.second}
                    </Text>
                    <Text style={styles.third} onPress={this.showImage}>
                        {this.props.third}
                    </Text>
                    <View style={styles.line}/>
                </View>
            </TouchableOpacity>
        )
    };
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        // marginHorizontal: 15,
    },
    first: {
        marginLeft: 15,
        marginTop: 10,
        width: 200,
    },
    second: {
        marginLeft: 15,
        marginTop: 10,
        width: 200,
    },
    third: {
        marginLeft: 15,
        marginTop: 10,
        width: 200,
    },
    line: {
        backgroundColor: '#ccc',
        marginTop: 10,
        height: 0.5,
    }
});