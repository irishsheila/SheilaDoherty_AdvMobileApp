package com.example.sheila.sheiladohertyfinal_working;


import android.content.Context;
import android.os.Bundle;
import android.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;


/**
 * A simple {@link Fragment} subclass.
 */
public class WorkoutListFragment extends Fragment implements AdapterView.OnItemClickListener{


    public WorkoutListFragment() {
        // Required empty public constructor
    }

    interface WorkoutListListener{
        void itemClicked(long id);
    }

    private WorkoutListListener listener;


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_workout_list, container, false);
    }

    @Override
    public void onStart(){
        super.onStart();
        View view = getView();
        if(view!=null){
            ListView listUniverse = (ListView) view.findViewById(R.id.listView);
            ArrayAdapter<Workout> listAdapter = new ArrayAdapter<Workout>(getActivity(), android.R.layout.simple_list_item_1, Workout.workouts);
            listUniverse.setAdapter(listAdapter);
            listUniverse.setOnItemClickListener(this);
        }
    }

    @Override
    public void onAttach(Context context){
        super.onAttach(context);
        listener = (WorkoutListListener) context;
    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id){
        if(listener!=null){
            listener.itemClicked(id);
        }
    }

}
