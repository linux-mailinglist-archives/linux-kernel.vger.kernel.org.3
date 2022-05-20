Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5D552EE8F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350533AbiETO5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiETO5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:57:44 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DC31737EF;
        Fri, 20 May 2022 07:57:41 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 417914000F;
        Fri, 20 May 2022 14:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653058659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pejjagd04uhGPBvwZNzDzgti8YXBTsaNP9vyEjKnY7U=;
        b=R8lUCqKdq6VkpW+RkJQqRfPxOtgyJmB7MgNyodMsLkrlpUMLgjXJMWh1XK77oaZagjKEW3
        fkMRmlBi2mx8JovhnmEme+9fbyxNvN1gTkwWpVjzxq5tfgk8hy96lBfN0EmosDEuFnhwMa
        X+bcS9mOVAZYt9bSaFZPdBdQJjrzXpAk8xOiCMI0ZjtB9gSks84DJvxwTUPRsVaZiDiuo+
        S4hU42KH18PCDdxKVQnR+VsfpyXJtez1Znh+8Cjmi0MPL1TvuuGRq4zkRRvIeBdRIfRACK
        0SlFu1D+rrHSxujdVNkvfLXbi0c+xIg7NtB+9Qz+NwkHMmEsruV97ljBWXnnCg==
Date:   Fri, 20 May 2022 16:57:35 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 3/4] staging: media: Add support for the Allwinner A31
 ISP
Message-ID: <YoesXywA4yzBDSwU@aptenodytes>
References: <20220415153708.637804-1-paul.kocialkowski@bootlin.com>
 <20220415153708.637804-4-paul.kocialkowski@bootlin.com>
 <YmqFQSRBsqs4ghNQ@valkosipuli.retiisi.eu>
 <Ymqk89e+mn/1kLLx@aptenodytes>
 <YmsCJicyzf+Bz98y@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FAoW3tsaHuiF93BU"
Content-Disposition: inline
In-Reply-To: <YmsCJicyzf+Bz98y@valkosipuli.retiisi.eu>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FAoW3tsaHuiF93BU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Fri 29 Apr 22, 00:07, Sakari Ailus wrote:
> Hi Paul,
>=20
> On Thu, Apr 28, 2022 at 04:30:11PM +0200, Paul Kocialkowski wrote:
> > Hi Sakari,
> >=20
> > On Thu 28 Apr 22, 15:14, Sakari Ailus wrote:
> > > Hi Paul,
> > >=20
> > > Thanks for the set.
> > >=20
> > > A few comments below.
> >=20
> > Thanks a lot for your review!
>=20
> You're welcome!
>=20
> ...
>=20
> > > I understand this is an online ISP. How do you schedule the video buf=
fer
> > > queues? Say, what happens if it's time to set up buffers for a frame =
and
> > > there's a buffer queued in the parameter queue but not in the image d=
ata
> > > queue? Or the other way around?
> >=20
> > The ISP works in a quite atypical way, with a DMA buffer that is used to
> > hold upcoming parameters (including buffer addresses) and a bit in a "d=
irect"
> > register to schedule the update of the parameters at next vsync.
> >=20
> > The update (setting the bit) is triggered whenever new parameters are
> > submitted via the params video device or whenever there's a capture buf=
fer
> > available in the capture video device.
> >=20
> > So you don't particularly need to have one parameter buffer matching a =
capture
> > buffer, the two can be updated independently. Of course, a capture buff=
er will
> > only be returned after another buffer becomes active.
>=20
> This also means it's not possible to associate a capture buffer to a
> parameter buffer by other means than timing --- which is unreliable. The
> request API would allow that but it's not free of issues either.

Yes the request API seems like a good fit for this. Note that the returned
sequence number in dequeued buffers for the capture and meta video devices
should match though, so userspace still has a way to know which captured bu=
ffer
used parameters from which meta params buffer.

> Alternatively, I think in this case you could always require the capture
> buffer and grab a parameter buffer when it's available. As ISPs are
> generally requiring device specific control software, this shouldn't be a
> problem really.

I think this is pretty much what happens already.

