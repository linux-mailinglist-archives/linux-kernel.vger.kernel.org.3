Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8214CA8CF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243382AbiCBPLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiCBPLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:11:33 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA2176E01;
        Wed,  2 Mar 2022 07:10:48 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9DB87E000A;
        Wed,  2 Mar 2022 15:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646233847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X4UckDZjY5c9bYF9BGPzmjMQ+toTh1ACFiggernYIBg=;
        b=dyvrQGgydHYeOU0sUI9zPO2LqaQ4maTSmXLvKLLnNbwrXW0t3Uwit++FbQHyoJfHpVyalI
        3mKpClhjJgxQSss9rC+YqeGjO4kH1TKWdEFkSs8i1MnIXJh9Im+ktTaBK0ahP3UXCXdupy
        uF883nXhHuK1Aza8aJa3Sl0tyicsWFJVLnncyY84XLGYUYoCi0CteplayToNT9K25h6eF/
        6Z7VpgifFauimix6WKTQ0etb32PcgDrIZ7ANhonxsNjPmps+g0bztjtTHvz7xpK5XYXmN1
        rtHGsVh+9JQNaMoUrNGyJy48sSoqcB4vpZNx6Aab9I8xubL5saLqfcyitNUmCA==
Date:   Wed, 2 Mar 2022 16:10:44 +0100
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
Message-ID: <Yh+I9Gsz/mQt9791@aptenodytes>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-64-paul.kocialkowski@bootlin.com>
 <YgFFxMd2htKvX0K1@pendragon.ideasonboard.com>
 <Yh5CuyEJ+WhIAzYm@aptenodytes>
 <Yh8wD8lF2Hs+cxD7@pendragon.ideasonboard.com>
 <Yh9v2Tez3x6rwhB3@aptenodytes>
 <Yh9yMYTJly5oDroa@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tuUbZtcT2/vID5n5"
