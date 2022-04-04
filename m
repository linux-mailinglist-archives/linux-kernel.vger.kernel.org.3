Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BBF4F18FE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240883AbiDDP67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378820AbiDDP6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:58:51 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0D6427EB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:56:51 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id s11so8084490qtc.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 08:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=oxOs663yUTsQaF87soynkuuBjsTvX+61snvNDnfnDpk=;
        b=chfLUKxMwEMVxSBD2jEIRK7tGSH7AVdL1lvo/9Ye7Ui1fkiTef2W1bVpebglZLUlzg
         1Q2l/8FKmI+QYKZpZ7QkVLv9KW1+QnhiOv8e3cmTbzZ0BplKdYBcwi2Z3zpgdqQSS/a2
         Riih5TYQyc0SgsH5G6n5CZ36/B1jwHgk8IfvGhI2I5BrEHOfJ6lHnnUZMdXbJuHTl/+p
         V2aGoKoOUVXkwtGDxIp5vEgPKBMsfF3+gT16w+DOUnkBiUBpgUu8dYm9MUToqerw548Z
         hSa6U6zzRBbotpB6IvWsKFMQ9V0AQKByQ4WninpIjJu+7eAo5bkCP4DBYRb3Sj43O8OF
         SrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=oxOs663yUTsQaF87soynkuuBjsTvX+61snvNDnfnDpk=;
        b=RmBn3kaP7NX84sRhizA+NQfDecAAMxAu0hWSt32r5IOsPFqpegbsY0E91qs/JTLraz
         xH0/y3dFHoQgs9gvpHJ169iAXg6ekw0qMlTWMXCUqynUyG1uLgcW01ghnwm4GVxwvGqn
         TMrXQ71iK80QbBY1Zle1HvQAnMiPk2Ut78Iyqy096zHaKrYeogNSl1+LWZFKUNE9PUGs
         /Tv5zKVk1CoIfdw7GWSUZh+CZ5l+TcL7YwvnOnrTC85iNi2bNherZ4rHFSx1rIo0IvfE
         NpXPPY1xlXlOaJgNRHvciXkSalPu/qni3J2PiuANWxnp5WiFoJqZ31waDcCrn3AGRPzm
         ySnw==
X-Gm-Message-State: AOAM532DBFLmiMBWybMXJZnOeqLiJV4dSkdS4BFtNBmuZzebHxk/nYdG
        DdIStY/tBxpEjwQkMZBlClcTEg==
X-Google-Smtp-Source: ABdhPJw2/icBGrgAgwAxRbBd++PjY8dJNbX4PyEG8FXVChXg4BbE0MkqxL4xHnIBPpHIB/5SWIfQ2g==
X-Received: by 2002:ac8:5a47:0:b0:2e1:e78c:8367 with SMTP id o7-20020ac85a47000000b002e1e78c8367mr664250qta.126.1649087809994;
        Mon, 04 Apr 2022 08:56:49 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id b2-20020ac87fc2000000b002e1b9ddb629sm8462150qtk.47.2022.04.04.08.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 08:56:49 -0700 (PDT)
Message-ID: <ffe596b7ea7aef81c40ec1859dec0d9255038570.camel@ndufresne.ca>
Subject: Re: [PATCH v4 05/15] media: uapi: HEVC: Rename HEVC stateless
 controls with STATELESS prefix
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, jonas@kwiboo.se
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com, jc@kynesim.co.uk
Date:   Mon, 04 Apr 2022 11:56:47 -0400
In-Reply-To: <20220228140838.622021-6-benjamin.gaignard@collabora.com>
References: <20220228140838.622021-1-benjamin.gaignard@collabora.com>
         <20220228140838.622021-6-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 28 f=C3=A9vrier 2022 =C3=A0 15:08 +0100, Benjamin Gaignard a =C3=
