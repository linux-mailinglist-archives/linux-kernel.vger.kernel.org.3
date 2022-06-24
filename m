Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFE555A041
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiFXR46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiFXR4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:56:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31C5B846
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:56:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n185so1713025wmn.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GdCHquEX7XfneqMXAxRSqfPbi/yikw7b304xzJEcLRM=;
        b=ZWCsB2QmMHhVM8jgIBhwmznJaAmG4zv2EHmDjcqsXA/7VLjNSXrjqAyiWQaTNEQ5rL
         cuoD6b8V2lFpSNzNmaCJa7Cc8ZHUhet47SSYhm0FzGgJMv66Fen4zIIF5aknEa1o2Mgk
         tRJrVXKNLc7OJwCFxvofQHh+3p5+UkNWNKf6A0OMxBCVw6ktrhXle3j4grQc9RARl//i
         MAf2qJ54a0ghPEJggVqw3i2rYkAzMOBiR8cIHPzEREl0xb//mrWKHT/f4+sJRGMNvdGf
         qvB6zU2wEAvJ+YU9AJMIDNTzG+q1APTY8XeevN8bFtqtIQ2dA50rvNl1tr3c9hJzDSAr
         LsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GdCHquEX7XfneqMXAxRSqfPbi/yikw7b304xzJEcLRM=;
        b=udcaGS2ss3rbrwlYdWx7NlBoCYRxPixshJUf9Ezo3QAIIahl2Q8uzPjQnE7ETVup1o
         v4BPzOfmntU6gxbxv11/ppmUUV4W+2G7PvKK10EqfE8yv+mZRvM4Y9WeFQRYbnLFzOAF
         aIWjx8YAyNqWIVPQ/PnORQIektOCvraezpj+0FrsJyajcnuV6eIqYAFZW88rdBnc6xNw
         BEvqq5stLa/oguMhb1POiIOGErbQRJVS9DpN/0w6mNqdKRXuBzDw2YroV/uEo88tVmgf
         7A+jaPzi8IZNzrDkiUUq8ScX14GGkXDMiCv2y8avh7JxM4Qsus0TGUrTnTKmVVRfLFrN
         6N1Q==
X-Gm-Message-State: AJIora+CQvvqMvM/mlLOV3SdzLP3cQ5bUSnzjuN8a3YLnSCZRRrPrGyu
        gIw6L/ZkN96HEsMn95wnrmMXnw==
X-Google-Smtp-Source: AGRyM1uG/5Pl+wfQD1a0xBSDUieWE0BWetrHFihHoqpZb+ZRJZ1T5bQjSJwocs1hsdjg3po/LVieHA==
X-Received: by 2002:a1c:4682:0:b0:39c:4459:6a84 with SMTP id t124-20020a1c4682000000b0039c44596a84mr5365943wma.167.1656093411236;
        Fri, 24 Jun 2022 10:56:51 -0700 (PDT)
Received: from [192.168.0.237] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j19-20020a5d6e53000000b002102b16b9a4sm2942935wrz.110.2022.06.24.10.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 10:56:50 -0700 (PDT)
Message-ID: <3ec07506-cfd6-e0af-f8fc-8a8a58ef0c79@linaro.org>
Date:   Fri, 24 Jun 2022 19:56:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 1/3] dt-bindings: arm: qcom: document qcom,msm-id and
 qcom,board-id
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
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
References: <20220623105401.168122-1-krzysztof.kozlowski@linaro.org>
 <20220623105401.168122-2-krzysztof.kozlowski@linaro.org>
 <1656091594.364332.146335.nullmailer@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1656091594.364332.146335.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2022 19:26, Rob Herring wrote:
