Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A20A559FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiFXR1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiFXR0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:26:47 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE37B15731;
        Fri, 24 Jun 2022 10:26:43 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id p13so1958902ilq.0;
        Fri, 24 Jun 2022 10:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=pG44rlutVz8or+Ka4stYxBDxJcy/zH2ZBfdoozeWmIQ=;
        b=h0yMMxQs212+R43sXJ+SFDT8t878vKvXYnXGy0J7kq+U5bWCKjr12zuNxCUQ1NENH7
         f4GjjLvPo6kDu+Wy5nG91pTHx09mdQc0uOQ1c9ft8JRxO1HX9pGxK0rGB6417NxgHumb
         ZK/veQhl5D/1at20RoZdq/DdMe8dhkF3xWQlmevWcrfX7Cko9dEUjIXibYgStshCPSUZ
         upfHbKBvsZiPrvBtSTZ/T0wfCLFlWuZg0i7wDZP12X/W4txO+LoR33mXxWI5oU1gMnaf
         DuJSSmQY9J4ClZG2E833u/FvumlAH5iyZErdyU9MoljWtuLCdYuyLQpFv5MuyCJKmpCX
         9P+g==
X-Gm-Message-State: AJIora8p6MIoWPGfYdpkNaXhf+tYqHmg5XC7+VyWuO6LgSMg0lvXrzeh
        EHLZ5BTmE6Fgma4l3F2hJQ==
X-Google-Smtp-Source: AGRyM1sp8qJgtkAHwQ7xSchoyFjcFRtWdFDawd+7XUChsAzX5klGJTS7YDEzNpsD5lqJ/34v5mQAFg==
X-Received: by 2002:a05:6e02:16cc:b0:2da:63c7:257e with SMTP id 12-20020a056e0216cc00b002da63c7257emr25166ilx.285.1656091602736;
        Fri, 24 Jun 2022 10:26:42 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z6-20020a05660217c600b006692192baf7sm1495029iox.25.2022.06.24.10.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:26:42 -0700 (PDT)
Received: (nullmailer pid 146336 invoked by uid 1000);
        Fri, 24 Jun 2022 17:26:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20220623105401.168122-2-krzysztof.kozlowski@linaro.org>
References: <20220623105401.168122-1-krzysztof.kozlowski@linaro.org> <20220623105401.168122-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: arm: qcom: document qcom,msm-id and qcom,board-id
Date:   Fri, 24 Jun 2022 11:26:34 -0600
Message-Id: <1656091594.364332.146335.nullmailer@robh.at.kernel.org>
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

