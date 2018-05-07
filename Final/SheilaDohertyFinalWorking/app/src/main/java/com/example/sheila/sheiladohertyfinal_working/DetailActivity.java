package com.example.sheila.sheiladohertyfinal_working;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;

public class DetailActivity extends Activity implements WorkoutTypeFragment.ButtonClickListener{

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);
        WorkoutTypeFragment workoutDetailFragment = (WorkoutTypeFragment) getFragmentManager().findFragmentById(R.id.fragment_container);
        int universeId = (int) getIntent().getExtras().get("id");
        workoutDetailFragment.setUniverseId(universeId);
    }

    @Override
    public void addworkoutclicked(View view) {
        WorkoutTypeFragment fragment = (WorkoutTypeFragment) getFragmentManager().findFragmentById(R.id.fragment_container);
        fragment.addworkout();
    }
}
