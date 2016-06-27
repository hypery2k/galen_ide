package com.galenframework.idea;

import java.util.ResourceBundle;

import com.intellij.CommonBundle;
import org.jetbrains.annotations.NonNls;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.PropertyKey;

public class GalenBundle {

    /** The {@link ResourceBundle} path. */
    @NonNls
    private static final String BUNDLE_NAME = "messages.GalenBundle";

    /** The {@link ResourceBundle} instance. */
    @NotNull
    private static final ResourceBundle BUNDLE = ResourceBundle.getBundle(BUNDLE_NAME);

	public static final String PLUGIN_ID = "com.galenframework.specs.idea";


    /**
     * Loads a {@link String} from the {@link #BUNDLE} {@link ResourceBundle}.
     *
     * @param key    the key of the resource
     * @param params the optional parameters for the specific resource
     * @return the {@link String} value or {@code null} if no resource found for the key
     */
    public static String message(@PropertyKey(resourceBundle = BUNDLE_NAME) String key, Object... params) {
        return CommonBundle.message(BUNDLE, key, params);
    }

    /**
     * Loads a {@link String} from the {@link #BUNDLE} {@link ResourceBundle}.
     *
     * @param key          the key of the resource
     * @param defaultValue the default value that will be returned if there is nothing set
     * @param params       the optional parameters for the specific resource
     * @return the {@link String} value or {@code null} if no resource found for the key
     */
    public static String messageOrDefault(@PropertyKey(resourceBundle = BUNDLE_NAME) String key, String defaultValue,
                                          Object... params) {
        return CommonBundle.messageOrDefault(BUNDLE, key, defaultValue, params);
    }
}
