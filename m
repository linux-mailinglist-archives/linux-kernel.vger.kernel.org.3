Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F8C54CB29
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243235AbiFOOV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349429AbiFOOVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:21:00 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1168452505
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:20:50 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d13so10514243plh.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zyV3GEz0EDSQFb2UbQd5dyhvw8xF/tMChAgYEabTTbo=;
        b=n0YaiQJC8aGaiZl0GQHQ+sC2arcn1ObpcgX4aiAez63DDiXoukajfmYN558+0OHm60
         I3uwpTVlDR8vwKUj/P9CUU3KAJPQwFHIVdJNJgT1J6izIIYvwJfX5iopYsrTMf0/ygOl
         7Bsr64IwTNyZXqKH4aIGDJTFPQXTWdqqKeKB1KvTLx8LuaqwOgPTenWTfE4z9JS7wcUH
         96lYF/sI9BYSW+VCMsZalq43c9ts2lN1amGqzZ7G83I67rScqO1MbQj10Gc/zg/ctiEJ
         SKLiroNFCXPaITpgiGlMkk8ZJzQr3xpJaLhMYCGmxZUbqarD7BMoInsCl/EilEfMDBdO
         JgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zyV3GEz0EDSQFb2UbQd5dyhvw8xF/tMChAgYEabTTbo=;
        b=4wTz6atnAd9mved50jUC/YmiSYqAAf0tSBG5DSwd9s4bNyoFc0ocC5eTNQIm/KTGao
         JkcurGKoga7WC+7LPQbAo72ec52WlzRDnuUfzt3PXELv14vHDBG5ix5/Wo64vWgm/BvX
         6OQmeeVAJTG5U140YwNkZntaHnF4BNVzePAW5djmi5/Dk5hb7bkrtZfmmlg1W2q/Xeum
         Gzwgi5tz0OU+DFv6Y66Mp6PvEqRFH4smWVLPLpH1EuqDxSo0pTpR/nCn2VvnGdKIFz4R
         czidBLrly2eQHjBvMwnx1ZOdBMlarDpTHrY8vsZ1fY+XiNbYlX499bDrCbugqmLFGSAt
         L7yg==
X-Gm-Message-State: AJIora+YQeujp4X8vVLM1mMoDJyYIx4L6lZ2WnrwMJVTcpM6bERdmmzk
        UDZwvUv/q2pCL2UAs3af8O7ZDA==
X-Google-Smtp-Source: AGRyM1ugZW2UggxybZ/ns7cX9//TMM/zGfmzxhxYGXoT10YOgiB7O7NlzLzk4m/Ap3LxaooPVfF2oQ==
X-Received: by 2002:a17:902:7884:b0:167:4d5b:7a2f with SMTP id q4-20020a170902788400b001674d5b7a2fmr97475pll.18.1655302849484;
        Wed, 15 Jun 2022 07:20:49 -0700 (PDT)
Received: from [172.20.0.255] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id e6-20020a63ae46000000b003f65560a1a7sm9954841pgp.53.2022.06.15.07.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 07:20:49 -0700 (PDT)
Message-ID: <df30578f-3760-a595-963c-35a90f373272@linaro.org>
Date:   Wed, 15 Jun 2022 07:20:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/2] dt-binding: Add cypress,cy8c95x0 binding
Content-Language: en-US
To:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220615104921.1390138-1-patrick.rudolph@9elements.com>
 <20220615104921.1390138-2-patrick.rudolph@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220615104921.1390138-2-patrick.rudolph@9elements.com>
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

On 15/06/2022 03:49, Patrick Rudolph wrote:
> Added device tree binding documentation for
> Cypress CY8C95x0 I2C pin-controller.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>

The subject is still wrong. You need subsystem prefix (pinctrl) and you
can skip final "binding" word, as it is implied by dt-bindings.

> ---
>  .../bindings/pinctrl/cypress,cy8c95x0.yaml    | 131 ++++++++++++++++++
>  1 file changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml b/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
> new file mode 100644
> index 000000000000..765e8834d9dd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
> @@ -0,0 +1,131 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/cypress,cy8c95x0.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cypress CY8C95X0 I2C GPIO expander
> +
> +maintainers:
> +  - Patrick Rudolph <patrick.rudolph@9elements.com>
> +
> +description: |
> +  This supports the 20/40/60 pin Cypress CYC95x0 GPIO I2C expanders.
> +  Pin function configuration is performed on a per-pin basis.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cypress,cy8c9520
> +      - cypress,cy8c9540
> +      - cypress,cy8c9560
> +
> +  reg:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    description:
> +      The first cell is the GPIO number and the second cell specifies GPIO
> +      flags, as defined in <dt-bindings/gpio/gpio.h>.
> +    const: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  gpio-line-names: true
> +
> +  gpio-ranges:
> +    maxItems: 1
> +
> +  gpio-reserved-ranges:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description:
> +      Optional power supply.
> +
> +patternProperties:
> +  '-pins$':
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +    $ref: "/schemas/pinctrl/pincfg-node.yaml"

Skip quotes.

> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this
> +          subnode.
> +        items:
> +          - pattern: "^gp([0-7][0-7])$"

Use the same type of quotes everywhere - either ' or ". Does it actually
work? It looks like you allow here only one pin but the description
suggests it is a list of pins. I think you wanted here just "pattern:
..." without leading minus. Then you need also min and maxItems.

Why blank line here disappeared? My comment was in different place.

> +      function:
> +        description:
> +          Specify the alternative function to be configured for the specified
> +          pins.
> +        enum: [ gpio, pwm ]
> +
> +      bias-pull-down: true
> +
> +      bias-pull-up: true
> +
> +      bias-disable: true
> +
> +      output-high: true
> +
> +      output-low: true
> +
> +      drive-push-pull: true
> +
> +      drive-open-drain: true
> +
> +      drive-open-source: true
> +
> +    required:
> +      - pins
> +      - function
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +  - gpio-controller
> +  - '#gpio-cells'
> +
> +additionalProperties: false
> +
> +allOf:
> +  - $ref: "pinctrl.yaml#"
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c0 {

Just "i2c".

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pinctrl@20 {
> +        compatible = "cypress,cy8c9520";
> +        reg = <0x20>;
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        #interrupt-cells = <2>;
> +        interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-controller;
> +        vdd-supply = <&p3v3>;
> +        gpio-reserved-ranges = <5 1>;
> +      };
> +    };


Best regards,
Krzysztof
