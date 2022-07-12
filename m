Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8E9571315
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiGLH1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGLH1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:27:36 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E385580533;
        Tue, 12 Jul 2022 00:27:34 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 35FBBFF80D;
        Tue, 12 Jul 2022 07:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1657610853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bpXxgQVLThIrcwbFLdC+Oqd7zgsOvgu2Eviw5gZrkdY=;
        b=ccEsXcUB51//SqpwTJ63LwCEW/LQN962E53svv3qIXAaBo6zFsS2fHOJN8mgheQtZvcO97
        LoPI6a6mJs/TxmHCOcoqgquOdBjkeltDKoVvcyexueYpIKkTJs1fX1cpM74mi/6RPEgkDe
        Gk7AFudTQLM5OXAHMk+A1a5hbK5hp8p20eB2iZN1oYZ5jVG2DDiiluht2dGoNg1ICLZf72
        WmetIP5hpIiVbnB7OlmxiVo7FYGENCgTUyd9rQ57Zj28TccvKfrq5NPsRwsWqeZce1xPDE
        a3cKZYswZZTgxpGOToRyAj5rb49q8rpbR4vWtDyKPyFo247Wx+bfKOYqu8ttlw==
Date:   Tue, 12 Jul 2022 09:27:30 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH v2 7/8] cedrus: Use vb2_find_buffer
Message-ID: <Ys0iYr1PlvPtFV03@aptenodytes>
References: <20220711211141.349902-1-ezequiel@vanguardiasur.com.ar>
 <20220711211141.349902-8-ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dQW3AryerkWbR4hZ"
Content-Disposition: inline
In-Reply-To: <20220711211141.349902-8-ezequiel@vanguardiasur.com.ar>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dQW3AryerkWbR4hZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ezequiel,

On Mon 11 Jul 22, 18:11, Ezequiel Garcia wrote:
> Use the newly introduced vb2_find_buffer API to get a vb2_buffer
> given a buffer timestamp.

Looks good with the changes requested by Jernej!

Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

As a sidenote for later: maybe we could merge cedrus_dst_buf_addr and
cedrus_buf_addr into one.

Thanks,

Paul

> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> Acked-by: Tomasz Figa <tfiga@chromium.org>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus.h   | 24 ++++++-----
>  .../staging/media/sunxi/cedrus/cedrus_h264.c  | 16 +++----
>  .../staging/media/sunxi/cedrus/cedrus_h265.c  | 16 +++----
>  .../staging/media/sunxi/cedrus/cedrus_mpeg2.c | 28 ++++--------
>  .../staging/media/sunxi/cedrus/cedrus_vp8.c   | 43 ++++---------------
>  5 files changed, 46 insertions(+), 81 deletions(-)
>=20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/stagin=
g/media/sunxi/cedrus/cedrus.h
> index 3bc094eb497f..c054dbe3d3bc 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.h
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
> @@ -233,19 +233,23 @@ static inline dma_addr_t cedrus_buf_addr(struct vb2=
_buffer *buf,
>  }
> =20
>  static inline dma_addr_t cedrus_dst_buf_addr(struct cedrus_ctx *ctx,
> -					     int index, unsigned int plane)
> +					     struct vb2_buffer *buf,
> +					     unsigned int plane)
>  {
> -	struct vb2_buffer *buf =3D NULL;
> -	struct vb2_queue *vq;
> -
> -	if (index < 0)
> -		return 0;
> +	return buf ? cedrus_buf_addr(buf, &ctx->dst_fmt, plane) : 0;
> +}
> =20
> -	vq =3D v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
> -	if (vq)
> -		buf =3D vb2_get_buffer(vq, index);
> +static inline void cedrus_write_ref_buf_addr(struct cedrus_ctx *ctx,
> +					     struct vb2_queue *q,
> +					     u64 timestamp,
> +					     u32 luma_reg,
> +					     u32 chroma_reg)
> +{
> +       struct cedrus_dev *dev =3D ctx->dev;
> +       struct vb2_buffer *buf =3D vb2_find_buffer(q, timestamp);
> =20
> -	return buf ? cedrus_buf_addr(buf, &ctx->dst_fmt, plane) : 0;
> +       cedrus_write(dev, luma_reg, cedrus_dst_buf_addr(ctx, buf, 0));
> +       cedrus_write(dev, chroma_reg, cedrus_dst_buf_addr(ctx, buf, 1));
>  }
> =20
>  static inline struct cedrus_buffer *
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/s=
taging/media/sunxi/cedrus/cedrus_h264.c
> index d8fb93035470..0559efeac125 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> @@ -111,16 +111,16 @@ static void cedrus_write_frame_list(struct cedrus_c=
tx *ctx,
>  	for (i =3D 0; i < ARRAY_SIZE(decode->dpb); i++) {
>  		const struct v4l2_h264_dpb_entry *dpb =3D &decode->dpb[i];
>  		struct cedrus_buffer *cedrus_buf;
> -		int buf_idx;
> +		struct vb2_buffer *buf;
> =20
>  		if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_VALID))
>  			continue;
> =20
> -		buf_idx =3D vb2_find_timestamp(cap_q, dpb->reference_ts, 0);
> -		if (buf_idx < 0)
> +		buf =3D vb2_find_buffer(cap_q, dpb->reference_ts);
> +		if (!buf)
>  			continue;
> =20
> -		cedrus_buf =3D vb2_to_cedrus_buffer(cap_q->bufs[buf_idx]);
> +		cedrus_buf =3D vb2_to_cedrus_buffer(buf);
>  		position =3D cedrus_buf->codec.h264.position;
>  		used_dpbs |=3D BIT(position);
> =20
> @@ -186,7 +186,7 @@ static void _cedrus_write_ref_list(struct cedrus_ctx =
*ctx,
>  		const struct v4l2_h264_dpb_entry *dpb;
>  		const struct cedrus_buffer *cedrus_buf;
>  		unsigned int position;
> -		int buf_idx;
> +		struct vb2_buffer *buf;
>  		u8 dpb_idx;
> =20
>  		dpb_idx =3D ref_list[i].index;
> @@ -195,11 +195,11 @@ static void _cedrus_write_ref_list(struct cedrus_ct=
x *ctx,
>  		if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
>  			continue;
> =20
> -		buf_idx =3D vb2_find_timestamp(cap_q, dpb->reference_ts, 0);
> -		if (buf_idx < 0)
> +		buf =3D vb2_find_buffer(cap_q, dpb->reference_ts);
> +		if (!buf)
>  			continue;
> =20
> -		cedrus_buf =3D vb2_to_cedrus_buffer(cap_q->bufs[buf_idx]);
> +		cedrus_buf =3D vb2_to_cedrus_buffer(buf);
>  		position =3D cedrus_buf->codec.h264.position;
> =20
>  		sram_array[i] |=3D position << 1;
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/s=
taging/media/sunxi/cedrus/cedrus_h265.c
> index 44f385be9f6c..60cc13e4d0a9 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> @@ -102,14 +102,14 @@ static void cedrus_h265_frame_info_write_single(str=
uct cedrus_ctx *ctx,
>  						unsigned int index,
>  						bool field_pic,
>  						u32 pic_order_cnt[],
> -						int buffer_index)
> +						struct vb2_buffer *buf)
>  {
>  	struct cedrus_dev *dev =3D ctx->dev;
> -	dma_addr_t dst_luma_addr =3D cedrus_dst_buf_addr(ctx, buffer_index, 0);
> -	dma_addr_t dst_chroma_addr =3D cedrus_dst_buf_addr(ctx, buffer_index, 1=
);
> +	dma_addr_t dst_luma_addr =3D cedrus_dst_buf_addr(ctx, buf, 0);
> +	dma_addr_t dst_chroma_addr =3D cedrus_dst_buf_addr(ctx, buf, 1);
>  	dma_addr_t mv_col_buf_addr[2] =3D {
> -		cedrus_h265_frame_info_mv_col_buf_addr(ctx, buffer_index, 0),
> -		cedrus_h265_frame_info_mv_col_buf_addr(ctx, buffer_index,
> +		cedrus_h265_frame_info_mv_col_buf_addr(ctx, buf->index, 0),
> +		cedrus_h265_frame_info_mv_col_buf_addr(ctx, buf->index,
>  						       field_pic ? 1 : 0)
>  	};
>  	u32 offset =3D VE_DEC_H265_SRAM_OFFSET_FRAME_INFO +
> @@ -141,7 +141,7 @@ static void cedrus_h265_frame_info_write_dpb(struct c=
edrus_ctx *ctx,
>  	unsigned int i;
> =20
>  	for (i =3D 0; i < num_active_dpb_entries; i++) {
> -		int buffer_index =3D vb2_find_timestamp(vq, dpb[i].timestamp, 0);
> +		struct vb2_buffer *buf =3D vb2_find_buffer(vq, dpb[i].timestamp);
>  		u32 pic_order_cnt[2] =3D {
>  			dpb[i].pic_order_cnt[0],
>  			dpb[i].pic_order_cnt[1]
> @@ -149,7 +149,7 @@ static void cedrus_h265_frame_info_write_dpb(struct c=
edrus_ctx *ctx,
> =20
>  		cedrus_h265_frame_info_write_single(ctx, i, dpb[i].field_pic,
>  						    pic_order_cnt,
> -						    buffer_index);
> +						    buf);
>  	}
>  }
> =20
> @@ -616,7 +616,7 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
>  	cedrus_h265_frame_info_write_single(ctx, output_pic_list_index,
>  					    slice_params->pic_struct !=3D 0,
>  					    pic_order_cnt,
> -					    run->dst->vb2_buf.index);
> +					    &run->dst->vb2_buf);
> =20
>  	cedrus_write(dev, VE_DEC_H265_OUTPUT_FRAME_IDX, output_pic_list_index);
> =20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c b/drivers/=
staging/media/sunxi/cedrus/cedrus_mpeg2.c
> index 5dad2f296c6d..22d6cae9a710 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> @@ -54,13 +54,9 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx *ctx,=
 struct cedrus_run *run)
>  	const struct v4l2_ctrl_mpeg2_picture *pic;
>  	const struct v4l2_ctrl_mpeg2_quantisation *quantisation;
>  	dma_addr_t src_buf_addr, dst_luma_addr, dst_chroma_addr;
> -	dma_addr_t fwd_luma_addr, fwd_chroma_addr;
> -	dma_addr_t bwd_luma_addr, bwd_chroma_addr;
>  	struct cedrus_dev *dev =3D ctx->dev;
>  	struct vb2_queue *vq;
>  	const u8 *matrix;
> -	int forward_idx;
> -	int backward_idx;
>  	unsigned int i;
>  	u32 reg;
> =20
> @@ -123,27 +119,19 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx *c=
tx, struct cedrus_run *run)
>  	cedrus_write(dev, VE_DEC_MPEG_PICBOUNDSIZE, reg);
> =20
>  	/* Forward and backward prediction reference buffers. */
> -
>  	vq =3D v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
> =20
> -	forward_idx =3D vb2_find_timestamp(vq, pic->forward_ref_ts, 0);
> -	fwd_luma_addr =3D cedrus_dst_buf_addr(ctx, forward_idx, 0);
> -	fwd_chroma_addr =3D cedrus_dst_buf_addr(ctx, forward_idx, 1);
> -
> -	cedrus_write(dev, VE_DEC_MPEG_FWD_REF_LUMA_ADDR, fwd_luma_addr);
> -	cedrus_write(dev, VE_DEC_MPEG_FWD_REF_CHROMA_ADDR, fwd_chroma_addr);
> -
> -	backward_idx =3D vb2_find_timestamp(vq, pic->backward_ref_ts, 0);
> -	bwd_luma_addr =3D cedrus_dst_buf_addr(ctx, backward_idx, 0);
> -	bwd_chroma_addr =3D cedrus_dst_buf_addr(ctx, backward_idx, 1);
> -
> -	cedrus_write(dev, VE_DEC_MPEG_BWD_REF_LUMA_ADDR, bwd_luma_addr);
> -	cedrus_write(dev, VE_DEC_MPEG_BWD_REF_CHROMA_ADDR, bwd_chroma_addr);
> +	cedrus_write_ref_buf_addr(ctx, vq, pic->forward_ref_ts,
> +				  VE_DEC_MPEG_FWD_REF_LUMA_ADDR,
> +				  VE_DEC_MPEG_FWD_REF_CHROMA_ADDR);
> +	cedrus_write_ref_buf_addr(ctx, vq, pic->backward_ref_ts,
> +				  VE_DEC_MPEG_BWD_REF_LUMA_ADDR,
> +				  VE_DEC_MPEG_BWD_REF_CHROMA_ADDR);
> =20
>  	/* Destination luma and chroma buffers. */
> =20
> -	dst_luma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index, 0);
> -	dst_chroma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index, 1=
);
> +	dst_luma_addr =3D cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 0);
> +	dst_chroma_addr =3D cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 1);
> =20
>  	cedrus_write(dev, VE_DEC_MPEG_REC_LUMA, dst_luma_addr);
>  	cedrus_write(dev, VE_DEC_MPEG_REC_CHROMA, dst_chroma_addr);
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c b/drivers/st=
aging/media/sunxi/cedrus/cedrus_vp8.c
> index f4016684b32d..196cf692186d 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
> @@ -661,7 +661,6 @@ static void cedrus_vp8_setup(struct cedrus_ctx *ctx,
>  	dma_addr_t luma_addr, chroma_addr;
>  	dma_addr_t src_buf_addr;
>  	int header_size;
> -	int qindex;
>  	u32 reg;
> =20
>  	cedrus_engine_enable(ctx, CEDRUS_CODEC_VP8);
> @@ -805,43 +804,17 @@ static void cedrus_vp8_setup(struct cedrus_ctx *ctx,
>  	reg |=3D VE_VP8_LF_DELTA0(slice->lf.mb_mode_delta[0]);
>  	cedrus_write(dev, VE_VP8_MODE_LF_DELTA, reg);
> =20
> -	luma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index, 0);
> -	chroma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index, 1);
> +	luma_addr =3D cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 0);
> +	chroma_addr =3D cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 1);
>  	cedrus_write(dev, VE_VP8_REC_LUMA, luma_addr);
>  	cedrus_write(dev, VE_VP8_REC_CHROMA, chroma_addr);
> =20
> -	qindex =3D vb2_find_timestamp(cap_q, slice->last_frame_ts, 0);
> -	if (qindex >=3D 0) {
> -		luma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 0);
> -		chroma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 1);
> -		cedrus_write(dev, VE_VP8_FWD_LUMA, luma_addr);
> -		cedrus_write(dev, VE_VP8_FWD_CHROMA, chroma_addr);
> -	} else {
> -		cedrus_write(dev, VE_VP8_FWD_LUMA, 0);
> -		cedrus_write(dev, VE_VP8_FWD_CHROMA, 0);
> -	}
> -
> -	qindex =3D vb2_find_timestamp(cap_q, slice->golden_frame_ts, 0);
> -	if (qindex >=3D 0) {
> -		luma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 0);
> -		chroma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 1);
> -		cedrus_write(dev, VE_VP8_BWD_LUMA, luma_addr);
> -		cedrus_write(dev, VE_VP8_BWD_CHROMA, chroma_addr);
> -	} else {
> -		cedrus_write(dev, VE_VP8_BWD_LUMA, 0);
> -		cedrus_write(dev, VE_VP8_BWD_CHROMA, 0);
> -	}
> -
> -	qindex =3D vb2_find_timestamp(cap_q, slice->alt_frame_ts, 0);
> -	if (qindex >=3D 0) {
> -		luma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 0);
> -		chroma_addr =3D cedrus_dst_buf_addr(ctx, qindex, 1);
> -		cedrus_write(dev, VE_VP8_ALT_LUMA, luma_addr);
> -		cedrus_write(dev, VE_VP8_ALT_CHROMA, chroma_addr);
> -	} else {
> -		cedrus_write(dev, VE_VP8_ALT_LUMA, 0);
> -		cedrus_write(dev, VE_VP8_ALT_CHROMA, 0);
> -	}
> +	cedrus_write_ref_buf_addr(ctx, cap_q, slice->last_frame_ts,
> +				  VE_VP8_FWD_LUMA, VE_VP8_FWD_CHROMA);
> +	cedrus_write_ref_buf_addr(ctx, cap_q, slice->golden_frame_ts,
> +				  VE_VP8_BWD_LUMA, VE_VP8_BWD_CHROMA);
> +	cedrus_write_ref_buf_addr(ctx, cap_q, slice->alt_frame_ts,
> +				  VE_VP8_ALT_LUMA, VE_VP8_ALT_CHROMA);
> =20
>  	cedrus_write(dev, VE_H264_CTRL, VE_H264_CTRL_VP8 |
>  		     VE_H264_CTRL_DECODE_ERR_INT |
> --=20
> 2.34.3
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--dQW3AryerkWbR4hZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmLNImIACgkQ3cLmz3+f
v9H86wf/QKozEVXlvJXfKOT7nTAS3FD/saq9Ge8gg8TwiRezKLvVhXGCMkSDlwBg
ifvWS3iKjqUSoouy13SaXTqkcwj69fNvCoOLf6nxGlo5LEEaHRobBVuzRpJCjlNE
sH+DOWMRxtCmU2wTlJmq3E2DzWCjP7ybnllVXQuMU4QXaNu/EPUuZX8GjeUiNLVy
S9AwJK9Ea5ldZiTT2Q4m16eoIgF/npJKJezBz2I5O9y50p66oETMAUMc+AWf1chc
eFrva12tOOzoHr1VmOmNxC9GuxTbq/OjyQqnn1RfRd1bQTRcYwPiqdxX33PMHsHk
IZwzckJtJPC8waVnO+vSqp4zVp327A==
=k9aO
-----END PGP SIGNATURE-----

--dQW3AryerkWbR4hZ--
