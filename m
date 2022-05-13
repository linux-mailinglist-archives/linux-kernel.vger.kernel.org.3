Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9B5525DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350072AbiEMIjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242212AbiEMIjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:39:02 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BFD2655EB
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:39:01 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id p4so9183522edx.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5eGnaTrZ5QL37vftbdKCPQxPP9FiPYVF4w7vRXHzsMM=;
        b=LG1nKsPb416GGdMtYA81IjhMhD/KCV58tHHZskrSiRF15YyXN+VUzIYUALgby/QHon
         u2xJFOKT5lYsGSdFD05dRm4immZir8XX/Zy+cktKtuCVh4yloZuqff//IsM1QzUOR8kt
         5Q3MJ2A7NXkZcQHV1f6djfKYOD+HdnbNGRgVkM4Lymq/QRUUa1rs5jXMuuyZhxgiCB3Y
         dxw7pFt8FzAeB+W5JCOIwLs/6btd+Cdgy3XjgyyhnrWolcYAj8p0AReh/hqCYN3Y+SKL
         VZPadeqs4afvv8f39xumhbXS0ZG+VrPn6/0A0BdsSWQlH/69yV3/tdMxT8EJU1pNZVH9
         8SFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5eGnaTrZ5QL37vftbdKCPQxPP9FiPYVF4w7vRXHzsMM=;
        b=j50BviElM0ZSDEb/z8bolsP6+0fTHSI/3EacNI5cyRN9B267B2Amg4S/ybS0JQxV3/
         xFr7brU/zS16AZKfGpOJ/5GQSQ9lCZwDp/yoNjz+e29KeoyWMYSnpn3R7mMcnz049tC4
         ZcnH1u1c+w5qFmZJwrm1Z23wnsR2miEK7UmyzTEmg7GXo2QeyfGmNlDL8ZVfAaiVdXDP
         T8tI9pBDrhqdDOWNlJGdCDEipCruBwHTCSM+CmJ7vqEFjejKxzYc5bFjeGwcO5Cs/px/
         xHwXvZZgMKULXYZExpVLPZPLJXyH0jHtAps4/IiErQp1Qaxsj/D/Fjw97DHRHlBsndCs
         ewHw==
X-Gm-Message-State: AOAM533GCDQeHF1b6VergyZ/HT4U18TUpY/pbGK07yXOtiS4oGR2KetA
        GdNzgyBAaaIrJ4Jqzw1NPNAGIw==
X-Google-Smtp-Source: ABdhPJx1ZUddn9oRkISOeRqNayJCSyiC/ExqIWCAeF8ygLNluQ/SklXUZsGOXJUeCR3R7X8C8EPu3A==
X-Received: by 2002:a05:6402:5190:b0:427:df4a:19d9 with SMTP id q16-20020a056402519000b00427df4a19d9mr39905569edd.384.1652431139697;
        Fri, 13 May 2022 01:38:59 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id yl15-20020a17090693ef00b006f3ef214de7sm540660ejb.77.2022.05.13.01.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:38:59 -0700 (PDT)
Message-ID: <32aab734-5890-99b2-09c9-8ec7418c7649@linaro.org>
Date:   Fri, 13 May 2022 10:38:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/2] dt-bindings: gpio: gpio-mvebu: convert txt binding
 to YAML
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        andrew@lunn.ch
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20220512094125.3748197-1-chris.packham@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220512094125.3748197-1-chris.packham@alliedtelesis.co.nz>
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

On 12/05/2022 11:41, Chris Packham wrote:
> Convert the existing device tree binding to YAML format.
> 
> The old binding listed the interrupt-controller and related properties
> as required but there are sufficiently many existing usages without it
> that the YAML binding does not make the interrupt properties required.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> 
> Notes:
>     Changes in v3:
>     - Correct indent in example
>     - Move offset and marvell,pwm-offset to separate patch
>     - Correct some documentation cross references

Thank you for your patch. There is something to discuss/improve.

> diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml b/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
> new file mode 100644
> index 000000000000..2d95ef707f53
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
> @@ -0,0 +1,143 @@
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

These should be rather platform or driver maintainers, not subsystem
folks. Unless it happens that Thierry and Lee are for platform?

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - marvell,armada-8k-gpio
> +          - marvell,orion-gpio
> +
> +      - items:
> +          - enum:
> +              - marvell,mv78200-gpio
> +              - marvell,armada-370-gpio
> +              - marvell,armadaxp-gpio
> +          - const: marvell,orion-gpio
> +
> +  reg:
> +    description: |
> +      Address and length of the register set for the device. Not used for
> +      marvell,armada-8k-gpio.
> +
> +      For the "marvell,armadaxp-gpio" variant a second entry is expected for
> +      the per-cpu registers. For other variants second entry can be provided,
> +      for the PWM function using the GPIO Blink Counter on/off registers.
> +    minItems: 1
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: gpio
> +      - const: pwm
> +    minItems: 1
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
> +    minimum: 1
> +    maximum: 32
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  "#pwm-cells":
> +    description:
> +      The first cell is the GPIO line number. The second cell is the period
> +      in nanoseconds.
> +    const: 2
> +
> +  clocks:
> +    description:
> +      Clock(s) used for PWM function.
> +    items:
> +      - description: Core clock
> +      - description: AXI bus clock
> +    minItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: axi
> +    minItems: 1
> +
> +required:
> +  - compatible
> +  - gpio-controller
> +  - ngpios
> +  - "#gpio-cells"
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: marvell,armada-8k-gpio
> +    then:
> +      required:
> +        - offset
> +    else:
> +      required:
> +        - reg

one blank line please

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: marvell,armadaxp-gpio

Original bindings are saying that second reg is optional for
marvell,armada-370-gpio. What about other cases, e.g. mv78200-gpio? Is
it also allowed (and optional) there?

> +    then:
> +      properties:
> +        reg:
> +          minItems: 2

Then you also should require two reg-names.


Best regards,
Krzysztof
