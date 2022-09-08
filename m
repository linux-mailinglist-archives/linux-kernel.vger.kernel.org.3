Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6B85B21AB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbiIHPK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiIHPKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:10:24 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EA0C742A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:10:21 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id q7so28261410lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=5nfFIngu44pae0WCPcM9HQdcNod8T/OMsQbWWVXDqBo=;
        b=LpM3YfC1fmIAQHVaXCX9t/gf9W/yDctvTi9sGXLM0KZtsTeRFtfSYa0I+lVOn77RZG
         gfzpsFmshBRPGemal9JP8/hOz9uhDZK7PZbPVmfkyMH6ujA4/HPnp4dyVPodGiK17X7n
         /OgBw/FsLG5qhSW7iffykKunHEEWz+owJsX6aT7Bu7a+g7DFx1K3mRGRJfSV+l8Vs4A3
         MmWXafVDRzF/+E0ntAcuuaRVZ0BF4OPx032SZfLnno9qPKtWXjRHdda2FlHPyCRVqjxb
         f/m+QK5eXftPOazJbg8mmMjnxKysa5jz7BNvgAjm/tkGj8LtMDWqOxZwUPUGMLMWQUa2
         wpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5nfFIngu44pae0WCPcM9HQdcNod8T/OMsQbWWVXDqBo=;
        b=D0TDfrLdMxOz/HIIQXPFwUcPfgUeoChUlkpUzntdrspDFEcdtkddCkXKu2B4cOxnaS
         9OKtaWd3hpqOHx/QNUyyFnB1feu9Z+3xUhwXWzz/0pRpi2A05Ejpu5OPaFPEjt4NX4k7
         k0/28QvzH79gXXCHoLSntZk5rWStB8AOsS5Rhg6OKmUdvyOzIn9OAXXgkrGd7NGquQ65
         j3U2hh90HTIhQ67vshz0il0/taQFkfX5/HBCGnj3rw4MZaOtcWUQCDz4VUQ9wfbi8k2d
         2LeHqRNiyl/voz/spS9NJBQJIoXlVtgOTS51HcTzLyqIqw9Bflx4o5nx8DtGD5NNvUBY
         FIqA==
X-Gm-Message-State: ACgBeo0jaftK1XMwSIzuHu9wFnHT1FCSjPwApHC+N9I6+KKwzgIZzRJI
        Cg0GqbrnlTyVpIjqKHd4qppuUQ==
X-Google-Smtp-Source: AA6agR7mH7tBvCONHwd5zeSS7p8UBOMCrjw3/bIV+uQT7ic1vLgbCVloBrxwXFxi0Pxd+glXTXPrRg==
X-Received: by 2002:a19:2d5c:0:b0:498:3e16:b3fc with SMTP id t28-20020a192d5c000000b004983e16b3fcmr1346131lft.498.1662649819860;
        Thu, 08 Sep 2022 08:10:19 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f11-20020a056512092b00b00497b198987bsm546555lft.26.2022.09.08.08.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 08:10:19 -0700 (PDT)
Message-ID: <1d3904d9-7fec-2e61-f999-61b89c4becb6@linaro.org>
Date:   Thu, 8 Sep 2022 17:10:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 05/13] dt-bindings: serial: atmel,at91-usart: convert
 to json-schema
Content-Language: en-US
To:     Sergiu.Moga@microchip.com, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com,
        richard.genoud@gmail.com, radu_nicolae.pirea@upb.ro,
        gregkh@linuxfoundation.org, broonie@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, jirislaby@kernel.org,
        admin@hifiphile.com, Kavyasree.Kotagiri@microchip.com,
        Tudor.Ambarus@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-6-sergiu.moga@microchip.com>
 <e799ca9e-acb0-1bea-1c1a-b2ab79089381@linaro.org>
 <fde16d80-28b4-aae6-363f-ad9dcf87a5e1@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fde16d80-28b4-aae6-363f-ad9dcf87a5e1@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 17:06, Sergiu.Moga@microchip.com wrote:
> On 08.09.2022 15:29, Krzysztof Kozlowski wrote:

>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - clock-names
>>> +  - clocks
>>> +
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        $nodename:
>>> +          pattern: "^serial@[0-9a-f]+$"
>>
>> You should rather check value of atmel,usart-mode, because now you won't
>> properly match device nodes called "foobar". Since usart-mode has only
>> two possible values, this will nicely simplify you if-else.
>>
>>
> 
> 
> I did think of that but the previous binding specifies that 
> atmel,usart-mode is required only for the SPI mode and it is optional 
> for the USART mode. That is why I went for the node's regex since I 
> thought it is something that both nodes would have.

I think it should be explicit - you configure node either to this or
that, so the property should be always present. The node name should not
be responsible for it, even though we want node names to match certain
patterns.

> 
> 
>>> +    then:
>>> +      allOf:
>>> +        - $ref: /schemas/serial/serial.yaml#
>>> +        - $ref: /schemas/serial/rs485.yaml#
>>> +
>>> +      properties:
>>> +        atmel,use-dma-rx:
>>> +          type: boolean
>>> +          description: use of PDC or DMA for receiving data
>>> +
>>> +        atmel,use-dma-tx:
>>> +          type: boolean
>>> +          description: use of PDC or DMA for transmitting data
>>> +
>>> +        atmel,fifo-size:
>>> +          $ref: /schemas/types.yaml#/definitions/uint32
>>> +          description:
>>> +            Maximum number of data the RX and TX FIFOs can store for FIFO
>>> +            capable USARTS.
>>> +          enum: [ 16, 32 ]
>>
>> I did not mention it last time, but I think it should follow generic
>> practice, so define all properties top-level and disallow them for other
>> type. This allows you to simply use additionalProperties:false at the end.
>>
> 
> 
> What would be a good example binding in this case?

The example binding.

https://elixir.bootlin.com/linux/v5.19/source/Documentation/devicetree/bindings/example-schema.yaml#L212

> 
> 
>>> +
>>> +    else:
>>> +      if:
>>> +        properties:
>>> +          $nodename:
>>> +            pattern: "^spi@[0-9a-f]+$"
>>> +      then:
>>> +        allOf:
>>> +          - $ref: /schemas/spi/spi-controller.yaml#
>>> +
>>> +        properties:
>>> +          atmel,usart-mode:
>>> +            const: 1
>>> +
>>> +          "#size-cells":
>>> +            const: 0
>>> +
>>> +          "#address-cells":
>>> +            const: 1
>>
>> The same - top level and disallow them for uart.
>>
> 
> 
> These values of #size-cells and #address-cells are only meant for the 
> SPI so I guess I would still have to specify their mandatory const 
> values here.

Sure, ok.

> 
> 
>>> +
>>> +        required:
>>> +          - atmel,usart-mode
>>> +          - "#size-cells"
>>> +          - "#address-cells"
>>
>> End else in this branch is what?
>>
> 
> 
> You are right, I will remove the useless if: after else:

Best regards,
Krzysztof
