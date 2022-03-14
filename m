Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9933E4D8F2D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245437AbiCNWB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245425AbiCNWB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:01:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3B63BF95
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:00:47 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nTsk7-0002oU-No; Mon, 14 Mar 2022 23:00:43 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-6399-440a-c2a2-bdf7.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:6399:440a:c2a2:bdf7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7614A4B406;
        Mon, 14 Mar 2022 22:00:42 +0000 (UTC)
Date:   Mon, 14 Mar 2022 23:00:42 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v3] can, tty: elmcan CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220314220042.vpicmcrwvexxwk3c@pengutronix.de>
References: <20220307214303.1822590-1-max@enpas.org>
 <CAMZ6RqJZObevKPc29jW+m6i0eAgestTbw8KCPXxSGHzSXK7cRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3ycyvbpbhbranjzf"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJZObevKPc29jW+m6i0eAgestTbw8KCPXxSGHzSXK7cRg@mail.gmail.com>
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


--3ycyvbpbhbranjzf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.03.2022 16:01:12, Vincent Mailhol wrote:
> > +/* Send a can_frame to a TTY. */
> > +static netdev_tx_t elmcan_netdev_start_xmit(struct sk_buff *skb,
> > +                                           struct net_device *dev)
> > +{
> > +       struct elmcan *elm =3D netdev_priv(dev);
> > +       struct can_frame *frame =3D (struct can_frame *)skb->data;
> > +
> > +       if (skb->len !=3D sizeof(struct can_frame))
> > +               goto out;
>=20
> Isn=E2=80=99t this aleardy guaranteed by the upper layers?

You can always inject packets via the packet socket into the kernel,
bypassing e.g. the CAN RAW layer.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--3ycyvbpbhbranjzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIvuwcACgkQrX5LkNig
011hxQf/RQ/sycT5AgFovH7C118vWmXWvYLZt9R+LGEiU/9AfY3b3IChu/WIVZBJ
ZbdnY7Wb9l/KVBGE7KTnpeUNdX3qwgQ4Xfbt+9eFUCFqEyAzUzWgN92NyVDlR3R2
JOowtZ30+EdcjRSGJ5CHOp/VWS4Flc7gHYfLWvC+ef5+IIN3xL47jcD8PjKgvC30
dNLfkxkt2YZo1niaUSNnD49vUqMHin7YDbpgNGv85iYQG0Iz2YU6ORUqCsgoaxd4
nGYj3ImRUFOxxu+c7cMBq7injzXVJlAnci6FIUAoOdmsy8cleNmoz1J6X5d2m+qu
f1UX3f1r6274L20mKBLVKACSdPCp2g==
=H7ZN
-----END PGP SIGNATURE-----

--3ycyvbpbhbranjzf--
