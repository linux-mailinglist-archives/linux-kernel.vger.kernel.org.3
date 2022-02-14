Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBE84B47C4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343706AbiBNJvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:51:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343946AbiBNJqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:46:34 -0500
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41326AA50;
        Mon, 14 Feb 2022 01:40:02 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id E0EA0580326;
        Mon, 14 Feb 2022 04:39:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 14 Feb 2022 04:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=iHF86gLKmAluuysLaqRwDFdrk2bHcBeKvHF9zA
        JIyNA=; b=RUWHHO/NmTqhAwBVdYo46ixTK5JvdKZWLpjvecKXto9RqQAcPyEMQ7
        V3RLschKh/hXHNjNyZ0fiB7G2y5vF53weh0QH5UruYDKWHEntIa6EcXiOt476UlU
        Frxno+uB5po8sOzwmpfAcj5PSTSHHpOYQANxeb3hqGZxGLGSXsPI28WLZ4ltV4bd
        eWTzHFxTz8ucN4uX0h3tqBmB/tLFPhCndDnfACGEpK8xyF04GXLqi17yrj6zZNwm
        8FZmHjJQpxuCcvb4mvQlauKvOYPFRz8cROVpZJBJOvya42Tr1FFxv8S+K9OrxEC1
        BsUcyvuWrXCa6KX4v0ugss8zBaM09zJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=iHF86gLKmAluuysLa
        qRwDFdrk2bHcBeKvHF9zAJIyNA=; b=aFMt948QmSvUPAdtyGWCeYg6Ry6qOX0hE
        vUJl25fPcAxGK0VSl6tXoPHcwghygc6HqUp/QRILkcp/cA3yWix/58mtQesCSctm
        mg2inYfw1u+usxw3DalLMzMLeGfp4+t96xDVUtJ4HuCPMY1POxTd3YBeGNHD46O8
        cOl34JU72UE1IyuLW+YHKWAFeOT0VJ7sCWhoTNC62JjMK4m6GdZhuRyjfj+Ep0lR
        AUJ2vI9cUzCal5openPILj0B7JiRIyCE3POpF2huEsb9RQ3BnadQYUoqX8N+olgy
        9Wrl4nofmScFoxEsS+z4xOhOr6K2LS+1ibJIZGQf5qoV763r0fZJw==
X-ME-Sender: <xms:byMKYro-1KV4wWPNwN1Kd0FiSUI96cg9qHsSpZMEDkyStbUfBwqHJQ>
    <xme:byMKYlrtJ7OK-k99vSNXuFz130ARkI_DiuwkD_oHWG03kxi3d_y0PsjEValvaGZZE
    NB_3u3hdesW6FH2lDM>
X-ME-Received: <xmr:byMKYoNDl_kWO7eoMo4LIE5cwDih4peaBLEjHmHhU9sWDHdz5Fgd4rHwuDF9mWEJq5LVsJzJkrd1kZm9SeCga_dGdNQY6prPd70shHU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjedvgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeffteetveeijeetuefhffegkeetgffhieelheehtdduudethffhjedtvddtudel
    vdenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordht
    vggthh
X-ME-Proxy: <xmx:byMKYu7ctkc0ayv_YQfuSM2M5hsLOeWyde_8b5B0F4nxr3MJqoyrww>
    <xmx:byMKYq6pBR9pYtZw8WdIS22uuoGhIGsQS1Utk_Toy43sYJYdLcto7w>
    <xmx:byMKYmgvKh2U-uetw1UIlzKfvHFZzEOvsD9BKP27WLiGFqhxHGuwmQ>
    <xmx:byMKYtp695JEX8gTxitJ-dP7Aw-S0-nURVzLxiuaH3DyzdKs4yTxcg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Feb 2022 04:39:58 -0500 (EST)
Date:   Mon, 14 Feb 2022 10:39:54 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v5 03/11] dt-bindings: media: Add bindings for
 bcm2835-unicam
