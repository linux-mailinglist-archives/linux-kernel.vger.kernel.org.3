Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8129B562EBD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbiGAIrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiGAIrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:47:17 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991EC735A0;
        Fri,  1 Jul 2022 01:47:15 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5FFB220015;
        Fri,  1 Jul 2022 08:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656665233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tCKiu9UVJfksHqgDLzozOfGbaUpNB7t/2OMHm7HVzjc=;
        b=PKR6wnsqRd5W9qPKz+LIaEvioP/9C+wbOgTd6SC+Z0WenLwqtVEd9+IMm7IOnFq/ZIQRp5
        IoexIv7cUOXK0I4dg18iVKxDDpa4MjvVLoZpI1ECwCw67XWjTpaUiBH2LBpH0sVP8F1ep/
        rYd038j4mBXtzPhCEcnafds3P3xBHhxEupo4HQMPMdIujpxFxIw3GqlynjvCGQz5DL1k1h
        LAsND+4U6thEgQtSrwjW9q1hyp1FmispmvSg3ZWGNvnYKz+Ac+E6H72U+lrM1XXddl1FDh
        IgayEjMo/EMxCZS4BC/g6nbYdhCcTmUD6t+dM3mGT0DKPC2RPhjqCi9iE+8x1Q==
Date:   Fri, 1 Jul 2022 10:47:10 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
Subject: Re: [PATCH 3/7] media: hantro: HEVC: Fix chroma offset computation
Message-ID: <Yr60jj4OOAM6plWC@aptenodytes>
References: <20220617115802.396442-1-benjamin.gaignard@collabora.com>
 <20220617115802.396442-4-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a0X7j1VNZJp1Rx4A"
Content-Disposition: inline
In-Reply-To: <20220617115802.396442-4-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a0X7j1VNZJp1Rx4A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Benjamin,

On Fri 17 Jun 22, 13:57, Benjamin Gaignard wrote:
> The chroma offset depends of the bitstream depth.
> Make sure that ctx->bit_depth is used to compute it.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/staging/media/hantro/hantro_g2_hevc_dec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/=
staging/media/hantro/hantro_g2_hevc_dec.c
> index 9eac133bda68..8407ad45b7b7 100644
> --- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> +++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> @@ -12,7 +12,7 @@
> =20
>  static size_t hantro_hevc_chroma_offset(struct hantro_ctx *ctx)
>  {
> -	return ctx->dst_fmt.width * ctx->dst_fmt.height;
> +	return ctx->dst_fmt.width * ctx->dst_fmt.height * ctx->bit_depth / 8;

Is this a case for DIV_ROUND_UP or are you sure the rounded-down size is al=
ways
sufficient?

Cheers,

Paul

>  }
> =20
>  static size_t hantro_hevc_motion_vectors_offset(struct hantro_ctx *ctx)
> --=20
> 2.32.0
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--a0X7j1VNZJp1Rx4A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmK+tI4ACgkQ3cLmz3+f
v9FI6gf+OMP0FLYqOVzpR7SYs1HX+twVAKRGc9qUg00x8P8t2OXlXvlkxE9qN+bW
A1e9/jH6hE4ngt7bK+DZHrpf9eSYHA8axTSTu2ftFceFjMydrJLcG3GjYW+xDgdF
CBUjb8sPZXZAD5qb2nPyk6+wPonGYQNpx5Zcxxq/n1kaa2xEv99pgVXFB11Sl71S
PGPt2X0N50/BboLoDDEm/eTHGMAtitTh6M5JVKK/rlaHUMVmh6+sdzcQ3J3pWUIP
asPKQQVQt1d/UvbkJBWfPj9/sWuzTm3t2B6WIq3IlinVruUWBGSZGM1sEUVauZvk
xsAwJqD/PUfhZIAKHmr+oYze+ZAjGA==
=OrxB
-----END PGP SIGNATURE-----

--a0X7j1VNZJp1Rx4A--
