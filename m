Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255065667CC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiGEKXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGEKXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:23:13 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E25D140D9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:23:11 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q8so1478779ljj.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 03:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hkwPfIALvdSAU2N+QXSkCqGtHG+6iyMXOJOvPCyiJGw=;
        b=DkaKRWBO09Bt2yF50Bv2PtP2qHgMg2KEOaGzBjYBoFxhX6fe2VO9yY9e34yUmIN/Ri
         oytrJjsQsF9fhlM5rYSX2RQyWNfu6uXCBCbsErDdTTpvJhgdmTFZ2rfRCw0nS+bS840S
         h2KMdRVwicolslBHijie/QN9nSpJ2L0+P/pMPiMkbh2xuilR8LLVAOWNGdrVqnF/bKyr
         IK1v7AzELoGJdsXlsMzH7e03vmBwkrmwfV/ZsH0I3AZRUbfLhFVxTVLhuhvkxm+aT+Jv
         pPQ8Lz/NSVpUeIU8iGxOpCD8onXdJoHKVcN6+JzHqcJ7hzGalSI28JF1L6YG9fGpdssg
         JSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hkwPfIALvdSAU2N+QXSkCqGtHG+6iyMXOJOvPCyiJGw=;
        b=S0Q70gpamsbK3mRiHnHzBeIlDiht5wpFIpkKmIdodrfE64W2DZkcd7SKpNG9Aox1AG
         KW4QoOKFCtsPCCvHiUHnpgzXruKjEOOoGtFb7flMfc9F/k0yo5UPTrTBgTlpmVwnPBrm
         V6V4s7S+niOO2u+ANwwK9ANdNvEuNOqbSkLcERYIb91FTfDSwjf8rhZLRxkzZKU4oGJo
         0FxwNkCC3ReaQPKfUkd+59f9uWVOX+NDKP/tJlaQ1SutM2uhvqDMrSvmpnaFuveNZtrB
         r+R+maHJjTms1ZSrJsT34+fi6fXXyGWM1YjJRYOTExtmKFHL5HCHPVlXnurjc/BG1dov
         x3Qw==
X-Gm-Message-State: AJIora+Q+YKfZW6b5GZtQDYKla7E2zHDluJeZk51xG2s0Geo4Ctbo3bt
        8z5tlzenJxHipxAz03H7i+wB9g==
X-Google-Smtp-Source: AGRyM1tK6aV4ED+ArkEi6a0TDdCwN3rOkmF5CvDjTenVKYf3MB0Hfzxm32KYRLOcIqfP845yDk0iEw==
X-Received: by 2002:a2e:9dcb:0:b0:25d:16eb:2671 with SMTP id x11-20020a2e9dcb000000b0025d16eb2671mr8829879ljj.46.1657016589353;
        Tue, 05 Jul 2022 03:23:09 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0025a725af81csm5479239ljc.39.2022.07.05.03.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 03:23:08 -0700 (PDT)
Message-ID: <1053b27f-37f8-a94d-2868-1e2b200d822a@linaro.org>
Date:   Tue, 5 Jul 2022 12:23:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 06/43] dt-bindings: phy: qcom,qmp: split out
 msm8996-qmp-pcie-phy
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-7-johan+linaro@kernel.org>
 <46b0cdab-aa94-7f55-5d9f-f79a644f0fec@linaro.org>
 <YsQQfwqmiQ7O3FdY@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YsQQfwqmiQ7O3FdY@hovoldconsulting.com>
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

On 05/07/2022 12:20, Johan Hovold wrote:
> On Tue, Jul 05, 2022 at 12:08:36PM +0200, Krzysztof Kozlowski wrote:
>> On 05/07/2022 11:42, Johan Hovold wrote:
>>> The QMP PHY DT schema is getting unwieldy. Break out the odd-bird
>>> msm8996-qmp-pcie-phy which is the only QMP PHY that uses separate
>>> "per-lane" nodes.
>>>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
>>>  .../phy/qcom,msm8996-qmp-pcie-phy.yaml        | 114 ++++++++++++++++++
>>>  .../devicetree/bindings/phy/qcom,qmp-phy.yaml |  32 -----
>>>  2 files changed, 114 insertions(+), 32 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
>>> new file mode 100644
>>> index 000000000000..14fd86fd91ec
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
>>> @@ -0,0 +1,114 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +
>>
>> No line break
>>
>>> +%YAML 1.2
>>> +---
>>> +$id: "http://devicetree.org/schemas/phy/qcom,msm8996-qmp-pcie-phy.yaml#"
>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>
>> Drop the quotes from two above.
> 
> This comes from the current binding. I can clean that one up first.

You now selectively copy pieces from old binding into new one. Copy
while correcting obvious issues.

> 
>>> +
>>> +title: Qualcomm QMP PHY controller (MSM8996 PCIe)
>>> +
>>> +maintainers:
>>> +  - Vinod Koul <vkoul@kernel.org>
>>> +
>>> +description:
>>> +  QMP PHY controller supports physical layer functionality for a number of
>>> +  controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: qcom,msm8996-qmp-pcie-phy
>>> +
>>> +  reg:
>>> +    minItems: 1
>>> +    items:
>>> +      - description: Address and length of PHY's common serdes block.
>>> +      - description: Address and length of PHY's DP_COM control block.
>>
>> Are two reg items applicable here?
> 
> No, but see below.
> 
>>> +
>>> +  "#address-cells":
>>> +    enum: [ 1, 2 ]
>>> +
>>> +  "#size-cells":
>>> +    enum: [ 1, 2 ]
>>> +
>>> +  ranges: true
>>> +
>>> +  clocks:
>>> +    minItems: 1
>>> +    maxItems: 4
>>
>> Define clocks here, not in allOf:if:then.
> 
> To remain sane, and to help reviewers, I decided not to do changes to
> the binding while splitting it up which would only make them harder
> to review.
> 
> Hence the split followed by cleanup/tightening of constraints.

It's confusing. I look at this commit and it is not correct. How do I
know that next commits will correct it? I responded in further patches
that most of them they should be squashed with this copy.

> 
>> How about an example?
> 
> That's also a new addition to the binding and goes in a later separate
> patch.
> 



Best regards,
Krzysztof
