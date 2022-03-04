Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3B74CD099
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbiCDJBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbiCDJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:01:08 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A726B12B76C;
        Fri,  4 Mar 2022 01:00:19 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3EEEC1BF213;
        Fri,  4 Mar 2022 09:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646384418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MoznkUIec7VAQY3ImNmY3IHeuYJ/S05cBMHdD+Wm4Nc=;
        b=F9tvU0ozNsPeQ9lftznClBeZfJB6PRNXxUPQuKwyUpT+KlQKi1Nt6H6ki+H9T74PtC15GX
        mEICPAhXiahTCeW0RAjDqf9QHMqxP63CmickbbG9Wiyp9qId8qFcZGrK6aWmhmVw7/aGt2
        yLlqqcQDFBjV1yRkmHN+eaunAwYFhRpPb7msRMR/CGFHaJhhUappIX1EW+O1P7k1yliwnB
        M5V5bFFMXlCKDVfIyrkqNeKa0olTvBeJQCCkrxzrIJUMmqwnsXU1BEtxyIGQsumhssIw9L
        Zlau+iKBkap+qVKAuIzvu4o1YBw/r/7qV5t3A4pr5bmRcw1uqeMrjAN3qNgwTQ==
Date:   Fri, 4 Mar 2022 10:00:12 +0100
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
Message-ID: <YiHVHM53GUQ1jxco@aptenodytes>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-31-paul.kocialkowski@bootlin.com>
 <YgqbqVRinNxQ8+WV@paasikivi.fi.intel.com>
 <Yh+GZv9/rKQ2WbI2@aptenodytes>
 <YiFEq1liAnBy0fkq@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dwUOJP15b315kF0b"
Content-Disposition: inline
In-Reply-To: <YiFEq1liAnBy0fkq@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dwUOJP15b315kF0b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Fri 04 Mar 22, 00:43, Sakari Ailus wrote:
> Hi Paul,
>=20
> On Wed, Mar 02, 2022 at 03:59:50PM +0100, Paul Kocialkowski wrote:
> > > > +static int
> > > > +sun6i_csi_bridge_notifier_bound(struct v4l2_async_notifier *notifi=
er,
> > > > +				struct v4l2_subdev *remote_subdev,
> > > > +				struct v4l2_async_subdev *async_subdev)
> > > > +{
> > > > +	struct sun6i_csi_device *csi_dev =3D
> > > > +		container_of(notifier, struct sun6i_csi_device,
> > > > +			     bridge.notifier);
> > > > +	struct sun6i_csi_bridge *bridge =3D &csi_dev->bridge;
> > > > +	struct sun6i_csi_bridge_source *source =3D NULL;
> > > > +	struct fwnode_handle *fwnode =3D dev_fwnode(csi_dev->dev);
> > > > +	struct fwnode_handle *handle =3D NULL;
> > > > +	bool enabled;
> > > > +	int ret;
> > > > +
> > > > +	while ((handle =3D fwnode_graph_get_next_endpoint(fwnode, handle)=
)) {
> > >=20
> > > I'd instead store the information you need here in struct sun6i_csi_b=
ridge.
> > > You could remove the loop here.
> >=20
> > Is there a different method for matching a remote subdev to a local por=
t?
> > The rationale here is that I need the handle for fwnode_graph_parse_end=
point
> > but cannot get that handle from the remote subdev's fwnode pointer dire=
ctly.
>=20
> You generally shouldn't try to match fwnodes here as the V4L2 async
> framework has already done that job. This information can be found behind
> the async_subdev pointer.
>=20
> See e.g. drivers/media/pci/intel/ipu3/ipu3-cio2-main.c for an example.

Thanks for the feedback, I'll look into that.

> >=20
> > > > +		struct fwnode_endpoint endpoint =3D { 0 };
> > > > +		struct fwnode_handle *remote_fwnode;
> > > > +
> > > > +		remote_fwnode =3D fwnode_graph_get_remote_port_parent(handle);
> > > > +		if (!remote_fwnode)
> > > > +			continue;
> > > > +
> > > > +		if (remote_fwnode !=3D remote_subdev->fwnode)
> > > > +			goto next;
> > > > +
> > > > +		ret =3D fwnode_graph_parse_endpoint(handle, &endpoint);
> > > > +		if (ret < 0)
> > > > +			goto next;
> > > > +
> > > > +		switch (endpoint.port) {
> > > > +		case SUN6I_CSI_PORT_PARALLEL:
> > > > +			source =3D &bridge->source_parallel;
> > > > +			enabled =3D true;
> > > > +			break;
> > > > +		default:
> > > > +			break;
> > > > +		}
> > > > +
> > > > +next:
> > > > +		fwnode_handle_put(remote_fwnode);
> > > > +	}
> > > > +
> > > > +	if (!source)
> > > > +		return -EINVAL;
> > > > +
> > > > +	source->subdev =3D remote_subdev;
> > > > +
> > > > +	return sun6i_csi_bridge_link(csi_dev, SUN6I_CSI_BRIDGE_PAD_SINK,
> > > > +				     remote_subdev, enabled);
> > > > +}
> > > > +
> > > > +static int
> > > > +sun6i_csi_bridge_notifier_complete(struct v4l2_async_notifier *not=
ifier)
> > > > +{
> > > > +	struct sun6i_csi_device *csi_dev =3D
> > > > +		container_of(notifier, struct sun6i_csi_device,
> > > > +			     bridge.notifier);
> > > > +
> > > > +	return sun6i_csi_v4l2_complete(csi_dev);
> > >=20
> > > You could call v4l2_device_register_subdev_nodes() here.
> >=20
> > That's definitely what sun6i_csi_v4l2_complete does (the diff is probab=
ly not
> > very clear). Note that the wrapper is extended later on to register the=
 capture
> > video device for the no-isp path.
>=20
> I could be missing something... Do you need to call
> sun6i_csi_v4l2_complete() in multiple places or not? If not, then I think
> it'd be probably better to just move the code here.

No this is only called here so I guess we can avoid it entirely.

Thanks,

Paul

> >=20
> > Maybe the capture registration could be kept in sun6i_csi_probe for the=
 non-isp
> > path and then the wrapper wouldn't be needed. I don't mind either way.
>=20
> --=20
> Kind regards,
>=20
> Sakari Ailus

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--dwUOJP15b315kF0b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmIh1RwACgkQ3cLmz3+f
v9Ha5Qf+Lz13XAEQwduMjvaJ3V4PK+23t0taf6Fv0+Peh5fnTfFagFYbMtBdFsbo
q/6i5Zt3JaRdXe+5SixAINP00cflNxpxuAN+MRbjP4wfaRBxNRGqhIGjXWzJYLZe
jn4lX8W49l8iafyCstJ5jhccMEn/LSo1mO3pAyjc3pMXK+6HabgMe5UEETWvm5n3
XX1j/KBu1PtgQUNKbBxKGpGVmlmBjMEfM+DIx19h70AeeG7OW4wUq37IJ5i6AiuX
Q7da7pWZMzdesWbjon3l5X5rPbfimGXqNLJYUa86zFBrk/nO+10HhU1udx4du5AW
4e/50RP2kNoRQ9bvpvarQtS8gN0BGg==
=Nf6c
-----END PGP SIGNATURE-----

--dwUOJP15b315kF0b--
