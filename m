Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DEB4DCFDC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiCQU7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiCQU7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:59:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878541BB78A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:57:23 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nUxBO-0001hk-Q8; Thu, 17 Mar 2022 21:57:18 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-45d5-ab38-4e18-d873.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:45d5:ab38:4e18:d873])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CD3AA4D746;
        Thu, 17 Mar 2022 20:57:17 +0000 (UTC)
Date:   Thu, 17 Mar 2022 21:57:17 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Max Staudt <max@enpas.org>
Cc:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v3] can, tty: elmcan CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220317205717.pfgfdxxyucmeuuwr@pengutronix.de>
References: <20220307214303.1822590-1-max@enpas.org>
 <CAMZ6RqJZObevKPc29jW+m6i0eAgestTbw8KCPXxSGHzSXK7cRg@mail.gmail.com>
 <20220309135414.34f77251.max@enpas.org>
 <CAMZ6RqJJ-PO=WeFeuXk4iC9GHLXz_ZMWtsVCm6sGVGbmeE5U1Q@mail.gmail.com>
 <20220314220408.hn4vdohtjdbfoaqo@pengutronix.de>
 <20220317212359.71252c57.max@enpas.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oacdquk4r2zftcgp"
Content-Disposition: inline
In-Reply-To: <20220317212359.71252c57.max@enpas.org>
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


--oacdquk4r2zftcgp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.03.2022 21:23:59, Max Staudt wrote:
> On Mon, 14 Mar 2022 23:04:08 +0100
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>=20
> > On 09.03.2022 22:49:49, Vincent Mailhol wrote:
> > > Either we agree that using can_rx_offload without implementing
> > > the mailbox_read() is OK and in that case, the can_rx_offload
> > > framework should be modified to allow mailbox_read() to be a NULL
> > > pointer.
> > >=20
> > > Either it is not the case and you use the more classic
> > > netif_rx().
> > >=20
> > > And I do not have the answer. I haven't studied can_rx_offload
> > > enough to be a judge here. Sorry.
> > >=20
> > > @Marc, any thoughts? =20
> >=20
> > Use can_rx_offload_add_manual() instead.
>=20
> m-(
>=20
> Yes, it's right underneath _add_fifo() and does the right thing. No
> idea how I missed it, I thought I had looked through all variants.

I think that function was not there form the beginning, maybe you looked
at the rx-offload code when it was not available.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--oacdquk4r2zftcgp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIzoKsACgkQrX5LkNig
013IOAf/c9dbbTwcZKyUV+gQU4LIgz1WYgV3/u0NL3CFQNp0T99+ZjV5bw5zWE5k
Z2Lt6i4NXJnIL0hDBVQI8EY53+gLbuxqdyxGvQUrONANXXmSTLOia+2NaqaCDV/S
ORJZycjStfmi4HfTbulMELey6h08ueBOmN/NaXCecnrXQcKSMOwOeb0Hng4Flj+Y
yfXqUT0XRwH02I5zBTEccMWUKRs9B/osjyoZDuqgrBtTFEmQ9/Ag20LFsI9iwjje
c20Ncr0KJLsm/fvjAQraqgOOL3zLn0TySrlGpSRI/KxD5YQojMzTC0ac+0BCc/EM
dqUeoPFrQXFvepvy1vOeqnqtLb6zHQ==
=2qna
-----END PGP SIGNATURE-----

--oacdquk4r2zftcgp--
