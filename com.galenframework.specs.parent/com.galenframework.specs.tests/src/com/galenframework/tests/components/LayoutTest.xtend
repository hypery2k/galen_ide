/*
 * generated by Xtext 2.9.2
 */
package com.galenframework.tests.components

import com.galenframework.tests.SpecsInjectorProvider
import com.galenframework.specs.Model
import com.google.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(SpecsInjectorProvider)
class LayoutTest{

	@Inject
	ParseHelper<Model> parseHelper;


	@Test
	def void shouldParseLayoutRuleTitleSimple() {
		val result = parseHelper.parse('''
			= Main section =
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

}