Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4193532A80
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 14:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbiEXMhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 08:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237409AbiEXMhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 08:37:43 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A937CDF6;
        Tue, 24 May 2022 05:37:36 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 960BF40018;
        Tue, 24 May 2022 12:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653395854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6TmRvXMBXKzvHnQeIS3dP+SHVdrOjsDZ1s/a3SWwHws=;
        b=TlhQ9+91r4lJZTfdlIaV8PxM5C2m21D8wmvVhnZZ2GFWlzYESUcYoKKZyS33NyYRu7yHP8
        Ey0PCjcFYeBUQak/3Lm2ltpuVoS3uwbHR5wyc+6xY1Omdssy8cxbSewgU5QlZwbkQ63hps
        VcwXSaHoFKbwoE+MQs5cYGZsH0PKQGSftrlu3Tz5IPAyn+6vvXjlv+BV3Hi5EkJIYklWcH
        ou1rD6ELM2X0tIlgNCzjW1aLJoLi+czfQ1fdKnJWG3gTENGCWwH7kLUIkJgCVvqC0Zykar
        OSpMkoldOFwFMtRHtR6PfBpxXivEqezaykvbX9lI1lQRpl7j04uWCb//jtYCuw==
Date:   Tue, 24 May 2022 14:37:30 +0200
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
Message-ID: <YozRiiN7LM0dzbjq@aptenodytes>
References: <20220415153708.637804-1-paul.kocialkowski@bootlin.com>
 <20220415153708.637804-4-paul.kocialkowski@bootlin.com>
 <YmqFQSRBsqs4ghNQ@valkosipuli.retiisi.eu>
 <Ymqk89e+mn/1kLLx@aptenodytes>
 <YmsCJicyzf+Bz98y@valkosipuli.retiisi.eu>
 <YoesXywA4yzBDSwU@aptenodytes>
 <Yop0DGOo1ky2dfnv@pendragon.ideasonboard.com>
 <YouDa3mE9+SkKJg/@aptenodytes>
 <YouLusf4sWK9W2J7@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JFVjsol0NsyPDSxX"
Content-Disposition: inline
In-Reply-To: <YouLusf4sWK9W2J7@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JFVjsol0NsyPDSxX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Mon 23 May 22, 16:27, Laurent Pinchart wrote:
> Hi Paul,
>=20
> On Mon, May 23, 2022 at 02:51:55PM +0200, Paul Kocialkowski wrote:
> > On Sun 22 May 22, 20:34, Laurent Pinchart wrote:
> > > On Fri, May 20, 2022 at 04:57:35PM +0200, Paul Kocialkowski wrote:
> > > > On Fri 29 Apr 22, 00:07, Sakari Ailus wrote:
> > > > > On Thu, Apr 28, 2022 at 04:30:11PM +0200, Paul Kocialkowski wrote:
> > > > > > Hi Sakari,
> > > > > >=20
> > > > > > On Thu 28 Apr 22, 15:14, Sakari Ailus wrote:
> > > > > > > Hi Paul,
> > > > > > >=20
> > > > > > > Thanks for the set.
> > > > > > >=20
> > > > > > > A few comments below.
> > > > > >=20
> > > > > > Thanks a lot for your review!
> > > > >=20
> > > > > You're welcome!
> > > > >=20
> > > > > ...
> > > > >=20
> > > > > > > I understand this is an online ISP. How do you schedule the v=
ideo buffer
> > > > > > > queues? Say, what happens if it's time to set up buffers for =
a frame and
> > > > > > > there's a buffer queued in the parameter queue but not in the=
 image data
> > > > > > > queue? Or the other way around?
> > > > > >=20
> > > > > > The ISP works in a quite atypical way, with a DMA buffer that i=
s used to
> > > > > > hold upcoming parameters (including buffer addresses) and a bit=
 in a "direct"
