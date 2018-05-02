package com.example.sheila.thankful;
import io.realm.RealmObject;
import io.realm.annotations.PrimaryKey;
import io.realm.annotations.Required;

/**
 * Created by Sheila on 4/25/18.
 */

public class Thanks extends RealmObject {
    @Required
    @PrimaryKey
    private String date;
    private String note;
    private String picture;
    private String color;

    public String getNote(){
        return note;
    }

    public void setNote(String note){
        this.note = note;
    }

    public String getPicture(){
        return picture;
    }

    public void setPicture(String picture){
        this.picture = picture;
    }

    public String getColor(){
        return color;
    }

    public void setColor(String color){
        this.color = color;
    }

    public String getDate(){
        return date;
    }

    public void setDate(String date){
        this.date = date;
    }

}
