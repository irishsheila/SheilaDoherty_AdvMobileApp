package com.example.sheila.thankful;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;
import io.realm.Realm;
import io.realm.RealmConfiguration;
import io.realm.RealmQuery;
import io.realm.RealmResults;

public class Entry extends AppCompatActivity {

    private Realm realm;
    String colorRadio;
    String imageName;
    String datePassed;
    String noteEntry;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_entry);
        Intent incomingIntent = getIntent();
        datePassed = incomingIntent.getStringExtra("date");
        TextView selectedDate = (TextView)findViewById(R.id.dateTextView);
        selectedDate.setText(datePassed);
        realm = Realm.getDefaultInstance();
        Log.d("PATH", "path: " + realm.getPath());
        //check to see if entry for date already exists
        Thanks thanksEntry = realm.where(Thanks.class).equalTo("date",datePassed).findFirst();
        //if it does have an entry for that date, load it
        if(thanksEntry != null){
            //prefill note to edit
            EditText noteEditText = (EditText)findViewById(R.id.thankfulText);
            noteEditText.setText(thanksEntry.getNote());

            //preselect color radio button
            RadioGroup colorRadioGroup = (RadioGroup)findViewById(R.id.radioGroup);
            String colorSelected = thanksEntry.getColor();
            Log.d("Color received: ", colorSelected);
            switch(colorSelected){
                case "blue":
                    colorRadioGroup.check(R.id.blueRadioButton);
                    break;
                case "green":
                    colorRadioGroup.check(R.id.greenRadioButton);
                    break;
                case "orange":
                    colorRadioGroup.check(R.id.orangeRadioButton);
                    break;
                case"teal":
                    colorRadioGroup.check(R.id.tealRadioButton);
                    break;
                default:
                    colorRadioGroup.check(R.id.pinkRadioButton);
            }

            //preselect image radio button
            RadioGroup imageRadioGroup = (RadioGroup)findViewById(R.id.imageRadioGroup);
            String imageSelected = thanksEntry.getPicture();
            Log.d("Image Selected: ", imageSelected);
            switch(imageSelected){
                case "happy":
                    imageRadioGroup.check(R.id.happyRadioButton);
                    break;
                case "flower":
                    imageRadioGroup.check(R.id.flowerRadioButton);
                    break;
                case "heart":
                    imageRadioGroup.check(R.id.heartRadioButton);
                    break;
                default:
                    imageRadioGroup.check(R.id.birdRadioButton);
            }
        }
        //if it doesn't, do nothing
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    public boolean onOptionsItemSelected(MenuItem item){
        //get the ID of the item on the action bar that was clicked
        switch (item.getItemId()){
            case R.id.done:
            //start activity
                setValues();
                Intent intent = new Intent(this, MainActivity.class);
                startActivity(intent);
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    public void setValues() {
        //set color
        RadioGroup colorGroup = (RadioGroup) findViewById(R.id.radioGroup);
        int color_id = colorGroup.getCheckedRadioButtonId();
        String cID = String.valueOf(color_id);
        Log.d("Color_id is: ", cID);
        String BRB = String.valueOf(R.id.blueRadioButton);
        Log.d("Blue button: ", BRB);
        String ORB = String.valueOf(R.id.orangeRadioButton);
        Log.d("Orange button: ", ORB);

        switch (color_id) {
            case R.id.blueRadioButton:
                colorRadio = "blue";
                break;
            case R.id.orangeRadioButton:
                colorRadio = "orange";
                break;
            case R.id.tealRadioButton:
                colorRadio = "teal";
                break;
            case R.id.pinkRadioButton:
                colorRadio = "pink";
                break;
            default:
                colorRadio = "green";

        }

        //set image
        RadioGroup imageGroup = (RadioGroup) findViewById(R.id.imageRadioGroup);
        int image_id = imageGroup.getCheckedRadioButtonId();
        switch (image_id) {
            case R.id.birdRadioButton:
                imageName = "bird";
                break;
            case R.id.heartRadioButton:
                imageName = "heart";
                break;
            case R.id.happyRadioButton:
                imageName = "happy";
                break;
            default:
                imageName = "flower";
        }

        //set note
        EditText thankfulNote = (EditText) findViewById(R.id.thankfulText);
        noteEntry = thankfulNote.getText().toString();
        Log.d("setValues", "date: " + datePassed);
        Log.d("setValues", "color: " + colorRadio);
        Log.d("setValues", "image: " + imageName);
        Log.d("setValues", "note: " + noteEntry);

        writeRealm();
    }

    public void writeRealm(){
        Log.i("Starting: ", "writeRealm()");
        RealmQuery<Thanks> query = realm.where(Thanks.class);
        query.equalTo("date", datePassed);
        final Thanks checkEntry = query.findFirst();
        //final Thanks checkEntry = realm.where(Thanks.class).equalTo("date", datePassed).findFirst();
        //if it does, load it
        if(checkEntry != null) {
            Log.i("checkEntry", "NOT NULL");
            realm.executeTransaction(new Realm.Transaction() {
                @Override
                public void execute(Realm realm) {
                    checkEntry.setColor(colorRadio);
                    checkEntry.setPicture(imageName);
                    checkEntry.setNote(noteEntry);
                }
            });
            Log.i("finished", "END NOT NULL SECTION");
        }
        else{
            realm.executeTransactionAsync(new Realm.Transaction() {
                @Override
                public void execute(Realm realm) {
                    Log.i("Starting: ", "else realm execution");
                    //create a realm object
                    Thanks newThanks = realm.createObject(Thanks.class, datePassed);
                    newThanks.setColor(colorRadio);
                    Log.i("Realm Set: ", newThanks.getColor());
                    newThanks.setNote(noteEntry);
                    Log.i("Realm Set: ", newThanks.getNote());
                    newThanks.setPicture(imageName);
                    Log.i("Realm Set: ", newThanks.getPicture());
                }
            });
        }
    Log.i("finished", "WRITE REALM");
    }

    @Override
    protected void onDestroy(){
        super.onDestroy();
        realm.close();
    }
}
