Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D8A57207A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiGLQMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbiGLQMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:12:49 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1362BFAC6;
        Tue, 12 Jul 2022 09:12:42 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 50C4840011;
        Tue, 12 Jul 2022 16:12:38 +0000 (UTC)
Date:   Tue, 12 Jul 2022 18:12:36 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] media: dt-bindings: ov5693: document YAML binding
Message-ID: <20220712161236.le6wvdhdbleoxeyf@uno.localdomain>
References: <20220630134835.592521-1-tommaso.merciai@amarulasolutions.com>
 <20220630134835.592521-6-tommaso.merciai@amarulasolutions.com>
 <20220711093659.mf7i4uqtrejtfong@uno.localdomain>
 <20220712152538.jh4ufxik7icllox6@uno.localdomain>
 <47aa4fbc-9cf4-7ac3-2fb4-2135a7703212@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47aa4fbc-9cf4-7ac3-2fb4-2135a7703212@linaro.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

On Tue, Jul 12, 2022 at 05:32:45PM +0200, Krzysztof Kozlowski wrote:
> On 12/07/2022 17:25, Jacopo Mondi wrote:
> > Hi Krzysztof
> >    could you have a look at the below question ?
>
> Sorry, there was a bunch of quoted text without end. When you reply
> under quote, please remove the rest of the quote. None of us have a lot
> of time to waste on scrolling emails...
>

I should have kept a counter of the times I've been told "please do
not remove context, I'm so busy I do not have time to read the whole
thread" and "please remove context, I'm so busy I cannot read the
whole email".

After 5 years of kernel development I would now know what to do.

> >
> > If no need to resend from Tommaso I think the series could be
> > collected for v5.20.
> >
> > On Mon, Jul 11, 2022 at 11:37:05AM +0200, Jacopo Mondi wrote:
> >> Hi Tommaso, Krzysztof,
> >>
> >>    This has been reviewed by Krzysztof already, so I guess it's fine,
> >> but let me ask anyway
> >>
> >> On Thu, Jun 30, 2022 at 03:48:34PM +0200, Tommaso Merciai wrote:
> >>> Add documentation of device tree in YAML schema for the OV5693
> >>> CMOS image sensor from Omnivision
> >>>
> >>> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> >>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>> ---
> >>> Changes since v1:
> >>>  - Fix allOf position as suggested by Krzysztof
> >>>  - Remove port description as suggested by Krzysztof
> >>>  - Fix EOF as suggested by Krzysztof
> >>>
> >>> Changes since v2:
> >>>  - Fix commit body as suggested by Krzysztof
> >>>
> >>> Changes since v3:
> >>>  - Add reviewed-by tags, suggested by Jacopo, Krzysztof
> >>>
> >>> Changes since v4:
> >>>  - Remove wrong Sakari reviewed-by tag, suggested by Krzysztof, Sakari
> >>>
> >>>  .../bindings/media/i2c/ovti,ov5693.yaml       | 106 ++++++++++++++++++
> >>>  MAINTAINERS                                   |   1 +
> >>>  2 files changed, 107 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> >>> new file mode 100644
> >>> index 000000000000..b83c9fc04023
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> >>> @@ -0,0 +1,106 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +# Copyright (c) 2022 Amarulasolutions
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/media/i2c/ovti,ov5693.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Omnivision OV5693 CMOS Sensor
> >>> +
> >>> +maintainers:
> >>> +  - Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> >>> +
> >>> +description: |
> >>> +  The Omnivision OV5693 is a high performance, 1/4-inch, 5 megapixel, CMOS
> >>> +  image sensor that delivers 2592x1944 at 30fps. It provides full-frame,
> >>> +  sub-sampled, and windowed 10-bit MIPI images in various formats via the
> >>> +  Serial Camera Control Bus (SCCB) interface.
> >>> +
> >>> +  OV5693 is controlled via I2C and two-wire Serial Camera Control Bus (SCCB).
> >>> +  The sensor output is available via CSI-2 serial data output (up to 2-lane).
> >>> +
> >>> +allOf:
> >>> +  - $ref: /schemas/media/video-interface-devices.yaml#
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: ovti,ov5693
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  clocks:
> >>> +    description:
> >>> +      System input clock (aka XVCLK). From 6 to 27 MHz.
> >>> +    maxItems: 1
> >>> +
> >>> +  dovdd-supply:
> >>> +    description:
> >>> +      Digital I/O voltage supply, 1.8V.
> >>> +
> >>> +  avdd-supply:
> >>> +    description:
> >>> +      Analog voltage supply, 2.8V.
> >>> +
> >>> +  dvdd-supply:
> >>> +    description:
> >>> +      Digital core voltage supply, 1.2V.
> >>> +
> >>> +  reset-gpios:
> >>> +    description:
> >>> +      The phandle and specifier for the GPIO that controls sensor reset.
> >>> +      This corresponds to the hardware pin XSHUTDN which is physically
> >>> +      active low.
> >>> +    maxItems: 1
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +  - reg
> >>> +  - clocks
> >>> +  - dovdd-supply
> >>> +  - avdd-supply
> >>> +  - dvdd-supply
> >>
> >> Should supplies be made mandatory ? Sensors are often powered by fixed
> >> rails. Do we want DTS writers to create "fixed-regulators" for all of
> >> them ? The fact the regulator framework creates dummies if there's no
> >> entry in .dts for a regulator makes me think it's fine to have them
> >> optional, but I understand how Linux works should not be an indication
> >> of how a bindings should look like.
> >>
> >
> > This question ^ :)
>
> My generic answer for generic devices would be - if resource is
> physically required (one need to connect the wire), I would say it
> should be also required in the bindings. This also forces driver
> developer to think about these resources and might result on
> portable/better code.
>
> However your point is correct that it might create many "fake"
> regulators, because pretty often these are fixed on the board and not
> controllable. Therefore I am fine with not requiring them - to adjust
> the bindings to real life cases.

Tommaso if you can re-send this one with the supplies dropped I think
the series is still in time for being collected for this merge window
(Sakari to confirm this).

Thanks
  j

>
> Best regards,
> Krzysztof
