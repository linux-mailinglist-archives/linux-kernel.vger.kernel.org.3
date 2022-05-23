Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903F1530EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbiEWMwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbiEWMwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:52:05 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38DE3DA7A;
        Mon, 23 May 2022 05:52:01 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 335121C0004;
        Mon, 23 May 2022 12:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653310320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U+H5xu8nCjdPDFB+rNE/Nv2sAZrPCxc01fLrAUYE1eE=;
        b=OHjPq6PNsRRavWiImrmtBl5h8WOWbZbQ2kehnB7qEoTtWw47+3pwOl5kMlB+tXm/J4wGRv
        bZ+YCtkRlq+zIhBsnfhcfcieywN68jOpLfntklbqH651Lm1e56yMYVuEV3IA/uKVomqiS9
        Mv7d4WfJtTbnsT9Mvy0M3mHLJlxasC0WezQ9riLw1XyLIK5cd4kRY682AX78iTkiB2PXm7
        f/N5mTQPniOhR6SoS5KuaD7b5Tokf9yznWLvBaH3B6yDmcXAFsyVPRaPOgr4y5O96FQVYt
        0ceQCUoBTL2ZaRlxtx0PfPzk2fIiGuDdWAQ+dYILBy19/kVw95TrVpUZRbKjjQ==
Date:   Mon, 23 May 2022 14:51:55 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
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
Subject: Re: [PATCH v3 3/4] staging: media: Add support for the Allwinner A31
 ISP
Message-ID: <YouDa3mE9+SkKJg/@aptenodytes>
References: <20220415153708.637804-1-paul.kocialkowski@bootlin.com>
 <20220415153708.637804-4-paul.kocialkowski@bootlin.com>
 <YmqFQSRBsqs4ghNQ@valkosipuli.retiisi.eu>
 <Ymqk89e+mn/1kLLx@aptenodytes>
 <YmsCJicyzf+Bz98y@valkosipuli.retiisi.eu>
 <YoesXywA4yzBDSwU@aptenodytes>
 <Yop0DGOo1ky2dfnv@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SXPMYzqIrx+IMC+b"
Content-Disposition: inline
In-Reply-To: <Yop0DGOo1ky2dfnv@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SXPMYzqIrx+IMC+b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Sun 22 May 22, 20:34, Laurent Pinchart wrote:
> Hi Paul,
>=20
> On Fri, May 20, 2022 at 04:57:35PM +0200, Paul Kocialkowski wrote:
> > On Fri 29 Apr 22, 00:07, Sakari Ailus wrote:
> > > On Thu, Apr 28, 2022 at 04:30:11PM +0200, Paul Kocialkowski wrote:
> > > > Hi Sakari,
> > > >=20
> > > > On Thu 28 Apr 22, 15:14, Sakari Ailus wrote:
> > > > > Hi Paul,
> > > > >=20
> > > > > Thanks for the set.
> > > > >=20
> > > > > A few comments below.
> > > >=20
> > > > Thanks a lot for your review!
> > >=20
> > > You're welcome!
> > >=20
> > > ...
> > >=20
> > > > > I understand this is an online ISP. How do you schedule the video=
 buffer
> > > > > queues? Say, what happens if it's time to set up buffers for a fr=
ame and
> > > > > there's a buffer queued in the parameter queue but not in the ima=
ge data
> > > > > queue? Or the other way around?
> > > >=20
> > > > The ISP works in a quite atypical way, with a DMA buffer that is us=
ed to
> > > > hold upcoming parameters (including buffer addresses) and a bit in =
a "direct"
> > > > register to schedule the update of the parameters at next vsync.
> > > >=20
> > > > The update (setting the bit) is triggered whenever new parameters a=
re
> > > > submitted via the params video device or whenever there's a capture=
 buffer
> > > > available in the capture video device.
> > > >=20
> > > > So you don't particularly need to have one parameter buffer matchin=
g a capture
> > > > buffer, the two can be updated independently. Of course, a capture =
buffer will
> > > > only be returned after another buffer becomes active.
> > >=20
> > > This also means it's not possible to associate a capture buffer to a
> > > parameter buffer by other means than timing --- which is unreliable. =
The
> > > request API would allow that but it's not free of issues either.
> >=20
> > Yes the request API seems like a good fit for this. Note that the retur=
ned
> > sequence number in dequeued buffers for the capture and meta video devi=
ces
> > should match though, so userspace still has a way to know which capture=
d buffer
> > used parameters from which meta params buffer.
> >=20
> > > Alternatively, I think in this case you could always require the capt=
ure
> > > buffer and grab a parameter buffer when it's available. As ISPs are
> > > generally requiring device specific control software, this shouldn't =
be a
> > > problem really.
> >=20
> > I think this is pretty much what happens already.
> >=20
> > > I wonder what Laurent thinks.
>=20
> If parameters buffers are optional, I think the request API should be
> used, otherwise we won't be able to ensure per-frame control. The
> alternative is to make the parameter buffer mandatory for every frame,
> even if no parameters have changed. Or maybe that's the case already ?

Currently the parameters are not mandatory (there is a default state set
by the driver) and queued parameter buffers are applied in the order they
are submitted.

The request API would make per-frame control possible, but I don't think
there is a point in making it mandatory. It seems that the situation is very
similar to what already exists with the rkisp1 driver.

Cheers,

Paul