=A9crit=C2=A0:
> Change HEVC  stateless controls names to V4L2_CID_STATELESS_HEVC instead
> of V4L2_CID_MPEG_VIDEO_HEVC be coherent with v4l2 naming convention.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> version 4:
> - put controls under stateless section in v4l2-ctrls-defs.c
>=20
>  .../media/v4l/ext-ctrls-codec.rst             | 26 +++++++--------
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c     | 32 +++++++++----------
>  drivers/staging/media/hantro/hantro_drv.c     | 26 +++++++--------
>  drivers/staging/media/hantro/hantro_hevc.c    |  8 ++---
>  drivers/staging/media/sunxi/cedrus/cedrus.c   | 24 +++++++-------
>  .../staging/media/sunxi/cedrus/cedrus_dec.c   | 10 +++---
>  include/media/hevc-ctrls.h                    | 26 +++++++--------
>  7 files changed, 76 insertions(+), 76 deletions(-)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/=
Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index d096cb75993a..acf49420e56d 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -2639,7 +2639,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
> =20
>  .. _v4l2-mpeg-hevc:
> =20
> -``V4L2_CID_MPEG_VIDEO_HEVC_SPS (struct)``
> +``V4L2_CID_STATELESS_HEVC_SPS (struct)``
>      Specifies the Sequence Parameter Set fields (as extracted from the
>      bitstream) for the associated HEVC slice data.
>      These bitstream parameters are defined according to :ref:`hevc`.
> @@ -2792,7 +2792,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
> =20
>      \normalsize
> =20
> -``V4L2_CID_MPEG_VIDEO_HEVC_PPS (struct)``
> +``V4L2_CID_STATELESS_HEVC_PPS (struct)``
>      Specifies the Picture Parameter Set fields (as extracted from the
>      bitstream) for the associated HEVC slice data.
>      These bitstream parameters are defined according to :ref:`hevc`.
> @@ -2945,7 +2945,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
> =20
>      \normalsize
> =20
> -``V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS (struct)``
> +``V4L2_CID_STATELESS_HEVC_SLICE_PARAMS (struct)``
>      Specifies various slice-specific parameters, especially from the NAL=
 unit
