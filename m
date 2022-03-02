Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2B84CA5DC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242174AbiCBNYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242152AbiCBNY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:24:28 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1109140AD;
        Wed,  2 Mar 2022 05:23:43 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2772BE000B;
        Wed,  2 Mar 2022 13:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646227422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3lWTG0gcGGbb63Q514N2waqyjTzAQQv9mi2bl0IjFZU=;
        b=D6ASxIIXcd7UuceF+qoJdzdfOmYnKNQ7frw3t21QBWafjG5DUfUkq+Wzaig6BAFhIo9v5p
        CeB7J7lUWrcBidvO1oRCgNSbjXJzk5QkSQaPDnRhLop/9uf/rSGBWB6cj3skn644PYKCMW
        /vOa1tokbeD9ijeuAgPKF4bch6zFZdW3qhR7WmylDGWvKT9X9Iwc6Gguy2Zb1ybHFjyjWT
        JJjL2EjyQ5Vr+F5jEKByXnD6u3Wajg+LC9eVip0a8IUfZGgzw/8HWaFrALduJWc5elfpqZ
        ra8BdH8YMw5pz5iiAREfbGKR3kjRp25U63MjAPK3z0P942qaExkcUtAhMoqpcQ==
Date:   Wed, 2 Mar 2022 14:23:37 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 63/66] staging: media: Add support for the Allwinner
 A31 ISP
Message-ID: <Yh9v2Tez3x6rwhB3@aptenodytes>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-64-paul.kocialkowski@bootlin.com>
 <YgFFxMd2htKvX0K1@pendragon.ideasonboard.com>
 <Yh5CuyEJ+WhIAzYm@aptenodytes>
 <Yh8wD8lF2Hs+cxD7@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="K5/ovBA9OpV1w3Z2"
Content-Disposition: inline
In-Reply-To: <Yh8wD8lF2Hs+cxD7@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K5/ovBA9OpV1w3Z2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Wed 02 Mar 22, 10:51, Laurent Pinchart wrote:
> Hi Paul,
>=20
> On Tue, Mar 01, 2022 at 04:58:51PM +0100, Paul Kocialkowski wrote:
> > On Mon 07 Feb 22, 18:16, Laurent Pinchart wrote:
> > > On Sat, Feb 05, 2022 at 07:54:26PM +0100, Paul Kocialkowski wrote:
> > > > Some Allwinner platforms come with an Image Signal Processor, which
> > > > supports various features in order to enhance and transform data
> > > > received by image sensors into good-looking pictures. In most cases,
> > > > the data is raw bayer, which gets internally converted to RGB and
> > > > finally YUV, which is what the hardware produces.
> > > >=20
> > > > This driver supports ISPs that are similar to the A31 ISP, which was
> > > > the first standalone ISP found in Allwinner platforms. Simpler ISP
> > > > blocks were found in the A10 and A20, where they are tied to a CSI
> > > > controller. Newer generations of Allwinner SoCs (starting with the
> > > > H6, H616, etc) come with a new camera subsystem and revised ISP.
> > > > Even though these previous and next-generation ISPs are somewhat
> > > > similar to the A31 ISP, they have enough significant differences to
> > > > be out of the scope of this driver.
> > > >=20
> > > > While the ISP supports many features, including 3A and many
> > > > enhancement blocks, this implementation is limited to the following:
> > > > - V3s (V3/S3) platform support;
> > > > - Bayer media bus formats as input;
> > >=20
> > > Greyscale formats would also be nice to have, if the hardware can
> > > support that (it mostly just requires the ability to disable the CFA
> > > interpolation).
> >=20
> > As far as I know there's no support for grayscale, only bayer formats
> > and YUV.
> >=20
> > > > - Semi-planar YUV (NV12/NV21) as output;
> > >=20
> > > Packed YUV would also be useful if the hardware supports it.
> >=20
> > Same here, it only supports planar and semi-planar YUV as output.
> >=20
> > > > - Debayering with per-component gain and offset configuration;
> > > > - 2D noise filtering with configurable coefficients.
> > > >=20
> > > > Since many features are missing from the associated uAPI, the driver
> > > > is aimed to integrate staging until all features are properly
> > > > described.
> > > >=20
> > > > On the technical side, it uses the v4l2 and media controller APIs,
> > > > with a video node for capture, a processor subdev and a video node
> > > > for parameters submission. A specific uAPI structure and associated
> > > > v4l2 meta format are used to configure parameters of the supported
> > > > modules.
> > > >=20
> > > > One particular thing about the hardware is that configuration for
> > > > module registers needs to be stored in a DMA buffer and gets copied
> > > > to actual registers by the hardware at the next vsync, when instruc=
ted
> > > > by a flag. This is handled by the "state" mechanism in the driver.
> > > >=20
> > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > ---
> > > >  drivers/staging/media/sunxi/Kconfig           |   1 +
> > > >  drivers/staging/media/sunxi/Makefile          |   1 +
> > > >  drivers/staging/media/sunxi/sun6i-isp/Kconfig |  13 +
> > > >  .../staging/media/sunxi/sun6i-isp/Makefile    |   4 +
> > > >  .../staging/media/sunxi/sun6i-isp/sun6i_isp.c | 572 +++++++++++++
> > > >  .../staging/media/sunxi/sun6i-isp/sun6i_isp.h |  86 ++
> > > >  .../media/sunxi/sun6i-isp/sun6i_isp_capture.c | 751 ++++++++++++++=
++++
> > > >  .../media/sunxi/sun6i-isp/sun6i_isp_capture.h |  78 ++
> > > >  .../media/sunxi/sun6i-isp/sun6i_isp_params.c  | 573 +++++++++++++
> > > >  .../media/sunxi/sun6i-isp/sun6i_isp_params.h  |  52 ++
> > > >  .../media/sunxi/sun6i-isp/sun6i_isp_proc.c    | 599 ++++++++++++++
> > > >  .../media/sunxi/sun6i-isp/sun6i_isp_proc.h    |  61 ++
> > > >  .../media/sunxi/sun6i-isp/sun6i_isp_reg.h     | 275 +++++++
> > > >  .../sunxi/sun6i-isp/uapi/sun6i-isp-config.h   |  43 +
> > >=20
> > > Could you add a TODO file to list the issues that need to be fixed for
> > > the driver to move out of staging ? I'll already propose one entry:
> > >=20
> > > - Add support in libcamera
> >=20
> > Maybe it would be good to narrow down what level of support you have in=
 mind
