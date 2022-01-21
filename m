Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703ED4967B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 23:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiAUWI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 17:08:58 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:45728 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiAUWI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 17:08:57 -0500
Received: by mail-oi1-f180.google.com with SMTP id m9so1083159oia.12;
        Fri, 21 Jan 2022 14:08:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=B5PRJv8DW4GtoofF22Yvx5mcu38WclazOKtU1d0nT6U=;
        b=z1t8EgPdc82tFjmnizYT8KGo3305Uc1yE0e9m7QZxPg1FwTXH5rcTaho13UYF+EtUW
         idPsQImxcosKUSDsIXiPXNUeeYKVLspmEcreHVxfBXIK0z6X5jIJt5dMzDi10njumbIs
         fKhOlq7Pg7lMx5Eslsk7C3fQKGHbgT9Jme/lEUlfPpEkXp0gTMXrq/dqDxz4DwM45S9n
         G80mjwd+K3iBZfAjomwcV8/VjDpY2X7oAa4BkumwLkk+lnXYLqxSysBk6WdGuSAJDKRM
         R1WopoKP01xUyfoo5WttPIosRnvhIJiFg8s8n4/MYbZDyUyZ69LGYNc4kdSL1/112QyP
         UNpg==
X-Gm-Message-State: AOAM531EBgBT5gQPH/bBFNi+tBarv7IUgZInBpUWgJySJwsRc9KA8HDP
        5OppJvhrO/gSD0jk8RIR1zSQpkEYfg==
X-Google-Smtp-Source: ABdhPJwnQunxSNcAMTfZBLYtlv7Gl89Wu2H4S7e1uRHLx4SML5xE5ON9F5makJ9I7cRXCkkJuPhyEQ==
X-Received: by 2002:aca:b985:: with SMTP id j127mr2168884oif.92.1642802936359;
        Fri, 21 Jan 2022 14:08:56 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l16sm1310898oop.45.2022.01.21.14.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 14:08:55 -0800 (PST)
Received: (nullmailer pid 1682948 invoked by uid 1000);
        Fri, 21 Jan 2022 22:08:54 -0000
Date:   Fri, 21 Jan 2022 16:08:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmitry.torokhov@gmail.com, rydberg@bitmath.org,
        andreas@kemnade.info, linus.walleij@linaro.org,
        alistair23@gmail.com,
        =?iso-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@free-electrons.com>
Subject: Re: [PATCH v5 2/4] dt-bindings: input: Add Cypress TT2100
 touchscreen controller
Message-ID: <Yesu9riVhZb1b8Jj@robh.at.kernel.org>
References: <20220109115331.388633-1-alistair@alistair23.me>
 <20220109115331.388633-3-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220109115331.388633-3-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2022 at 09:53:29PM +1000, Alistair Francis wrote:
> From: Mylène Josserand <mylene.josserand@free-electrons.com>
> 
> Add the Cypress TrueTouch Generation 5 touchscreen device tree bindings
> documentation. It can use I2C or SPI bus.
> This touchscreen can handle some defined zone that are designed and
> sent as button. To be able to customize the keycode sent, the
> "linux,code" property in a "button" sub-node can be used.
> 
> Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  .../input/touchscreen/cypress,tt21000.yaml    | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
> new file mode 100644
> index 000000000000..acd2d9389f8c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/cypress,tt21000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cypress TT2100 touchscreen controller
> +
> +description: The Cypress TT2100 series (also known as "CYTTSP5" after
> +  the marketing name Cypress TrueTouch Standard Product series 5).
> +
> +maintainers:
> +  - Alistair Francis <alistair@alistair23.me>
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    const: cypress,tt21000
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator for voltage.
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  linux,code:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: EV_ABS specific event code generated by the axis.
> +
> +patternProperties:
> +  "^button-[0-9]+$":

Where does the numbering come from? I assume it correlates to something 
in the h/w. If so, I think you should use 'reg' and a unit-address here. 
Generally, we don't want the node names to be important (i.e. used by 
the OS).

> +    type: object
> +    properties:
> +      linux,code:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Keycode to emit
> +
> +    required:
> +      - linux,code
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - vdd-supply
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/input/linux-event-codes.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        touchscreen@24 {
> +            compatible = "cypress,tt21000";
> +            reg = <0x24>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&tp_reset_ds203>;
> +            interrupt-parent = <&pio>;
> +            interrupts = <1 5 IRQ_TYPE_LEVEL_LOW>;
> +            reset-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>;
> +            vdd-supply = <&reg_touch>;
> +
> +            button-0 {
> +                linux,code = <KEY_HOMEPAGE>;
> +            };
> +
> +            button-1 {
> +                linux,code = <KEY_MENU>;
> +            };
> +
> +            button-2 {
> +                linux,code = <KEY_BACK>;
> +            };
> +        };
> +    };
> +...
> -- 
> 2.31.1
> 
> 
