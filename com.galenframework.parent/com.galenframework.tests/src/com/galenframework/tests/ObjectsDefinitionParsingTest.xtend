/*
 * generated by Xtext 2.9.0.beta5
 */
package com.galenframework.tests

import com.galenframework.spec.Model
import com.google.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import com.galenframework.spec.Element

@RunWith(XtextRunner)
@InjectWith(SpecInjectorProvider)
class ObjectsDefinitionParsingTest {

	@Inject
	ParseHelper<Model> parseHelper;

	// NEGATIVE TESTS
	@Test
	def void shouldNotloadObjectFromEmptyObjectDefinition() {
		val result = parseHelper.parse('''
			# objects
			@objects
		''')
		Assert.assertNotNull(result)
		Assert.assertNotNull(result.objects)
		val objects = result.objects.elements
		Assert.assertTrue("Should read no object definition, but was " + objects.size, objects.size == 0)
	}

	@Test
	def void shouldNotLoadAllObjectWithMixedIndentation() {
		val result = parseHelper.parse('''
			@objects
			   navbar  .navbar-header
			  navbar  .navbar-header
			  	 navbar  .navbar-header
		''')
		Assert.assertNotNull(result)
		Assert.assertNotNull(result.objects)
		val objects = result.objects.elements
		objects.get(0).assertObject("navbar", ".navbar-header")
		Assert.assertTrue("Should read one object definitions, but was " + objects.size, objects.size == 1)
	}

	// POSITIVE TESTS	
	@Test
	def void shouldParsePartlyModels() {
		val result = parseHelper.parse('''
			# objects
			@objects
			test
		''')
		Assert.assertNotNull(result)
		Assert.assertNotNull(result.objects)
		val objects = result.objects.elements
		Assert.assertTrue("Should read object name 'test' but was" + objects.get(0).name,
			objects.get(0).name.equalsIgnoreCase("test"))
	}

	@Test
	def void shouldLoadOneObjectWithComment() {
		val result = parseHelper.parse('''
			# objects
			@objects
			  navbar  .navbar-header
		''')
		Assert.assertNotNull(result)
		Assert.assertNotNull(result.objects)
		val objects = result.objects.elements
		Assert.assertTrue("Should read one object definition, but was " + objects.size, objects.size == 1)
		objects.get(0).assertObject("navbar", ".navbar-header")
	}

	@Test
	def void shouldLoadOneObjectWithoutType() {
		val result = parseHelper.parse('''
			@objects
			  navbar  .navbar-header
		''')
		Assert.assertNotNull(result)
		Assert.assertNotNull(result.objects)
		val objects = result.objects.elements
		Assert.assertTrue("Should read one object definition, but was " + objects.size, objects.size == 1)
		objects.get(0).assertObject("navbar", ".navbar-header")
	}

	@Test
	def void shouldLoadOneObjectWithType() {
		val result = parseHelper.parse('''
			@objects
			  navbar css .navbar-header
		''')
		Assert.assertNotNull(result)
		Assert.assertNotNull(result.objects)
		val objects = result.objects.elements
		Assert.assertTrue("Should read one object definition, but was " + objects.size, objects.size == 1)
		objects.get(0).assertObject("navbar", "css", ".navbar-header")
	}

	@Test
	def void shouldLoadMultipleObject2() {
		val result = parseHelper.parse('''
			@objects
			  navbar css .navbar-header
			  navbar2 xpath //*[@data-attr=navbar-header]
			  navbar-* #navbar-header
		''')
		Assert.assertNotNull(result)
		Assert.assertNotNull(result.objects)
		val objects = result.objects.elements
		Assert.assertTrue(
			"Should read three object definitions, but was " + objects.size,
			objects.size == 3
		)
		objects.get(0).assertObject("navbar", "css", ".navbar-header")
		objects.get(1).assertObject("navbar2", "xpath", "//*[@data-attr=navbar-header]")
		objects.get(2).assertObject("navbar-*", "#navbar-header")
	}

	@Test
	def void shouldLoadMultipleObject() {
		val result = parseHelper.parse('''
			@objects
			  navbar .navbar-header
			  body  body
			  navbar2 xpath //*[@data-attr=navbar-header]
			  navbar-* #navbar-header
		''')
		Assert.assertNotNull(result)
		Assert.assertNotNull(result.objects)
		val objects = result.objects.elements
		Assert.assertTrue(
			"Should read four object definitions, but was " + objects.size,
			objects.size == 4
		)
		objects.get(0).assertObject("navbar", ".navbar-header")
		objects.get(1).assertObject("body", "body")
		objects.get(2).assertObject("navbar2", "xpath", "//*[@data-attr=navbar-header]")
		objects.get(3).assertObject("navbar-*", "#navbar-header")
	}

