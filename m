Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F0454B070
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356738AbiFNMPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357234AbiFNMNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:13:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E454B26D1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:13:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o15Q9-0004yC-MR; Tue, 14 Jun 2022 14:13:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o15Q0-000U8f-Kk; Tue, 14 Jun 2022 14:13:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o15Q1-00GFDm-5P; Tue, 14 Jun 2022 14:13:13 +0200
Date:   Tue, 14 Jun 2022 14:13:12 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor.Dooley@microchip.com
Cc:     lkp@intel.com, thierry.reding@gmail.com, lee.jones@linaro.org,
        kbuild-all@lists.01.org, Daire.McNamara@microchip.com,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20220614121312.hfotzvx76i4fda6e@pengutronix.de>
References: <20220613111759.1550578-2-conor.dooley@microchip.com>
 <202206141813.qgogbMAN-lkp@intel.com>
 <63334bed-17ba-fed5-9463-9fd52fd57351@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2cqte3h4y34ec6lw"
Content-Disposition: inline
In-Reply-To: <63334bed-17ba-fed5-9463-9fd52fd57351@microchip.com>
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


--2cqte3h4y34ec6lw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 14, 2022 at 10:34:00AM +0000, Conor.Dooley@microchip.com wrote:
> >     xtensa-linux-ld: drivers/pwm/pwm-microchip-core.o: in function `mch=
p_core_pwm_enable.isra.0':
> >>> pwm-microchip-core.c:(.text+0x380): undefined reference to `__udivdi3'
> >     xtensa-linux-ld: drivers/pwm/pwm-microchip-core.o: in function `mch=
p_core_pwm_apply':
> >     pwm-microchip-core.c:(.text+0x586): undefined reference to `__udivd=
i3'
>=20
> I assume this is me using functions that are only defined for 64 bit...

This is usually a division with variables > int.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2cqte3h4y34ec6lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKoe1YACgkQwfwUeK3K
7Amj+Qf+Lx8YJijRTh3pxwVyz/2Fng8mmXJyOtwyQc5Ms8eZ4StZTQkQ7uWPbhOi
XLF3+gCNa1zhsNVHcGZN8ZHMXJrQDSY4OIgAnWqeCivbOKBTphBATvTmWeV4JRz0
9Yl6PkbHIWE3Vj7p29Ic3z/7CZ5tsa7Qa63GyFGEee/XnALZO93emZY6ffKq23is
ifZtH2YBki7cO8mZoORQdFuQyaduLLaU5Rp2qlPk0G6ubfxwZAdh7xV8TvT4wlX+
K4sSaLk68hA2w9mHJVJcGkXOxl+g5tn7SsLk56Wds8fr/GWb0GEc8Oz68+MwQ6Uz
ODW+LRCs1U5tThiYfdVNsJe7HN6tuA==
=VeKf
-----END PGP SIGNATURE-----

--2cqte3h4y34ec6lw--