>      header, general slice segment header and weighted prediction paramet=
er
>      parts of the bitstream.
> @@ -3110,7 +3110,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
> =20
>      \normalsize
> =20
> -``V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX (struct)``
> +``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
>      Specifies the HEVC scaling matrix parameters used for the scaling pr=
ocess
>      for transform coefficients.
>      These matrix and parameters are defined according to :ref:`hevc`.
> @@ -3260,7 +3260,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
> =20
>      \normalsize
> =20
> -``V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE (enum)``
> +``V4L2_CID_STATELESS_HEVC_DECODE_MODE (enum)``
>      Specifies the decoding mode to use. Currently exposes slice-based an=
d
>      frame-based decoding but new modes might be added later on.
>      This control is used as a modifier for V4L2_PIX_FMT_HEVC_SLICE
> @@ -3275,7 +3275,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>         This menu control is not yet part of the public kernel API and
>         it is expected to change.
> =20
> -.. c:type:: v4l2_mpeg_video_hevc_decode_mode
> +.. c:type:: v4l2_stateless_hevc_decode_mode
> =20
>  .. raw:: latex
> =20
> @@ -3288,11 +3288,11 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>      :stub-columns: 0
>      :widths:       1 1 2
> =20
> -    * - ``V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_SLICE_BASED``
> +    * - ``V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED``
>        - 0
>        - Decoding is done at the slice granularity.
>          The OUTPUT buffer must contain a single slice.
> -    * - ``V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_FRAME_BASED``
> +    * - ``V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED``
>        - 1
>        - Decoding is done at the frame granularity.
>          The OUTPUT buffer must contain all slices needed to decode the
> @@ -3302,7 +3302,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
> =20
>      \normalsize
> =20
> -``V4L2_CID_MPEG_VIDEO_HEVC_START_CODE (enum)``
> +``V4L2_CID_STATELESS_HEVC_START_CODE (enum)``
>      Specifies the HEVC slice start code expected for each slice.
>      This control is used as a modifier for V4L2_PIX_FMT_HEVC_SLICE
>      pixel format. Applications that support V4L2_PIX_FMT_HEVC_SLICE
> @@ -3316,7 +3316,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>         This menu control is not yet part of the public kernel API and
>         it is expected to change.
> =20
> -.. c:type:: v4l2_mpeg_video_hevc_start_code
> +.. c:type:: v4l2_stateless_hevc_start_code
> =20
>  .. tabularcolumns:: |p{9.2cm}|p{0.6cm}|p{7.5cm}|
> =20
> @@ -3325,13 +3325,13 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>      :stub-columns: 0
>      :widths:       1 1 2
> =20
> -    * - ``V4L2_MPEG_VIDEO_HEVC_START_CODE_NONE``
> +    * - ``V4L2_STATELESS_HEVC_START_CODE_NONE``
>        - 0
>        - Selecting this value specifies that HEVC slices are passed
>          to the driver without any start code. The bitstream data should =
be
>          according to :ref:`hevc` 7.3.1.1 General NAL unit syntax, hence
>          contains emulation prevention bytes when required.
> -    * - ``V4L2_MPEG_VIDEO_HEVC_START_CODE_ANNEX_B``
> +    * - ``V4L2_STATELESS_HEVC_START_CODE_ANNEX_B``
>        - 1
>        - Selecting this value specifies that HEVC slices are expected
>          to be prefixed by Annex B start codes. According to :ref:`hevc`
> @@ -3364,7 +3364,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>      This provides a bitmask which consists of bits [0, LTR_COUNT-1].
>      This is applicable to the H264 and HEVC encoders.
> =20
> -``V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS (struct)``
> +``V4L2_CID_STATELESS_HEVC_DECODE_PARAMS (struct)``
>      Specifies various decode parameters, especially the references pictu=
re order
>      count (POC) for all the lists (short, long, before, current, after) =
and the
>      number of entries for each of them.
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4=
l2-core/v4l2-ctrls-defs.c
> index 54ca4e6b820b..4b68cbe23309 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -699,9 +699,9 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
>  		return hevc_tier;
>  	case V4L2_CID_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE:
>  		return hevc_loop_filter_mode;
> -	case V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE:
> +	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:
>  		return hevc_decode_mode;
> -	case V4L2_CID_MPEG_VIDEO_HEVC_START_CODE:
> +	case V4L2_CID_STATELESS_HEVC_START_CODE:
>  		return hevc_start_code;
>  	case V4L2_CID_CAMERA_ORIENTATION:
>  		return camera_orientation;
> @@ -995,13 +995,6 @@ const char *v4l2_ctrl_get_name(u32 id)
>  	case V4L2_CID_MPEG_VIDEO_HEVC_SIZE_OF_LENGTH_FIELD:	return "HEVC Size o=
f Length Field";
>  	case V4L2_CID_MPEG_VIDEO_REF_NUMBER_FOR_PFRAMES:	return "Reference Fram=
es for a P-Frame";
>  	case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:		return "Prepend SPS an=
d PPS to IDR";
> -	case V4L2_CID_MPEG_VIDEO_HEVC_SPS:			return "HEVC Sequence Parameter Se=
t";
> -	case V4L2_CID_MPEG_VIDEO_HEVC_PPS:			return "HEVC Picture Parameter Set=
";
> -	case V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS:		return "HEVC Slice Paramet=
ers";
> -	case V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX:		return "HEVC Scaling Mat=
rix";
> -	case V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS:		return "HEVC Decode Param=
eters";
> -	case V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE:		return "HEVC Decode Mode";
> -	case V4L2_CID_MPEG_VIDEO_HEVC_START_CODE:		return "HEVC Start Code";
> =20
>  	/* CAMERA controls */
>  	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
> @@ -1180,6 +1173,13 @@ const char *v4l2_ctrl_get_name(u32 id)
>  	case V4L2_CID_STATELESS_MPEG2_QUANTISATION:		return "MPEG-2 Quantisatio=
n Matrices";
>  	case V4L2_CID_STATELESS_VP9_COMPRESSED_HDR:	return "VP9 Probabilities U=
pdates";
>  	case V4L2_CID_STATELESS_VP9_FRAME:			return "VP9 Frame Decode Parameter=
s";
> +	case V4L2_CID_STATELESS_HEVC_SPS:			return "HEVC Sequence Parameter Set=
";
> +	case V4L2_CID_STATELESS_HEVC_PPS:			return "HEVC Picture Parameter Set"=
;
> +	case V4L2_CID_STATELESS_HEVC_SLICE_PARAMS:		return "HEVC Slice Paramete=
rs";
> +	case V4L2_CID_STATELESS_HEVC_SCALING_MATRIX:		return "HEVC Scaling Matr=
ix";
> +	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:		return "HEVC Decode Parame=
ters";
> +	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:		return "HEVC Decode Mode";
> +	case V4L2_CID_STATELESS_HEVC_START_CODE:		return "HEVC Start Code";
> =20
>  	/* Colorimetry controls */
>  	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
> @@ -1355,8 +1355,8 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum=
 v4l2_ctrl_type *type,
