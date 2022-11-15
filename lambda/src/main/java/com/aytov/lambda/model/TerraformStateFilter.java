package com.aytov.lambda.model;

import com.amazonaws.services.lambda.runtime.LambdaLogger;

import java.util.Optional;

public final class TerraformStateFilter {
    private final LambdaLogger logger;
    private final Optional<String> expression;

    public TerraformStateFilter(LambdaLogger logger, Optional<String> expression) {
        this.logger = logger;
        this.expression = expression;
    }

    public LambdaLogger getLogger() {
        return logger;
    }

    public Optional<String> getExpression() {
        return expression;
    }
}
