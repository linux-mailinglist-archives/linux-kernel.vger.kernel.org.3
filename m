Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229294AA903
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 14:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379926AbiBENHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 08:07:47 -0500
Received: from mout.gmx.net ([212.227.15.15]:36929 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233802AbiBENHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 08:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644066446;
        bh=C4VhI0nkTDxCgOfwq+qBldblHETjXjIVtnVjq1a3XVM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=hOvQrtIuSs5bXoELF+k/Los1k6ztgOw5wZeiqFu85AcN1SWcIwCGcEUjCIWWaixv7
         XE6ePoSVufmOKLy253N87oY2PWoiAJGi/hJHRMpexez6NnRFsc6ZSmfoYWaB6P5uWQ
         2UYalDwzBnwHxfJg2NWXJ/1h2G1ReowN0NtoVO+o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVeMA-1mojG605UC-00RZS0; Sat, 05
 Feb 2022 14:07:26 +0100
Date:   Sat, 5 Feb 2022 14:07:25 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v3 4/4] clk: clps711x: Terminate clk_div_table with
 sentinel element
Message-ID: <Yf52jcOQGvjWhCAL@latitude>
References: <20220205005232.772726-1-j.neuschaefer@gmx.net>
 <20220205005232.772726-5-j.neuschaefer@gmx.net>
 <df167547-a1b2-5b20-705c-33403ecf9e47@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sDjqsj/OIHo6mxie"
