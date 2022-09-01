Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D8A5A9B4E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbiIAPLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiIAPLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:11:06 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E28E52457;
        Thu,  1 Sep 2022 08:11:05 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 75DDA200010;
        Thu,  1 Sep 2022 15:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662045064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hPAZFTv0OR8dOw9wKgqi4Kvh5eCGaJ3DTwQLR0c7o2o=;
        b=c5981UEzRxWDuafkKOPkAwjINHBGfzuF9vrUkJxwdwrtDvfGJbXFtJoir/1EsYtNGHmC+o
        ohg2NlW6Q668Z+BNI8lCHe4B+NqcByWvofNwtwBJ9xd3vh4PsEAzZ06+of+HyuNZks4yZz
        WDK5UhQUMHmJdadf0j+9dfcPntXTRG/MS1fTKigh8bga93OQh4mAj0WBiEzy/HQwm3sV3w
        ag1LGnVqu1VMRqvDje+Y8c+tWL+EL8UZKll1UpOakhga5Vpu8PHSZurQpkOPNvRBzSyxJI
        wI6oaruZD3wYTNKLKfRuuDUpd9OKNsMk3ey/8L4vRcML2JQYPnNPmOOgJlOp3g==
Date:   Thu, 1 Sep 2022 17:11:00 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 5/6] media: sun6i-csi: Detect the availability of the
 ISP
Message-ID: <YxDLhPMibhXO1oU/@aptenodytes>
References: <20220826184144.605605-1-paul.kocialkowski@bootlin.com>
 <20220826184144.605605-6-paul.kocialkowski@bootlin.com>
 <YwlLsKaEOoXdqRK0@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wChqMM/2eeW8sfq3"
Content-Disposition: inline
In-Reply-To: <YwlLsKaEOoXdqRK0@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wChqMM/2eeW8sfq3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Sat 27 Aug 22, 01:39, Laurent Pinchart wrote:
> Hi Paul,
>=20
> Thank you for the patch.

Thanks for the review!

> On Fri, Aug 26, 2022 at 08:41:43PM +0200, Paul Kocialkowski wrote:
> > Add a helper to detect whether the ISP is available and connected
> > and store the indication in a driver-wide variable.
>=20
> This sounds like it would be a global variable, while it's stored in the
> driver-specific device structure.

Okay I can clarify the commit message here.

> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 33 +++++++++++++++++++
> >  .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  3 ++
> >  2 files changed, 36 insertions(+)
> >=20
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drive=
rs/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > index 00521f966cee..b16166cba2ef 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > @@ -24,6 +24,35 @@
> >  #include "sun6i_csi_capture.h"
> >  #include "sun6i_csi_reg.h"
> > =20
> > +/* ISP */
> > +
> > +static bool sun6i_csi_isp_detect(struct sun6i_csi_device *csi_dev)
> > +{
> > +	struct device *dev =3D csi_dev->dev;
> > +	struct fwnode_handle *handle =3D NULL;
>=20
> No need to initialize this to NULL.

Indeed.

> > +
> > +	/* ISP is not available if disabled in kernel config. */
> > +	if (!IS_ENABLED(CONFIG_VIDEO_SUN6I_ISP))
> > +		return 0;
>=20
> Hmmm... The ISP driver may be disabled when compiling the sun6i-csi
> driver, but later enabled and deployed. Disabling ISP support silently
> like this could be confusing. Could it be better to move this check
> after the graph check, and print a warning message in this case ?

Yeah I'm not too surprised corner cases like this can exist.
Agreed that printing a warning message would be good, but I don't follow the
point of moving the check later on. Do you have something in mind there?

> > +
> > +	/*
> > +	 * ISP is not available if not connected via fwnode graph.
> > +	 * This weill also check that the remote parent node is available.
>=20
> s/weill/will/

Good catch, thanks!

> 	 * ISP is not available if not connected via fwnode graph. This will
> 	 * also check that the remote parent node is available.
>=20
> > +	 */
> > +	handle =3D fwnode_graph_get_endpoint_by_id(dev_fwnode(dev),
> > +						 SUN6I_CSI_PORT_ISP, 0,
> > +						 FWNODE_GRAPH_ENDPOINT_NEXT);
> > +	if (!handle)
> > +		return 0;
> > +
> > +	fwnode_handle_put(handle);
> > +
> > +	dev_info(dev, "ISP link is available\n");
>=20
> You could make that a debug message, it's not crucial information that
> needs to be printed when the driver is loaded. If you prefer keeping an
> info message, then I'd move it to the probe function and print that the
> CSI has been probed, and indicate in that message if the ISP is
> available.

You're right, let's make this debug. It's more the opposite case that is wo=
rth
a warning message.

Thanks,

Paul

> > +	csi_dev->isp_available =3D true;
> > +
> > +	return 0;
> > +}
> > +
> >  /* Media */
> > =20
> >  static const struct media_device_ops sun6i_csi_media_ops =3D {
> > @@ -290,6 +319,10 @@ static int sun6i_csi_probe(struct platform_device =
*platform_dev)
> >  	if (ret)
> >  		return ret;
> > =20
> > +	ret =3D sun6i_csi_isp_detect(csi_dev);
> > +	if (ret)
> > +		goto error_resources;
> > +
> >  	ret =3D sun6i_csi_v4l2_setup(csi_dev);
> >  	if (ret)
> >  		goto error_resources;
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drive=
rs/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > index e611bdd6e9b2..8e232cd91ebe 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > @@ -21,6 +21,7 @@
> >  enum sun6i_csi_port {
> >  	SUN6I_CSI_PORT_PARALLEL		=3D 0,
> >  	SUN6I_CSI_PORT_MIPI_CSI2	=3D 1,
> > +	SUN6I_CSI_PORT_ISP		=3D 2,
> >  };
> > =20
> >  struct sun6i_csi_buffer {
> > @@ -44,6 +45,8 @@ struct sun6i_csi_device {
> >  	struct clk			*clock_mod;
> >  	struct clk			*clock_ram;
> >  	struct reset_control		*reset;
> > +
> > +	bool				isp_available;
> >  };
> > =20
> >  struct sun6i_csi_variant {
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--wChqMM/2eeW8sfq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmMQy4QACgkQ3cLmz3+f
v9GtJQf/XNoL23Tf/tABOubjKLDGCcpO8JAwFSVCLTLp0SrTV//p7vHq/QKayRXP
5mBJNOaAe797XnyFs9k6oaYGhbFP8/K3pOPs43RqZbta/w0/aOjaJP+e6aHWIZGA
gH2lN2nOfZRfw/3S58z8lDuqhtTDvdIfSIcqtQkW8+/l+Oi9tZIXwqEcY768YjzA
f6nhiDZQoY+5V75ebH5DmXftNUSv5el9ip1SssvhKljVlK7NLSnVAkE6ouMhI0gi
TVClcmFbaT1qNqEG5m9RZJsLCk59olG/otZIcu14laypVPHVyOI3fH55ZqA1i5tE
XfF4NGbHS8bQJkoB2RciCHuBglQrmg==
=tFCj
-----END PGP SIGNATURE-----

--wChqMM/2eeW8sfq3--
