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
class GroupsTest {
		@Inject
	ParseHelper<Model> parseHelper;

	// NEGATIVE TESTS

	@Test
	def void shouldWorkWithoutAnyGroup() {
		val result = parseHelper.parse('''
			@objects
			   navbar  .navbar-header
			  navbar  .navbar-header
			  	 navbar  .navbar-header
		''')
		assertNotNull(result)
		assertNotNull(result.objects.elements)
		assertNull(result.groups)
	}

	// POSITIVE TESTS	
	@Test
	def void shouldReadSimpleGroupEntry() {
		val result = parseHelper.parse('''
			@objects
				navbar  .navbar-header
				navcontent  .navbar-content
			@groups
				navigation navbar,navcontent
		''')
		assertNotNull(result)
		assertNotNull(result.objects)
		assertNotNull(result.groups)
		val navbar = result.objects.elements.get(0)
		val navcontent = result.objects.elements.get(1)
		val groups = result.groups.groupEntries
		val navigationGroup = groups.get(0)
		assertTrue(navigationGroup.name.equalsIgnoreCase("navigation"))
		assertTrue(navigationGroup.consistsOf.get(0) == navbar)
		assertTrue(navigationGroup.consistsOf.get(1) == navcontent)
	}
}