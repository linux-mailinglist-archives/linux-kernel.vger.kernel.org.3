Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3EE5A9AED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiIAOzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiIAOzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:55:22 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D052E9CE;
        Thu,  1 Sep 2022 07:55:19 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 01CCE40006;
        Thu,  1 Sep 2022 14:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662044117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lDrzHG/7bnUpPCX2FdrfpAZxJHZMJVwgW3PqPlPCOCs=;
        b=bQgI+vH5dajNG9Z/r/xlTow4bxF/JtJelzS6MhnucPS2fUoWLhn04T3s2G3xCvNzrmw9qy
        77F2lPLkpm51PvC35mhD+X8wzc8UhVjCYKU+Gi5dnSeguymG25WbXRM+urfoIzdYY6lTxg
        GSt/fHUiXg/iGzJ36/bmdBasRCAgGNGY3qpfFEztzAvfhBhaKzCVp116wZH//gnlRFvUs1
        IcQ5LFqKHE2D2ilvwsh5xgmuTfVOSJbEtpQLp6JY7XhIAXTVpx6B3sNVgp+fTcpfcfM4DM
        Z09jF7psINbclhiZ1zjF2iICHWjYjFh7yoS6lNkrsQDhZfrswZqpXr2NlVBhYQ==
Date:   Thu, 1 Sep 2022 16:55:14 +0200
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
Subject: Re: [PATCH v6 6/6] media: sun6i-csi: Add support for hooking to the
 isp devices
Message-ID: <YxDH0jZE1laFnfcu@aptenodytes>
References: <20220826184144.605605-1-paul.kocialkowski@bootlin.com>
 <20220826184144.605605-7-paul.kocialkowski@bootlin.com>
 <YwlMsAG/vPUTNd4o@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7aRp53ihIMe3iTc5"
Content-Disposition: inline
In-Reply-To: <YwlMsAG/vPUTNd4o@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7aRp53ihIMe3iTc5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Sat 27 Aug 22, 01:44, Laurent Pinchart wrote:
> Hi Paul,
>=20
> Thank you for the patch.
>=20
> On Fri, Aug 26, 2022 at 08:41:44PM +0200, Paul Kocialkowski wrote:
> > In order to use the isp and csi together, both devices need to be
> > parented to the same v4l2 and media devices. We use the isp as
> > top-level device and let the csi code hook to its v4l2 and media
> > devices when async subdev registration takes place.
>=20
> Have you considered the option of making the CSI the master device, with
> the ISP registering an async subdev instead ?

Yes I did consider it but the issue is that some platforms using these driv=
ers
have 2 CSI blocks and always 1 ISP block that can be fed from either CSI.
So if we want to have a single media device where we can switch the ISP bet=
ween
the two CSIs, the only choice is to have the media/v4l2 devices registered
by the ISP driver.

For the next generation it would be absolutely necessary to have a single d=
river
using the component framework instead of separate drivers because the numbe=
r of
components and routing capabilities are much more complex.

> I'm also wondering, what will happen if userspace tries to capture from
> both the CSI output and the ISP output at the same time ?

Well there's a media link to select where the sun6i-csi-bridge data should
flow, so if it's routed to the sun6i-isp-proc instead of sun6i-csi-capture
it should fail when trying to capture via sun6i-csi.

I'll double-check that this is actually the case, but I think
media_pipeline_start in sun6i_csi_capture_start_streaming should error out
in this case.

Cheers,

Paul

> > As a result v4l2/media device setup is only called when the ISP
> > is missing and the capture device is registered after the devices
> > are hooked. The bridge subdev and its notifier are registered
> > without any device when the ISP is available. Top-level pointers
> > for the devices are introduced to either redirect to the hooked ones
> > (isp available) or the registered ones (isp missing).
> >=20
> > Also keep track of whether the capture node was setup or not to
> > avoid cleaning up resources when it wasn't.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 45 +++++++++++++++----
> >  .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  7 +++
> >  .../sunxi/sun6i-csi/sun6i_csi_bridge.c        | 32 +++++++++++--
> >  .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 19 ++++++--
> >  .../sunxi/sun6i-csi/sun6i_csi_capture.h       |  1 +
> >  5 files changed, 89 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drive=
rs/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > index b16166cba2ef..0bac89d8112f 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > @@ -26,6 +26,18 @@
> > =20
> >  /* ISP */
> > =20
> > +int sun6i_csi_isp_complete(struct sun6i_csi_device *csi_dev,
> > +			   struct v4l2_device *v4l2_dev)
> > +{
> > +	if (csi_dev->v4l2_dev && csi_dev->v4l2_dev !=3D v4l2_dev)
> > +		return -EINVAL;
> > +
> > +	csi_dev->v4l2_dev =3D v4l2_dev;
> > +	csi_dev->media_dev =3D v4l2_dev->mdev;
> > +
> > +	return sun6i_csi_capture_setup(csi_dev);
> > +}
> > +
> >  static bool sun6i_csi_isp_detect(struct sun6i_csi_device *csi_dev)
> >  {
> >  	struct device *dev =3D csi_dev->dev;
> > @@ -95,6 +107,9 @@ static int sun6i_csi_v4l2_setup(struct sun6i_csi_dev=
ice *csi_dev)
> >  		goto error_media;
> >  	}
> > =20
> > +	csi_dev->v4l2_dev =3D v4l2_dev;
> > +	csi_dev->media_dev =3D media_dev;
> > +
> >  	return 0;
> > =20
> >  error_media:
> > @@ -323,17 +338,27 @@ static int sun6i_csi_probe(struct platform_device=
 *platform_dev)
