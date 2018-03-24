package com.example.sheila.spring;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

public class BulbActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_bulb);
        //get bulb id from the intent
        int bulbnum = (Integer)getIntent().getExtras().get("bulbid");
        String bulbtype = (String)getIntent().getExtras().get("bulbtype");
        Bulb bulb;
        switch (bulbtype){
            case "Tulips":
                bulb = Bulb.tulips[bulbnum];
                break;
            case "Iris":
                bulb = Bulb.irises[bulbnum];
                break;
            case "Daffodils":
                bulb = Bulb.daffodils[bulbnum];
                break;
            default: bulb = Bulb.tulips[bulbnum];
        }
        //populate image
        ImageView bulbImage = (ImageView)findViewById(R.id.bulbImageView);
        bulbImage.setImageResource(bulb.getImageResourceID());
        //populate name
        TextView bulbName = (TextView)findViewById(R.id.bulb_name);
        bulbName.setText(bulb.getName());
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
