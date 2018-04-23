package com.example.sheila.grocerylist;

import android.app.Application;

import io.realm.Realm;
import io.realm.RealmConfiguration;

/**
 * Created by Sheila on 4/17/18.
 */

public class GroceryListApplication extends Application {
    @Override
    public void onCreate(){
        super.onCreate();
        Realm.init(this);
        RealmConfiguration realmConfig = new RealmConfiguration.Builder().build();
        Realm.setDefaultConfiguration(realmConfig);
    }
}
