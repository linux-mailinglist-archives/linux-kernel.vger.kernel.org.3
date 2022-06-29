Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5410F55F32D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 04:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiF2CJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 22:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiF2CJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 22:09:53 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A1A2E693;
        Tue, 28 Jun 2022 19:09:50 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id r133so14686897iod.3;
        Tue, 28 Jun 2022 19:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=waCJIZKcY+s87HZbkQDuAXOTS88eENMKzg5sjsc1NzY=;
        b=K1J9kY/z9z26xkxUg/hMbVlci583PznauOMdrUB1JPIBohx5dMc7phx+Ia3+6mcS3j
         R7a3XH8iwbIrKr5CO/fIGHYI2WO4yy0CvLT0uwWd7CIjn+Mt7XCts4xeLbG9K38BNPeF
         EMhxvzJ1voq+OuYTSofviVdmpBE7fl8bGIxnOAKGCFnddSf/f4eeBxPBfR7e2x7WWj6R
         BuroIu2dnBIjVx5J77cqK0+IBhH7dPIxX5OHqUzGNBewTIzfGGFcjOzEBj7RqQpVwAcj
         hgL5Jyccd22uuA0wFORTm51JCDZhm+Cqg8IMNv1zsCLnCoHjpXxrFrBjx2OkKBfDmI5O
         4JYw==
X-Gm-Message-State: AJIora/PyTXB5rGtBY8T0cJm/HybDecXqqnb1M+fsL5ESzltkRBXX8pN
        dgAl3ijtHZJHqoyqy/Yx4Q==
X-Google-Smtp-Source: AGRyM1vdK8gQg0KczW14+8tjZakRIV3kb131xnXsYvJk4n/AJZUPHnqUJmxDkVAJ8/u+E2ECEObOTg==
X-Received: by 2002:a02:90ce:0:b0:32e:e2ce:b17c with SMTP id c14-20020a0290ce000000b0032ee2ceb17cmr705645jag.268.1656468589332;
        Tue, 28 Jun 2022 19:09:49 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id a12-20020a029f8c000000b0032b3a7817dbsm6538536jam.159.2022.06.28.19.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 19:09:49 -0700 (PDT)
Received: (nullmailer pid 1403676 invoked by uid 1000);
        Wed, 29 Jun 2022 02:09:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org
In-Reply-To: <20220628184137.21678-3-ansuelsmth@gmail.com>
References: <20220628184137.21678-1-ansuelsmth@gmail.com> <20220628184137.21678-3-ansuelsmth@gmail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: arm: msm: Convert kpss-acc driver Documentation to yaml
Date:   Tue, 28 Jun 2022 20:09:39 -0600
Message-Id: <1656468579.900344.1403675.nullmailer@robh.at.kernel.org>
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

On Tue, 28 Jun 2022 20:41:35 +0200, Christian Marangi wrote:
> Convert kpss-acc driver Documentation to yaml.
> The original Documentation was wrong all along. Fix it while we are
> converting it.
> The example was wrong as kpss-acc-v2 should only expose the regs but we
> don't have any driver that expose additional clocks. The kpss-acc driver
> is only specific to v1. For this exact reason, limit all the additional
> bindings (clocks, clock-names, clock-output-names and #clock-cells) to
> v1 and also flag that these bindings should NOT be used for v2.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 ----------
>  .../bindings/arm/msm/qcom,kpss-acc.yaml       | 94 +++++++++++++++++++
>  2 files changed, 94 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml: allOf:0: 'then' is a dependency of 'if'
	hint: Keywords must be a subset of known json-schema keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml: allOf:0: 'then' is a dependency of 'else'
	hint: Keywords must be a subset of known json-schema keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml: allOf:0:if: 'if' is a dependency of 'then'
	hint: Keywords must be a subset of known json-schema keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml: patternProperties:^thermistor@:properties:adi,excitation-current-nanoamp: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml: ignoring, error in schema: allOf: 0
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml: ignoring, error in schema: patternProperties: ^thermistor@: properties: adi,excitation-current-nanoamp
Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.example.dtb:0:0: /example-0/spi/ltc2983@0: failed to match any schema with compatible: ['adi,ltc2983']
Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.example.dtb:0:0: /example-0/clock-controller@2088000: failed to match any schema with compatible: ['qcom,kpss-acc-v1']
Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.example.dtb:0:0: /example-1/clock-controller@f9088000: failed to match any schema with compatible: ['qcom,kpss-acc-v2']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

