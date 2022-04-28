Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F3F5136E9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348403AbiD1Odq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiD1Odh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:33:37 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888852CE3F;
        Thu, 28 Apr 2022 07:30:20 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A8075C0003;
        Thu, 28 Apr 2022 14:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651156219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Glxz9IVdj5j7vTuvkmx5NfY8R84xnkUlqB5qF6D//Q=;
        b=d4saSo0HxfntzYasdLoAwCnmifUjSPCX59t3p45uxJtbxaZMC2C4OLJFKzSeek2gTPsFYA
        BmSnnwX9oumGzoZUWYycJ59yyBbMDegBHS6rNY/fD0tYiLUCetpkiMuhR4cqeU2zAQVjQz
        zdo4Z2dKY2KLkmTuU+8oH9Nzmi+e3c+XcCnQU5V87ikQPvfsNj7noucT+6bj4Poah3REgW
        6q7t+XDHKqg5EyNefxZs8zMPYRc7BxUoCaMSg6fh0Zv1OJUe1HQ048ZnVqdgV7w5lUWVtF
        ihlUQIgmrs1HBN07dm5I5JQbw/4A30FJS/yWq09mKLWC9ljMKH20GNOVazS9PQ==
Date:   Thu, 28 Apr 2022 16:30:11 +0200
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
Message-ID: <Ymqk89e+mn/1kLLx@aptenodytes>
References: <20220415153708.637804-1-paul.kocialkowski@bootlin.com>
 <20220415153708.637804-4-paul.kocialkowski@bootlin.com>
 <YmqFQSRBsqs4ghNQ@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oDJ9GP/VwhMGHB5u"
Content-Disposition: inline
In-Reply-To: <YmqFQSRBsqs4ghNQ@valkosipuli.retiisi.eu>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oDJ9GP/VwhMGHB5u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Thu 28 Apr 22, 15:14, Sakari Ailus wrote:
> Hi Paul,
>=20
> Thanks for the set.
>=20
> A few comments below.

Thanks a lot for your review!

[...]

> >  .../staging/media/sunxi/sun6i-isp/TODO.txt    |   6 +
>=20
> This should be called TODO (without .txt).

Understood!

> I understand this is an online ISP. How do you schedule the video buffer
> queues? Say, what happens if it's time to set up buffers for a frame and
> there's a buffer queued in the parameter queue but not in the image data
> queue? Or the other way around?

The ISP works in a quite atypical way, with a DMA buffer that is used to
hold upcoming parameters (including buffer addresses) and a bit in a "direc=
t"
register to schedule the update of the parameters at next vsync.

The update (setting the bit) is triggered whenever new parameters are
submitted via the params video device or whenever there's a capture buffer
available in the capture video device.

So you don't particularly need to have one parameter buffer matching a capt=
ure
buffer, the two can be updated independently. Of course, a capture buffer w=
ill
only be returned after another buffer becomes active.

I hope this answers your concern!

[...]