	@Test
	def void shouldLoadMultipleObjectWithIndent() {
		// given then
		val result = parseHelper.parse('''
			@objects
			  navbar .navbar-header
			  navbar-* css div.navbar-header
			    navbar2 xpath //*[@data-attr=navbar2-header]
			  
		''')
		// then
		Assert.assertNotNull(result)
		Assert.assertNotNull(result.objects)
		val objects = result.objects.elements
		Assert.assertTrue(
			"Should read two object definitions, but was " + objects.size,
			objects.size == 2
		)
		val object1 = objects.get(0)
		val object2 = objects.get(1)
		Assert.assertTrue(
			"Should read one child object definitions, but was " + object2.children.size,
			object2.children.size == 1
		)
		object1.assertObject("navbar", ".navbar-header")
		object2.assertObject("navbar-*", "css", "div.navbar-header")
		object2.children.get(0).assertObject("navbar2", "xpath", "//*[@data-attr=navbar2-header]")
	}

	@Test
	def void shouldLoadMultipleObjectWithIndentMixedAndNestedChilds() {
		val result = parseHelper.parse('''
			@objects
			  navbar1 .navbar-header
			  navbar2 #navbar-header
			    navbar21 xpath //*[@data-attr=navbar2-header]
				  navbar211 xpath //*[@data-attr=navbar3-header]
			    navbar22 xpath //*[@data-attr=navbar3-header]
			  navbar4-* #navbar3-header
			  
		''')
		Assert.assertNotNull(result)
		Assert.assertNotNull(result.objects)
		val objects = result.objects.elements
		Assert.assertTrue(
			"Should three object definitions, but was " + objects.size,
			objects.size == 3
		)
		val object1 = objects.get(0)
		val object2 = objects.get(1)
		val object3 = objects.get(2)
		Assert.assertTrue(
			"Should read two child object definitions, but was " + object2.children.size,
			object2.children.size == 2
		)
		Assert.assertTrue(
			"Should read one sub-child object definitions, but was " + object2.children.get(0).children.size,
			object2.children.get(0).children.size == 1
		)
		object1.assertObject("navbar1", ".navbar-header")
		object2.assertObject("navbar2", "#navbar-header")
		object2.children.get(0).assertObject("navbar21", "xpath", "//*[@data-attr=navbar2-header]")
		object2.children.get(0).children.get(0).assertObject("navbar211", "xpath", "//*[@data-attr=navbar3-header]")
		object2.children.get(1).assertObject("navbar22", "xpath", "//*[@data-attr=navbar3-header]")
		object3.assertObject("navbar4-*", "#navbar3-header")
	}

	@Test
	def void shouldLoadMultipleObjectWithComplexLocators() {
		// given, when
		val result = parseHelper.parse('''
			@objects
			    navbar css .navbar-header
			    navbar-item-*		css .navbar-collapse .nav li
			    menubar-left		.sidebar-left
			    header 			//*[@data-attr=navbar2-header]
			    content			.bs-docs-container
			    header-container	.bs-docs-header .container
			    bootstrap-logo		span.bs-docs-booticon
			     
		''')
		// then
		Assert.assertNotNull(result)
		Assert.assertNotNull(result.objects)
		val objects = result.objects.elements
		Assert.assertTrue(
			"Should 7 object definitions, but was " + objects.size,
			objects.size == 7
		)
		objects.get(0).assertObject("navbar", "css", ".navbar-header")
		objects.get(1).assertObject("navbar-item-*", ".navbar-collapse .nav li")
	}
	

	// HELPER
	def void assertObject(Element element, String name, String selector, String selectorValue) {
		Assert.assertTrue("Should read name '" + name + "', but was " + element.name,
			element.name.equalsIgnoreCase(name))
		if (selector != null) {
			Assert.assertTrue("Should read selector '" + selector + "', but was " + element.type,
				element.type.equalsIgnoreCase(selector))
		}
		Assert.assertTrue("Should read selector value'" + selectorValue + "', but was " + element.selector,
			element.selector.equalsIgnoreCase(selectorValue))
	}

	def void assertObject(Element element, String name, String selectorValue) {
		element.assertObject(name, null, selectorValue)
	}

}
