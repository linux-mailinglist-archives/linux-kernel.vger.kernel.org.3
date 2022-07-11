Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F9C56FEC7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiGKKWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiGKKVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:21:53 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9708238B;
        Mon, 11 Jul 2022 02:37:08 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id DD15820012;
        Mon, 11 Jul 2022 09:37:00 +0000 (UTC)
Date:   Mon, 11 Jul 2022 11:36:59 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] media: dt-bindings: ov5693: document YAML binding
Message-ID: <20220711093659.mf7i4uqtrejtfong@uno.localdomain>
References: <20220630134835.592521-1-tommaso.merciai@amarulasolutions.com>
 <20220630134835.592521-6-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220630134835.592521-6-tommaso.merciai@amarulasolutions.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso, Krzysztof,

   This has been reviewed by Krzysztof already, so I guess it's fine,
but let me ask anyway

On Thu, Jun 30, 2022 at 03:48:34PM +0200, Tommaso Merciai wrote:
> Add documentation of device tree in YAML schema for the OV5693
> CMOS image sensor from Omnivision
>
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changes since v1:
>  - Fix allOf position as suggested by Krzysztof
>  - Remove port description as suggested by Krzysztof
>  - Fix EOF as suggested by Krzysztof
>
> Changes since v2:
>  - Fix commit body as suggested by Krzysztof
>
> Changes since v3:
>  - Add reviewed-by tags, suggested by Jacopo, Krzysztof
>
> Changes since v4:
>  - Remove wrong Sakari reviewed-by tag, suggested by Krzysztof, Sakari
>
>  .../bindings/media/i2c/ovti,ov5693.yaml       | 106 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
>
> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> new file mode 100644
> index 000000000000..b83c9fc04023
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2022 Amarulasolutions
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/ovti,ov5693.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Omnivision OV5693 CMOS Sensor
> +
> +maintainers:
> +  - Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> +
> +description: |
> +  The Omnivision OV5693 is a high performance, 1/4-inch, 5 megapixel, CMOS
> +  image sensor that delivers 2592x1944 at 30fps. It provides full-frame,
> +  sub-sampled, and windowed 10-bit MIPI images in various formats via the
> +  Serial Camera Control Bus (SCCB) interface.
> +
> +  OV5693 is controlled via I2C and two-wire Serial Camera Control Bus (SCCB).
> +  The sensor output is available via CSI-2 serial data output (up to 2-lane).
> +
> +allOf:
> +  - $ref: /schemas/media/video-interface-devices.yaml#
> +
> +properties:
> +  compatible:
> +    const: ovti,ov5693
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      System input clock (aka XVCLK). From 6 to 27 MHz.
> +    maxItems: 1
> +
> +  dovdd-supply:
> +    description:
> +      Digital I/O voltage supply, 1.8V.
> +
> +  avdd-supply:
> +    description:
> +      Analog voltage supply, 2.8V.
> +
> +  dvdd-supply:
> +    description:
> +      Digital core voltage supply, 1.2V.
> +
> +  reset-gpios:
> +    description:
> +      The phandle and specifier for the GPIO that controls sensor reset.
> +      This corresponds to the hardware pin XSHUTDN which is physically
> +      active low.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - dovdd-supply
> +  - avdd-supply
> +  - dvdd-supply

Should supplies be made mandatory ? Sensors are often powered by fixed
rails. Do we want DTS writers to create "fixed-regulators" for all of
them ? The fact the regulator framework creates dummies if there's no
entry in .dts for a regulator makes me think it's fine to have them
optional, but I understand how Linux works should not be an indication
of how a bindings should look like.

> +  - port
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/px30-cru.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/pinctrl/rockchip.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ov5693: camera@36 {
> +            compatible = "ovti,ov5693";
> +            reg = <0x36>;
> +
> +            reset-gpios = <&gpio2 RK_PB1 GPIO_ACTIVE_LOW>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&cif_clkout_m0>;
> +
> +            clocks = <&cru SCLK_CIF_OUT>;
> +            assigned-clocks = <&cru SCLK_CIF_OUT>;
> +            assigned-clock-rates = <19200000>;
> +
> +            avdd-supply = <&vcc_1v8>;
> +            dvdd-supply = <&vcc_1v2>;
> +            dovdd-supply = <&vcc_2v8>;
> +
> +            rotation = <90>;
> +            orientation = <0>;
> +
> +            port {
> +                ucam_out: endpoint {
> +                    remote-endpoint = <&mipi_in_ucam>;
> +                    data-lanes = <1 2>;
> +                    link-frequencies = /bits/ 64 <450000000>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1fc9ead83d2a..844307cb20c4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14719,6 +14719,7 @@ M:	Daniel Scally <djrscally@gmail.com>
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
>  T:	git git://linuxtv.org/media_tree.git
> +F:	Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
>  F:	drivers/media/i2c/ov5693.c
>
>  OMNIVISION OV5695 SENSOR DRIVER
> --
> 2.25.1
>
