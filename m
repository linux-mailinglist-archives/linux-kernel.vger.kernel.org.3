Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2EE521C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344600AbiEJObR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245263AbiEJODa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:03:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDC82E07E9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:40:32 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id p4so20086228edx.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UFf0N9Ca4Qmqrak9sBs2frjC8lzk6TgQKWf5Bl7P6Yg=;
        b=d9fLDIwfwlCuY3t/N6rLucvF1aLQty2zVdgx3pkwjYK3886Fq2BnwQHRmg62I2mD2/
         Wx/hWeq2NhgAk9k5Yx0iubaZOFpRxeqq5SxZHUjlJHKUsbujbGZqc8Ocabv/qgxbWc2b
         M5U3Bm0LdN0AEVOb9/+sVY5fE0B/EQO6U7JF5ij3oOe7dPZbT579CyjqhrEJA9tSo2Pc
         niIPE+kg66njFy2S7/EMxv8I3NM+zcM7cTz8D3M2xSBk8hy15glIh+Yy28g9+rEWXB5h
         aJoB0+zhp7GJkmWOhvc+nDHtQR849nuRjul4f+onkxrFhy1dpI0u3b12A/yt4UksBHl9
         oumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UFf0N9Ca4Qmqrak9sBs2frjC8lzk6TgQKWf5Bl7P6Yg=;
        b=5WUf38+lpIBGqgoYJbj+JqtIqOPv1y+AIl8UaOB9ZTVNirdeMG56ue7MscEtEYy/SU
         p9updlETnijeYNJ0mBf7usccE5YSSznj0ZsDDmuB+FwXv4M428Li/TALysiZyGN+TTBs
         m+N5ToqCsje2/CbxmpZwpQv5L8+drFx8xm52e0YErHoSazonYt4AhFiwgstL5w/1ZKzr
         aflC9vbBV52uVjobgV6HlYfIMY5FjT4JmdoXyY5CLrAZmdEMqwhQFqOHAGZcIj0untrM
         kCOEJ5i2OEnukdziMLBsCiuVpSUenGTp2InxD8VEYr92cGmoSMGH29nbugb6ztykTD5S
         DsDQ==
X-Gm-Message-State: AOAM531/o8I3D2fnMYYjuo1gFZT8025NCehQAzE6P6YL+bSdbku6ULxd
        l4+6mGjWVMonIgG2N8PwOFYMnw==
X-Google-Smtp-Source: ABdhPJzlINYlos9kx0GGFowhHM5QoQEOKdw97M9BYqERgWbcRq6bRjf1GD/nFl/ustJe4YTUop2hPw==
X-Received: by 2002:a50:9511:0:b0:428:7acf:99b9 with SMTP id u17-20020a509511000000b004287acf99b9mr17622666eda.338.1652190030916;
        Tue, 10 May 2022 06:40:30 -0700 (PDT)
Received: from [192.168.0.253] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i18-20020a170906a29200b006fa9384a0b5sm1199959ejz.61.2022.05.10.06.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 06:40:30 -0700 (PDT)
Message-ID: <6db35313-5dcd-c9f2-724c-d157a835c9fc@linaro.org>
Date:   Tue, 10 May 2022 15:40:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] dt-bindings: gpio: gpio-mvebu: convert txt binding to
 YAML
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20220510094404.1020307-1-chris.packham@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220510094404.1020307-1-chris.packham@alliedtelesis.co.nz>
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

