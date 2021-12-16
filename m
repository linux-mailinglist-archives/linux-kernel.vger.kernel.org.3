Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F26477DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241460AbhLPU6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:58:40 -0500
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:47070 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhLPU6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:58:39 -0500
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id D134AF40EA4; Thu, 16 Dec 2021 21:58:36 +0100 (CET)
Date:   Thu, 16 Dec 2021 21:58:36 +0100
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.ne@posteo.net>,
        linux-rtc@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Ash Logan <ash@heyquark.com>,
        rw-r-r-0644 <r.r.qwertyuiop.r.r@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3 0/5] rtc: nintendo: Add a RTC driver for the GameCube,
 Wii and Wii U
Message-ID: <20211216205836.yporkr4omon4mdd2@luna>
Jabber-ID: linkmauve@linkmauve.fr
References: <20211027223516.2031-1-linkmauve@linkmauve.fr>
 <20211215175501.6761-1-linkmauve@linkmauve.fr>
 <163964813197.6786.14005810276404182021.b4-ty@bootlin.com>
 <20211216202220.y6rctd2k72yuya5w@luna>
 <Ybun5qp6DH7qkAGy@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g7bzb2vspv7jrctf"
Content-Disposition: inline
In-Reply-To: <Ybun5qp6DH7qkAGy@piout.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g7bzb2vspv7jrctf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 16, 2021 at 09:56:06PM +0100, Alexandre Belloni wrote:
> On 16/12/2021 21:22:20+0100, Emmanuel Gil Peyrot wrote:
> > On Thu, Dec 16, 2021 at 10:49:44AM +0100, Alexandre Belloni wrote:
> > > On Wed, 15 Dec 2021 18:54:56 +0100, Emmanuel Gil Peyrot wrote:
> > > > These three consoles share a device, the MX23L4005, which contains a
> > > > clock and 64=C2=A0bytes of SRAM storage, and is exposed on the EXI =
bus
> > > > (similar to SPI) on channel 0, device 1.  This driver allows it to =
be
> > > > used as a Linux RTC device, where time can be read and set.
> > > >=20
> > > > The hardware also exposes two timers, one which shuts down the cons=
ole
> > > > and one which powers it on, but these aren=E2=80=99t supported curr=
ently.
> > > >=20
> > > > [...]
> > >=20
> > > Applied, thanks!
> > >=20
> > > [1/5] rtc: gamecube: Add a RTC driver for the GameCube, Wii and Wii U
> > >       commit: 86559400b3ef9de93ba50523cffe767c35cd531a
> > > [2/5] rtc: gamecube: Report low battery as invalid data
> > >       commit: 322539a014bcd24cbb9281832c09b24e07912237
> > > [3/5] powerpc: wii.dts: Expose HW_SRNPROT on this platform
> > >       commit: 5479618e1e2641dd57352a73b7b7b2f6908fbeee
> > > [4/5] powerpc: gamecube_defconfig: Enable the RTC driver
> > >       commit: 57bd7d356506b713d0df8d8e42da7810a18864df
> > > [5/5] powerpc: wii_defconfig: Enable the RTC driver
> > >       commit: 69e8ba80ddda4db31e59facbf2db19773ad3785b
> > >=20
> > > This one didn't apply ceanly but I believe I did the right thing. Can=
 you check?
> >=20
> > I believe you didn=E2=80=99t, at least that commit[1] seems to have one=
 =E2=80=9C+=E2=80=9D too
> > many in the modified line, whereas the previous one[2] doesn=E2=80=99t.
> >=20
>=20
> I knew I needed you to check, this is fixed now.
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/commit=
/?id=3Dc636783d594f6cfc95db51c796761719317ce5eb

Perfect, thanks a lot!

>=20
>=20
> --=20
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

--=20
Emmanuel Gil Peyrot

--g7bzb2vspv7jrctf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEjrVT1SzTln43kCLJOWgfYkb2LpAFAmG7qHkACgkQOWgfYkb2
LpB+lggAqK4bBYvcQJuO7l3AfG48bohYpR73j6lYIN6SfBi5N2F17LKCDz0Km5ry
8UYKuEIz1qt3LKKXc8SmEEmd5U8sP1rwy0fZKDAjy2OZu+2n+g7tpAmEj6wu7qdQ
I29nqeALUbY179Ykk3VyHvT9NHgqe4c7LMHqbuEM9mSFQlipOpeW4j0uNCFJHezE
ROx6Fuz5Gp6STzArDHpgtGrTS3yvt8KeuoeX8Xt2v1VRLTgYPlCnJLym7eaamH1M
TcId8j44UNck0AGfwTPgLUCM/IKDQxh+sEqmaexBJOa3EM6naG63QxUY9eegVYZv
M3/zwHnr+VPRatCx5NzZf+a+rjFDuw==
=VwOp
-----END PGP SIGNATURE-----

--g7bzb2vspv7jrctf--
