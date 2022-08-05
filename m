Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2297458B09B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 21:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241372AbiHET7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 15:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241255AbiHET6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 15:58:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2304D14B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 12:58:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oK3Sz-0001L6-Kr; Fri, 05 Aug 2022 21:58:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oK3Sv-001xCF-PI; Fri, 05 Aug 2022 21:58:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oK3Sx-009msZ-De; Fri, 05 Aug 2022 21:58:39 +0200
Date:   Fri, 5 Aug 2022 21:58:36 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor.Dooley@microchip.com
Cc:     Daire.McNamara@microchip.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, robh+dt@kernel.org,
        thierry.reding@gmail.com
Subject: Re: [PATCH v7 3/4] pwm: add microchip soft ip corePWM driver
Message-ID: <20220805195836.vh3wv4xbpwjhuvfs@pengutronix.de>
References: <20220721172109.941900-1-mail@conchuod.ie>
 <20220721172109.941900-4-mail@conchuod.ie>
 <20220802084619.wunl3nglcpgo6j5i@pengutronix.de>
 <e55e4a7f-b0bc-f48a-b555-d4b96d69bb87@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gci3n4sxshtnuiph"
Content-Disposition: inline
In-Reply-To: <e55e4a7f-b0bc-f48a-b555-d4b96d69bb87@microchip.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
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


--gci3n4sxshtnuiph
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Conor,

On Tue, Aug 02, 2022 at 12:34:14PM +0000, Conor.Dooley@microchip.com wrote:
> I'll fix it all up & submit v8 after -rc1.

I discard the whole series in patchwork in the expectation that all
patches will be part of your v8.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gci3n4sxshtnuiph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLtdmkACgkQwfwUeK3K
7AlcuQf+PzHja618Q4oqXducHw/jRkMygZFPSXlBZTRuIoMQZ/pMHPLAlMHM5pkw
LXJbuMYpU/F7n42/VVs9CsnI1xLmpUTSRFfrJB4YEkiDUBsw0h46rZHKL04vZKRh
y/0TmS4YBcoeSVUyylpD5J0ngNwTcpqG7LRjCfrCPYsXRDi90t6IUYw5e1aJ01hH
zHTAKzv4tdXT4JWO6lnNBuwa/Px1AMvtTg476WI7YlVV9ekIM6pNPIzBb+SsrDJL
LD/EnTBopac1x1qDSv9ZYwJqODqMYWBPxtXKFdZhw9yyWutXLE7eu5E/HpkMDIBx
ZU3e0rIV8+7YfqTZPGxu3+qaG8YLkw==
=txLA
-----END PGP SIGNATURE-----

--gci3n4sxshtnuiph--
