Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDB35B1CF8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiIHM3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiIHM3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:29:32 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4059E64F1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:29:25 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id m15so7766517lfl.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 05:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=AOYM2uxRcROkjqcy5wTEe5RRwIILvFO/9m5JYr+/yBc=;
        b=CfW8e8Heha0OSP8fGVBKIwthvRkQm33nJxk6UiJFrx1ZMpDyE0lYkYe05yBHqIDXkN
         Tf+gYFb50dnSOkMMr2W3IK5L/mupR/AvnaXfuLA6qb9Nsf8zMxLYdDAnv0gZoiArqIgj
         wnILwumvsUIKdTij+Tb7AH1VZIUcafARYzN/4ZJowNf57Sat19Rdn/O0AdYFfOyHKU2g
         MSWjVrMpaQpsbWE61k5io0W10EjfW2miw7yTY5Ml0G8qKZjQQ+d4g6GLx0bSz1Ukcih4
         Im39hBZVjLwJjvAP+bWI/dLaFDKwTg51wE1/dRAnpORKtfcfe+CvlXlt1zJDWWNeN3ww
         kM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AOYM2uxRcROkjqcy5wTEe5RRwIILvFO/9m5JYr+/yBc=;
        b=GCAosEEygH3ZlEQeTLD0Bd4mEQsM6XCOy4sp6GpNE/E+CMuGzVhxBjfxzJFdLebynD
         k4lCsSDPuaNGQkKTCEdSR4+KqrwvX/i0PoKN2nV+n0Jx4LAmpXvGzKD45ughhqqQjZ/e
         J/qrBEM/hfjUHO5fzpZHIJ4ZCjNKKIesnxhJ66ybY60ugBrHTVxVapSdPXfrr5A+jx5Y
         JgUH7DbNkQefKGrt+j5F8mUuhg589fpxBo1yQHWrKbOrFUkKVfHkMg7aXpP3wuarU8DM
         IL3CRdHl+VINiYxp9psqkw1Jb+1T6w/mv7YaWQvPe/vSWZuADCBEptKZ243rvogPhKcZ
         A17Q==
X-Gm-Message-State: ACgBeo0tzT+fr14NJ+b+uj1wBi15hujHSSMkM6WGWw2jFOz21iA5FaPG
        qfdgESKzWAotpfBxB7A+8yF8+A==
X-Google-Smtp-Source: AA6agR7Sw3aUl+bzoVPgymQwGIGbd2jnXqoekOS8+3z++MWnTDBkgrcRsIqgBv/AZVzRLt5GocmZHA==
X-Received: by 2002:a05:6512:260f:b0:492:8e9f:c647 with SMTP id bt15-20020a056512260f00b004928e9fc647mr2475346lfb.443.1662640164089;
        Thu, 08 Sep 2022 05:29:24 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u4-20020a05651220c400b00497a7529bbasm157365lfr.24.2022.09.08.05.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 05:29:23 -0700 (PDT)
Message-ID: <e799ca9e-acb0-1bea-1c1a-b2ab79089381@linaro.org>
Date:   Thu, 8 Sep 2022 14:29:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 05/13] dt-bindings: serial: atmel,at91-usart: convert
 to json-schema
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, richard.genoud@gmail.com,
        radu_nicolae.pirea@upb.ro, gregkh@linuxfoundation.org,
        broonie@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        jirislaby@kernel.org, admin@hifiphile.com,
        kavyasree.kotagiri@microchip.com, tudor.ambarus@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-6-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220906135511.144725-6-sergiu.moga@microchip.com>
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

