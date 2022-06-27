Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0D255D80D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbiF0PGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbiF0PGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:06:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C9A175B7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:06:03 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o5qJL-0000rM-G9; Mon, 27 Jun 2022 17:05:59 +0200
Received: from pengutronix.de (p200300ea0f229100e97a6e34b3068c93.dip0.t-ipconnect.de [IPv6:2003:ea:f22:9100:e97a:6e34:b306:8c93])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id BD2BDA0461;
        Mon, 27 Jun 2022 15:05:57 +0000 (UTC)
Date:   Mon, 27 Jun 2022 17:05:57 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Max Staudt <max@enpas.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH v9] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220627150557.qluqtejrddj5nfif@pengutronix.de>
References: <20220618195031.10975-1-max@enpas.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kovmxfmurem5z7iw"
Content-Disposition: inline
In-Reply-To: <20220618195031.10975-1-max@enpas.org>
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


--kovmxfmurem5z7iw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.06.2022 21:50:31, Max Staudt wrote:
> This is the can327 driver. It does a surprisingly good job at turning
> ELM327 based OBD-II interfaces into cheap CAN interfaces for simple
> homebrew projects.
>=20
> Please see the included documentation for details and limitations:
> Documentation/networking/device_drivers/can/can327.rst
>=20
> Cc: linux-can <linux-can@vger.kernel.org>
> Signed-off-by: Max Staudt <max@enpas.org>
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Added with some minor coding style improvements (line breaks and
whitespace changes) to make checkpatch and clang-format happier to
can-next/master!

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--kovmxfmurem5z7iw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmK5x1IACgkQrX5LkNig
013dFgf+LN9lKCXv+ZaFhnWN+BiF6lyNXdlpVLeVO6jgWqyo6for8l9+HvhSwocq
kDSI8YA1u1IND3ggP+FncOVNl6qbXJwnqls3qThDrNhULxXBOj16ekdN5mUTIX63
Q8fhk066NMqIIav31rKXHDaovI1G5hfd72QEWzNg5ABbOoe7msF46tp+AzBWbRSn
HdvANjNdKaYKuskXJmfCwYEWl+uUQuD99XWrkQqHY2Uv8lF0eqUEJAYmkgZf2fVk
cWXetuE+r+6z/dbXofOF6gKZ3Y34iEchUw1KHTT9a6ATTPX37ulzUKUTrkopLSAr
IsPXJcnWJpO/tyRQvSPla/pvZcPv4A==
=5RII
-----END PGP SIGNATURE-----

--kovmxfmurem5z7iw--
