Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048755B2840
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiIHVQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiIHVQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:16:20 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2D1BFC58;
        Thu,  8 Sep 2022 14:16:18 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id c39-20020a05683034a700b006540d515722so1225805otu.5;
        Thu, 08 Sep 2022 14:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rWcbq6ugiqgCgjELcrVqjS0I0wNefYBPb+GNt/oNe5w=;
        b=1TrYSYYscIIBk0wK8JDkQn5sYV3jLzDPU/OehI29LgizQvm2lkjHSl1krAp7pzXqUd
         ols+guR3MEpuwp06xrapqbdXsWasMlG/xEFI4u/BXoingH4211xI7d2cFHFGdxcL819F
         leA6pxSaYWfPgnooVOW6rM1/pzWDiRQIUjrlqxSaYuF/sC3qMzoPudrih5fmT9szueYB
         pBXcfARXbIFzqGgTbzpQuRaeDuzCLfQuU70n04H2EBYCaJXz0woElkKGK0ejWZCP2G5Y
         dv+rm31XBWT7acGAooZRTTGLIU90fPX0haIhm7Vt1GT9ta26wD13vIn4cxWKA4xIy8Zn
         qWzQ==
X-Gm-Message-State: ACgBeo3mWQwL9/W77cxGouuRTAAK2OInW6IGSZjAcSFixRO94YxEOuWH
        AlaPobl+tmPFhdyg8Ulz3w==
X-Google-Smtp-Source: AA6agR5ionLIAJ47zBwQEOmI6h314I0xQAXIv3ruArlWY7lsCBuy17bNk3p+MWY01+zMs1FnHRbRpQ==
X-Received: by 2002:a9d:6f04:0:b0:654:ce0:d6ca with SMTP id n4-20020a9d6f04000000b006540ce0d6camr1263105otq.159.1662671777625;
        Thu, 08 Sep 2022 14:16:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z20-20020a056871015400b0011f390fdb0asm167406oab.12.2022.09.08.14.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 14:16:17 -0700 (PDT)
Received: (nullmailer pid 3355396 invoked by uid 1000);
        Thu, 08 Sep 2022 21:16:16 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sireesh Kodali <sireeshkodali1@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20220908184925.2714098-3-sireeshkodali1@gmail.com>
References: <20220908184925.2714098-1-sireeshkodali1@gmail.com> <20220908184925.2714098-3-sireeshkodali1@gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: remoteproc: qcom: Convert wcnss documentation to YAML
Date:   Thu, 08 Sep 2022 16:16:16 -0500
Message-Id: <1662671776.543526.3355395.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Sep 2022 00:19:23 +0530, Sireesh Kodali wrote:
> This is a direct conversion of the existing txt documentation to YAML.
> It is in preparation for the addition of pronto-v3 to the docs. This
> patch doesn't document any of the existing subnodes/properties that are
> not documented in the existing txt file. That is done in a separate
> patch.
> 
> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> ---
>  .../bindings/remoteproc/qcom,wcnss-pil.yaml   | 263 ++++++++++++++++++
>  1 file changed, 263 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.example.dtb: pronto@a21b000: iris: 'vddxo-supply' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.example.dtb: pronto@a21b000: iris: 'vddrfa-supply' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.example.dtb: pronto@a21b000: iris: 'vddpa-supply' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.example.dtb: pronto@a21b000: iris: 'vdddig-supply' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.example.dtb: wcnss: 'bt' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

