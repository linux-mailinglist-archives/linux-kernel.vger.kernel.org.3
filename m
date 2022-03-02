Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224F64CA237
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 11:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241001AbiCBKdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 05:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240992AbiCBKdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:33:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E3238B9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 02:32:29 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nPMHP-0004fM-BT; Wed, 02 Mar 2022 11:32:23 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-5c51-3418-45e9-21d0.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:5c51:3418:45e9:21d0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D8D2340B54;
        Wed,  2 Mar 2022 10:32:19 +0000 (UTC)
Date:   Wed, 2 Mar 2022 11:32:19 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
Subject: Re: drivers/net/can/usb/etas_es58x/es58x_fd.c:174:8: warning:
 Uninitialized variable: rx_event_msg [uninitvar]
Message-ID: <20220302103219.kvpfhc6qz42t3pvv@pengutronix.de>
References: <202203021333.mMJpWPzx-lkp@intel.com>
 <5f13b914-e309-49ee-4f98-c81780c478b9@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="es7shakc2uxqunjk"
Content-Disposition: inline
In-Reply-To: <5f13b914-e309-49ee-4f98-c81780c478b9@intel.com>
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


--es7shakc2uxqunjk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.03.2022 17:47:08, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   575115360652e9920cc56a028a286ebe9bf82694
> commit: c664e2137a27680922d8aeb64fb10313416b254f can: etas_es58x: add sup=
port for the ETAS ES58X_FD CAN USB interfaces
> date:   11 months ago
> compiler: powerpc64-linux-gcc (GCC) 11.2.0
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <yujie.liu@intel.com>
>=20
>=20
> cppcheck possible warnings: (new ones prefixed by >>, may not be real pro=
blems)
>=20
>    In file included from drivers/net/can/usb/etas_es58x/es58x_fd.c:
> >> drivers/net/can/usb/etas_es58x/es58x_fd.c:174:8: warning: Uninitialize=
d variable: rx_event_msg [uninitvar]
>     ret =3D es58x_check_msg_len(es58x_dev->dev, *rx_event_msg, msg_len);
>           ^
>=20
> vim +174 drivers/net/can/usb/etas_es58x/es58x_fd.c
>=20
> c664e2137a2768 Vincent Mailhol 2021-04-10  165
> c664e2137a2768 Vincent Mailhol 2021-04-10  166  static int es58x_fd_rx_ev=
ent_msg(struct net_device *netdev,
> c664e2137a2768 Vincent Mailhol 2021-04-10  167  				 const struct es58x_f=
d_urb_cmd *es58x_fd_urb_cmd)
> c664e2137a2768 Vincent Mailhol 2021-04-10  168  {
> c664e2137a2768 Vincent Mailhol 2021-04-10  169  	struct es58x_device *es5=
8x_dev =3D es58x_priv(netdev)->es58x_dev;
> c664e2137a2768 Vincent Mailhol 2021-04-10  170  	u16 msg_len =3D get_unal=
igned_le16(&es58x_fd_urb_cmd->msg_len);
> c664e2137a2768 Vincent Mailhol 2021-04-10 @171  	const struct es58x_fd_rx=
_event_msg *rx_event_msg;
> c664e2137a2768 Vincent Mailhol 2021-04-10  172  	int ret;
> c664e2137a2768 Vincent Mailhol 2021-04-10  173
> c664e2137a2768 Vincent Mailhol 2021-04-10 @174  	ret =3D es58x_check_msg_=
len(es58x_dev->dev, *rx_event_msg, msg_len);
> c664e2137a2768 Vincent Mailhol 2021-04-10  175  	if (ret)
> c664e2137a2768 Vincent Mailhol 2021-04-10  176  		return ret;
> c664e2137a2768 Vincent Mailhol 2021-04-10  177
> c664e2137a2768 Vincent Mailhol 2021-04-10  178  	rx_event_msg =3D &es58x_=
fd_urb_cmd->rx_event_msg;
> c664e2137a2768 Vincent Mailhol 2021-04-10  179
> c664e2137a2768 Vincent Mailhol 2021-04-10  180  	return es58x_rx_err_msg(=
netdev, rx_event_msg->error_code,
> c664e2137a2768 Vincent Mailhol 2021-04-10  181  				rx_event_msg->event_c=
ode,
> c664e2137a2768 Vincent Mailhol 2021-04-10  182  				get_unaligned_le64(&r=
x_event_msg->timestamp));
> c664e2137a2768 Vincent Mailhol 2021-04-10  183  }
> c664e2137a2768 Vincent Mailhol 2021-04-10  184

Thanks for the report.

This looks like a false positive to me, as es58x_check_msg_len() is not
a function, but a macro:

| #define es58x_check_msg_len(dev, msg, actual_len)			\
| 	__es58x_check_msg_len(dev, __stringify(msg),			\
| 			      actual_len, sizeof(msg))

__es58x_check_msg_len() don't use "rx_event_msg" directly, but only a
string representation of it and a "sizeof()".

I think it's possible to assign rx_event_msg before the
es58x_check_msg_len(). I think (hope?) the compiler will not optimize
anything away. :)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--es7shakc2uxqunjk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIfR7AACgkQrX5LkNig
013QCQgAqK9CFYzDpArq0c7Bm8GbARd+F9DP/5Ir6bmH34+nSEvwBXvIB2bqDlLS
5O6vzlP32gdyQTiUj7wZE9urPrtXkRcxrewMeoezOVuTNVfH32hwWANBYeyfP0g+
8h1ePZHny0wbhGuGMzR7GRyEwtAfDQMpkfnzwrsY0AA6T5tshvWE/ToMVjtR6iqz
kIyok2Q01jbLYyqoFjHMYDXhyLIS3kKxt8tUYiUKmxeqvdMW9Azw1eUuBWCRoJ9z
feAmwJS6+BXnmOAvX9CLIlFo1asRCZKikRgPjDiEkcX8/Kc5OLeItu4+bYZx5cEk
UdTZSPc0DW5omA7gnaBoOQiufTPk+Q==
=t9ZQ
-----END PGP SIGNATURE-----

--es7shakc2uxqunjk--