On 10/05/2022 11:44, Chris Packham wrote:
> Convert the existing device tree binding to YAML format.
> 
> The old binding listed the interrupt-controller and related properties
> as required but there are sufficiently many existing usages without it
> that the YAML binding does not make the interrupt properties required.
> 
> The offset and marvell,pwm-offset properties weren't in the old binding
> and are added to the YAML binding. The offset property is required when
> the marvell,armada-8k-gpio compatible is used.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../devicetree/bindings/gpio/gpio-mvebu.txt   |  93 -----------
>  .../devicetree/bindings/gpio/gpio-mvebu.yaml  | 147 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 148 insertions(+), 94 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> deleted file mode 100644
> index 0fc6700ed800..000000000000
> --- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> +++ /dev/null
> @@ -1,93 +0,0 @@
> -* Marvell EBU GPIO controller
> -
> -Required properties:
> -
> -- compatible : Should be "marvell,orion-gpio", "marvell,mv78200-gpio",
> -  "marvell,armadaxp-gpio" or "marvell,armada-8k-gpio".
> -
> -    "marvell,orion-gpio" should be used for Orion, Kirkwood, Dove,
> -    Discovery (except MV78200) and Armada 370. "marvell,mv78200-gpio"
> -    should be used for the Discovery MV78200.
> -
> -    "marvel,armadaxp-gpio" should be used for all Armada XP SoCs
> -    (MV78230, MV78260, MV78460).
> -
> -    "marvell,armada-8k-gpio" should be used for the Armada 7K and 8K
> -    SoCs (either from AP or CP), see
> -    Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt
> -    for specific details about the offset property.
> -
> -- reg: Address and length of the register set for the device. Only one
> -  entry is expected, except for the "marvell,armadaxp-gpio" variant
> -  for which two entries are expected: one for the general registers,
> -  one for the per-cpu registers. Not used for marvell,armada-8k-gpio.
> -
> -- interrupts: The list of interrupts that are used for all the pins
> -  managed by this GPIO bank. There can be more than one interrupt
> -  (example: 1 interrupt per 8 pins on Armada XP, which means 4
> -  interrupts per bank of 32 GPIOs).
> -
> -- interrupt-controller: identifies the node as an interrupt controller
> -
> -- #interrupt-cells: specifies the number of cells needed to encode an
> -  interrupt source. Should be two.
> -  The first cell is the GPIO number.
> -  The second cell is used to specify flags:
> -    bits[3:0] trigger type and level flags:
> -      1 = low-to-high edge triggered.
> -      2 = high-to-low edge triggered.
> -      4 = active high level-sensitive.
> -      8 = active low level-sensitive.
> -
> -- gpio-controller: marks the device node as a gpio controller
> -
> -- ngpios: number of GPIOs this controller has
> -
> -- #gpio-cells: Should be two. The first cell is the pin number. The
> -  second cell is reserved for flags, unused at the moment.
> -
> -Optional properties:
> -
> -In order to use the GPIO lines in PWM mode, some additional optional
> -properties are required.
> -
> -- compatible: Must contain "marvell,armada-370-gpio"
> -
> -- reg: an additional register set is needed, for the GPIO Blink
> -  Counter on/off registers.
> -
> -- reg-names: Must contain an entry "pwm" corresponding to the
> -  additional register range needed for PWM operation.
> -
> -- #pwm-cells: Should be two. The first cell is the GPIO line number. The
> -  second cell is the period in nanoseconds.
> -
> -- clocks: Must be a phandle to the clock for the GPIO controller.
> -
> -Example:
> -
> -		gpio0: gpio@d0018100 {
> -			compatible = "marvell,armadaxp-gpio";
> -			reg = <0xd0018100 0x40>,
> -			    <0xd0018800 0x30>;
> -			ngpios = <32>;
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -			interrupts = <16>, <17>, <18>, <19>;
> -		};
> -
> -		gpio1: gpio@18140 {
> -			compatible = "marvell,armada-370-gpio";
> -			reg = <0x18140 0x40>, <0x181c8 0x08>;
> -			reg-names = "gpio", "pwm";
> -			ngpios = <17>;
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -			#pwm-cells = <2>;
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -			interrupts = <87>, <88>, <89>;
> -			clocks = <&coreclk 0>;
> -		};
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml b/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
> new file mode 100644
> index 000000000000..84b72e506526
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
> @@ -0,0 +1,147 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/gpio-mvebu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell EBU GPIO controller
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Lee Jones <lee.jones@linaro.org>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - marvell,orion-gpio
> +          - marvell,mv78200-gpio
> +          - marvell,armada-370-gpio

It's expected to have orion fallback, so this does not look correct.

> +          - marvell,armadaxp-gpio
> +          - marvell,armada-8k-gpio
> +      - items:
> +          - const: marvell,armada-370-gpio
> +          - const: marvell,orion-gpio
> +
> +    description: |
> +      "marvell,orion-gpio" should be used for Orion, Kirkwood, Dove, Discovery
> +      (except MV78200) and Armada 370. "marvell,mv78200-gpio" should be used
> +      for the Discovery MV78200.
> +
> +      "marvel,armadaxp-gpio" should be used for all Armada XP SoCs (MV78230,
> +      MV78260, MV78460).
> +
> +      "marvell,armada-8k-gpio" should be used for the Armada 7K and 8K SoCs
> +      (either from AP or CP), see
> +      Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt
> +      for specific details about the offset property.

Why having the description? The usage should be obvious from the schema,
so what is so special here?

> +
> +  reg:
> +    description: |
> +      Address and length of the register set for the device. Only one entry
> +      is expected, except for the "marvell,armadaxp-gpio" variant for which
> +      two entries are expected: one for the general registers, one for the
> +      per-cpu registers. 

This needs also entry in allOf with per-variant constraints.

> Not used for marvell,armada-8k-gpio.
> +
> +      An additional register set is needed, for the GPIO Blink
> +      Counter on/off registers.
> +    minItems: 1
> +    maxItems: 2

PWM? the "reg" above was saying about per-cpu registers, so this is
confusing. I understand old bindings wrote it like that, so maybe it
should be fixed now.

Anyway, you need to describe the items and then apply constraints in allOf.

> +
> +  reg-names:
> +    description:
> +      Must contain an entry "pwm" corresponding to the
> +      additional register range needed for PWM operation.
> +    minItems: 1
> +    maxItems: 2
> +
> +  offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Offset in the register map for the gpio registers (in bytes)
> +
> +  interrupts:
> +    description: |
> +      The list of interrupts that are used for all the pins managed by this
> +      GPIO bank. There can be more than one interrupt (example: 1 interrupt
> +      per 8 pins on Armada XP, which means 4 interrupts per bank of 32
> +      GPIOs).
> +    minItems: 1
> +    maxItems: 4
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  gpio-controller: true
> +
> +  ngpios:
> +    description:
> +      number of GPIOs this controller has

Skip description, it's obvious from generic bindings.

> +    minimum: 1
> +    maximum: 32
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  marvell,pwm-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Offset in the register map for the pwm registers (in bytes)

It's the same as offset. Why allowing both? Isn't one deprecated?

> +
> +  "#pwm-cells":
> +    description:
> +      The first cell is the GPIO line number. The second cell is the period
> +      in nanoseconds.
> +    const: 2
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2

This should be strictly defined, either here or per variant.

> +
> +required:
> +  - compatible
> +  - gpio-controller
> +  - ngpios
> +  - "#gpio-cells"
> +
> +if:

Within allOf please.

Best regards,
Krzysztof
