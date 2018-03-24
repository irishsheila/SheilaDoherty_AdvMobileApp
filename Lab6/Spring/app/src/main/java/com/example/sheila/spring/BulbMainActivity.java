package com.example.sheila.spring;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

public class BulbMainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_bulb_main);

        //create the listener
        AdapterView.OnItemClickListener itemClickListener = new AdapterView.OnItemClickListener(){
            public void onItemClick(AdapterView<?> listView, View view, int position, long id){
                String bulbtype = (String) listView.getItemAtPosition(position);
                //create new intent
                Intent intent = new Intent(BulbMainActivity.this, BulbCategoryActivity.class);
                //add bulbtype to intent
                intent.putExtra("bulbtype", bulbtype);
                //start intent
                startActivity(intent);
            }
        };
        ListView listview = (ListView) findViewById(R.id.listView);
        //add listener to the listview
        listview.setOnItemClickListener(itemClickListener);
    }

    //need these two functions in every activity where I want an action bar
    @Override
    public boolean onCreateOptionsMenu(Menu menu){
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item){
        switch (item.getItemId()){
            case R.id.create_order:
                Intent intent = new Intent(this, OrderActivity.class);
                startActivity(intent);
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }
}