> On Thu, 23 Jun 2022 12:53:59 +0200, Krzysztof Kozlowski wrote:
>> The top level qcom,msm-id and qcom,board-id properties are utilized by
>> bootloaders on Qualcomm MSM platforms to determine which device tree
>> should be used and passed to the kernel.
>>
>> The commit b32e592d3c28 ("devicetree: bindings: Document qcom board
>> compatible format") from 2015 was a consensus during discussion about
>> upstreaming qcom,msm-id and qcom,board-id fields.  There are however still
>> problems with that consensus:
>> 1. It was reached 7 years ago but it turned out its implementation did
>>    not reach all possible products.
>>
>> 2. Initially additional tool (dtbTool) was needed for parsing these
>>    fields to create a QCDT image consisting of multiple DTBs, later the
>>    bootloaders were improved and they use these qcom,msm-id and
>>    qcom,board-id properties directly.
>>
>> 3. Extracting relevant information from the board compatible requires
>>    this additional tool (dtbTool), which makes the build process more
>>    complicated and not easily reproducible (DTBs are modified after the
>>    kernel build).
>>
>> 4. Some versions of Qualcomm bootloaders expect these properties even
>>    when booting with a single DTB.  The community is stuck with these
>>    bootloaders thus they require properties in the DTBs.
>>
>> Since several upstreamed Qualcomm SoC-based boards require these
>> properties to properly boot and the properties are reportedly used by
>> bootloaders, document them.
>>
>> Link: https://lore.kernel.org/r/a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org/
>> Co-developed-by: Kumar Gala <galak@codeaurora.org>
>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>  .../devicetree/bindings/arm/qcom.yaml         | 121 +++++++++++++++
>>  include/dt-bindings/arm/qcom,ids.h            | 146 ++++++++++++++++++
>>  2 files changed, 267 insertions(+)
>>  create mode 100644 include/dt-bindings/arm/qcom,ids.h
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/qcom.yaml: properties:qcom,board-id:items: 'oneOf' conditional failed, one must be fixed:
> 	{'oneOf': [{'maxItems': 2, 'items': [{'description': 'Board ID consisting of three bitfields::\n  - bits 31-24 - Unused\n  - bits 23-16 - Platform Version Major\n  - bits 15-8  - Platform Version Minor\n  - bits 7-0   - Platform Type\nPlatform Type field is an exact match value.  The\nPlatform Major/Minor field is a best match.  The bootloader will\nlook for the closest possible match.\n'}, {'description': 'Subtype ID unique to a Platform Type/Chipset ID.  For a given\nPlatform Type, there will typically only be a single board and the\nsubtype_id will be 0.  However in some cases board variants may\nneed to be distinguished by different subtype_id values.\n'}]}, {'minItems': 4, 'items': [{'const': 8}, {'const': 0}, {'description': 'OnePlus board ID'}, {'description': 'OnePlus subtype ID'}]}]} is not of type 'array'
> 	{'maxItems': 2, 'items': [{'description': 'Board ID consisting of three bitfields::\n  - bits 31-24 - Unused\n  - bits 23-16 - Platform Version Major\n  - bits 15-8  - Platform Version Minor\n  - bits 7-0   - Platform Type\nPlatform Type field is an exact match value.  The\nPlatform Major/Minor field is a best match.  The bootloader will\nlook for the closest possible match.\n'}, {'description': 'Subtype ID unique to a Platform Type/Chipset ID.  For a given\nPlatform Type, there will typically only be a single board and the\nsubtype_id will be 0.  However in some cases board variants may\nneed to be distinguished by different subtype_id values.\n'}]} should not be valid under {'required': ['maxItems']}
> 		hint: "maxItems" is not needed with an "items" list
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/qcom.yaml: properties:qcom,board-id:items:oneOf:1: 'oneOf' conditional failed, one must be fixed:
> 		[{'const': 8}, {'const': 0}, {'description': 'OnePlus board ID'}, {'description': 'OnePlus subtype ID'}] is too long
> 		[{'const': 8}, {'const': 0}, {'description': 'OnePlus board ID'}, {'description': 'OnePlus subtype ID'}] is too short
> 		False schema does not allow 4
> 		1 was expected
> 		4 is greater than the maximum of 2
> 		4 is greater than the maximum of 3
> 		hint: "minItems" is only needed if less than the "items" list length
> 		from schema $id: http://devicetree.org/meta-schemas/items.yaml#

Eh, I did not see it on dtschema v2022.05-2-g4af6db61ac2b

This one I can remove.

> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/qcom.yaml: properties:qcom,board-id:items:oneOf:1: 'oneOf' conditional failed, one must be fixed:
> 		[{'const': 8}, {'const': 0}, {'description': 'OnePlus board ID'}, {'description': 'OnePlus subtype ID'}] is too long
> 		[{'const': 8}, {'const': 0}, {'description': 'OnePlus board ID'}, {'description': 'OnePlus subtype ID'}] is too short
> 		False schema does not allow 4
> 		1 was expected
> 		4 is greater than the maximum of 2
> 		4 is greater than the maximum of 3
> 		hint: "minItems" is only needed if less than the "items" list length

However this one I need.

Without the minItems:4, the
arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi matches both
conditions of oneOf.

The DTS looks like:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi?id=92f20ff72066d8d7e2ffb655c2236259ac9d1c5d#n24

But I think I can code it differently:
oneOf
  - items
      - items
        - foo
        - bar
  - items
      - items
        - foo
        - bar
        - baz
        - faz


> 		from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> 	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/qcom.yaml: ignoring, error in schema: properties: qcom,board-id: items
> Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb:0:0: /: failed to match any schema with compatible: ['arrow,apq8096-db820c', 'qcom,apq8096-sbc', 'qcom,apq8096']
> Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb:0:0: /: failed to match any schema with compatible: ['arrow,apq8096-db820c', 'qcom,apq8096-sbc', 'qcom,apq8096']
> Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb:0:0: /: failed to match any schema with compatible: ['arrow,apq8096-db820c', 'qcom,apq8096-sbc', 'qcom,apq8096']
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 


Best regards,
Krzysztof