> > here. Just adding basic support fort the pipeline is probably doable, b=
ut
> > developing complex 3A algorithms would require very significant effort =
and
> > it would be a shame that this prevents the driver from leaving staging.
> >=20
> > I think another obvious task would be to have a complete uAPI that refl=
ects
> > all modules that are part of the ISP.
> >=20
> > What do you think?
>=20
> The reason why I'd like to see libcamera support for the ISP driver is
> to ensure that the kernel API is adequate for real use cases. The API
> can be split in three parts:
>=20
> - Pipeline configuration (this includes the media controller topology,
>   link setting, subdev pad format/selection rectangle configuration,
>   ...)
> - ISP parameters
> - ISP statistics
>=20
> A pipeline handler implementation will cover the first parts. The second
> and third parts need to be tested too, but we don't need to implement
> every single feature. A very simple algorithm that demonstrates
> statistics can be captured and ISP parameters can be set should be
> enough to test and exercise the API in real scenarios. We're working on
> making basic AE and AWB algorithm implementations generic (or at least
> creating generic building blocks that can easily be assembled to create
> those algorithms, as the ISP statistics and parameters are specific to
> the ISP and thus require some ISP-specific code), so that should become
> a fairly easy task soon. I expect most of the work to go in the pipeline
> handler.
>=20
> Does this sound fair to you ?

Yes I understand that these aspects need to be tested too, but I feel like
having an implementation with a feedback look (even rudimentary and using
some generic helpers) would be quite a stretch.

It would probably be sufficient to have some demo code that can receive sta=
ts
and set parameters, but without necessarily any connection between the two.
As such it's also my feeling that a standalone demo program could be easier
to manage for that purpose than libcamera support.

So how about making the requirement that a (free software) userspace
implementration must demonstrate ability to read relevant statistics
=66rom the ISP and (independently) control parameters that affect the outpu=
t?

Paul

> > > This isn't required to merge the driver in staging as long as ABI
> > > compatibility doesn't need to be preserved until the driver is moved =
out
> > > of staging.
> > >
> > > >  14 files changed, 3109 insertions(+)
> > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/Kconfig
> > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/Makefile
> > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp=
=2Ec
> > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp=
=2Eh
> > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp=
_capture.c
> > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp=
_capture.h
> > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp=
_params.c
> > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp=
_params.h
> > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp=
_proc.c
> > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp=
_proc.h
> > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp=
_reg.h
> > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/uapi/sun6=
i-isp-config.h
> > >=20
> > > [snip]
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--K5/ovBA9OpV1w3Z2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmIfb9kACgkQ3cLmz3+f
v9HLxgf7BVSjJJaoUtt14ZCC2KEHslFkkaoYKWqbTuYs7HZKbshhkU08H1x98kan
j6GLaOTw7UDo8sGQPXTfJzmNnOH/nN4mGMjn+C8L5TfRHZ3IKk+JHjBpDXSPJzAN
Du4q7ZZumbRtI1thugIkLiqere3R2XWQiR3EdtrwfphlAfFsZYWD4TvZyp3F1keQ
x+rPg016fDfxqrgDrIVub5jLqxp4oTkqf7iyZxotB1mLEI/jwUsZEGSzT6i2dV1H
nl5PKhXlzFcH5MpquyNEaOH6GQXej6Z4CzVo/YQP8wsA/EzcOpKqPXyaJ0BTuGYt
Kj1aXtVJx9oiqB+RsZ4vOMg1Q5QffA==
=W9up
-----END PGP SIGNATURE-----

--K5/ovBA9OpV1w3Z2--
