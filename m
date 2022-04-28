Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1180512DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343797AbiD1IIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343806AbiD1IIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:08:02 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0966F9D4E9;
        Thu, 28 Apr 2022 01:04:47 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CE5A46000D;
        Thu, 28 Apr 2022 08:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651133085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XFs4BoPFxxMdlDnM4BwqsNcAhqErhYQfhGYqvICNnic=;
        b=mp/2iSH7tfbe8g/5WJ3MiWav+wygO0D+A4ld69PaCo5bU9jE9M5pyY2WpYYMvhE10xe2lY
        mtIvqWtsvYA3PCbxGlgXbTbEDoqEG1m+xDzrUovm1CYfVOBaDNQlYzpwe8lvXiyCafaVS3
        zVFguuWu/SLdpeqvTHVavojWQydWEfBNw8iZXfOrE9pQSnsWUulwrG2eCKsZyEImte8tyK
        6ik1cj/nbQTTh61UqFA6YA35nBhqLAaK3S8EffM1M7DY96sDD45Yk7P4sDV/NlEvf4MhvE
        v+/ppmeXSHhl2abOjUsm1EvUIdFzWMCYUPK1wMEUTRrKmkKyhIAS/FtvjazP6A==
Date:   Thu, 28 Apr 2022 10:04:37 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 13/45] media: sun6i-csi: Introduce and use video
 helper functions
Message-ID: <YmpKlePweCAyeOT0@aptenodytes>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
 <20220415152811.636419-14-paul.kocialkowski@bootlin.com>
 <13001485.uLZWGnKmhe@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hbLKg0yuMi8/nDoQ"
Content-Disposition: inline
In-Reply-To: <13001485.uLZWGnKmhe@jernej-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hbLKg0yuMi8/nDoQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jernej,

