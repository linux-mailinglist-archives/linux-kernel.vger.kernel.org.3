Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E426D4C8F83
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiCAP7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiCAP7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:59:39 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957296145;
        Tue,  1 Mar 2022 07:58:55 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B7AAA20000E;
        Tue,  1 Mar 2022 15:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646150333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p1HaABgS+y/Gfst5xbNMwu8EcDjttBMdhpgl96eHGRE=;
        b=mHTC1Y9/6NFvBqVq+c4md0DDZ5QMZXHvL/3M4g+DF9wz7peCsLrR8kNNZh7O3gwGc+phhS
        NIwBzWPE5kUwQuNa0bchxp55FZbws1L5Xy9eWQ0uFrPpj5yW7tXGx64xsKLUU9p21RrFk3
        wbkX554Dg1I8K6G7XOM2iSu4tbqb4uFn07Sy2rz8hlFRdYiXHO/xyvG0P8x8qAxG9pFw09
        MeyJMaDwc+v5uMiIrKvEbfQ15i8ixIVXEwueRyo2kwp/ze0Oo7c+S1GjBQ4o1gHDsN7fF3
        mo3cu7Hgavwy4j7ZZPn6031crTUmXFH/Nlw7J+/M2cWQLC9b6iGi4b2qHa7n5A==
Date:   Tue, 1 Mar 2022 16:58:51 +0100
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
Message-ID: <Yh5CuyEJ+WhIAzYm@aptenodytes>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-64-paul.kocialkowski@bootlin.com>
 <YgFFxMd2htKvX0K1@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rv9snxutxHS4sJyL"
Content-Disposition: inline
In-Reply-To: <YgFFxMd2htKvX0K1@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rv9snxutxHS4sJyL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Mon 07 Feb 22, 18:16, Laurent Pinchart wrote:
> Hi Paul,
>=20
> Thank you for the patch.
>=20
> On Sat, Feb 05, 2022 at 07:54:26PM +0100, Paul Kocialkowski wrote:
> > Some Allwinner platforms come with an Image Signal Processor, which
> > supports various features in order to enhance and transform data
> > received by image sensors into good-looking pictures. In most cases,
> > the data is raw bayer, which gets internally converted to RGB and
> > finally YUV, which is what the hardware produces.
> >=20
> > This driver supports ISPs that are similar to the A31 ISP, which was
> > the first standalone ISP found in Allwinner platforms. Simpler ISP
> > blocks were found in the A10 and A20, where they are tied to a CSI
> > controller. Newer generations of Allwinner SoCs (starting with the
> > H6, H616, etc) come with a new camera subsystem and revised ISP.
> > Even though these previous and next-generation ISPs are somewhat
> > similar to the A31 ISP, they have enough significant differences to
> > be out of the scope of this driver.
> >=20
> > While the ISP supports many features, including 3A and many
> > enhancement blocks, this implementation is limited to the following:
> > - V3s (V3/S3) platform support;
> > - Bayer media bus formats as input;
>=20
> Greyscale formats would also be nice to have, if the hardware can
> support that (it mostly just requires the ability to disable the CFA
> interpolation).

As far as I know there's no support for grayscale, only bayer formats
and YUV.

> > - Semi-planar YUV (NV12/NV21) as output;
>=20
> Packed YUV would also be useful if the hardware supports it.

Same here, it only supports planar and semi-planar YUV as output.

> > - Debayering with per-component gain and offset configuration;
> > - 2D noise filtering with configurable coefficients.
> >=20
> > Since many features are missing from the associated uAPI, the driver
> > is aimed to integrate staging until all features are properly
> > described.
> >=20
> > On the technical side, it uses the v4l2 and media controller APIs,
> > with a video node for capture, a processor subdev and a video node
> > for parameters submission. A specific uAPI structure and associated
> > v4l2 meta format are used to configure parameters of the supported
> > modules.
> >=20
> > One particular thing about the hardware is that configuration for
> > module registers needs to be stored in a DMA buffer and gets copied
> > to actual registers by the hardware at the next vsync, when instructed
> > by a flag. This is handled by the "state" mechanism in the driver.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/staging/media/sunxi/Kconfig           |   1 +
> >  drivers/staging/media/sunxi/Makefile          |   1 +
> >  drivers/staging/media/sunxi/sun6i-isp/Kconfig |  13 +
> >  .../staging/media/sunxi/sun6i-isp/Makefile    |   4 +
> >  .../staging/media/sunxi/sun6i-isp/sun6i_isp.c | 572 +++++++++++++
> >  .../staging/media/sunxi/sun6i-isp/sun6i_isp.h |  86 ++
> >  .../media/sunxi/sun6i-isp/sun6i_isp_capture.c | 751 ++++++++++++++++++
> >  .../media/sunxi/sun6i-isp/sun6i_isp_capture.h |  78 ++
> >  .../media/sunxi/sun6i-isp/sun6i_isp_params.c  | 573 +++++++++++++
> >  .../media/sunxi/sun6i-isp/sun6i_isp_params.h  |  52 ++
> >  .../media/sunxi/sun6i-isp/sun6i_isp_proc.c    | 599 ++++++++++++++
> >  .../media/sunxi/sun6i-isp/sun6i_isp_proc.h    |  61 ++
> >  .../media/sunxi/sun6i-isp/sun6i_isp_reg.h     | 275 +++++++
> >  .../sunxi/sun6i-isp/uapi/sun6i-isp-config.h   |  43 +
>=20
> Could you add a TODO file to list the issues that need to be fixed for
> the driver to move out of staging ? I'll already propose one entry:
>=20
> - Add support in libcamera

Maybe it would be good to narrow down what level of support you have in mind
here. Just adding basic support fort the pipeline is probably doable, but
developing complex 3A algorithms would require very significant effort and
it would be a shame that this prevents the driver from leaving staging.

I think another obvious task would be to have a complete uAPI that reflects
all modules that are part of the ISP.

What do you think?

Paul

> This isn't required to merge the driver in staging as long as ABI
> compatibility doesn't need to be preserved until the driver is moved out
> of staging.
>
> >  14 files changed, 3109 insertions(+)
> >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/Kconfig
> >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/Makefile
> >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c
> >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.h
> >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_cap=
ture.c
> >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_cap=
ture.h
> >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_par=
ams.c
> >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_par=
ams.h
> >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_pro=
c.c
> >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_pro=
c.h
> >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_reg=
=2Eh
> >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/uapi/sun6i-is=
p-config.h
>=20
> [snip]
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--rv9snxutxHS4sJyL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmIeQrsACgkQ3cLmz3+f
v9H2jgf+N/b7OZxk/ZZM3hYobj15RrI+x8TKse6MSXRy36uwvb7ncA6XvvbKn78m
fvLBGg4D0y3s7WHU+sMiBYWmHyfp8CUCuMmsK4pP0hL97ATEn+tQJDgYVEbKpyYi
fsYNYk2f42wsKG/++VqBImcqWNlGKSwVjOIPL+0Tp/PacAjZrQKKQiMj8Ual9zLX
JdQPMAORdCKsedX6imko0+rCgb7y2lOHslREnI0q+H5doa3XENq6r0bhDlmkjruK
9OuvzL/JJfaSwqA8Wd6LzoxC/mQq4Tw5DHnotsk1z5rfbDN0/v7IvTh6s16Fq0Ws
3giosRl9b6nSW2QSxGILv98e7i6WbQ==
=TKnA
-----END PGP SIGNATURE-----

--rv9snxutxHS4sJyL--
