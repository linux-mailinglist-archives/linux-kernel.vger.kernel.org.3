Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E84A4E45D2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbiCVSRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiCVSRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:17:05 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2307020186;
        Tue, 22 Mar 2022 11:15:37 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id w4so22684786edc.7;
        Tue, 22 Mar 2022 11:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=9c+q5A+g63Va4Id/tmRlrr68w+A/h9s1XNixEI8cdPY=;
        b=MZbbZEzDhqYnzreHZWQHLgQFRRKXCrimZZJ2PVoXf6sZGFi88PAoUvENr0F3uuFFaH
         BkDnVFYJmrWBE72nAhcFl87Q3BiNONwK3e1YjPiRO10fYOa6YGQbYuqNlV8y5V0uUV0V
         pIjA1iG9EtHdTP/Yn+eAWGa2cvbpOgZN9MHZW7oZJhdX4agmtNNWUCIMAS53OZb6WWBw
         8Af/qNNinP+OMwCHqIPlx2EVGbN/JcBa7YtqGa/Erg4O0CEV6cWtTRrta2vO7kzgDtrs
         QserO+vJ7S85En9VA42Dq84u7tzuQXbJkrkp8GlB+NccDFD2Ycy2Bn1VY8S1nDpsJ7os
         Tx9w==
X-Gm-Message-State: AOAM530y44U8T1x39KSnJ8m/B9ie1oRaVl9PKuS6ySXrdi5S3ufiJ2PE
        zviAgJbVDqb+adRUPfbNgXE=
X-Google-Smtp-Source: ABdhPJwkbOwQf7TAo9l37B0npu7WSJxyJ0dZLWCi2/outcxSGf3TiBsI3b27baCUKxtDm+/pazgL5A==
X-Received: by 2002:aa7:c881:0:b0:419:1a3d:4437 with SMTP id p1-20020aa7c881000000b004191a3d4437mr20895274eds.378.1647972935477;
        Tue, 22 Mar 2022 11:15:35 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id u9-20020a170906124900b006ce88a505a1sm9069026eja.179.2022.03.22.11.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 11:15:34 -0700 (PDT)
Message-ID: <30ec2e32-aa72-bfd5-9513-172b396d9424@kernel.org>
Date:   Tue, 22 Mar 2022 19:15:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4 18/18] dt-bindings: arm: msm: Convert kpss-gcc driver
 Documentation to yaml
Content-Language: en-US
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220321144825.11736-1-ansuelsmth@gmail.com>
 <20220321144825.11736-19-ansuelsmth@gmail.com>
 <a7837388-e36f-9e55-4107-9f7f85571f3b@kernel.org>
 <YjiWY9wxGMtUAcjY@Ansuel-xps.localdomain>
In-Reply-To: <YjiWY9wxGMtUAcjY@Ansuel-xps.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 16:14, Ansuel Smith wrote:
> On Mon, Mar 21, 2022 at 04:41:37PM +0100, Krzysztof Kozlowski wrote:
>> On 21/03/2022 15:48, Ansuel Smith wrote:
>>> Convert kpss-gcc driver Documentation to yaml.
>>>
>>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
>>> ---
>>>  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ------------
>>>  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 68 +++++++++++++++++++
>>>  2 files changed, 68 insertions(+), 44 deletions(-)
>>>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>>>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>>> deleted file mode 100644
>>> index e628758950e1..000000000000
>>> --- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>>> +++ /dev/null
>>> @@ -1,44 +0,0 @@
>>> -Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
>>> -
>>> -PROPERTIES
>>> -
>>> -- compatible:
>>> -	Usage: required
>>> -	Value type: <string>
>>> -	Definition: should be one of the following. The generic compatible
>>> -			"qcom,kpss-gcc" should also be included.
>>> -			"qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc"
>>> -			"qcom,kpss-gcc-apq8064", "qcom,kpss-gcc"
>>> -			"qcom,kpss-gcc-msm8974", "qcom,kpss-gcc"
>>> -			"qcom,kpss-gcc-msm8960", "qcom,kpss-gcc"
>>> -
>>> -- reg:
>>> -	Usage: required
>>> -	Value type: <prop-encoded-array>
>>> -	Definition: base address and size of the register region
>>> -
>>> -- clocks:
>>> -	Usage: required
>>> -	Value type: <prop-encoded-array>
>>> -	Definition: reference to the pll parents.
>>> -
>>> -- clock-names:
>>> -	Usage: required
>>> -	Value type: <stringlist>
>>> -	Definition: must be "pll8_vote", "pxo".
>>> -
>>> -- clock-output-names:
>>> -	Usage: required
>>> -	Value type: <string>
>>> -	Definition: Name of the output clock. Typically acpu_l2_aux indicating
>>> -		    an L2 cache auxiliary clock.
>>> -
>>> -Example:
>>> -
>>> -	l2cc: clock-controller@2011000 {
>>> -		compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc";
>>> -		reg = <0x2011000 0x1000>;
>>> -		clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
>>> -		clock-names = "pll8_vote", "pxo";
>>> -		clock-output-names = "acpu_l2_aux";
>>> -	};
>>> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
>>> new file mode 100644
>>> index 000000000000..20ee182eb16f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
>>> @@ -0,0 +1,68 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/arm/msm/qcom,kpss-gcc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
>>> +
>>> +maintainers:
>>> +  - Ansuel Smith <ansuelsmth@gmail.com>
>>> +
>>> +description: |
>>> +  Krait Processor Sub-system (KPSS) Global Clock Controller (GCC). Used
>>> +  to control L2 mux (in the current implementation).
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - qcom,kpss-gcc-ipq8064
>>> +          - qcom,kpss-gcc-apq8064
>>> +          - qcom,kpss-gcc-msm8974
>>> +          - qcom,kpss-gcc-msm8960
>>> +      - const: qcom,kpss-gcc
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    items:
>>> +      - description: phandle to pll8_vote
>>> +      - description: phandle to pxo_board
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: pll8_vote
>>> +      - const: pxo
>>> +
>>> +  clock-output-names:
>>> +    const: acpu_l2_aux
>>> +
>>> +  '#clock-cells':
>>> +    const: 0
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - clocks
>>> +  - clock-names
>>> +  - clock-output-names
>>> +  - '#clock-cells'
>>
>> You add here a new required property, so this is not a pure conversion.
>> Please explain in the commit msg why are you doing this. I asked about
>> this in your previous patchset.
>>
>> Best regards,
>> Krzysztof
> 
> Sorry I probably missed it. Just to make sure you are referring to
> #clock-cells?
> Since this expose a clock, clock-cells is required. Should I put this in
> a different commit? 

Yeah, clock-cells. It's enough to mention it in commit msg.


Best regards,
Krzysztof
