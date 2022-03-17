Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA6B4DCB52
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbiCQQ0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbiCQQ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:26:53 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A021CF4A3;
        Thu, 17 Mar 2022 09:25:34 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 022D71C000F;
        Thu, 17 Mar 2022 16:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647534333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ALLei3Iid7g2f1Vlipcd3o4ARbpYuWc1mA/FuF55Vc8=;
        b=k9f2Sl/YQbbeQF2+xpKVWjRLn+R21VdIU6zkCahjTpxNn0SWaJien4auiqVQBavL9Qm+E7
        eprs5GO1ca5uE+oIgeltqYtcB83uVuDX8DtdW+WQY4cXY7plXWp9owt+qOlx/AbKnkNUWj
        1ocrN2PvfVeGSjNYZoPphiLcKjwcp9cTI+QfuW56iHcjvde17Ph83Hw6JngXQjMkXUPG+4
        T+TZbml6cUtyYqEEYExF6T98cRR/bmNV+UZ8qy3moYP7czZzwQ0uBMhVlMzVzCOmJh4th4
        2KGYIaiIilZoAOtv/Of545k1tyQm/1SE7x+DLL6G1LfbmJ3/iL21LoML05pu5Q==
Date:   Thu, 17 Mar 2022 17:25:29 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 5/9] media: sunxi: Add support for the A31 MIPI CSI-2
 controller
Message-ID: <YjNg+T+J1YkOm9LE@aptenodytes>
References: <20220302220739.144303-1-paul.kocialkowski@bootlin.com>
 <20220302220739.144303-6-paul.kocialkowski@bootlin.com>
 <YjHluwVnbPyHo1kp@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bi/43uRme1u2xO1q"