On 06/09/2022 15:55, Sergiu Moga wrote:
> Convert at91 USART DT Binding for Atmel/Microchip SoCs to
> json-schema format. Furthermore, move this binding to the
> serial directory, since binding directories match hardware,
> unlike the driver subsystems which match Linux convention.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
> 
> 
> 
> v1 -> v2:
> - only do what the commit says, split the addition of other compatibles and
> properties in other patches
> - remove unnecessary "|"'s
> - mention header in `atmel,usart-mode`'s description
> - place `if:` under `allOf:`
> - respect order of spi0's DT properties: compatible, then reg then the reset of properties
> 
> 
> 
> 
> 
>  .../devicetree/bindings/mfd/atmel-usart.txt   |  98 ----------
>  .../bindings/serial/atmel,at91-usart.yaml     | 183 ++++++++++++++++++
>  2 files changed, 183 insertions(+), 98 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-usart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-usart.txt b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> deleted file mode 100644
> index a09133066aff..000000000000
> --- a/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> +++ /dev/null
> @@ -1,98 +0,0 @@
> -* Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
> -
> -Required properties for USART:
> -- compatible: Should be one of the following:
> -	- "atmel,at91rm9200-usart"
> -	- "atmel,at91sam9260-usart"
> -	- "microchip,sam9x60-usart"
> -	- "atmel,at91rm9200-dbgu", "atmel,at91rm9200-usart"
> -	- "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart"
> -	- "microchip,sam9x60-dbgu", "microchip,sam9x60-usart"
> -- reg: Should contain registers location and length
> -- interrupts: Should contain interrupt
> -- clock-names: tuple listing input clock names.
> -	Required elements: "usart"
> -- clocks: phandles to input clocks.
> -
> -Required properties for USART in SPI mode:
> -- #size-cells      : Must be <0>
> -- #address-cells   : Must be <1>
> -- cs-gpios: chipselects (internal cs not supported)
> -- atmel,usart-mode : Must be <AT91_USART_MODE_SPI> (found in dt-bindings/mfd/at91-usart.h)
> -
> -Optional properties in serial and SPI mode:
> -- dma bindings for dma transfer:
> -	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
> -		memory peripheral interface and USART DMA channel ID, FIFO configuration.
> -		The order of DMA channels is fixed. The first DMA channel must be TX
> -		associated channel and the second one must be RX associated channel.
> -		Refer to dma.txt and atmel-dma.txt for details.
> -	- dma-names: "tx" for TX channel.
> -		     "rx" for RX channel.
> -		     The order of dma-names is also fixed. The first name must be "tx"
> -		     and the second one must be "rx" as in the examples below.
> -
> -Optional properties in serial mode:
> -- atmel,use-dma-rx: use of PDC or DMA for receiving data
> -- atmel,use-dma-tx: use of PDC or DMA for transmitting data
> -- {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD line respectively.
> -  It will use specified PIO instead of the peripheral function pin for the USART feature.
> -  If unsure, don't specify this property.
> -- atmel,fifo-size: maximum number of data the RX and TX FIFOs can store for FIFO
> -  capable USARTs.
> -- rs485-rts-delay, rs485-rx-during-tx, linux,rs485-enabled-at-boot-time: see rs485.txt
> -
> -<chip> compatible description:
> -- at91rm9200:  legacy USART support
> -- at91sam9260: generic USART implementation for SAM9 SoCs
> -
> -Example:
> -- use PDC:
> -	usart0: serial@fff8c000 {
> -		compatible = "atmel,at91sam9260-usart";
> -		reg = <0xfff8c000 0x4000>;
> -		interrupts = <7>;
> -		clocks = <&usart0_clk>;
> -		clock-names = "usart";
> -		atmel,use-dma-rx;
> -		atmel,use-dma-tx;
> -		rts-gpios = <&pioD 15 GPIO_ACTIVE_LOW>;
> -		cts-gpios = <&pioD 16 GPIO_ACTIVE_LOW>;
> -		dtr-gpios = <&pioD 17 GPIO_ACTIVE_LOW>;
> -		dsr-gpios = <&pioD 18 GPIO_ACTIVE_LOW>;
> -		dcd-gpios = <&pioD 20 GPIO_ACTIVE_LOW>;
> -		rng-gpios = <&pioD 19 GPIO_ACTIVE_LOW>;
> -	};
> -
> -- use DMA:
> -	usart0: serial@f001c000 {
> -		compatible = "atmel,at91sam9260-usart";
> -		reg = <0xf001c000 0x100>;
> -		interrupts = <12 4 5>;
> -		clocks = <&usart0_clk>;
> -		clock-names = "usart";
> -		atmel,use-dma-rx;
> -		atmel,use-dma-tx;
> -		dmas = <&dma0 2 0x3>,
> -		       <&dma0 2 0x204>;
> -		dma-names = "tx", "rx";
> -		atmel,fifo-size = <32>;
> -	};
> -
> -- SPI mode:
> -	#include <dt-bindings/mfd/at91-usart.h>
> -
> -	spi0: spi@f001c000 {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		compatible = "atmel,at91rm9200-usart", "atmel,at91sam9260-usart";
> -		atmel,usart-mode = <AT91_USART_MODE_SPI>;
> -		reg = <0xf001c000 0x100>;
> -		interrupts = <12 IRQ_TYPE_LEVEL_HIGH 5>;
> -		clocks = <&usart0_clk>;
> -		clock-names = "usart";
> -		dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(3)>,
> -		       <&dma0 2 (AT91_DMA_CFG_PER_ID(4) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
> -		dma-names = "tx", "rx";
> -		cs-gpios = <&pioB 3 0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> new file mode 100644
> index 000000000000..b25535b7a4d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> @@ -0,0 +1,183 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/atmel,at91-usart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
> +
> +maintainers:
> +  - Richard Genoud <richard.genoud@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - atmel,at91rm9200-usart
> +          - atmel,at91sam9260-usart
> +          - microchip,sam9x60-usart
> +      - items:
> +          - const: atmel,at91rm9200-dbgu
> +          - const: atmel,at91rm9200-usart
> +      - items:
> +          - const: atmel,at91sam9260-dbgu
> +          - const: atmel,at91sam9260-usart
> +      - items:
> +          - const: microchip,sam9x60-dbgu
> +          - const: microchip,sam9x60-usart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: usart
> +
> +  clocks:
> +    maxItems: 1
> +
> +  dmas:
> +    items:
> +      - description: TX DMA Channel
> +      - description: RX DMA Channel
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +
> +  atmel,usart-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Must be either <AT91_USART_MODE_SPI> for SPI or
> +      <AT91_USART_MODE_SERIAL> for USART (found in dt-bindings/mfd/at91-usart.h).
> +    enum: [ 0, 1 ]
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clock-names
> +  - clocks
> +
> +allOf:
> +  - if:
> +      properties:
> +        $nodename:
> +          pattern: "^serial@[0-9a-f]+$"

You should rather check value of atmel,usart-mode, because now you won't
properly match device nodes called "foobar". Since usart-mode has only
two possible values, this will nicely simplify you if-else.


> +    then:
> +      allOf:
> +        - $ref: /schemas/serial/serial.yaml#
> +        - $ref: /schemas/serial/rs485.yaml#
> +
> +      properties:
> +        atmel,use-dma-rx:
> +          type: boolean
> +          description: use of PDC or DMA for receiving data
> +
> +        atmel,use-dma-tx:
> +          type: boolean
> +          description: use of PDC or DMA for transmitting data
> +
> +        atmel,fifo-size:
> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          description:
> +            Maximum number of data the RX and TX FIFOs can store for FIFO
> +            capable USARTS.
> +          enum: [ 16, 32 ]

I did not mention it last time, but I think it should follow generic
practice, so define all properties top-level and disallow them for other
type. This allows you to simply use additionalProperties:false at the end.

> +
> +    else:
> +      if:
> +        properties:
> +          $nodename:
> +            pattern: "^spi@[0-9a-f]+$"
> +      then:
> +        allOf:
> +          - $ref: /schemas/spi/spi-controller.yaml#
> +
> +        properties:
> +          atmel,usart-mode:
> +            const: 1
> +
> +          "#size-cells":
> +            const: 0
> +
> +          "#address-cells":
> +            const: 1

The same - top level and disallow them for uart.

> +
> +        required:
> +          - atmel,usart-mode
> +          - "#size-cells"
> +          - "#address-cells"

End else in this branch is what?

> +
> +unevaluatedProperties: false
> +

Best regards,
Krzysztof