> >  	if (ret)
> >  		goto error_resources;
> > =20
> > -	ret =3D sun6i_csi_v4l2_setup(csi_dev);
> > -	if (ret)
> > -		goto error_resources;
> > +	/*
> > +	 * Register our own v4l2 and media devices when there is no ISP aroun=
d.
> > +	 * Otherwise the ISP will use async subdev registration with our brid=
ge,
> > +	 * which will provide v4l2 and media devices that are used to register
> > +	 * the video interface.
> > +	 */
> > +	if (!csi_dev->isp_available) {
> > +		ret =3D sun6i_csi_v4l2_setup(csi_dev);
> > +		if (ret)
> > +			goto error_resources;
> > +	}
> > =20
> >  	ret =3D sun6i_csi_bridge_setup(csi_dev);
> >  	if (ret)
> >  		goto error_v4l2;
> > =20
> > -	ret =3D sun6i_csi_capture_setup(csi_dev);
> > -	if (ret)
> > -		goto error_bridge;
> > +	if (!csi_dev->isp_available) {
> > +		ret =3D sun6i_csi_capture_setup(csi_dev);
> > +		if (ret)
> > +			goto error_bridge;
> > +	}
> > =20
> >  	return 0;
> > =20
> > @@ -341,7 +366,8 @@ static int sun6i_csi_probe(struct platform_device *=
platform_dev)
> >  	sun6i_csi_bridge_cleanup(csi_dev);
> > =20
> >  error_v4l2:
> > -	sun6i_csi_v4l2_cleanup(csi_dev);
> > +	if (!csi_dev->isp_available)
> > +		sun6i_csi_v4l2_cleanup(csi_dev);
> > =20
> >  error_resources:
> >  	sun6i_csi_resources_cleanup(csi_dev);
> > @@ -355,7 +381,10 @@ static int sun6i_csi_remove(struct platform_device=
 *pdev)
