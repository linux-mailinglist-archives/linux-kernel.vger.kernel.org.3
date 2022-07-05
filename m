Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9843566710
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbiGEJvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbiGEJtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648A013CCB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 02:49:35 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o8fBS-0001vI-75; Tue, 05 Jul 2022 11:49:30 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-a082-c20a-3b95-9158.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:a082:c20a:3b95:9158])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 041E8A8764;
        Tue,  5 Jul 2022 09:49:27 +0000 (UTC)
Date:   Tue, 5 Jul 2022 11:49:27 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Oliver Neukum <oneukum@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v9] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220705094927.vgtxcjh4klw6dcg3@pengutronix.de>
References: <20220618195031.10975-1-max@enpas.org>
 <20220627150557.qluqtejrddj5nfif@pengutronix.de>
 <20220627190126.4eb57a2b.max@enpas.org>
 <CAMuHMdUYCiRC+9UnQB6-2XGp+wOjYq1U_J3bDQT+WNm==mS4qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="upcj6ikityqz426n"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUYCiRC+9UnQB6-2XGp+wOjYq1U_J3bDQT+WNm==mS4qg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--upcj6ikityqz426n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.07.2022 11:43:52, Geert Uytterhoeven wrote:
> So development started before commit cd6484e1830be260 ("serdev:
> Introduce new bus for serial attached devices").  I guess that is the
> reason why this driver uses a line discipline, instead of the serial
> bus?
>=20
> I had a quick glance through the various revisions posted, and it
> doesn't seem like anyone mentioned the serial bus.  Would there be
> any advantage in migrating to the serial bus?

Does serial bus work with hot plug devices like USB Serial Adapters
and/or devices that are not described in the device tree?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--upcj6ikityqz426n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLECSUACgkQrX5LkNig
013x8QgAlkzZNjplXmSkbzLnfp5FyxE2SofCqbRT/uaQoymqG4Yr2TNTfm6iA9p2
vc/Dlp+91F+Efxp/Bx2ByYT0UA6Q23LZXF5m4l3b25fLy0HRGi9NiXNwFldbJNtg
gyQdruRQJJrXxTmz1pZL0aAjgjX+TTrFRXpU0MYWVU9sB4Bbj7N3tnMLeOo88LLy
+qNoFLQGodZI6Xfj/yvBrbnVtM8G/kkkcLCJyztht70gzacBT9X/xPadrwc1cA8J
8t5gpBQ5lTAdTsI8AcW633FZhI1WGpGQM1/gy+RM7z2HtEsCy0Fm1Yk/WzgS0CKL
7uyJOPsdXXL708fcrjyuo0yF3+ve/g==
=Ke92
-----END PGP SIGNATURE-----

--upcj6ikityqz426n--
