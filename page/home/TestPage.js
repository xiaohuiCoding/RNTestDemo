import React, {Component} from 'react';
import {
    View,
    Text,
    TextInput,
    StyleSheet
} from 'react-native';

export default class TestPage extends Component {

    static xgNavigationBarOptions = {
        pageName: 'TestPage',
        title: '测试页面',
    };

    constructor(props) {
        super(props);
        this.state = {
            textValue: ''
        }
    }

    render() {
        return (
            <View style={styles.container}>
                <Text style={styles.text}>输入：</Text>
                <TextInput
                    style={styles.textInput}
                    placeholder={'请输入内容'}
                    placeholderTextColor={'#cccccc'}
                    underlineColorAndroid="transparent"
                    multiline={true}
                    // maxLength={20}
                    // value={this.state.textValue}
                    onChangeText={(text) => {
                        this.setState({
                            textValue: text
                        });
                    }}
                />
                <Text style={styles.text}>输出：</Text>
                <Text style={styles.text}>{this.state.textValue}</Text>
            </View>
        )
    };
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: 'white',
    },
    text: {
        marginLeft: 10,
        marginRight: 10,
        marginTop: 10,
    },
    textInput: {
        color: '#333333',
        fontSize: 14,
        marginLeft: 10,
        marginRight: 10,
        marginTop: 10,
        borderColor: 'blue',
        borderWidth: 1,
    }
});