>  	case V4L2_CID_MPEG_VIDEO_HEVC_SIZE_OF_LENGTH_FIELD:
>  	case V4L2_CID_MPEG_VIDEO_HEVC_TIER:
>  	case V4L2_CID_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE:
> -	case V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE:
> -	case V4L2_CID_MPEG_VIDEO_HEVC_START_CODE:
> +	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:
> +	case V4L2_CID_STATELESS_HEVC_START_CODE:
>  	case V4L2_CID_STATELESS_H264_DECODE_MODE:
>  	case V4L2_CID_STATELESS_H264_START_CODE:
>  	case V4L2_CID_CAMERA_ORIENTATION:
> @@ -1493,19 +1493,19 @@ void v4l2_ctrl_fill(u32 id, const char **name, en=
um v4l2_ctrl_type *type,
>  	case V4L2_CID_STATELESS_VP8_FRAME:
>  		*type =3D V4L2_CTRL_TYPE_VP8_FRAME;
>  		break;
> -	case V4L2_CID_MPEG_VIDEO_HEVC_SPS:
> +	case V4L2_CID_STATELESS_HEVC_SPS:
>  		*type =3D V4L2_CTRL_TYPE_HEVC_SPS;
>  		break;
> -	case V4L2_CID_MPEG_VIDEO_HEVC_PPS:
> +	case V4L2_CID_STATELESS_HEVC_PPS:
>  		*type =3D V4L2_CTRL_TYPE_HEVC_PPS;
>  		break;
> -	case V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS:
> +	case V4L2_CID_STATELESS_HEVC_SLICE_PARAMS:
>  		*type =3D V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS;
>  		break;
> -	case V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX:
> +	case V4L2_CID_STATELESS_HEVC_SCALING_MATRIX:
>  		*type =3D V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX;
>  		break;
> -	case V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS:
> +	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:
>  		*type =3D V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS;
>  		break;
>  	case V4L2_CID_STATELESS_VP9_COMPRESSED_HDR:
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/=
media/hantro/hantro_drv.c
> index dc768884cb79..6f58c259d8fc 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -255,7 +255,7 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>  		if (sps->bit_depth_luma_minus8 !=3D 0)
>  			/* Only 8-bit is supported */
>  			return -EINVAL;
> -	} else if (ctrl->id =3D=3D V4L2_CID_MPEG_VIDEO_HEVC_SPS) {
> +	} else if (ctrl->id =3D=3D V4L2_CID_STATELESS_HEVC_SPS) {
>  		const struct v4l2_ctrl_hevc_sps *sps =3D ctrl->p_new.p_hevc_sps;
> =20
>  		if (sps->bit_depth_luma_minus8 !=3D sps->bit_depth_chroma_minus8)
> @@ -428,18 +428,18 @@ static const struct hantro_ctrl controls[] =3D {
>  	}, {
>  		.codec =3D HANTRO_HEVC_DECODER,
>  		.cfg =3D {
> -			.id =3D V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE,
> -			.min =3D V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_FRAME_BASED,
> -			.max =3D V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_FRAME_BASED,
> -			.def =3D V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_FRAME_BASED,
> +			.id =3D V4L2_CID_STATELESS_HEVC_DECODE_MODE,
> +			.min =3D V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
> +			.max =3D V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
> +			.def =3D V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
>  		},
>  	}, {
>  		.codec =3D HANTRO_HEVC_DECODER,
>  		.cfg =3D {
> -			.id =3D V4L2_CID_MPEG_VIDEO_HEVC_START_CODE,
> -			.min =3D V4L2_MPEG_VIDEO_HEVC_START_CODE_ANNEX_B,
> -			.max =3D V4L2_MPEG_VIDEO_HEVC_START_CODE_ANNEX_B,
> -			.def =3D V4L2_MPEG_VIDEO_HEVC_START_CODE_ANNEX_B,
> +			.id =3D V4L2_CID_STATELESS_HEVC_START_CODE,
> +			.min =3D V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
> +			.max =3D V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
> +			.def =3D V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
>  		},
>  	}, {
>  		.codec =3D HANTRO_HEVC_DECODER,
> @@ -459,23 +459,23 @@ static const struct hantro_ctrl controls[] =3D {
>  	}, {
>  		.codec =3D HANTRO_HEVC_DECODER,
>  		.cfg =3D {
> -			.id =3D V4L2_CID_MPEG_VIDEO_HEVC_SPS,
> +			.id =3D V4L2_CID_STATELESS_HEVC_SPS,
>  			.ops =3D &hantro_ctrl_ops,
>  		},
>  	}, {
>  		.codec =3D HANTRO_HEVC_DECODER,
>  		.cfg =3D {
> -			.id =3D V4L2_CID_MPEG_VIDEO_HEVC_PPS,
> +			.id =3D V4L2_CID_STATELESS_HEVC_PPS,
>  		},
>  	}, {
>  		.codec =3D HANTRO_HEVC_DECODER,
>  		.cfg =3D {
> -			.id =3D V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS,
> +			.id =3D V4L2_CID_STATELESS_HEVC_DECODE_PARAMS,
>  		},
>  	}, {
>  		.codec =3D HANTRO_HEVC_DECODER,
>  		.cfg =3D {
> -			.id =3D V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX,
> +			.id =3D V4L2_CID_STATELESS_HEVC_SCALING_MATRIX,
>  		},
>  	}, {
>  		.codec =3D HANTRO_HEVC_DECODER,
> diff --git a/drivers/staging/media/hantro/hantro_hevc.c b/drivers/staging=
/media/hantro/hantro_hevc.c
> index b49a41d7ae91..b6ec86d03d91 100644
> --- a/drivers/staging/media/hantro/hantro_hevc.c
> +++ b/drivers/staging/media/hantro/hantro_hevc.c
> @@ -201,22 +201,22 @@ int hantro_hevc_dec_prepare_run(struct hantro_ctx *=
ctx)
>  	hantro_start_prepare_run(ctx);
> =20
>  	ctrls->decode_params =3D
> -		hantro_get_ctrl(ctx, V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS);
> +		hantro_get_ctrl(ctx, V4L2_CID_STATELESS_HEVC_DECODE_PARAMS);
>  	if (WARN_ON(!ctrls->decode_params))
>  		return -EINVAL;
> =20
>  	ctrls->scaling =3D
> -		hantro_get_ctrl(ctx, V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX);
> +		hantro_get_ctrl(ctx, V4L2_CID_STATELESS_HEVC_SCALING_MATRIX);
>  	if (WARN_ON(!ctrls->scaling))
>  		return -EINVAL;
> =20
>  	ctrls->sps =3D
> -		hantro_get_ctrl(ctx, V4L2_CID_MPEG_VIDEO_HEVC_SPS);
> +		hantro_get_ctrl(ctx, V4L2_CID_STATELESS_HEVC_SPS);
>  	if (WARN_ON(!ctrls->sps))
>  		return -EINVAL;
> =20
>  	ctrls->pps =3D
> -		hantro_get_ctrl(ctx, V4L2_CID_MPEG_VIDEO_HEVC_PPS);
> +		hantro_get_ctrl(ctx, V4L2_CID_STATELESS_HEVC_PPS);
>  	if (WARN_ON(!ctrls->pps))
>  		return -EINVAL;
> =20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/stagin=
g/media/sunxi/cedrus/cedrus.c
> index 4a4b714b0f26..e0428163f82c 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> @@ -42,7 +42,7 @@ static int cedrus_try_ctrl(struct v4l2_ctrl *ctrl)
>  		if (sps->bit_depth_luma_minus8 !=3D 0)
>  			/* Only 8-bit is supported */
>  			return -EINVAL;
> -	} else if (ctrl->id =3D=3D V4L2_CID_MPEG_VIDEO_HEVC_SPS) {
> +	} else if (ctrl->id =3D=3D V4L2_CID_STATELESS_HEVC_SPS) {
>  		const struct v4l2_ctrl_hevc_sps *sps =3D ctrl->p_new.p_hevc_sps;
>  		struct cedrus_ctx *ctx =3D container_of(ctrl->handler, struct cedrus_c=
tx, hdl);
> =20
> @@ -164,42 +164,42 @@ static const struct cedrus_control cedrus_controls[=
] =3D {
>  	},
>  	{
>  		.cfg =3D {
> -			.id	=3D V4L2_CID_MPEG_VIDEO_HEVC_SPS,
> +			.id	=3D V4L2_CID_STATELESS_HEVC_SPS,
>  			.ops	=3D &cedrus_ctrl_ops,
>  		},
>  		.codec		=3D CEDRUS_CODEC_H265,
>  	},
>  	{
>  		.cfg =3D {
> -			.id	=3D V4L2_CID_MPEG_VIDEO_HEVC_PPS,
> +			.id	=3D V4L2_CID_STATELESS_HEVC_PPS,
>  		},
>  		.codec		=3D CEDRUS_CODEC_H265,
>  	},
>  	{
>  		.cfg =3D {
> -			.id	=3D V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS,
> +			.id	=3D V4L2_CID_STATELESS_HEVC_SLICE_PARAMS,
>  		},
>  		.codec		=3D CEDRUS_CODEC_H265,
>  	},
>  	{
>  		.cfg =3D {
> -			.id	=3D V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX,
> +			.id	=3D V4L2_CID_STATELESS_HEVC_SCALING_MATRIX,
>  		},
>  		.codec		=3D CEDRUS_CODEC_H265,
>  	},
>  	{
>  		.cfg =3D {
> -			.id	=3D V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE,
> -			.max	=3D V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_SLICE_BASED,
> -			.def	=3D V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_SLICE_BASED,
> +			.id	=3D V4L2_CID_STATELESS_HEVC_DECODE_MODE,
> +			.max	=3D V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
> +			.def	=3D V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
>  		},
>  		.codec		=3D CEDRUS_CODEC_H265,
>  	},
>  	{
>  		.cfg =3D {
> -			.id	=3D V4L2_CID_MPEG_VIDEO_HEVC_START_CODE,
> -			.max	=3D V4L2_MPEG_VIDEO_HEVC_START_CODE_NONE,
> -			.def	=3D V4L2_MPEG_VIDEO_HEVC_START_CODE_NONE,
> +			.id	=3D V4L2_CID_STATELESS_HEVC_START_CODE,
> +			.max	=3D V4L2_STATELESS_HEVC_START_CODE_NONE,
> +			.def	=3D V4L2_STATELESS_HEVC_START_CODE_NONE,
>  		},
>  		.codec		=3D CEDRUS_CODEC_H265,
>  	},
> @@ -211,7 +211,7 @@ static const struct cedrus_control cedrus_controls[] =
=3D {
>  	},
>  	{
>  		.cfg =3D {
> -			.id =3D V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS,
> +			.id =3D V4L2_CID_STATELESS_HEVC_DECODE_PARAMS,
>  		},
>  		.codec		=3D CEDRUS_CODEC_H265,
>  	},
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/st=
aging/media/sunxi/cedrus/cedrus_dec.c
> index a16c1422558f..f6be4ae72ee2 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> @@ -65,15 +65,15 @@ void cedrus_device_run(void *priv)
> =20
>  	case V4L2_PIX_FMT_HEVC_SLICE:
>  		run.h265.sps =3D cedrus_find_control_data(ctx,
> -			V4L2_CID_MPEG_VIDEO_HEVC_SPS);
> +			V4L2_CID_STATELESS_HEVC_SPS);
>  		run.h265.pps =3D cedrus_find_control_data(ctx,
> -			V4L2_CID_MPEG_VIDEO_HEVC_PPS);
> +			V4L2_CID_STATELESS_HEVC_PPS);
>  		run.h265.slice_params =3D cedrus_find_control_data(ctx,
> -			V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS);
> +			V4L2_CID_STATELESS_HEVC_SLICE_PARAMS);
>  		run.h265.decode_params =3D cedrus_find_control_data(ctx,
> -			V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS);
> +			V4L2_CID_STATELESS_HEVC_DECODE_PARAMS);
>  		run.h265.scaling_matrix =3D cedrus_find_control_data(ctx,
> -			V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX);
> +			V4L2_CID_STATELESS_HEVC_SCALING_MATRIX);
>  		break;
> =20
>  	case V4L2_PIX_FMT_VP8_FRAME:
> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> index a329e086a89a..b3540167df9e 100644
> --- a/include/media/hevc-ctrls.h
> +++ b/include/media/hevc-ctrls.h
> @@ -16,13 +16,13 @@
>  /* The pixel format isn't stable at the moment and will likely be rename=
d. */
>  #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC =
parsed slices */
> =20
> -#define V4L2_CID_MPEG_VIDEO_HEVC_SPS		(V4L2_CID_CODEC_BASE + 1008)
> -#define V4L2_CID_MPEG_VIDEO_HEVC_PPS		(V4L2_CID_CODEC_BASE + 1009)
> -#define V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS	(V4L2_CID_CODEC_BASE + 101=
0)
> -#define V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX	(V4L2_CID_CODEC_BASE + 1=
011)
> -#define V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_BASE + 10=
12)
> -#define V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE + 1015=
)
> -#define V4L2_CID_MPEG_VIDEO_HEVC_START_CODE	(V4L2_CID_CODEC_BASE + 1016)
> +#define V4L2_CID_STATELESS_HEVC_SPS		(V4L2_CID_CODEC_BASE + 1008)
> +#define V4L2_CID_STATELESS_HEVC_PPS		(V4L2_CID_CODEC_BASE + 1009)
> +#define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS	(V4L2_CID_CODEC_BASE + 1010=
)
> +#define V4L2_CID_STATELESS_HEVC_SCALING_MATRIX	(V4L2_CID_CODEC_BASE + 10=
11)
> +#define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_BASE + 101=
2)
> +#define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE + 1015)
> +#define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_BASE + 1016)
> =20
>  /* enum v4l2_ctrl_type type values */
>  #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
> @@ -31,14 +31,14 @@
>  #define V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX 0x0123
>  #define V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS 0x0124
> =20
> -enum v4l2_mpeg_video_hevc_decode_mode {
> -	V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_SLICE_BASED,
> -	V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_FRAME_BASED,
> +enum v4l2_stateless_hevc_decode_mode {
> +	V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
> +	V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
>  };
> =20
> -enum v4l2_mpeg_video_hevc_start_code {
> -	V4L2_MPEG_VIDEO_HEVC_START_CODE_NONE,
> -	V4L2_MPEG_VIDEO_HEVC_START_CODE_ANNEX_B,
> +enum v4l2_stateless_hevc_start_code {
> +	V4L2_STATELESS_HEVC_START_CODE_NONE,
> +	V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
>  };
> =20
>  #define V4L2_HEVC_SLICE_TYPE_B	0

