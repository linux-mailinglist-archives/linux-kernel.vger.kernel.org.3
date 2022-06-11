Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BC454761D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 17:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbiFKP2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 11:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbiFKP2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 11:28:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C9B1FA63
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 08:28:05 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o031u-0000kI-FR; Sat, 11 Jun 2022 17:28:02 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4507292ECE;
        Sat, 11 Jun 2022 15:28:01 +0000 (UTC)
Date:   Sat, 11 Jun 2022 17:28:00 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220611152800.3brt52riunli7fq3@pengutronix.de>
References: <20220602213544.68273-1-max@enpas.org>
 <CAMZ6RqLLn3tE6kPd+yyHURsbBU_jVKN=u4=YvhZVyAf_NyRqCQ@mail.gmail.com>
 <20220611151551.5024f51e.max@enpas.org>
 <CAMZ6RqLb3irjBrpiOv23Hg6vVpzK4d31Pvat2AOS3EC0+e_=3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tsr2fvhk6ihaf3yn"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqLb3irjBrpiOv23Hg6vVpzK4d31Pvat2AOS3EC0+e_=3A@mail.gmail.com>
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


--tsr2fvhk6ihaf3yn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.06.2022 23:42:39, Vincent Mailhol wrote:
> > > This part of the patch does not apply. It conflicts with
> > > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/c=
ommit/?id=3D5f02ecbe08d6a3434a14b92bee98adec76e8808e
> > >
> > > Please rebase on the latest version on net-next.
> >
> > Thanks, will do. I may wait for your cleanup patches to appear, though.
>=20
> The v5 of my cleanup is already in the master branch of linux-can-next:
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/lo=
g/
>=20
> But you might have a conflict on drivers/net/can/Kconfig so better to
> wait for the v6 (or apply my patches manually if you are in a hurry).

I've pushed Vincent's v6 to linux-can-next/master. Please base your
series on that branch. It also contains "can: netlink: allow configuring
of fixed bit rates without need for do_set_bittiming callback"

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--tsr2fvhk6ihaf3yn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKktH0ACgkQrX5LkNig
012UjAf9Fo7IgYKJorYIpj685hA8ch49jRkUPolUDOwiruW/fEG+oAepcVQtur/s
MvqFXbv3KkzI5BX6B+Lb7XnMioy7VqK+BKE4/BsaIsog+0BDoZUFksXYgq89zo1p
SILVkPSBy3KiK/Y/1lYEjNnmC2yZwE7kx6Nx4Md55dhvO7TFZ9ImpF6dp/P7VOVG
7tEhLVhNEgptl0Au0nTlJmPqNSEZlDp3VdsuZwLDV/k398iphuLES3KiZ26zlDvt
ngwnErg8c+vl5omDtLCdR3j3LYlJ7tF9+BIgAKkOSHWSsMmGhUO+r6vccYF9gIae
Y4HZoasWwSuUuKKxIs/n6Bo1kzvjaA==
=lw8v
-----END PGP SIGNATURE-----

--tsr2fvhk6ihaf3yn--
