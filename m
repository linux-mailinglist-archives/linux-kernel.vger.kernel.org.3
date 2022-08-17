Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6045D596B54
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiHQI1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbiHQI1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:27:37 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CB67B1D3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:27:35 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id l10so12871854lje.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=AUEPEQrtzko3joxTi1sNDT6jkQbhLcJuQtYh6DenYSA=;
        b=nvE89qoyuJ5S85vyg4UJj47vgOJ1KSuQrxyguNw90tM3rZPQahsF/3uoGZDYB53L6V
         tOBSMt/rNLd3mHVs7bhbXRtoxQzf9viHfNIvOU/KJ7iE8nzhskPFLF4J4+kxXwHb4908
         8umXckfKAtfIzc2UNRFGJ6iI40vol9INqgR3SWmYBf6g3kPhirTObNp84j/9lfmCqtFP
         DuijiwVT6nMgeJkOZCc0vQAKzuE+Og0LsGyfvmYoRGz7Z3+LyQdJZNnf83NNaJt64o8D
         UZfjdgAhlldxoaqPaQgySeMH9Ha0u+HduSOuyUkLraniJcOjP6L5NlYG6JjipQdLcyHj
         tTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=AUEPEQrtzko3joxTi1sNDT6jkQbhLcJuQtYh6DenYSA=;
        b=MsXD7b/j41JL255M5Vl4ygmFiLVXiYDy/yZjdcHXUJNBGAfba3SS9ImF2ZJyT9zOWv
         aOUcdhjM12nkeSdS8KImNL125xg454LgEAmYLs3BoTPWu16KlhgI8k9Lia3r9ENwY5gu
         XZHvHCCgbKIEhbyR+aKlFeTDIck0mL5qfg4JqnWo3/GfFS08iZ+CburKDKnZly7HwiwZ
         2uMKc8CUQ3hu0Cl71WmDOShvwcdw+5KsIyQ92Pq6YC6ek1Yam83okY+PR2XY4BbqErLK
         B4LkQRdI7EC05OOmnoM4MZvJfQRw0jiVrluj5ppUY8cJKBEcQCvWpxKH+1TcjZOeOWWQ
         GG+g==
X-Gm-Message-State: ACgBeo1suYSLcyhE9NRsKphnPFlm8YgcTUe8tpGEcnzM2XSkxZA+UjYp
        4enzbeOD18xfFe/B/BhMP5FIPw==
X-Google-Smtp-Source: AA6agR5muIWF3q3plYn12f7zASTsP+6/wcsnnjxssIfFoa3erwi9zoCQbNgiFDsB6V6VUPtXloAiZw==
X-Received: by 2002:a2e:b8c2:0:b0:25f:f714:2e9f with SMTP id s2-20020a2eb8c2000000b0025ff7142e9fmr7243540ljp.95.1660724853551;
        Wed, 17 Aug 2022 01:27:33 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1b1c:14b7:109b:ed76? (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id p16-20020a056512139000b00492a0f02758sm316489lfa.28.2022.08.17.01.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 01:27:33 -0700 (PDT)
Message-ID: <29e6a293-29c4-a9ab-0767-9adfa982226b@linaro.org>
Date:   Wed, 17 Aug 2022 11:27:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/4] regulator: dt-bindings: Add Allwinner D1 LDOs
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220815043436.20170-1-samuel@sholland.org>
 <20220815043436.20170-2-samuel@sholland.org>
 <c4ec080a-b8b1-e3a9-c9d7-063e138c9bb8@linaro.org>
 <03de0f7b-9251-a5c0-91a1-5f2b5d41d8a0@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <03de0f7b-9251-a5c0-91a1-5f2b5d41d8a0@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2022 11:15, Samuel Holland wrote:

>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - allwinner,sun20i-d1-analog-ldos
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  nvmem-cells:
>>> +    items:
>>> +      - description: NVMEM cell for the calibrated bandgap reference trim value
>>> +
>>> +  nvmem-cell-names:
>>> +    items:
>>> +      - const: bg_trim
>>> +
>>> +patternProperties:
>>> +  "^(a|hp)ldo$":
>>> +    type: object
>>> +    $ref: regulator.yaml#
>>> +    unevaluatedProperties: false
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - nvmem-cells
>>> +  - nvmem-cell-names
>>> +
>>> +unevaluatedProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    audio-codec@2030000 {
>>> +        compatible = "simple-mfd", "syscon";
>>
>> This cannot be on its own. Both require device specific compatible.
> 
> Again, the device-specific compatible does not exist, because the binding for
> the audio codec has not been written (and it will be quite nontrivial).
> 
> So I can:
>   1) Leave the example as-is until the audio codec binding gets written,
>      and fill in the specific compatible at that time.
>   2) Remove the example, with the reasoning that the example really
>      belongs with the MFD parent (like for the other regulator). Then
>      there will be no example until the audio codec binding is written.
>   3) Drop the analog LDOs from this series entirely, and some parts
>      of the SoC (like thermal monitoring) cannot be added to the DTSI
>      until the audio codec binding is written.
> 
> What do you think?

How about just removing the audio-codec node? The schema is about
regulators, not audio-codec.

OTOH, if you have parent device schema, you could put the example only
there. But as I understand, you don't have, right?

> 
> The same question applies for the D1 SoC DTSI, where I use this same construct.

This is not correct and should be fixed. Either you add the schema with
compatible or please drop the device node from the DTSI.

> 
> (And technically this does validate with the current schema.)
> 
>>> +        reg = <0x2030000 0x1000>;
>>> +        ranges;
>>> +        #address-cells = <1>;
>>> +        #size-cells = <1>;
>>> +
>>> +        regulators@2030348 {
>>> +            compatible = "allwinner,sun20i-d1-analog-ldos";
>>> +            reg = <0x2030348 0x4>;
>>> +            nvmem-cells = <&bg_trim>;
>>> +            nvmem-cell-names = "bg_trim";
>>> +
>>> +            reg_aldo: aldo {
>>> +                regulator-min-microvolt = <1800000>;
>>> +                regulator-max-microvolt = <1800000>;
>>> +            };
>>> +
>>> +            reg_hpldo: hpldo {
>>> +                regulator-min-microvolt = <1800000>;
>>> +                regulator-max-microvolt = <1800000>;
>>> +            };
>>> +        };
>>> +    };
>>> +
>>> +...
>>> diff --git a/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
>>> new file mode 100644
>>> index 000000000000..e3e2810fb3d7
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
>>> @@ -0,0 +1,37 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/regulator/allwinner,sun20i-d1-system-ldos.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Allwinner D1 System LDOs
>>> +
>>> +description:
>>> +  Allwinner D1 contains a pair of general-purpose LDOs which are designed to
>>> +  supply power inside and outside the SoC. They are controlled by a register
>>> +  within the system control MMIO space.
>>
>> Fix order.
>>
>>
>>> +
>>> +maintainers:
>>> +  - Samuel Holland <samuel@sholland.org>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - allwinner,sun20i-d1-system-ldos
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +patternProperties:
>>> +  "^ldo[ab]$":
>>> +    type: object
>>> +    $ref: regulator.yaml#
>>> +    unevaluatedProperties: false
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +unevaluatedProperties: false
>>
>>
>> Example please.
> 
> Rob asked me to move the example to the parent binding, so I did. The example is
> added in patch 3.

Yeah, I noticed it later. It's fine.

Best regards,
Krzysztof
