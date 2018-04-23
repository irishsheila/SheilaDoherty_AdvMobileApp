package com.example.sheila.grocerylist;

import android.content.DialogInterface;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ListView;
import java.util.UUID;
import io.realm.Realm;
import io.realm.RealmResults;

public class GroceryListActivity extends AppCompatActivity {
    private Realm realm;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_grocery_list);
        realm = Realm.getDefaultInstance(); //get realm instance
        final RealmResults<Groceries> groceries = realm.where(Groceries.class).findAll();
        final GroceryAdapter adapter = new GroceryAdapter(this, groceries);
        ListView listView = (ListView) findViewById(R.id.grocery_list);
        listView.setAdapter(adapter);
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                LinearLayout layout = new LinearLayout(GroceryListActivity.this);
                layout.setOrientation(LinearLayout.VERTICAL);
                final Groceries grocery = (Groceries) adapterView.getAdapter().getItem(i);
                //create edit texts & add to layout
                final EditText groceryEditText = new EditText(GroceryListActivity.this);
                groceryEditText.setText(grocery.getGrocery_item());
                layout.addView(groceryEditText);
                final EditText categoryEditText = new EditText(GroceryListActivity.this);
                categoryEditText.setText(grocery.getGrocery_category());
                layout.addView(categoryEditText);
                AlertDialog.Builder dialog = new AlertDialog.Builder(GroceryListActivity.this);
                dialog.setTitle("Edit Food");
                dialog.setView(layout);
                dialog.setPositiveButton("Save", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int i) {
                        //save edited food
                        final String updatedFoodItem = groceryEditText.getText().toString();
                        final String updatedCategoryItem = categoryEditText.getText().toString();
                        if(!updatedFoodItem.isEmpty()){
                            changeFood(grocery.getId(), updatedFoodItem,updatedCategoryItem);
                        }

                    }
                });
                dialog.setNegativeButton("Delete", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int i) {
                        //delete food
                        deleteFood(grocery.getId());
                    }
                });
                dialog.create();
                dialog.show();
            }
        });

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                //create a vertical linear layout to hold edit texts
                LinearLayout layout = new LinearLayout(GroceryListActivity.this);
                layout.setOrientation(LinearLayout.VERTICAL);
                //create edit texts and add to layout
                final EditText foodEditText = new EditText(GroceryListActivity.this);
                foodEditText.setHint("Food Item");
                layout.addView(foodEditText);
                final EditText categoryEditText = new EditText(GroceryListActivity.this);
                categoryEditText.setHint("Grocery Category");
                layout.addView(categoryEditText);

                //create alert dialog
                AlertDialog.Builder dialog = new AlertDialog.Builder(GroceryListActivity.this);
                dialog.setTitle("Add Food Item");
                dialog.setView(layout);
                dialog.setPositiveButton("Save", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        //get book name entered
                        final String newGroceryItem = foodEditText.getText().toString();
                        final String newGroceryCategory = categoryEditText.getText().toString();

                        if(!newGroceryItem.isEmpty()) {
                            //start realm write transaction
                            realm.executeTransactionAsync(new Realm.Transaction() {
                                @Override
                                public void execute(Realm realm) {
                                    //create a realm object
                                    Groceries newfood = realm.createObject(Groceries.class, UUID.randomUUID().toString());
                                    newfood.setGrocery_item(newGroceryItem);
                                    newfood.setGrocery_category(newGroceryCategory);
                                }
                            });
                        }
                    }
                });
                dialog.setNegativeButton("Cancel", null);
                dialog.show();
            }
        });

    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        //close the Realm instance when the Activity exits
        realm.close();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_grocery_list, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    public void changeFoodBought (final String foodId){
        realm.executeTransactionAsync(new Realm.Transaction() {
            @Override
            public void execute(Realm realm) {
                Groceries grocery = realm.where(Groceries.class).equalTo("id", foodId).findFirst();
                grocery.setFood_found(!grocery.hasBought());;
            }
        });
    }

    public void changeFood (final String foodId, final String food_item, final String category_name){
        realm.executeTransactionAsync(new Realm.Transaction() {
            @Override
            public void execute(Realm realm) {
                Groceries grocery = realm.where(Groceries.class).equalTo("id", foodId).findFirst();
                grocery.setGrocery_item(food_item);
                grocery.setGrocery_category(category_name);
            }
        });
    }

    public void deleteFood(final String foodId){
        realm.executeTransactionAsync(new Realm.Transaction() {
            @Override
            public void execute(Realm realm) {
                realm.where(Groceries.class).equalTo("id", foodId)
                        .findFirst()
                        .deleteFromRealm();
            }
        });
    }
}