On Thu, 23 Jun 2022 12:53:59 +0200, Krzysztof Kozlowski wrote:
> The top level qcom,msm-id and qcom,board-id properties are utilized by
> bootloaders on Qualcomm MSM platforms to determine which device tree
> should be used and passed to the kernel.
> 
> The commit b32e592d3c28 ("devicetree: bindings: Document qcom board
> compatible format") from 2015 was a consensus during discussion about
> upstreaming qcom,msm-id and qcom,board-id fields.  There are however still
> problems with that consensus:
> 1. It was reached 7 years ago but it turned out its implementation did
>    not reach all possible products.
> 
> 2. Initially additional tool (dtbTool) was needed for parsing these
>    fields to create a QCDT image consisting of multiple DTBs, later the
>    bootloaders were improved and they use these qcom,msm-id and
>    qcom,board-id properties directly.
> 
> 3. Extracting relevant information from the board compatible requires
>    this additional tool (dtbTool), which makes the build process more
>    complicated and not easily reproducible (DTBs are modified after the
>    kernel build).
> 
> 4. Some versions of Qualcomm bootloaders expect these properties even
>    when booting with a single DTB.  The community is stuck with these
>    bootloaders thus they require properties in the DTBs.
> 
> Since several upstreamed Qualcomm SoC-based boards require these
> properties to properly boot and the properties are reportedly used by
> bootloaders, document them.
> 
> Link: https://lore.kernel.org/r/a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org/
> Co-developed-by: Kumar Gala <galak@codeaurora.org>
> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/arm/qcom.yaml         | 121 +++++++++++++++
>  include/dt-bindings/arm/qcom,ids.h            | 146 ++++++++++++++++++
>  2 files changed, 267 insertions(+)
>  create mode 100644 include/dt-bindings/arm/qcom,ids.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/qcom.yaml: properties:qcom,board-id:items: 'oneOf' conditional failed, one must be fixed:
	{'oneOf': [{'maxItems': 2, 'items': [{'description': 'Board ID consisting of three bitfields::\n  - bits 31-24 - Unused\n  - bits 23-16 - Platform Version Major\n  - bits 15-8  - Platform Version Minor\n  - bits 7-0   - Platform Type\nPlatform Type field is an exact match value.  The\nPlatform Major/Minor field is a best match.  The bootloader will\nlook for the closest possible match.\n'}, {'description': 'Subtype ID unique to a Platform Type/Chipset ID.  For a given\nPlatform Type, there will typically only be a single board and the\nsubtype_id will be 0.  However in some cases board variants may\nneed to be distinguished by different subtype_id values.\n'}]}, {'minItems': 4, 'items': [{'const': 8}, {'const': 0}, {'description': 'OnePlus board ID'}, {'description': 'OnePlus subtype ID'}]}]} is not of type 'array'
	{'maxItems': 2, 'items': [{'description': 'Board ID consisting of three bitfields::\n  - bits 31-24 - Unused\n  - bits 23-16 - Platform Version Major\n  - bits 15-8  - Platform Version Minor\n  - bits 7-0   - Platform Type\nPlatform Type field is an exact match value.  The\nPlatform Major/Minor field is a best match.  The bootloader will\nlook for the closest possible match.\n'}, {'description': 'Subtype ID unique to a Platform Type/Chipset ID.  For a given\nPlatform Type, there will typically only be a single board and the\nsubtype_id will be 0.  However in some cases board variants may\nneed to be distinguished by different subtype_id values.\n'}]} should not be valid under {'required': ['maxItems']}
		hint: "maxItems" is not needed with an "items" list
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/qcom.yaml: properties:qcom,board-id:items:oneOf:1: 'oneOf' conditional failed, one must be fixed:
		[{'const': 8}, {'const': 0}, {'description': 'OnePlus board ID'}, {'description': 'OnePlus subtype ID'}] is too long
		[{'const': 8}, {'const': 0}, {'description': 'OnePlus board ID'}, {'description': 'OnePlus subtype ID'}] is too short
		False schema does not allow 4
		1 was expected
		4 is greater than the maximum of 2
		4 is greater than the maximum of 3
		hint: "minItems" is only needed if less than the "items" list length
		from schema $id: http://devicetree.org/meta-schemas/items.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/qcom.yaml: properties:qcom,board-id:items:oneOf:1: 'oneOf' conditional failed, one must be fixed:
		[{'const': 8}, {'const': 0}, {'description': 'OnePlus board ID'}, {'description': 'OnePlus subtype ID'}] is too long
		[{'const': 8}, {'const': 0}, {'description': 'OnePlus board ID'}, {'description': 'OnePlus subtype ID'}] is too short
		False schema does not allow 4
		1 was expected
		4 is greater than the maximum of 2
		4 is greater than the maximum of 3
		hint: "minItems" is only needed if less than the "items" list length
		from schema $id: http://devicetree.org/meta-schemas/items.yaml#
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/qcom.yaml: ignoring, error in schema: properties: qcom,board-id: items
Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb:0:0: /: failed to match any schema with compatible: ['arrow,apq8096-db820c', 'qcom,apq8096-sbc', 'qcom,apq8096']
Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb:0:0: /: failed to match any schema with compatible: ['arrow,apq8096-db820c', 'qcom,apq8096-sbc', 'qcom,apq8096']
Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb:0:0: /: failed to match any schema with compatible: ['arrow,apq8096-db820c', 'qcom,apq8096-sbc', 'qcom,apq8096']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

