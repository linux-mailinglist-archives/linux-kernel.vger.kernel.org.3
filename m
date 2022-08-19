Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A77E5997AE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347406AbiHSIl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347442AbiHSIlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:41:47 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7588169F6F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:41:44 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id q7so1575676lfu.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=CRnuTsAE9g4131Gs1Ch+MF8rdf+eDVa6Xez0TyG+a0A=;
        b=V7WH7QjsIZrOhFjZEoS5Hp1lBUUj/KrXDaY23Htx+8JpSFUB8BlrdppWhAU7pEdgsv
         oT/t3nWpySkKzLc3u/0c1i2e5+dsenLdH5FXMO4jy+R2qoM+gmu+DC7H/BnjOUEI2br/
         iviv0sz8OnaHsEKw89AwM6eOvGlyurUv9SE4RbQnlA/KuCzoaTgDmH4Vi5robLyGi4se
         I4f45nZrl8lDIx3d7Y/t5a8S37ptwSD1RTPgihhPpikOBmG0fvg90h++2VrJRFtYJA2r
         FYU2xaKVv5zBjt5mfAOcaeY8FHJPyPJsIZpDB8W9j/RQ3d8UKxJEymaVfjM2mnIUeZAB
         BeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=CRnuTsAE9g4131Gs1Ch+MF8rdf+eDVa6Xez0TyG+a0A=;
        b=jLzYy6nRa21V4CYjDtREG/Do9P4VEv+G7fZawPRooOw5s3nYLzAKLR1QlJZugPUUaX
         mis53lOwVjxW3WgoKtBTiXHE5ItheRetS7zrmS4RYSjYQfjMs2nqeJwJk1TXVcqjNer3
         vfXeupjIaeoSdsdL7mUzMhZS9KahJiGQqNaahDokJPiIgwRsA0N8Vpm1+6BJWgMXTKWv
         ErOW9XfwaGRLCqf2n7mECmd2dxPrJcixbxoJvZAEDnM7oGzRtcSo4X8m9/ljjJNihLOE
         vLar0AqiY/5jVuckpjLEgl4QvyzE/xDWYw8eFdMorJrfxG41ZDnAwxPE+d+8PRoz1S0k
         4XNA==
X-Gm-Message-State: ACgBeo3K4dje1AyRViuw3WB2ebv33Zb/XP6uSDnY1vLjY44MztYXeyD6
        I+9mNtuVLO5zpjaAUr2YhHhSAQ==
X-Google-Smtp-Source: AA6agR4wD3EqU9y0mOORxLi5pTs4j3x4Q1X/qtUS/M7PdaGN8KlxcT2G4pkJ/ZXRfgKQ4SF0TxW/tA==
X-Received: by 2002:a05:6512:2291:b0:48b:492e:ef35 with SMTP id f17-20020a056512229100b0048b492eef35mr2081867lfu.494.1660898502773;
        Fri, 19 Aug 2022 01:41:42 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id d11-20020ac25ecb000000b00492b494c4dbsm557072lfq.89.2022.08.19.01.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 01:41:42 -0700 (PDT)
Message-ID: <aa659b2e-44cb-b2e2-eced-1ef7f5de5647@linaro.org>
Date:   Fri, 19 Aug 2022 11:41:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/5] dt-bindings: mfd: atmel,at91-usart: convert to
 json-schema
Content-Language: en-US
To:     Sergiu.Moga@microchip.com, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        admin@hifiphile.com, Kavyasree.Kotagiri@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
 <20220817075517.49575-3-sergiu.moga@microchip.com>
 <c1a98a3e-609e-7783-b1b7-3bb39caa8c65@linaro.org>
 <5fd68d8e-7132-2f58-0ef9-cd4a0fe45127@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5fd68d8e-7132-2f58-0ef9-cd4a0fe45127@microchip.com>
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

On 19/08/2022 11:37, Sergiu.Moga@microchip.com wrote:

>>> +      - items:
>>> +          - const: atmel,at91rm9200-dbgu
>>> +          - const: atmel,at91rm9200-usart
>>> +      - items:
>>> +          - const: atmel,at91sam9260-dbgu
>>> +          - const: atmel,at91sam9260-usart
>>> +      - items:
>>> +          - const: microchip,sam9x60-dbgu
>>> +          - const: microchip,sam9x60-usart
>>> +      - items:
>>> +          - const: microchip,sam9x60-usart
>>> +          - const: atmel,at91sam9260-usart
>> This is not correct - contradicts earlier one.
>>
> 
> Yes, this was for a DT node we have internally, my bad. You are right, 
> it does not really make sense and it should not be the other way around: 
> having the DT validate the binding. I will remove this combination in 
> the next version.

You need to fix any out of tree DTS or upstream it.
> 
> 
>>> +      - items:
>>> +          - const: microchip,sam9x60-dbgu
>>> +          - const: microchip,sam9x60-usart
>>> +          - const: atmel,at91sam9260-dbgu
>>> +          - const: atmel,at91sam9260-usart
>> What? You wrote above that microchip,sam9x60-dbgu is compatible only
>> with microchip,sam9x60-usart. Now you write it is also compatible with
>> other ones?
> 
> 
> Yes, this one is intended because the 9x60 IP has new functionalities on 
> top of 9260, and some nodes do keep all four as fallback.

Then all nodes should keep fallbacks.

> 
> 
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clock-names:
>>> +    contains:
>>> +      const: usart
>> No, this has to be specific/fixed list.
> 
> 
> I wanted to highlight the fact that it must contain either:
> clock-names = "usart";
> or
> clock-names = "usart", "gclk";
> 
> What would be the recommended way of doing this then?

We have an example for this.

https://elixir.bootlin.com/linux/v5.19/source/Documentation/devicetree/bindings/example-schema.yaml#L91


Best regards,
Krzysztof
