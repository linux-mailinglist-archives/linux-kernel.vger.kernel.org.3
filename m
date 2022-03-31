Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923C74ED10D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 02:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352157AbiCaAwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 20:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352142AbiCaAwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 20:52:41 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C66059A64;
        Wed, 30 Mar 2022 17:50:55 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-df0940c4eeso10355981fac.8;
        Wed, 30 Mar 2022 17:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=A66b4EUBSg5Uy8yfSHgRx+FsA0tOVWffGvkQxaTSXa4=;
        b=WmRm68LeHN10i8196Y/jNuk251oR07iYWyACCbDS3j4GKdDBhduUb7DvcbA4DEQ3Zb
         plZoyiWe2vterHZUZqxWeW600442easL6+IWX2WXsP9B/vHpfb7K8i8bqGuW74zEibGQ
         8SVS7aLRagDtM6kW5WfnxwGmMfi8vHrID3c3LnTdOyESbJ5io6PmrqdeqNyQjZ+Hkv8c
         q+nu+8q+r4Ml4JkW0Ml8FlRmS4FGRghfnz6Ea2OtB4DpFT9Y9Ti+kGn8kOUP+FNR1Tro
         80wvXwvW518peULjj8/rpxbnG8boXZ0E2gJ0xb/2JjKNRrXPmIRSzZZPW3eQQlOCSl8h
         YOAw==
X-Gm-Message-State: AOAM532RsCpl5bk3s1H0QJNvkpdeGrbA5mWl2oUcJcqa2NlSdQbpB0h7
        akQSYfBZuZuZ8PcLtOGVKvKYNB5yHQ==
X-Google-Smtp-Source: ABdhPJy+MIlGWczbPgmzwI4IOf+RWSip/f9hsK3bXG7yz7sjaQp7VehJM3ItEfIvE3um0TqWR73I2A==
X-Received: by 2002:a05:6870:c58f:b0:da:b3f:2b69 with SMTP id ba15-20020a056870c58f00b000da0b3f2b69mr1386894oab.264.1648687854353;
        Wed, 30 Mar 2022 17:50:54 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a15-20020a056870000f00b000de1ab6364dsm10660771oaa.49.2022.03.30.17.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 17:50:53 -0700 (PDT)
Received: (nullmailer pid 3984300 invoked by uid 1000);
        Thu, 31 Mar 2022 00:50:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     sanjayc@nvidia.com, devicetree@vger.kernel.org,
        ksitaraman@nvidia.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-tegra@vger.kernel.org,
        krzk+dt@kernel.org, rafael@kernel.org, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, bbasu@nvidia.com, treding@nvidia.com,
        viresh.kumar@linaro.org
In-Reply-To: <20220330143819.27476-3-sumitg@nvidia.com>
References: <20220330143819.27476-1-sumitg@nvidia.com> <20220330143819.27476-3-sumitg@nvidia.com>
Subject: Re: [Patch v2 2/4] dt-bindings: arm: tegra: Add bindins for nvidia,tegra-ccplex-cluster
Date:   Wed, 30 Mar 2022 19:50:53 -0500
Message-Id: <1648687853.036468.3984299.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 20:08:17 +0530, Sumit Gupta wrote:
> The Tegra CCPLEX_CLUSTER area contains memory-mapped
> registers that initiate CPU frequency/voltage transitions.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../tegra/nvidia,tegra-ccplex-cluster.yaml    | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.example.dt.yaml: example-0: ccplex@e000000:reg:0: [0, 234881024, 0, 393215] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