Content-Disposition: inline
In-Reply-To: <Yh9yMYTJly5oDroa@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tuUbZtcT2/vID5n5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Wed 02 Mar 22, 15:33, Laurent Pinchart wrote:
> Hi Paul,
>=20
> On Wed, Mar 02, 2022 at 02:23:37PM +0100, Paul Kocialkowski wrote:
> > On Wed 02 Mar 22, 10:51, Laurent Pinchart wrote:
> > > On Tue, Mar 01, 2022 at 04:58:51PM +0100, Paul Kocialkowski wrote:
> > > > On Mon 07 Feb 22, 18:16, Laurent Pinchart wrote:
> > > > > On Sat, Feb 05, 2022 at 07:54:26PM +0100, Paul Kocialkowski wrote:
> > > > > > Some Allwinner platforms come with an Image Signal Processor, w=
hich
> > > > > > supports various features in order to enhance and transform data
> > > > > > received by image sensors into good-looking pictures. In most c=
ases,
> > > > > > the data is raw bayer, which gets internally converted to RGB a=
nd
> > > > > > finally YUV, which is what the hardware produces.
> > > > > >=20
> > > > > > This driver supports ISPs that are similar to the A31 ISP, whic=
h was
> > > > > > the first standalone ISP found in Allwinner platforms. Simpler =
ISP
> > > > > > blocks were found in the A10 and A20, where they are tied to a =
CSI
> > > > > > controller. Newer generations of Allwinner SoCs (starting with =
the
> > > > > > H6, H616, etc) come with a new camera subsystem and revised ISP.
> > > > > > Even though these previous and next-generation ISPs are somewhat
> > > > > > similar to the A31 ISP, they have enough significant difference=
s to
> > > > > > be out of the scope of this driver.
> > > > > >=20
> > > > > > While the ISP supports many features, including 3A and many
> > > > > > enhancement blocks, this implementation is limited to the follo=
wing:
> > > > > > - V3s (V3/S3) platform support;
> > > > > > - Bayer media bus formats as input;
> > > > >=20
> > > > > Greyscale formats would also be nice to have, if the hardware can
> > > > > support that (it mostly just requires the ability to disable the =
CFA
> > > > > interpolation).
> > > >=20
> > > > As far as I know there's no support for grayscale, only bayer forma=
ts
> > > > and YUV.
> > > >=20
> > > > > > - Semi-planar YUV (NV12/NV21) as output;
> > > > >=20
> > > > > Packed YUV would also be useful if the hardware supports it.
> > > >=20
> > > > Same here, it only supports planar and semi-planar YUV as output.
> > > >=20
> > > > > > - Debayering with per-component gain and offset configuration;
> > > > > > - 2D noise filtering with configurable coefficients.
> > > > > >=20
> > > > > > Since many features are missing from the associated uAPI, the d=
river
> > > > > > is aimed to integrate staging until all features are properly
> > > > > > described.
> > > > > >=20
> > > > > > On the technical side, it uses the v4l2 and media controller AP=
Is,
> > > > > > with a video node for capture, a processor subdev and a video n=
ode
> > > > > > for parameters submission. A specific uAPI structure and associ=
ated
> > > > > > v4l2 meta format are used to configure parameters of the suppor=
ted
> > > > > > modules.
> > > > > >=20
> > > > > > One particular thing about the hardware is that configuration f=
or
> > > > > > module registers needs to be stored in a DMA buffer and gets co=
pied
> > > > > > to actual registers by the hardware at the next vsync, when ins=
tructed
> > > > > > by a flag. This is handled by the "state" mechanism in the driv=
er.
> > > > > >=20
> > > > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > > ---
> > > > > >  drivers/staging/media/sunxi/Kconfig           |   1 +
> > > > > >  drivers/staging/media/sunxi/Makefile          |   1 +
> > > > > >  drivers/staging/media/sunxi/sun6i-isp/Kconfig |  13 +
> > > > > >  .../staging/media/sunxi/sun6i-isp/Makefile    |   4 +
> > > > > >  .../staging/media/sunxi/sun6i-isp/sun6i_isp.c | 572 ++++++++++=
+++
> > > > > >  .../staging/media/sunxi/sun6i-isp/sun6i_isp.h |  86 ++
> > > > > >  .../media/sunxi/sun6i-isp/sun6i_isp_capture.c | 751 ++++++++++=
++++++++
> > > > > >  .../media/sunxi/sun6i-isp/sun6i_isp_capture.h |  78 ++
> > > > > >  .../media/sunxi/sun6i-isp/sun6i_isp_params.c  | 573 ++++++++++=
+++
> > > > > >  .../media/sunxi/sun6i-isp/sun6i_isp_params.h  |  52 ++
> > > > > >  .../media/sunxi/sun6i-isp/sun6i_isp_proc.c    | 599 ++++++++++=
++++
> > > > > >  .../media/sunxi/sun6i-isp/sun6i_isp_proc.h    |  61 ++
> > > > > >  .../media/sunxi/sun6i-isp/sun6i_isp_reg.h     | 275 +++++++
> > > > > >  .../sunxi/sun6i-isp/uapi/sun6i-isp-config.h   |  43 +
> > > > >=20
> > > > > Could you add a TODO file to list the issues that need to be fixe=
d for
> > > > > the driver to move out of staging ? I'll already propose one entr=
y:
> > > > >=20
> > > > > - Add support in libcamera
> > > >=20
> > > > Maybe it would be good to narrow down what level of support you hav=
e in mind
> > > > here. Just adding basic support fort the pipeline is probably doabl=
e, but
> > > > developing complex 3A algorithms would require very significant eff=
ort and
> > > > it would be a shame that this prevents the driver from leaving stag=
ing.
> > > >=20
> > > > I think another obvious task would be to have a complete uAPI that =
reflects
> > > > all modules that are part of the ISP.
> > > >=20
> > > > What do you think?
> > >=20
> > > The reason why I'd like to see libcamera support for the ISP driver is
> > > to ensure that the kernel API is adequate for real use cases. The API
> > > can be split in three parts:
> > >=20
> > > - Pipeline configuration (this includes the media controller topology,
> > >   link setting, subdev pad format/selection rectangle configuration,
> > >   ...)
> > > - ISP parameters
> > > - ISP statistics
> > >=20
> > > A pipeline handler implementation will cover the first parts. The sec=
ond
> > > and third parts need to be tested too, but we don't need to implement
> > > every single feature. A very simple algorithm that demonstrates
> > > statistics can be captured and ISP parameters can be set should be
> > > enough to test and exercise the API in real scenarios. We're working =
on
> > > making basic AE and AWB algorithm implementations generic (or at least
> > > creating generic building blocks that can easily be assembled to crea=
te
> > > those algorithms, as the ISP statistics and parameters are specific to
> > > the ISP and thus require some ISP-specific code), so that should beco=
me
> > > a fairly easy task soon. I expect most of the work to go in the pipel=
ine
> > > handler.
> > >=20
> > > Does this sound fair to you ?
> >=20
> > Yes I understand that these aspects need to be tested too, but I feel l=
ike
> > having an implementation with a feedback look (even rudimentary and usi=
ng
> > some generic helpers) would be quite a stretch.
>=20
> Don't be scared, it's not that difficult :-) A very basic feedback loop
> is easier to implement than the code that configures the pipeline and
> tracks buffers.

