Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB175542B48
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiFHJTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbiFHJNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:13:55 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133371B31A7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:34:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id v1so29297391ejg.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 01:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BOGJ0hmYd1E/cDWBfcReTmcYR/z3qD5M/WAMgLhHLXY=;
        b=EQ5vhjjTXKriPWdW/xzhMglRMdU1gDSb0TYJz3AlO+fenefTMuLkvTd/NUHXe+ohAz
         NO8KjUUhEOZ0rSLGXFbhS0uRc8Dkih9VgCuVpScxz2uPN9xwNvztuq+RoAY+SK2B4mHU
         UvcxD11mjCO/neA1MArxoem3PEnrRSOaRrSofICNYelNbuNaSB4c0pVCaN3Nk0GuUf8S
         HfeAsnP5F1XJjs+OD9uqA9zrMrRIjeyNN8++Ljue777xDTzoencU3zpawjc9sy06KIDx
         aepMUpR54z1jXKG5wguw+Tu5aLMa9xPnd6SWIhmpJ+tDaYjRb+PEUmh+GempuQ+L8yBI
         KGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BOGJ0hmYd1E/cDWBfcReTmcYR/z3qD5M/WAMgLhHLXY=;
        b=E9FwwJrHVH2V3p9zjUfofV+lz1AOZfOPZvyoySnXe0FLqkDHJZBnbDh7r1nzY2X7ZZ
         i7AFkLNIdRiTP8qcrxjtqPubMaUcB3sPliFWf6TEq+AO2uxaca+og4FhGUyHZkZHlVCb
         qk00x3v8+7b5GRMFZ3pQuEbZ3F38fMuJ63/+JX4MYEQq+OHZZ4+/zEX46rCciS1bMttv
         dblrOhTk19WI0i+vu0dU+cLPQd2EICyo8T2u3m3OrKqOy0jekjJr1T1Zw0IyxWP0/uHu
         K3xYr9jDQBPYrNApD4B03YGLJNhY+w/JNxtdJYvauVu9t8iqX62iG/ZxUjzYGhOkmRfN
         7xjw==
X-Gm-Message-State: AOAM5327oy5/ouOg84FIrjWPtcJwvXrgTBQui7ZzZTh8qgJDs3QMd2w3
        7MIj2v6a/2M9ysSf4/a00NdaKw==
X-Google-Smtp-Source: ABdhPJwXeGcDpZp8OoIEmODFuqgEUDhqHrM5X63C012jpMDiVPnRaPyZ3MACjWHtloT3WRSre4i/MQ==
X-Received: by 2002:a17:906:9d01:b0:711:dc5d:c8a5 with SMTP id fn1-20020a1709069d0100b00711dc5dc8a5mr8558506ejc.432.1654677274596;
        Wed, 08 Jun 2022 01:34:34 -0700 (PDT)
Received: from [192.168.0.189] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id de46-20020a1709069bee00b0070f6855b90bsm6323281ejc.170.2022.06.08.01.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:34:34 -0700 (PDT)
Message-ID: <1345050e-b6a4-64be-1359-8d31d88769ab@linaro.org>
Date:   Wed, 8 Jun 2022 10:34:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Content-Language: en-US
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
References: <20220607144740.14937-1-kavyasree.kotagiri@microchip.com>
 <20220607144740.14937-2-kavyasree.kotagiri@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220607144740.14937-2-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2022 16:47, Kavyasree Kotagiri wrote:
> Convert the Atmel flexcom device tree bindings to json schema.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
> v1 -> v2:
>  - Fix title.
> 
>  .../bindings/mfd/atmel,flexcom.yaml           | 97 +++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-flexcom.txt | 63 ------------
>  2 files changed, 97 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> new file mode 100644
> index 000000000000..05cb6ebb4b2a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/atmel,flexcom.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel Flexcom (Flexible Serial Communication Unit)
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

Same comment applies as before... Your previous set was better here and
for some reason you decided to change it. This should be enum so you
avoid useless change next patch.

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
> +patternProperties:
> +  "^serial@[0-9a-f]+$":
> +    description: See atmel-usart.txt for details of USART bindings.
> +    type: object
> +
> +  "^spi@[0-9a-f]+$":
> +    description: See ../spi/spi_atmel.txt for details of SPI bindings.
> +    type: object
> +
> +  "^i2c@[0-9a-f]+$":
> +    description: See ../i2c/i2c-at91.txt for details of I2C bindings.
> +    type: object
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
> +          spi0: spi@400 {
> +                compatible = "atmel,at91rm9200-spi";
> +                reg = <0x400 0x200>;
> +                interrupts = <19 4 7>;

as pointed - looks like a IRQ flag

> +                pinctrl-names = "default";
> +                pinctrl-0 = <&pinctrl_flx0_default>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                clocks = <&flx0_clk>;
> +                clock-names = "spi_clk";
> +                atmel,fifo-size = <32>;
> +          };
> +    };



Best regards,
Krzysztof