> > +static int sun6i_isp_tables_setup(struct sun6i_isp_device *isp_dev)
> > +{
> > +	struct sun6i_isp_tables *tables =3D &isp_dev->tables;
> > +	int ret;
> > +
> > +	/* Sizes are hardcoded for now but actually depend on the platform. */
>=20
> Would it be cleaner to have them defined in a platform-specific way, e.g.
> in a struct you obtain using device_get_match_data()?

Absolutely! I didn't do it at this stage since only one platform is support=
ed
but we could just as well introduce a variant structure already for the tab=
le
sizes.

> > +
> > +	tables->load.size =3D 0x1000;
> > +	ret =3D sun6i_isp_table_setup(isp_dev, &tables->load);
> > +	if (ret)
> > +		return ret;
> > +
> > +	tables->save.size =3D 0x1000;
> > +	ret =3D sun6i_isp_table_setup(isp_dev, &tables->save);
> > +	if (ret)
> > +		return ret;
> > +
> > +	tables->lut.size =3D 0xe00;
> > +	ret =3D sun6i_isp_table_setup(isp_dev, &tables->lut);
> > +	if (ret)
> > +		return ret;
> > +
> > +	tables->drc.size =3D 0x600;
> > +	ret =3D sun6i_isp_table_setup(isp_dev, &tables->drc);
> > +	if (ret)
> > +		return ret;
> > +
> > +	tables->stats.size =3D 0x2100;
> > +	ret =3D sun6i_isp_table_setup(isp_dev, &tables->stats);
>=20
> You can return already here.

Sure.

> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +static void sun6i_isp_tables_cleanup(struct sun6i_isp_device *isp_dev)
> > +{
> > +	struct sun6i_isp_tables *tables =3D &isp_dev->tables;
> > +
> > +	sun6i_isp_table_cleanup(isp_dev, &tables->stats);
> > +	sun6i_isp_table_cleanup(isp_dev, &tables->drc);
> > +	sun6i_isp_table_cleanup(isp_dev, &tables->lut);
> > +	sun6i_isp_table_cleanup(isp_dev, &tables->save);
> > +	sun6i_isp_table_cleanup(isp_dev, &tables->load);
> > +}
> > +
> > +/* Media */
> > +
> > +static const struct media_device_ops sun6i_isp_media_ops =3D {
> > +	.link_notify =3D v4l2_pipeline_link_notify,
> > +};
> > +
> > +/* V4L2 */
> > +
> > +static int sun6i_isp_v4l2_setup(struct sun6i_isp_device *isp_dev)
> > +{
> > +	struct sun6i_isp_v4l2 *v4l2 =3D &isp_dev->v4l2;
> > +	struct v4l2_device *v4l2_dev =3D &v4l2->v4l2_dev;
> > +	struct media_device *media_dev =3D &v4l2->media_dev;
> > +	struct device *dev =3D isp_dev->dev;
> > +	int ret;
> > +
> > +	/* Media Device */
> > +
> > +	strscpy(media_dev->model, SUN6I_ISP_DESCRIPTION,
> > +		sizeof(media_dev->model));
> > +	snprintf(media_dev->bus_info, sizeof(media_dev->bus_info),
> > +		 "platform:%s", dev_name(dev));
>=20
> This is no longer needed, see commit b0e38610f40a0f89e34939d2c7420590d67d=
86a3

Thanks!

> > +	media_dev->ops =3D &sun6i_isp_media_ops;
> > +	media_dev->hw_revision =3D 0;
> > +	media_dev->dev =3D dev;
> > +
> > +	media_device_init(media_dev);
> > +
> > +	ret =3D media_device_register(media_dev);
> > +	if (ret) {
> > +		dev_err(dev, "failed to register media device\n");
> > +		return ret;
> > +	}
> > +
> > +	/* V4L2 Control Handler */
> > +
> > +	ret =3D v4l2_ctrl_handler_init(&v4l2->ctrl_handler, 0);
>=20
> I suppose you intend to add controls later on?

I might be wrong but I thought this was necessary to expose sensor controls
registered by subdevs that end up attached to this v4l2 device.

I doubt the drivers itself will expose controls otherwise.

[...]

> > +	isp_dev->clock_ram =3D devm_clk_get(dev, "ram");
> > +	if (IS_ERR(isp_dev->clock_ram)) {
> > +		dev_err(dev, "failed to acquire ram clock\n");
> > +		return PTR_ERR(isp_dev->clock_ram);
> > +	}
> > +
> > +	ret =3D clk_set_rate_exclusive(isp_dev->clock_mod, 297000000);
>=20
> Is this also specific to the model?

There is less certainty that another platform that will use this driver
will need another rate, but I think it would look better to have it in the
variant anyway.

[...]

> > +static int sun6i_isp_capture_open(struct file *file)
> > +{
> > +	struct sun6i_isp_device *isp_dev =3D video_drvdata(file);
> > +	struct video_device *video_dev =3D &isp_dev->capture.video_dev;
> > +	struct mutex *lock =3D &isp_dev->capture.lock;
> > +	int ret;
> > +
> > +	if (mutex_lock_interruptible(lock))
> > +		return -ERESTARTSYS;
> > +
> > +	ret =3D v4l2_pipeline_pm_get(&video_dev->entity);
>=20
> Do you need this?
>=20
> Drivers should primarily depend on runtime PM, this is only needed for
> compatibility reasons. Instead I'd like to see sensor drivers being moved
> to runtime PM.

Yes it's still needed to support sensor drivers that don't use rpm yet.

[...]

> > +int sun6i_isp_capture_setup(struct sun6i_isp_device *isp_dev)
> > +{
> > +	struct sun6i_isp_capture *capture =3D &isp_dev->capture;
> > +	struct sun6i_isp_capture_state *state =3D &capture->state;
> > +	struct v4l2_device *v4l2_dev =3D &isp_dev->v4l2.v4l2_dev;
> > +	struct v4l2_subdev *proc_subdev =3D &isp_dev->proc.subdev;
> > +	struct video_device *video_dev =3D &capture->video_dev;
> > +	struct vb2_queue *queue =3D &capture->queue;
> > +	struct media_pad *pad =3D &capture->pad;
> > +	struct v4l2_format *format =3D &capture->format;
> > +	struct v4l2_pix_format *pix_format =3D &format->fmt.pix;
> > +	int ret;
> > +
> > +	/* State */
> > +
> > +	INIT_LIST_HEAD(&state->queue);
> > +	spin_lock_init(&state->lock);
> > +
> > +	/* Media Entity */
> > +
> > +	video_dev->entity.ops =3D &sun6i_isp_capture_entity_ops;
> > +
> > +	/* Media Pads */
> > +
> > +	pad->flags =3D MEDIA_PAD_FL_SINK | MEDIA_PAD_FL_MUST_CONNECT;
> > +
> > +	ret =3D media_entity_pads_init(&video_dev->entity, 1, pad);
> > +	if (ret)
> > +		goto error_mutex;
>=20
> return ret;

Good catch, thanks!

[...]

> > +	ret =3D video_register_device(video_dev, VFL_TYPE_VIDEO, -1);
> > +	if (ret) {
> > +		v4l2_err(v4l2_dev, "failed to register video device: %d\n",
> > +			 ret);
> > +		goto error_media_entity;
> > +	}
> > +
> > +	v4l2_info(v4l2_dev, "device %s registered as %s\n", video_dev->name,
> > +		  video_device_node_name(video_dev));
>=20
> This isn't really driver specific. I'd drop it.

I agree but I see that many drivers are doing it and the information can
actually be quite useful at times.

> > +
> > +	/* Media Pad Link */
> > +
> > +	ret =3D media_create_pad_link(&proc_subdev->entity,
> > +				    SUN6I_ISP_PROC_PAD_SOURCE,
> > +				    &video_dev->entity, 0,
> > +				    MEDIA_LNK_FL_ENABLED |
> > +				    MEDIA_LNK_FL_IMMUTABLE);
> > +	if (ret < 0) {
> > +		v4l2_err(v4l2_dev, "failed to create %s:%u -> %s:%u link\n",
> > +			 proc_subdev->entity.name, SUN6I_ISP_PROC_PAD_SOURCE,
> > +			 video_dev->entity.name, 0);
>=20
> This error message printing would be better to be added to
> media_create_pad_link().

Yeah that makes sense.

[...]

> > +void sun6i_isp_params_configure(struct sun6i_isp_device *isp_dev)
> > +{
> > +	struct sun6i_isp_params_state *state =3D &isp_dev->params.state;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&state->lock, flags);
> > +
> > +	sun6i_isp_params_configure_base(isp_dev);
> > +
> > +	/* Default config is only applied at the very first stream start. */
> > +	if (state->configured)
> > +		goto complete;
> > +
> > +	 sun6i_isp_params_configure_modules(isp_dev,
>=20
> Indentation. Doesn't checkpatch.pl complain?

It doesn't, even with --strict, but that's definitely an issue there.

[...]

> > +static int sun6i_isp_params_querycap(struct file *file, void *private,
> > +				     struct v4l2_capability *capability)
> > +{
> > +	struct sun6i_isp_device *isp_dev =3D video_drvdata(file);
> > +	struct video_device *video_dev =3D &isp_dev->params.video_dev;
> > +
> > +	strscpy(capability->driver, SUN6I_ISP_NAME, sizeof(capability->driver=
));
> > +	strscpy(capability->card, video_dev->name, sizeof(capability->card));
> > +	snprintf(capability->bus_info, sizeof(capability->bus_info),
> > +		 "platform:%s", dev_name(isp_dev->dev));
>=20
> This is no longer needed with commit
> 2a792fd5cf669d379d82354a99998d9ae9ff7d14 .

Thanks.

[...]

> > +static const struct v4l2_subdev_pad_ops sun6i_isp_proc_pad_ops =3D {
> > +	.init_cfg	=3D sun6i_isp_proc_init_cfg,
> > +	.enum_mbus_code	=3D sun6i_isp_proc_enum_mbus_code,
> > +	.get_fmt	=3D sun6i_isp_proc_get_fmt,
> > +	.set_fmt	=3D sun6i_isp_proc_set_fmt,
> > +};
> > +
> > +const struct v4l2_subdev_ops sun6i_isp_proc_subdev_ops =3D {
>=20
> This can be static, can't it?

Oops, yes and it should be. Same applies to sun6i-csi-bridge actually.

[...]

> > +struct sun6i_isp_params_config_bdnf {
> > +	__u8	in_dis_min; // 8
> > +	__u8	in_dis_max; // 10
>=20
> Are these default values or something else? Better documentation was in t=
he
> TODO.txt file already.

Yes that's the default register values, but these comments are and overlook=
 on
my side and should be removed.

Thanks!

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--oDJ9GP/VwhMGHB5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmJqpPMACgkQ3cLmz3+f
v9HXvQgAn6cRhpKDno79TUNMn+J81Zq+1c5WzbdWbv19cDQ/IqRhnZuPZbKqtZ5I
VKianyU2Waaf3F7EoCkfIunWmCUiZtOobpv0/05HIXuibtBM6PyQw8pYnW35llD8
Uf0Cgfb+ogiyTbsTlw4mbtcPSjBqQp/B+cwyxyHDfDmDj9Djm9oXsb1b5agDnG0z
NXOnNHqNNn1SDG+Q7/0C28EPwT5N8zaaMBK49ORUdA3E2GFwod0LhCGIMnFHGpjw
MW5cpZKhRBgdGjkAbG7YVcrTW17C3Uzemqoe8zn/7g6p44TZNqruaQ7ZW7KY/8mW
ZVyXC7w7lTrTnpmy1V1rrOBlHKwwFQ==
=OasI
-----END PGP SIGNATURE-----

--oDJ9GP/VwhMGHB5u--
