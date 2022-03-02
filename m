Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBF54CA8B6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243129AbiCBPAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiCBPAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:00:40 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2F53CFD3;
        Wed,  2 Mar 2022 06:59:54 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 437B8200009;
        Wed,  2 Mar 2022 14:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646233193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NT+kcBdCJaRCn1KXjI10tFId3ij/iQNBW1Ug7O+AIR8=;
        b=fQ6L54qUdvvYl4Y0YOtVop2KDbUCzQMMVAsZ4z9lPufwTawvSggtKpPH01mWX0gehZO3/6
        hYkgT/STxo+mDcZhi0Cu9C9WcbTtLS4928OshkzD4HluhMwArQwff7ch2IVVg00rsMg+EF
        eZh8W+QoHMYUuQI7JpiFu7uqDWemkgFR0EtMsKPIUawOAde3O4arwUZe//Twm0I0zgLBMM
        E+PGnRDhDGfAwYRIYTcj8rn4npc9uztPwSB0uonFXTiW7+vSyEXFuhFXfESozNZ1dSnOIH
        WJsjXRrf9MaddSaL5bhtigXM39zqGiY5L5U1ChN4IssOOqktPmKfs2Z2hxz1Gg==
Date:   Wed, 2 Mar 2022 15:59:50 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 30/66] media: sun6i-csi: Add bridge v4l2 subdev with
 port management
Message-ID: <Yh+GZv9/rKQ2WbI2@aptenodytes>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-31-paul.kocialkowski@bootlin.com>
 <YgqbqVRinNxQ8+WV@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iIlmZW4kMnsR7tZI"
Content-Disposition: inline
In-Reply-To: <YgqbqVRinNxQ8+WV@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iIlmZW4kMnsR7tZI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Mon 14 Feb 22, 20:12, Sakari Ailus wrote:
> Hi Paul,
>=20
> On Sat, Feb 05, 2022 at 07:53:53PM +0100, Paul Kocialkowski wrote:
> > Introduce a bridge v4l2 subdev to prepare for separation between the
> > processing part (bridge) and the dma engine, which is required to
> > properly support ths isp workflow later on.
> >=20
> > Currently the bridge just manages fwnode mapping to media pads,
> > using an async notifier (which was previously in the main code).
> > The s_stream video op just forwards to the connected v4l2 subdev
> > (sensor or MIPI CSI-2 bridge).
> >=20
> > The video capture device is now registered after the bridge and
> > attaches to it with a media link.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  .../media/platform/sunxi/sun6i-csi/Makefile   |   2 +-
> >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 156 +-----
> >  .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  12 +-
> >  .../sunxi/sun6i-csi/sun6i_csi_bridge.c        | 473 ++++++++++++++++++
> >  .../sunxi/sun6i-csi/sun6i_csi_bridge.h        |  44 ++
> >  .../platform/sunxi/sun6i-csi/sun6i_video.c    |  19 +
> >  6 files changed, 571 insertions(+), 135 deletions(-)
> >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_br=
idge.c
> >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_br=
idge.h

[...]

