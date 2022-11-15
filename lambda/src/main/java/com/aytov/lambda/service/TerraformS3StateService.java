package com.aytov.lambda.service;

import com.amazonaws.regions.Regions;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.aytov.lambda.model.TerraformStateFilter;
import com.jayway.jsonpath.JsonPath;
import com.jayway.jsonpath.JsonPathException;

public class TerraformS3StateService {
    private final String bucketName;
    private final String key;

    private final AmazonS3 s3;

    public TerraformS3StateService(final String bucketName, final String key, final Regions region) {
        this.bucketName = bucketName;
        this.key = key;

        s3 = AmazonS3Client.builder()
                .withRegion(region)
                .build();
    }

    public String getState(final TerraformStateFilter terraformStateFilter) {
        terraformStateFilter.getLogger().log("bucketName is: " + bucketName + "\n");
        terraformStateFilter.getLogger().log("key is: " + key + "\n");

        final String jsonState = getAllState();

        if (terraformStateFilter.getExpression().isPresent()) {
            terraformStateFilter.getLogger().log("expression is: " + terraformStateFilter.getExpression() + "\n");
            return getFilteredState(jsonState, terraformStateFilter);
        }

        return jsonState;
    }

    private String getFilteredState(final String jsonState, final TerraformStateFilter terraformStateFilter) {
        return JsonPathWrapper.create(jsonState, terraformStateFilter.getLogger())
                .apply(terraformStateFilter.getExpression().get());
    }

    public String getAllState() {
        return s3.getObjectAsString(bucketName, key);
    }

    static class JsonPathWrapper {
        private final String value;
        private final LambdaLogger logger;

        private JsonPathWrapper(String value, LambdaLogger logger) {
            this.value = value;
            this.logger = logger;
        }

        static JsonPathWrapper create(String value, LambdaLogger logger) {
            return new JsonPathWrapper(value, logger);
        }

        String apply(String expression) {
            try {
                return JsonPath.parse(value).read(expression).toString();
            } catch (JsonPathException e) {
                logger.log("Error while applying filter expression: " + e.getMessage());
                throw (e);
            }
        }
    }
}