> > > > > > register to schedule the update of the parameters at next vsync.
> > > > > >=20
> > > > > > The update (setting the bit) is triggered whenever new paramete=
rs are
> > > > > > submitted via the params video device or whenever there's a cap=
ture buffer
> > > > > > available in the capture video device.
> > > > > >=20
> > > > > > So you don't particularly need to have one parameter buffer mat=
ching a capture
> > > > > > buffer, the two can be updated independently. Of course, a capt=
ure buffer will
> > > > > > only be returned after another buffer becomes active.
> > > > >=20
> > > > > This also means it's not possible to associate a capture buffer t=
o a
> > > > > parameter buffer by other means than timing --- which is unreliab=
le. The
> > > > > request API would allow that but it's not free of issues either.
> > > >=20
> > > > Yes the request API seems like a good fit for this. Note that the r=
eturned
> > > > sequence number in dequeued buffers for the capture and meta video =
devices
> > > > should match though, so userspace still has a way to know which cap=
tured buffer
> > > > used parameters from which meta params buffer.
> > > >=20
> > > > > Alternatively, I think in this case you could always require the =
capture
> > > > > buffer and grab a parameter buffer when it's available. As ISPs a=
re
> > > > > generally requiring device specific control software, this should=
n't be a
> > > > > problem really.
> > > >=20
> > > > I think this is pretty much what happens already.
> > > >=20
> > > > > I wonder what Laurent thinks.
> > >=20
> > > If parameters buffers are optional, I think the request API should be
> > > used, otherwise we won't be able to ensure per-frame control. The
> > > alternative is to make the parameter buffer mandatory for every frame,
> > > even if no parameters have changed. Or maybe that's the case already ?
> >=20
> > Currently the parameters are not mandatory (there is a default state set
> > by the driver) and queued parameter buffers are applied in the order th=
ey
> > are submitted.
> >=20
> > The request API would make per-frame control possible, but I don't think
> > there is a point in making it mandatory. It seems that the situation is=
 very
> > similar to what already exists with the rkisp1 driver.
>=20
> You mentioned that the parameter buffers contain buffer addresses, is
> that the DMA address of the image buffers (input and output) ? If so,
> how does that work, does the kernel patch the parameters buffer provided
> by userspace to fill the DMA addresses in placeholders ?

Ah there might be a misunderstanding here: the hardware has a notion of
"parameters buffer" which a DMA buffer that holds the next values of most of
the registers (including the DMA adresses of dst buffers).

However the parameters buffers for configuring the ISP are uAPI structures
which are distinct from the registers of the hardware. It's these structures
that are provided to the driver via a dedicated meta-output video device,
by userspace. Of course the values from the uAPI parameters buffers also en=
d up
in the hardware parameters.

I hope this clarifies things a bit!

Paul

