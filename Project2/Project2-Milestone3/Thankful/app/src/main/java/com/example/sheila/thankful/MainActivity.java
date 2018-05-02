package com.example.sheila.thankful;

import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.constraint.ConstraintLayout;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.CalendarView;
import android.widget.ImageView;
import android.support.v7.widget.AppCompatTextView;
import android.widget.TextView;

import java.util.Random;

import io.realm.Realm;
import io.realm.RealmResults;

public class MainActivity extends AppCompatActivity {

    private static final String TAG = "CalendarActivity";
    private CalendarView mCalendarView;
    private Realm realm;
    private String imagePassed;
    private String colorPassed;
    private String datePassed;
    private String notePassed;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        realm = Realm.getDefaultInstance();
        mCalendarView = (CalendarView)findViewById(R.id.calendarView);
        mCalendarView.setOnDateChangeListener(new CalendarView.OnDateChangeListener() {
            @Override
            public void onSelectedDayChange(@NonNull CalendarView view, int year, int month, int dayOfMonth) {
                String date = (month + 1) + "." + dayOfMonth + "." + year;
                Log.d(TAG, "onSelectedDayChange: date: " + date);

                Intent intent = new Intent(MainActivity.this, Entry.class);
                intent.putExtra("date", date);
                startActivity(intent);
            }
        });
        randomRealmSelection();
        updateImages();
    }

    public void randomRealmSelection(){
        if (!realm.isEmpty()){
            Random random = new Random();
            RealmResults<Thanks> list = realm.where(Thanks.class).findAll();
            Thanks item = list.get(random.nextInt(list.size()));
            datePassed = item.getDate();
            imagePassed = item.getPicture();
            colorPassed = item.getColor();
            notePassed = item.getNote();
        }
        else{
            datePassed = "";
            String[] cArray = getResources().getStringArray(R.array.colorArray);
            String randomColor = cArray[new Random().nextInt(cArray.length-1)];
            String[] iArray = getResources().getStringArray(R.array.imageArray);
            String randomImage = iArray[new Random().nextInt(iArray.length-1)];
            imagePassed = randomImage;
            colorPassed = randomColor;
            notePassed =getString(R.string.gratitude_quote);
        }
    }

    public void updateImages(){
        //set background color
        ConstraintLayout mConstraintLayout = (ConstraintLayout)findViewById(R.id.mainConstraintLayout);
        switch (colorPassed){
            case "green":
                mConstraintLayout.setBackgroundResource(R.drawable.bg_green);
                break;
            case "blue":
                mConstraintLayout.setBackgroundResource(R.drawable.bg_blue);
                break;
            case "pink":
                mConstraintLayout.setBackgroundResource(R.drawable.bg_pink);
                break;
            case "teal":
                mConstraintLayout.setBackgroundResource(R.drawable.bg_teal);
                break;
             default:
                mConstraintLayout.setBackgroundResource(R.drawable.bg_orange);
        }
        //set date of entry
        TextView mDate = (TextView)findViewById(R.id.randomDateTextView);
        mDate.setText(datePassed);

        //set note of entry
        TextView mNote = (TextView)findViewById(R.id.randomNoteTextView);
        mNote.setText(notePassed);

        //set image of entry
        ImageView mImage = (ImageView)findViewById(R.id.randomImageView);
        switch (imagePassed){
            case "bird":
                mImage.setImageResource(R.drawable.bird);
                break;
            case "heart":
                mImage.setImageResource(R.drawable.heart);
                break;
            case "happy":
                mImage.setImageResource(R.drawable.happy);
                break;
            default:
                mImage.setImageResource(R.drawable.flower);
        }


    }
}
