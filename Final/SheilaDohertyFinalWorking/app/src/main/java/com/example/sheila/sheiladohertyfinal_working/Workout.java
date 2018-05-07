package com.example.sheila.sheiladohertyfinal_working;

import java.util.ArrayList;
import java.util.Arrays;

public class Workout {
    private String workoutcategory;
    private ArrayList<String> workouttype = new ArrayList<>();

    private Workout(String cat, ArrayList<String> type){
        this.workoutcategory = cat;
        this.workouttype = new ArrayList<String>(type);
    }

    public static final Workout[] workouts = {
            new Workout("Cardio", new ArrayList<String>(Arrays.asList(""))),
            new Workout("Strength", new ArrayList<String>(Arrays.asList(""))),
            new Workout("Flexibility", new ArrayList<String>(Arrays.asList("")))
    };

    public String getWorkoutcategory(){
        return workoutcategory;
    }
    public ArrayList<String> getWorkouttype(){
        return workouttype;
    }

    public  String toString(){
        return this.workoutcategory;
    }
}