Thanks for the reassurance :) In any case I think there's work to be done
to figure the precise meaning of the feedback data. I remember seeing heade=
rs
that describe the data layout but the meaning of individual fields seems
very vague. But in any case we need proper understanding of that since
that's what the driver will be returning.

> > It would probably be sufficient to have some demo code that can receive=
 stats
> > and set parameters, but without necessarily any connection between the =
two.
> > As such it's also my feeling that a standalone demo program could be ea=
sier
> > to manage for that purpose than libcamera support.
> >=20
> > So how about making the requirement that a (free software) userspace
> > implementration must demonstrate ability to read relevant statistics
> > from the ISP and (independently) control parameters that affect the out=
put?
>=20
> It's easy to create a test tool to demonstrate that the driver works
> fine, when the purpose of the test tool is to exercise the driver API in
> the way intended by the driver author. What such a test tool fails to
> demonstrate is the fitness of the API for real uses cases. This is why
> KMS requires userspace APIs to be exercised in a real display stack
> (X.org, Weston, Android hwcomposer, ...) and not just in a test tool.
> We're following the same rationale here.

Okay I understand your point here. If the expectation is to fully validate
proper use-cases and not just parts of the API individually, I don't object.
It's a high standard but it might prevent issues down the road.

Cheers,

Paul

> > > > > This isn't required to merge the driver in staging as long as ABI
> > > > > compatibility doesn't need to be preserved until the driver is mo=
ved out
> > > > > of staging.
> > > > >
> > > > > >  14 files changed, 3109 insertions(+)
> > > > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/Kconf=
ig
> > > > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/Makef=
ile
> > > > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i=
_isp.c
> > > > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i=
_isp.h
> > > > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i=
_isp_capture.c
> > > > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i=
_isp_capture.h
> > > > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i=
_isp_params.c
> > > > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i=
_isp_params.h
> > > > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i=
_isp_proc.c
> > > > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i=
_isp_proc.h
> > > > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i=
_isp_reg.h
> > > > > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/uapi/=
sun6i-isp-config.h
> > > > >=20
> > > > > [snip]
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--tuUbZtcT2/vID5n5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmIfiPQACgkQ3cLmz3+f
v9EjHgf+OoOgooDLEu+qDE0N3ghYDvl9IBaAba6GVII8htAdUSdPUT14wH36J7Z/
IWJluY4VrgC71ME7WbUSwLcvXrYs93DPiim87ErsD8rpe49j/0MQDpz2DOBec+zT
NrFDnlbW1aKHA3iWEOUuQcNSVnhefj4cNWUmwOlGtMIeqOctwm4P6bc01GsOVoYX
jzzqyrO8ydE+UrJV8JfgfpkYU/eYtcX1HfVaE82jMJfY8uygtyGHbF605aIRwND8
FuKxaqFHq2YpDfq0X5vaxM1Np1OFi5aswjLURiQADWAYdJA001HTLY3kEHB3L9Jk
AW5a99gT8ZQjSvuhlolEggCnJkS6Kw==
=U0J9
-----END PGP SIGNATURE-----

--tuUbZtcT2/vID5n5--
