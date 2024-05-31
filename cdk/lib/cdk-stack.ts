import * as cdk from "aws-cdk-lib";
import * as lambda from "aws-cdk-lib/aws-lambda";
import * as ecr_assets from "aws-cdk-lib/aws-ecr-assets";

import { Construct } from "constructs";

// import * as sqs from 'aws-cdk-lib/aws-sqs';

export class CdkStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    ["python", "bun", "go", "rust"].forEach((lang) => {
      const [_lambda, funcUrl] = this.createLambdaFunction(lang);
      console.log(`Lambda Function URL: ${funcUrl.url}`);
    });
  }

  private createLambdaFunction(
    lang: string
    // vpc: ec2.Vpc,
  ): [lambda.DockerImageFunction, lambda.FunctionUrl] {
    // const isGitHubActions = process.env.GITHUB_ACTIONS === "true";
    // console.log("isGitHubActions", isGitHubActions);

    const lambdaFunc = new lambda.DockerImageFunction(this, `Lambda-${lang}`, {
      architecture: lambda.Architecture.X86_64,
      code: lambda.DockerImageCode.fromImageAsset(`../${lang}`, {
        platform: ecr_assets.Platform.LINUX_AMD64,
        // cacheFrom: isGitHubActions ? [{ type: "gha" }] : undefined,
        // cacheTo: isGitHubActions ? { type: "gha" } : undefined,
      }),
      // vpc,
      // vpcSubnets: {
      //   subnetType: ec2.SubnetType.PRIVATE_WITH_EGRESS,
      // },
      // ipv6AllowedForDualStack: true,
      // securityGroups: [
      //   new ec2.SecurityGroup(this, "SecurityGroup", {
      //     securityGroupName: "LambdaSg",
      //     vpc,
      //     allowAllIpv6Outbound: true,
      //     allowAllOutbound: true,
      //   }),
      // ],
    });

    // Function URL
    const funcUrl = lambdaFunc.addFunctionUrl({
      authType: lambda.FunctionUrlAuthType.NONE,
    });

    return [lambdaFunc, funcUrl];
  }
}
