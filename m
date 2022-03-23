Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C2B4E4FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243380AbiCWKBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 06:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239268AbiCWKBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:01:12 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36C375C37;
        Wed, 23 Mar 2022 02:59:42 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id r22so1704019ejs.11;
        Wed, 23 Mar 2022 02:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=RkfMRwQ+lzNAq0Y79wKv+fIuubMsSf8cziDDSaFTilM=;
        b=sYViR/5W1aINEirPPtsZ4Pe9BasCo37hI/1QbOqMVG9EpWNqCSGfJVQzgl09HG/8a9
         48Albv+u8wkdrWBcdkivscKn8TB3P4dPCfLo+H5jHWYs9nWrGBVGTD5eNXcWtXFxQpSK
         Lu4PriSxbd3d9SYHQRrCRXKuVI9qajrF3AYMlYV+ditXGY0zpeG3adiEo6N1aSzDfUp/
         jb0R2YtItmyZmwdGkH1G3f1T5N8wsbKlgRT5ytYpvlTjwVDKeBYcIPjqjP7tmkLVUfDP
         SaD5sHFOG712AQ2fVdOlAF/GzjDihq4WH8R7PUzU8o/qPRowx2QZDardBBvtbrR/388m
         AcUg==
X-Gm-Message-State: AOAM532kcHku9SZpfVV58YqZ6Mj/x+AlsGDVnakrAqdBYco3sNNti3pC
        WJcCq2R7x2LdcRlKKyMnMxA=
X-Google-Smtp-Source: ABdhPJwjV+ei6iKYAvFwt4ijhV80vJ+s3wmOKfaFxFMyXsM5AGVP3dJvLED3a7u2jEgvijnDBfVk/w==
X-Received: by 2002:a17:907:3e0d:b0:6e0:5c27:a184 with SMTP id hp13-20020a1709073e0d00b006e05c27a184mr3041967ejc.355.1648029581079;
        Wed, 23 Mar 2022 02:59:41 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id yy18-20020a170906dc1200b006d6e5c75029sm9447882ejb.187.2022.03.23.02.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:59:40 -0700 (PDT)
Message-ID: <f13fdc4b-8f45-b09f-5d58-8d2a565e2c18@kernel.org>
Date:   Wed, 23 Mar 2022 10:59:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v6 17/18] dt-bindings: arm: msm: Convert kpss-gcc driver
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
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
 <20220321231548.14276-18-ansuelsmth@gmail.com>
 <e832516d-277d-6a0b-4588-b32a085185c8@kernel.org>
 <YjnOdYMS+P85pqvF@Ansuel-xps.localdomain>
In-Reply-To: <YjnOdYMS+P85pqvF@Ansuel-xps.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 14:26, Ansuel Smith wrote:
> On Tue, Mar 22, 2022 at 11:07:26AM +0100, Krzysztof Kozlowski wrote:
>> On 22/03/2022 00:15, Ansuel Smith wrote:
>>> Convert kpss-gcc driver Documentation to yaml. Since kpss-gcc expose a
>>> clock add the required '#clock-cells' binding while converting it.
>>>
>>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
>>> ---
>>>  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ------------
>>>  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 69 +++++++++++++++++++
>>>  2 files changed, 69 insertions(+), 44 deletions(-)
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
>>> index 000000000000..7eb852be02c1
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
>>> @@ -0,0 +1,69 @@
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
>>> +      - const: syscon
>>
>> There was no syscon here before. This is not explained in commit msg or
>> patch history, while I asked to document explicitly any deviation from
>> the conversion.
>>
>> This is not how the process works. You keep making silent/hidden changes
>> to the bindings and to the patch submission process. It's difficult to
>> review and it is even more difficult to trust you that you implement
>> what we ask for. You keep resending versions of the patchset the same
>> day (two versions yesterday, shortly after another one) which does not
>> give time to react and review. Plus then you hide some more changes to
>> regular conversion without explaining them.
>>
>> NAK. It's really bad process. :(
>>
>>
>> Best regards,
>> Krzysztof
> 
> The thing is that i'm trying to fix all the mess of years of keeping bad
> Documentation and having dts that never followed Documentation. It's
> really nothing silent/hidden. You add review tag to a patch? That won't
> change. The bot alert me of some bugs? I push another revision with the
> bug fixed. 

It does not necessarily mean that bindings are bad and such changes
should be documented.

> (I understand I should not send that much revision in the
> same day but still considering the slow process of reviewing the c code,
> I prefer to keep the Documentation part correct and ready)

Rob also pointed to this - sending two versions of this huge patchset
the same day is way too much.

> 
> If you notice the changes across the different patch, it's very minimal
> and 99% of it has not changed. Nothing silent just me addressing warning
> from the bot. About the trust issue...
> Is it really a syscon addition that bad? Again the original
> Documentation was just bad so why should we care to have a 100% 1:1
> conversion if it should have been not accepted in the first place.

Does not have to be 100% but deviations should be either expected or
explained. Bindings are used also outside of Linux kernel.

> The addition of this new syscon is because in the current dtsi it's
> there and I assume it's there as this is a global accessor and probably
> other driver would access the same regs (so it's also a syscon)

If these are assumptions, then they need to be checked. If these were
new bindings, we would discuss/check the need of syscon. Now we do not
question existing properties, because they were accepted. But syscon
compatible was not accepted, so putting it here requires our acknowledgment.

The bindings are probably pure junk, so this is not merely a conversion
how you wrote in commit msg. This is rework of the bindings. Don't hide
rework under "conversion". Conversion is TXT->YAML without any changes...

I asked about this before and the only part you added to commit msg was
"clock-cells". And now I see syscon - so isn't it a bit surprising?

> 
> I understand the complain about putting too much revision... But NAK
> this cause I'm trying to fix all this mess just because more and more
> problems are coming up and I'm trying to fix them. It's a bit sad.

Why you cannot test your changes and fix them all before sending sixth
version? Why the bot has to test your code, not you?

> Hope you can understand that it's not my interest to push silent changes
> or other nasty stuff. It's just me fixing the mess and trying to at
> least have the Documentation part ready while I wait for c code review.
Best regards,
Krzysztof
