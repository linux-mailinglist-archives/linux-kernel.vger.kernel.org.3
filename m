Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD805633D4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiGAM4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiGAM4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:56:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38C03BBEB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 05:56:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o7GCT-0001xb-7p; Fri, 01 Jul 2022 14:56:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o7GCO-003muO-9Q; Fri, 01 Jul 2022 14:56:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o7GCR-002Jys-03; Fri, 01 Jul 2022 14:56:43 +0200
Date:   Fri, 1 Jul 2022 14:56:39 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/2] MAINTAINERS: add pwm to PolarFire SoC entry
Message-ID: <20220701125639.3sbafn7hsfsi6e7y@pengutronix.de>
References: <20220617114442.998357-1-conor.dooley@microchip.com>
 <20220617114442.998357-3-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fny2pvyg3zhnbzkv"
Content-Disposition: inline
In-Reply-To: <20220617114442.998357-3-conor.dooley@microchip.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
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


--fny2pvyg3zhnbzkv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jun 17, 2022 at 12:44:43PM +0100, Conor Dooley wrote:
> Add the newly introduced pwm driver to the existing PolarFire SoC entry.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f1b4b77daa5f..d0b39fa4f309 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17091,6 +17091,7 @@ L:	linux-riscv@lists.infradead.org
>  S:	Supported
>  F:	arch/riscv/boot/dts/microchip/
>  F:	drivers/mailbox/mailbox-mpfs.c
> +F:	drivers/pwm/pwm-microchip-core.c
>  F:	drivers/soc/microchip/
>  F:	include/soc/microchip/mpfs.h

The change looks okish to me, but it doesn't make sense without patch
1/2. So I'm discarding this one from our patchwork instance, too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fny2pvyg3zhnbzkv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmK+7wQACgkQwfwUeK3K
7An84Qf/T4slkYPXeMf/DX0QXgxmtPj+FdfqZK/7rmnnSvlyWYAgAbSNoAuEppwu
jZLUtt9oLIb+5RHyrPG5Pq7cfjQ/7Mx1nsqx+Zy++zX84vzArIOINxbFg3xkr60k
zO51xsBX0pR4xG8HOVus17ABkZK9FBhr1fjQ4WHDKn2nhRfhto+yR/pfaGjE8F9s
u/y1Kg9djPrZHHPHV1/OjahHCnTdq/jNn9kHARpoNBZ5XpHiEIf53/E3Uoptafln
R09YGYo2Z4Rw+ysJgZSFMNd41cUOSYEAUAZVHInPEFf86DFh4bn4uc1jeXXJsofi
tqvBvNkk5ME5m3YDvMLOZo5KGoE8pA==
=jHZQ
-----END PGP SIGNATURE-----

--fny2pvyg3zhnbzkv--
