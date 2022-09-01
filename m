Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A105A99B1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbiIAOFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiIAOEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:04:52 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913EBDF6;
        Thu,  1 Sep 2022 07:04:47 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 52F5BE0002;
        Thu,  1 Sep 2022 14:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662041084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lw/b6gMufWECAX3seoCAwz85Lfff7SY9MngeM/poOiQ=;
        b=pVXCmuvw0nSzp9uwaVdKCDH5ubtCP4d/S619ihZ+U1Y4k648ZQ2pF6sZ4Mfn/ZsCMyPDtT
        CMPArZ6NtwlnZvElQt/WgcUxuQZj4QfzKHujzswTjfvc5CWXQHNV2cU/0SF38RgjCBh6nW
        09LD6GOR2M5umPsd7TF4ep+4Fo4Vdp2E2C+V+1vhdiSTjJkmg33WWcDSJWL8eE2ATV389M
        LyD3s6GyBc3XHVUI72FFBn4znnvrN8jYpfqSWMgd/ttEcSse5NPg6z1sfpYGJoXWHfSwac
        PL1d33OqXLyLcxMNFgXM4ODh6B92GFqI9hwbikk+oFQRO3vL9XDGvtjfiaqHtQ==
Date:   Thu, 1 Sep 2022 16:04:40 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 5/6] ARM: dts: sun8i: a83t: Add MIPI CSI-2 controller
 node
Message-ID: <YxC7+Pi4v3Bc1oXc@aptenodytes>
References: <20220826182803.604563-1-paul.kocialkowski@bootlin.com>
 <20220826182803.604563-6-paul.kocialkowski@bootlin.com>
 <YwkYKcffdRGnq+pK@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IMztB6PSZ8uhBkMR"
Content-Disposition: inline
In-Reply-To: <YwkYKcffdRGnq+pK@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IMztB6PSZ8uhBkMR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Fri 26 Aug 22, 21:59, Laurent Pinchart wrote:
> Hi Paul,
>=20
> Thank you for the patch.
>=20
> On Fri, Aug 26, 2022 at 08:28:02PM +0200, Paul Kocialkowski wrote:
> > MIPI CSI-2 is supported on the A83T with a dedicated controller that
> > covers both the protocol and D-PHY. It can be connected to the CSI
> > interface as a V4L2 subdev through the fwnode graph.
> >=20
> > This is not done by default since connecting the bridge without a
> > subdev attached to it will cause a failure on the CSI driver.
>=20
> No urgency, but would it be possible to fix this so that the CSI-2
> receiver can be connected to the CSI unconditionally in DT ? The
> connection exists at the hardware level in the SoC, and should thus
> exist here too, regardless of whether or not a sensor is connected.

Yes it's true that having the link always would be legitimate.

For the context, this CSI controller can be switched between the MIPI CSI-2
controller and a parallel sensor input (i.e. it's not dedicated to one or t=
he
other like on the V3).

Last time I tried, having the connection between the two always there resul=
ted
in the unability to use a parallel sensor when no sensor is attached to the
mipi csi-2 receiver. Probably because the async notifier never completes si=
nce
the mipi csi-2's subdev is never registered without a sensor subdev attache=
d.

Do you see a way to handle this case properly?

Thanks,

Paul

> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  arch/arm/boot/dts/sun8i-a83t.dtsi | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8=
i-a83t.dtsi
> > index 82fdb04122ca..ecf9f3b2c0c0 100644
> > --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > @@ -1064,6 +1064,32 @@ csi: camera@1cb0000 {
> >  			status =3D "disabled";
> >  		};
> > =20
> > +		mipi_csi2: csi@1cb1000 {
> > +			compatible =3D "allwinner,sun8i-a83t-mipi-csi2";
> > +			reg =3D <0x01cb1000 0x1000>;
> > +			interrupts =3D <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks =3D <&ccu CLK_BUS_CSI>,
> > +				 <&ccu CLK_CSI_SCLK>,
> > +				 <&ccu CLK_MIPI_CSI>,
> > +				 <&ccu CLK_CSI_MISC>;
> > +			clock-names =3D "bus", "mod", "mipi", "misc";
> > +			resets =3D <&ccu RST_BUS_CSI>;
> > +			status =3D "disabled";
> > +
> > +			ports {
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <0>;
> > +
> > +				mipi_csi2_in: port@0 {
> > +					reg =3D <0>;
> > +				};
> > +
> > +				mipi_csi2_out: port@1 {
> > +					reg =3D <1>;
> > +				};
> > +			};
> > +		};
> > +
> >  		hdmi: hdmi@1ee0000 {
> >  			compatible =3D "allwinner,sun8i-a83t-dw-hdmi";
> >  			reg =3D <0x01ee0000 0x10000>;
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--IMztB6PSZ8uhBkMR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmMQu/gACgkQ3cLmz3+f
v9FfGgf/bUMOB5DarPNVlB6cB7ecutOIL2h9YZR6cAqSwT3S9OzsDPTgN+b8AuP6
x9K6FblBxuQQKeysoJmym088qRKSIozBsf++zfGtAPu6aORTI0ACT9oYX0ZekSAa
3mc9QM6ALIgGaahDFz5K3Vr5c5pMt5z+r7FPL1zNYwHDwuE5J2b38/cLh723rVaU
MtdiA1Rw8BymidVxPbcInyeQ7FtS7DbIlq1T0wtK7qhRO6Pjf8V6sRGOgUKA4+DO
R5miZyF62faENsnijrnnZ5YhrFJ+z/wzyAqdvPFuKxoeDCFaJLUQrZH9nz5F9UvC
LdyBeOjbv+I1iyJW+76mQgLz6nAtNQ==
=Id0r
-----END PGP SIGNATURE-----

--IMztB6PSZ8uhBkMR--
