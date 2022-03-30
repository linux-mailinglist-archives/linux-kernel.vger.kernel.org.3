Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462964EBBE8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243880AbiC3HmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243911AbiC3Hl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:41:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB4952E1B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:40:11 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nZSvu-0004in-0p; Wed, 30 Mar 2022 09:39:58 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-5314-bece-822a-622d.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:5314:bece:822a:622d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CA6BA56C4E;
        Wed, 30 Mar 2022 07:39:56 +0000 (UTC)
Date:   Wed, 30 Mar 2022 09:39:56 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Kris Bahnsen <kris@embeddedTS.com>
Cc:     linux-kernel@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, Mark Featherston <mark@embeddedTS.com>
Subject: Re: [PATCH RESEND] can: Fix Links to Technologic Systems web
 resources
Message-ID: <20220330073956.vipax3mvz3nhetu6@pengutronix.de>
References: <20220329201229.16279-1-kris@embeddedTS.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qngs36tpyj5rr3tl"
Content-Disposition: inline
In-Reply-To: <20220329201229.16279-1-kris@embeddedTS.com>
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


--qngs36tpyj5rr3tl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29.03.2022 13:12:29, Kris Bahnsen wrote:
> Technologic Systems has rebranded as embeddedTS with the current
> domain eventually going offline. Update web/doc URLs to correct
> resource locations.
>=20
> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
> ---
> This is a resend as the prior patch was accidentally marked as a series

Thanks, applied to can-next/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--qngs36tpyj5rr3tl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJECUcACgkQrX5LkNig
011FAAgAgzZzZTzQCz0gKaQgpHxMS9z1JILr5XJHRxHuS/dVc/sCQPDoTBxbcSkj
3WoVT2ubkKYns3z67Hen7kJf7xK6nTsY2vdRS9aldD5SWT/nbJ26q5BrS7Cx0+d5
Ut2EGRe2EiP/Xevq9qjByjue5jwuWgj8Jv1ujUo9ktr0RxQHjzA4kjv+FinilAaS
tj9XwW7JWRCghx7Ff1uWONkELGCFt75k1XHLqjeEpslvoX82Yw77YXotD4a+UPL7
PuclyhpbWfJswZMiUktz0RigVtzIVguMl66zeKdVoXIUAlczclNEZv+IwPIxZ48o
Zo5jYgvk20x7723d7nWG2xvL76YJag==
=tkGY
-----END PGP SIGNATURE-----

--qngs36tpyj5rr3tl--
