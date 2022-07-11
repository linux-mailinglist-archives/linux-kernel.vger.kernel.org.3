Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7CE5700A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiGKL3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiGKL3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:29:11 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAE025F6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:11:12 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y8so5794537eda.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D5nVikuoA6wfNZyYZEzQvKz72M0/Hoh1lF2/51VFzaU=;
        b=PFmjS82N1zfBDFvFZoBsJI+jFwyxeYBX5qh9A7cpI5hKkKjCY1Gx5O5Yl97JlpktZ6
         wBJvkLJwAxx3ts1Id/RA13sqev1y7yO8i+AvP4P3SafTI2D+vencAZDY7eJd10xTqbZ+
         m8zAQaadWg7AsqbYWqP0IcncCwdDfgxVJP1Zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D5nVikuoA6wfNZyYZEzQvKz72M0/Hoh1lF2/51VFzaU=;
        b=DTxlYwajYawPuP3Ddlw5Bql5232yEo1fOAwbEwmi7XiFD8cOIcyVOdb2hYP5ISelqu
         hOJ9ZOw2mITIIR7Se6mLBqMEDzZ3xid39KPKgHPfDUrVPnyPH41+tsF7+mrSIsrnmGRx
         dAzWNUdC1Z6wm0LDraHjMm2EQVo6bGd7DorJ+OAZ6LuxJlg2mx5gs58NMFvskxIIoj7o
         ITKZg6O8uc6EdSmDhrqn8aLipimmv9IcBvDNB18Delv5QbCUM6l76HJ56UhqnpAP7oUO
         5FFLbeFiLAwZ6E/4BFR0tUopB+FQ3KxrmxWjSonMIJPdzYMh8Hjgk0mej23nvq6s1woj
         Uang==
X-Gm-Message-State: AJIora9Fk4cqSeA3uQBAmyRJsx9TLLaBumxyDBItRm+b00IXJwXyi7B1
        IGatE/GpzoJszibpg338YCY5Ng==
X-Google-Smtp-Source: AGRyM1vOpri2JWJlhoTxQIZUiDN+X2lDVKiMEo7HvoZbkDdspCf79QwoJomwds9oGsdoOeNFlfaybQ==
X-Received: by 2002:a05:6402:cba:b0:43a:6b17:f6b5 with SMTP id cn26-20020a0564020cba00b0043a6b17f6b5mr24260662edb.330.1657537871095;
        Mon, 11 Jul 2022 04:11:11 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-59-144.cust.vodafonedsl.it. [188.217.59.144])
        by smtp.gmail.com with ESMTPSA id ku24-20020a170907789800b0072af102e65csm2571629ejc.152.2022.07.11.04.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 04:11:10 -0700 (PDT)
Date:   Mon, 11 Jul 2022 13:11:08 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
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
Message-ID: <20220711111108.GA66765@tom-ThinkPad-T14s-Gen-2i>
References: <20220630134835.592521-1-tommaso.merciai@amarulasolutions.com>
 <20220630134835.592521-6-tommaso.merciai@amarulasolutions.com>
 <20220711093659.mf7i4uqtrejtfong@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711093659.mf7i4uqtrejtfong@uno.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,
Thanks for your review.