> I wonder what Laurent thinks.
>=20
> >=20
> > I hope this answers your concern!
> >=20
> > [...]
> >=20
> > > > +static int sun6i_isp_tables_setup(struct sun6i_isp_device *isp_dev)
> > > > +{
> > > > +	struct sun6i_isp_tables *tables =3D &isp_dev->tables;
> > > > +	int ret;
> > > > +
> > > > +	/* Sizes are hardcoded for now but actually depend on the platfor=
m. */
> > >=20
> > > Would it be cleaner to have them defined in a platform-specific way, =
e.g.
> > > in a struct you obtain using device_get_match_data()?
> >=20
> > Absolutely! I didn't do it at this stage since only one platform is sup=
ported
> > but we could just as well introduce a variant structure already for the=
 table
> > sizes.
>=20
> I think that would be nice already, especially if you know these are going
> to be different. Otherwise macros could be an option.

Understood!

> ...
>=20
> > > > +	ret =3D v4l2_ctrl_handler_init(&v4l2->ctrl_handler, 0);
> > >=20
> > > I suppose you intend to add controls later on?
> >=20
> > I might be wrong but I thought this was necessary to expose sensor cont=
rols
> > registered by subdevs that end up attached to this v4l2 device.
> >=20
> > I doubt the drivers itself will expose controls otherwise.
>=20
> Now that this is an MC-enabled driver, the subdev controls should be
> accessed through the subdev nodes only. Adding them to the video device's
> control handler is quite hackish and not guaranteed to even work (as e.g.
> multiple subdevs can have the same control).

Yes I was wondering what would happen in that case. I'll drop the ctrls
handling in the next iteration then.

Paul

> ...
>=20
> > > > +{
> > > > +	struct sun6i_isp_device *isp_dev =3D video_drvdata(file);
> > > > +	struct video_device *video_dev =3D &isp_dev->capture.video_dev;
> > > > +	struct mutex *lock =3D &isp_dev->capture.lock;
> > > > +	int ret;
> > > > +
> > > > +	if (mutex_lock_interruptible(lock))
> > > > +		return -ERESTARTSYS;
> > > > +
> > > > +	ret =3D v4l2_pipeline_pm_get(&video_dev->entity);
> > >=20
> > > Do you need this?
> > >=20
> > > Drivers should primarily depend on runtime PM, this is only needed for
> > > compatibility reasons. Instead I'd like to see sensor drivers being m=
oved
> > > to runtime PM.
> >=20
> > Yes it's still needed to support sensor drivers that don't use rpm yet.
>=20
> To that I suggested adding runtime PM support for the affected sensors.
> This doesn't seem to get done otherwise. E.g. ipu3-cio2 driver does not
> call s_power() on sensor subdevs.
>=20
> ...
>=20
> > > > +	ret =3D video_register_device(video_dev, VFL_TYPE_VIDEO, -1);
> > > > +	if (ret) {
> > > > +		v4l2_err(v4l2_dev, "failed to register video device: %d\n",
> > > > +			 ret);
> > > > +		goto error_media_entity;
> > > > +	}
> > > > +
> > > > +	v4l2_info(v4l2_dev, "device %s registered as %s\n", video_dev->na=
me,
> > > > +		  video_device_node_name(video_dev));
> > >=20
> > > This isn't really driver specific. I'd drop it.
> >=20
> > I agree but I see that many drivers are doing it and the information can
> > actually be quite useful at times.
>=20
> You can get that information using media-ctl -e 'entity name'.
>=20
> I guess this could be also added to video_register_device() on debug leve=
l.
>=20
> > > > +struct sun6i_isp_params_config_bdnf {
> > > > +	__u8	in_dis_min; // 8
> > > > +	__u8	in_dis_max; // 10
> > >=20
> > > Are these default values or something else? Better documentation was =
in the
> > > TODO.txt file already.
> >=20
> > Yes that's the default register values, but these comments are and over=
look on
> > my side and should be removed.
>=20
> I'm fine leaving these here. Just wondering. Up to you.
>=20
> --=20
> Kind regards,
>=20
> Sakari Ailus

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--FAoW3tsaHuiF93BU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmKHrF8ACgkQ3cLmz3+f
v9HhUggAlMjbtLYEq3V4Mz0xX1XuzbkyKEzMNadNg6z6gQ4YaVnXpvpyFH4M35Zq
aK+9CBzhgAy7OPfzxZ7SLijO27vEApEjQsxF79cI+VAb6TsTxcdT0wvYW3DyPVV7
CM8qYR6k7r1TrbPP2S2tpm2e0o2vgMAg3YIYvs183GelA3KO+XAAlKiNf/hxvcPX
jZ9x2twYZxuw5SdKU+HwVwKJqGxF6cbJ82VSuO6vBp3McxB+GP6C5lXR360UJNcN
TDxgvMYYqruqriEcxQubPYwV6ndB6l1LZDo0PJMi9FmdYL4T2K0oc5J0IqpiKu/a
Ax3F0ID+oBjpErydkMbGHXrEN/aLug==
=+4MT
-----END PGP SIGNATURE-----

--FAoW3tsaHuiF93BU--