> > > > > > I hope this answers your concern!
> > > > > >=20
> > > > > > [...]
> > > > > >=20
> > > > > > > > +static int sun6i_isp_tables_setup(struct sun6i_isp_device =
*isp_dev)
> > > > > > > > +{
> > > > > > > > +	struct sun6i_isp_tables *tables =3D &isp_dev->tables;
> > > > > > > > +	int ret;
> > > > > > > > +
> > > > > > > > +	/* Sizes are hardcoded for now but actually depend on the=
 platform. */
> > > > > > >=20
> > > > > > > Would it be cleaner to have them defined in a platform-specif=
ic way, e.g.
> > > > > > > in a struct you obtain using device_get_match_data()?
> > > > > >=20
> > > > > > Absolutely! I didn't do it at this stage since only one platfor=
m is supported
> > > > > > but we could just as well introduce a variant structure already=
 for the table
> > > > > > sizes.
> > > > >=20
> > > > > I think that would be nice already, especially if you know these =
are going
> > > > > to be different. Otherwise macros could be an option.
> > > >=20
> > > > Understood!
> > > >=20
> > > > > ...
> > > > >=20
> > > > > > > > +	ret =3D v4l2_ctrl_handler_init(&v4l2->ctrl_handler, 0);
> > > > > > >=20
> > > > > > > I suppose you intend to add controls later on?
> > > > > >=20
> > > > > > I might be wrong but I thought this was necessary to expose sen=
sor controls
> > > > > > registered by subdevs that end up attached to this v4l2 device.
> > > > > >=20
> > > > > > I doubt the drivers itself will expose controls otherwise.
> > > > >=20
> > > > > Now that this is an MC-enabled driver, the subdev controls should=
 be
> > > > > accessed through the subdev nodes only. Adding them to the video =
device's
> > > > > control handler is quite hackish and not guaranteed to even work =
(as e.g.
> > > > > multiple subdevs can have the same control).
> > > >=20
> > > > Yes I was wondering what would happen in that case. I'll drop the c=
trls
> > > > handling in the next iteration then.
> > > >=20
> > > > Paul
> > > >=20
> > > > > ...
> > > > >=20
> > > > > > > > +{
> > > > > > > > +	struct sun6i_isp_device *isp_dev =3D video_drvdata(file);
> > > > > > > > +	struct video_device *video_dev =3D &isp_dev->capture.vide=
o_dev;
> > > > > > > > +	struct mutex *lock =3D &isp_dev->capture.lock;
> > > > > > > > +	int ret;
> > > > > > > > +
> > > > > > > > +	if (mutex_lock_interruptible(lock))
> > > > > > > > +		return -ERESTARTSYS;
> > > > > > > > +
> > > > > > > > +	ret =3D v4l2_pipeline_pm_get(&video_dev->entity);
> > > > > > >=20
> > > > > > > Do you need this?
> > > > > > >=20
> > > > > > > Drivers should primarily depend on runtime PM, this is only n=
eeded for
> > > > > > > compatibility reasons. Instead I'd like to see sensor drivers=
 being moved
> > > > > > > to runtime PM.
> > > > > >=20
> > > > > > Yes it's still needed to support sensor drivers that don't use =
rpm yet.
> > > > >=20
> > > > > To that I suggested adding runtime PM support for the affected se=
nsors.
> > > > > This doesn't seem to get done otherwise. E.g. ipu3-cio2 driver do=
es not
> > > > > call s_power() on sensor subdevs.
> > > > >=20
> > > > > ...
> > > > >=20
> > > > > > > > +	ret =3D video_register_device(video_dev, VFL_TYPE_VIDEO, =
-1);
> > > > > > > > +	if (ret) {
> > > > > > > > +		v4l2_err(v4l2_dev, "failed to register video device: %d\=
n",
> > > > > > > > +			 ret);
> > > > > > > > +		goto error_media_entity;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	v4l2_info(v4l2_dev, "device %s registered as %s\n", video=
_dev->name,
> > > > > > > > +		  video_device_node_name(video_dev));
> > > > > > >=20
> > > > > > > This isn't really driver specific. I'd drop it.
> > > > > >=20
> > > > > > I agree but I see that many drivers are doing it and the inform=
ation can
> > > > > > actually be quite useful at times.
> > > > >=20
> > > > > You can get that information using media-ctl -e 'entity name'.
> > > > >=20
> > > > > I guess this could be also added to video_register_device() on de=
bug level.
> > > > >=20
> > > > > > > > +struct sun6i_isp_params_config_bdnf {
> > > > > > > > +	__u8	in_dis_min; // 8
> > > > > > > > +	__u8	in_dis_max; // 10
> > > > > > >=20
> > > > > > > Are these default values or something else? Better documentat=
ion was in the
> > > > > > > TODO.txt file already.
> > > > > >=20
> > > > > > Yes that's the default register values, but these comments are =
and overlook on
> > > > > > my side and should be removed.
> > > > >=20
> > > > > I'm fine leaving these here. Just wondering. Up to you.
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--JFVjsol0NsyPDSxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmKM0YoACgkQ3cLmz3+f
v9G+Ogf7B1TmIO1K4sACLe/AMewXZ771xdAEhH55RqAjbRvriNNH7aF05wYXLa9D
3B1gi7maOrrFR5Fn2VzMcZk9tGAIb80tt4AkbcQ0Acv3UgiZ0raEYWjH9mv5zJLv
5kJ6SgXpSt0k3JP1u5E8/r+YjFnfGKP5yaEr2AYIhYx3rqANCUbXzaQ834jPogUE
bxQAAGS1R8MOQTSIKMt+V4TmrcoTG3l31IAtW8bX+3T+/KbLVJE78TAF/I2j9H5w
LMrOwVe+nlPbnWIwJtjciXTPXig+Do6YOU5SFgOkRFuFyIJzCx1PXZuqFJIR9uFY
t5j8F2P7EA/nvoAc98QhXVGrDdj6vg==
=osVl
-----END PGP SIGNATURE-----

--JFVjsol0NsyPDSxX--
