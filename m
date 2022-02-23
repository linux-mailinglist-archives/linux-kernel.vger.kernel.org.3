Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8AC4C1D20
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 21:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241166AbiBWU1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 15:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241156AbiBWU1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 15:27:01 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148174D9C0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:26:30 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so33723wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sJPlOaClwDYorktbDkd9+wDzEANKDnxO5CFuBVYHXe8=;
        b=BEEfhcPqiI+WT+Dpz7WzsUiLQTWWnMGmqoexEhw593Y8ZxjjKAZ7ao2qeB0VJZJh6k
         yBSGlRqkEIG8RCxnec2/BV4zUIEGx0OF8Z0I0bfqTwNgOa8x2ncKzuh104dOuGOtZ1lS
         Pl/HqYC6zKa9tsnnoJscfu/xMTAhahGI5qwNHxSmIynWSvlwR86mIWhHPYc3H0lbSp+i
         UFJZV0nEkO21ekUFWgd1zv3VMvxZCBmYVbVBhy9itkQQJOjFmaPzXJ+ryFjhgtMhYpFO
         ytEG9yc9J0dhY3k/Wlf+8huRfPo9Ivl7hXHsdB3UaPNiuB4LmsG/qt6jMKj3PfSqG7TA
         vWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sJPlOaClwDYorktbDkd9+wDzEANKDnxO5CFuBVYHXe8=;
        b=It3FtZSlQNcRagzJuKka2i3Qrwbed7RRFx7IvbDrMDS8sDe5b+kdWWuB8CFy6lYy93
         K5g8oiu9VockvZ/s7k5/C29F310Hl29IkQ8ITGJu3bfRw+wudF0Jehe/dxZsXzlurcBf
         y7KF/BHsJ4a9KMhXdB0XTOHZ3OqtoCsBuJDjDGRNUnwabeM25mr+9QJxgNTcyqbkiZYh
         ZXfGPBR24LHnAlrgBFOlfgHtB9BgM5QVQrEbtUZw2jB4y6ysjvWYl9krH0Cu6jOVZ5O3
         ZmbXLF6elSp/i1DxgLiq9QyKKyJTjzTmjEBpZsVJqNpU5qJwOhJ0Ybw8BkTFHXVgjNhd
         K8vQ==
X-Gm-Message-State: AOAM531/rKAGhBcgrXonv0E6x9tENqZ5i54xELUP0W/kwF5fkggUEOOl
        0V5ghTCHMDqmfCLigYRZN/N0Wg==
X-Google-Smtp-Source: ABdhPJwe3rIUpO4EQyWFQvq2poGfUjKuImrMQv+GNJQxf6u9vnwiDVZXhTabIndzGbOLOUpAfeVMzA==
X-Received: by 2002:a05:600c:4fd6:b0:352:c2c6:8f34 with SMTP id o22-20020a05600c4fd600b00352c2c68f34mr9133943wmq.186.1645647988449;
        Wed, 23 Feb 2022 12:26:28 -0800 (PST)
Received: from [192.168.2.116] ([109.76.226.172])
        by smtp.gmail.com with ESMTPSA id e3sm466620wrr.94.2022.02.23.12.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 12:26:27 -0800 (PST)
Message-ID: <08bed815-5f34-634f-df6d-7c7371c33033@conchuod.ie>
Date:   Wed, 23 Feb 2022 20:26:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v7 03/11] dt-bindings: rtc: add bindings for microchip
 mpfs rtc
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Conor.Dooley@microchip.com
Cc:     a.zummo@towertech.it, Lewis.Hanly@microchip.com,
        Daire.McNamara@microchip.com, Ivan.Griffin@microchip.com,
        atishp@rivosinc.com, palmer@rivosinc.com, robh@kernel.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, geert@linux-m68k.org,
        krzysztof.kozlowski@canonical.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220214135840.168236-1-conor.dooley@microchip.com>
 <20220214135840.168236-4-conor.dooley@microchip.com>
 <5b0681a0-ff46-7eb4-3644-0d1173c1f0d4@microchip.com>
 <YhZQRqHib2+GR7Ma@piout.net>
 <3483b6c4-67a7-5ed5-2953-728ea8ba5874@microchip.com>
 <YhaXJofTTTgaoEsn@piout.net>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <YhaXJofTTTgaoEsn@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2022 20:20, Alexandre Belloni wrote:
> On 23/02/2022 15:25:00+0000, Conor.Dooley@microchip.com wrote:
>> On 23/02/2022 15:18, Alexandre Belloni wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> On 23/02/2022 07:41:27+0000, Conor.Dooley@microchip.com wrote:
>>>> Hi Alessandro, Alexandre,
>>>> If one of you could take a look at this, that'd be great.
>>>
>>> I actually expected someone else to apply this, what is your plan?
>>
>> I was going to ask Palmer to take the series via riscv. Since I have
>> Rob's R-b, I was just looking for a subsystem maintainer ack/R-b before
>> actually asking him.
>>
> 
> Rob's review is enough for a DT binding, no need to wait for me. but
> FWIW:
> 
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Great, thanks.
> 
> 
>> Thanks,
>> Conor.
>>
>>>
>>>> Thanks,
>>>> Conor.
>>>>
>>>> On 14/02/2022 13:58, conor.dooley@microchip.com wrote:
>>>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>>>
>>>>> Add device tree bindings for the real time clock on
>>>>> the Microchip PolarFire SoC.
>>>>>
>>>>> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
>>>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>>>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>>> ---
>>>>>     .../bindings/rtc/microchip,mfps-rtc.yaml      | 58 +++++++++++++++++++
>>>>>     1 file changed, 58 insertions(+)
>>>>>     create mode 100644 Documentation/devicetree/bindings/rtc/microchip,mfps-rtc.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/rtc/microchip,mfps-rtc.yaml b/Documentation/devicetree/bindings/rtc/microchip,mfps-rtc.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..a2e984ea3553
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/rtc/microchip,mfps-rtc.yaml
>>>>> @@ -0,0 +1,58 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/rtc/microchip,mfps-rtc.yaml#
>>>>> +
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Microchip PolarFire Soc (MPFS) RTC Device Tree Bindings
>>>>> +
>>>>> +allOf:
>>>>> +  - $ref: rtc.yaml#
>>>>> +
>>>>> +maintainers:
>>>>> +  - Daire McNamara <daire.mcnamara@microchip.com>
>>>>> +  - Lewis Hanly <lewis.hanly@microchip.com>
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - microchip,mpfs-rtc
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  interrupts:
>>>>> +    items:
>>>>> +      - description: |
>>>>> +          RTC_WAKEUP interrupt
>>>>> +      - description: |
>>>>> +          RTC_MATCH, asserted when the content of the Alarm register is equal
>>>>> +          to that of the RTC's count register.
>>>>> +
>>>>> +  clocks:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  clock-names:
>>>>> +    items:
>>>>> +      - const: rtc
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>> +  - reg
>>>>> +  - interrupts
>>>>> +  - clocks
>>>>> +  - clock-names
>>>>> +
>>>>> +additionalProperties: false
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +    rtc@20124000 {
>>>>> +        compatible = "microchip,mpfs-rtc";
>>>>> +        reg = <0x20124000 0x1000>;
>>>>> +        clocks = <&clkcfg 21>;
>>>>> +        clock-names = "rtc";
>>>>> +        interrupts = <80>, <81>;
>>>>> +    };
>>>>> +...
>>>>
>>>
>>> --
>>> Alexandre Belloni, co-owner and COO, Bootlin
>>> Embedded Linux and Kernel engineering
>>> https://bootlin.com
>>
> 
