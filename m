Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C874A70EC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 13:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344171AbiBBMkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 07:40:24 -0500
Received: from mout.gmx.net ([212.227.17.21]:59757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231748AbiBBMkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643805612;
        bh=lZ4316Q44PluVsj1sPcy2CFLDYO7r+nhpKEFqWsIIjg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NdkqWDdn0NXzC/h0pU0+zBc2tw3R3Lai9pmWTF8lgCOr3eUGgnZDsZJ88V8z0/E4t
         fFDfHWPUoEe/BLNkpf1YgfAR83ZxU9fpxilpfak2Kvgv1muIfs/kR5Mmy7UNKedCQ8
         Yf82lDuZkvnHxmRUmMCgsJFxmxTp7YY4mDhhzdEU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMGRK-1my7mk0F4I-00JLCU; Wed, 02
 Feb 2022 13:40:12 +0100
Date:   Wed, 2 Feb 2022 13:40:10 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Joel Stanley <joel@jms.id.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>
Subject: Re: [PATCH v5 0/9] Nuvoton WPCM450 pinctrl and GPIO driver
Message-ID: <Yfp7qni4djRCr52u@latitude>
References: <20220129115228.2257310-1-j.neuschaefer@gmx.net>
 <CACRpkdYEigGHkoGfBg15tFXadgpXUAjDOnw7ePXhmvHJqPEJXw@mail.gmail.com>
 <YfZkis8M81Ejpagq@latitude>
 <CACPK8XdFXRQf3MpPh3z=EMAKtnQSHL+iwwMCVYc5dP9DfQEN+Q@mail.gmail.com>
 <YfpyjDBH83FE7r4o@latitude>
 <CAHp75Vdg8zFSHaTP_8jQua5QfRYbvZ4_rLdCtt3ks8YEibseTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R5woTQRwH04BjSJ1"
Content-Disposition: inline
In-Reply-To: <CAHp75Vdg8zFSHaTP_8jQua5QfRYbvZ4_rLdCtt3ks8YEibseTg@mail.gmail.com>
X-Provags-ID: V03:K1:manlM35z/hW/kYRc4Z+Fu1gQic/531v5Rk2b8zODaOSCQ/pEik9
 9OmFYjoMPaoibAtxV3rpuIo1t+FoURAzkDZfDn4YnR0G2ZZAiHFDCVwfe9RlujHs0lgSMVN
 guJn3RP410fuecCTPK4ZYk18IaDuRcgvIciVGf07XOT7b8PiminOY2t5E36dZS0gWQ95UuS
 3q67h/iyI/UvyyZriOUxA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UeiIv49JUjY=:DRkoabxXjIY4rxCd709AjA
 eCkHW91FMqYuvUm0vn4MnIIljx9nwYDCIHNqNU7KPbx6/h5jHw7ognyt4pZGal4FIb+QZ4fI9
 FS3ZtFXnn6RlmlIVR5QkcsEqaPcxqravCn9H5j/kdaPHi1sThm9Pj3c6y8loGy04dEmEM3dkQ
 9OKZNv71pxxAqFCHp1zM6xL46ImCaFbcS8guI680/aOpx8qf7eWzqrDx/IJuuSD0VGFrlCs5E
 KZ8lm6jVCG+60juJMUJNxHwHNQo6Z6wmwKezaC4y7r6ed5SdwROPYfNJxJvRanGrucVNw4qz1
 HMKLW4j1ns0JYtsdC45s5G3ISWa7P3C/J8tnBf2cNRn10Mqbr5V4Vi4OBCmxxdMJpdpRUgVNW
 GhsAdQ6cZG/0kjl3ZE8X6A0yMBBfFHjEkft0dbkwIP2Gx1A2bZfV2w6POpWtbFxSwRrjG/qFy
 6ULfZWugq7GXreMzaLoGDsRzFkOyBPfjYi4FjCJK8hUKH9PhTQNL5vWHEliyyxl6jEFMIdzUZ
 WVp+5ikh278qipsoQnm06gSaGXFUf05poT8lTQev5romc1KwM4GtmgOYgEWkKxorqblHtj+az
 yh8e0h9oT55Hog6fnILe3ew6qw57maEZ5jjsvK8pNSltAwhygcmNXlXwtck6y1Vk9gUkJOZ44
 96biw3PcpOBhv90C+OeInckVwAsgYoWR89DM6ECoGftHbIiSAJd0oRUOcgQ/NT2fXmRD8zCfA
 C4qba5wUtNZ5ssK8+69G5ZpRzEnIu6O5gCCUI92yoSInzBEJaZ/8cOAYxtYdjilHgVl/KDJUg
 dDELl7H4x3iaueYp9Qyp6fJRpCXnJMtxLoiC+B02cPG1ojz5RH0f3xayGfWH1qQStVyRmhGav
 b8zcChswCJi8d3qNtrBjfCVZTwSZDUiufSRi24kBgyT5GDAu0LrfUdIpy90Ghtqfkv/DXhgOz
 WWkjYvdsJtN4jq2h79xXolebIFeXHL6XogBg754r5unz1seB3BBF5MN2yYXo3Y74yzy8wwxiU
 ppnNtGrDN14QbNisxUXOsIBrXMGTG6StbrtUUJf3BmM/xCjUPsqrVzCiIUKzrDu6AZ9QATkEe
 jX/7V4Hq+q41Es=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R5woTQRwH04BjSJ1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 02, 2022 at 02:10:44PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 2, 2022 at 2:01 PM Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
> > On Tue, Feb 01, 2022 at 11:42:11PM +0000, Joel Stanley wrote:
> > > On Tue, 1 Feb 2022 at 13:05, Jonathan Neusch=C3=A4fer <j.neuschaefer@=
gmx.net> wrote:
>=20
> ...
>=20
> > > I assume you're sending a v6 to fix some of the warnings?
> >
> > No, the warnings are fairly independent of this patchset, it's just that
> > the adjacent pinctrl-npcm7xx driver started to be built by the bot, due
> > to my Kconfig change. I'll fix them in a separate patchset.
>=20
> I guess you need to fix that first.
>=20
> Because now and then all CIs will complain to your patch and confuse peop=
le.

Hm, right.

I'll send the pinctrl-npcm7xx fixes, and then a version 6 of this
patchset if necessary.


Jonathan

--R5woTQRwH04BjSJ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmH6e4MACgkQCDBEmo7z
X9vqjA//XOr8yfUq5cP1/TPoekmsBBV4OcpprXWKtONJX8zrJhuLbde1yIrOpoD2
L91zOk8aZysJxABmHucetpGBBtvM/ddJbX4PV0B308hrmSQ2sOY4Y3ZDMTsyd1kr
k2J6wna7RAC9AToOk7VGEg4XXbEu5FDFIdkcSBfa16sKIZU3MzlHhl2Z1Wwckf+Z
duzmJSpaDlTQxaDPwTr5fN3QYJ9Q56EgPBXuPa83ZMsal1VBZf5MrzoDBbAveN9j
Z+oeurb761NmtjT15ioLeug+Ym1v2Dr3fhjpoj8cdXkL2FJsIqV7S+Dxdqe6ApoL
RKYA0yGdZglW4XjLIjudGU+T68u4slrvl+OUs99YA7pV+MhG40heSGP8PdEeDIpS
XRNGboQV0mqgtIREoczo8Y3hJLBA3HfKL1jLUa9QXD1sNCTxiBp8ELnSfFY4xOtN
JXvks9+4hRw8C4ML3SWLjgqJfnlrBYPHDZWe4pctVdYqL13hLdv6qIe3hzI7MHdk
CfEhgf5KqSaJp3bz/YaGtIdmA8e7j3tIqt3VqmxsJEYH+i39VRywtM4dfuIxVA0U
c+YSPU531ARyTmssDLNwzZpXjXtjEIwXf8OA0Fzfz3GHqkaqHXLdT82CRo8+XTKK
IyDcNhp1R5oXdVfk7O6bhniQo3xN5H1xKYx6ijQoHlH9G0lkqDM=
=nFA4
-----END PGP SIGNATURE-----

--R5woTQRwH04BjSJ1--
