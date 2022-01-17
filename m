Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2BB491231
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 00:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243768AbiAQXKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 18:10:55 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:35872 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiAQXKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 18:10:54 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7EDD71C0B80; Tue, 18 Jan 2022 00:10:52 +0100 (CET)
Date:   Tue, 18 Jan 2022 00:10:52 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Olof Johansson <olof@lixom.net>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LinusW <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [PATCH 00/23] Add support for Tesla Full Self-Driving (FSD) SoC
Message-ID: <20220117231052.GC14035@duo.ucw.cz>
References: <CGME20220113122302epcas5p1d45c0714fe286f8f91d0f28c3fad86e4@epcas5p1.samsung.com>
 <20220113121143.22280-1-alim.akhtar@samsung.com>
 <20220116092325.GA30745@amd>
 <CAOesGMhpw7+5Q3MDAFQTr8-sDFgVXOE=v6h8d8pbHiZn8=3h2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline
In-Reply-To: <CAOesGMhpw7+5Q3MDAFQTr8-sDFgVXOE=v6h8d8pbHiZn8=3h2g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2022-01-17 12:53:48, Olof Johansson wrote:
> On Sun, Jan 16, 2022 at 1:23 AM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Hi!
> >
> > > This patch set adds basic support for the Tesla Full Self-Driving (FS=
D)
> > > SoC. This SoC contains three clusters of four Cortex-A72 CPUs,
> > > as well as several IPs.
> >
> > I'm not thrilled by their naming. Intel does not produce "Intel
> > Fastest in world SoC"
>=20
> If you say so. :)
>=20
> > , and this chip is not actually suitable for
> > autonomous driving :-(.
>=20
> And AMD's Infinity Fabric isn't.... infinite. Things have names.
>=20
> That discussion seems off-topic for this patchset. It references a
> marketing name used by the company, and as such it makes sense to be
> able to cross-reference:
> https://www.tesla.com/support/full-self-driving-computer
>=20
> Tesla seems to have moved away from the initial "Hardware 3" naming
> scheme, so using this naming seems as good as any.

I'd prefer to call it Tesla HW3. Even wikipedia has that name, no need
to do false advertising for Tesla, and we'll have good names for
HW2.5 and HW4 if it comes out. We normally use codenames, not
marketing names.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYeX3fAAKCRAw5/Bqldv6
8pXrAJ991crIbz8luJ+Y25epSfypIwOj9wCgpttXss4rji1sswAsPeL+46QmffY=
=0J4l
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
