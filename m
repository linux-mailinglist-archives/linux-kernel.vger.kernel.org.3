Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9E0512D80
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343582AbiD1H7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245733AbiD1H7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:59:20 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B47F20BCE;
        Thu, 28 Apr 2022 00:56:05 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2362040007;
        Thu, 28 Apr 2022 07:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651132564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PwJWSFPyWMtOiNkzX7trHwiAp5qywL60TmDmXyh8PGE=;
        b=dvpykhS3lCXFqqBThqULeTtNcre6KG0VweOfWsTgp9gaa45NvaKxFs1rVpHur9eqVU3bmD
        CJ3wAoHMqu/3EZT8oXNhPed2JIt/fgielZnLo2c7dJuqNmmXQ4c6A73EGOBBfRMTGcH6Ea
        VNOhcXutVN3OWNCv6nZfZ1j6F9R4fAnd/4lucF8QHzdMkPjKidzTI2L+teZJZlvrRQSOCu
        MU8PTHX+fqSU7idnkfHN4ccBqbNaqJdLlP8GBnzfIpPNQ5/b3C9fG+0QUQr56bWZ289iWX
        d9W7nhhCk/K6rsARwdtrAsNhjHJBMjZhRDoTm9EvMPBRu8WPDtKi5TSusOE5ag==
Date:   Thu, 28 Apr 2022 09:55:56 +0200
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
Message-ID: <YmpIjPe8pw+yvGyL@aptenodytes>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
 <20220415152811.636419-44-paul.kocialkowski@bootlin.com>
 <2029179.KlZ2vcFHjT@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ed//Kfe9t1pc7ZsY"
Content-Disposition: inline
In-Reply-To: <2029179.KlZ2vcFHjT@jernej-laptop>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ed//Kfe9t1pc7ZsY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jernej,

Thanks a lot for all your reviews!

On Wed 27 Apr 22, 22:07, Jernej =C5=A0krabec wrote:
> Dne petek, 15. april 2022 ob 17:28:09 CEST je Paul Kocialkowski napisal(a=
):
> > Add a helper to detect whether the ISP is available and connected
> > and store the indication in a driver-wide variable.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 33 +++++++++++++++++++
> >  .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  3 ++
> >  2 files changed, 36 insertions(+)
> >=20
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c index
> > a88deb8ba1e7..f185cbd113c7 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > @@ -25,6 +25,35 @@
> >  #include "sun6i_csi_capture.h"
> >  #include "sun6i_csi_reg.h"
> >=20
> > +/* ISP */
> > +
> > +static bool sun6i_csi_isp_detect(struct sun6i_csi_device *csi_dev)
> > +{
> > +	struct device *dev =3D csi_dev->dev;
> > +	struct fwnode_handle *handle =3D NULL;
> > +
> > +	/* ISP is not available if disabled in kernel config. */
> > +	if (!IS_ENABLED(CONFIG_VIDEO_SUN6I_ISP))
>=20
> Where is this symbol defined?

That is defined through Kconfig's auto-generated header, from the associated
option for the ISP driver. It is defined in the ISP support series so this
will effectively always be false for now.

> Best regards,
> Jernej
>=20
> > +		return 0;
> > +
> > +	/*
> > +	 * ISP is not available if not connected via fwnode graph.
> > +	 * This weill also check that the remote parent node is available.
> > +	 */
> > +	handle =3D fwnode_graph_get_endpoint_by_id(dev_fwnode(dev),
> > +						=20
> SUN6I_CSI_PORT_ISP, 0,
> > +						=20
> FWNODE_GRAPH_ENDPOINT_NEXT);
> > +	if (!handle)
> > +		return 0;
> > +
> > +	fwnode_handle_put(handle);
> > +
> > +	dev_info(dev, "ISP link is available\n");
> > +	csi_dev->isp_available =3D true;
> > +
> > +	return 0;
> > +}
> > +
> >  /* Media */
> >=20
> >  static const struct media_device_ops sun6i_csi_media_ops =3D {
> > @@ -306,6 +335,10 @@ static int sun6i_csi_probe(struct platform_device
> > *platform_dev) if (ret)
> >  		return ret;
> >=20
> > +	ret =3D sun6i_csi_isp_detect(csi_dev);
> > +	if (ret)
> > +		goto error_resources;
> > +
> >  	ret =3D sun6i_csi_v4l2_setup(csi_dev);
> >  	if (ret)
> >  		goto error_resources;
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h index
> > 6aa83dd11684..9b105c341047 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > @@ -22,6 +22,7 @@
> >  enum sun6i_csi_port {
> >  	SUN6I_CSI_PORT_PARALLEL		=3D 0,
> >  	SUN6I_CSI_PORT_MIPI_CSI2	=3D 1,
> > +	SUN6I_CSI_PORT_ISP		=3D 2,
> >  };
> >=20
> >  struct sun6i_csi_buffer {
> > @@ -46,6 +47,8 @@ struct sun6i_csi_device {
> >  	struct clk			*clock_mod;
> >  	struct clk			*clock_ram;
> >  	struct reset_control		*reset;
> > +
> > +	bool				isp_available;
> >  };
> >=20
> >  struct sun6i_csi_variant {
>=20
>=20
>=20
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--Ed//Kfe9t1pc7ZsY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmJqSIsACgkQ3cLmz3+f
v9FaXQgAofXC4aKthXOVBgx2avaUKkXQfv+k5TuIIIcHUt5UxHio7Jz/Jo63k4aS
40fL2G9UAHlkY/pvlmXOPWyoFOZkEOMgSPrDtOOYHnFDxfVdMMDr+WtEWewhiEic
bWgj3LQRgrW51O/SFiAmCcFe3lrrkPy7MpSOKduQlfwXxnN9BKyF+SfC/Xd1fcD5
qHNk3WuDDyJ/jYC7d3hgdy4WdcE4Hy4OvZY8VzvGw0OGA9Ys0s0JMs74ohNqOnz/
92wSVjm9u7Shz8UZMdA0rY9MKNN1d4WTFTp8ok4IOAIzv/2irOo3HA9+PBzatZw1
ZcQIEdZFCx0heApvDexHrVygwHTWWw==
=JFVd
-----END PGP SIGNATURE-----

--Ed//Kfe9t1pc7ZsY--
