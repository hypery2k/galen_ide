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

@RunWith(XtextRunner)
@InjectWith(SpecInjectorProvider)
class ObjectsDefinitionParsingTest {

	@Inject
	ParseHelper<Model> parseHelper;

	@Test
	def void loadOneObjectWithComment() {
		val result = parseHelper.parse('''
			# objects
			@objects
			  navbar  .navbar-header
		''')
		Assert.assertNotNull(result)
		Assert.assertNotNull(result.objectSection.objects)
		val objects = result.objectSection.objects.elements
		Assert.assertTrue("Should read one object definition, but was " + objects.size, objects.size == 1)
		val object = objects.get(0)
		Assert.assertTrue("Should read CSS selector type, but was " + object.selector,
			object.selector.equalsIgnoreCase(".navbar-header"))
	}

	@Test
	def void loadOneObjectWithoutType() {
		val result = parseHelper.parse('''
			@objects
			  navbar  .navbar-header
		''')
		Assert.assertNotNull(result)
		Assert.assertNotNull(result.objectSection.objects)
		val objects = result.objectSection.objects.elements
		Assert.assertTrue("Should read one object definition, but was " + objects.size, objects.size == 1)
		val object = objects.get(0)
		Assert.assertTrue("Should read CSS selector type, but was " + object.selector,
			object.selector.equalsIgnoreCase(".navbar-header"))
	}

	@Test
	def void loadOneObjectWithType() {
		val result = parseHelper.parse('''
			@objects
			  navbar css .navbar-header
		''')
		Assert.assertNotNull(result)
		Assert.assertNotNull(result.objectSection.objects)
		val objects = result.objectSection.objects.elements
		Assert.assertTrue("Should read one object definition, but was " + objects.size, objects.size == 1)
		val object = objects.get(0)
		Assert.assertTrue("Should read CSS selector type, but was " + object.selector,
			object.selector.equalsIgnoreCase(".navbar-header"))
	}

	@Test
	def void loadMultipleObject2() {
		val result = parseHelper.parse('''
			@objects
			  navbar css .navbar-header
			  navbar2 xpath //*[@data-attr=navbar-header]
			  navbar-* #navbar-header
		''')
		Assert.assertNotNull(result)
		Assert.assertNotNull(result.objectSection.objects)
		val objects = result.objectSection.objects.elements
		Assert.assertTrue(
			"Should read three object definitions, but was " + objects.size,
			objects.size == 3
		)
		val object1 = objects.get(0)
		val object2 = objects.get(1)
		val object3 = objects.get(2)
		Assert.assertTrue("Should read default selector , but was " + object1.selector,
			object1.selector.equalsIgnoreCase(".navbar-header"))
		Assert.assertTrue("Should read selector value, but was " + object2.selector,
			object2.selector.equalsIgnoreCase("//*[@data-attr=navbar-header]"))
		Assert.assertTrue("Should read selector value, but was " + object3.selector,
			object3.selector.equalsIgnoreCase("#navbar-header"))
	}

	@Test
	def void loadMultipleObject() {
		val result = parseHelper.parse('''
			@objects
			  navbar .navbar-header
			  body  body
			  navbar2 xpath //*[@data-attr=navbar-header]
			  navbar-* #navbar-header
		''')
		Assert.assertNotNull(result)
		Assert.assertNotNull(result.objectSection.objects)
		val objects = result.objectSection.objects.elements
		Assert.assertTrue(
			"Should read four object definitions, but was " + objects.size,
			objects.size == 4
		)
		val object1 = objects.get(0)
		val object2 = objects.get(1)
		val object3 = objects.get(2)
		val object4 = objects.get(3)
		Assert.assertTrue("Should read default selector , but was " + object1.selector,
			object1.selector.equalsIgnoreCase(".navbar-header"))
		Assert.assertTrue("Should read selector value, but was " + object2.selector,
			object2.selector.equalsIgnoreCase("body"))
		Assert.assertTrue("Should read selector value, but was " + object3.selector,
			object3.selector.equalsIgnoreCase("//*[@data-attr=navbar-header]"))
		Assert.assertTrue("Should read selector value, but was " + object4.selector,
			object4.selector.equalsIgnoreCase("#navbar-header"))
	}

	@Test
	def void loadMultipleObjectWithIndent() {
		val result = parseHelper.parse('''
			@objects
			  navbar .navbar-header
			  navbar-* #navbar-header
			    navbar2 xpath //*[@data-attr=navbar-header]
			  navbar-* #navbar-header
		''')
		Assert.assertNotNull(result)
		Assert.assertNotNull(result.objectSection.objects)
		val objects = result.objectSection.objects.elements
		Assert.assertTrue(
			"Should read four object definitions, but was " + objects.size,
			objects.size == 4
		)
		val object1 = objects.get(0)
		val object2 = objects.get(1)
		val object3 = objects.get(2)
		Assert.assertTrue("Should read default selector , but was " + object1.selector,
			object1.selector.equalsIgnoreCase(".navbar-header"))
		Assert.assertTrue("Should read selector value, but was " + object2.selector,
			object2.selector.equalsIgnoreCase("xpath //*[@data-attr=navbar-header]"))
	}

}
