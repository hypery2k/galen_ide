package com.galenframework.ide.parser.antlr;

import org.antlr.runtime.Token;
import org.antlr.runtime.TokenSource;

public class SpecTokenSource extends
		com.galenframework.parser.antlr.SpecTokenSource {

	public SpecTokenSource(TokenSource createLexer) {
		super(createLexer);
	}

	@Override
	public Token nextToken() {
		// TODO Auto-generated method stub
		return super.nextToken();
	}

	@Override
	public String getSourceName() {
		// TODO Auto-generated method stub
		return super.getSourceName();
	}

}
