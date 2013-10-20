package com.example.modernear;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;

public class MainActivity extends Activity {

	protected static final String TAG = "MainActivity";
	// Your Facebook APP ID
	//private static String APP_ID = "308180782571605"; // Replace your App ID here
//	// Instance of Facebook Class
//	private Facebook facebook;
//	private AsyncFacebookRunner mAsyncRunner;
//	String FILENAME = "AndroidSSO_data";
//	private SharedPreferences mPrefs;
	Button btnLogin;
	Button login_btn_fb;
	EditText editTxtLoginUS;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

//		facebook = new Facebook(APP_ID);
//		mAsyncRunner = new AsyncFacebookRunner(facebook);
//
		btnLogin = (Button) findViewById(R.id.login_btn);
//		btnFbLogin.setOnClickListener(new View.OnClickListener() {
//
//			@Override
//			public void onClick(View v) {
//				loginToFacebook();
//
//			}
//		});
		editTxtLoginUS = (EditText) findViewById(R.id.firstname);
		btnLogin.setOnClickListener(new  OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Log.i(TAG, "---------: " + btnLogin.getText());
				Log.i(TAG, "---------editTxtLoginUS: " + editTxtLoginUS.getText());
				//editTxtLoginUS.getText(); //TODO: to save the entered text from edit text
				
				Intent myIntent = new Intent(MainActivity.this, MapMainActivity.class);
				myIntent.putExtra("key", editTxtLoginUS.getText()); //Optional parameters
				MainActivity.this.startActivity(myIntent);
				
				
				
			}
		});
		login_btn_fb = (Button) findViewById(R.id.login_btn_fb);
		login_btn_fb.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Intent myIntent = new Intent(MainActivity.this, MapLocations.class);
				myIntent.putExtra("key", editTxtLoginUS.getText()); //Optional parameters
				MainActivity.this.startActivity(myIntent);
				
			}
		});
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

	public void onGetClick(View v) 
	{
		EditText textView = (EditText)findViewById(R.id.firstname);
		new HttpGetDemo().execute(textView);    	
	}
	
	public void onPostClick(View v) 
	{
	///TextView textView = (TextView)findViewById(R.id.viewText1);
		//new HttpPostDemo().execute(textView); 
	}
	
//	@SuppressWarnings("deprecation")
//	public void loginToFacebook() {
//		mPrefs = getPreferences(MODE_PRIVATE);
//		String access_token = mPrefs.getString("access_token", null);
//		long expires = mPrefs.getLong("access_expires", 0);
//
//		if (access_token != null) {
//			facebook.setAccessToken(access_token);
//		}
//
//		if (expires != 0) {
//			facebook.setAccessExpires(expires);
//		}
//
//		if (!facebook.isSessionValid()) {
//			facebook.authorize(this,
//					new String[] { "email", "publish_stream" },
//					new DialogListener() {
//
//						@Override
//						public void onCancel() {
//							// Function to handle cancel event
//						}
//
//						@Override
//						public void onComplete(Bundle values) {
//							// Function to handle complete event
//							// Edit Preferences and update facebook acess_token
//							SharedPreferences.Editor editor = mPrefs.edit();
//							editor.putString("access_token",
//									facebook.getAccessToken());
//							editor.putLong("access_expires",
//									facebook.getAccessExpires());
//							editor.commit();
//						}
//
//						@Override
//						public void onFacebookError(FacebookError e) {
//							// TODO Auto-generated method stub
//
//						}
//
//						@Override
//						public void onError(DialogError e) {
//							// TODO Auto-generated method stub
//
//						}
//
//					});
//		}
//	}

}