Message-ID: <20220214093954.5y4jbqcddmwhgxr5@houat>
References: <20220208155027.891055-1-jeanmichel.hautbois@ideasonboard.com>
 <20220208155027.891055-4-jeanmichel.hautbois@ideasonboard.com>
 <f58bf6a9-c63f-19ab-36c8-a9a7b9182859@i2se.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t3f56jmwvuijnmiw"
Content-Disposition: inline
In-Reply-To: <f58bf6a9-c63f-19ab-36c8-a9a7b9182859@i2se.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t3f56jmwvuijnmiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 13, 2022 at 04:48:45PM +0100, Stefan Wahren wrote:
> as someone with a little more insight to the clocks, i like to know your
> opinion about the bcm2835-unicam binding.
>=20
> Am 08.02.22 um 16:50 schrieb Jean-Michel Hautbois:
> > Introduce the dt-bindings documentation for bcm2835 CCP2/CSI2 Unicam
> > camera interface.
> >
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> > Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.c=
om>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >
> > ---
> > v4:
> > - make MAINTAINERS its own patch
> > - describe the reg and clocks correctly
> > - use a vendor entry for the number of data lanes
> > ---
> >  .../bindings/media/brcm,bcm2835-unicam.yaml   | 117 ++++++++++++++++++
> >  1 file changed, 117 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/brcm,bcm283=
5-unicam.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/media/brcm,bcm2835-unica=
m.yaml b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> > new file mode 100644
> > index 000000000000..1938ace23b3d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> > @@ -0,0 +1,117 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/brcm,bcm2835-unicam.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Broadcom BCM283x Camera Interface (Unicam)
> > +
> > +maintainers:
> > +  - Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> > +
> > +description: |-
> > +  The Unicam block on BCM283x SoCs is the receiver for either
> > +  CSI-2 or CCP2 data from image sensors or similar devices.
> > +
> > +  The main platform using this SoC is the Raspberry Pi family of board=
s.  On
> > +  the Pi the VideoCore firmware can also control this hardware block, =
and
> > +  driving it from two different processors will cause issues.  To avoi=
d this,
> > +  the firmware checks the device tree configuration during boot. If it=
 finds
> > +  device tree nodes whose name starts with 'csi' then it will stop the=
 firmware
> > +  accessing the block, and it can then safely be used via the device t=
ree
> > +  binding.
> > +
> > +properties:
> > +  compatible:
> > +    const: brcm,bcm2835-unicam
> > +
> > +  reg:
> > +    items:
> > +      - description: Unicam block.
> > +      - description: Clock Manager Image (CMI) block.
> > +
> > +  reg-names:
> > +    items:
> > +      - const: unicam
> > +      - const: cmi
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Clock to drive the LP state machine of Unicam.
> > +      - description: Clock for the VPU (core clock).
> > +
> > +  clock-names:
> > +    items:
> > +      - const: lp
> > +      - const: vpu
> > +
>=20
> according to this patch [1], the unicam driver only needs the VPU clock
> reference just to enforce a minimum of 250 MHz. The firmware clock
> binding and its driver is specific to the bcm2711, but the Unicam IP
> exists since bcm2835.
>=20
> So do you think the clock part is correct or should be the VPU clock
> optional?

I think we should keep it mandatory. Indeed, that clock is shared with
the HVS that will change its rate on a regular basis, so even just
enforcing that 250MHz while it's on without a clock handle will be
fairly hard.

Also, those are the constraints we have now, but having the clock handle
all the time will allow us to add any constraint we might need in the
future.

And BCM2711 or not, the clock has probably always been there.

Maxime

--t3f56jmwvuijnmiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgojagAKCRDj7w1vZxhR
xRwhAP4nTOU8IjZGJK9OngHxyKECh2qYDcYc37EHQpvvUHsodQD/eDaW99MTlwsB
G1jvqQ86KEqFJZSiz5OxGOzUBgGtSg4=
=jJIB
-----END PGP SIGNATURE-----

--t3f56jmwvuijnmiw--