Content-Disposition: inline
In-Reply-To: <df167547-a1b2-5b20-705c-33403ecf9e47@amsat.org>
X-Provags-ID: V03:K1:fP/oSlxDV9neudojDaQbmFoTH770fUTV+vGft6K0roeaA15Sri6
 lisQCyO+uCtRdmMtixaseovb0wZmIb4ZEh6vjaZPycSBeiGvMrT733rU/VumV4hjz3nErGT
 r3uqQXOhy2+7sHWW+z+8aLy+c/Ic+qsalnwirRyL61FE4bsjoY7P5286A09ACEUAjM7f4a1
 cwQaFuTj5QE6UrihOCHPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lCfhPZbo8sk=:yJjxtEmyX0AhTSHjY8nHui
 J1A4rpuC+D9K8BVjWrRZrl4wLE+fD+U+yO4ve8iO0MrbrL33EXffH4/5Xkki+RKIVEg9UWzpF
 rKbCKZN61b173uC/CRddnC1Kqt2HNj3GBlkFCzTpgmGU77AuSom+4vEOG+Gkv0JKBjeYWU6kL
 uGGBuz861ntutTWwDC3F2DBfxJhS/dmJYcSuYPmfSzP2qCfPbsvjtuWmVCGPHLHmAg4jQLAfl
 wNt8avvgnWQBJJQ8U1cGR/+BNHNYrrYvvRd/xk1t/z7AmVcvMAmnF1z1bmC5zI8jEFBBsL0g9
 bnNRGlfsFgmNjUvAES8ihHI/rRT2H5IpRcEsN4iCghY54fddirpAWQyS859si1tFNdBTt4vCt
 6vJuZ2kypHiEM2X+V2aMjv8g4O22K9o4TrkTqZA/ld0IKDq05lqQCIqyadDmaQ+2ObKbmI/Mn
 Ip0mAMFNPTfcoSjlDiMerINQa3069xsE6dDkuDbDSwzf+kYeBa2u4XjIGqkBfyrMoGA1vcvsU
 WlW9EKOG3h8CfTWoUDnqW4+NKfRhLYM0SQm84zxUEd29Rmhq6Fl/N/hjyKpjTf2IqTks3Kua+
 q2ASXKdmdViBP0Q2uON8YWJMBIy+8e1YCgBuabhjLDQY34IU8JbcXcI+37GAqgzGLkiwaxoA1
 b0FPoAYtv+IGXUGNWDRoTylhTyv/FGK4DHlLAp5HU9De9tuB4W13KEljfb3d3knbfQhSmxTGQ
 hfinO1AAYSN0S8HV4YDEr5Gc3sFzYWUWVH7gMQxqINCU6fji3ka6PtMUmIlW7NTwgL/ClX8mJ
 nAzlcwcGN/iFtwlt2f+Bxma3PDe5REJRVuIKwU02C/69WaDQpeCXp43eEPSMGJ1WR6hhCF/P1
 3IMSAT0Zmv8AL3zyIer9nGyrOqwFP7FlUOXXjpkGow1X3PkY3OOVLJOO9F1HXp3pIDkoH3+Sz
 l9k3j7JcYV+1FjJ/HxguHLmnMAP+iNoYys+jN2ItV2vDBM2LJ5TO4iiHP5deHhXIpKEXHLXU5
 THvy7oGTH+MbzQB02j6+4Ejky6GMxvu1kP1J4nUgvppdoWBfygxWuKAj3JqS8qohagoavNec6
 kEC5XhSv4yvJgM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sDjqsj/OIHo6mxie
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 05, 2022 at 01:13:00PM +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> On 5/2/22 01:52, Jonathan Neusch=C3=A4fer wrote:
> > In order that the end of a clk_div_table can be detected, it must be
> > terminated with a sentinel element (.div =3D 0).
> >=20
> > Fixes: 631c53478973d ("clk: Add CLPS711X clk driver")
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > ---
> >=20
> > v3:
> > - no changes
> >=20
> > v2:
> > - Add Fixes tag
> > ---
> >   drivers/clk/clk-clps711x.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/clk/clk-clps711x.c b/drivers/clk/clk-clps711x.c
> > index a2c6486ef1708..d96d96c8752c7 100644
> > --- a/drivers/clk/clk-clps711x.c
> > +++ b/drivers/clk/clk-clps711x.c
> > @@ -28,11 +28,13 @@ static const struct clk_div_table spi_div_table[] =
=3D {
> >   	{ .val =3D 1, .div =3D 8, },
> >   	{ .val =3D 2, .div =3D 2, },
> >   	{ .val =3D 3, .div =3D 1, },
> > +	{}
>=20
> Why not use the same style on all patches? Others developers looking
> at this code will directly grab this is a sentinel section, instead of
> wondering why this empty section is here.
>=20
>         { /* sentinel */ }

I found the {} style sufficient.
But ok, I'll go with { /* sentinel */ } now.

>=20
> Anyhow the patch logic is correct, so:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks!

Jonathan

--sDjqsj/OIHo6mxie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmH+do0ACgkQCDBEmo7z
X9tqjA/9G3JPcGCGdT9B6a/i2y21V8VUhCE780qumn74gsKoiPoiWBAJUVXstuxL
djQIS29uNvKJXnL1H7ioDV9mRdCEaKQQxW4oUMmNEHi+EnEQrQAZmKPLjm6qemOf
LHjUFU0yUKZxwYcIyXkTD2NricH27swc5p38FZrcdaaElSVNQmwjnZJfRv3QcMSJ
M9bBLYMiZBRT3iHakzelkjIj5Yi/VdVtiPM+563HjSoZh/vKsH1Nt5pbsrwgd0lX
qcF4CsDa8zh4kOjIRJftnWFh2Oz0JoKX2JsYa4H8UUBLHiGzD53LWaRaYAscEEHI
b2hjxgiSNXq7VV6fb0E5Fn7K8iVUXQdRh1sDei6I8FAScS0MbuPMY63wa4DXu3gb
RRbUTNTUEt4HSqIdTs++tr1kPWV4t+p2pfSyMXgVRDBxMyQlVRqppOElVgCPu5iT
FW7cKKC8FCsIc4MUGxqxqdOfKLFjgvzglb4hg3+yAoooaJzvxoajai/O2JmOdssD
FhawY/YVgOvku5GppeHEgsioQXqbpTKHln5nPVkoaUJOLPE/DzMcUGP5RylYjRS3
H7sk9lBigeTkOrTE8Ro3LpT7YcjjIGLKXpvnUn3Muq3s6SAhQDEZuYM7CX7p39Y/
2s6c6PtJRhEj5M5rCKB97bQ44DFG8DKbo+vInnbjre6gJFSzZa8=
=YqC+
-----END PGP SIGNATURE-----

--sDjqsj/OIHo6mxie--