> > =20
> >  	sun6i_csi_capture_cleanup(csi_dev);
> >  	sun6i_csi_bridge_cleanup(csi_dev);
> > -	sun6i_csi_v4l2_cleanup(csi_dev);
> > +
> > +	if (!csi_dev->isp_available)
> > +		sun6i_csi_v4l2_cleanup(csi_dev);
> > +
> >  	sun6i_csi_resources_cleanup(csi_dev);
> > =20
> >  	return 0;
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drive=
rs/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > index 8e232cd91ebe..bc3f0dae35df 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > @@ -36,6 +36,8 @@ struct sun6i_csi_v4l2 {
> > =20
> >  struct sun6i_csi_device {
> >  	struct device			*dev;
> > +	struct v4l2_device		*v4l2_dev;
> > +	struct media_device		*media_dev;
> > =20
> >  	struct sun6i_csi_v4l2		v4l2;
> >  	struct sun6i_csi_bridge		bridge;
> > @@ -53,4 +55,9 @@ struct sun6i_csi_variant {
> >  	unsigned long	clock_mod_rate;
> >  };
> > =20
> > +/* ISP */
> > +
> > +int sun6i_csi_isp_complete(struct sun6i_csi_device *csi_dev,
> > +			   struct v4l2_device *v4l2_dev);
> > +
> >  #endif
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c =
b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
> > index 492f93b0db28..86d20c1c35ed 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
> > @@ -653,6 +653,7 @@ sun6i_csi_bridge_notifier_bound(struct v4l2_async_n=
otifier *notifier,
> >  	struct sun6i_csi_bridge *bridge =3D &csi_dev->bridge;
> >  	struct sun6i_csi_bridge_source *source =3D bridge_async_subdev->sourc=
e;
> >  	bool enabled;
> > +	int ret;
> > =20
> >  	switch (source->endpoint.base.port) {
> >  	case SUN6I_CSI_PORT_PARALLEL:
> > @@ -667,6 +668,16 @@ sun6i_csi_bridge_notifier_bound(struct v4l2_async_=
notifier *notifier,
> > =20
> >  	source->subdev =3D remote_subdev;
> > =20
> > +	if (csi_dev->isp_available) {
> > +		/*
> > +		 * Hook to the first available remote subdev to get v4l2 and
> > +		 * media devices and register the capture device then.
> > +		 */
> > +		ret =3D sun6i_csi_isp_complete(csi_dev, remote_subdev->v4l2_dev);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	return sun6i_csi_bridge_link(csi_dev, SUN6I_CSI_BRIDGE_PAD_SINK,
> >  				     remote_subdev, enabled);
> >  }
> > @@ -679,6 +690,9 @@ sun6i_csi_bridge_notifier_complete(struct v4l2_asyn=
c_notifier *notifier)
> >  			     bridge.notifier);
> >  	struct v4l2_device *v4l2_dev =3D &csi_dev->v4l2.v4l2_dev;
> > =20
> > +	if (csi_dev->isp_available)
> > +		return 0;
> > +
> >  	return v4l2_device_register_subdev_nodes(v4l2_dev);
> >  }
> > =20
> > @@ -752,7 +766,7 @@ int sun6i_csi_bridge_setup(struct sun6i_csi_device =
*csi_dev)
> >  {
> >  	struct device *dev =3D csi_dev->dev;
> >  	struct sun6i_csi_bridge *bridge =3D &csi_dev->bridge;
> > -	struct v4l2_device *v4l2_dev =3D &csi_dev->v4l2.v4l2_dev;
> > +	struct v4l2_device *v4l2_dev =3D csi_dev->v4l2_dev;
> >  	struct v4l2_subdev *subdev =3D &bridge->subdev;
> >  	struct v4l2_async_notifier *notifier =3D &bridge->notifier;
> >  	struct media_pad *pads =3D bridge->pads;
> > @@ -793,7 +807,11 @@ int sun6i_csi_bridge_setup(struct sun6i_csi_device=
 *csi_dev)
> > =20
> >  	/* V4L2 Subdev */
> > =20
> > -	ret =3D v4l2_device_register_subdev(v4l2_dev, subdev);
> > +	if (csi_dev->isp_available)
> > +		ret =3D v4l2_async_register_subdev(subdev);
> > +	else
> > +		ret =3D v4l2_device_register_subdev(v4l2_dev, subdev);
> > +
> >  	if (ret) {
> >  		dev_err(dev, "failed to register v4l2 subdev: %d\n", ret);
> >  		goto error_media_entity;
> > @@ -810,7 +828,10 @@ int sun6i_csi_bridge_setup(struct sun6i_csi_device=
 *csi_dev)
> >  	sun6i_csi_bridge_source_setup(csi_dev, &bridge->source_mipi_csi2,
> >  				      SUN6I_CSI_PORT_MIPI_CSI2, NULL);
> > =20
> > -	ret =3D v4l2_async_nf_register(v4l2_dev, notifier);
> > +	if (csi_dev->isp_available)
> > +		ret =3D v4l2_async_subdev_nf_register(subdev, notifier);
> > +	else
> > +		ret =3D v4l2_async_nf_register(v4l2_dev, notifier);
> >  	if (ret) {
> >  		dev_err(dev, "failed to register v4l2 async notifier: %d\n",
> >  			ret);
> > @@ -822,7 +843,10 @@ int sun6i_csi_bridge_setup(struct sun6i_csi_device=
 *csi_dev)
> >  error_v4l2_async_notifier:
> >  	v4l2_async_nf_cleanup(notifier);
> > =20
> > -	v4l2_device_unregister_subdev(subdev);
> > +	if (csi_dev->isp_available)
> > +		v4l2_async_unregister_subdev(subdev);
> > +	else
> > +		v4l2_device_unregister_subdev(subdev);
> > =20
> >  error_media_entity:
> >  	media_entity_cleanup(&subdev->entity);
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c=
 b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> > index c9e7526b84c4..69ea1cbaea0c 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> > @@ -570,7 +570,7 @@ static int sun6i_csi_capture_buffer_prepare(struct =
vb2_buffer *buffer)
> >  {
> >  	struct sun6i_csi_device *csi_dev =3D vb2_get_drv_priv(buffer->vb2_que=
ue);
> >  	struct sun6i_csi_capture *capture =3D &csi_dev->capture;
> > -	struct v4l2_device *v4l2_dev =3D &csi_dev->v4l2.v4l2_dev;
> > +	struct v4l2_device *v4l2_dev =3D csi_dev->v4l2_dev;
> >  	struct vb2_v4l2_buffer *v4l2_buffer =3D to_vb2_v4l2_buffer(buffer);
> >  	unsigned long size =3D capture->format.fmt.pix.sizeimage;
> > =20
> > @@ -889,7 +889,7 @@ static int sun6i_csi_capture_link_validate(struct m=
edia_link *link)
> >  	struct video_device *video_dev =3D
> >  		media_entity_to_video_device(link->sink->entity);
> >  	struct sun6i_csi_device *csi_dev =3D video_get_drvdata(video_dev);
> > -	struct v4l2_device *v4l2_dev =3D &csi_dev->v4l2.v4l2_dev;
> > +	struct v4l2_device *v4l2_dev =3D csi_dev->v4l2_dev;
> >  	const struct sun6i_csi_capture_format *capture_format;
> >  	const struct sun6i_csi_bridge_format *bridge_format;
> >  	unsigned int capture_width, capture_height;
> > @@ -971,7 +971,7 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device=
 *csi_dev)
> >  {
> >  	struct sun6i_csi_capture *capture =3D &csi_dev->capture;
> >  	struct sun6i_csi_capture_state *state =3D &capture->state;
> > -	struct v4l2_device *v4l2_dev =3D &csi_dev->v4l2.v4l2_dev;
> > +	struct v4l2_device *v4l2_dev =3D csi_dev->v4l2_dev;
> >  	struct v4l2_subdev *bridge_subdev =3D &csi_dev->bridge.subdev;
> >  	struct video_device *video_dev =3D &capture->video_dev;
> >  	struct vb2_queue *queue =3D &capture->queue;
> > @@ -980,6 +980,10 @@ int sun6i_csi_capture_setup(struct sun6i_csi_devic=
e *csi_dev)
> >  	struct v4l2_pix_format *pix_format =3D &format->fmt.pix;
> >  	int ret;
> > =20
> > +	/* This may happen with multiple bridge notifier bound calls. */
> > +	if (state->setup)
> > +		return 0;
> > +
> >  	/* State */
> > =20
> >  	INIT_LIST_HEAD(&state->queue);
> > @@ -1055,6 +1059,7 @@ int sun6i_csi_capture_setup(struct sun6i_csi_devi=
ce *csi_dev)
> >  	ret =3D media_create_pad_link(&bridge_subdev->entity,
> >  				    SUN6I_CSI_BRIDGE_PAD_SOURCE,
> >  				    &video_dev->entity, 0,
> > +				    csi_dev->isp_available ? 0 :
> >  				    MEDIA_LNK_FL_ENABLED |
> >  				    MEDIA_LNK_FL_IMMUTABLE);
> >  	if (ret < 0) {
> > @@ -1065,6 +1070,8 @@ int sun6i_csi_capture_setup(struct sun6i_csi_devi=
ce *csi_dev)
> >  		goto error_video_device;
> >  	}
> > =20
> > +	state->setup =3D true;
> > +
> >  	return 0;
> > =20
> >  error_video_device:
> > @@ -1083,7 +1090,13 @@ void sun6i_csi_capture_cleanup(struct sun6i_csi_=
device *csi_dev)
> >  	struct sun6i_csi_capture *capture =3D &csi_dev->capture;
> >  	struct video_device *video_dev =3D &capture->video_dev;
> > =20
> > +	/* This may happen if async registration failed to complete. */
> > +	if (!capture->state.setup)
> > +		return;
> > +
> >  	vb2_video_unregister_device(video_dev);
> >  	media_entity_cleanup(&video_dev->entity);
> >  	mutex_destroy(&capture->lock);
> > +
> > +	capture->state.setup =3D false;
> >  }
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h=
 b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> > index 29893cf96f6b..3ee5ccefbd10 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> > @@ -45,6 +45,7 @@ struct sun6i_csi_capture_state {
> > =20
> >  	unsigned int			sequence;
> >  	bool				streaming;
> > +	bool				setup;
> >  };
> > =20
> >  struct sun6i_csi_capture {
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--7aRp53ihIMe3iTc5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmMQx9IACgkQ3cLmz3+f
v9HuAQf/f1OOl4QcLtOzRq13Pzyph3j5E5UHU6ZDXpGxKbFx7FdmQz3e3b+p49jL
f5ZxRO4N3bDQiESa8XEBCnfQ41acKdOxdNU57IFkjQC45aop4DOVGcsg8xWyRtpK
EAdtglwgXE7/mgQIz7YzjX4eOyBwikTiS9AZwC1PXx1ml8qI/VFJjNHbIfRsblt6
MGHzHU+9IAUSmTpPodUzSJI0we9D2DCziToUfsf4h+jqrbGxTRalWjKt4fFaeqkF
rmIqcN/9wNnbnnV+5AWI8KCj02TiQmDU3MKpvVTe5HbfvBaFj+m9bKdrXtV1oCDb
Tu8I+XvX9lnqkCYLqRJhyYLlUGtkcw==
=OO09
-----END PGP SIGNATURE-----

--7aRp53ihIMe3iTc5--
