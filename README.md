# Barcode Scanning Module for React Native

This is a sample that shows how to implement barcode scanning in React Native using Dynamsoft Barcode Reader SDK. 

To learn more about Dynamsoft Barcode Reader, please visit http://www.dynamsoft.com/Products/Dynamic-Barcode-Reader.aspx.


## License

You can request for a free trial license online. [Get a trial license >](https://www.dynamsoft.com/CustomerPortal/Portal/Triallicense.aspx)

Without a valid license, the SDK can work but will not return a full result.

<kbd><img src="http://www.codepool.biz/wp-content/uploads/2017/04/react-native-barcode-license.png" width="50%">

## How to Run the Example

```bash
cd Example
npm install
react-native run-android or react-native run-ios
```

### Screenshots

<kbd><img src="http://www.codepool.biz/wp-content/uploads/2017/04/react-native-barcode-detection.jpg" width="50%">

<kbd><img src="http://www.codepool.biz/wp-content/uploads/2017/04/react-native-barcode-result.png" width="50%">

## How to Use the Barcode Scanning Module

### In Android

1. Create a new React Native project.

    ```bash
    react-native init NewProject
    ```

2. Add the local module to dependencies in `package.json`.

    ```json
    "dependencies": {
		"react": "16.0.0-alpha.6",
		"react-native": "0.43.3",
		"react-native-dbr":"file:../"
	},
    ```

3. Link dependencies.

    ```bash
    react-native link
    ```

4. Use **flatDir** to define library path in `android/build.gradle`.

    ```
    flatDir {
        dirs "$rootDir/../node_modules/react-native-dbr/android/lib"
    }
    ```

4. Use the module in `index.android.js`.

    ```javascript
    import BarcodeReaderManager from 'react-native-dbr';

    BarcodeReaderManager.readBarcode('your license key', (msg) => {
        this.setState({result: msg});
        }, 
        (err) => {
        console.log(err);
    });
    ```

### In iOS

1. Create a new React Native project.

    ```bash
    react-native init NewProject --version 0.44.3
    ```

2. Add the local module to dependencies in `NewProject/package.json`.

    ```json
    "dependencies": {
        "react": "16.0.0-alpha.6",
        "react-native": "0.43.3",
        "react-native-dbr":"file:../"
    }
    ```

3. Remove `node_moudules` and install.

    ```bash
    sudo rm -rf node_moudules 
    npm install or yarn
    ```

4. Add `BarcodeReaderManager.xcodeproj` to  your project libraries.

5. Use the module in `index.ios.js`.

    ```javascript
    import BarcodeReaderManager from 'react-native-dbr';
    BarcodeReaderManager.readBarcode('your license here').then((msg) =>{
        this.setState({result: msg});
    }).catch((err) => {
        console.log(err);
    });
    ```

6. To achieve navigation from react-native to viewController, in `AppDelegate.m`, add the following code:

    ```objective-c
    #import "../../../ios/BarcodeReaderManagerViewController.h"
    #import "../../../ios/DbrManager.h"

    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
    //  self.window.rootViewController = rootViewController;
        _nav = [[UINavigationController alloc] initWithRootViewController:_rootViewController];
        self.window.rootViewController = _nav;
        _nav.navigationBarHidden = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doNotification:) name:@"readBarcode" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToJs:) name:@"backToJs" object:nil];
        [self.window makeKeyAndVisible];
        return YES;
    }

    -(void)doNotification:(NSNotification *)notification{
        BarcodeReaderManagerViewController* dbrMangerController = [[BarcodeReaderManagerViewController alloc] init];
        dbrMangerController.dbrManager = [[DbrManager alloc] initWithLicense:notification.userInfo[@"inputValue"]];
        [self.nav pushViewController:dbrMangerController animated:YES];
    }

    -(void)backToJs:(NSNotification *)notification{
        [self.nav popToViewController:self.rootViewController animated:YES];
    }
    ```

## Blog

[Android Barcode Detection Component for React Native](http://www.codepool.biz/android-barcode-detection-component-react-native.html)
