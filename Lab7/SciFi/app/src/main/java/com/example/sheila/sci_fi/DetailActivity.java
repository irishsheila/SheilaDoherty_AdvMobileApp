package com.example.sheila.sci_fi;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;

public class DetailActivity extends Activity implements CharacterDetailFragment.ButtonClickListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);
        CharacterDetailFragment characterDetailFragment = (CharacterDetailFragment)getFragmentManager().findFragmentById(R.id.fragment_container);
        int universeId = (int) getIntent().getExtras().get("id");
        characterDetailFragment.setUniverse(universeId);
    }

    @Override
    public void addcharacterclicked(View view){
        CharacterDetailFragment fragment = (CharacterDetailFragment)getFragmentManager().findFragmentById(R.id.fragment_container);
        fragment.addcharacter();
    }
}
