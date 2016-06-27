package com.galenframework.idea;

import org.jetbrains.annotations.NotNull;

import com.intellij.openapi.application.ApplicationManager;
import com.intellij.openapi.components.ApplicationComponent;

/**
 * 
 * @author hypery2k
 *
 */
public class SpecsApplicationComponent implements ApplicationComponent {
	/** Plugin has been updated with the current run. */
	private boolean updated;

	/** Plugin update notification has been shown. */
	private boolean updateNotificationShown;

	/**
	 * Get Specs Application Component
	 *
	 * @return Specs Application Component
	 */
	@NotNull
	public static SpecsApplicationComponent getInstance() {
		return ApplicationManager.getApplication().getComponent(SpecsApplicationComponent.class);
	}

	@Override
	public void initComponent() {
	}

	@Override
	public void disposeComponent() {
	}

	@Override
	public String getComponentName() {
		return "SpecsApplicationComponent";
	}

	/**
	 * Checks if plugin was updated in the current run.
	 *
	 * @return plugin was updated
	 */
	public boolean isUpdated() {
		return updated;
	}

	/**
	 * Checks if update notification was shown.
	 *
	 * @return notification shown
	 */
	public boolean isUpdateNotificationShown() {
		return updateNotificationShown;
	}

    /**
     * Sets update notification shown status.
     *
     * @param shown notification
     */
    public void setUpdateNotificationShown(boolean shown) {
        this.updateNotificationShown = shown;
    }

}
