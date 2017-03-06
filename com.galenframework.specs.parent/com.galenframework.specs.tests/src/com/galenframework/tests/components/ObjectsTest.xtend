
package com.galenframework.tests.components

import com.galenframework.specs.Model
import com.google.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.junit.Test
import org.junit.runner.RunWith

import static org.junit.Assert.*
import com.galenframework.specs.Element
import com.galenframework.specs.XpathSelector
import com.galenframework.specs.CssSelector
import com.galenframework.specs.IdSelector
import com.galenframework.tests.SpecsInjectorProvider

@RunWith(XtextRunner)
@InjectWith(SpecsInjectorProvider)
class ObjectsTest {

	@Inject
	ParseHelper<Model> parseHelper;

	// NEGATIVE TESTS

	@Test
	def void shouldNotLoadAllObjectWithMixedIndentation() {
		val result = parseHelper.parse('''
			@objects
			   navbar  .navbar-header
			  navbar  .navbar-header
			  	 navbar  .navbar-header
		''')
		assertNotNull(result)
		assertNotNull(result.objects.elements)
		val objects = result.objects.elements
		objects.get(0).assertObject("navbar", ".navbar-header")
		assertTrue("Should read one object definitions, but was " + objects.size, objects.size == 1)
	}

	// POSITIVE TESTS	
	@Test
	def void shouldLoadObjectFromEmptyObjectDefinition() {
		val result = parseHelper.parse('''
			# objects
			@objects
		''')
		assertNotNull(result)
		assertNull(result.objects)
	}
	@Test
	def void shouldParsePartlyModels() {
		val result = parseHelper.parse('''
			# objects
			@objects
			test
		''')
		assertNotNull(result)
		assertNotNull(result.objects.elements)
		val objects = result.objects.elements
		assertTrue("Should read object name 'test' but was" + objects.get(0).name,
			objects.get(0).name.equalsIgnoreCase("test"))
	}

	@Test
	def void shouldLoadOneObjectWithComment() {
		val result = parseHelper.parse('''
			# objects
			@objects
			  navbar  .navbar-header
		''')
		assertNotNull(result)
		assertNotNull(result.objects.elements)
		val objects = result.objects.elements
		assertTrue("Should read one object definition, but was " + objects.size, objects.size == 1)
		objects.get(0).assertObject("navbar", ".navbar-header")
	}

	@Test
	def void shouldLoadCssSelectorWithoutType() {
		val result = parseHelper.parse('''
			@objects
			  navbar  .navbar-header
		''')
		assertNotNull(result)
		assertNotNull(result.objects.elements)
		val objects = result.objects.elements
		assertTrue("Should read one object definition, but was " + objects.size, objects.size == 1)
		objects.get(0).assertObject("navbar", ".navbar-header")
	}

	@Test
	def void shouldLoadIdSelector() {
		val result = parseHelper.parse('''
			@objects
			  navbar  id  123
		''')
		assertNotNull(result)
		assertNotNull(result.objects.elements)
		val objects = result.objects.elements
		assertTrue("Should read one object definition, but was " + objects.size, objects.size == 1)
		objects.get(0).assertObject("navbar", "id", "123")
	}

	@Test
	def void shouldLoadCssSelectorWithID() {
		val result = parseHelper.parse('''
			@objects
			  navbar  css  #id
		''')
		assertNotNull(result)
		assertNotNull(result.objects.elements)
		val objects = result.objects.elements
		assertTrue("Should read one object definition, but was " + objects.size, objects.size == 1)
		objects.get(0).assertObject("navbar", "css", "#id")
	}

	@Test
	def void shouldLoadCssSelector() {
		val result = parseHelper.parse('''
			@objects
			  navbar  css  .navbar-header
		''')
		assertNotNull(result)
		assertNotNull(result.objects.elements)
		val objects = result.objects.elements
		assertTrue("Should read one object definition, but was " + objects.size, objects.size == 1)
		objects.get(0).assertObject("navbar", "css", ".navbar-header")
	}

	@Test
	def void shouldLoadCssSelectorComplexWithHtmlTag() {
		val result = parseHelper.parse('''
			@objects
			  navbar  css  body.navbar-header
			  navbar  css  div > .navbar-header
			  navbar  css  div .navbar-header
		''')
		assertNotNull(result)
		assertNotNull(result.objects.elements)
		val objects = result.objects.elements
		assertTrue("Should read three object definition, but was " + objects.size, objects.size == 3)
		objects.get(0).assertObject("navbar", "css", "body.navbar-header")
		objects.get(1).assertObject("navbar", "css", "div > .navbar-header")
		objects.get(2).assertObject("navbar", "css", "div .navbar-header")
	}

	@Test
	def void shouldLoadCssSelectorComplexWithSubSelect() {
		val result = parseHelper.parse('''
			@objects
			  navbar  css  .navbar-header div
		''')
		assertNotNull(result)
		assertNotNull(result.objects.elements)
		val objects = result.objects.elements
		assertTrue("Should read one object definition, but was " + objects.size, objects.size == 1)
		objects.get(0).assertObject("navbar", "css", ".navbar-header div")
	}

