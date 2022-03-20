Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C77C4E1C14
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 15:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245279AbiCTOs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 10:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238877AbiCTOs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 10:48:56 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A4C8BF11;
        Sun, 20 Mar 2022 07:47:31 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id t1so15308506edc.3;
        Sun, 20 Mar 2022 07:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=uejOS6QLMjmUowzupThvyDhrrSMU4zNF1nSVHZ+xCUA=;
        b=DNr9+gJkf+pAiptcTqATo7pbMchuB28sFFfaUX+6sDOUrHqc7vxTC6nAFSHB45wPim
         uzvbUoFCDlJVi1d6UwnXQzR4gfdO2hbwF84qDtG5UBmKrTqoBcoj3mmSwL3btR8ni/Un
         f19QeICLvoEa+IaOnahpT0ZQn1udX442VaveTh6iWdc604TJTMxYhuDNerD2HnGrcOQ7
         Rx+Tk0xkNth+NkbLz+UlMqbCTbIhqXAEPB11eKNMkKl3BY77Y9l6grYQJ3NonWGCgvLr
         QjygkGwSG6LZJWgrdOYhqS+3lLUz87TEWyRqv3IxY2j1N6BaHAel6H/CBM9KEq38KQDh
         7qPg==
X-Gm-Message-State: AOAM53043gBA4KFvE1VfwrMko8TPQpf+6Nt7tYt4k3jLK9eYY9EkKzdC
        Rt8bnuC+qZkS5Gtzm1UBb9J5Q+9Vjqo=
X-Google-Smtp-Source: ABdhPJxZj2xyJeSCvP0JCmAUEZBA3vK91nQohCbqtqn/Vo33xsUJfdEPtxzDD8Sw/p4IJW2f/l4lIA==
X-Received: by 2002:aa7:c30f:0:b0:419:2af:4845 with SMTP id l15-20020aa7c30f000000b0041902af4845mr14935974edq.296.1647787649828;
        Sun, 20 Mar 2022 07:47:29 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id j22-20020a50ed16000000b00419366b2146sm602048eds.43.2022.03.20.07.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 07:47:29 -0700 (PDT)
Message-ID: <ae9a0e80-d9a5-320f-f1d5-9666633a6a87@kernel.org>
Date:   Sun, 20 Mar 2022 15:47:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 16/16] dt-bindings: arm: msm: Convert kpss driver
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
References: <20220318160827.8860-1-ansuelsmth@gmail.com>
 <20220318160827.8860-17-ansuelsmth@gmail.com>
 <45e4f763-d991-0939-3735-bfea05c48143@kernel.org>
 <YjbvpN5S77cyyN/U@Ansuel-xps.localdomain>
In-Reply-To: <YjbvpN5S77cyyN/U@Ansuel-xps.localdomain>
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

On 20/03/2022 10:11, Ansuel Smith wrote:
> On Sun, Mar 20, 2022 at 01:05:51PM +0100, Krzysztof Kozlowski wrote:
>> On 18/03/2022 17:08, Ansuel Smith wrote:
>>> Convert kpss-acc and kpss-gcc Documentation to yaml. Fix multiple
>>> Documentation error and provide additional example for kpss-gcc-v2.
>>>
>>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
>>> ---
>>>  .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 ----------
>>>  .../bindings/arm/msm/qcom,kpss-acc.yaml       | 97 +++++++++++++++++++
>>>  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ---------
>>>  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 63 ++++++++++++
>>>  4 files changed, 160 insertions(+), 93 deletions(-)
>>>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
>>>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
>>>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>>>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
>>> deleted file mode 100644
>>> index 7f696362a4a1..000000000000
>>> --- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
>>> +++ /dev/null
>>> @@ -1,49 +0,0 @@
>>> -Krait Processor Sub-system (KPSS) Application Clock Controller (ACC)
>>> -
>>> -The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
>>> -There is one ACC register region per CPU within the KPSS remapped region as
>>> -well as an alias register region that remaps accesses to the ACC associated
>>> -with the CPU accessing the region.
>>> -
>>> -PROPERTIES
>>> -
>>> -- compatible:
>>> -	Usage: required
>>> -	Value type: <string>
>>> -	Definition: should be one of:
>>> -			"qcom,kpss-acc-v1"
>>> -			"qcom,kpss-acc-v2"
>>> -
>>> -- reg:
>>> -	Usage: required
>>> -	Value type: <prop-encoded-array>
>>> -	Definition: the first element specifies the base address and size of
>>> -		    the register region. An optional second element specifies
>>> -		    the base address and size of the alias register region.
>>> -
>>> -- clocks:
>>> -        Usage: required
>>> -        Value type: <prop-encoded-array>
>>> -        Definition: reference to the pll parents.
>>> -
>>> -- clock-names:
>>> -        Usage: required
>>> -        Value type: <stringlist>
>>> -        Definition: must be "pll8_vote", "pxo".
>>> -
>>> -- clock-output-names:
>>> -	Usage: optional
>>> -	Value type: <string>
>>> -	Definition: Name of the output clock. Typically acpuX_aux where X is a
>>> -		    CPU number starting at 0.
>>> -
>>> -Example:
>>> -
>>> -	clock-controller@2088000 {
>>> -		compatible = "qcom,kpss-acc-v2";
>>> -		reg = <0x02088000 0x1000>,
>>> -		      <0x02008000 0x1000>;
>>> -		clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
>>> -		clock-names = "pll8_vote", "pxo";
>>> -		clock-output-names = "acpu0_aux";
>>> -	};
>>> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
>>> new file mode 100644
>>> index 000000000000..6e8ef4f85eab
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
>>> @@ -0,0 +1,97 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/arm/msm/qcom,kpss-acc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Krait Processor Sub-system (KPSS) Application Clock Controller (ACC)
>>> +
>>> +maintainers:
>>> +  - Ansuel Smith <ansuelsmth@gmail.com>
>>> +
>>> +description: |
>>> +  The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
>>> +  There is one ACC register region per CPU within the KPSS remapped region as
>>> +  well as an alias register region that remaps accesses to the ACC associated
>>> +  with the CPU accessing the region.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - qcom,kpss-acc-v1
>>> +      - qcom,kpss-acc-v2
>>> +
>>> +  reg:
>>> +    items:
>>> +      - description: Base address and size of the register region
>>> +      - description: Optional base address and size of the alias register region
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
>>> +    description: Name of the aux clock. Krait can have at most 4 cpu.
>>> +    enum:
>>> +      - acpu0_aux
>>> +      - acpu1_aux
>>> +      - acpu2_aux
>>> +      - acpu3_aux
>>> +
>>> +  '#clock-cells':
>>> +    const: 0
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>
>> This is not obvious from the original bindings. Why are these required
>> only on v1? Whatr about v2? Are they allowed on v2? Why at least
>> clock-cells are not required on v2?
>>
> 
> The original Documentation was a joke. I should have also write it in
> the cover letter. v2 doesn't export clocks and just expose the kpss
> regs. Doesn't provide any mux / clocks. It's really an entirely
> different implementation. Aka the Documentation was wrong from the
> start.

