Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44454BDBDC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355330AbiBUKms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:42:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355589AbiBUKlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:41:09 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075384D624;
        Mon, 21 Feb 2022 02:03:14 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id E57DB58025E;
        Mon, 21 Feb 2022 05:03:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 21 Feb 2022 05:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=MewriESTXRMbblpSYnQ8yYADa3NnoEjRQEC2H3
        lKSUI=; b=Mt768FWMLUOeF8jeTm7nkj7ASdVW7s67U6Im0Wy00c2rytVEY+2t8W
        plTGafbs/POLzovhcntJtXs25qHVz/XcFfimvNGPiD84N33FRLEHQnXPHu8y9RM/
        62unKA84+3IGrcJEgQR7urG8gi8N6Btu/vc8WtRwCIB5JG3XuZKjVkLQcaXk4sId
        u2RPC3YU/KWIkMuJygRm6ogYbDUo6qXqVkzxgB6VYUC8ZfOlBZz0f4wQ06Dplrhr
        7l/pyobImZL6lWzDe/CbdcPjGrIl77Tft0nS4Szn6M62y081r+L15ny6+G2R/LEN
        KpmKYGGVHxHW+x0KfWi2kfOXntvVShFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=MewriESTXRMbblpSY
        nQ8yYADa3NnoEjRQEC2H3lKSUI=; b=PWnPDsKkAXzzlVLbReqFM4ev0+D84Wmj8
        UXO8s4hvhDp2973lI485LLrFleqMu5Z2xSEMtWpepGxvtUDkC5NYDYKzEvAA2R1u
        +IDGx4LP70DhXKLJZRrhVPFKCHXq+U0oJmA/zEQDePTOtoT4M4lCXDSu54Bp47C/
        JA4gRxORqlB66YrgQRNOhVr4Jvl9XxgvDHoK98Lp9e3S2QIfJvBCG+uRyNBIpulU
        64c/a4Fq9zRPOXrTNEJdKLYcadHfD5pyWYMO35o771FiIaLYYzbsAsQIyz6Zh007
        UqcSl5oSzox4tIE1TJFkI5Kw17EIRC/wRewu3LeKwkuD9lrc+b73A==
X-ME-Sender: <xms:X2MTYvc9vVjKn80UQsy7USVcWpMf3QaFKgRQGxIh6pUP7DB15cmcAQ>
    <xme:X2MTYlNo6Wdazc_lM4SSTMuwXmOQqattlLu8VDPymELmuGE5HeawXUvyGuIHN4UNU
    p9eYBAa-tOUhpspKS0>
X-ME-Received: <xmr:X2MTYohVABDQ07AHDI5_6ZDv267i9MnVq-X84H77mRfZ0QPCroS6HeZ_vUduOXFiFnV_d7sLhT4VfDZs6QBd5qOq-v9apDqj-0jScjU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeeigddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeffteetveeijeetuefhffegkeetgffhieelheehtdduudethffhjedtvddtudel
    vdenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordht
    vggthh
X-ME-Proxy: <xmx:X2MTYg8HQCsmowzoLQPVSDV6SuRwknGP0H8muXZFOLqUOvNzp1ysiw>
    <xmx:X2MTYrs_srCsXTTK-5X6pOTDSJSZmNrU-N30D0cnI1NLEbIVOMv_fA>
    <xmx:X2MTYvHAccxpkx-tn53rooXHlxc_HLLMyY9o8R0-reF8hsM0whxRuQ>
    <xmx:X2MTYjN0PEgIm1hOlGQtl1p4RqDvuy9Fp_NwTItBPx4KcmFC3GRsTA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 05:03:10 -0500 (EST)
Date:   Mon, 21 Feb 2022 11:03:09 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
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
Message-ID: <20220221100309.ytcy6bxijwztyhsd@houat>
References: <20220208155027.891055-1-jeanmichel.hautbois@ideasonboard.com>
 <20220208155027.891055-4-jeanmichel.hautbois@ideasonboard.com>
 <f58bf6a9-c63f-19ab-36c8-a9a7b9182859@i2se.com>
 <20220214093954.5y4jbqcddmwhgxr5@houat>
 <YgomyazKaV2QnfYQ@pendragon.ideasonboard.com>
 <7ba0d8e7-72b9-d139-f29f-45a803ca2fdb@i2se.com>
 <YhM6474MwSh6bjUe@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hgycafmcvwvkmfnm"
Content-Disposition: inline
In-Reply-To: <YhM6474MwSh6bjUe@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hgycafmcvwvkmfnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 21, 2022 at 09:10:27AM +0200, Laurent Pinchart wrote:
> Hi Stefan,
>=20
> On Mon, Feb 14, 2022 at 12:32:59PM +0100, Stefan Wahren wrote:
> > Am 14.02.22 um 10:54 schrieb Laurent Pinchart:
> > > On Mon, Feb 14, 2022 at 10:39:54AM +0100, Maxime Ripard wrote:
> > >> On Sun, Feb 13, 2022 at 04:48:45PM +0100, Stefan Wahren wrote:
> > >>> as someone with a little more insight to the clocks, i like to know=
 your
