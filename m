Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FA14E26B1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347478AbiCUMiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347516AbiCUMh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:37:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524E0972BF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:36:34 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nWHGw-0002gR-F8; Mon, 21 Mar 2022 13:36:30 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-87a7-3ba5-ba0a-e35e.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:87a7:3ba5:ba0a:e35e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 094C550951;
        Mon, 21 Mar 2022 12:36:29 +0000 (UTC)
Date:   Mon, 21 Mar 2022 13:36:28 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-can@vger.kernel.org,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: rectify entry for XILINX CAN DRIVER
Message-ID: <20220321123628.xor3acqqtsio6rc7@pengutronix.de>
References: <20220321122840.17841-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wf6zkoaopeuzp55v"
Content-Disposition: inline
In-Reply-To: <20220321122840.17841-1-lukas.bulwahn@gmail.com>
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


--wf6zkoaopeuzp55v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.03.2022 13:28:40, Lukas Bulwahn wrote:
> Commit 7843d3c8e5e6 ("dt-bindings: can: xilinx_can: Convert Xilinx CAN
> binding to YAML") converts xilinx_can.txt to xilinx,can.yaml, but missed =
to
> adjust its reference in MAINTAINERS.
>=20
> Hence, ./scripts/get_maintainer.pl --self-test=3Dpatterns complains about=
 a
> broken reference.
>=20
> Repair this file reference in XILINX CAN DRIVER.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Marc, please pick this minor non-urgent clean-up patch in your can-next
> tree on top of the commit above.

Thanks for the patch. Added to linux-can-next/testing.

Regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--wf6zkoaopeuzp55v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmI4cUkACgkQrX5LkNig
012NSgf9EivbGzj8YWszX1kiGTU8gvWE/4QaiT05Z/0k+iIEjLr2d9zE3UnTW2yP
gWhJZaInj+T95cldNrcHHQTDYy+6tYbbBgPO8NDHDJAx+BgBkqzaqs7R7HA4ro5k
noQu5raLVX0zZEC6qO5nu9E3a88NJnTWkUXyuAu8wxkBRFfYooIA9sECcaRd6B2k
VnYEZ9jq/dB7/37J99qM3stFcoUupA1Z4zyqoFxGdxeM2ru4/WogwkQDAPS26OuH
IBu77gt6JJqs8XbKuUt4eYWL6GoNxbFO3d7c/HSAae0V5Ajd5/rdFYJJX5IKwiaq
xX7pCYl8p0oqLbdbgRvfAFpK9vzBWw==
=mvu3
-----END PGP SIGNATURE-----

--wf6zkoaopeuzp55v--
