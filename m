Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A581A513299
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345624AbiD1Lm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345604AbiD1Lmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:42:54 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBB26EC5C;
        Thu, 28 Apr 2022 04:39:38 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EFF5024000B;
        Thu, 28 Apr 2022 11:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651145977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=25x1RGE8SyMvMHJazJNDrpPtoAk8a2d3p44nhmT6xQ0=;
        b=cn+cXnVVN/rkBpwmnRHQRTVI/PYaFjB6R1kR8IT+XJkgp/ieF96FzC/x9i61OPzWFYbTBd
        HKvHcSoGOeHWUaRH1yyoYAJQ6XLheqnXiLcah6zM9iPwX+n7LOajcTVwLVb5U8iuoOc5Hh
        R2YlEmFWkl8R9peqSysVXTgr6Wwn+NaB+6ngn7eHgjfCtLOvc/VErBdig44xwxpUtTa/Og
        R0dKrvDku2ZrB10kuU2mQ8xcQ0qyJTOhAb6/EQ/Y1F4ODXRRxi2FtzK+kdpd0Ayyrg27qz
        gv3mWGTym/+EGW4RzUbfZp410BVj2djeIXWh4WdFwTqAUGg44ukGVfMhhx3HSQ==
Date:   Thu, 28 Apr 2022 13:39:30 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 43/45] media: sun6i-csi: Detect the availability of
 the ISP
Message-ID: <Ymp88rULPlsKqjXU@aptenodytes>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
 <2029179.KlZ2vcFHjT@jernej-laptop>
 <YmpIjPe8pw+yvGyL@aptenodytes>
 <5794263.alqRGMn8q6@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1TLKJ1OwjGkmpqF0"
Content-Disposition: inline
In-Reply-To: <5794263.alqRGMn8q6@jernej-laptop>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1TLKJ1OwjGkmpqF0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jernej,

