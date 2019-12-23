/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, { Component } from 'react';
import {
  SafeAreaView,
  StyleSheet,
  ScrollView,
  View,
  Text,
  StatusBar,
  Button,
} from 'react-native';

import {
  Header,
  LearnMoreLinks,
  Colors,
  DebugInstructions,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';
import {NativeModules} from 'react-native';
const BarcodeReaderManager = NativeModules.BarcodeReaderManager;

export default class App extends Component{
    constructor(props){
        super(props);
        this.state = {
            result: 'N/A'
        };
    }

  	onButtonPress = () => {
  		//ios
    	BarcodeReaderManager.readBarcode('your license here').then((events) =>{
			this.setState({result: events});
		}).catch((err) => {
			console.log(err);
		});
	    //android
	    // BarcodeReaderManager.readBarcode('your license here',events => {
	    //     this.setState({result: events});
	    //   },err => {
	    //     alert(err)
	    //   }
	    // );
  	}
	render(){
		return (
			<View style={styles.container}>
			<Button title='Read Barcode' onPress={this.onButtonPress} />
			<Text style={styles.display}>
				Barcode Result : {this.state.result}
			</Text>
			</View>
		);
	};
}

const styles = StyleSheet.create({
  scrollView: {
    backgroundColor: Colors.lighter,
  },
  engine: {
    position: 'absolute',
    right: 0,
  },
  body: {
    backgroundColor: Colors.white,
  },
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
    color: Colors.black,
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
    color: Colors.dark,
  },
  highlight: {
    fontWeight: '700',
  },
  footer: {
    color: Colors.dark,
    fontSize: 12,
    fontWeight: '600',
    padding: 4,
    paddingRight: 12,
    textAlign: 'right',
  },
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  display: {
    fontSize: 20,
    textAlign: 'center',
    color:'#FFD700',
    margin: 10,
  },
});