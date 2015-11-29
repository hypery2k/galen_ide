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
		Assert.assertNull(result.objects)
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
		Assert.assertTrue("Should read two object definitions, but was " + objects.size, objects.size == 2)
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
			"Should read three object definitions, but was " + objects.size,
			objects.size == 2
		)
		val object1 = objects.get(0)
		val object2 = objects.get(1)
		Assert.assertTrue(
			"Should read one child object definitions, but was " + object2.children.elements.size,
			object2.children.elements.size == 1
		)
		object1.assertObject("navbar", ".navbar-header")
		object2.assertObject("navbar-*", "css", "div.navbar-header")
		object2.children.elements.get(0).assertObject("navbar2", "xpath", "//*[@data-attr=navbar2-header]")
	}

	@Test
	def void shouldLoadMultipleObjectWithIndentMixed() {
		val result = parseHelper.parse('''
			@objects
			  navbar .navbar-header
			  navbar-* #navbar-header
			    navbar2 xpath //*[@data-attr=navbar2-header]
			  navbar3-* #navbar3-header
			  
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

		object1.assertObject("navbar", ".navbar-header")
		object2.assertObject("navbar-*", "xpath //*[@data-attr=navbar-header]")
		object2.children.elements.get(0).assertObject("navbar2-*", "xpath", "//*[@data-attr=navbar2-header]")
		object3.assertObject("navbar3-*", "#navbar3-header")
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
