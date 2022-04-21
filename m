Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C9250A129
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387494AbiDUNvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387457AbiDUNvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:51:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6110381BE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:48:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nhXAT-0005v7-9y; Thu, 21 Apr 2022 15:48:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nhXAS-004N86-2u; Thu, 21 Apr 2022 15:48:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nhXAP-004hN3-N3; Thu, 21 Apr 2022 15:48:17 +0200
Date:   Thu, 21 Apr 2022 15:48:08 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     xinlei.lee@mediatek.com, thierry.reding@gmail.com,
        lee.jones@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rex-bc.chen@mediatek.com,
        jitao.shi@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v6, 5/5] dt-bindings: pwm: Add interrupts property for
 MediaTek MT8192
Message-ID: <20220421134808.sqnecvysuzlgdsz5@pengutronix.de>
References: <1650284456-16407-1-git-send-email-xinlei.lee@mediatek.com>
 <1650284456-16407-6-git-send-email-xinlei.lee@mediatek.com>
 <a92d3b46-ace4-2d19-fef9-c59cd1a596ce@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g74nijuruvmiaccu"
Content-Disposition: inline
In-Reply-To: <a92d3b46-ace4-2d19-fef9-c59cd1a596ce@collabora.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g74nijuruvmiaccu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Apr 21, 2022 at 12:17:00PM +0200, AngeloGioacchino Del Regno wrote:
> Il 18/04/22 14:20, xinlei.lee@mediatek.com ha scritto:
> > From: Xinlei Lee <xinlei.lee@mediatek.com>
> >=20
> > Add interrupts property of pwm for MediaTek MT8192 SoC.
> >=20
> > Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
>=20
> Hello Xinlei,
> the pwm-mtk-disp.c driver does not support interrupts.
>=20
> Please add interrupts support to the driver first, and only then
> add that in the dt-bindings.

in my understanding the linux driver state and the binding documentation
are somewhat independent. Here I'd say adding the irq information to dt
without the driver supporting it is fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--g74nijuruvmiaccu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJhYJUACgkQwfwUeK3K
7AmXqgf+MrAe0PFC2xF5YzOIK5R/MGmmmV3pJNlax2M2UkDsWxeavnkcBOQcilzv
ln6uRHHRETr5tUiBEZBTPVgX8/suEhfhw+/EPtUSH/LUK9cMEAxsSjZItwZCjzUi
+4SKV+24sivp5jfmsbyrZCKsGDNjDynXf3DBVcJbB4MLWl42NDVTIqqxA0hQe7Of
pfwrYWjTX0MM3ZHBN3vA7reDg/d+qvoDwxn6dHT0oRvXmhyH7xhQ5N2KxkhGPBpP
MJv4P3O37I6QygsplJHpJaoDv7zAYSJXx4wk9w1vp9vj3fZxVB9TsP9m9ILZx30U
9PmDnaULNIt8tZukhdV4M8VDymcQJA==
=vy1d
-----END PGP SIGNATURE-----

--g74nijuruvmiaccu--
