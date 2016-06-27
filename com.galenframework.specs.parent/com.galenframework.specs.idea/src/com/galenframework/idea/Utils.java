package com.galenframework.idea;

import java.util.List;

import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import com.galenframework.idea.lang.SpecsLanguage;
import com.intellij.ide.plugins.IdeaPluginDescriptor;
import com.intellij.ide.plugins.PluginManager;
import com.intellij.openapi.extensions.PluginId;
import com.intellij.openapi.fileEditor.FileEditorManager;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.util.text.StringUtil;
import com.intellij.openapi.vfs.VfsUtilCore;
import com.intellij.openapi.vfs.VirtualFile;
import com.intellij.psi.FileViewProvider;
import com.intellij.psi.PsiFile;
import com.intellij.psi.PsiManager;

/**
 * 
 * {@link Utils} class that contains various methods.
 * @author hypery2k
 *
 */
public class Utils {
	/** Private constructor to prevent creating {@link Utils} instance. */
    private Utils() {
    }

    /**
     * Gets relative path of given @{link VirtualFile} and root directory.
     *
     * @param directory root directory
     * @param file      file to get it's path
     * @return relative path
     */
    @Nullable
    public static String getRelativePath(@NotNull VirtualFile directory, @NotNull VirtualFile file) {
        return VfsUtilCore.getRelativePath(file, directory, '/') + (file.isDirectory() ? '/' : "");
    }

    /**
     * Opens given file in editor.
     *
     * @param project current project
     * @param file    file to open
     */
    public static void openFile(@NotNull Project project, @NotNull PsiFile file) {
        openFile(project, file.getVirtualFile());
    }

    /**
     * Opens given file in editor.
     *
     * @param project current project
     * @param file    file to open
     */
    public static void openFile(@NotNull Project project, @NotNull VirtualFile file) {
        FileEditorManager.getInstance(project).openFile(file, true);
    }

    /**
     * Returns Gitignore plugin information.
     *
     * @return {@link IdeaPluginDescriptor}
     */
    public static IdeaPluginDescriptor getPlugin() {
        return PluginManager.getPlugin(PluginId.getId(GalenBundle.PLUGIN_ID));
    }

    /**
     * Returns plugin major version.
     *
     * @return major version
     */
    public static String getMajorVersion() {
        return getVersion().split("\\.")[0];
    }

    /**
     * Returns plugin minor version.
     *
     * @return minor version
     */
    public static String getMinorVersion() {
        return StringUtil.join(getVersion().split("\\."), 0, 2, ".");
    }

    /**
     * Returns plugin version.
     *
     * @return version
     */
    public static String getVersion() {
        return getPlugin().getVersion();
    }

    /**
     * Checks if lists are equal.
     *
     * @param l1 first list
     * @param l2 second list
     * @return lists are equal
     */
    public static boolean equalLists(@NotNull List<?> l1, @NotNull List<?> l2) {
        return l1.size() == l2.size() && l1.containsAll(l2) && l2.containsAll(l1);
    }

    /**
     * Checks if file is under given directory.
     *
     * @param file      file
     * @param directory directory
     * @return file is under directory
     */
    public static boolean isUnder(@NotNull VirtualFile file, @NotNull VirtualFile directory) {
        VirtualFile parent = file.getParent();
        while (parent != null) {
            if (directory.equals(parent)) {
                return true;
            }
            parent = parent.getParent();
        }
        return false;
    }

    /**
     * Checks if file is in project directory.
     *
     * @param file    file
     * @param project project
     * @return file is under directory
     */
    public static boolean isInProject(@NotNull final VirtualFile file, @NotNull final Project project) {
        return project.getBaseDir() != null && (isUnder(file, project.getBaseDir()) ||
                StringUtil.startsWith(file.getUrl(), "temp://"));
    }
}
