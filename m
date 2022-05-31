Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6685391C8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344565AbiEaNVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbiEaNVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:21:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ACD95DC1
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:21:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nw1nx-0000Ep-Gx; Tue, 31 May 2022 15:21:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nw1nx-005efL-QH; Tue, 31 May 2022 15:21:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nw1nv-00DJc8-Q8; Tue, 31 May 2022 15:20:59 +0200
Date:   Tue, 31 May 2022 15:20:59 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: add MT8365 SoC binding
Message-ID: <20220531132059.xjskzckbfs7ryuky@pengutronix.de>
References: <20220530205038.917431-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tynsucpudxxdmjic"
Content-Disposition: inline
In-Reply-To: <20220530205038.917431-1-fparent@baylibre.com>
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


--tynsucpudxxdmjic
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 30, 2022 at 10:50:37PM +0200, Fabien Parent wrote:
> Add binding documentation for the MT8365 SoC.
>=20
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
> v2: fix clock description (five -> three)

LGTM:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

If you want to further improve: This binding document wants to be
converted to yaml.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tynsucpudxxdmjic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKWFjgACgkQwfwUeK3K
7AlCRwf/VVvjLyJHg3Nxfrv26HKBGmX+EYRGK2t4VxMlx6ga7dudvL1daRdztnuI
7tywCMIgWpT6P7Mh8hKOYQldUSX+q9JzYncZ5DZXamBmnP8SfUNh5tPTEP8jlZyD
93nHm7eXlqksJF5SL9TPQLxHlWRnVGtsOzz51fzid0W/qz4VLF8LhY3iupFKWjkr
BYfQapf2ZXMWcNphZugIjXspoDTUBMUZRk8++o+5Zu0be++MAdyGU5OgBqLf6CrA
PmdtB/AjJYDRZA5duAD++rAdceOW7sTrnuepZVw1krcOxEOnb23SlD0NVXfwTIC6
ZG4NLDFRbTKj2/HMI2ibILqMkBtx0Q==
=kAWl
-----END PGP SIGNATURE-----

--tynsucpudxxdmjic--