> > > > I hope this answers your concern!
> > > >=20
> > > > [...]
> > > >=20
> > > > > > +static int sun6i_isp_tables_setup(struct sun6i_isp_device *isp=
_dev)
> > > > > > +{
> > > > > > +	struct sun6i_isp_tables *tables =3D &isp_dev->tables;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	/* Sizes are hardcoded for now but actually depend on the pla=
tform. */
> > > > >=20
> > > > > Would it be cleaner to have them defined in a platform-specific w=
ay, e.g.
> > > > > in a struct you obtain using device_get_match_data()?
> > > >=20
> > > > Absolutely! I didn't do it at this stage since only one platform is=
 supported
> > > > but we could just as well introduce a variant structure already for=
 the table
> > > > sizes.
> > >=20
> > > I think that would be nice already, especially if you know these are =
going
> > > to be different. Otherwise macros could be an option.
> >=20
> > Understood!
> >=20
> > > ...
> > >=20
> > > > > > +	ret =3D v4l2_ctrl_handler_init(&v4l2->ctrl_handler, 0);
> > > > >=20
> > > > > I suppose you intend to add controls later on?
> > > >=20
> > > > I might be wrong but I thought this was necessary to expose sensor =
controls
> > > > registered by subdevs that end up attached to this v4l2 device.
> > > >=20
> > > > I doubt the drivers itself will expose controls otherwise.
> > >=20
> > > Now that this is an MC-enabled driver, the subdev controls should be
> > > accessed through the subdev nodes only. Adding them to the video devi=
ce's
> > > control handler is quite hackish and not guaranteed to even work (as =
e.g.
> > > multiple subdevs can have the same control).
> >=20
> > Yes I was wondering what would happen in that case. I'll drop the ctrls
> > handling in the next iteration then.
> >=20
> > Paul
> >=20
> > > ...
> > >=20
> > > > > > +{
> > > > > > +	struct sun6i_isp_device *isp_dev =3D video_drvdata(file);
> > > > > > +	struct video_device *video_dev =3D &isp_dev->capture.video_de=
v;
> > > > > > +	struct mutex *lock =3D &isp_dev->capture.lock;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	if (mutex_lock_interruptible(lock))
> > > > > > +		return -ERESTARTSYS;
> > > > > > +
> > > > > > +	ret =3D v4l2_pipeline_pm_get(&video_dev->entity);
> > > > >=20
> > > > > Do you need this?
> > > > >=20
> > > > > Drivers should primarily depend on runtime PM, this is only neede=
d for
> > > > > compatibility reasons. Instead I'd like to see sensor drivers bei=
ng moved
> > > > > to runtime PM.
> > > >=20
> > > > Yes it's still needed to support sensor drivers that don't use rpm =
yet.
> > >=20
> > > To that I suggested adding runtime PM support for the affected sensor=
s.
> > > This doesn't seem to get done otherwise. E.g. ipu3-cio2 driver does n=
ot
> > > call s_power() on sensor subdevs.
> > >=20
> > > ...
> > >=20
> > > > > > +	ret =3D video_register_device(video_dev, VFL_TYPE_VIDEO, -1);
> > > > > > +	if (ret) {
> > > > > > +		v4l2_err(v4l2_dev, "failed to register video device: %d\n",
> > > > > > +			 ret);
> > > > > > +		goto error_media_entity;
> > > > > > +	}
> > > > > > +
> > > > > > +	v4l2_info(v4l2_dev, "device %s registered as %s\n", video_dev=
->name,
> > > > > > +		  video_device_node_name(video_dev));
> > > > >=20
> > > > > This isn't really driver specific. I'd drop it.
> > > >=20
> > > > I agree but I see that many drivers are doing it and the informatio=
n can
> > > > actually be quite useful at times.
> > >=20
> > > You can get that information using media-ctl -e 'entity name'.
> > >=20
> > > I guess this could be also added to video_register_device() on debug =
level.
> > >=20
> > > > > > +struct sun6i_isp_params_config_bdnf {
> > > > > > +	__u8	in_dis_min; // 8
> > > > > > +	__u8	in_dis_max; // 10
> > > > >=20
> > > > > Are these default values or something else? Better documentation =
was in the
> > > > > TODO.txt file already.
> > > >=20
> > > > Yes that's the default register values, but these comments are and =
overlook on
> > > > my side and should be removed.
> > >=20
> > > I'm fine leaving these here. Just wondering. Up to you.
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--SXPMYzqIrx+IMC+b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmKLg2sACgkQ3cLmz3+f
v9HkdAf/c8WwJ1tDC3vE468r7moIH1vWtbKyBlLkj1iB/T6YtO4tadBef69WudfQ
mEmB43e4AeciElrjs/y0s0lTvbSatpK2BRUg82vQwm7PKUvgefaNkliZsU2WSOeT
5hbkDNUX1ckQeZxVbpqO7zleFAa+uupHBmzM9c5/mE6g2mYOB9PSyNvNiZSBJUb7
eM3IilYNswo+nWdcXWR3KYAgePBArQAEyE9IBmQSPrXeBJVj0Hqsti0Z9ANJjOcx
ZHa0d9TY6SOb/oRw7gPQGj796ZcfYhXrTCStEPYOh304OXSA790Vvd0O6wgPTio9
8UxE4fCbngH6y23ie+BH3Kl25imuWw==
=ZrB9
-----END PGP SIGNATURE-----

--SXPMYzqIrx+IMC+b--
