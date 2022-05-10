Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB5752123F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbiEJKgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239870AbiEJKga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:36:30 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BE9887AF
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:32:33 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g20so19439719edw.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/MqHzowFCN88QrQcwqy6I1tlpSGYuw9Ji/xKQiWYHFY=;
        b=HCHP+pwGkiGUg/3uVhpfA0cGRi0a6eT9Xs/fvkUpRhX/pFBn/IvuNHnS3+ePCSe0Sq
         Vp2XsGce4iu7ArAr1nZ0zr6D2KEoCM3H7Ic1NvlSvH0k+T1tleTtaXjh6ecc1/b+GF1S
         wzedKBvir5/yDBkiMuQPac3jYG+7/pA7PV93tmYd8zn3auI7vmwSTzcFZpnb4VMUYUOV
         vWD507Pd5lw4W2m55pYyz6kO/GnYR2PpzBfb4e6vA+VuQoozfBVufOSo8Q+7snYZfYPB
         92gPlKELzNSPrwwZKjJ5OTna/rHw0HayRGGZLUAUb9emXV8gjZDtY04ll1Bewz2zlVEt
         rb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/MqHzowFCN88QrQcwqy6I1tlpSGYuw9Ji/xKQiWYHFY=;
        b=WcBHFZrDea3/AkdQP2mgio9GOxuI2bLL3vGvMLZrNLx/YdW8vUzFsODV93t4G7Mfn8
         tyaPkjUrd7usH3W61CvZhPWTtNvKIw7lmCYtuqxBX5i9kq/KQvXqMNsfdrLyGoOLOcbt
         32N61ubHlm0O2bRdU4Kbfp46R/mw/y2BuOn9o9f04duXYxmTBYjwPZVpo3ZVKTLybCmx
         PA/GRU7Ra/pW8hp4o3z8jR46uqCqrfkLRq68Q5/hvaG7jF9qJtxWzPuOlpdBeZzlPwHu
         iuCtP7oJ6FVCYEC+4JYYP3bsAqYxvWdFueUb5zP3vCKo8kHOQc0YddPK0y+BHc7jbeVP
         2UHQ==
X-Gm-Message-State: AOAM532R5iD4gP29k6fZyBMHFEMbqWjs0y9AWjMSneaR+ZgZ7YteGOcQ
        LDcKPA3A/iw4I2er4lJ6xH5RCg==
X-Google-Smtp-Source: ABdhPJzXSwfbjptKkZFNufiI9L3pttyFvhhG+CEF2ObP3xI6dpxIsPq6siVIquVKSZXmsNVuPmRi4w==
X-Received: by 2002:a05:6402:5108:b0:427:e323:4c67 with SMTP id m8-20020a056402510800b00427e3234c67mr22784859edd.326.1652178751935;
        Tue, 10 May 2022 03:32:31 -0700 (PDT)
Received: from [192.168.0.251] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gc35-20020a1709072b2300b006f3ef214db7sm5922303ejc.29.2022.05.10.03.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 03:32:31 -0700 (PDT)
Message-ID: <73d0121c-66cc-9738-d7b5-0f2c72884846@linaro.org>
Date:   Tue, 10 May 2022 12:32:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: atmel,flexcom: Convert to
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
References: <20220509084920.14529-1-kavyasree.kotagiri@microchip.com>
 <20220509084920.14529-2-kavyasree.kotagiri@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220509084920.14529-2-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2022 10:49, Kavyasree Kotagiri wrote:
> Convert the Atmel flexcom device tree bindings to json schema.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
>  .../bindings/mfd/atmel,flexcom.yaml           | 92 +++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-flexcom.txt | 63 -------------
>  2 files changed, 92 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> new file mode 100644
> index 000000000000..79ec7ebc7055
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/atmel,flexcom.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Device tree bindings for Atmel Flexcom (Flexible Serial Communication Unit)

s/Device tree bindings//
> +
> +maintainers:
> +  - Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> +
> +description:
> +  The Atmel Flexcom is just a wrapper which embeds a SPI controller,
> +  an I2C controller and an USART. Only one function can be used at a
> +  time and is chosen at boot time according to the device tree.
> +
> +properties:
> +  compatible:
> +    const: atmel,sama5d2-flexcom
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges:
> +    description:
> +      One range for the full I/O register region. (including USART,
> +      TWI and SPI registers).
> +    items:
> +      maxItems: 3
> +
> +  atmel,flexcom-mode:
> +    description: |
> +      Specifies the flexcom mode as follows:
> +      1: USART
> +      2: SPI
> +      3: I2C.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 3]
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +  - atmel,flexcom-mode
> +
> +additionalProperties: false
> +
> +patternProperties:

This goes after "properties" (before "required").

> +  "^serial@[0-9a-f]+$":
> +    description: See atmel-usart.txt for details of USART bindings.

type: object

Then a blank line.


> +  "^spi@[0-9a-f]+$":
> +    description: See ../spi/spi_atmel.txt for details of SPI bindings.

type: object

Then a blank line.

> +  "^i2c@[0-9a-f]+$":
> +    description: See ../i2c/i2c-at91.txt for details of I2C bindings.

type: object


> +
> +examples:
> +  - |
> +    flx0: flexcom@f8034000 {
> +          compatible = "atmel,sama5d2-flexcom";
> +          reg = <0xf8034000 0x200>;
> +          clocks = <&flx0_clk>;
> +          #address-cells = <1>;
> +          #size-cells = <1>;
> +          ranges = <0x0 0xf8034000 0x800>;
> +          atmel,flexcom-mode = <2>;
> +

Best regards,
Krzysztof
