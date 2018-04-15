package com.example.sheila.sci_fi;

import java.util.ArrayList;

/**
 * Created by Sheila on 4/6/18.
 */

import java.util.Arrays;

public class Characters {
    private String universe;
    private ArrayList<String> scificharacters = new ArrayList<>();

    //constructor
    private Characters(String univ, ArrayList<String> characters) {
        this.universe = univ;
        this.scificharacters = new ArrayList<>(characters);
    }

    public static final Characters[] characters = {
            new Characters("Star Trek", new ArrayList<String>(Arrays.asList("Captain James T. Kirk", "Mr. Spock", "Captain Jean-Luc Picard", "Commander William T. Riker", "Data", "Captain Katheryn Janeway", "Chakotay"))),
            new Characters("Star Wars", new ArrayList<String>(Arrays.asList("Luke Skywalker", "Princess Leia", "Han Solo", "Darth Vader", "Kylo Ren", "Captain Phasma"))),
            new Characters("Firefly", new ArrayList<String>(Arrays.asList("Captain Malcolm Reynolds", "Zoe Washburne", "Inara Serra", "Kaylee Frye", "Jayne Cobb", "River Tam"))),
            new Characters("Battlestar Galactica", new ArrayList<String>(Arrays.asList("Kara Thrace", "Gaius Baltar", "Captain William Adama", "Number Six", "Lee Adama"))),
            new Characters("The Walking Dead", new ArrayList<String>(Arrays.asList("Rick Grimes", "Carl Grimes", "Michonne", "Glenn Rhee", "Daryl Dixon", "Hershel Greene", "Maggie Greene", "Carol Peletier")))
    };

    public String getUniverse(){
        return universe;
    }

    public ArrayList<String> getScificharacters(){
        return scificharacters;
    }

    public String toString(){
        return this.universe;
    }
}
