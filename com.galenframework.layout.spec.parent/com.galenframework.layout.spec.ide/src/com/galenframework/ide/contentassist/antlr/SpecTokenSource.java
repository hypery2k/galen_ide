package com.galenframework.ide.contentassist.antlr;

import org.antlr.runtime.Token;
import org.antlr.runtime.TokenSource;

public class SpecTokenSource extends com.galenframework.parser.antlr.SpecTokenSource {

	public SpecTokenSource(TokenSource createLexer) {
		super(createLexer);
	}

	@Override
	public Token nextToken() {
		return super.nextToken();
	}

	@Override
	public String getSourceName() {
		return super.getSourceName();
	}

}
