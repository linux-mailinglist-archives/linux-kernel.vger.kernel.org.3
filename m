Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA71561909
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiF3LX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiF3LXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:23:54 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F35CB43
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:23:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id mf9so38461695ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cl2/aCRmz32z0M8hATk63KFl8RD4GPOSvWPssViTZUo=;
        b=cn6dgKQrEDTdE1btrPB4ifpslzzEQroEEzzek9jnManHYUnf9nqJ2zGHKZv1k6tIUA
         rmZKjIf9x/kZ1oxQ4PtR2SsYw3xZTbZXWI85Yng8GRkUkaphKp/mQDVQIr2s4HRp/ZTe
         m4vUZO4bmWD/xWJzI1eBnsSZfjlMFtoqhLNm8OP+FU1c8/6jrcff/r5/Yh3wgc+KY9yO
         6XBa5MLRLXXsIhzNFCVX4PEajTiTSHmpJRDG0nXYNQ2RYVRJ+YOV7xDVU461/SML/xoH
         3PsnUmNjAHdALjD9P6CZwPcLtgV0Lls9cj6ladKn7KnYtBowAP0ddzQQklKhLz/WyekD
         a0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cl2/aCRmz32z0M8hATk63KFl8RD4GPOSvWPssViTZUo=;
        b=K3VlWdG7YEDNpiH//ji7yGglDoKeoPFc4Sf6WPoyE5ZB9zEZCenOUdA6/59YCFyQGi
         /HhZ9ICDllS4f7iq3mPx078D57OCdQfS9QlnJ0BK4QqEmdf8mFQKXOoDzErjeMNXGjPt
         kvMEgx2e6EXuXgfiqT/Xgnz9C1Q75rstAgOxSLgZadjGPyjWntLkhIFbI0jsmOvU+Lhu
         mtw4q2AsNYCye7Aj7f8eSQKDf5iIiyVaIRVuFpY/F54uc0ZLROatnWps/sjooNoeRZg6
         A5gBMEik/l/FkmnCi+eismjnsNSfqYv7AGkD4ksgX2uskdjW8l2AXdfSpFr1wfPuMq96
         cTew==
X-Gm-Message-State: AJIora9WB7JDS1RakBKxMhuyf8OvnTUseRWkG8fVlOmuljXPATrMWjnm
        nH1gxM9mzcAvqwfbRo5C3a4ciw==
X-Google-Smtp-Source: AGRyM1vzV8t/NFxmlrbioqZlidD6qaapajGaXld+er4AVudrw4e+3F+0nTH5/wCK8ErRIl6XX2keVg==
X-Received: by 2002:a17:906:76c9:b0:726:f0f2:6504 with SMTP id q9-20020a17090676c900b00726f0f26504mr8121841ejn.213.1656588231034;
        Thu, 30 Jun 2022 04:23:51 -0700 (PDT)
Received: from [192.168.0.189] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q14-20020a1709066ace00b00722e603c39asm9018739ejs.31.2022.06.30.04.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 04:23:50 -0700 (PDT)
Message-ID: <1de5d955-91f9-032c-0ceb-2e48d04464dc@linaro.org>
Date:   Thu, 30 Jun 2022 13:23:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 1/4] dt-bindings: interconnect: qcom,msm8998-cpu-bwmon:
 add BWMON device
Content-Language: en-US
To:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh@kernel.org>
References: <20220629140302.236715-1-krzysztof.kozlowski@linaro.org>
 <20220629140302.236715-2-krzysztof.kozlowski@linaro.org>
 <55cf5a2f-7be2-bb65-09d6-d4d5af4d2f0f@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <55cf5a2f-7be2-bb65-09d6-d4d5af4d2f0f@quicinc.com>
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

On 30/06/2022 13:14, Rajendra Nayak wrote:
> 
> On 6/29/2022 7:32 PM, Krzysztof Kozlowski wrote:
>> Add bindings for the Qualcomm Bandwidth Monitor device providing
>> performance data on interconnects.  The bindings describe only BWMON CPU
>> (version 4), e.g. the instance which appeared for the first on Qualcomm
>> MSM8998 SoC and is also used on SDM845.  This BWMON device sits between
>> CPU and Last Level Cache Controller.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Acked-by: Georgi Djakov <djakov@kernel.org>
>> ---
>>   .../interconnect/qcom,msm8998-llcc-bwmon.yaml | 85 +++++++++++++++++++
>>   1 file changed, 85 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8998-llcc-bwmon.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-llcc-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-llcc-bwmon.yaml
>> new file mode 100644
>> index 000000000000..76e09658d615
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-llcc-bwmon.yaml
>> @@ -0,0 +1,85 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interconnect/qcom,msm8998-llcc-bwmon.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Interconnect Bandwidth Monitor
>> +
>> +maintainers:
>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> +
>> +description: |
>> +  Bandwidth Monitor measures current throughput on buses between various NoC
>> +  fabrics and provides information when it crosses configured thresholds.
>> +
>> +  Certain SoCs might have more than one Bandwidth Monitors, for example on SDM845::
>> +   - Measuring the bandwidth between CPUs and Last Level Cache Controller -
>> +     called LLCC BWMON,
>> +   - Measuring the bandwidth between Last Level Cache Controller and memory (DDR).
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - qcom,sdm845-llcc-bwmon
>> +          - const: qcom,msm8998-llcc-bwmon
>> +      - const: qcom,msm8998-llcc-bwmon       # BWMON v4
>> +
>> +  interconnects:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  operating-points-v2: true
>> +  opp-table: true
>> +
>> +  reg:
>> +    # BWMON v4 (currently described) and BWMON v5 use one register address
>> +    # space.  BWMON v2 uses two register spaces - not yet described.
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - interconnects
>> +  - interrupts
>> +  - operating-points-v2
>> +  - opp-table
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interconnect/qcom,sdm845.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    pmu@1436400 {
>> +        compatible = "qcom,sdm845-llcc-bwmon", "qcom,msm8998-llcc-bwmon";
> 
> so with this compatible fallback scheme, I am trying to understand what
> do I need to do if I have to add support for another SoC for instance.
> 
> I just update the binding with the new SoC compatible (lets say qcom,sc7280-llcc-bwmon)
> and in the device tree node use it as
> 	compatible = "qcom,sc7280-llcc-bwmon", "qcom,sdm845-llcc-bwmon", "qcom,msm8998-llcc-bwmon";
> without any updates in the driver?

I expect:
"qcom,sc7280-llcc-bwmon", "qcom,msm8998-llcc-bwmon";
and you need to add sc7280 compatible to the driver. The actual proper
solution in my patch would be to use msm8998 compatible in the driver,
but I did not test MSM8998.

Maybe we should switch to that anyway?

Best regards,
Krzysztof
