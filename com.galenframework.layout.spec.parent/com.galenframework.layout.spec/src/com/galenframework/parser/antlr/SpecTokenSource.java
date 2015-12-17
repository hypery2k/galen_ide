package com.galenframework.parser.antlr;

import org.antlr.runtime.Token;
import org.antlr.runtime.TokenSource;
import org.eclipse.xtext.parser.antlr.AbstractIndentationTokenSource;

import com.galenframework.parser.antlr.internal.InternalSpecParser;

public class SpecTokenSource extends AbstractIndentationTokenSource {
	
	public SpecTokenSource(TokenSource delegate) {
		super(delegate);
	}
	
	@Override
	protected boolean shouldSplitTokenImpl(Token token) {
		return token.getType() == InternalSpecParser.RULE_WS;
	}

	@Override
	protected int getBeginTokenType() {
		return InternalSpecParser.RULE_BEGIN;
	}

	@Override
	protected int getEndTokenType() {
		return InternalSpecParser.RULE_END;
	}

}
