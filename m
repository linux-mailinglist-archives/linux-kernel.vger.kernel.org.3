Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B07B512BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244561AbiD1GyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244529AbiD1GyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:54:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1233F986C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:51:04 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1njxzP-0003Yt-Of; Thu, 28 Apr 2022 08:50:59 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-6c64-eec7-9c08-9d9e.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:6c64:eec7:9c08:9d9e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9798E6F68F;
        Thu, 28 Apr 2022 06:50:58 +0000 (UTC)
Date:   Thu, 28 Apr 2022 08:50:58 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Andreas Larsson <andreas@gaisler.com>
Cc:     linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-kernel@vger.kernel.org, software@gaisler.com
Subject: Re: [PATCH 0/3] can: grcan: Bug fixes
Message-ID: <20220428065058.mf76kmhamddsqsvk@pengutronix.de>
References: <20220427134307.22981-1-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3ehkjv647hydu7gq"
Content-Disposition: inline
In-Reply-To: <20220427134307.22981-1-andreas@gaisler.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3ehkjv647hydu7gq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27.04.2022 15:43:04, Andreas Larsson wrote:
> These patches
> * makes sure that DMA memory is allocated properly
> * avoids the tx errata workaround needlessly being applied
> * fixes a bug where the driver can be left hanging without interrupts ena=
bled
>=20
> Andreas Larsson (2):
>   can: grcan: Fix broken system id check for errata workaround needs
>   can: grcan: Only use the napi poll budget for rx
>=20
> Daniel Hellstrom (1):
>   can: grcan: use ofdev->dev when allocating DMA memory

Thanks for the patches. Can you please add a "Fixes:" tag to each patch.
=46rom the description it seems they should be backported to the stable
kernels, correct?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--3ehkjv647hydu7gq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJqOU8ACgkQrX5LkNig
0138awf8CRjYpPJ61meelWmMiISKdKDVE6fz2p/o+FqwRqxM9dOkCV+/3WCTMH4b
EwiTOn87Q5M9qO3M4gkzJhblIvo6HzExaOCKrbHazoTcK4mpWf5T3Ly+bNvMpp10
oeUwDvc8oE/UIUyWMLtDDcEh1KNQoY/MihhlZwbt/8QXA5gSv+b9QnKRmzAPzI0p
jGZUINJRUu40P5ZqxZJbHnXj19mTSyTZxcRty3ipvUR99MU8/mfmErQXlMMWdPeq
IhxM215XSIWaU8bGNkqgyDedqZu4h9mrmsYxNiGf6icKr6Ps3BiwPWl/YQ3bJa6x
HK/+DZKQvNVP5jw1/8EI5podZHMvXw==
=QSKS
-----END PGP SIGNATURE-----

--3ehkjv647hydu7gq--
