Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304C2514FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378664AbiD2P4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378290AbiD2P4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:56:41 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42705CABBE;
        Fri, 29 Apr 2022 08:53:20 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id e4so8948643oif.2;
        Fri, 29 Apr 2022 08:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=8c/8aPQ+INHY9UT15ou0Pj3sFCcZR4zflpgcHdOlHcU=;
        b=ESHqhbeyzjt7S5d0vZPvl43UmynKJDaQrIIJJRRCg6Kgea7LTJecxeZ51SqpxzrvEE
         pBYegpBFWrsEL3Dvjlift1tekjHe5AywmToaLUnhLYXPXzfh2ncDUuWFezvZpnhEeeZ9
         rC1jcW+GYgp7tY2NclZTdTL4z3H8+PNsaE/M3CgECI0S6lZfsH0qrzjHbvAgZlDsh3VA
         PEeMh5yE0uZtxvBUymIZYrVcWNJJTS/AJOrCDnUOGEc9v/Rlyoj6zbjd1QfY6fjK7jPo
         9wPU+SFdk29Iw0hlI/kUi7V/8RxEIS8Nn2d0DcZN9o2Pjgz7T4pCqvmA6bExT8bgYPU0
         6TBQ==
X-Gm-Message-State: AOAM530giWbKYGGrvNgVzIRioW6RNt3FYH/KLG9hDYgXBdadSYfRKxmG
        eLGflFQghN5EaAYANZLhlQ==
X-Google-Smtp-Source: ABdhPJyHk6Vezdq2ZcgOXBezvob14dh5P9RlvoepRdMfGc3VB1Wg+ZVR0YtpfMvXI89g6zvT2louZg==
X-Received: by 2002:a05:6808:188a:b0:323:47b:2030 with SMTP id bi10-20020a056808188a00b00323047b2030mr23553oib.77.1651247599523;
        Fri, 29 Apr 2022 08:53:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b14-20020a056870160e00b000e915a9121csm3362607oae.52.2022.04.29.08.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 08:53:18 -0700 (PDT)
Received: (nullmailer pid 2344495 invoked by uid 1000);
        Fri, 29 Apr 2022 15:53:16 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <20220429121739.28584-4-ansuelsmth@gmail.com>
References: <20220429121739.28584-1-ansuelsmth@gmail.com> <20220429121739.28584-4-ansuelsmth@gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: arm: msm: Convert kpss-gcc driver Documentation to yaml
Date:   Fri, 29 Apr 2022 10:53:16 -0500
Message-Id: <1651247596.124069.2344494.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022 14:17:39 +0200, Ansuel Smith wrote:
> Convert kpss-gcc driver Documentation to yaml.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 -------------
>  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 63 +++++++++++++++++++
>  2 files changed, 63 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml: properties: '#clock-cells' is a dependency of 'clock-output-names'
	from schema $id: http://devicetree.org/meta-schemas/clocks.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml: ignoring, error in schema: properties
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.example.dtb: clock-controller@2011000: '#clock-cells' is a dependency of 'clock-output-names'
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/clock/clock.yaml
Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.example.dtb:0:0: /example-0/clock-controller@2011000: failed to match any schema with compatible: ['qcom,kpss-gcc-ipq8064', 'qcom,kpss-gcc']
Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.example.dtb:0:0: /example-0/clock-controller@2011000: failed to match any schema with compatible: ['qcom,kpss-gcc-ipq8064', 'qcom,kpss-gcc']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

