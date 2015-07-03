//
//  RestKitManager.swift
//  FlexYourMacros
//

import Foundation

class RestKitManager: RKObjectManager {
    
    class func configureResponseDescriptors() {
        
        // add the response descriptor
        let objectManager = RestKitManager.sharedManager() as RestKitManager;
        
        objectManager.addResponseDescriptor(UserLogInResponse.responseDescriptor)
                
        objectManager.addResponseDescriptor(ProgressResponse.responseDescriptor)


    }

    class func setupRestkit() {
        
        let modelPath = NSBundle.mainBundle().pathForResource("Model", ofType: "momd")
        var url = NSURL.fileURLWithPath(modelPath!)
        
        let managedObjectModel = NSManagedObjectModel(contentsOfURL: url!)
        
        let managedObjectStore = RKManagedObjectStore(managedObjectModel: managedObjectModel)
        
        var error: NSError?
        
        let options = [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true]
        
        let success = RKEnsureDirectoryExistsAtPath(RKApplicationDataDirectory(), &error)
        
        if !success {
            println("Failed to create Application Data Directory at path \(RKApplicationDataDirectory())")
        }
        
        let path = RKApplicationDataDirectory().stringByAppendingPathComponent("Model.sqlite")
        
        println("Path-------------------------------:: \(path)")
        
        let persistentStore = managedObjectStore.addSQLitePersistentStoreAtPath(path, fromSeedDatabaseAtPath: nil, withConfiguration: nil, options: options, error: &error)
        
        if persistentStore == nil {
            println("Failed adding persistent store at path \(path)")
        }
        
        managedObjectStore.createManagedObjectContexts()
        
        // manage cache to prevent creation of duplicates
        
        // create an OAuthClient
        let baseURL = NSURL(string: Constants.ServiceConstants.BaseUrlString)
        
        let oauthClient = AFOAuth2Client(baseURL: baseURL)
        oauthClient.setDefaultHeader("Content-Type", value:"application/json")
        oauthClient.setDefaultHeader("Accept", value:"application/json")
        oauthClient.setAuthorizationHeaderWithUsername(Constants.ServiceConstants.oAuthUserName, password: Constants.ServiceConstants.oAuthPassword)
        
        //create an Object manager with aouthclient as HTTP client
        let objectManager = RestKitManager(HTTPClient: oauthClient)
        objectManager.managedObjectStore = managedObjectStore
        
        RestKitManager.setSharedManager(objectManager)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.managedObjectContext = RKManagedObjectStore.defaultStore().persistentStoreManagedObjectContext
        
        RestKitManager.initLogging()
        #if !(TARGET_OS_EMBEDDED)  // This will work for Mac or Simulator but excludes physical iOS devices
            #if DEBUG
                // @(1) is NSSQLiteStoreType
                createCoreDataDebugProjectWithType(1, storeURL: persistentStore!.URL!.absoluteString!, modelFilePath: modelUrl.absoluteString!)
            #endif
        #endif
    }
    
    struct Class {
        static let UIAlertController = "UIAlertController"
    }
    
    class func setToken(flag: Bool) {

        var accessToken = ""
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if userDefaults.objectForKey("session") != nil {
            
            accessToken = userDefaults.objectForKey("accesstoken") as! String
            
            //get the accesstoken set date from the userdefaults
            let accessTokenSetDate = userDefaults.valueForKey("accesstoken_setdate") as! NSDate
            
            let tokenExpirationTime = userDefaults.objectForKey("expiresin") as! String
            
            //check the time interval since the accesstoken is set in seconds
            var seconds = NSDate().timeIntervalSinceDate(accessTokenSetDate)
            
            //check whether the accesstoken exceeded the expiration time
            if seconds >= tokenExpirationTime.doubleValue {
                
                //found the token expired and user is redirected to the login page
                    let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
                    
//                    appDelegate?.loadLogin()
                    return
            }
            
            println("date ---\(accessTokenSetDate)")
           
        }
        var accesstoken : String? = (flag) ? accessToken: ""
        RestKitManager.sharedManager().HTTPClient.setDefaultHeader("Authorization", value:"Bearer "+accesstoken!)
        
    }
    
    class func setupBasicAuth() {
        
        // create an OAuthClient
        let baseURL = NSURL(string: Constants.ServiceConstants.BaseUrlString)
        
        let oauthClient = AFOAuth2Client(baseURL: baseURL)
        oauthClient.setDefaultHeader("Content-Type", value:"application/json")
        oauthClient.setDefaultHeader("Accept", value:"application/json")
        oauthClient.setAuthorizationHeaderWithUsername(Constants.ServiceConstants.oAuthUserName, password: Constants.ServiceConstants.oAuthPassword)
        
        RestKitManager.sharedManager().HTTPClient = oauthClient
    }
    
}


#if !(TARGET_OS_EMBEDDED)
    func createCoreDataDebugProjectWithType(storeFormat: NSNumber, storeURL: String, modelFilePath: String) {
        
        var project: NSDictionary = [
            "storeFilePath": storeURL,
            "storeFormat" : storeFormat,
            "modelFilePath": modelFilePath,
            "v" : "1"
        ]
        
        var projectFile = "/tmp/\(NSBundle.mainBundle().infoDictionary![kCFBundleNameKey]!).cdp"
        
        project.writeToFile(projectFile, atomically: true)
    }
    
#endif
