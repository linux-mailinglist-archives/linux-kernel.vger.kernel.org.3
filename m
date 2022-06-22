Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9C4554468
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352206AbiFVHMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352142AbiFVHME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:12:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754BB36B79
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:12:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3uWu-0005OK-HA; Wed, 22 Jun 2022 09:12:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3uWo-001z4j-Sk; Wed, 22 Jun 2022 09:11:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3uWp-000Mys-IW; Wed, 22 Jun 2022 09:11:55 +0200
Date:   Wed, 22 Jun 2022 09:11:51 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [next] Unable to handle kernel execute from non-executable
 memory at virtual address - devm_clk_release
Message-ID: <20220622071151.xmabagjyr5qasff5@pengutronix.de>
References: <CA+G9fYv4S2TqZ53oH5FEK07qHV+LwkZEx7+KNiCa5wZWruDSfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lqt3bo3e3asngv5g"
Content-Disposition: inline
In-Reply-To: <CA+G9fYv4S2TqZ53oH5FEK07qHV+LwkZEx7+KNiCa5wZWruDSfA@mail.gmail.com>
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


--lqt3bo3e3asngv5g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 22, 2022 at 06:41:30AM +0530, Naresh Kamboju wrote:
> The following kernel crash was noticed on arm64 Raspberry Pi 4 Model B
> devices while booting. This crash is always reproducible.
>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>=20
> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: 1e502319853ceebfe7480a436ba22ab01372fa0c
>   git_describe: next-20220620
>   kernel_version: 5.19.0-rc3
>   kernel-config: https://builds.tuxbuild.com/2ApqivCh2DP6v2QxI17B2GnWiUk/=
config
>   build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pip=
elines/567830223
>   artifact-location: https://builds.tuxbuild.com/2ApqivCh2DP6v2QxI17B2GnW=
iUk
>   toolchain: gcc-11

Patch available at https://lore.kernel.org/all/20220620171815.114212-1-u.kl=
eine-koenig@pengutronix.de/

I wonder how the recipents of this mail were choosen. If your build bot
identified abae8e57e49aa75f6db76aa866c775721523908f as the broken
commit, this would be a very helpful information in this report.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lqt3bo3e3asngv5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKywLQACgkQwfwUeK3K
7AleAgf+JZg7IG3GJ2dkcv/k61X0tlqdukxR0hKi2O69G3gOTAy/nWRvoJNfizdj
T77eaizrdrfpqU2hpjsjd2XCiW5USzUItWtvhwC2BOZFqhvWYizrbt1GC922lf0Y
u48Jf3b7de0Ft4KgaCAAGWB5F4GvU8qP9tMNLlx57ojiO6my7Inwlef4gJ7sRkpt
UUDX+3uMQRbWT7n6IcLvcKtKPobuyZmmt0S7IRjyeanrWOT96Nz9OodBnwb/82VG
vppCQ+bhilNUSHDpQIVyqiCvrD3aPMG8+rffdczKVPe9iW/nWlV7W6ZCF4MYDcB3
q9VWq/HxAc7IUoH1g/yWXWKSXcmGlQ==
=b4NL
-----END PGP SIGNATURE-----

--lqt3bo3e3asngv5g--
