Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E062F4AD7C7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356796AbiBHLsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbiBHLr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:47:56 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E81C00268D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:36:00 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id eg42so21044570edb.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 03:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KPlR6gJDHsACPyVMcZtoDq6lm4JjvzGgUldKcw5CvFE=;
        b=SekmjhaP94H/FC7zsedKUk/Cq7nQQIzfVQs5LybFKPQUdwVI4pdmzAVRAFBMxz69u0
         tQiuFmuSdZmojfO+wMkOh5iMArzfwnxI15v4uu7shP1tnL64/p0QSOj/z00TACxZCoAk
         CEN0EQFQkgwxZuLtBcPe+gJ/niMzChiXIb6WXUTYEymnBoaTwCJGCBNVzqxECZPtbOIG
         BMP+pMnpDr55sMeZr2pqkF1wpBgdxCxagJptZhVjgaA7K7Nn5naU8GzmZGsro7djODkb
         FW6Nica3Rfa6WPUYGMsa+j6f9IJsZJLjynA1bIWQee6CXPyETUguRtzFM2z0soPv79BG
         L5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KPlR6gJDHsACPyVMcZtoDq6lm4JjvzGgUldKcw5CvFE=;
        b=ptaR76iK5c1uyFNham42HsIAtDTr3RAJPZjr14TmuP6rYhZBgLOh02usIJjUzCs+8j
         h0pw2xTnR5B2NMSvCOXVfl/7nfgBXZVI9uL9rT8SaM9ZzI7/6RT/xV16f4FBa/3W6bMd
         gqOEAIRYwJi3iupvFioZkRLigYavggaHb7xMUAu/MDskhjPFk/+3DeK1LzJfU7Sessdq
         f9qomz48Nb93t+pzwnUTo4QEQ+S7IYM5WFx4b/zzVrGpOpT8PdGVrjF+SrrFUzzQcXcU
         DCtwV0TNmoFXhQpiktMnBVGPi/Op/gzXWPy2f+2RNzAzS8XnfuyyDCFiOJWftWdi+rsO
         x4kg==
X-Gm-Message-State: AOAM5316jytZnGjqQQRZDGuVJb/u2HecmLGiwY+Ii4Rm+mnB2bjGu75+
        UvF48RmRM+ELJG8Zw8xxsPgiKGsikCW3hkhXpv+S1w==
X-Google-Smtp-Source: ABdhPJzYSB24uVf1cbhEcYjKt3W+LXFr1sz/yMsFDj7wmuiLzgtrwFIAmARBE3XfnAfTr+nMGzumxyfE0tCCxcFEHUc=
X-Received: by 2002:aa7:c917:: with SMTP id b23mr4035128edt.118.1644320155975;
 Tue, 08 Feb 2022 03:35:55 -0800 (PST)
MIME-Version: 1.0
References: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com>
 <7954256.DvuYhMxLoT@steina-w> <Yf3fe2F88SNcl2Jd@pendragon.ideasonboard.com>
 <5541132.DvuYhMxLoT@steina-w> <YgHJIsZSrDFp9xvF@pendragon.ideasonboard.com>
In-Reply-To: <YgHJIsZSrDFp9xvF@pendragon.ideasonboard.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 8 Feb 2022 11:35:39 +0000
Message-ID: <CAPY8ntDBu2M89Eif93SaOLykPzTCzCVwE1MypNMxJ+kmAY_5JA@mail.gmail.com>
Subject: Re: (EXT) Re: (EXT) [RFC PATCH v4 03/12] dt-bindings: media: Add
 bindings for bcm2835-unicam
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, LKML <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Naushir Patuck <naush@raspberrypi.com>, robh@kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander and Laurent

