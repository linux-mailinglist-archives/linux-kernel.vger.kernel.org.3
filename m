Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5299F4A7070
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 13:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344054AbiBBMBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 07:01:34 -0500
Received: from mout.gmx.net ([212.227.17.22]:58157 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229848AbiBBMBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643803278;
        bh=DG0I89u/xoEtET/fIjlaMIIbu9UDAXTghXDfdeYsOrQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=fU4Ais4GGYiQEV+WI/7iBj5fZhROPD3gkNTFRYD4Mv83dEb/88qNAjva0rl9WeCaP
         +rvekP35tpXY9qbvfpreIL8DRGCAchTMjmAFRRw5EcMVo8AVM1Jrw85m6QIbGOI87v
         g+dYyJ8JMVd4E1xt+nd7dX+GGLTVE2nQuByyO6jg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmjq-1mlzAS2jBS-00THUq; Wed, 02
 Feb 2022 13:01:18 +0100
Date:   Wed, 2 Feb 2022 13:01:16 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>
Subject: Re: [PATCH v5 0/9] Nuvoton WPCM450 pinctrl and GPIO driver
Message-ID: <YfpyjDBH83FE7r4o@latitude>
References: <20220129115228.2257310-1-j.neuschaefer@gmx.net>
 <CACRpkdYEigGHkoGfBg15tFXadgpXUAjDOnw7ePXhmvHJqPEJXw@mail.gmail.com>
 <YfZkis8M81Ejpagq@latitude>
 <CACPK8XdFXRQf3MpPh3z=EMAKtnQSHL+iwwMCVYc5dP9DfQEN+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yUAS+izAGfHMhGZS"
Content-Disposition: inline
In-Reply-To: <CACPK8XdFXRQf3MpPh3z=EMAKtnQSHL+iwwMCVYc5dP9DfQEN+Q@mail.gmail.com>
X-Provags-ID: V03:K1:YWqsdi+eBk6zLt0DaPphq9cAs1M4Jyld/+a8Ne9Qv2A65ipmJM9
 gBqcjVV1uCHTMUg2FSopPkMYcU9kVVCdv23cAmQK4hSYFeq8AwkzXB3S3eXrC67EX5CoFYF
 sCL6s748R5Jdl0w+NrAzcp3l+OooUcjYusrOGo6ffitEC5Ff9PEP5cjtu0KOVz1PnqWIzdF
 IuVtC7xCR7DJUMHk56Euw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vny+rQ3ZSLM=:hUza3+afPJJCbjITS1BZVL
 iXLt5zOx2s2qxb1WeRMOhA6IRPLd32AVKrKv78ScFI1uYGDrjQh/djRSeKO9meZbq2Am4wK2Z
 6cIwauVX1HTDpjheE6Dv3A5JU6GaobR0+x9lHXhYKyO0vewHjbYURhmfVfiCw2/bXtNR40rFk
 i8PYjxaOQ6CTXlvsq5yHOt+6vU7jwqe2fdPGzzq8dzjspBsTy3iO3X7cj6DibK1bU/e/IbTce
 375EbZrNzu39AH4djXPlaJ9iH5O/4xahxEnljKPav6ez+0BiWKvo3q3mViFHSLI9ofnSCNrje
 HRqGob4g9/GwBhKdr0576Q+WcYH8o98w0r3Q4sYr3dK6JMwOT53fSoOxs4vi7xq+XhSjarMQW
 5C1Qr1JJs0cd9/A5f8szFMvR9dUwBruI3n5FBwD9D1QvwD2u8W5b4kLTzbF/2Y6c+nrx1i3Nx
 bIRKTsYq++1j+wY8baxTqJSfkYI85qUfjTwf3b4ZFoyDsEOjpE8cquWTgAe2kLb8at8MRZ22W
 YnJbVFb+nPs9AR6OL1Iupj/87ylwmUaa6wtb+WBjArIe7Tmpg2NxKtTmyCkPuVrUvxVzR6Xst
 hFeEIm9df3OooHr8vFoz1U+pM7ogQIf5LCqTot4CRqPAOu4V1r4LdQNUwl2NjMVKdMD7EHBgx
 Tl/T+6ZJPI6B4nWpTTFOWgBhEIePRCIrgdFLgIsf0ZMfu/orfXXRTqws2UAeSaDgxRo5Fjglk
 R18SOKpPxQKkJkFnHIz435v2uGc9/V9o9gIGI78PhOiYPa/3YQODzPNQVjRC+4R1ATHEAxwOV
 /HWCEUxHqx3OuG75EXXfZuiu7q7fKjOpNJIG4hMaocS2oaumWP7XkW4oq0JC4S1FVXq3Ushf1
 J02osc8ftZcwv3posAIpXvyoaW3hL219yEDi2FKBI85AMPjJ30K3C45mtnAXLogdUhmB7F7nx
 cjDZTgNjvQ2zttOBML+zj0vFHkMm44rQgCgpXkZwqgxno+ezSeRgbf9zvdXxAVvCFMKLHX0ui
 ngrTcTR29c2rMMo+6/+Rr+pBq/gMrIgMzaltuRLUrYUHGAwWnLUpDw9XoskMBHCAdb+EfxlJ0
 pGbyVn1tE6r2Iw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yUAS+izAGfHMhGZS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 01, 2022 at 11:42:11PM +0000, Joel Stanley wrote:
> On Tue, 1 Feb 2022 at 13:05, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.=
net> wrote:
> >
> > On Sun, Jan 30, 2022 at 02:50:25AM +0100, Linus Walleij wrote:
> > > On Sat, Jan 29, 2022 at 12:57 PM Jonathan Neusch=C3=A4fer
> > > <j.neuschaefer@gmx.net> wrote:
> > >
> > > > This is version 5 of the WPCM450 pinctrl/GPIO driver patchset.
>=20
> > > Which patches do you expect to be applied to the pin control tree?
> >
> > These two:
> >
> > [PATCH v5 4/9] dt-bindings: pinctrl: Add Nuvoton WPCM450
> > [PATCH v5 5/9] pinctrl: nuvoton: Add driver for WPCM450
> >
> > and the rest can go through Joel Stanley's BMC tree, I think.
>=20
> Seems reasonable. I assume you're sending a v6 to fix some of the warning=
s?

No, the warnings are fairly independent of this patchset, it's just that
the adjacent pinctrl-npcm7xx driver started to be built by the bot, due
to my Kconfig change. I'll fix them in a separate patchset.


Jonathan

--yUAS+izAGfHMhGZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmH6ckMACgkQCDBEmo7z
X9uopA//dcZaTmjymc48RpOuC9ck8TQlUVQmUtcW8EHdRYgWGKlmjgmgcnHf/8pB
c3ZyzpYD/Amm594bUvNR8du8Ew/E6GO+MtL1iDL8I9rbQ67vzNnX74oT2wRcZ/pW
kSoSamv1pFgLnVoI4twifrvZXhw5kqrT0pZbjofikXFMF0RbYhs7AMWzz6thqrPv
EvLOvKbaVLhduQ/tz1E3pKlHfZ1JaIqpNgaJGj5y3+ScUavPaeJ2Gmvw16fnvCOg
rFmMevibWKOiqed3TRweyU0UBpeThWIvAWwkruwojZGAi5wlk1lpbDJj8l9xqx9l
V1hwC1rF9VCVshkB4BBaUFPEDp85LoncbIIHSttKDMviCdO2PyR8xXPnPyGOczaA
MV/CdkaO81DaqnHiIlJ/1gPRD53wfpBt9M9X+vv2xZte3fKfLhokfwq3a2zlyqt/
tZq15BViGD+OSsQzQ8X3/odUMJ09k+ym0X5VUbHpzIMM04IS2Ys42c83nWyqh4Uv
5LQHC7BfvkNt8wxKp6hxdcEp+4gL098nk0uB4luRI1AGkqh/PFML3fonNRPuQvCo
Akq0BejtptUnpdxjRW6WQydQSLVBYCVmqfw8R8lW+MTqC8VWTakNAap+JjeL08Al
RBkv8tUMvkeUgPkW9bqMGl57LK0YL4WfNciLe1VIjopJlUy4ZwU=
=MUta
-----END PGP SIGNATURE-----

--yUAS+izAGfHMhGZS--
