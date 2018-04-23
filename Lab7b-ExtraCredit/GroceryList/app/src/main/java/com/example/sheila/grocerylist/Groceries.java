package com.example.sheila.grocerylist;


/**
 * Created by Sheila on 4/17/18.
 */

import io.realm.RealmObject;
import io.realm.annotations.PrimaryKey;
import io.realm.annotations.Required;

public class Groceries extends RealmObject{
    @Required
    @PrimaryKey
    private String id;
    private String grocery_item;
    private String grocery_category;
    private boolean food_found;

    public String getId(){
        return id;
    }

    public void setId(String id){
        this.id = id;
    }

    public String getGrocery_item(){
        return grocery_item;
    }

    public void setGrocery_item(String food){
        this.grocery_item = food;
    }

    public String getGrocery_category(){
        return grocery_category;
    }

    public void setGrocery_category(String food_category){
        this.grocery_category = food_category;
    }

    public boolean hasBought(){
        return food_found;
    }

    public void setFood_found(boolean done){
        this.food_found = done;
    }

}
