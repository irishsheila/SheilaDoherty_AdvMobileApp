package com.example.sheila.spring;

/**
 * Created by Sheila on 3/21/18.
 */

public class Bulb {
    private String name;
    private int imageResourceID;
    //constructor
    private Bulb(String newname, int newID){
        this.name = newname;
        this.imageResourceID = newID;
    }

    public static final Bulb[] tulips = {
            new Bulb("Daydream", R.drawable.daydream),
            new Bulb("Apeldoorn Elite", R.drawable.apeldoorn),
            new Bulb("Baja Luka", R.drawable.banjaluka),
            new Bulb("Burning Heart", R.drawable.burningheart),
            new Bulb("Cape Cod", R.drawable.capecod)
    };

    public static final Bulb[] irises = {
            new Bulb("Iris chrysophylla", R.drawable.irischrysographes),
            new Bulb("Iris foetidissima", R.drawable.irisfoetidissima),
            new Bulb("Iris graminea", R.drawable.irisgraminea),
            new Bulb("Iris purdyi", R.drawable.irispurdyi),
            new Bulb("Iris albican", R.drawable.irisalbicans)
    };

    public static final Bulb[] daffodils = {
            new Bulb("Narcissus Asturiensis", R.drawable.d_narcissus_asturiensis),
            new Bulb("Narcissus Cyclamineus", R.drawable.d_narcissus_cyclamineus),
            new Bulb("Narcissus Papyraceus", R.drawable.d_narcissus_papyraceus),
            new Bulb("Narcissus Poeticus", R.drawable.d_narcissus_poeticus),
            new Bulb("Narcissus Tazetta", R.drawable.d_narcissus_tazetta)
    };

    public String getName(){
        return name;
    }

    public int getImageResourceID(){
        return imageResourceID;
    }

    //string representation of a tulip is its name
    public  String toString(){
        return this.name;
    }
}
