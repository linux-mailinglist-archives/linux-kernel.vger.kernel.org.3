Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCD1530DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbiEWKOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbiEWKOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:14:49 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B107D40906
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:14:47 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id g16so16616409lja.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DTFzfs97FGySKOakohZLd/CBj+6KUAF9b0qA3qCgoMw=;
        b=gMFbmeA3lnmZFoM/x1iVzSdGVpG9K2u4Io4V1OeB9s0OwEauY9FPtlPWee+kYl+Cc7
         cgriJgvPw1fOW6QbkbM1WMcFZhbQV70nsCl0VwBHjhEn6yK9i8mR+UVzuQR0y0uoyCtv
         fSySWkMgSf1ifL2jhguyBhOAVuXcOo6v1KsMsodCExQPta4PmVwsEaohhgkwtPjBbCos
         v4mHYb2t/R9pCQAAVX47eeqPj5kiZNgMkJ9n6O+sTbL6bYhSvj2o8yyVpA41Ez+OZ+wK
         dLIq4QVddqjGbNqZf30wndeFCcrMwWT2BMVwArbfZfd9rjQqHc8YIfvJYVoVUbFfaM81
         XAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DTFzfs97FGySKOakohZLd/CBj+6KUAF9b0qA3qCgoMw=;
        b=BmUb7HAD0iXb6iSDGReWYj4jPdsXC5lR/nXm4Zjs8mk48f0D+JpxhdgcXSJp3DoLYs
         a4pYPz/YWha0W+h6tyH0WqGQosoLZZyRZadIIgI2TrjSjS431q7yXW183iMohlYeqDjO
         XTFXMOY+QZK4FnSd102XMUEb2eFwOp+2U5WWO8UtYO6Xu0bH0xbb5nNCmu3s5f34bfbj
         PgyC94yTeVjTLAwngfUkxmhHSBq7xU8dPbFCUMfG99SyXplFWyu46Fq58Y19iM5DmcYC
         V8DsCrP9ezTo8F7/RKgb0d1jpjVD47aClojxmZRCzqr/delYe0+MpIoOD6aUBYv6/HuT
         bdCw==
X-Gm-Message-State: AOAM530s+kgKahIKNbJrnlaxHi7KdgJw6m80pHeruvHnUIZZQYGVqqK/
        OCJPC2uG4+xjeAooNggWjCys1g==
X-Google-Smtp-Source: ABdhPJybMlIwD6+ltyktZPc/eHNgHuIQEUlFFZz6NpeI0qV0IZplIUkZjZlP79fsYNw3onR3Un/dSQ==
X-Received: by 2002:a2e:9c43:0:b0:250:a467:400 with SMTP id t3-20020a2e9c43000000b00250a4670400mr12511597ljj.348.1653300886072;
        Mon, 23 May 2022 03:14:46 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c20-20020a05651c015400b00253cf1c1c15sm1731941ljd.49.2022.05.23.03.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 03:14:45 -0700 (PDT)
Message-ID: <d12a0afc-c040-5615-fc0d-70a5c29bbf0a@linaro.org>
Date:   Mon, 23 May 2022 12:14:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] dt-bindings: leds: Add bindings for the TLC5925
 controller
Content-Language: en-US
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220523084958.2723943-1-jjhiblot@traphandler.com>
 <20220523084958.2723943-2-jjhiblot@traphandler.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220523084958.2723943-2-jjhiblot@traphandler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2022 10:49, Jean-Jacques Hiblot wrote:
> Add bindings documentation for the TLC5925 LED controller.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

Thank you for your patch. There is something to discuss/improve.

> ---
> devicetree@vger.kernel.org
>  .../bindings/leds/leds-tlc5925.yaml           | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-tlc5925.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml b/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml
> new file mode 100644
> index 000000000000..156db599d5a1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml

Filename: vendor,device
so "ti,tlc5925-leds.yaml" for example.



> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/leds-tlc5925.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LEDs connected to TI TLC5925 controller
> +
> +maintainers:
> +  - Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> +
> +description: |
> +  The TLC5925 is a low-power 16-channel constant-current LED sink driver.
> +  It is controlled through a SPI interface.
> +  It is built around a shift register and latches which convert serial
> +  input data into a parallel output. Several TLC5925 can be chained to
> +  control more than 16 LEDs with a single chip-select.
> +  The brightness level cannot be controlled, each LED is either on or off.
> +
> +  Each LED is represented as a sub-node of the ti,tlc5925 device.
> +
> +properties:
> +  compatible:
> +    const: ti,tlc5925
> +
> +  shift_register_length:
> +    maxItems: 1

No...
1. Did you test your bindings with dt_binding_check? This fails
obviously... please, do not send untested bindings.

2. vendor prefix, no underscores, proper type, maxItems look wrong here

> +    description: |
> +      The length of the shift register. If several TLC5925 are chained,
> +      shift_register_length should be set to 16 times the number of TLC5925.
> +      The value must be a multiple of 8.
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  output-enable-b-gpios:
> +    description: |
> +      GPIO pins to enable/disable the parallel output. They describe the GPIOs
> +      connected to the OE/ pin of the TLC5925s.

maxItems


> +
> +patternProperties:
> +  "@[a-f0-9]+$":

How many LEDs you can have here? Usually it is limited, so the pattern
should be narrowed.

> +    type: object
> +
> +    $ref: common.yaml#
> +
> +    properties:
> +      reg:
> +        items:

Not correct syntax... I will stop reviewing. There is no point to use
reviewers time to do the job of a tool.


> +examples:
> +  - |
> +    &spi0 {
> +        leds@2 {
> +                compatible = "ti,tlc5925";

Messed up indentation. 4 spaces for DTS example.

> +                reg = <0x02>;
> +                spi-max-frequency = <30000000>;
> +                shift_register_length = <32>;
> +                output-enable-b-gpios = <&gpio0b 9 GPIO_ACTIVE_HIGH>, <&gpio0b 7 GPIO_ACTIVE_HIGH>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                led-satus@0 {
> +                        reg = <0>;
> +                        function = LED_FUNCTION_STATUS;
> +                        color = <LED_COLOR_ID_GREEN>;
> +                };
> +
> +                led-satus@4 {
> +                        reg = <4>;
> +                        function = LED_FUNCTION_STATUS;
> +                        color = <LED_COLOR_ID_RED>;
> +                };
> +
> +                led-alive@24 {
> +                        reg = <24>;
> +                        label = "green:alive"
> +                };
> +
> +                led-panic@31 {
> +                        reg = <31>;
> +                        label = "red:panic"
> +                };
> +        };
> +    };


Best regards,
Krzysztof
