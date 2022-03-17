Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C88E4DC331
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiCQJqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiCQJqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:46:17 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE731AAFC4;
        Thu, 17 Mar 2022 02:45:00 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id b19so6480800wrh.11;
        Thu, 17 Mar 2022 02:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BIsej/fBX7RVeqwrLbFPG3V5lHvWvQ/MKBBud6g58/g=;
        b=oEslTyV5i1Oye8JfUhEME+/QPVe8TOnbZSFr40/2Jam0pyB0eAi0Lz8fFQqV0u8z4+
         2JnEwqWtk4SqV7zM76DmrmoJ+WVJZhAiAeYYTEfiRV6xjHuni7KtpiWJnNM4+38DhnV9
         qwp/UfuAcNHgBLXka/a78L8nOaO6mCbOE1QaogLYYC9pkVerWZrsEXaaZrDMQTkgg5OQ
         5yNxeSzep6pcPWhI3AbLQCbEwTjetuN90blgCm8VUvE7xL2jOuF1uaq5FOws9T1bwCMF
         IZLt7aLAokT1W8ROmu81SpcCwvIehref5X99rhpVHfvBEOJQJ3NtY/HRT9V/Ay6dPW1r
         U5vg==
X-Gm-Message-State: AOAM5316MZfvFNYfJvz71JI+UcXPJC1x8i1BEhRk5VHiShXuZoFBrzER
        F2HB8qoShEJGZgPgBPhbTzs=
X-Google-Smtp-Source: ABdhPJwBx4IlPpEFAwjA2GiR5NIv9ipGvJkg0rcec13xACQMcGpnku47qtShu9Fnx+pV7uflhGu3Sw==
X-Received: by 2002:adf:eb81:0:b0:1e3:2bf5:132 with SMTP id t1-20020adfeb81000000b001e32bf50132mr3266317wrn.246.1647510299158;
        Thu, 17 Mar 2022 02:44:59 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm5273451wri.0.2022.03.17.02.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 02:44:58 -0700 (PDT)
Message-ID: <971850ad-96af-2abb-f4bf-ba6188e2d732@kernel.org>
Date:   Thu, 17 Mar 2022 10:44:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v4 1/5] dt-bindings: interrupt-controller: Add Renesas
 RZ/G2L Interrupt Controller
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220317012404.8069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220317012404.8069-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220317012404.8069-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2022 02:24, Lad Prabhakar wrote:
> Add DT bindings for the Renesas RZ/G2L Interrupt Controller.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../renesas,rzg2l-irqc.yaml                   | 131 ++++++++++++++++++
>  1 file changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> new file mode 100644
> index 000000000000..a14492ec9235
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> @@ -0,0 +1,131 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/renesas,rzg2l-irqc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G2L (and alike SoC's) Interrupt Controller (IA55)
> +
> +maintainers:
> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> +  - Geert Uytterhoeven <geert+renesas@glider.be>
> +
> +description: |
> +  IA55 performs various interrupt controls including synchronization for the external
> +  interrupts of NMI, IRQ, and GPIOINT and the interrupts of the built-in peripheral
> +  interrupts output by each IP. And it notifies the interrupt to the GIC
> +    - IRQ sense select for 8 external interrupts, mapped to 8 GIC SPI interrupts
> +    - GPIO pins used as external interrupt input pins, mapped to 32 GIC SPI interrupts
> +    - NMI edge select (NMI is not treated as NMI exception and supports fall edge and
> +      stand-up edge detection interrupts)
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,r9a07g044-irqc    # RZ/G2L
> +      - const: renesas,rzg2l-irqc
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  '#address-cells':
> +    const: 0
> +
> +  interrupt-controller: true
> +
> +  reg:
> +    maxItems: 1> +
> +  interrupts:
> +    maxItems: 41
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: clk
> +      - const: pclk
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - '#interrupt-cells'
> +  - '#address-cells'
> +  - interrupt-controller
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - resets
> +
> +additionalProperties: false

This should be rather unevaluatedProperties and remove
interrupt-controller:true from properties.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> +
> +    irqc: interrupt-controller@110a0000 {
> +            compatible = "renesas,r9a07g044-irqc", "renesas,rzg2l-irqc";
> +            #interrupt-cells = <2>;
> +            #address-cells = <0>;
> +            interrupt-controller;
> +            reg = <0x110a0000 0x10000>;

Put the reg after compatible in DTS code. The ordering of properties in
bindings is a bit odd, but I wasn't following order by myself, so cannot
complain. :)



Best regards,
Krzysztof
