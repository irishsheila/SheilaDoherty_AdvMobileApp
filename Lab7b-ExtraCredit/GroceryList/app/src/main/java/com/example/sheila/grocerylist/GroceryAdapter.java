package com.example.sheila.grocerylist;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.ListAdapter;
import android.widget.TextView;

import io.realm.OrderedRealmCollection;
import io.realm.RealmBaseAdapter;

/**
 * Created by Sheila on 4/18/18.
 */

public class GroceryAdapter extends RealmBaseAdapter<Groceries> implements ListAdapter {
    private GroceryListActivity activity;

    private static class ViewHolder{
        TextView groceryName;
        TextView categoryName;
        CheckBox hasBought;
    }

    GroceryAdapter(GroceryListActivity activity, OrderedRealmCollection<Groceries> data){
        super(data);
        this.activity = activity;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent){
        ViewHolder viewHolder;

        if(convertView == null){
            convertView = LayoutInflater.from(parent.getContext()).inflate(R.layout.grocery_list_row, parent, false);
            viewHolder = new ViewHolder();
            viewHolder.groceryName = (TextView)convertView.findViewById(R.id.groceryTextView);
            viewHolder.categoryName = (TextView)convertView.findViewById(R.id.categoryTextView);
            viewHolder.hasBought = (CheckBox)convertView.findViewById(R.id.checkBox);
            viewHolder.hasBought.setOnClickListener(listener);
            convertView.setTag(viewHolder);
        }else{
            viewHolder = (ViewHolder)convertView.getTag();
        }
        if (adapterData != null) {
            Groceries grocery = (Groceries) adapterData.get(position); //not sure about this?
            viewHolder.groceryName.setText(grocery.getGrocery_item());
            viewHolder.categoryName.setText(grocery.getGrocery_category());
            viewHolder.hasBought.setChecked(grocery.hasBought());
            viewHolder.hasBought.setTag(position);
        }
        return convertView;
    }


    private View.OnClickListener listener = new View.OnClickListener() {
        @Override
        public void onClick(View view) {
            int position = (Integer) view.getTag();
            if (adapterData != null) {
                Groceries grocery = adapterData.get(position);
                activity.changeFoodBought(grocery.getId());
            }
        }
    };
}
