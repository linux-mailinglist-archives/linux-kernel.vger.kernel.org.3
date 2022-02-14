Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860924B5627
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356343AbiBNQ3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:29:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbiBNQ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:29:03 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29731C73;
        Mon, 14 Feb 2022 08:28:54 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 533571BF20A;
        Mon, 14 Feb 2022 16:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644856132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5duxPRqWDu+1JL3oVHLVTFQSMMgYnhs6Kqh7x0Swsnk=;
        b=X6pwmukcd11Mw7rgTo4OKu1ESaDmEN4fj2oNd+qz1feH91E4jnTQThvEWarS0aIXZMPeU9
        B8h/kZlDoJCIF0L8SQfDVo+xwYIjNME3aCAk9cupji/XDzP1v2sbT0J7CCDs8MnMxUrzbW
        TW3U5YQ/CVYu7bOGu9ljX4/4ZLxe657soWOXimNA5YbYUNc5pqIArVn4hYeadDhkWxNsZw
        KiCfZHdZTjAYQSHtD810UfmclTdztaMEGGbUbNQB0YNNXpF6Y9RiYRYJdW8DDRf+Mnda+Q
        kX2bqtcKOnclqVKjQlfBa1Vgq2LONfL5khac3De3DmV53nd/cLvINt5oSJgicw==
Date:   Mon, 14 Feb 2022 17:28:50 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Rob Herring <robh@kernel.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-staging@lists.linux.dev, Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 61/66] dt-bindings: media: Add Allwinner A31 ISP
 bindings documentation
Message-ID: <YgqDQs/GJVxZMB+C@aptenodytes>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-62-paul.kocialkowski@bootlin.com>
 <YgE/+UmP4nJVxtRT@pendragon.ideasonboard.com>
 <YgZ9GjgasiPljg9X@robh.at.kernel.org>
 <YgbMmLht/AXb5R1y@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yzLvnjd3wstFCaVx"
Content-Disposition: inline
In-Reply-To: <YgbMmLht/AXb5R1y@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yzLvnjd3wstFCaVx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri 11 Feb 22, 22:52, Laurent Pinchart wrote:
> Hi Rob,
>=20
> On Fri, Feb 11, 2022 at 09:13:30AM -0600, Rob Herring wrote:
> > On Mon, Feb 07, 2022 at 05:51:21PM +0200, Laurent Pinchart wrote:
> > > On Sat, Feb 05, 2022 at 07:54:24PM +0100, Paul Kocialkowski wrote:
> > > > This introduces YAML bindings documentation for the Allwinner A31 I=
mage
> > > > Signal Processor (ISP).
> > > >=20
> > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > ---
> > > >  .../media/allwinner,sun6i-a31-isp.yaml        | 117 ++++++++++++++=
++++
> > > >  1 file changed, 117 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/media/allwinn=
er,sun6i-a31-isp.yaml
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6=
i-a31-isp.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a3=
1-isp.yaml
> > > > new file mode 100644
> > > > index 000000000000..2d87022c43ce
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-i=
sp.yaml
> > > > @@ -0,0 +1,117 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/media/allwinner,sun6i-a31-isp.y=
aml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Allwinner A31 Image Signal Processor Driver (ISP) Device Tr=
ee Bindings
> > > > +
> > > > +maintainers:
> > > > +  - Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - allwinner,sun6i-a31-isp
> > > > +      - allwinner,sun8i-v3s-isp
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 1
> > > > +
> > > > +  clocks:
> > > > +    items:
> > > > +      - description: Bus Clock
> > > > +      - description: Module Clock
> > > > +      - description: DRAM Clock
> > >=20
> > > That's interesting, does the ISP have a dedicated DRAM ?
> > >=20
> > > > +
> > > > +  clock-names:
> > > > +    items:
> > > > +      - const: bus
> > > > +      - const: mod
> > > > +      - const: ram
> > > > +
> > > > +  resets:
> > > > +    maxItems: 1
> > > > +
> > > > +  ports:
> > > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > > +
> > > > +    properties:
> > > > +      port@0:
> > > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > > +        description: CSI0 input port
> > > > +
> > > > +        properties:
> > > > +          reg:
> > > > +            const: 0
> > > > +
> > > > +          endpoint:
> > > > +            $ref: video-interfaces.yaml#
> > > > +            unevaluatedProperties: false
> > >=20
> > > If no other property than remote-endpoint are allowed, I'd write
> > >=20
> > >           endpoint:
> > >             $ref: video-interfaces.yaml#
> > > 	    remote-endpoint: true
> >=20
> > You just mixed a node and a property...
>=20
> Yes, I meant
>=20
>            endpoint:
>              $ref: video-interfaces.yaml#
>              properties:
>                remote-endpoint: true
>=20
> and actually add
>=20
>              additionalProperties: false
>=20
> > 'remote-endpoint' is always allowed, so need to put it here and every=
=20
> > other user. So 'unevaluatedProperties' is correct. But it would be good=
=20
> > to define what properties from video-interfaces.yaml are used here.
>=20
> I've been looking at this recently. The usual pattern is to write
>=20
>     endpoint:
>       $ref: video-interfaces.yaml#
>       unevaluatedProperties: false
>       properties:
>         hsync-polarity: true
>         vsync-polarity: true
>=20
> to express that the hsync-polarity and vsync-polarity properties are
> used. However, this will still validate fine if, for instance,
> data-lanes was specified in the device tree. Shouldn't we use
> additionalProperties instead of unevaluatedProperties here ? If so,
> specifying remote-endpoint: true seems needed.

My understanding is that unevaluatedProperties well allow all properties
defined in the included video-interfaces.yaml ref but reject others
while additionalProperties will reject any unspecified local property,
even if it is declared in the ref.

In any case with the ISP maybe we don't even want to take the ref from
video-interfaces.yaml since we are dealing with an internal fifo between
two devices. Maybe it would be more appropriate to ref
/schemas/graph.yaml#/$defs/endpoint-base, which already defines
remote-endpoint too.

What do you think?

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--yzLvnjd3wstFCaVx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmIKg0EACgkQ3cLmz3+f
v9Fg/ggAoquw4gO5eekW7dxNLQONv8zyL3sxR/AwEuZlLOhjPUHeJzQwg5NupSx8
AqsMfFQA68MxH3nsQNRZkCFLXTIzmrK/xZRRX7OFD8cLQjKjMJmbz6gpm32UHBJr
un2rlNt0N8+iY9xKne3vQFPscOhnVFk/i5bdYj65jCfOiZF+jvnUwYtFcgoeQrv7
r4Hu6A2hlK9O8t+kG9oJ0MSU9ZdYTeXuLTg9W1QtSkt2bSxVauV0JxRKO7Wo67D6
LqwIEBtpEikyWIMARqoR3BcroJvCPNK96AmyZ9eKkTmpC+NI8pOLJyxwdRhqPN1o
njaQSFJo2B9w/O690dh0GMhf5B2I3Q==
=B7GD
-----END PGP SIGNATURE-----

--yzLvnjd3wstFCaVx--
