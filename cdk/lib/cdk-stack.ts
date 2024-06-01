import * as cdk from "aws-cdk-lib";
import * as lambda from "aws-cdk-lib/aws-lambda";
import * as ecr_assets from "aws-cdk-lib/aws-ecr-assets";

import { Construct } from "constructs";

export class CdkStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    ["bun", "go", "rust", "gunicorn", "uvicorn"].forEach((lang) => {
      const [_lambda, funcUrl] = this.createLambdaFunction(lang);
    });
  }

  private createLambdaFunction(
    lang: string
  ): [lambda.DockerImageFunction, lambda.FunctionUrl] {
    const lambdaFunc = new lambda.DockerImageFunction(this, `Lambda-${lang}`, {
      architecture: lambda.Architecture.X86_64,
      code: lambda.DockerImageCode.fromImageAsset(`../${lang}`, {
        platform: ecr_assets.Platform.LINUX_AMD64,
      }),
      memorySize: 128,
    });

    // Function URL
    const funcUrl = lambdaFunc.addFunctionUrl({
      authType: lambda.FunctionUrlAuthType.NONE,
    });

    return [lambdaFunc, funcUrl];
  }
}