> > +static int sun6i_csi_bridge_set_fmt(struct v4l2_subdev *subdev,
> > +				    struct v4l2_subdev_state *state,
> > +				    struct v4l2_subdev_format *format)
> > +{
> > +	struct sun6i_csi_device *csi_dev =3D v4l2_get_subdevdata(subdev);
> > +	struct v4l2_mbus_framefmt *mbus_format =3D &format->format;
> > +
> > +	sun6i_csi_bridge_mbus_format_prepare(mbus_format);
> > +
> > +	if (format->which =3D=3D V4L2_SUBDEV_FORMAT_TRY)
> > +		*v4l2_subdev_get_try_format(subdev, state, format->pad) =3D
> > +			*mbus_format;
> > +	else
> > +		csi_dev->bridge.mbus_format =3D *mbus_format;
>=20
> Note that the driver is responsible for serialising access to its data,
> i.e. you have to acquire the mutex here.

Thanks, will take care of that next time.

> > +
> > +	return 0;
> > +}
> > +
> > +static const struct v4l2_subdev_pad_ops sun6i_csi_bridge_pad_ops =3D {
> > +	.init_cfg	=3D sun6i_csi_bridge_init_cfg,
> > +	.enum_mbus_code	=3D sun6i_csi_bridge_enum_mbus_code,
> > +	.get_fmt	=3D sun6i_csi_bridge_get_fmt,
> > +	.set_fmt	=3D sun6i_csi_bridge_set_fmt,
> > +};
> > +
> > +const struct v4l2_subdev_ops sun6i_csi_bridge_subdev_ops =3D {
> > +	.video	=3D &sun6i_csi_bridge_video_ops,
> > +	.pad	=3D &sun6i_csi_bridge_pad_ops,
> > +};
> > +
> > +/* Media Entity */
> > +
> > +static int sun6i_csi_bridge_link_validate(struct media_link *link)
> > +{
> > +	struct v4l2_subdev *subdev =3D
> > +		media_entity_to_v4l2_subdev(link->sink->entity);
> > +	struct sun6i_csi_device *csi_dev =3D v4l2_get_subdevdata(subdev);
> > +	struct sun6i_csi_bridge *bridge =3D &csi_dev->bridge;
> > +	struct device *dev =3D csi_dev->dev;
> > +	struct v4l2_subdev *source_subdev =3D
> > +		media_entity_to_v4l2_subdev(link->source->entity);
> > +	int ret;
> > +
> > +	/* Only support one enabled source at a time. */
> > +	if (bridge->source) {
> > +		dev_err(dev, "multiple sources are connected to the bridge\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	ret =3D v4l2_subdev_link_validate(link);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (source_subdev =3D=3D bridge->source_parallel.subdev)
> > +		bridge->source =3D &bridge->source_parallel;
> > +	else
>=20
> Useless use of else.

Fair enough.

> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct media_entity_operations sun6i_csi_bridge_entity_op=
s =3D {
> > +	.link_validate	=3D sun6i_csi_bridge_link_validate,
> > +};
> > +
> > +/* V4L2 Async */
> > +
> > +static int sun6i_csi_bridge_link(struct sun6i_csi_device *csi_dev,
> > +				 int sink_pad_index,
> > +				 struct v4l2_subdev *remote_subdev,
> > +				 bool enabled)
> > +{
> > +	struct device *dev =3D csi_dev->dev;
> > +	struct v4l2_subdev *subdev =3D &csi_dev->bridge.subdev;
> > +	struct media_entity *sink_entity =3D &subdev->entity;
> > +	struct media_entity *source_entity =3D &remote_subdev->entity;
> > +	int source_pad_index;
> > +	int ret;
> > +
> > +	/* Get the first remote source pad. */
> > +	ret =3D media_entity_get_fwnode_pad(source_entity, remote_subdev->fwn=
ode,
> > +					  MEDIA_PAD_FL_SOURCE);
> > +	if (ret < 0) {
> > +		dev_err(dev, "missing source pad in external entity %s\n",
> > +			source_entity->name);
> > +		return -EINVAL;
> > +	}
> > +
> > +	source_pad_index =3D ret;
> > +
> > +	dev_dbg(dev, "creating %s:%u -> %s:%u link\n", source_entity->name,
> > +		source_pad_index, sink_entity->name, sink_pad_index);
> > +
> > +	ret =3D media_create_pad_link(source_entity, source_pad_index,
> > +				    sink_entity, sink_pad_index,
> > +				    enabled ? MEDIA_LNK_FL_ENABLED : 0);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to create %s:%u -> %s:%u link\n",
> > +			source_entity->name, source_pad_index,
> > +			sink_entity->name, sink_pad_index);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +sun6i_csi_bridge_notifier_bound(struct v4l2_async_notifier *notifier,
> > +				struct v4l2_subdev *remote_subdev,
> > +				struct v4l2_async_subdev *async_subdev)
> > +{
> > +	struct sun6i_csi_device *csi_dev =3D
> > +		container_of(notifier, struct sun6i_csi_device,
> > +			     bridge.notifier);
> > +	struct sun6i_csi_bridge *bridge =3D &csi_dev->bridge;
> > +	struct sun6i_csi_bridge_source *source =3D NULL;
> > +	struct fwnode_handle *fwnode =3D dev_fwnode(csi_dev->dev);
> > +	struct fwnode_handle *handle =3D NULL;
> > +	bool enabled;
> > +	int ret;
> > +
> > +	while ((handle =3D fwnode_graph_get_next_endpoint(fwnode, handle))) {
>=20
> I'd instead store the information you need here in struct sun6i_csi_bridg=
e.
> You could remove the loop here.

Is there a different method for matching a remote subdev to a local port?
The rationale here is that I need the handle for fwnode_graph_parse_endpoint
but cannot get that handle from the remote subdev's fwnode pointer directly.

> > +		struct fwnode_endpoint endpoint =3D { 0 };
> > +		struct fwnode_handle *remote_fwnode;
> > +
> > +		remote_fwnode =3D fwnode_graph_get_remote_port_parent(handle);
> > +		if (!remote_fwnode)
> > +			continue;
> > +
> > +		if (remote_fwnode !=3D remote_subdev->fwnode)
> > +			goto next;
> > +
> > +		ret =3D fwnode_graph_parse_endpoint(handle, &endpoint);
> > +		if (ret < 0)
> > +			goto next;
> > +
> > +		switch (endpoint.port) {
> > +		case SUN6I_CSI_PORT_PARALLEL:
> > +			source =3D &bridge->source_parallel;
> > +			enabled =3D true;
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +
> > +next:
> > +		fwnode_handle_put(remote_fwnode);
> > +	}
> > +
> > +	if (!source)
> > +		return -EINVAL;
> > +
> > +	source->subdev =3D remote_subdev;
> > +
> > +	return sun6i_csi_bridge_link(csi_dev, SUN6I_CSI_BRIDGE_PAD_SINK,
> > +				     remote_subdev, enabled);
> > +}
> > +
> > +static int
> > +sun6i_csi_bridge_notifier_complete(struct v4l2_async_notifier *notifie=
r)
> > +{
> > +	struct sun6i_csi_device *csi_dev =3D
> > +		container_of(notifier, struct sun6i_csi_device,
> > +			     bridge.notifier);
> > +
> > +	return sun6i_csi_v4l2_complete(csi_dev);
>=20
> You could call v4l2_device_register_subdev_nodes() here.

That's definitely what sun6i_csi_v4l2_complete does (the diff is probably n=
ot
very clear). Note that the wrapper is extended later on to register the cap=
ture
video device for the no-isp path.

Maybe the capture registration could be kept in sun6i_csi_probe for the non=
-isp
path and then the wrapper wouldn't be needed. I don't mind either way.

> > +}
> > +
> > +static const struct v4l2_async_notifier_operations
> > +sun6i_csi_bridge_notifier_ops =3D {
> > +	.bound		=3D sun6i_csi_bridge_notifier_bound,
> > +	.complete	=3D sun6i_csi_bridge_notifier_complete,
> > +};
> > +
> > +/* Bridge */
> > +
> > +static int sun6i_csi_bridge_source_setup(struct sun6i_csi_device *csi_=
dev,
> > +					 struct sun6i_csi_bridge_source *source,
> > +					 u32 port,
> > +					 enum v4l2_mbus_type *bus_types)
> > +{
> > +	struct device *dev =3D csi_dev->dev;
> > +	struct v4l2_async_notifier *notifier =3D &csi_dev->bridge.notifier;
> > +	struct v4l2_fwnode_endpoint *endpoint =3D &source->endpoint;
> > +	struct v4l2_async_subdev *async_subdev;
> > +	struct fwnode_handle *handle;
> > +	int ret;
> > +
> > +	handle =3D fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), port, 0, =
0);
> > +	if (!handle)
> > +		return -ENODEV;
> > +
> > +	ret =3D v4l2_fwnode_endpoint_parse(handle, endpoint);
> > +	if (ret)
> > +		goto complete;
> > +
> > +	if (bus_types) {
> > +		bool valid =3D false;
> > +		unsigned int i;
> > +
> > +		for (i =3D 0; bus_types[i] !=3D V4L2_MBUS_INVALID; i++) {
> > +			if (endpoint->bus_type =3D=3D bus_types[i]) {
> > +				valid =3D true;
> > +				break;
> > +			}
> > +		}
> > +
> > +		if (!valid) {
> > +			dev_err(dev, "unsupported bus type for port %d\n",
> > +				port);
> > +			ret =3D -EINVAL;
> > +			goto complete;
> > +		}
> > +	}
> > +
> > +	async_subdev =3D v4l2_async_nf_add_fwnode_remote(notifier, handle,
> > +		struct v4l2_async_subdev);
> > +	if (IS_ERR(async_subdev)) {
> > +		ret =3D PTR_ERR(async_subdev);
> > +		goto complete;
> > +	}
> > +
> > +	source->expected =3D true;
> > +
> > +complete:
> > +	fwnode_handle_put(handle);
> > +
> > +	return ret;
> > +}
> > +
> > +int sun6i_csi_bridge_setup(struct sun6i_csi_device *csi_dev)
> > +{
> > +	struct device *dev =3D csi_dev->dev;
> > +	struct sun6i_csi_bridge *bridge =3D &csi_dev->bridge;
> > +	struct v4l2_device *v4l2_dev =3D &csi_dev->v4l2.v4l2_dev;
> > +	struct v4l2_subdev *subdev =3D &bridge->subdev;
> > +	struct v4l2_async_notifier *notifier =3D &bridge->notifier;
> > +	struct media_pad *pads =3D bridge->pads;
> > +	enum v4l2_mbus_type parallel_mbus_types[] =3D {
> > +		V4L2_MBUS_PARALLEL,
> > +		V4L2_MBUS_BT656,
> > +		V4L2_MBUS_INVALID
> > +	};
> > +	int ret;
> > +
> > +	/* V4L2 Subdev */
> > +
> > +	v4l2_subdev_init(subdev, &sun6i_csi_bridge_subdev_ops);
> > +	strscpy(subdev->name, SUN6I_CSI_BRIDGE_NAME, sizeof(subdev->name));
> > +	subdev->flags |=3D V4L2_SUBDEV_FL_HAS_DEVNODE;
> > +	subdev->owner =3D THIS_MODULE;
> > +	subdev->dev =3D dev;
> > +
> > +	v4l2_set_subdevdata(subdev, csi_dev);
> > +
> > +	/* Media Entity */
> > +
> > +	subdev->entity.function =3D MEDIA_ENT_F_VID_IF_BRIDGE;
> > +	subdev->entity.ops =3D &sun6i_csi_bridge_entity_ops;
> > +
> > +	/* Media Pads */
> > +
> > +	pads[SUN6I_CSI_BRIDGE_PAD_SINK].flags =3D MEDIA_PAD_FL_SINK;
> > +	pads[SUN6I_CSI_BRIDGE_PAD_SOURCE].flags =3D MEDIA_PAD_FL_SOURCE |
> > +						  MEDIA_PAD_FL_MUST_CONNECT;
> > +
> > +	ret =3D media_entity_pads_init(&subdev->entity,
> > +				     SUN6I_CSI_BRIDGE_PAD_COUNT, pads);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* V4L2 Subdev */
> > +
> > +	ret =3D v4l2_device_register_subdev(v4l2_dev, subdev);
> > +	if (ret) {
> > +		dev_err(dev, "failed to register v4l2 subdev: %d\n", ret);
> > +		goto error_media_entity;
> > +	}
> > +
> > +	/* V4L2 Async */
> > +
> > +	v4l2_async_nf_init(notifier);
> > +	notifier->ops =3D &sun6i_csi_bridge_notifier_ops;
> > +
> > +	sun6i_csi_bridge_source_setup(csi_dev, &bridge->source_parallel,
> > +				      SUN6I_CSI_PORT_PARALLEL,
> > +				      parallel_mbus_types);
> > +
> > +	ret =3D v4l2_async_nf_register(v4l2_dev, notifier);
> > +	if (ret) {
> > +		dev_err(dev, "failed to register v4l2 async notifier: %d\n",
> > +			ret);
> > +		goto error_v4l2_async_notifier;
> > +	}
> > +
> > +	return 0;
> > +
> > +error_v4l2_async_notifier:
> > +	v4l2_async_nf_cleanup(notifier);
> > +
> > +	v4l2_device_unregister_subdev(subdev);
> > +
> > +error_media_entity:
> > +	media_entity_cleanup(&subdev->entity);
> > +
> > +	return ret;
> > +}
> > +
> > +void sun6i_csi_bridge_cleanup(struct sun6i_csi_device *csi_dev)
> > +{
> > +	struct v4l2_subdev *subdev =3D &csi_dev->bridge.subdev;
> > +	struct v4l2_async_notifier *notifier =3D &csi_dev->bridge.notifier;
> > +
> > +	v4l2_async_nf_unregister(notifier);
> > +	v4l2_async_nf_cleanup(notifier);
> > +
> > +	v4l2_device_unregister_subdev(subdev);
> > +
> > +	media_entity_cleanup(&subdev->entity);
> > +}
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h =
b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
> > new file mode 100644
> > index 000000000000..2ee7878102b6
> > --- /dev/null
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
> > @@ -0,0 +1,44 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright 2021 Bootlin
>=20
> 2022?

Right, thanks!

> > + * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > + */
> > +
> > +#ifndef _SUN6I_CSI_BRIDGE_H_
> > +#define _SUN6I_CSI_BRIDGE_H_
> > +
> > +#include <media/v4l2-device.h>
> > +#include <media/v4l2-fwnode.h>
> > +
> > +#define SUN6I_CSI_BRIDGE_NAME	"sun6i-csi-bridge"
> > +
> > +enum sun6i_csi_bridge_pad {
> > +	SUN6I_CSI_BRIDGE_PAD_SINK	=3D 0,
> > +	SUN6I_CSI_BRIDGE_PAD_SOURCE	=3D 1,
> > +	SUN6I_CSI_BRIDGE_PAD_COUNT	=3D 2,
> > +};
> > +
> > +struct sun6i_csi_device;
> > +
> > +struct sun6i_csi_bridge_source {
> > +	struct v4l2_subdev		*subdev;
> > +	struct v4l2_fwnode_endpoint	endpoint;
> > +	bool				expected;
> > +};
> > +
> > +struct sun6i_csi_bridge {
> > +	struct v4l2_subdev		subdev;
> > +	struct v4l2_async_notifier	notifier;
> > +	struct media_pad		pads[2];
> > +	struct v4l2_mbus_framefmt	mbus_format;
> > +
> > +	struct sun6i_csi_bridge_source	source_parallel;
> > +	struct sun6i_csi_bridge_source	*source;
> > +};
> > +
> > +/* Bridge */
> > +
> > +int sun6i_csi_bridge_setup(struct sun6i_csi_device *csi_dev);
> > +void sun6i_csi_bridge_cleanup(struct sun6i_csi_device *csi_dev);
> > +
> > +#endif
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c b/dri=
vers/media/platform/sunxi/sun6i-csi/sun6i_video.c
> > index d32ff6b81f8a..fa5bf3697ace 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
> > @@ -632,6 +632,7 @@ int sun6i_video_setup(struct sun6i_csi_device *csi_=
dev)
> >  {
> >  	struct sun6i_video *video =3D &csi_dev->video;
> >  	struct v4l2_device *v4l2_dev =3D &csi_dev->v4l2.v4l2_dev;
> > +	struct v4l2_subdev *bridge_subdev =3D &csi_dev->bridge.subdev;
> >  	struct video_device *video_dev =3D &video->video_dev;
> >  	struct vb2_queue *queue =3D &video->queue;
> >  	struct media_pad *pad =3D &video->pad;
> > @@ -715,8 +716,26 @@ int sun6i_video_setup(struct sun6i_csi_device *csi=
_dev)
> >  	v4l2_info(v4l2_dev, "device %s registered as %s\n", video_dev->name,
> >  		  video_device_node_name(video_dev));
> > =20
> > +	/* Media Pad Link */
> > +
> > +	ret =3D media_create_pad_link(&bridge_subdev->entity,
> > +				    SUN6I_CSI_BRIDGE_PAD_SOURCE,
> > +				    &video_dev->entity, 0,
> > +				    MEDIA_LNK_FL_ENABLED |
> > +				    MEDIA_LNK_FL_IMMUTABLE);
> > +	if (ret < 0) {
> > +		v4l2_err(v4l2_dev, "failed to create %s:%u -> %s:%u link\n",
> > +			 bridge_subdev->entity.name,
> > +			 SUN6I_CSI_BRIDGE_PAD_SOURCE,
> > +			 video_dev->entity.name, 0);
> > +		goto error_video_device;
> > +	}
> > +
> >  	return 0;
> > =20
> > +error_video_device:
> > +	vb2_video_unregister_device(video_dev);
> > +
> >  error_media_entity:
> >  	media_entity_cleanup(&video_dev->entity);
> > =20
>=20
> --=20
> Sakari Ailus

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--iIlmZW4kMnsR7tZI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmIfhmYACgkQ3cLmz3+f
v9HQ8Qf/cy64XfFscFcXwVl8VCS8lRjeiD2nZyiOhL/vJB/onD6x3wxQll8UliVc
yLlu8N3p7csfRNwsiFUgIJxQ2rjNGcDUfOOaR9I4aEe7Tk6VSma6ZWH3zArukjVV
kqB47QW3lWrTRdWaKMR4anzb1GI3zrSzX0MgNyae/aHgBnx/2Qi2FitJTnnpMm3i
FVBbXMWKDgEdUeSqQ2xdBAvv421TqGG96nX29QYqfBRgwGRhcZc7/TH3O6Closq1
JofsDi9GGJOfdB+7HLnc7XtCYkc5nm2KFgN/OpIKCcdZSY77j5kI0ur0HMNDqvkJ
AiL2iGwZ+7Zb4rRkZX7vAJSrOqMVmw==
=FYfi
-----END PGP SIGNATURE-----

--iIlmZW4kMnsR7tZI--
