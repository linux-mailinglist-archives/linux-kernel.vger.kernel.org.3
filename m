Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C16C54C2A7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243959AbiFOHdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbiFOHdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:33:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C669275E0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:33:33 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o1NWo-0007PC-0U; Wed, 15 Jun 2022 09:33:26 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 26A689627F;
        Wed, 15 Jun 2022 07:33:23 +0000 (UTC)
Date:   Wed, 15 Jun 2022 09:33:22 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Max Staudt <max@enpas.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH v8] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220615073322.6nbdumfcztnybsgz@pengutronix.de>
References: <20220612152601.142314-1-max@enpas.org>
 <20220612155654.ij53kpw7cscj53nk@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b7j72yanl6ow7ifw"
Content-Disposition: inline
In-Reply-To: <20220612155654.ij53kpw7cscj53nk@pengutronix.de>
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


--b7j72yanl6ow7ifw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Max!

On 12.06.2022 17:56:54, Marc Kleine-Budde wrote:
> > diff --git a/include/uapi/linux/tty.h b/include/uapi/linux/tty.h
> > index 9d0f06bfbac3..68aeae2addec 100644
> > --- a/include/uapi/linux/tty.h
> > +++ b/include/uapi/linux/tty.h
> > @@ -38,8 +38,9 @@
> >  #define N_NULL		27	/* Null ldisc used for error handling */
> >  #define N_MCTP		28	/* MCTP-over-serial */
> >  #define N_DEVELOPMENT	29	/* Manual out-of-tree testing */
> > +#define N_CAN327	30	/* ELM327 based OBD-II interfaces */
> > =20
> >  /* Always the newest line discipline + 1 */
> > -#define NR_LDISCS	30
> > +#define NR_LDISCS	31
> > =20
> >  #endif /* _UAPI_LINUX_TTY_H */
>=20
> Greg, do you want the include/uapi/linux/tty.h changes in a separate
> patch and upstream it?

Please make this a separate patch and send it to Greg similar to the
N_DEVELOPMENT patch.

Once this change is in net-next/master I'll merge the can327 driver.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--b7j72yanl6ow7ifw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKpiz8ACgkQrX5LkNig
012WVwf/R4eTxzSLZXjfph/6QT8XMx5pdIgG281OtBPuG+8b+u2++o6g/6sKpvEc
dqz4I55UfLMEOHVK6SBlpMf1QFnpZ/34PhnZppPAOrqqh1peBJ8+qTHq6jvVApMt
La5d4KSkD/XN1ZRbRP3pzTw1Wyzq5+0MIGS9biZedLO8V8mGx7JhlKoU2FjJGLdd
ti9KSwR8oxcemzK43LLHjNqNds/H0F2LxVcTXbY+1ndx0MZmLfT0rmwEjx2oIHYl
+UzeXbf9YOPkXtKnCaibeDCjMnddo3/2LjPoSLs7M4gU8df6Z3KovlGDFaMx7Te/
5z2z9vhFWraDKSQgMEKQVNAMmcZypg==
=ud73
-----END PGP SIGNATURE-----

--b7j72yanl6ow7ifw--
