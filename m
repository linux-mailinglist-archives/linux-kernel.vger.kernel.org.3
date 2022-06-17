Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A637755004B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382620AbiFQXEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239454AbiFQXEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:04:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819E253E1A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:04:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso2466840pjn.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RoKyPgsIRLbHbebKiGOapoVSb6B/cyX7rANTiMTjAo0=;
        b=fHkFGLZVgd3z98x+awr68lFG8aNMdMavp7+BYxx2O2CCQpuaCA3dZaR9ktG6r2igXn
         PIxKinMRNWJY5LfxP7VmaD3n4h3iZllLtzu+hwPpsPZqICOcnL7RYAd1XO25mSoktVPi
         enV4W6G+BeYFoX8kU3rvfIyCdElShlBIJAZKkHDSy0Ia3JvgeJtmWcSQyVZhUG1Jd4Pm
         qUBqi2hEeXmY2d536Pmx/NmmqdUUbe34sGZj4FNT77kJQcnPyXCHjwK6VbKuijSI+31C
         uMGbzPQp9AzZdxW15nbQXv2AN2oZE2OfXNdN08Luk43pcAEaj3XiwFcf9u5ef4ns7WJo
         iN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RoKyPgsIRLbHbebKiGOapoVSb6B/cyX7rANTiMTjAo0=;
        b=SR4jxKeB+2Kw9h6TuOKVjObwOhJVBYxsjvWI9xToKbTUQxPrkxdX2L9nzaCjjWjdWp
         GIyDaJtn9/U1ibgirDQGcmf+eOJ3GqzH6AGwP6X9yHaL/XV7EyPXZG41GcN3Cabx8MNi
         3gjJy442NRxqlxHc23S2izahy4xPo+mD5zBZQYOYD9e8Xs7xcEsWrXRKhRirrT4bsH2c
         QT8kOetnJVaOwTkr8nLmoJvYUyLFU2VkQfY3x7JxoU7AQ6hgIeSwSMU6nQOOozwr3Zd8
         JFtGhtaqnuBgROmqigw/NvsbBnCnCYjNpp7IJhVORolcmV7IH2iLpPfPsD91edku4ka7
         4Wow==
X-Gm-Message-State: AJIora/9JigDp7fWIZhAYQ2z2UmTYDFu4aMDLr8gbTYFy1kWeyoLEaX/
        bFej5Wmcl6YideA/nxLMi7nIFA==
X-Google-Smtp-Source: AGRyM1vKdPg8Goi/ejlBDg8dGYVKd1DYp762UWMOPOQLqFsNKBm1vRWI1/Xv145Z6OD5ccCIwefGaA==
X-Received: by 2002:a17:90b:1808:b0:1e2:a335:ad04 with SMTP id lw8-20020a17090b180800b001e2a335ad04mr24111968pjb.110.1655507082007;
        Fri, 17 Jun 2022 16:04:42 -0700 (PDT)
Received: from [172.31.235.92] ([216.9.110.6])
        by smtp.gmail.com with ESMTPSA id je18-20020a170903265200b0016511314b94sm625513plb.159.2022.06.17.16.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 16:04:41 -0700 (PDT)
Message-ID: <e40ad829-2530-6807-efda-49689e5932e1@linaro.org>
Date:   Fri, 17 Jun 2022 16:04:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 2/3] dt-bindings: mfd: atmel,flexcom: Add new
 compatible string for lan966x
Content-Language: en-US
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        robh+dt@kernel.org, Nicolas.Ferre@microchip.com,
        Claudiu.Beznea@microchip.com, krzysztof.kozlowski+dt@linaro.org
Cc:     UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220617130729.12072-1-kavyasree.kotagiri@microchip.com>
 <20220617130729.12072-3-kavyasree.kotagiri@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220617130729.12072-3-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2022 06:07, Kavyasree Kotagiri wrote:
> LAN966x SoC flexcoms has two optional I/O lines. Namely, CS0 and CS1
> in flexcom SPI mode. CTS and RTS in flexcom USART mode. These pins
> can be mapped to lan966x FLEXCOM_SHARED[0-20] pins and usage depends on
> functions being configured.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
> v3 -> v4:
>  - Added else condition to allOf:if:then.
> 
> v2 -> v3:
>  - Add reg property of lan966x missed in v2.
> 
> v1 -> v2:
>  - Use allOf:if:then for lan966x dt properties
> 
>  .../bindings/mfd/atmel,flexcom.yaml           | 80 ++++++++++++++++++-
>  1 file changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> index fdb1645d123f..7e0e4d6b1b96 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> +++ b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> @@ -18,9 +18,11 @@ properties:
>    compatible:
>      enum:
>        - atmel,sama5d2-flexcom
> +      - microchip,lan966x-flexcom


This looks good now.

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
>  patternProperties:
>    "^serial@[0-9a-f]+$":
>      description: See atmel-usart.txt for details of USART bindings.
> @@ -73,6 +96,33 @@ required:
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
> +          minItems: 2
> +          items:
> +            - description: Flexcom base regsiters map

typo here - registers

> +            - description: Flexcom shared registers map
> +      required:
> +        - microchip,flx-shrd-pins
> +        - microchip,flx-cs
> +
> +    else:
> +      properties:
> +        reg:
> +          maxItems: 1

I think maxItems are not needed in such case. Rob's bot complains, so be
sure you test your bindings before sending.

> +          items:
> +            - description: Flexcom base regsiters map

typo

> +        microchip,flx-shrd-pins: false
> +        microchip,flx-cs: false
> +
>  additionalProperties: false
>  
>  examples:
> @@ -101,4 +151,32 @@ examples:
>                  atmel,fifo-size = <32>;
>            };
>      };
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    flx3: flexcom@e0064000 {
> +          compatible = "microchip,lan966x-flexcom";

Just like in patch #1 = wrong indentation. 4 spaces for the DTS example.

> +          reg = <0xe0064000 0x100>,
> +                <0xe2004180 0x8>;
> +          clocks = <&flx0_clk>;
> +          #address-cells = <1>;
> +          #size-cells = <1>;
> +          ranges = <0x0 0xe0040000 0x800>;
> +          atmel,flexcom-mode = <2>;
> +          microchip,flx-shrd-pins = <9>;
> +          microchip,flx-cs = <0>;
> +
> +          spi3: spi@400 {
> +                compatible = "atmel,at91rm9200-spi";
> +                reg = <0x400 0x200>;
> +                interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> +                pinctrl-names = "default";
> +                pinctrl-0 = <&pinctrl_flx3_default>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                clocks = <&nic_clk>;
> +                clock-names = "spi_clk";
> +                atmel,fifo-size = <32>;
> +          };
> +    };
>  ...


Best regards,
Krzysztof