On Tue, 8 Feb 2022 at 01:36, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Alexander,
>
> On Mon, Feb 07, 2022 at 07:30:25AM +0100, Alexander Stein wrote:
> > Am Samstag, 5. Februar 2022, 03:22:51 CET schrieb Laurent Pinchart:
> > > On Fri, Feb 04, 2022 at 09:50:06AM +0100, Alexander Stein wrote:
> > > > Am Donnerstag, 3. Februar 2022, 18:50:00 CET schrieb Jean-Michel Hautbois:
> > > > > Introduce the dt-bindings documentation for bcm2835 CCP2/CSI2 Unicam
> > > > > camera interface. Also add a MAINTAINERS entry for it.
> > > > >
> > > > > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > > > > Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> > > > > Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> > > > >
> > > > > ---
> > > > > v4:
> > > > > - make MAINTAINERS its own patch
> > > > > - describe the reg and clocks correctly
> > > > > - use a vendor entry for the number of data lanes
> > > > > ---
> > > > >
> > > > >  .../bindings/media/brcm,bcm2835-unicam.yaml   | 110 ++++++++++++++++++
> > > > >  1 file changed, 110 insertions(+)
> > > > >  create mode 100644
> > > > >
> > > > > Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> > > > >
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> > > > > b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..0725a0267c60
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> > > > > @@ -0,0 +1,110 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/media/brcm,bcm2835-unicam.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Broadcom BCM283x Camera Interface (Unicam)
> > > > > +
> > > > > +maintainers:
> > > > > +  - Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> > > > > +
> > > > > +description: |-
> > > > > +  The Unicam block on BCM283x SoCs is the receiver for either
> > > > > +  CSI-2 or CCP2 data from image sensors or similar devices.
> > > > > +
> > > > > +  The main platform using this SoC is the Raspberry Pi family of boards.
> > > > > +  On the Pi the VideoCore firmware can also control this hardware block,
> > > > > +  and driving it from two different processors will cause issues.
> > > > > +  To avoid this, the firmware checks the device tree configuration
> > > > > +  during boot. If it finds device tree nodes starting by csi then
> > > > > +  it will stop the firmware accessing the block, and it can then
> > > > > +  safely be used via the device tree binding.
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: brcm,bcm2835-unicam
> > > > > +
> > > > > +  reg:
> > > > > +    items:
> > > > > +      - description: Unicam block.
> > > > > +      - description: Clock Manager Image (CMI) block.
> > > > > +
> > > > > +  interrupts:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  clocks:
> > > > > +    items:
> > > > > +      - description: Clock to drive the LP state machine of Unicam.
> > > > > +      - description: Clock for the vpu (core clock).
> > > > > +
> > > > > +  clock-names:
> > > > > +    items:
> > > > > +      - const: lp
> > > > > +      - const: vpu
> > > > > +
> > > > > +  power-domains:
> > > > > +    items:
> > > > > +      - description: Unicam power domain
> > > > > +
> > > > > +  brcm,num-data-lanes:
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +    enum: [ 2, 4 ]
> > > > > +    description: Number of data lanes on the csi bus
> > > >
> > > > There is already data-lanes in
> > > > Documentation/devicetree/bindings/media/video- interfaces.yaml. AFAICS
> > > > these two are identical. Can't the video-
> > > > interface.yaml be used for this? I'm no expert TBH.
> > >
> > > This is the number of data lanes that the Unicam instance supports.
> > > There are two Unicam instances, and they can have 2 or 4 data lanes
> > > depending on the SoC. The data-lanes endpoint property indicates the
> > > number of lanes used on a particular board.
> >
> > Thanks for the explanation. Isn't this something which could be derived from
> > the compatible, e.g. having 2 different ones for 2 and 4 lanes respectively?
> > See [1] for a similar situation in the SPI subsystem.
> > I don't have a strong opinion, just want to share my feedback.
>
> Yes, it could also be done through compatible strings, but in this case
> I think a vendor-specific property is better. The number of lanes routed
> from the Unicam IP core to the external of the SoC depends on the exact
> SoC model, so we would need to create different compatible strings for
> essentially the same IP core.

Yes csi0 (only supporting 2 data lanes) and csi1 (supporting 4 lanes)
could have different compatibles. However lanes default to being
disabled, so there's no need to treat csi1 any differently to csi0 if
only using up to 2 lanes.

The issue is your second case as eg on Compute Module 4, all 4 data
lanes of csi1 on the BCM2711 are routed to the camera connector. On
the Pi4 which also uses BCM2711, only 2 data lanes of csi1 are routed
to the camera connector. It's the same SoC, so the same compatible
string would normally apply.
It's a board design decision over how many lanes to route, not a
difference in the silicon or IP core. With 3rd parties able to design
their own carrier boards for Compute Modules, there's no guarantee
that a Compute Module will always have 4 lanes routed either.

Take imx290 as a sensor driver which supports running on either 2 or 4
lanes based on DT. A user can take a dtoverlay to configure it for 4
lanes on a Pi4 and it can not work. If the driver can validate the
number of lanes requested then it can produce some form of error,
otherwise you get the support query.

If V4L2's CSI support did something similar to DRM's DSI support where
the API passed across the number of lanes to run with, then data-lanes
could be used for this validation (and lane reordering). However at
present we have to have the data-lanes property on all CSI2 devices in
a chain have to match.

This has been discussed previously [1], and I relented and dropped it
to only use data-lanes.
From a support side, having that validation avoids so many issues that
it will be in our vendor tree whether it is accepted to mainline or
not.

  Dave

[1] https://patchwork.linuxtv.org/project/linux-media/patch/888a28269a8a7c22feb2a126db699b1259d1b457.1497452006.git.dave.stevenson@raspberrypi.org/

> > [1] https://patchwork.kernel.org/project/spi-devel-general/patch/20211207104114.2720764-1-alexander.stein@ew.tq-group.com/#24641405
>
> --
> Regards,
>
> Laurent Pinchart
