Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A0C4C0E22
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbiBWIU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiBWIU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:20:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB873BBDB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 00:20:29 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nMmsn-0001hh-Uq; Wed, 23 Feb 2022 09:20:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nMmsm-000mFQ-1R; Wed, 23 Feb 2022 09:20:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nMmsk-004z5V-Gb; Wed, 23 Feb 2022 09:20:18 +0100
Date:   Wed, 23 Feb 2022 09:20:18 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     conor.dooley@microchip.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org, jassisinghbrar@gmail.com,
        thierry.reding@gmail.com, lee.jones@linaro.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, geert@linux-m68k.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-riscv@lists.infradead.org,
        lewis.hanly@microchip.com, daire.mcnamara@microchip.com,
        ivan.griffin@microchip.com, atishp@rivosinc.com,
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v7 05/11] dt-bindings: pwm: add microchip corepwm binding
Message-ID: <20220223082018.degrftmxpk5uc6xn@pengutronix.de>
References: <20220214135840.168236-1-conor.dooley@microchip.com>
 <20220214135840.168236-6-conor.dooley@microchip.com>
 <20220223062018.nbgidqxgh2soz625@pengutronix.de>
 <65edc257-82ec-e100-7a44-5c510aba51ce@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iwzv2cqxmtoj6ivg"
Content-Disposition: inline
In-Reply-To: <65edc257-82ec-e100-7a44-5c510aba51ce@canonical.com>
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


--iwzv2cqxmtoj6ivg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 23, 2022 at 08:12:49AM +0100, Krzysztof Kozlowski wrote:
> On 23/02/2022 07:20, Uwe Kleine-K=F6nig wrote:
> > On Mon, Feb 14, 2022 at 01:58:35PM +0000, conor.dooley@microchip.com wr=
ote:
> >> From: Conor Dooley <conor.dooley@microchip.com>
> >>
> >> Add device tree bindings for the Microchip fpga fabric based "core" PWM
> >> controller.
> >>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> >=20
> > I like it:
> >=20
> > Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > nitpick: Put your S-o-b last in the commit log. (This doesn't justify a
> > resend IMHO)
>=20
> It should be the opposite - the first. First author signs the patch,
> then comes review and finally an ack. Putting SoB at then suggests that
> tags were accumulated before sending patch, out of mailing list.

well, or in an earlier revision of this patch as is the case here. One
of the ideas of S-o-b is that the order shows the flow of the patch
states and if this patch ends in git with:

	Referred-by: Rob Herring <robh@kernel.org>
	Singed-off-by: Conor Dooley <conor.dooley@microchip.com>
	Backed-by: Palmer Dabbelt <palmer@rivosinc.com>
	Singed-off-by: Peter Maintainer <pm@example.com>

I'd expect that Backed-by was added by Peter, not Conor.
(Modified the tags on purpose to not interfere with b4's tag pickup, I
guess you humans still get the point.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--iwzv2cqxmtoj6ivg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIV7j8ACgkQwfwUeK3K
7Aloogf+O25Xs80EkRbZcoT53Op4Qz+T2M0ldDqTk6fHIxcR3qzb7m74O1AGSR3K
UfR9clLI5oaiJ77rpUJrj755Va3JCOlPiwB14+LakdvvjWlnf+z7h+DC892GcAaj
ML4S91q/Y/ORSl0189iTfICN78MRMs6UWjVJWX3wV/HqeFQi3fSMNXTjQ8IC6LYe
GWMVhC3eYpSFxsdqMDeAaEX6CChb0CwfAwMzWxrOt+6sFPfimaOMz4HgHpJsn1bf
qTj64t9fgifBN41OJNqirl2R2mPxKn/McocqNmDFj+o1DyQ0ikT1sqGFTjnEN3fl
I/W+Pfdxw50SJZHNxfcDTll9wibNTA==
=Be78
-----END PGP SIGNATURE-----

--iwzv2cqxmtoj6ivg--