> > >>> opinion about the bcm2835-unicam binding.
> > >>>
> > >>> Am 08.02.22 um 16:50 schrieb Jean-Michel Hautbois:
> > >>>> Introduce the dt-bindings documentation for bcm2835 CCP2/CSI2 Unic=
am
> > >>>> camera interface.
> > >>>>
> > >>>> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > >>>> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> > >>>> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonbo=
ard.com>
> > >>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > >>>>
> > >>>> ---
> > >>>> v4:
> > >>>> - make MAINTAINERS its own patch
> > >>>> - describe the reg and clocks correctly
> > >>>> - use a vendor entry for the number of data lanes
> > >>>> ---
> > >>>>  .../bindings/media/brcm,bcm2835-unicam.yaml   | 117 +++++++++++++=
+++++
> > >>>>  1 file changed, 117 insertions(+)
> > >>>>  create mode 100644 Documentation/devicetree/bindings/media/brcm,b=
cm2835-unicam.yaml
> > >>>>
> > >>>> diff --git a/Documentation/devicetree/bindings/media/brcm,bcm2835-=
unicam.yaml b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.y=
aml
> > >>>> new file mode 100644
> > >>>> index 000000000000..1938ace23b3d
> > >>>> --- /dev/null
> > >>>> +++ b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.=
yaml
> > >>>> @@ -0,0 +1,117 @@
> > >>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > >>>> +%YAML 1.2
> > >>>> +---
> > >>>> +$id: http://devicetree.org/schemas/media/brcm,bcm2835-unicam.yaml#
> > >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >>>> +
> > >>>> +title: Broadcom BCM283x Camera Interface (Unicam)
> > >>>> +
> > >>>> +maintainers:
> > >>>> +  - Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> > >>>> +
> > >>>> +description: |-
> > >>>> +  The Unicam block on BCM283x SoCs is the receiver for either
> > >>>> +  CSI-2 or CCP2 data from image sensors or similar devices.
> > >>>> +
> > >>>> +  The main platform using this SoC is the Raspberry Pi family of =
boards.  On
> > >>>> +  the Pi the VideoCore firmware can also control this hardware bl=
ock, and
> > >>>> +  driving it from two different processors will cause issues.  To=
 avoid this,
> > >>>> +  the firmware checks the device tree configuration during boot. =
If it finds
> > >>>> +  device tree nodes whose name starts with 'csi' then it will sto=
p the firmware
> > >>>> +  accessing the block, and it can then safely be used via the dev=
ice tree
> > >>>> +  binding.
> > >>>> +
> > >>>> +properties:
> > >>>> +  compatible:
> > >>>> +    const: brcm,bcm2835-unicam
> > >>>> +
> > >>>> +  reg:
> > >>>> +    items:
> > >>>> +      - description: Unicam block.
> > >>>> +      - description: Clock Manager Image (CMI) block.
> > >>>> +
> > >>>> +  reg-names:
> > >>>> +    items:
> > >>>> +      - const: unicam
> > >>>> +      - const: cmi
> > >>>> +
> > >>>> +  interrupts:
> > >>>> +    maxItems: 1
> > >>>> +
> > >>>> +  clocks:
> > >>>> +    items:
> > >>>> +      - description: Clock to drive the LP state machine of Unica=
m.
> > >>>> +      - description: Clock for the VPU (core clock).
> > >>>> +
> > >>>> +  clock-names:
> > >>>> +    items:
> > >>>> +      - const: lp
> > >>>> +      - const: vpu
> > >>>> +
> > >>>
> > >>> according to this patch [1], the unicam driver only needs the VPU c=
lock
> > >>> reference just to enforce a minimum of 250 MHz. The firmware clock
> > >>> binding and its driver is specific to the bcm2711, but the Unicam IP
> > >>> exists since bcm2835.
> > >>>
> > >>> So do you think the clock part is correct or should be the VPU clock
> > >>> optional?
> > >>
> > >> I think we should keep it mandatory. Indeed, that clock is shared wi=
th
> > >> the HVS that will change its rate on a regular basis, so even just
> > >> enforcing that 250MHz while it's on without a clock handle will be
> > >> fairly hard.
> > >>
> > >> Also, those are the constraints we have now, but having the clock ha=
ndle
> > >> all the time will allow us to add any constraint we might need in the
> > >> future.
> > >>
> > >> And BCM2711 or not, the clock has probably always been there.
> > >
> > > Furthermore, regardless of what the driver needs, Unicam operates with
> > > the VPU clock, so I think it makes sense to reference it in the device
> > > tree.
> >=20
> > okay, as a result we need a DTS patch for bcm2835-rpi.dtsi to enable the
> > firmware clocks and its driver in this series.
>=20
> Can't we do that on top, enabling Unicam support for bcm2711 only first
> ? I have no idea how to deal with firmware clocks on bcm2825, and I'm
> not sure Jean-Michel even has a hardware platform to test it.

The RPi kernel uses the firmware clocks driver for all the platforms, so
it shouldn't be too bad.

Maxime

--hgycafmcvwvkmfnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYhNjXQAKCRDj7w1vZxhR
xXONAQCmnUupgwvTeLp0tAkmJV3ctRhLRSUsMMeJCaHqExxavAEAlN3LD5YUbQlJ
ZP3zjKZ/YFbcFLVUD8Dzpvqr5E0xaAg=
=C2uD
-----END PGP SIGNATURE-----

--hgycafmcvwvkmfnm--
