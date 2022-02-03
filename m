Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933284A86C4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241347AbiBCOkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:40:39 -0500
Received: from mout.gmx.net ([212.227.15.19]:33733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbiBCOkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643899223;
        bh=rRjmFdAesvKhjyp7CmXgshmx7Slt/RMJF7feElgQOgg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=XeDnwBrzzivc02u0dt61dSPYT0i3jk+vZPYNQWHHut7tdGgJhqA6dQFmklX3OojdY
         BnWIHy5R6xzLcB4+2cTjbIDDbrt/hlf9JSUVhGqIbm/jX08ZTo0FQBkb02534/2jBW
         xB81Kk9Rr34KFYfFw8s0ih0Lx/nRzsg046GgQDpw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([185.66.193.41]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MacOW-1mdXe12BII-00c7Un; Thu, 03
 Feb 2022 15:40:23 +0100
Date:   Thu, 3 Feb 2022 15:40:21 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        kernel test robot <lkp@intel.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v2 1/2] pinctrl: nuvoton: npcm7xx: Use %zd printk format
 for ARRAY_SIZE()
Message-ID: <YfvpVVigOc4eEdR3@latitude>
References: <20220203133736.246397-1-j.neuschaefer@gmx.net>
 <20220203133736.246397-2-j.neuschaefer@gmx.net>
 <CAHp75VfrygdyjgQJ7iRnGL-CELCQ+6D30r5aWwitCTUJvGVf_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eVcSzelghXg5He3N"
Content-Disposition: inline
In-Reply-To: <CAHp75VfrygdyjgQJ7iRnGL-CELCQ+6D30r5aWwitCTUJvGVf_g@mail.gmail.com>
X-Provags-ID: V03:K1:4bBE4nsJxFwrk9zc0XZ0PREFwZZ1cGi0gqitsnTcJKy/+lrRauz
 b9vy3mLTWGwrHzedGDbuRRyQe5gy1LKRVIArrtG8YzQ/QmrKZxQtwNOlC5Iblk8TgrpjIyG
 1ckR8eF5g39XIWw4Q4M8I/fyd2UjO2nN08NVZKQ4/V7HBmdVvlq5Pog3IYdhOVF6pSovm2v
 YxqT2SxvUiUxcAcl/gCrw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+52ExvH9WdA=:afTqJsb4yJJzNZf4ZDGLbP
 RcAVcOHm3lvpx+0qhqnud/B0YwPmGlP5voOgryctjJShdF+TJYFH3hxbBTeH/4ZA2uSfZBELH
 nNnq1TTh1DKLtgGPaYP2hmX4B0T9/NjtbQ1BjsLrEAk16RioaoXILW+oNsdM6gmYARLIq8eP6
 YaTUKWTUueUaUBHdwyJglj8kmaMwtUwfZw3Pd3G+GoaWBqsmcqR0uiGFvE5WPc1LGDDGxNu6K
 73CD0CgwtxxU7bgkhyESuHXVqWUQPL4EW2v0cryr0owqjdss64Z6u2FiSb8K27y7Lb8TzyPyo
 h/IDiqRXEAPEOt/FH1WeJ9SaBJgIkuee3LuCZN1FpfcDd87FDYdK7r142xOegNSORpAmrDkHh
 vYczgpVTFSDXRYgJ7Md1AKHkwtgNZmWd9iRLo4LdN05TKrY4W1t/HZVRJeRCLbirAQBfBczGM
 bTao48P8tl0cIEVAcHizfzNOjBQ8kOGcgx4A/JO3WpJaYY7Vy0A4vrxFuY4cmCg8gEn4L8XZx
 iSUk4wPUTiB3zyq3BCJ952hUHKmIEVorhnkzjM1nlev5//m9HfutCrt8oz4LwUtD/wb2GiOKj
 Od0jgoeEH1uW4gowDePceu7wxnekyysOEoId+cqs8wQuYtTyKELaCNg2yy7mkiDsOzctS1RDi
 TMzBHEqrLdIOGJHo5HK2dn9y1GFGW/31u2uB09gLmSAyNM+dcX/ReFKDI2I+5A7n/AfmgeVVF
 8DYQDk513RSRubZyzaXai5L/9M+v1czQjPrL+1W5gLTBCbrWfe81VP33jSHvh3XyhynwoIqcI
 XLUJEHE5v8wlwDTzCwpYxozqvHB44h3953TP20enPX3g3aBwZ2FZ79BniuV+hIABiodmffnxx
 mlwQnn1w/8Pa2Db61pLhdhqWMiBuGqv1bNT5Zd88R0hDQ6Ec1UeUKDAuw+n7/+01eSeGT7XFD
 6ADqTA2KOoZT3qZr091oeseG/g4+hK6/CoYOlKHemQKq8yEfbR2W1reRyaHGoYm+4zctVEMfo
 SrwatIdIhHJDcsKgFo+J+Lt7OmAZGVonmMSxxfOapRvtPLFqo7oSH2JPaqoL+88gOECWHL56q
 Vk67uhmqCccHPQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eVcSzelghXg5He3N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 03, 2022 at 04:16:56PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 3, 2022 at 3:37 PM Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
> >
> > When compile-testing on 64-bit architectures, GCC complains about the
> > mismatch of types between the %d format specifier and value returned by
> > ARRAY_LENGTH(). Use %zd, which is correct everywhere.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Fixes: 3b588e43ee5c7 ("pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO d=
river")
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>=20
> ...
>=20
> > -       dev_dbg(npcm->dev, "group size: %d\n", ARRAY_SIZE(npcm7xx_group=
s));
> > +       dev_dbg(npcm->dev, "group size: %zd\n", ARRAY_SIZE(npcm7xx_grou=
ps));
>=20
> Dunno how it's slipped away, but the proper specifier is %zu.

Right, I should have noticed that.

> I guess that's what I also mentioned in reply to LKP's report.

True,

>> Should be %zu


Thanks,
Jonathan

--eVcSzelghXg5He3N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmH76TMACgkQCDBEmo7z
X9ut4A//aOQLQWn/GISMFzJ4/Pq/g4sc9jjB+rZZhAxaAYaJXKdOoIq++a00Ng0/
MUq7qOV18RJQiA/KYLud7LOmRNsbQXGNzDo1Z4TcplE/MjJr2VsJe+OuXO3fzvNN
oJmEtfn0k3cwbiAPTkF00izWfjMGHfou/0xRX+NDoJybCt9eVwj8SUUW8fPdhwTC
smiOUgLo39wHTlvP6WQiLSHu1RP53qe5aiqL11ZCmeSHMzH/vlQcG0jhBb4/46AR
rB1wnbMEFap3VoZtRs73al6Ze+wPdmdL6sUB4e8L+5d59LDi9ROe02DbamgMf0VB
C+sDv3GsemHp62J/id20G8eFit9C/xSyjVmng7uHMxWt75issT62gIxrfK2P81q+
1dTEH64apssen6L1w4NiPs0pxzKmQ3vzO5FhypsaqHv/Qgc+C/nEu7drwaJ4MtSs
nXZR+QU2vSKBxR5GK3ezz4UIuZKU8ZOYVlryQPm+wX4MBDumeH41RPqdSX3U/OZf
OmCnFxWxTOFxc2aMt1JnKSxqMMFqLtQ18EDrj0WlxMOiW+f2f4RmS4yNAOyU0h5J
ToH0Undp8fPD3fCsIJhI+io7VR13Jq0pJVqG0XbnEd2ljRcL9fRLaGf1ggwT3Ork
ZKST+SfL/krulH/yaPmmB4ty2/1mDvNgWMXlc1zbeNwWmNBjsQU=
=r2Xy
-----END PGP SIGNATURE-----

--eVcSzelghXg5He3N--
