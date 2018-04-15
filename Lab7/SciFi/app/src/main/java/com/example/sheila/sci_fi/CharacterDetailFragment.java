package com.example.sheila.sci_fi;


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
public class CharacterDetailFragment extends Fragment implements View.OnClickListener {

    private ArrayAdapter<String> adapter;
    private long universeId;

    public void setUniverse(long id){
        this.universeId = id;
    }


    public CharacterDetailFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_character_detail, container, false);
    }

    @Override
    public void onStart(){
        super.onStart();
        View view = getView();
        ListView listCharacters = (ListView) view.findViewById(R.id.characterlistView);

        ArrayList<String> characterlist = new ArrayList<String>();
        characterlist = Characters.characters[(int)universeId].getScificharacters();
        adapter = new ArrayAdapter<String>(getActivity(), android.R.layout.simple_list_item_1, characterlist);
        listCharacters.setAdapter(adapter);
        Button addCharacterButton = (Button) view.findViewById(R.id.addCharacterButton);
        addCharacterButton.setOnClickListener(this);
        registerForContextMenu(listCharacters);
    }

    interface ButtonClickListener{
        void addcharacterclicked(View view);
    }

    private ButtonClickListener listener;

    @Override
    public void onAttach(Context context){
        super.onAttach(context);
        listener = (ButtonClickListener) context;
    }

    @Override
    public void onClick(View view){
        if (listener!=null){
            listener.addcharacterclicked(view);
        }
    }

    public void addcharacter(){
        final Dialog dialog = new Dialog(getActivity());
        dialog.setContentView(R.layout.dialog);
        dialog.setTitle("Add Character");
        dialog.setCancelable(true);
        final EditText editText = (EditText)dialog.findViewById(R.id.editTextCharacter);
        Button button = (Button)dialog.findViewById(R.id.addButton);
        button.setOnClickListener((new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String characterName = editText.getText().toString();
                if(!characterName.isEmpty()){
                    Characters.characters[(int) universeId].getScificharacters().add(characterName);
                    CharacterDetailFragment.this.adapter.notifyDataSetChanged();
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
        String charactername = adapter.getItem((adapterContextMenuInfo.position));
        menu.setHeaderTitle("Delete " + charactername);
        menu.add(1,1,1,"Yes");
        menu.add(2,2,2, "No");
    }

    @Override public boolean onContextItemSelected(MenuItem item){
        int itemId = item.getItemId();
        if(itemId == 1){
            AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo) item.getMenuInfo();
            Characters.characters[(int) universeId].getScificharacters().remove(info.position);
            CharacterDetailFragment.this.adapter.notifyDataSetChanged();
        }
        return true;
    }

}
