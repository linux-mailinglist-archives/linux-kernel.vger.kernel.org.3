Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6534B58781E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbiHBHpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbiHBHp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:45:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484C422B3E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:45:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oImag-0008IG-9t; Tue, 02 Aug 2022 09:45:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oImaf-001Gz2-GV; Tue, 02 Aug 2022 09:45:21 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oImae-0095B7-Ow; Tue, 02 Aug 2022 09:45:20 +0200
Date:   Tue, 2 Aug 2022 09:45:20 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     conor.dooley@microchip.com, daire.mcnamara@microchip.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, thierry.reding@gmail.com,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 1/4] dt-bindings: pwm: fix microchip corePWM's
 pwm-cells
Message-ID: <20220802074520.ayyjl5sf332eta3o@pengutronix.de>
References: <20220721172109.941900-1-mail@conchuod.ie>
 <20220721172109.941900-2-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qqmpwa5unzevycoi"
Content-Disposition: inline
In-Reply-To: <20220721172109.941900-2-mail@conchuod.ie>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qqmpwa5unzevycoi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2022 at 06:21:07PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> corePWM is capable of inverted operation but the binding requires
> \#pwm-cells of 2. Expand the binding to support setting the polarity.
>=20
> Fixes: df77f7735786 ("dt-bindings: pwm: add microchip corepwm binding")
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

I'm surprised by myself I didn't notice this when acking df77f7735786,
*shrug*.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qqmpwa5unzevycoi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLo1g4ACgkQwfwUeK3K
7AnP5Af/XZhd73YIdx2wsJViugHNrfh9xObg6ePSOGVeE9RzkIizBUQuUxVZt+Gq
7imbuubQrntsS0HZqxkwl24eGRPrSbAJrN+jHY323LTl72X3MbLIRBMLHLN2eZ1P
pbu6kCeR425V36EMSaJOAsAMEHHKuia73rwxuUL2G674Y0brEcZ914XLqgqgC1V9
+zhH0KFx9rgzEPWPIozeZgVK9AYjhYVgIZC7wj8GEqME1ppslZQt2czTU16cB3PZ
IsDIseICnSi3YB8poYd/9Od6RkyDW0Lq7r+6HwpxmgIvAzLOjWYWtZad09q1aAKu
+HmVReWtq83sFOepD+uHUmgmpmZcjQ==
=Bu3F
-----END PGP SIGNATURE-----

--qqmpwa5unzevycoi--
