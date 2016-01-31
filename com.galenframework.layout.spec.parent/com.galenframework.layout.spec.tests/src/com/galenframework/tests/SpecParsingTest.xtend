/*
 * generated by Xtext 2.9.0
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
class SpecParsingTest{

	@Inject
	ParseHelper<Model> parseHelper;
	
	@Test
	def void shouldParseSpecWithImport() {
		val result = parseHelper.parse('''
			# objects
			@objects
			  navbar  .navbar-header
			  
			@import abc.gspec
			@import other.gspec
			  
			= Main section =
			  navbar:
			    visible
		''')
		Assert.assertNotNull(result)
		Assert.assertNotNull(result.objects.elements)
		Assert.assertNotNull(result.importSection)
		val elements = result.objects.elements	
		val imports = result.importSection	
		val layoutSections = result.layoutCheckSection	
		Assert.assertEquals(1,elements.size)
		Assert.assertEquals(2,imports.size)
		Assert.assertEquals("abc.gspec",imports.get(0).file)
		Assert.assertEquals("other.gspec",imports.get(1).file)
		Assert.assertEquals(1,layoutSections.size)
		val mainSection = layoutSections.get(0)
		Assert.assertEquals(1,mainSection.rules.size)
		//Assert.assertNotNull(result.im)			


	}
	

	@Test
	def void loadPassSimpleSpec() {
		val result = parseHelper.parse('''
			# objects
			@objects
			  navbar  .navbar-header
			  
			= Main section =
			  navbar:
			    visible
		''')
		Assert.assertNotNull(result)
		Assert.assertNotNull(result.objects.elements)		
		val elementRef = result.objects.elements.get(0)
		Assert.assertEquals("navbar",elementRef.name)
		Assert.assertNotNull(result.layoutCheckSection)
		val layoutSections = result.layoutCheckSection
		Assert.assertEquals(1,layoutSections.size)
		val mainSection = layoutSections.get(0)
		Assert.assertEquals(1,mainSection.rules.size)
		val MainSectionElementRef = mainSection.rules.get(0)
		Assert.assertEquals("navbar",MainSectionElementRef.ref.name)
		/*
		val objects = result.objects.elements
		val sections = result.layoutCheckSection
		Assert.assertTrue("Should read one object definition, but was " + objects.size, objects.size == 1)
		Assert.assertTrue("Should read one object layout check section, but was " + sections.size, sections.size == 1)
		val object = objects.get(0)
		Assert.assertTrue("Should read CSS selector type, but was " + object.selector,
			object.selector.equalsIgnoreCase(".navbar-header"))
		val section = sections.get(0)
		Assert.assertTrue("Should get correct name, but was " + section.name,
			section.name.equalsIgnoreCase("Main section"))
		Assert.assertTrue("Should get correct element reference, but was " + section.ref.name,
			section.ref.name.equalsIgnoreCase("navbar")) */

	}

}