	@Test
	def void shouldLoadXPathSelector() {
		val result = parseHelper.parse('''
			@objects
			  navbar  xpath  //div*
		''')
		assertNotNull(result)
		assertNotNull(result.objects.elements)
		val objects = result.objects.elements
		assertTrue("Should read one object definition, but was " + objects.size, objects.size == 1)
		objects.get(0).assertObject("navbar", "xpath", "//div*")
	}

	@Test
	def void shouldLoadOneObjectWithType() {
		val result = parseHelper.parse('''
			@objects
			  navbar css .navbar-header
		''')
		assertNotNull(result)
		assertNotNull(result.objects.elements)
		val objects = result.objects.elements
		assertTrue("Should read one object definition, but was " + objects.size, objects.size == 1)
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
		assertNotNull(result)
		assertNotNull(result.objects.elements)
		val objects = result.objects.elements
		assertTrue(
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
			  content  body
			  navbar2 xpath //*[@data-attr=navbar-header]
			  navbar-* #navbar-header
		''')
		assertNotNull(result)
		assertNotNull(result.objects.elements)
		val objects = result.objects.elements
		assertTrue(
			"Should read four object definitions, but was " + objects.size,
			objects.size == 4
		)
		objects.get(0).assertObject("navbar", ".navbar-header")
		objects.get(1).assertObject("content", "body")
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
		assertNotNull(result)
		assertNotNull(result.objects.elements)
		val objects = result.objects.elements
		assertTrue(
			"Should read two object definitions, but was " + objects.size,
			objects.size == 2
		)
		val object1 = objects.get(0)
		val object2 = objects.get(1)
		assertTrue(
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
			    navbar21 xpath //*[@data-attr=navbar21-header]
			    navbar22 xpath //*[@data-attr=navbar22-header]
			        navbar221 xpath //*[@data-attr=navbar221-header]
			    navbar31 xpath //*[@data-attr=navbar31-header]
			  navbar4-* #navbar3-header
			  
		''')
		assertNotNull(result)
		assertNotNull(result.objects.elements)
		val objects = result.objects.elements
		assertTrue(
			"Should three object definitions, but was " + objects.size,
			objects.size == 3
		)
		val object1 = objects.get(0)
		val object2 = objects.get(1)
		val object3 = objects.get(2)
		assertTrue(
			"Should three two child object definitions, but was " + object2.children.size,
			object2.children.size == 3
		)
		assertTrue(
			"Should read one sub-child object definitions, but was " + object2.children.get(1).children.size,
			object2.children.get(1).children.size == 1
		)
		object1.assertObject("navbar1", ".navbar-header")
		object2.assertObject("navbar2", "#navbar-header")
		object2.children.get(0).assertObject("navbar21", "xpath", "//*[@data-attr=navbar21-header]")
		object2.children.get(1).children.get(0).assertObject("navbar221", "xpath", "//*[@data-attr=navbar221-header]")
		object2.children.get(1).assertObject("navbar22", "xpath", "//*[@data-attr=navbar22-header]")
		object3.assertObject("navbar4-*", "#navbar3-header")
	}

	@Test
	def void shouldLoadMultipleObjectWithComplexLocators() {
		// given, when
		val result = parseHelper.parse('''
			@objects
			    navbar css .navbar-header
			    navbar-item-*    css .navbar-collapse .nav li
			    menubar-left   .sidebar-left
			    header      //*[@data-attr=navbar2-header]
			    content    .bs-docs-container
			    header-container    .bs-docs-header .container
			    bootstrap-logo    span.bs-docs-booticon
			     
		''')
		// then
		assertNotNull(result)
		assertNotNull(result.objects.elements)
		val objects = result.objects.elements
		assertTrue(
			"Should 7 object definitions, but was " + objects.size,
			objects.size == 7
		)
		objects.get(0).assertObject("navbar", "css", ".navbar-header")
		objects.get(1).assertObject("navbar-item-*", ".navbar-collapse .nav li")
	}

	// HELPER
	def void assertObject(Element element, String name, String selector, String selectorValue) {
		assertTrue("Should read name '" + name + "', but was " + element.name, element.name.equalsIgnoreCase(name))
		if (selector != null) {
			val className = element.selector.class.simpleName
			switch (selector) {
				case 'xpath':
					assertTrue("Should be XPath selector, but was " + className,
						element.selector instanceof XpathSelector)
				case 'id':
					assertTrue("Should be ID selector, but was " + className, element.selector instanceof IdSelector)
				default:
					assertTrue("Should be CSS selector, but was " + className, element.selector instanceof CssSelector)
			}
		}
		assertTrue("Should read selector value'" + selectorValue + "', but was " + element.selector.value,
			element.selector.value.equalsIgnoreCase(selectorValue)) // TODO correct string compare
	}

	def void assertObject(Element element, String name, String selectorValue) {
		element.assertObject(name, null, selectorValue)
	}

}
