package com.aytov.lambda;

import com.amazonaws.regions.Regions;
import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.aytov.lambda.model.Request;
import com.aytov.lambda.model.TerraformStateFilter;
import com.aytov.lambda.service.TerraformS3StateService;

import java.util.Optional;

public class LambdaTerraformStateHandler implements RequestHandler<Request, String> {
    private final TerraformS3StateService s3StateService;

    public LambdaTerraformStateHandler() {
        final String bucketName = System.getenv("STATE_BUCKET_NAME");
        final String fileName = System.getenv("STATE_FILE_NAME");
        final String region = System.getenv("REGION");

        this.s3StateService = new TerraformS3StateService(bucketName, fileName, Regions.fromName(region));
    }

    public String handleRequest(Request request, Context context) {
        final TerraformStateFilter terraformStateFilter = new TerraformStateFilter(context.getLogger(), Optional.ofNullable(request.getExp()));

        return s3StateService.getState(terraformStateFilter);
    }
}
