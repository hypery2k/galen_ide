package com.galenframework.idea;

import com.intellij.notification.Notification;
import com.intellij.notification.NotificationDisplayType;
import com.intellij.notification.NotificationGroup;
import com.intellij.notification.NotificationListener;
import com.intellij.notification.NotificationType;
import com.intellij.notification.Notifications;
import com.intellij.openapi.components.ProjectComponent;

/**
 * 
 * {@link ProjectComponent} instance to display plugin's update information.
 * @author hypery2k
 *
 */
public class UpdateComponent implements ProjectComponent {
    /** {@link IgnoreApplicationComponent} instance. */
    private SpecsApplicationComponent application;

	@Override
	public void initComponent() {
        application = SpecsApplicationComponent.getInstance();

	}

	@Override
	public void disposeComponent() {}

	@Override
	public String getComponentName() {
        return "UpdateComponent";
	}

	@Override
	public void projectOpened() {

        if (application.isUpdated() && !application.isUpdateNotificationShown()) {
            application.setUpdateNotificationShown(true);
            NotificationGroup group = new NotificationGroup("IGNORE_GROUP", NotificationDisplayType.STICKY_BALLOON, true);
            Notification notification = group.createNotification(
            		GalenBundle.message("update.title", Utils.getVersion()),
            		GalenBundle.message("update.content"),
                    NotificationType.INFORMATION,
                    NotificationListener.URL_OPENING_LISTENER
            );
            Notifications.Bus.notify(notification);
        }
	}

	@Override
	public void projectClosed() {

	}

}
