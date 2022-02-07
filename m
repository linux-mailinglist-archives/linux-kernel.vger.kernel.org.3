Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301274AB82F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344674AbiBGJtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbiBGJoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:44:23 -0500
X-Greylist: delayed 3633 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 01:44:21 PST
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8400AC043181;
        Mon,  7 Feb 2022 01:44:21 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7CCA8240008;
        Mon,  7 Feb 2022 09:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644227059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6KUt7aT0vf3HkBvqg1m3IH1dZxNe1djrpK9xW+fnoQw=;
        b=NkrfXNXYCHbTieByp9pVKjdSsJHaXqLnlqhNJGbny2eQ/2CsZrUdW2mSW8BFideJw1mHR7
        15E1pOBLcS9Zp/1a1+f6oN2t/XT5OKikI5lpiYSLG2Zsg02H2FT2KS4iKkG/crYs0wRf/d
        LdAbBUGvjGFfl0ceKgyWRSvFGkoenC8W/DHCeWzBHaqNAWaq5hcmZziIcYMn2MBYgGQERM
        SJJqkl47m6fRQi+eSFynQYJiS+deVZKhB4CRpVfmFn9Iveedvri6/XWxuSJSUDSrowXNWy
        N2qKe3FTk9/WTFe/Qpb4KssN0vY9p4sxkx+Snv5XDpdBc1wcZwbKDvlk4nw8Nw==
Date:   Mon, 7 Feb 2022 10:44:16 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-staging@lists.linux.dev, Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 02/66] dt-bindings: interconnect: sunxi: Add V3s mbus
 compatible
Message-ID: <YgDp8HzmcS8Nkn0q@aptenodytes>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <5386b1f5-9e75-4ce3-6641-bd7667c85d42@sholland.org>
 <YgDbv8aQEOOjwTb0@aptenodytes>
 <8021451.T7Z3S40VBb@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="10LvNQVJYUIIwFrj"
Content-Disposition: inline
In-Reply-To: <8021451.T7Z3S40VBb@jernej-laptop>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--10LvNQVJYUIIwFrj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jernej,

On Mon 07 Feb 22, 09:50, Jernej =C5=A0krabec wrote:
> Hi Paul,
>=20
> Dne ponedeljek, 07. februar 2022 ob 09:43:43 CET je Paul Kocialkowski=20
> napisal(a):
> > Hi,
> >=20
> > On Sat 05 Feb 22, 14:14, Samuel Holland wrote:
> > > On 2/5/22 12:53 PM, Paul Kocialkowski wrote:
> > > > Since the V3s uses the internal mbus, document its compatible.
> > > >=20
> > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > ---
> > > >=20
> > > >  .../devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml  |=
 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >=20
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-m=
bus.
> > > > yaml
> > > > b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-m=
bus.
> > > > yaml index 29c9961ee2d8..b67bf9261a6a 100644
> > > > ---
> > > > a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-m=
bus.
> > > > yaml +++
> > > > b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-m=
bus.
> > > > yaml> >=20
> > > > @@ -31,6 +31,7 @@ properties:
> > > >        - allwinner,sun5i-a13-mbus
> > > >        - allwinner,sun8i-h3-mbus
> > > >        - allwinner,sun8i-r40-mbus
> > > >=20
> > > > +      - allwinner,sun8i-v3s-mbus
> > >=20
> > > Please enable the expanded binding added in commit 245578ba9f03
> > > ("dt-bindings: arm: sunxi: Expand MBUS binding")[1] by adding the new
> > > compatible to the "if" block lower in the file. That way we can add V=
3S
> > > devfreq support in the future without changing that binding.
> >=20
> > I had missed that new driver but surely I will expand the updated bindi=
ng.
> >=20
> > By the way do you have an explanation about the cell index given to the
> > interconnects (after &mbus)?
>=20
> This is mbus channel. You can find appropriate one checking DRAM driver i=
n U-
> Boot, where mbus is configured.

Thanks, that's exactly what I was looking for! Looks like in my case
MBUS_PORT_CSI will be used both for CSI and ISP.

For the record it's also defined in the BSP kernel at:
include/linux/sunxi_mbus.h

Thanks,

Paul

> Best regards,
> Jernej
>=20
> >=20
> > Paul
> >=20
> > > Regards,
> > > Samuel
> > >=20
> > > [1]: https://git.kernel.org/torvalds/c/245578ba9f03
> > >=20
> > > >        - allwinner,sun50i-a64-mbus
> > > >   =20
> > > >    reg:
>=20
>=20
>=20
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--10LvNQVJYUIIwFrj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmIA6fAACgkQ3cLmz3+f
v9Fywwf/eKwq4XMLDo180gX6Pm1kgA2v/uxUB0R0xsoXaELb6IluwiuPO0jVvNCN
rYT26DH13eSTfZtHD9UlCMb7J1PO4lGT+FeVURUWx7tnX8m5r2H0H66VqyAdlPUT
mOunobehDH81Sl2Pj7FDVa1jyA8Bg/CZwnCxKi7cwLyg4EvFxQCYG3AxKb30UZya
WcQcmj84SGHps/X1XdbS1vnllGv9e9mE9FvaVdi+WZ4iUzcQOwCXpMsYiWoc0YdV
LhUCUeGeAqr9STaTz7ZDCPBMUjNtnONtTiDcyDIMcAIWshytEl2S2sKkpy4o8c8V
caHW8IBvVlyHHv9YjOnNRf5ysP3T7g==
=vjaa
-----END PGP SIGNATURE-----

--10LvNQVJYUIIwFrj--
