Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F23F51E4A4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 08:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445508AbiEGGkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 02:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiEGGks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 02:40:48 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FD940E6B;
        Fri,  6 May 2022 23:37:02 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 789541C0BA6; Sat,  7 May 2022 08:37:00 +0200 (CEST)
Date:   Sat, 7 May 2022 08:36:59 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v14 2/2] leds: Add driver for Qualcomm LPG
Message-ID: <20220507063659.GA6968@amd>
References: <20220303214300.59468-1-bjorn.andersson@linaro.org>
 <20220303214300.59468-2-bjorn.andersson@linaro.org>
 <20220504073009.GC8204@duo.ucw.cz>
 <YnKTAvQc6eDxTl14@ripper>
 <20220506160901.GA1199@bug>
 <YnVMcaRV86jZslhd@ripper>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <YnVMcaRV86jZslhd@ripper>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > As such the pattern sequence provided to hw_pattern looks to be the
> > > smae, but I don't see that it can be made compatible.
> > >=20
> > > > Can I get either patch to disable pattern infrastructure for now or=
 to
> > > > get it compatible?
> > > >=20
> > >=20
> > > I'd be happy to get this updated to your liking, but this was one of =
the
> > > drivers we discussed when we introduced the pattern trigger and led to
> > > the conclusion that we need the ability to do hw-specific patterns.
> > >=20
> > > As such this document provides the hardware specific documentation, as
> > > we describe under "hw_pattern" in
> > > Documentation/ABI/testing/sysfs-class-led-trigger-pattern.
> > >=20
> > > Please advice on what you would like me to do.
> >=20
> > I'd like you to use same format leds-trigger-pattern describes.
> >=20
> > If someone passes "255 500 0 500", that's requesting gradual transition=
s and
> > your hw can not do that. You return -EINVAL.
> >=20
> > If someone wants that kind of blinking, they need to pass "255 0 255 50=
0 0 0 0 500".
> >=20
>=20
> So the section under hw_pattern in sysfs-class-led-trigger-pattern that
> says:
>=20
> "Since different LED hardware can have different semantics of
> hardware patterns, each driver is expected to provide its own
> description for the hardware patterns in their documentation
> file at Documentation/leds/."
>=20
> That doesn't apply to this piece of hardware & driver?

It applies: since your hardware can not do arbitrary patterns, you
need description of what kinds of patterns it can do.

But you should still use compatible format, so that pattern that is
valid for hw_pattern file is valid for pattern file, too, and produces
same result.

If you believe documentation implies something else, it may need to be
clarified.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmJ2E4sACgkQMOfwapXb+vJMFACgv1L01dasG1ImG6KRZ5gYS2iV
eHsAn0pdBf62FwAjzmn9R2KEOJoW/1rb
=zdUZ
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
