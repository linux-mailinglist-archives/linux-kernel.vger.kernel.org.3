Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781A44ABF37
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448442AbiBGNLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359692AbiBGMwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 07:52:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6705CC0401C6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 04:52:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nH3V0-0001kT-Ap; Mon, 07 Feb 2022 13:52:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nH3Ux-00F6BR-1a; Mon, 07 Feb 2022 13:52:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nH3Uv-00Acnk-Fe; Mon, 07 Feb 2022 13:52:01 +0100
Date:   Mon, 7 Feb 2022 13:51:58 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH] dt-bindings: pwm: mtk-disp: add compatible string for
 MT8183 SoC
Message-ID: <20220207125158.t5362u2dddccdmsq@pengutronix.de>
References: <20220207112657.18246-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d3yuhoeyfgyvlc6b"
Content-Disposition: inline
In-Reply-To: <20220207112657.18246-1-allen-kh.cheng@mediatek.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d3yuhoeyfgyvlc6b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Feb 07, 2022 at 07:26:57PM +0800, Allen-KH Cheng wrote:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
>=20
> Add compatible string for MT8183 SoC in device tree binding.
>=20
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Doc=
umentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> index 902b271891ae..691e58b6c223 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> @@ -6,6 +6,7 @@ Required properties:
>     - "mediatek,mt6595-disp-pwm": found on mt6595 SoC.
>     - "mediatek,mt8167-disp-pwm", "mediatek,mt8173-disp-pwm": found on mt=
8167 SoC.
>     - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
> +   - "mediatek,mt8183-disp-pwm": found on mt8183 SoC.$

The patch looks good in principle. I'd like to see the .txt file
converted to .yaml though. Would you care for that please?

Also it would be good if you'd care that sender email address and author
address match.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--d3yuhoeyfgyvlc6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIBFesACgkQwfwUeK3K
7AkkAgf/fg+txDjzVkyHwJVZPCvspksFhmKCPBL43pn/2PuKFzuMBGET5zqIESSD
g/bRy5VJ3sPbOB2IiRqL8e+5uBRpyjErA9hDuBXAeE0j51fonbIeKx5tLMn0CmCm
QqngjwSvxBZin6oHjUsmeJ4DmTltc159yQlZJ4OA+0Ur5cSR2ygGBVf/PhNwD1sr
o6MlZ+PpgNZyD0emGImlgYyEzLlssbqHvcEexQ4Edy+Ia+x+WkKL2PijTSOsPpki
yh42NYdOPlPgvyLf5iAk2tyeb3b3+Z5z8olSGSLpnKmy/o6KFVLdPRmcF/GRvxKd
iGe2/E5kAx/Jh8ObG42MHTmx3NUprg==
=ZzWa
-----END PGP SIGNATURE-----

--d3yuhoeyfgyvlc6b--
