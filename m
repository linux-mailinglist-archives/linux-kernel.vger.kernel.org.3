Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AA855006C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383304AbiFQXMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383221AbiFQXMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:12:10 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A2864BFC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:12:06 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 187so5317265pfu.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=294ojvCzJG+QxzRogH/Uf6cGP9X/olCBo7vsCMUaWUs=;
        b=rRMAv5j+Hd/iJN32vcBDVL12U3rDEOOrDCl0MNjeuoB8nfWV1YTHVPRQxhLQzoJgkX
         ZJG8iKXWOMEzcoSSx4BzvL4tW/FkQYqnQyv12OpGhLHgnqsF6MA0Zv/JSKUyme4TAdC1
         PK4UNdO1p7nq6ua9IRX7f5y8kq4TRP0rZ11wo6jCd21bxBCR0qCtS3EqGZPgSOcsLfsG
         FG4f5UYmY07Jsv9z6xEuBtiNjJlIeAgxtaZTK9tJdqWjWANTPiGOVJybe7hvJ9oZqXL9
         HFn/y5aQTdGOOA9aVIAvXAe7Q0YJ5X8tMP0RYR8Qd7xIDEPKM+u0LrMy9wJIkIzH20SK
         yGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=294ojvCzJG+QxzRogH/Uf6cGP9X/olCBo7vsCMUaWUs=;
        b=eMYAbXkogkt95tAth4gbPWlzqZC6xnNnlXzSha2doWZ6ybIASWdLAPKABpXluoancQ
         bjS/oJcivuc1dwrdpe/2L2Kkos9kYVEGjcH6ks07voI40zXZf1X84lEZregpniDlASuS
         W+pZLWXZ7eE/gdwvBHtltVds/4PSn2NwQm6wH7CyWxknwJ4X8wQfnwDp7x5e8RjISaiM
         MVO1uAV2ewWu2g4H+mvJfc0xqTjaMYSft1UMDVdNI++iltzjv3dLMT+skjWNMZnoQsCx
         B9CoV20j4gAJs/n4kUSbXGYmEsP3cG77CWJq6s2O+0FaFWvrLaK7fHGRTPjlVhL0haZT
         q+jA==
X-Gm-Message-State: AJIora8ePzFGNslXV0Yzg+eNW8xW42IsO0G2kawUIciFz6Dla0xwncbV
        Mw0xI0uz7jddWhOEm3CcLL4MlA==
X-Google-Smtp-Source: AGRyM1stFAPlhmMkLY1NazO67J7oIwcpQv5+571CFcD+wsnGDHo4hdZrZyBBUSUL5SYGrTcERU92tQ==
X-Received: by 2002:a63:4f05:0:b0:405:5463:2ea8 with SMTP id d5-20020a634f05000000b0040554632ea8mr10679545pgb.94.1655507526105;
        Fri, 17 Jun 2022 16:12:06 -0700 (PDT)
Received: from [172.31.235.92] ([216.9.110.6])
        by smtp.gmail.com with ESMTPSA id c2-20020a639602000000b003fb098151c9sm4301292pge.64.2022.06.17.16.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 16:12:05 -0700 (PDT)
Message-ID: <b59237c7-fb60-35e2-66f9-668d9946bd3c@linaro.org>
Date:   Fri, 17 Jun 2022 16:12:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 02/15] dt-bindings: power: supply: Add Mediatek MT6370
 Charger
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, matthias.bgg@gmail.com,
        lee.jones@linaro.org, Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, ChiaEn Wu <chiaen_wu@richtek.com>
References: <20220613111146.25221-1-peterwu.pub@gmail.com>
 <20220613111146.25221-3-peterwu.pub@gmail.com>
 <dd9b9be2-7bdf-6cb6-b8ad-d7c0a0d5b98a@linaro.org>
 <CABtFH5+5Y5Tq3vO6Sg3kf98CWm9Aijv7qkdBcpm2SB0JZ1gCiA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CABtFH5+5Y5Tq3vO6Sg3kf98CWm9Aijv7qkdBcpm2SB0JZ1gCiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2022 03:19, ChiaEn Wu wrote:
