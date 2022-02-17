Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E5F4B9CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238964AbiBQKDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:03:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiBQKDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:03:17 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AECECC76;
        Thu, 17 Feb 2022 02:03:03 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id f37so8898362lfv.8;
        Thu, 17 Feb 2022 02:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=RoOTB3vZkQwzYPRZAgiyvvTVPRhf8OFRTaGI84Fbjro=;
        b=LnNVrxyRvAOtmCIOaUu+98tC35/2ib+27Z3s05eSMUxQUEW+kXDdSAYGkXCHAstvNE
         nnLBdEL2keD7bbdKJsikieb9zdYr99fwChFpbUlbz9TNY/byhScBOR5wVnjOo6QIzSK6
         z9x6qknR1sJC9nwV3d+7C+atFhHp/Eqr2lAABkyQW9qcjbvwmGQ+tQf6Lb7GOz80WIQM
         K8ju26q5xc9rJFdDj/TfE7/zwY0ddGEmSzNt4/t3RTA8yInTM3OV9YsO9r+fpBA/QENG
         hp6qlv93rj8A2h5eRVOke6y912QLnvOUBsOf8sx0wSzgGL6ghSEAn6W93AvfEO2hkfIM
         +s5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=RoOTB3vZkQwzYPRZAgiyvvTVPRhf8OFRTaGI84Fbjro=;
        b=hwUMfjcdPVi/JAGziBqVakhn7UuUwpzzbSfYhcxGt1f+j/TWLWl5isPDpYIohQqREP
         fAUNG4znZNUP5egIPFS+/NZVIUJAGNGTlJ8r2b8N75zi1hi6BIjT4BqPLuzRxfn9qF3E
         YAEmo1WF3tXXRzCzvoAGE5m10BToOu4ochuhCcsY1+Nzl6JCOQPT04QyFgcVyI9r8iYK
         vODvC3ytL+sSTsE2benwswC3Qtlz/WiCqN3J4togznDJtXA/k767dHdK1sIbQBXzdPe4
         omg4R8Ee8LTU2/lWDTk+1uJlXUi7VcpVxh3EjmYpKU/i9/zehkYiZNDsWir751ykqpGo
         dRuw==
X-Gm-Message-State: AOAM530dbaYTjojIi3Sk+BvoDrxkvVVKuDLjm8x2ryPlnoDO3sRV6hIa
        lUnZlaET+1Hq5DBfFJSMnzU=
X-Google-Smtp-Source: ABdhPJyHyBSPz0zviYWjFjR0JBinOyr3nCfiuhwyjA+aVFjHKiUoVmaPTr/VjgPeN0WeLb4fsHLoPA==
X-Received: by 2002:a05:6512:2622:b0:442:bd44:8af8 with SMTP id bt34-20020a056512262200b00442bd448af8mr1606991lfb.317.1645092181858;
        Thu, 17 Feb 2022 02:03:01 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id e10sm5110323ljk.30.2022.02.17.02.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 02:03:01 -0800 (PST)
Date:   Thu, 17 Feb 2022 12:02:58 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] drm/fourcc: Add DRM_FORMAT_R[124]
Message-ID: <20220217120258.0ee53dd8@eldfell>
In-Reply-To: <20220215165226.2738568-8-geert@linux-m68k.org>
References: <20220215165226.2738568-1-geert@linux-m68k.org>
        <20220215165226.2738568-8-geert@linux-m68k.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Jt_VVbdBEiI1p4OibkFRGE0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Jt_VVbdBEiI1p4OibkFRGE0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Feb 2022 17:52:25 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Introduce fourcc codes for single-channel frame buffer formats with two,
