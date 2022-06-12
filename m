Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F88547C63
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 23:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbiFLVSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 17:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbiFLVRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 17:17:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD31459322
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 14:17:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o0UxA-0005xS-DG; Sun, 12 Jun 2022 23:17:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o0Ux9-000AsY-HR; Sun, 12 Jun 2022 23:16:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o0Ux8-00FuSK-B9; Sun, 12 Jun 2022 23:16:58 +0200
Date:   Sun, 12 Jun 2022 23:16:56 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor.Dooley@microchip.com
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        Daire.McNamara@microchip.com, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20220612211656.eoqutfa36ngu734a@pengutronix.de>
References: <20220607084551.2735922-1-conor.dooley@microchip.com>
 <20220607084551.2735922-2-conor.dooley@microchip.com>
 <20220607200755.tgsrwe4ten5inw27@pengutronix.de>
 <eefc366e-1d32-7565-0d6d-243b8addc381@microchip.com>
 <20220608151308.ym6ls3ku6ukhtly6@pengutronix.de>
 <149da575-7ff9-9897-ce13-37c0f061b63e@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wncvypjdbe7brpnu"
Content-Disposition: inline
In-Reply-To: <149da575-7ff9-9897-ce13-37c0f061b63e@microchip.com>
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


--wncvypjdbe7brpnu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 12, 2022 at 01:00:53PM +0000, Conor.Dooley@microchip.com wrote:
> Hey Uwe, one last one for ya..
>=20
> On 08/06/2022 16:13, Uwe Kleine-K=F6nig wrote:
> > Hello Conor,
> >=20
> > On Wed, Jun 08, 2022 at 12:12:37PM +0000, Conor.Dooley@microchip.com wr=
ote:
> >> On 07/06/2022 21:07, Uwe Kleine-K=F6nig wrote:
> >>> On Tue, Jun 07, 2022 at 09:45:51AM +0100, Conor Dooley wrote:
> >>>> Add a driver that supports the Microchip FPGA "soft" PWM IP core.
> >>>>
> >>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >>>> ---
> ---8<---
> >>>> +struct mchp_core_pwm_registers {
> >>>> +	u8 posedge;
> >>>> +	u8 negedge;
> >>>> +	u8 period_steps;
> >>>> +	u8 prescale;
> >>>
> >>> these are the four registers for each channel, right? Can you add a
> >>> short overview how these registers define the resulting output wave.
> >>
> >> Ehh, only the edges are per channel. Does that change anything about
> >> your feedback?
> >> I'll add an explanation for each, sure.
> >=20
> > So the channels share the same period? If so you'll have to keep track
> > of which PWM channels are enabled and only change the period if no other
> > running channel is affected.
>=20
> When I am capping the period (or not allowing it to be changed in this ca=
se
> here) should I correct the duty cycle so that the the ratio is preserved?

No, the thing to do is: Pick the biggest possible period not bigger
than the requested period. For that period pick the biggest possible
duty_cycle not bigger than the requested duty_cycle.

The focus here is to do something somewhat sensible and simple.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wncvypjdbe7brpnu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKmV8YACgkQwfwUeK3K
7AmuQgf/esrFdmgkAoLjyqIsxyXenbDBgm/QoJrnjeFiCoHaCmEYUuNJDi4ykUUy
ahr3+eaXLsAEXNItWMTjDGIBNlatVnncgXDqNWXshpyjItm7LGSjJqUTNyMzJlOB
xq+4EN5VEz8UcnOJzG+zZ2nX4Fnm0CZio1O+JqDc/zwoagBQkHvceVH4X03GP0jv
smeehKQGxuxXZEsde1xb4G3Ss47wJeEFtfJWGwo6QEWEz5VLj0JH+cDjtfUZMcAC
DXqqCEN2WBKNRB/R6JsLStZn3VWoVW/yFyQ9VLHxd0aK9HGRobHOj+ew1Tse+tg7
liDPu+MBPJdyPgYQOyFY8kG54AI94A==
=y/r8
-----END PGP SIGNATURE-----

--wncvypjdbe7brpnu--