OK, thanks for explanation. Please mention it in the commit msg.

> 
>> The previous bindings make them required which you change here. Your
>> commit does not explain this.
>>
>> Please explicitly explain in commit msg all changes to the bindings
>> which are necessary for conversion.
>>
>>> +            const: qcom,kpss-acc-v1
>>> +      then:
>>> +        required:
>>> +          - clocks
>>> +          - clock-names
>>> +          - clock-output-names
>>> +          - '#clock-cells'
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
>>> +
>>> +    clock-controller@2088000 {
>>> +      compatible = "qcom,kpss-acc-v1";
>>> +      reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
>>> +      clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
>>> +      clock-names = "pll8_vote", "pxo";
>>> +      clock-output-names = "acpu0_aux";
>>> +      #clock-cells = <0>;
>>> +    };
>>> +
>>> +    clock-controller@2098000 {
>>> +      compatible = "qcom,kpss-acc-v1";
>>> +      reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
>>> +      clock-output-names = "acpu1_aux";
>>> +      clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
>>> +      clock-names = "pll8_vote", "pxo";
>>> +      #clock-cells = <0>;
>>
>> It's the same example as above, no differences. Remove it.
>>
> 
> Mhh this is a direct example on how the kpss-acc are defined for ipq806x
> with a configuration with 2 cpu. Tell me if I should really remove it or
> not.

Yeah, but all properties are exactly the same, there is no difference
here, so this as an example does not bring additional information.

> 
>>> +    };
>>> +
>>> +  - |
>>> +    clock-controller@f9088000 {
>>> +      compatible = "qcom,kpss-acc-v2";
>>> +      reg = <0xf9088000 0x1000>,
>>> +            <0xf9008000 0x1000>;
>>
>> You now changed the example. This looks wrong.
>>
> 
> Again the example was wrong from the start. There isn't ANY kpss v2 that
> exports clock and the driver that expose the aux clocks have just the
> compatible for v1. (that is correct)

OK, please also mention it in commit msg.

> 
>>> +    };
>>> +...
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
>>> index 000000000000..578e2eccb7db
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
>>> @@ -0,0 +1,63 @@
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
>>> +    const: qcom,kpss-gcc
>>
>> This is wrong conversion. You removed quite a lot.
>>
> 
> The driver doesn't have any support for it and we have no user for
> kpss-gcc. Again another Documentation that was pushed for the sake of it
> with no real user/no sense at all. Tell me if I should keep random
> compatible anyway. Should't be better to fix them for good and make devs
> add a specific compatible when the driver actually add support for them?

We talk here mostly about bindings, not driver, so the driver's
implementation matters less. IOW, driver does not have to implement all
compatibles from bindings. Bindings can be used in other projects,
outside of mainline kernel, so the compatibles actually might be useful.

These compatibles might be reasonable even if not implemented in the
driver, without real user.

More important question is whether these compatibles make sense. That
part I don't exactly now. You used term "random compatible", so are they
really random? To me they look like specific implementation of GCC, so
they look reasonable, but I know nothing about Qualcomm Krait and GCC.

> 
>> Please split this commit into two separate conversions (acc and gcc).
>>
> 
> Will do.
> 
>>> +
>>> +  reg:
>>> +    items:
>>> +      - description: Base address and size of the register region
>>
>> Just maxItems:1. No need for items and description - it's obvious.
>>
> 
> Ok.
> 
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
>>
>>
>> Best regards,
>> Krzysztof
> 
> I hope I don't look rude with my response. The Documentation for this
> stuff is really old and was pushed randomly. Guess how fun it was to
> discover that NONE of them were actually right and we have this from
> ages broken. Will for sure improve the commit description.
> 
> Also considering how brake they are should I really do a direct
> conversion and then fix them? Instead of dropping them for good and
> reimplement them the correct way directly?

It depends. If the bindings are really wrong, usually we combine the
changes necessary for conversion in one commit. Tweaking compatibles to
real life or adding new compatibles - maybe better in a separate commit.

Best regards,
Krzysztof