> four, and sixteen intensity levels.  Traditionally, the first channel
> has been called the "red" channel, but the fourcc can also be used for
> other light-on-dark displays.
>=20
> As the number of bits per pixel is less than eight, these rely on proper
> block handling for the calculation of bits per pixel and pitch.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/gpu/drm/drm_fourcc.c  | 6 ++++++
>  include/uapi/drm/drm_fourcc.h | 9 +++++++++
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index 5c77ce10f53e3a64..c12e48ecb1ab8aad 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -151,6 +151,12 @@ const struct drm_format_info *__drm_format_info(u32 =
format)
>  		{ .format =3D DRM_FORMAT_C4,		.depth =3D 4,  .num_planes =3D 1,
>  		  .char_per_block =3D { 1, }, .block_w =3D { 2, }, .block_h =3D { 1, }=
, .hsub =3D 1, .vsub =3D 1 },
>  		{ .format =3D DRM_FORMAT_C8,		.depth =3D 8,  .num_planes =3D 1, .cpp =
=3D { 1, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> +		{ .format =3D DRM_FORMAT_R1,		.depth =3D 1,  .num_planes =3D 1,
> +		  .char_per_block =3D { 1, }, .block_w =3D { 8, }, .block_h =3D { 1, }=
, .hsub =3D 1, .vsub =3D 1 },
> +		{ .format =3D DRM_FORMAT_R2,		.depth =3D 2,  .num_planes =3D 1,
> +		  .char_per_block =3D { 1, }, .block_w =3D { 4, }, .block_h =3D { 1, }=
, .hsub =3D 1, .vsub =3D 1 },
> +		{ .format =3D DRM_FORMAT_R4,		.depth =3D 4,  .num_planes =3D 1,
> +		  .char_per_block =3D { 1, }, .block_w =3D { 2, }, .block_h =3D { 1, }=
, .hsub =3D 1, .vsub =3D 1 },
>  		{ .format =3D DRM_FORMAT_R8,		.depth =3D 8,  .num_planes =3D 1, .cpp =
=3D { 1, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
>  		{ .format =3D DRM_FORMAT_R10,		.depth =3D 10, .num_planes =3D 1, .cpp =
=3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
>  		{ .format =3D DRM_FORMAT_R12,		.depth =3D 12, .num_planes =3D 1, .cpp =
=3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 3f09174670b3cce6..8605a1acc6813e6c 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -104,6 +104,15 @@ extern "C" {
>  #define DRM_FORMAT_C4		fourcc_code('C', '4', ' ', ' ') /* [3:0] C */
>  #define DRM_FORMAT_C8		fourcc_code('C', '8', ' ', ' ') /* [7:0] C */
> =20
> +/* 1 bpp Red */
> +#define DRM_FORMAT_R1		fourcc_code('R', '1', ' ', ' ') /* [0] R */
> +
> +/* 2 bpp Red */
> +#define DRM_FORMAT_R2		fourcc_code('R', '2', ' ', ' ') /* [1:0] R */
> +
> +/* 4 bpp Red */
> +#define DRM_FORMAT_R4		fourcc_code('R', '4', ' ', ' ') /* [3:0] R */
> +
>  /* 8 bpp Red */
>  #define DRM_FORMAT_R8		fourcc_code('R', '8', ' ', ' ') /* [7:0] R */
> =20

Hi Geert,

I have the same comment here as for C1/C2/C4: these need to specify the
ordering inside a byte. Otherwise this reads as one byte of storage per
pixel, but using only 1/2/4 bits of each byte.

The idea of having Cx and Rx formats separately sounds good to me.


Thanks,
pq

--Sig_/Jt_VVbdBEiI1p4OibkFRGE0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmIOHVIACgkQI1/ltBGq
qqepcA/+LL865J5CZJYZEBDBIYPLhUz/FNe6EH1lYd+zALvj8tkr+/ERUpIYrVo6
syM+GRsn9ZmHtBhvurgkSXnjHQ36oK2EYjOc/o4G5Oa0EkmA38SHlNe+WPL3IVsC
fWKCupfuYHnPT6/WFd50KDv5BAN/FRtguuRByXgp8WopMnlaSGdJ5Q57UliLJNQX
z8S4Zm2WiJ6b55Qb3qfUpSwMt0ScJ/8nmKkXnWlNyEEjxIlFC4vv/EmNJscZn98e
YGiQxlnlzMAIBGIZGZ1iVdzsAtG77UvhpL36W5qcDbPS3R38dyotSEWTEAGzowO2
EuudkRiJVsEmUvuXgPlN1gqo3JKqGXUe/9VXjSZIxnmh6n6pbNdfov1zfFWbipn9
SRJIRy+9Zywuo8xvxIt+XzrKOu000hoEKAkNR5kPMKRFBW0gJlqAldYP5BwxkBjQ
r7eIwzqjuYshHcmcvTTpy88zFR24noSuDIkLpR6PGt+Js1PPzBQdLcqqS7nQfVBl
1mEVZCvtkts92Za17HPwTwTCHBpHXjXtKxb0or83mgaeeWbKVz+sU6FAGuymYvEa
H4pFSBsMkUEPaCkqBY6CB9LKzJgboRNcwkaIaI+Chsrx3JfpI5VkvUlSEcb4fwSi
RksMQvVivoRpEbAcuPX3wVae6WT0ZhZcuPmKSEroBgv9KYBoiOY=
=oi2B
-----END PGP SIGNATURE-----

--Sig_/Jt_VVbdBEiI1p4OibkFRGE0--
