package com.galenframework.tests;

import org.eclipse.xtext.junit4.InjectWith;
import com.itemis.xtext.testing.XtextRunner2;
import com.itemis.xtext.testing.XtextTest;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;

@InjectWith(SpecsInjectorProvider.class)
@RunWith(XtextRunner2.class)
@Ignore
public class GSpecDataTest extends XtextTest {

	public GSpecDataTest() {
		super("GSpecDataTest");
	}

    @Before
    public final void before() {
    	super._before();
    	ignoreOsSpecificNewline();
    }

	@Test
	public void simple1() {
		testFile("simple1.gspec");
	}
	
	@Test
	public void complex1() {
		testFile("complex1.gspec");
	}

	@Test
	public void simpleIndentation1() {
		testFile("simpleIndentation1.gspec");
	}
}
