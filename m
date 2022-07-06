Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CCB568B8D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiGFOnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbiGFOnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:43:07 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650DA25583;
        Wed,  6 Jul 2022 07:43:06 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id n7so3623643ioo.7;
        Wed, 06 Jul 2022 07:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AyjSqRF0XP81OAbpDNXqK+W5+Y6NGmvzX2G9WERFxDU=;
        b=F1a8Cu9LxzjZQIMiQO3LEU5iWChuoJpCuVrTHDFXILGMSwcbSeILJNxOsdRJDclzRE
         r1xN9Zod+1mF89WQF2tdUuWICkaECv7+f21zyFMJIssdX82LhJueB/AL3PKnZT0pyzDF
         US7sPpUaoIoYZHZiRzF8Rc8Of9IYVAqiQzbAtVkjVRl5MnFzQQiPDE25wc6BCqrZhZDg
         sRoYd0OcERlHH+nxApcCDw20siByhMCrB8nEJz1BwmXzbRfjZxf6u3IrTd17jyb1s82j
         eqwBt9lBI7kBQdoV19G6jc7aLpleLd6tPu0+qYbztzUhezs3Pzdppk6Gsdrmc1HWPQTX
         w14Q==
X-Gm-Message-State: AJIora+EjcnsUMGse1Pa/tXjIPweJM6f2yQ8LHbGjckrQXQZLTwUFsJx
        Ae1MEph405B5HMrx9gHcRg==
X-Google-Smtp-Source: AGRyM1sd9D4Of7II1GBhcAtxmhMMB6f9wzCQzwAiSB39QHBVVQICj+jC2l1whI9A6744EbKNczmzlQ==
X-Received: by 2002:a02:85e3:0:b0:339:cf24:68f6 with SMTP id d90-20020a0285e3000000b00339cf2468f6mr25307234jai.161.1657118585525;
        Wed, 06 Jul 2022 07:43:05 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id v28-20020a02b09c000000b0032e0851ea0fsm16013453jah.10.2022.07.06.07.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 07:43:05 -0700 (PDT)
Received: (nullmailer pid 14333 invoked by uid 1000);
        Wed, 06 Jul 2022 14:43:03 -0000
Date:   Wed, 6 Jul 2022 08:43:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] dt-bindings: mfd: atmel,sama5d2-flexcom: Add new
 compatible string for lan966x
Message-ID: <20220706144303.GA7885-robh@kernel.org>
References: <20220706110619.71729-1-kavyasree.kotagiri@microchip.com>
 <20220706110619.71729-3-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706110619.71729-3-kavyasree.kotagiri@microchip.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 09:06:18AM -0200, Kavyasree Kotagiri wrote:
> LAN966x SoC flexcoms has two optional I/O lines. Namely, CS0 and CS1
> in flexcom SPI mode. CTS and RTS in flexcom USART mode. These pins
> can be mapped to lan966x FLEXCOM_SHARED[0-20] pins and usage depends on
> functions being configured.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
> v6 -> v7:
>  - Add #address-cells, #size-cells to flx3 example.
> 
> v5 -> v6:
>  - Removed spi node from flx3 example.
> 
> v4 -> v5:
>  - Fixed indentations and dt-schema errors.
>  - No errors seen with 'make dt_binding_check'.
> 
> v3 -> v4:
>  - Added else condition to allOf:if:then.
> 
> v2 -> v3:
>  - Add reg property of lan966x missed in v2.
> 
> v1 -> v2:
>  - Use allOf:if:then for lan966x dt properties
> 
>  .../bindings/mfd/atmel,sama5d2-flexcom.yaml   | 65 ++++++++++++++++++-
>  1 file changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
> index 864f490ffb83..b4b47accab49 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
> +++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
> @@ -18,9 +18,11 @@ properties:
>    compatible:
>      enum:
>        - atmel,sama5d2-flexcom
> +      - microchip,lan966x-flexcom

Don't use wildcards in compatible strings.

>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>  
>    clocks:
>      maxItems: 1
> @@ -47,6 +49,27 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [1, 2, 3]
>  
> +  microchip,flx-shrd-pins:
> +    description: Specify the Flexcom shared pins to be used for flexcom
> +      chip-selects.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      minimum: 0
> +      maximum: 20

It's not clear how one uses this. It's selecting 2 pins, or a range of 
pins, or ???

> +
> +  microchip,flx-cs:
> +    description: Flexcom chip selects. Here, value of '0' represents "cts" line
> +      of flexcom USART or "cs0" line of flexcom SPI and value of '1' represents
> +      "rts" line of flexcom USART or "cs1" line of flexcom SPI.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      minimum: 0
> +      maximum: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -56,6 +79,31 @@ required:
>    - ranges
>    - atmel,flexcom-mode
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: microchip,lan966x-flexcom
> +
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: Flexcom base registers map
> +            - description: Flexcom shared registers map
> +      required:
> +        - microchip,flx-shrd-pins
> +        - microchip,flx-cs
> +
> +    else:
> +      properties:
> +        reg:
> +          items:
> +            - description: Flexcom base registers map
> +        microchip,flx-shrd-pins: false
> +        microchip,flx-cs: false
> +
>  additionalProperties: false
>  
>  examples:
> @@ -71,4 +119,19 @@ examples:
>          ranges = <0x0 0xf8034000 0x800>;
>          atmel,flexcom-mode = <2>;
>      };
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    flx3: flexcom@e0064000 {
> +        compatible = "microchip,lan966x-flexcom";
> +        reg = <0xe0064000 0x100>,
> +              <0xe2004180 0x8>;
> +        clocks = <&flx0_clk>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0x0 0xe0040000 0x800>;
> +        atmel,flexcom-mode = <2>;
> +        microchip,flx-shrd-pins = <9>;
> +        microchip,flx-cs = <0>;
> +    };
>  ...
> -- 
> 2.25.1
> 
> 
