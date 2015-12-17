package com.galenframework.tests;

import org.eclipse.xtext.junit4.InjectWith;
import org.eclipselabs.xtext.utils.unittesting.XtextRunner2;
import org.eclipselabs.xtext.utils.unittesting.XtextTest;
import org.junit.Test;
import org.junit.runner.RunWith;

@InjectWith(SpecInjectorProvider.class)
@RunWith(XtextRunner2.class)
public class GSpecDataTest extends XtextTest {

	public GSpecDataTest() {
		super("GSpecDataTest");
	}
	
	@Test
	public void testSimple1() {
		testFile("simple1.gspec");
	}
	
	@Test
	public void testSimpleIndentation1() {
		testFile("simpleIndentation1.gspec");
	}
}
