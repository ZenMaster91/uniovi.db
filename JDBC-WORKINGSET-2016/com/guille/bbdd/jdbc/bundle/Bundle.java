package com.guille.bbdd.jdbc.bundle;

import java.util.MissingResourceException;
import java.util.ResourceBundle;

public class Bundle {
	
	private static final String BUNDLE_NAME = "com.guille.bbdd.jdbc.bundle.Desa.properties";
	private static final ResourceBundle RESOURCE_BUNDLE = ResourceBundle.getBundle(BUNDLE_NAME);

	private Bundle() {}

	public static String getString(String key) {
		try {
			return RESOURCE_BUNDLE.getString(key);
		} catch (MissingResourceException e) {
			return '!' + key + '!';
		}
	}
}
