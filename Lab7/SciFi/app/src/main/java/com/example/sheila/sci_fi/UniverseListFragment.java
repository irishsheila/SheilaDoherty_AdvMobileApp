package com.example.sheila.sci_fi;


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
public class UniverseListFragment extends Fragment implements AdapterView.OnItemClickListener {

    private UniverseListListener listener;

    public UniverseListFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_universe_list, container, false);
    }

    @Override
    public void onStart(){
        super.onStart();
        View view = getView();
        if(view!=null){
            ListView listUniverse = (ListView) view.findViewById(R.id.listView);
            ArrayAdapter<Characters> listAdapter = new ArrayAdapter<Characters>(getActivity(), android.R.layout.simple_list_item_1, Characters.characters);
            listUniverse.setAdapter(listAdapter);
            listUniverse.setOnItemClickListener(this);
        }
    }

    interface UniverseListListener{
        void itemClicked(long id);
    }

    @Override
    public void onAttach(Context context){
        super.onAttach(context);
        listener = (UniverseListListener) context;
    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id){
        if(listener!=null){
            listener.itemClicked(id);
        }
    }



}
