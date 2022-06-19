Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16715550948
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 10:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbiFSIIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 04:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbiFSIIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 04:08:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68BAAE51
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 01:08:41 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o2pyz-0007Pq-IU; Sun, 19 Jun 2022 10:08:33 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-83f1-6e60-bc5c-b382.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:83f1:6e60:bc5c:b382])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D59739957E;
        Sun, 19 Jun 2022 08:08:22 +0000 (UTC)
Date:   Sun, 19 Jun 2022 10:08:22 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        kbuild-all@lists.01.org, linux-can@vger.kernel.org,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220619080822.dukckeli3f2byibj@pengutronix.de>
References: <20220618195031.10975-1-max@enpas.org>
 <202206190533.0uzpvGYN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u3ofpwyjtrhvxsp2"
Content-Disposition: inline
In-Reply-To: <202206190533.0uzpvGYN-lkp@intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
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


--u3ofpwyjtrhvxsp2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.06.2022 06:02:32, kernel test robot wrote:
> Hi Max,
>=20
> I love your patch! Yet something to improve:
>=20
> [auto build test ERROR on mkl-can-next/testing]
> [also build test ERROR on linus/master v5.19-rc2 next-20220617]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]

The patch depends on:

| https://lore.kernel.org/all/20220618180134.9890-1-max@enpas.org/

which has not been added to a git tree so far.

Marc
--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--u3ofpwyjtrhvxsp2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKu2XMACgkQrX5LkNig
012yKwgApv2PYxUTUWaf7T2KcmIrZ7vDeXXzfXUOFexW2WgtRgnShK3dCmd0lhJg
+ZB7052ZR2/ZaN9n0MWf7d8/TrEam3LWs/6QtXq7MbXPx/BnaUFsx//qjccM6Nhz
ylgJgev3c+JMdXuPP65zNp6HRkF4zcgwPkY/aobhMSHgnCz+GbCNiaSNtePX9wdO
24oqYpznvCqflXB40NSEsVOCjagyhNhp0jR8wDi1LKk1u4NHSb+9XFCicXYmJhsj
/8SGQ14tJ77FUVPciY63Lj1e8o5XxMaOKcKrqbN6iitK9tkhuDFF4zZt6kIHYymj
OBfW2zfiK2U0PgL+S/LZoMbwwY5uKA==
=a3mT
-----END PGP SIGNATURE-----

--u3ofpwyjtrhvxsp2--
