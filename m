Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AD7526165
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380078AbiEMLwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380066AbiEMLwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:52:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056731F2C37
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:52:30 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1npTqL-0008RD-Nd; Fri, 13 May 2022 13:52:25 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0D7B07D980;
        Fri, 13 May 2022 11:52:24 +0000 (UTC)
Date:   Fri, 13 May 2022 13:52:23 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220513115223.b56etkaejphldjok@pengutronix.de>
References: <20220512182921.193462-1-max@enpas.org>
 <CAMZ6Rq+BwL1NPTLtC5sQAd4z1Kc1TFJPPoW-i+0RZ5dnFaWYiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z3ay42fpsw7fs2iu"
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+BwL1NPTLtC5sQAd4z1Kc1TFJPPoW-i+0RZ5dnFaWYiw@mail.gmail.com>
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


--z3ay42fpsw7fs2iu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13.05.2022 11:38:31, Vincent Mailhol wrote:
> > +
> > +       /* We shouldn't get here after a hardware fault:
> > +        * can_bus_off() calls netif_carrier_off()
> > +        */
> > +       WARN_ON_ONCE(elm->uart_side_failure);
> > +
> > +       if (!elm->tty ||
> > +           elm->uart_side_failure ||
> > +           elm->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) {
>=20
> Can the xmit function get called when CAN_CTRLMODE_LISTENONLY is on?

I think yes. You can skip the whole CAN stack by injecting CAN frames in
the kernel via the packet socket. Maybe we should add a check to
can_dropped_invalid_skb().

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--z3ay42fpsw7fs2iu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJ+RnQACgkQrX5LkNig
012RxwgAhvyEkZ57jhZy/V7+WUJvLjr82qaC4xscnyaqiRUhO/V9OQ03ZmmYfaml
6ANPCk2MyPeXSbj43R3L4EIRmId3uWiHUQrQAed5Rj1Ao4+Pui/na1DRsWUuTWxn
PvC0ReCzSK4AVcNi94gAfChOO4IjOsyQ+yETD5p7EN+XKk1q/qaYUH9u9oga8K0q
zpsUVUxzHOoZu8EzkNbXrvOGCVru002pFgnFLxq9SzOIUa4TSMw3T9JjcPsCKESe
m1Z2T5NStNz96CWO9Ff4hXThFLlIyRq3xCEhtFT7lMCdKfDXq2RZ6M6QMtYYWt1g
YStdSwjVf4qGrFM3KwKGvPyrX8PaZw==
=T2/6
-----END PGP SIGNATURE-----

--z3ay42fpsw7fs2iu--
