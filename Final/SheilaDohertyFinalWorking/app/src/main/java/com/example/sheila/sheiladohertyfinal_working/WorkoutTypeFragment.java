package com.example.sheila.sheiladohertyfinal_working;


import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.app.Fragment;
import android.view.ContextMenu;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;

import java.util.ArrayList;


/**
 * A simple {@link Fragment} subclass.
 */
public class WorkoutTypeFragment extends Fragment implements View.OnClickListener{

    private ArrayAdapter<String> adapter;
    private long universeId;

    interface ButtonClickListener{
        void addworkoutclicked(View view);
    }

    private ButtonClickListener listener;


    public WorkoutTypeFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        if(savedInstanceState !=null){
            universeId = savedInstanceState.getLong("universeId");
        }
        return inflater.inflate(R.layout.fragment_workout_type, container, false);
    }

    @Override
    public void onStart(){
        super.onStart();
        View view = getView();
        ListView listWorkouts = (ListView) view.findViewById(R.id.workouttypelistview);

        ArrayList<String> typelist = new ArrayList<String>();
        typelist = Workout.workouts[(int)universeId].getWorkouttype();
        adapter = new ArrayAdapter<String>(getActivity(), android.R.layout.simple_list_item_1, typelist);
        listWorkouts.setAdapter(adapter);
        Button addWorkoutButton = (Button) view.findViewById(R.id.addWorkoutButton);
        addWorkoutButton.setOnClickListener(this);
        registerForContextMenu(listWorkouts);
    }

    public void setUniverseId(long id){
        this.universeId = id;
    }

    @Override
    public void onSaveInstanceState(Bundle savedInstanceState){
        savedInstanceState.putLong("universeId", universeId);
    }

    @Override
    public void onAttach(Context context){
        super.onAttach(context);
        listener = (ButtonClickListener) context;
    }

    @Override
    public void onClick(View view){
        if (listener!=null){
            listener.addworkoutclicked(view);
        }
    }

    public void addworkout(){
        final Dialog dialog = new Dialog(getActivity());
        dialog.setContentView(R.layout.dialog);
        dialog.setTitle("Add Workout");
        dialog.setCancelable(true);
        final EditText editText = (EditText)dialog.findViewById(R.id.editTextWorkout);
        Button button = (Button)dialog.findViewById(R.id.addButton);
        button.setOnClickListener((new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String workoutName = editText.getText().toString();
                if(!workoutName.isEmpty()){
                    Workout.workouts[(int) universeId].getWorkouttype().add(workoutName);
                    WorkoutTypeFragment.this.adapter.notifyDataSetChanged();
                }
                dialog.dismiss();
            }
        }));
        dialog.show();
    }
    @Override
    public void onCreateContextMenu(ContextMenu menu, View view, ContextMenu.ContextMenuInfo menuInfo){
        super.onCreateContextMenu(menu,view,menuInfo);
        AdapterView.AdapterContextMenuInfo adapterContextMenuInfo = (AdapterView.AdapterContextMenuInfo) menuInfo;
        String workoutname = adapter.getItem((adapterContextMenuInfo.position));
        menu.setHeaderTitle("Delete " + workoutname);
        menu.add(1,1,1,"Yes");
        menu.add(2,2,2, "No");
    }

    @Override public boolean onContextItemSelected(MenuItem item){
        int itemId = item.getItemId();
        if(itemId == 1){
            AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo) item.getMenuInfo();
            Workout.workouts[(int) universeId].getWorkouttype().remove(info.position);
            WorkoutTypeFragment.this.adapter.notifyDataSetChanged();
        }
        return true;
    }


}
