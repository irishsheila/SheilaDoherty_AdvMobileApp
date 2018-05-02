package com.example.sheila.thankful;
import android.app.Application;
import android.util.Log;

import io.realm.Realm;
import io.realm.RealmConfiguration;

/**
 * Created by Sheila on 4/25/18.
 */

public class ThankfulApplication extends Application{
    @Override
    public void onCreate(){
        super.onCreate();
        Realm.init(this);
        RealmConfiguration realmConfig = new RealmConfiguration.Builder().build();

        //MUST COMMENT FOR APP TO FUNCTION PROPERLY!
        //Realm.deleteRealm(realmConfig); //uncomment to delete entire realm file

        Realm.setDefaultConfiguration(realmConfig);
    }
}
