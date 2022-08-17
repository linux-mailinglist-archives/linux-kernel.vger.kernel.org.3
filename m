Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4915B59684A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 06:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiHQEs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 00:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbiHQEsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 00:48:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4528F13E2D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 21:48:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOAyy-00070X-FQ; Wed, 17 Aug 2022 06:48:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOAyw-000FO0-U1; Wed, 17 Aug 2022 06:48:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOAyw-00CFN0-6a; Wed, 17 Aug 2022 06:48:42 +0200
Date:   Wed, 17 Aug 2022 06:48:39 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mfd tree with the i2c tree
Message-ID: <20220817044839.u6vdsyqf34njbu56@pengutronix.de>
References: <20220817110845.768796fa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="duleghe3iqhl65p6"
Content-Disposition: inline
In-Reply-To: <20220817110845.768796fa@canb.auug.org.au>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--duleghe3iqhl65p6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 17, 2022 at 11:08:45AM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the mfd tree got a conflict in:
>=20
>   drivers/mfd/intel_soc_pmic_core.c
>=20
> between commit:
>=20
>   ed5c2f5fd10d ("i2c: Make remove callback return void")
>=20
> from the i2c tree and commit:
>=20
>   8a8cf3dc6419 ("mfd: intel_soc_pmic_crc: Merge Intel PMIC core to crc")
>=20
> from the mfd tree.
>=20
> I fixed it up (I removed the file and added the following merge fix patch)
> and can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

The fixup looks right.

@Lee: There is an immutable tag that can be merged into your tree to
resolve the conflict before you send your changes to Linux at

	https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/make_rem=
ove_callback_void-immutable

@Stephen: Thanks for your fixes, here and in the input tree.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--duleghe3iqhl65p6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmL8cyQACgkQwfwUeK3K
7AlLEAf+PSNgeR+HEw2SNaQBtnEkE9/1WZ91XfIuCPTy2vzN8wfLGqNYjBJnscVQ
T+JyztxtwE3j0YfJSkOryqK9qGwXjpwm6QmDGQr1/Pfpa5P8/j/B1CEnepOm31JM
91bwtXmvYKPdtSY4PmI6EXM6Aqr2xC+QBhDURnV0XqUVw2vQ1ObJTw3Doczyri3X
9jUEDYmKN/jtgJXf1eOZFTvsieQlD81NzihI8vzV4z6K77MAQJ69u34xxFd9c7Cl
SIoWXScPN/euR6DW7TNXN3+Jdg0C1336r6YWiggTdHDw2PfYQUgZ9taGI2NED2Yq
Vq7df1EdtPPQAOtZ8jf1/MNnm/CbEA==
=FqU7
-----END PGP SIGNATURE-----

--duleghe3iqhl65p6--
