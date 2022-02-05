Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBF74AA8F1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 14:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379912AbiBENAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 08:00:02 -0500
Received: from mout.gmx.net ([212.227.15.18]:44621 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355661AbiBENAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 08:00:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644065980;
        bh=1IqmQjorxNrt4F6tQMG/nOvbNUC2Mp91gxt+Hj3iYgM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Yf+xTvUfGhHGSnWu8+qcktMONlYsx28bdHok1EnRV5Zrnmjxzw7QnUSX30oTZ6CpR
         Rin1hFmG3tHBAaLSZOtjd8gtm4Q4lHWa/bSrbkraznBxMZJmTISL7DcgfuRGnd7PCy
         bznsbp1EfE8jS4eRthWPnAVVDfP9G3Y2wIGWhqxU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mg6e4-1mZ0ks0VTS-00haJx; Sat, 05
 Feb 2022 13:59:40 +0100
Date:   Sat, 5 Feb 2022 13:59:39 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Yang Ling <gnaygnil@gmail.com>
Subject: Re: [PATCH v3 2/4] clk: loongson1: Terminate clk_div_table with
 sentinel element
Message-ID: <Yf50uxydH7sttAVY@latitude>
References: <20220205005232.772726-1-j.neuschaefer@gmx.net>
 <20220205005232.772726-3-j.neuschaefer@gmx.net>
 <1415e1d2-eca4-aa36-6ef0-708b8290089d@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HXzDeesQ95HhXOjX"
Content-Disposition: inline
In-Reply-To: <1415e1d2-eca4-aa36-6ef0-708b8290089d@amsat.org>
X-Provags-ID: V03:K1:BrbQdp4GKw/jCPwkILQyxzKGlwAlUaOqAdpuJXjWj9+S7tOnyNs
 /0rpgH5rFBDcvHMz1UDgngnbQFaVrpE69Nmb9b9Y1/2hVs6Ysp3hpsjHEPmI/mm+HjAGP/+
 nzy01N4E9WNbB5jydL8+IgYm/kXnBRyslTiUFWD2HEqiVLw9tvWz7hMaBXUZa4Xi1iKGIuZ
 Tv0bMY+3B0nbpCfr+ggAQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0QZG7XUGy58=:m5P+A9LQ8kYOHU+LAHsnFR
 rxZ22AJ1toKvSE64l/pALe273Y3qPctoWy+vRRoqUyVYJ2cj6lH9/5J0z2CKZkcBsLWPV4xhX
 SNlbgCF26OSMGv7deK/GDeX0H/K7zdwraWDhu5e5v5eHkNF0giJlxtcxPq2fGFBxtKdAqjktC
 wr0kNIpbUQSFGj1iW4WYRSF8opLaIWjoxo+zV9m8lMyU8m2UJLZmabzeoT+vMQQX4RShkCxdQ
 IZtR4tZOby2ePxdpj1XM8SiXBAjZp0Sxu19J77AlwxVXWjyE1CskOS2cbDp3AQSHRo8DldKl2
 r7xmb7qnuhnT/Y2ce1F0HkQq/bu22Nc5z2zCbJseJby8EKkt/s0RZa1RXCrITtNoHfl8itp0S
 MCY/aZKMdmjIHfmqSHVj/hSyIdMy//pC++f3TBfkfD7ORezpf2h15QnKzt/6rBLYOwwx/Nidu
 5KTQARHmmDPNkz+aIXsPJ8oOaIYfbk/ArdUJ/XqGpz2F3Pqstt+QOjiHhilixnvNUtyXClVal
 +03zIoxH77aMNziouf/9hMTSxqbV7yBCJwBiRbpVaLpauVTRhSwRFqifjx1AI2r013YxsFueq
 C+giweY5xmRgcsAQ1BgIuUqmETGNpc772Rn5WJ4QaZjVdfvqLO0rZC11uH60+yS9RkCWZiTdm
 k5HjF/5U0Bv9yxzWRF1n1SkNrjJonYT5G0sYID48SQsEPcMnZq9/ybzG+mhpQUtsShkO+t5m7
 6V2SSe+GKzc0nQD8UZMXFbBLfxk8kBWaFy2AmyVeH5C6D0BneQTG2Y0lxLuMP0KzDGmVBubNz
 rIjqWmFYr9eOpfHVhOWkdnDxu4cvWTGYTRMJ4p6LxGvVXa4RKN9uLa7N0fsfuR+lYS6lCYa5M
 76zGgO/KmexeEaCA/ntgrFdxdqGZED2y5UpbrCrJDlqqUnaH8QOZ1iuB+NnkVww+w5EZVzhAD
 RNC/5N/c3r6A6eFJ3o95DERgfFQkGW2HhwWb3X2IVN5qkKAOTi0Fu3IyvStYxipMJJsTDubr6
 /SSuUxD4+gK7k+Xhe5k1uHNVAGQn9M7UjVlUgqAiIHitkD5YcaFz5V/F7ClLHAPGIYBrzyqvT
 TKVhVC5nb/qpOI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HXzDeesQ95HhXOjX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 05, 2022 at 01:17:10PM +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> On 5/2/22 01:52, Jonathan Neusch=C3=A4fer wrote:
> > In order that the end of a clk_div_table can be detected, it must be
> > terminated with a sentinel element (.div =3D 0).
> >=20
> > Fixes: b4626a7f4892 ("CLK: Add Loongson1C clock support")
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >=20
> > v3:
> > - no changes
> >=20
> > v2:
> > - Add Fixes and R-b tags
> > ---
> >   drivers/clk/loongson1/clk-loongson1c.c | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/clk/loongson1/clk-loongson1c.c b/drivers/clk/loong=
son1/clk-loongson1c.c
> > index 703f87622cf5f..a6f9f20fc8b99 100644
> > --- a/drivers/clk/loongson1/clk-loongson1c.c
> > +++ b/drivers/clk/loongson1/clk-loongson1c.c
> > @@ -37,6 +37,7 @@ static const struct clk_div_table ahb_div_table[] =3D=
 {
> >   	[1] =3D { .val =3D 1, .div =3D 4 },
> >   	[2] =3D { .val =3D 2, .div =3D 3 },
> >   	[3] =3D { .val =3D 3, .div =3D 3 },
> > +	[4] =3D { /* sentinel */ },
>=20
> Sorry for being nitpicky here, but we don't need the trailing comma,
> since this is the last entry.

Good point.

Thanks,
Jonathan

--HXzDeesQ95HhXOjX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmH+dLoACgkQCDBEmo7z
X9tZsg/+KEJgbQUsX59zGsXcTp9JTu2ZhvyRUZU1Us8T3jTG0jvjS3Itl+tqRX2M
P/sphmKa34AVJKfK0NDW0JUToT46cRzaR9xgHE1MFoKmyWHqQymhuOTWeQthDH4R
0+wHNt7PAQvY5r29873yrzEQU+0sN5iuydaiI5DecaYtz0w3pxltraEUHZ0CK5kw
wuLoDZC56058LeXmCm5TOzAe+kGAoNhaEd1glLZbyBl5iGnAoi0gadJNZaGBjjx9
yURq3t9/j4mHqcrFaBLhNysQaNtJyMxijy06BRzzywEPfigdRBE2/1gLAbeR6YeT
PIKGTxGme/UdPHrhG5A+VEHwMHxn5q4ktWP2IKIiV1lhCUoklTdn8bSNHD/3XJYI
0IruXzxigB2W0JLCW5q8L0MXL7BWFG7S3kCTpD3JG8BAIFuG58haNTIEiBO/Hl/d
mnx6Ys+FLXA0k2v170vEDUHVmiC5xoNBsiaUaLJ+VzpTQlDrz899BZKMjsG9a8vq
BXbLBYqhX44BCyvTy4F35AjWMjn3jJrtY7510ubk4/fKIy4yxb/Yth1rk2In3v1I
ktydv164jCDiRHDjI1oJDGGTgK/5fN0InbxpdoaIJTNJhT/osiVcKbPAsSZPGSul
Xc9wHQM3RPTKbDCAiKaEEHkodiJ2b6W0w9sVEW6bU68sbDVvm9w=
=4g7R
-----END PGP SIGNATURE-----

--HXzDeesQ95HhXOjX--
