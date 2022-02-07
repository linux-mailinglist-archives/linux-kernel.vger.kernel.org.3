Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71FF4AB6D1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346670AbiBGIpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243028AbiBGInx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:43:53 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CA1C043181;
        Mon,  7 Feb 2022 00:43:50 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7BAC8E000C;
        Mon,  7 Feb 2022 08:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644223426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aqtEkkE4CxAPCqiyjvQlRqA4fyM6M/H+WbMg+4em3bk=;
        b=b/8uLavJfT0Pt7E5NoIji6JTEqyrnFW8AjRy2crSYjYa2+QxdwCGQc+rmkX8TpLU5/QH2B
        uXn/ZDuogrQ6mrqVH7TXf8npZfUUAvpaAkd7mavWrTl8CLvuYVYlLmJiQLtaw8z3KSzzHh
        0dClE6y7UCGqM1NJDXiyE8WDFc/dV6WZNEG7TJBNCL4fJmBdtmMsgNJEB/BHqTf5ryGxfR
        3y7pKlclTbaRTjTWl94cEd38+jWj3JUtyi6B+JFfjXc/S9vXarXeekHfSn1K95ltQdwScI
        KtNMhUPRgqM/sKC1j20xCDvOlzNXAmuXMF4bCE3bSsX+SdJGU3T7pWgvuBjZfA==
Date:   Mon, 7 Feb 2022 09:43:43 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 02/66] dt-bindings: interconnect: sunxi: Add V3s mbus
 compatible
Message-ID: <YgDbv8aQEOOjwTb0@aptenodytes>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-3-paul.kocialkowski@bootlin.com>
 <5386b1f5-9e75-4ce3-6641-bd7667c85d42@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="siWsic/QuhUMqNlN"
Content-Disposition: inline
In-Reply-To: <5386b1f5-9e75-4ce3-6641-bd7667c85d42@sholland.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--siWsic/QuhUMqNlN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat 05 Feb 22, 14:14, Samuel Holland wrote:
> On 2/5/22 12:53 PM, Paul Kocialkowski wrote:
> > Since the V3s uses the internal mbus, document its compatible.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  .../devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml  | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4=
i-a10-mbus.yaml b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun=
4i-a10-mbus.yaml
> > index 29c9961ee2d8..b67bf9261a6a 100644
> > --- a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-m=
bus.yaml
> > +++ b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-m=
bus.yaml
> > @@ -31,6 +31,7 @@ properties:
> >        - allwinner,sun5i-a13-mbus
> >        - allwinner,sun8i-h3-mbus
> >        - allwinner,sun8i-r40-mbus
> > +      - allwinner,sun8i-v3s-mbus
>=20
> Please enable the expanded binding added in commit 245578ba9f03 ("dt-bind=
ings:
> arm: sunxi: Expand MBUS binding")[1] by adding the new compatible to the =
"if"
> block lower in the file. That way we can add V3S devfreq support in the f=
uture
> without changing that binding.

I had missed that new driver but surely I will expand the updated binding.

By the way do you have an explanation about the cell index given to the
interconnects (after &mbus)?

Paul

> Regards,
> Samuel
>=20
> [1]: https://git.kernel.org/torvalds/c/245578ba9f03
>=20
> >        - allwinner,sun50i-a64-mbus
> > =20
> >    reg:
> >=20
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--siWsic/QuhUMqNlN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmIA274ACgkQ3cLmz3+f
v9Hedwf/dd7O5weguOH+OM1fWPM+D01os8bCMg2BVi/eJAzHIsTRwpzNVnuC5GkL
jEPrckhWzLYI9QVdh9sxYGDe3WtMpG5L0mXxvfM0AruEZ8OA9Up1eZ/4a/pXtjmp
ge2AkXEcmDd2BbtlMHe8obvpO9se0uDYHjA1MgApK8F5fVwRNn2dmu1zE5dAhufc
GF3GDEPpS7MLe7ReDnGd9wAt109SEIxDgJ9XeiC1XdumNE5BAnT49+7Qq2Wy4zjf
HDyDxIoHke+4+66Gf03JpeGikvOIW/8C/rwwh8AWLopLrcNVzyh1AM4BVI83Yaf2
DMLRURk+Ae/bMrUUReDsYsgpsKZ42w==
=B81B
-----END PGP SIGNATURE-----

--siWsic/QuhUMqNlN--