On Mon, Jul 11, 2022 at 11:36:59AM +0200, Jacopo Mondi wrote:
> Hi Tommaso, Krzysztof,
> 
>    This has been reviewed by Krzysztof already, so I guess it's fine,
> but let me ask anyway
> 
> On Thu, Jun 30, 2022 at 03:48:34PM +0200, Tommaso Merciai wrote:
> > Add documentation of device tree in YAML schema for the OV5693
> > CMOS image sensor from Omnivision
> >
> > Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > Changes since v1:
> >  - Fix allOf position as suggested by Krzysztof
> >  - Remove port description as suggested by Krzysztof
> >  - Fix EOF as suggested by Krzysztof
> >
> > Changes since v2:
> >  - Fix commit body as suggested by Krzysztof
> >
> > Changes since v3:
> >  - Add reviewed-by tags, suggested by Jacopo, Krzysztof
> >
> > Changes since v4:
> >  - Remove wrong Sakari reviewed-by tag, suggested by Krzysztof, Sakari
> >
> >  .../bindings/media/i2c/ovti,ov5693.yaml       | 106 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 107 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> > new file mode 100644
> > index 000000000000..b83c9fc04023
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> > @@ -0,0 +1,106 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (c) 2022 Amarulasolutions
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/i2c/ovti,ov5693.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Omnivision OV5693 CMOS Sensor
> > +
> > +maintainers:
> > +  - Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> > +
> > +description: |
> > +  The Omnivision OV5693 is a high performance, 1/4-inch, 5 megapixel, CMOS
> > +  image sensor that delivers 2592x1944 at 30fps. It provides full-frame,
> > +  sub-sampled, and windowed 10-bit MIPI images in various formats via the
> > +  Serial Camera Control Bus (SCCB) interface.
> > +
> > +  OV5693 is controlled via I2C and two-wire Serial Camera Control Bus (SCCB).
> > +  The sensor output is available via CSI-2 serial data output (up to 2-lane).
> > +
> > +allOf:
> > +  - $ref: /schemas/media/video-interface-devices.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: ovti,ov5693
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description:
> > +      System input clock (aka XVCLK). From 6 to 27 MHz.
> > +    maxItems: 1
> > +
> > +  dovdd-supply:
> > +    description:
> > +      Digital I/O voltage supply, 1.8V.
> > +
> > +  avdd-supply:
> > +    description:
> > +      Analog voltage supply, 2.8V.
> > +
> > +  dvdd-supply:
> > +    description:
> > +      Digital core voltage supply, 1.2V.
> > +
> > +  reset-gpios:
> > +    description:
> > +      The phandle and specifier for the GPIO that controls sensor reset.
> > +      This corresponds to the hardware pin XSHUTDN which is physically
> > +      active low.
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - dovdd-supply
> > +  - avdd-supply
> > +  - dvdd-supply
> 
> Should supplies be made mandatory ? Sensors are often powered by fixed
> rails. Do we want DTS writers to create "fixed-regulators" for all of
> them ? The fact the regulator framework creates dummies if there's no
> entry in .dts for a regulator makes me think it's fine to have them
> optional, but I understand how Linux works should not be an indication
> of how a bindings should look like.

You are right, this depends on hw design and yes in many cases sensors are
powered by fixed rails.
But let me say, I see some design in wich I have to handle these signals and
in fact are mandatory.

I check also in others binding's doc like:

 - Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
 - Documentation/devicetree/bindings/media/i2c/ovti,ov02a10.yaml
 - Documentation/devicetree/bindings/media/i2c/ovti,ov8865.yaml
 ...

These keep this information. 

Anyway, You suggest to drop off:

 - dovdd-supply
 - avdd-supply
 - dvdd-supply

From required properties, right?

Tommmaso

> 
> > +  - port
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/px30-cru.h>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/pinctrl/rockchip.h>
> > +
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        ov5693: camera@36 {
> > +            compatible = "ovti,ov5693";
> > +            reg = <0x36>;
> > +
> > +            reset-gpios = <&gpio2 RK_PB1 GPIO_ACTIVE_LOW>;
> > +            pinctrl-names = "default";
> > +            pinctrl-0 = <&cif_clkout_m0>;
> > +
> > +            clocks = <&cru SCLK_CIF_OUT>;
> > +            assigned-clocks = <&cru SCLK_CIF_OUT>;
> > +            assigned-clock-rates = <19200000>;
> > +
> > +            avdd-supply = <&vcc_1v8>;
> > +            dvdd-supply = <&vcc_1v2>;
> > +            dovdd-supply = <&vcc_2v8>;
> > +
> > +            rotation = <90>;
> > +            orientation = <0>;
> > +
> > +            port {
> > +                ucam_out: endpoint {
> > +                    remote-endpoint = <&mipi_in_ucam>;
> > +                    data-lanes = <1 2>;
> > +                    link-frequencies = /bits/ 64 <450000000>;
> > +                };
> > +            };
> > +        };
> > +    };
> > +
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1fc9ead83d2a..844307cb20c4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14719,6 +14719,7 @@ M:	Daniel Scally <djrscally@gmail.com>
> >  L:	linux-media@vger.kernel.org
> >  S:	Maintained
> >  T:	git git://linuxtv.org/media_tree.git
> > +F:	Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> >  F:	drivers/media/i2c/ov5693.c
> >
> >  OMNIVISION OV5695 SENSOR DRIVER
> > --
> > 2.25.1
> >

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
