Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4509484890
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 20:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiADTaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 14:30:30 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:43724 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiADTa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:30:28 -0500
Received: by mail-oi1-f182.google.com with SMTP id u21so47721764oie.10;
        Tue, 04 Jan 2022 11:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Fp7mpV0jaGY/mBci3bW2viP27TakGFeuXQpYOq0ghhY=;
        b=rd07o7jV/7gIBrOfwjjL+dsSZCIWy6NAqUUSF+Zahu7WS0TBYo9gmxLtWYyaSQFA2B
         aoztWil5fy+Zxo+bXElQ4O7ycLJaW/6TavpbZ4wdTvbetFgwjXz8jV7O47oySiubEqkw
         oKIbmFFxNB0AMezjSdCQoInqKjvmySA9RZoi6SAWIq+aW0ZprQM8lUH6A2LgYpwny3Fh
         QDi2/zyg7geLXRnG0bO91pubBSrolgmD0xot3gyCgM/OEr50tLfhJsiLOthaiHVTuhvR
         eYQ+/NuVR/YTC6L64LeiTuObqAtWJBnMfd0tsD3d5M9uKxO7/iU/2WHDt60EvHVR6pag
         hfRA==
X-Gm-Message-State: AOAM530ha3Au8WnXPeWHqlXzjWBYYNoRBwTzmxLUKivoloHcOcodvMpH
        7ICn+OyyeM7fy5WWauZqwA==
X-Google-Smtp-Source: ABdhPJxR+udq9ZViO2cj397JZRBYhhH5HT6XF2Y2AOr6hkSQFSItryyl69fzJh8TNOcXXyssw8NUPg==
X-Received: by 2002:a05:6808:241:: with SMTP id m1mr39397412oie.169.1641324627810;
        Tue, 04 Jan 2022 11:30:27 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x26sm2075011ote.78.2022.01.04.11.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 11:30:27 -0800 (PST)
Received: (nullmailer pid 1268031 invoked by uid 1000);
        Tue, 04 Jan 2022 19:30:26 -0000
Date:   Tue, 4 Jan 2022 13:30:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.torokhov@gmail.com, alistair23@gmail.com,
        linus.walleij@linaro.org, rydberg@bitmath.org,
        andreas@kemnade.info,
        =?iso-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@free-electrons.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: input: Add Cypress TT2100
 touchscreen controller
Message-ID: <YdSgUgdETb12TEVf@robh.at.kernel.org>
References: <20211222124603.326920-1-alistair@alistair23.me>
 <20211222124603.326920-3-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211222124603.326920-3-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 10:46:01PM +1000, Alistair Francis wrote:
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
> index 000000000000..5a721d789c87
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: GPL-2.0-only

Dual license new bindings. GPL-2.0-only OR BSD-2-Clause


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