> Hi Krzysztof,
> 
> Thanks for your helpful comments! I have so some questions want to ask
> you below.
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 於 2022年6月17日 週五 清晨5:05寫道：
>>
>> On 13/06/2022 04:11, ChiaEn Wu wrote:
>>> From: ChiaEn Wu <chiaen_wu@richtek.com>
>>>
>>> Add Mediatek MT6370 Charger binding documentation.
>>>
>>> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
>>> ---
>>>  .../power/supply/mediatek,mt6370-charger.yaml | 60 +++++++++++++++++++
>>>  1 file changed, 60 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml b/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml
>>> new file mode 100644
>>> index 000000000000..b63553ebb15b
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml
>>> @@ -0,0 +1,60 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/power/supply/mediatek,mt6370-charger.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Mediatek MT6370 Battery Charger
>>> +
>>> +maintainers:
>>> +  - ChiaEn Wu <chiaen_wu@richtek.com>
>>> +
>>> +description: |
>>> +  This module is part of the MT6370 MFD device.
>>> +  Provides Battery Charger, Boost for OTG devices and BC1.2 detection.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: mediatek,mt6370-charger
>>> +
>>> +  interrupts:
>>> +    description: |
>>> +      Specify what irqs are needed to be handled by MT6370 Charger driver. IRQ
>>> +      "MT6370_IRQ_CHG_MIVR", "MT6370_IRQ_ATTACH" and "MT6370_IRQ_OVPCTRL_UVP_D"
>>> +      are required.
>>> +    items:
>>> +      - description: BC1.2 done irq
>>> +      - description: usb plug in irq
>>> +      - description: mivr irq
>>> +
>>> +  interrupt-names:
>>> +    items:
>>> +      - const: attach_i
>>> +      - const: uvp_d_evt
>>> +      - const: mivr
>>> +
>>> +  io-channels:
>>> +    description: |
>>> +      Use ADC channel to read vbus, ibus, ibat, etc., info. Ibus ADC channel
>>> +      is required.
>>
>> Add io-channel-names and describe each item - what type of ADC it is
>> expected to be.
>>
> 
> I'm afraid I might not be understanding what you mean.
> I will try to add some text in "description" and "io-channel-names", like below
> ----------------------------------
> io-channels:
>   description: |
>     Use ADC channel to read VBUS, IBUS, IBAT, etc., info. Ibus ADC channel
>     is required. It can be seen in
> include/dt-bindings/iio/adc/mediatek,mt6370_adc.h
>   minItems: 1
>   maxItems: 9
> 
> io-channel-names:
>   items:
>     - const: vbusdiv5
>     - const: vbusdiv2

Almost. The best would be something like this:
Documentation/devicetree/bindings/power/supply/cpcap-charger.yaml
so also "items" with description under "io-channels". You need to skip
maxItems in such case (keep minItems).

>     - ...
> ----------------------------------
> Did these modifications meet your expectations?
> 
>>> +    minItems: 1
>>> +    maxItems: 9
>>> +
>>> +  usb-otg-vbus-regulator:
>>> +    type: object
>>> +    description: OTG boost regulator.
>>> +    $ref: /schemas/regulator/regulator.yaml#
>>
>> unevaluatedProperties: false
> 
> I will add this in the next patch.
> 
>>
>>> +
>>> +    properties:
>>> +      enable-gpio:
>>
>> "gpios", so:
>> enable-gpios
> 
> If this otg regulator only uses one GPIO Pin, do I still need to
> change to "gpios"?

Yes, because "gpios" is the preferred suffix. This is requirement for
all such properties. enable-gpios are also documented here:
Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml


> If so, I will refine it along with the regulator "enable-gpio" in MFD
> dt-binding.

Yes, there it should be "enable-gpios" as well.




Best regards,
Krzysztof
