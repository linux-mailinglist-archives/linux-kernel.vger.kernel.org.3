Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963C6518461
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiECMiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiECMiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:38:16 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6541EAE4
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 05:34:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id p18so19665060edr.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 05:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ESzdvB4/btl/1VCow2f5NIGlHBg35qVo2qLML71Yw3o=;
        b=DIsjTh73iE8Rod04+zulq6nGoNU0zcbcSAPgifnn3mAUZWqziW4iFRcBOAeaL1enXq
         GI5CyuaYx3wCYCnzhWR9YFn97IYPDtz9V4WgcdyHKJm6p9NtZlR1KwhlLzUpCD2SUpHA
         IX5Hu+vR6qGxrUPDATcDWaFvxnpQLtcTDCveaK9yhzJhTIC+DZRnHhhuPlUSlNYJf/H2
         suUhmJD4gQSXmbme1yHsQpHyXzTAiYQgqWzvsnOCeK/gOf2SDGli3m8b899kwrGAYxRh
         wMIsHASIbtfGmHQS0gFCDW3ca+q8EapxiHdeYuWFJdkkCuUyOG7dUhCAidR2CjXFenW3
         cQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ESzdvB4/btl/1VCow2f5NIGlHBg35qVo2qLML71Yw3o=;
        b=rvW8lQkSGC7LLViomJu2OXD3dJIZWyAfuUFWOHJDhYdQ2jE9wePqp783+KMZM6uu0t
         vrRHZ8zCsP1OriI/RNc+PbCBHOExZPBu94colqHhzztt0zat4TTqnwFlX9Ftd/gnKxt2
         mUm45Dcw46QEqRTeRg8lWmSCnIklkUOqucB9SZ9OyUZapq4L0gaKBhbmN12h8CZNugDz
         K8lEqE/31EvahhvhgPxi3M8lc1HWROTYSF8Cakpy89+zpN6klqRcMbZOR37A2KHlJrfj
         hLVwGhi3gthSqdHF6T1DFrCgKT087Uma/oc19DA51jBBpbzKIBG/1+S2Adl17fqn9Cz8
         aAGQ==
X-Gm-Message-State: AOAM5302tCexDu6foGhJzOUHk+uYj5wwU3IVBXAqgTlM7heg2/qXJLrL
        YHphUYaq1knhfWvdZo925w09UQ==
X-Google-Smtp-Source: ABdhPJwnw3kZXCYUj/4HGLMHRU8PEvlEVEU0guicE86J3K3VdGDVcBLLFwNDGN6Cdg7KX1WQKAnZ+w==
X-Received: by 2002:aa7:d9d6:0:b0:425:dafc:2fc6 with SMTP id v22-20020aa7d9d6000000b00425dafc2fc6mr17434815eds.340.1651581283193;
        Tue, 03 May 2022 05:34:43 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l16-20020a056402125000b0041d527833b9sm7875940edw.3.2022.05.03.05.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 05:34:42 -0700 (PDT)
Message-ID: <4c4b08a1-de08-d00f-dd4a-aeff2e1a9261@linaro.org>
Date:   Tue, 3 May 2022 14:34:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/4] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Content-Language: en-US
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        peda@axentia.se
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        linux@armlinux.org.uk, Manohar.Puri@microchip.com,
        UNGLinuxDriver@microchip.com
References: <20220503105528.12824-1-kavyasree.kotagiri@microchip.com>
 <20220503105528.12824-2-kavyasree.kotagiri@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220503105528.12824-2-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2022 12:55, Kavyasree Kotagiri wrote:
> Convert the Atmel flexcom device tree bindings to json schema.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
>  .../bindings/mfd/atmel,flexcom.yaml           | 68 +++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-flexcom.txt | 63 -----------------
>  2 files changed, 68 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> 

Thank you for your patch. There is something to discuss/improve.

> diff --git a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> new file mode 100644
> index 000000000000..62dea9b891d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/atmel,flexcom.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Device tree bindings for Atmel Flexcom (Flexible Serial Communication Unit)
> +
> +maintainers:
> +  - Rob Herring <robh+dt@kernel.org>

Person with access to hardware/datasheet/knowledge should be here, not
DT bindings maintainer.

> +
> +description: |

No need for "|"

> +  The Atmel Flexcom is just a wrapper which embeds a SPI controller,
> +  an I2C controller and an USART. Only one function can be used at a
> +  time and is chosen at boot time according to the device tree.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - atmel,sama5d2-flexcom
> +
> +  reg:
> +    minItems: 1

no need for minItems

> +    items:
> +      - description: Flexcom registers

Description is obvious, so just replace all three lines with
	maxItems: 1

> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#address-cells": true
> +
> +  "#size-cells": true


These should have some fixed value (e.g. const: 1).
Second question - they do not look valid since you do not have any
children nodes. It looks like you want children, so you need to define them.

> +
> +  ranges:
> +    description:
> +      One range for the full I/O register region. (including USART,
> +      TWI and SPI registers).
> +    items:
> +      minItems: 3

no need for minItems

> +      maxItems: 3
> +
> +  atmel,flexcom-mode:
> +    description:
> +      One of the values. UART, I2C, SPI.

This does not describe anything.

If you have defines here, mention the header.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]

Here is 0 not UART?

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    flx0: flexcom@f8034000 {> +          compatible = "atmel,sama5d2-flexcom";
> +          reg = <0xf8034000 0x200>;
> +          clocks = <&flx0_clk>;
> +          #address-cells = <1>;
> +          #size-cells = <1>;

No need for address/size - no children here.

> +          ranges = <0x0 0xf8034000 0x800>;

Why do you need ranges without children?


Best regards,
Krzysztof