Content-Disposition: inline
In-Reply-To: <YjHluwVnbPyHo1kp@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bi/43uRme1u2xO1q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Wed 16 Mar 22, 15:27, Sakari Ailus wrote:
> Hi Paul,
>=20
> Thanks for the set.
>=20
> On Wed, Mar 02, 2022 at 11:07:35PM +0100, Paul Kocialkowski wrote:
> ...
> > +static int sun6i_mipi_csi2_s_stream(struct v4l2_subdev *subdev, int on)
> > +{
> > +	struct sun6i_mipi_csi2_device *csi2_dev =3D v4l2_get_subdevdata(subde=
v);
> > +	struct v4l2_subdev *source_subdev =3D csi2_dev->bridge.source_subdev;
> > +	union phy_configure_opts dphy_opts =3D { 0 };
> > +	struct phy_configure_opts_mipi_dphy *dphy_cfg =3D &dphy_opts.mipi_dph=
y;
> > +	struct v4l2_mbus_framefmt *mbus_format =3D &csi2_dev->bridge.mbus_for=
mat;
> > +	const struct sun6i_mipi_csi2_format *format;
> > +	struct phy *dphy =3D csi2_dev->dphy;
> > +	struct device *dev =3D csi2_dev->dev;
> > +	struct v4l2_ctrl *ctrl;
> > +	unsigned int lanes_count =3D
> > +		csi2_dev->bridge.endpoint.bus.mipi_csi2.num_data_lanes;
> > +	unsigned long pixel_rate;
> > +	/* Initialize to 0 to use both in disable label (ret !=3D 0) and off.=
 */
> > +	int ret =3D 0;
> > +
> > +	if (!source_subdev)
> > +		return -ENODEV;
> > +
> > +	if (!on) {
> > +		v4l2_subdev_call(source_subdev, video, s_stream, 0);
> > +		goto disable;
> > +	}
> > +
> > +	/* Runtime PM */
> > +
> > +	ret =3D pm_runtime_resume_and_get(dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Sensor Pixel Rate */
> > +
> > +	ctrl =3D v4l2_ctrl_find(source_subdev->ctrl_handler, V4L2_CID_PIXEL_R=
ATE);
> > +	if (!ctrl) {
> > +		dev_err(dev, "missing sensor pixel rate\n");
> > +		ret =3D -ENODEV;
> > +		goto error_pm;
> > +	}
> > +
> > +	pixel_rate =3D (unsigned long)v4l2_ctrl_g_ctrl_int64(ctrl);
> > +	if (!pixel_rate) {
> > +		dev_err(dev, "missing (zero) sensor pixel rate\n");
> > +		ret =3D -ENODEV;
> > +		goto error_pm;
> > +	}
> > +
> > +	/* D-PHY */
> > +
> > +	if (!lanes_count) {
>=20
> I first thought this check could be moved to the beginning, but it's also
> redundant. v4l2_fwnode_endpoint_parse() will check the configuration is
> valid, i.e. the number of lanes is not zero.

Good to know, thanks!

> But should you add checks to make sure the hardware supports what has been
> configured? I'd do that right after parsing the endpoint.

I guess you mean checking that we don't get more than 4 lanes?
And maybe something related to lane ordering too?

> And you only seem to be using the number of data lanes, nothing more. So
> I'd store that, instead of the entire parsed v4l2_fwnode_endpoint.

That's correct, why not.

> The same applies to patch 8.
>=20
> I think these could be done on top of this set after it is merged. Up to
> you.

I'll go for another iteration.

Thanks!

Paul

> ...
>=20
> > +static int
> > +sun6i_mipi_csi2_bridge_source_setup(struct sun6i_mipi_csi2_device *csi=
2_dev)
> > +{
> > +	struct v4l2_async_notifier *notifier =3D &csi2_dev->bridge.notifier;
> > +	struct v4l2_fwnode_endpoint *endpoint =3D &csi2_dev->bridge.endpoint;
> > +	struct v4l2_async_subdev *subdev_async;
> > +	struct fwnode_handle *handle;
> > +	struct device *dev =3D csi2_dev->dev;
> > +	int ret;
> > +
> > +	handle =3D fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), 0, 0,
> > +						 FWNODE_GRAPH_ENDPOINT_NEXT);
> > +	if (!handle)
> > +		return -ENODEV;
> > +
> > +	endpoint->bus_type =3D V4L2_MBUS_CSI2_DPHY;
> > +
> > +	ret =3D v4l2_fwnode_endpoint_parse(handle, endpoint);
> > +	if (ret)
> > +		goto complete;
> > +
> > +	subdev_async =3D v4l2_async_nf_add_fwnode_remote(notifier, handle,
> > +		struct v4l2_async_subdev);
> > +	if (IS_ERR(subdev_async))
> > +		ret =3D PTR_ERR(subdev_async);
> > +
> > +complete:
> > +	fwnode_handle_put(handle);
> > +
> > +	return ret;
> > +}
>=20
> --=20
> Kind regards,
>=20
> Sakari Ailus

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--bi/43uRme1u2xO1q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmIzYPkACgkQ3cLmz3+f
v9FKsQf/REx8HWGAsHL4EqjK6NNY4P9j3krw6UROSlwsH6bZY5rQyi+CvqZgK3/P
yD7lqlJLu0Ejaifq6TFv/2G5trwxpR9CMdUS4XDGLKMNpQwFQihPIKN9GeZaB9GJ
xEWMgbnwMd+j7ip9XOPtQNNLMmEiuGEJe1cNgWNOlY6srAvLgJ9oe6ceUhEJoGWa
OZhAZ7ZUYNY0QAxZ343P3W9cIvGEOJEDGXEz29BUlNH3XKvzFyw6esG7CI606aE0
HoNlm/6r3uPwvjcmTu8TmX/bAFInySEN+KED2AQEFJfNnX3OQSLgwz+nM857wva7
0iXY8fnh8ItjVpkNOGg8hZ066dzSCg==
=1gfj
-----END PGP SIGNATURE-----

--bi/43uRme1u2xO1q--
