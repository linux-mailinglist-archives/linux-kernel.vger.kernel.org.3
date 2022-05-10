Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DED52255E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 22:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbiEJUVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 16:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiEJUV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 16:21:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188ED1B3BB9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 13:21:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1noWM9-00045f-Qa; Tue, 10 May 2022 22:21:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1noWM9-001YX0-QC; Tue, 10 May 2022 22:21:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1noWM7-008sln-PZ; Tue, 10 May 2022 22:21:15 +0200
Date:   Tue, 10 May 2022 22:21:11 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
Subject: Re: [PATCH 1/2] pwm: pwm-mediatek: Add support for MediaTek Helio
 X10 MT6795
Message-ID: <20220510202111.lbdtqr3i6i3m4hmb@pengutronix.de>
References: <20220503105405.54832-1-angelogioacchino.delregno@collabora.com>
 <20220503105405.54832-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wdtfek4vpxlvgeau"
Content-Disposition: inline
In-Reply-To: <20220503105405.54832-2-angelogioacchino.delregno@collabora.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wdtfek4vpxlvgeau
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 03, 2022 at 12:54:04PM +0200, AngeloGioacchino Del Regno wrote:
> The MediaTek Helio X10 MT6795 SoC has 7 PWMs: add a compatible string
> to use the right match data.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

LGTM

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wdtfek4vpxlvgeau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJ6yTQACgkQwfwUeK3K
7AnFkgf8CEb9HpPafjms8PISGpb1A+Q2khebLOLn50vUSlGgw0nQa+4pZESMHZyC
h0hs5fyOboYaGCZ5Lbl2+u9weIDwOo8kWR4juafflr+yrSUmU7/SvUm6whOhwKyM
4WGSasaDyyaI5Tu5V4AxjG9Uktc7l3LKdG6RsbXmh+pxsYR84faCAztr8fsJ8CnV
YBJLqFDts+Zv8xO77mQY+b2v6v9cmee6iDc7hNQl9Lcxd2iZ/xsJu89Polf+B6bx
iChumB+l6opA0uI0qWXBA7/AfZPDg4tGVG824HdpzSGranGnVRVZqWq6a1BY+jtd
khpkFUchFBNgTRsi7ey7QPBwFLq4gg==
=UxND
-----END PGP SIGNATURE-----

--wdtfek4vpxlvgeau--
