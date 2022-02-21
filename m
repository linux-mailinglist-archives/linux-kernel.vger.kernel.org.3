Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53D24BD6DA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345870AbiBUHLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:11:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiBUHLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:11:01 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628F7B69;
        Sun, 20 Feb 2022 23:10:38 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F3F61482;
        Mon, 21 Feb 2022 08:10:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1645427436;
        bh=ONkMNAtvkUZ/S9CvG5U6EYMEXS9davh/7VFRa++aVkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iR1a55EP0fLRLdw+GbzSj2vGdFw1C2jT7Pvn3UK3+27d2W0XVzORX9EM5I/rchGsH
         uWAG1HMIvSAXXziZ55yrtShw7MBIjqfrSdXcDZk0vqLCLh7ytsu3ki6DX7WQ8Xzk2g
         9ZIEqK8VtuDKlklH4tzd0zLjuN/R0Ko6ZwkXc6lU=
Date:   Mon, 21 Feb 2022 09:10:27 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        mchehab@kernel.org, naush@raspberrypi.com, robh@kernel.org,
        tomi.valkeinen@ideasonboard.com,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v5 03/11] dt-bindings: media: Add bindings for
 bcm2835-unicam
Message-ID: <YhM6474MwSh6bjUe@pendragon.ideasonboard.com>
References: <20220208155027.891055-1-jeanmichel.hautbois@ideasonboard.com>
 <20220208155027.891055-4-jeanmichel.hautbois@ideasonboard.com>
 <f58bf6a9-c63f-19ab-36c8-a9a7b9182859@i2se.com>
 <20220214093954.5y4jbqcddmwhgxr5@houat>
 <YgomyazKaV2QnfYQ@pendragon.ideasonboard.com>
 <7ba0d8e7-72b9-d139-f29f-45a803ca2fdb@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ba0d8e7-72b9-d139-f29f-45a803ca2fdb@i2se.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Mon, Feb 14, 2022 at 12:32:59PM +0100, Stefan Wahren wrote:
> Am 14.02.22 um 10:54 schrieb Laurent Pinchart:
> > On Mon, Feb 14, 2022 at 10:39:54AM +0100, Maxime Ripard wrote:
> >> On Sun, Feb 13, 2022 at 04:48:45PM +0100, Stefan Wahren wrote:
> >>> as someone with a little more insight to the clocks, i like to know your
> >>> opinion about the bcm2835-unicam binding.
> >>>
> >>> Am 08.02.22 um 16:50 schrieb Jean-Michel Hautbois:
> >>>> Introduce the dt-bindings documentation for bcm2835 CCP2/CSI2 Unicam
> >>>> camera interface.
> >>>>
> >>>> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> >>>> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> >>>> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> >>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>>>
> >>>> ---
> >>>> v4:
> >>>> - make MAINTAINERS its own patch
> >>>> - describe the reg and clocks correctly
> >>>> - use a vendor entry for the number of data lanes
> >>>> ---
> >>>>  .../bindings/media/brcm,bcm2835-unicam.yaml   | 117 ++++++++++++++++++
> >>>>  1 file changed, 117 insertions(+)
> >>>>  create mode 100644 Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> >>>> new file mode 100644
> >>>> index 000000000000..1938ace23b3d
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> >>>> @@ -0,0 +1,117 @@
> >>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>> +%YAML 1.2
> >>>> +---
> >>>> +$id: http://devicetree.org/schemas/media/brcm,bcm2835-unicam.yaml#
> >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>> +
> >>>> +title: Broadcom BCM283x Camera Interface (Unicam)
> >>>> +
> >>>> +maintainers:
> >>>> +  - Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> >>>> +
> >>>> +description: |-
> >>>> +  The Unicam block on BCM283x SoCs is the receiver for either
> >>>> +  CSI-2 or CCP2 data from image sensors or similar devices.
> >>>> +
> >>>> +  The main platform using this SoC is the Raspberry Pi family of boards.  On
> >>>> +  the Pi the VideoCore firmware can also control this hardware block, and
> >>>> +  driving it from two different processors will cause issues.  To avoid this,
> >>>> +  the firmware checks the device tree configuration during boot. If it finds
> >>>> +  device tree nodes whose name starts with 'csi' then it will stop the firmware
> >>>> +  accessing the block, and it can then safely be used via the device tree
> >>>> +  binding.
> >>>> +
> >>>> +properties:
> >>>> +  compatible:
> >>>> +    const: brcm,bcm2835-unicam
> >>>> +
> >>>> +  reg:
> >>>> +    items:
> >>>> +      - description: Unicam block.
> >>>> +      - description: Clock Manager Image (CMI) block.
> >>>> +
> >>>> +  reg-names:
> >>>> +    items:
> >>>> +      - const: unicam
> >>>> +      - const: cmi
> >>>> +
> >>>> +  interrupts:
> >>>> +    maxItems: 1
> >>>> +
> >>>> +  clocks:
> >>>> +    items:
> >>>> +      - description: Clock to drive the LP state machine of Unicam.
> >>>> +      - description: Clock for the VPU (core clock).
> >>>> +
> >>>> +  clock-names:
> >>>> +    items:
> >>>> +      - const: lp
> >>>> +      - const: vpu
> >>>> +
> >>>
> >>> according to this patch [1], the unicam driver only needs the VPU clock
> >>> reference just to enforce a minimum of 250 MHz. The firmware clock
> >>> binding and its driver is specific to the bcm2711, but the Unicam IP
> >>> exists since bcm2835.
> >>>
> >>> So do you think the clock part is correct or should be the VPU clock
> >>> optional?
> >>
> >> I think we should keep it mandatory. Indeed, that clock is shared with
> >> the HVS that will change its rate on a regular basis, so even just
> >> enforcing that 250MHz while it's on without a clock handle will be
> >> fairly hard.
> >>
> >> Also, those are the constraints we have now, but having the clock handle
> >> all the time will allow us to add any constraint we might need in the
> >> future.
> >>
> >> And BCM2711 or not, the clock has probably always been there.
> >
> > Furthermore, regardless of what the driver needs, Unicam operates with
> > the VPU clock, so I think it makes sense to reference it in the device
> > tree.
> 
> okay, as a result we need a DTS patch for bcm2835-rpi.dtsi to enable the
> firmware clocks and its driver in this series.

Can't we do that on top, enabling Unicam support for bcm2711 only first
? I have no idea how to deal with firmware clocks on bcm2825, and I'm
not sure Jean-Michel even has a hardware platform to test it.

If you want to send a patch series to enable firmware clocks on bcm2835,
we'll be happy to rebase on top.

-- 
Regards,

Laurent Pinchart