On Thu 28 Apr 22, 10:09, Jernej =C5=A0krabec wrote:
> Dne =C4=8Detrtek, 28. april 2022 ob 09:55:56 CEST je Paul Kocialkowski na=
pisal(a):
> > Hi Jernej,
> >=20
> > Thanks a lot for all your reviews!
> >=20
> > On Wed 27 Apr 22, 22:07, Jernej =C5=A0krabec wrote:
> > > Dne petek, 15. april 2022 ob 17:28:09 CEST je Paul Kocialkowski=20
> napisal(a):
> > > > Add a helper to detect whether the ISP is available and connected
> > > > and store the indication in a driver-wide variable.
> > > >=20
> > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > ---
> > > >=20
> > > >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 33 +++++++++++++++=
++++
> > > >  .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  3 ++
> > > >  2 files changed, 36 insertions(+)
> > > >=20
> > > > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > > b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c index
> > > > a88deb8ba1e7..f185cbd113c7 100644
> > > > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > > @@ -25,6 +25,35 @@
> > > >=20
> > > >  #include "sun6i_csi_capture.h"
> > > >  #include "sun6i_csi_reg.h"
> > > >=20
> > > > +/* ISP */
> > > > +
> > > > +static bool sun6i_csi_isp_detect(struct sun6i_csi_device *csi_dev)
> > > > +{
> > > > +	struct device *dev =3D csi_dev->dev;
> > > > +	struct fwnode_handle *handle =3D NULL;
> > > > +
> > > > +	/* ISP is not available if disabled in kernel config. */
> > > > +	if (!IS_ENABLED(CONFIG_VIDEO_SUN6I_ISP))
> > >=20
> > > Where is this symbol defined?
> >=20
> > That is defined through Kconfig's auto-generated header, from the assoc=
iated
> > option for the ISP driver. It is defined in the ISP support series so t=
his
> > will effectively always be false for now.
>=20
> Well, then, that driver should be merged before this patch. While I under=
stand=20
> that it's likely that ISP driver with such name will eventually materiali=
ze in=20
> kernel, I don't want to rely on things that are not set in stone, e.g. al=
ready=20
> merged.

Okay that would make sense, the patches adding ISP support in sun6i-csi cou=
ld
be moved to the series adding support for the ISP.

Cheers,

Paul

> Best regards,
> Jernej
>=20
> >=20
> > > Best regards,
> > > Jernej
> > >=20
> > > > +		return 0;
> > > > +
> > > > +	/*
> > > > +	 * ISP is not available if not connected via fwnode graph.
> > > > +	 * This weill also check that the remote parent node is available.
> > > > +	 */
> > > > +	handle =3D fwnode_graph_get_endpoint_by_id(dev_fwnode(dev),
> > > > +
> > >=20
> > > SUN6I_CSI_PORT_ISP, 0,
> > >=20
> > > > +
> > >=20
> > > FWNODE_GRAPH_ENDPOINT_NEXT);
> > >=20
> > > > +	if (!handle)
> > > > +		return 0;
> > > > +
> > > > +	fwnode_handle_put(handle);
> > > > +
> > > > +	dev_info(dev, "ISP link is available\n");
> > > > +	csi_dev->isp_available =3D true;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >=20
> > > >  /* Media */
> > > > =20
> > > >  static const struct media_device_ops sun6i_csi_media_ops =3D {
> > > >=20
> > > > @@ -306,6 +335,10 @@ static int sun6i_csi_probe(struct platform_dev=
ice
> > > > *platform_dev) if (ret)
> > > >=20
> > > >  		return ret;
> > > >=20
> > > > +	ret =3D sun6i_csi_isp_detect(csi_dev);
> > > > +	if (ret)
> > > > +		goto error_resources;
> > > > +
> > > >=20
> > > >  	ret =3D sun6i_csi_v4l2_setup(csi_dev);
> > > >  	if (ret)
> > > >  =09
> > > >  		goto error_resources;
> > > >=20
> > > > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > > > b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h index
> > > > 6aa83dd11684..9b105c341047 100644
> > > > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > > > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > > > @@ -22,6 +22,7 @@
> > > >=20
> > > >  enum sun6i_csi_port {
> > > > =20
> > > >  	SUN6I_CSI_PORT_PARALLEL		=3D 0,
> > > >  	SUN6I_CSI_PORT_MIPI_CSI2	=3D 1,
> > > >=20
> > > > +	SUN6I_CSI_PORT_ISP		=3D 2,
> > > >=20
> > > >  };
> > > > =20
> > > >  struct sun6i_csi_buffer {
> > > >=20
> > > > @@ -46,6 +47,8 @@ struct sun6i_csi_device {
> > > >=20
> > > >  	struct clk			*clock_mod;
> > > >  	struct clk			*clock_ram;
> > > >  	struct reset_control		*reset;
> > > >=20
> > > > +
> > > > +	bool				isp_available;
> > > >=20
> > > >  };
> > > > =20
> > > >  struct sun6i_csi_variant {
>=20
>=20
>=20
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--1TLKJ1OwjGkmpqF0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmJqfPIACgkQ3cLmz3+f
v9Fbdwf+Ngj8nUBk4am1Ubl2z/EaUy6WIGLfEptSSInVoFHFFKZq+nmFIActVTqT
M7zkI9vuMretENrWuBvAvdnTNeZkTZ9jEDOl4CWfBxbNRRYodxa9vdGOHdpDAX0b
/Gfa6jsbx2Qga8nfx/JACVLOO/IzF8KB/i7k9+9ZL63iVC1QlcCj32Okm25uHnWx
sxX48Is4cwPNQLbEeTofEVsR5er945usaVlySznc3iHgAuZr+Wyb0tAKPPtrvNn0
gN/O/k3wXOFWP6RyBMuAstwXlQcQiOsSrb0MpkAfP/zdebL2a+YaGoVDhHuZL8rY
mxZNmv0kBQX9BcZ2t/svntcJl5UZtA==
=rIIX
-----END PGP SIGNATURE-----

--1TLKJ1OwjGkmpqF0--