On Wed 27 Apr 22, 20:50, Jernej =C5=A0krabec wrote:
> Dne petek, 15. april 2022 ob 17:27:39 CEST je Paul Kocialkowski napisal(a=
):
> > Introduce some helpers for buffer and general video configuration.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  .../platform/sunxi/sun6i-csi/sun6i_video.c    | 46 +++++++++++--------
> >  1 file changed, 28 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
> > b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c index
> > e6c85fcc65bb..e47eeb27dc4e 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
> > @@ -92,6 +92,29 @@ static bool sun6i_video_format_check(u32 format)
> >  	return false;
> >  }
> >=20
> > +/* Video */
> > +
> > +static void sun6i_video_buffer_configure(struct sun6i_csi_device *csi_=
dev,
> > +					 struct sun6i_csi_buffer=20
> *csi_buffer)
> > +{
> > +	csi_buffer->queued_to_csi =3D true;
> > +	sun6i_csi_update_buf_addr(csi_dev, csi_buffer->dma_addr);
> > +}
> > +
> > +static void sun6i_video_configure(struct sun6i_csi_device *csi_dev)
> > +{
> > +	struct sun6i_video *video =3D &csi_dev->video;
> > +	struct sun6i_csi_config config =3D { 0 };
> > +
> > +	config.pixelformat =3D video->format.fmt.pix.pixelformat;
> > +	config.code =3D video->mbus_code;
> > +	config.field =3D video->format.fmt.pix.field;
> > +	config.width =3D video->format.fmt.pix.width;
> > +	config.height =3D video->format.fmt.pix.height;
> > +
> > +	sun6i_csi_update_config(csi_dev, &config);
> > +}
> > +
> >  /* Queue */
> >=20
> >  static int sun6i_video_queue_setup(struct vb2_queue *queue,
> > @@ -160,7 +183,6 @@ static int sun6i_video_start_streaming(struct vb2_q=
ueue
> > *queue, struct video_device *video_dev =3D &video->video_dev;
> >  	struct sun6i_csi_buffer *buf;
> >  	struct sun6i_csi_buffer *next_buf;
> > -	struct sun6i_csi_config config;
> >  	struct v4l2_subdev *subdev;
> >  	unsigned long flags;
> >  	int ret;
> > @@ -182,22 +204,13 @@ static int sun6i_video_start_streaming(struct
> > vb2_queue *queue, goto error_media_pipeline;
> >  	}
> >=20
> > -	config.pixelformat =3D video->format.fmt.pix.pixelformat;
> > -	config.code =3D video->mbus_code;
> > -	config.field =3D video->format.fmt.pix.field;
> > -	config.width =3D video->format.fmt.pix.width;
> > -	config.height =3D video->format.fmt.pix.height;
> > -
> > -	ret =3D sun6i_csi_update_config(csi_dev, &config);
> > -	if (ret < 0)
> > -		goto error_media_pipeline;
> > +	sun6i_video_configure(csi_dev);
>=20
> What happened to that error handling? New helper function ignores return =
value=20
> of sun6i_csi_update_config(). Why?

Ah that's a good point, the error value is still being returned by
sun6i_csi_update_config so it should be kept around at this stage.

Note that this is a transitional commit and sun6i_video_configure
(which gets renamed to sun6i_csi_capture_configure) is eventually
reworked to only configure registers (no checks) and returns void.

If you think it's important to keep it in the meantime I can do that.

Paul

> Best regards,
> Jernej
>=20
> >=20
> >  	spin_lock_irqsave(&video->dma_queue_lock, flags);
> >=20
> >  	buf =3D list_first_entry(&video->dma_queue,
> >  			       struct sun6i_csi_buffer, list);
> > -	buf->queued_to_csi =3D true;
> > -	sun6i_csi_update_buf_addr(csi_dev, buf->dma_addr);
> > +	sun6i_video_buffer_configure(csi_dev, buf);
> >=20
> >  	sun6i_csi_set_stream(csi_dev, true);
> >=20
> > @@ -219,8 +232,7 @@ static int sun6i_video_start_streaming(struct vb2_q=
ueue
> > *queue, * would also drop frame when lacking of queued buffer.
> >  	 */
> >  	next_buf =3D list_next_entry(buf, list);
> > -	next_buf->queued_to_csi =3D true;
> > -	sun6i_csi_update_buf_addr(csi_dev, next_buf->dma_addr);
> > +	sun6i_video_buffer_configure(csi_dev, next_buf);
> >=20
> >  	spin_unlock_irqrestore(&video->dma_queue_lock, flags);
> >=20
> > @@ -294,8 +306,7 @@ void sun6i_video_frame_done(struct sun6i_csi_device
> > *csi_dev) * for next ISR call.
> >  	 */
> >  	if (!next_buf->queued_to_csi) {
> > -		next_buf->queued_to_csi =3D true;
> > -		sun6i_csi_update_buf_addr(csi_dev, next_buf->dma_addr);
> > +		sun6i_video_buffer_configure(csi_dev, next_buf);
> >  		dev_dbg(csi_dev->dev, "Frame dropped!\n");
> >  		goto complete;
> >  	}
> > @@ -309,8 +320,7 @@ void sun6i_video_frame_done(struct sun6i_csi_device
> > *csi_dev) /* Prepare buffer for next frame but one.  */
> >  	if (!list_is_last(&next_buf->list, &video->dma_queue)) {
> >  		next_buf =3D list_next_entry(next_buf, list);
> > -		next_buf->queued_to_csi =3D true;
> > -		sun6i_csi_update_buf_addr(csi_dev, next_buf->dma_addr);
> > +		sun6i_video_buffer_configure(csi_dev, next_buf);
> >  	} else {
> >  		dev_dbg(csi_dev->dev, "Next frame will be dropped!\n");
> >  	}
>=20
>=20
>=20
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--hbLKg0yuMi8/nDoQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmJqSpUACgkQ3cLmz3+f
v9F9WQf/Yw9U3I/o7JqV+HsxUfKaf4gX6vbH1O2ZCv4jD06TNpE+RVR8CE2SjqVo
wI0w+RbVZMBT64ueuuqr2dRPuYlJ15WVCgMKU21N8vEAXDxfYVQr4f3/7cj8CBzK
x6vCvWs5dbqKF3ek3S3h7y9iMhDQ9nbVh7dZlJnQfwcAWK+K/aQEfpqnTBKpL3km
MCk9PxVjRtk23TS1pS/GtDids1vtMMNjnaDvfRR/NWd3dfEL25wC72N+7bxNv0fX
06IcEdCHll0ZanSeo/2Rdpy4KFCtC8LI+5xmv4lOZ7M/4+1UdlhI9ArYZvseiK3N
u8wy39tlfO0JuXma+sRGdMQDtSWPQQ==
=30KN
-----END PGP SIGNATURE-----

--hbLKg0yuMi8/nDoQ--
