Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E155019B0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243317AbiDNRMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245126AbiDNRL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:11:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B91D0AA9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649955749;
        bh=LdyEq5qQROjPgWrNLXz9QEVAlXZK6Rma+QSMxozyawk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=FvISkBNWW3DJf8aHMuo2J3eF/uD7DdxRmMGn2MZo4sYn71WGM07DkA0Y71TlBYzR4
         cfpvBFOBO50PnO4k7JkA+Ie8sY94RdqLtQRseZXNsMeHMKeSNTS9pmtjkFe/VQ2w2F
         IzTzHAE4VDuWDx3NJzHdzEs72A6rf18moxhhqjPo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MlNp7-1oMOt62NtF-00lkAg; Thu, 14
 Apr 2022 19:02:29 +0200
Date:   Thu, 14 Apr 2022 19:02:27 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        openbmc@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2] soc: nuvoton: Add SoC info driver for WPCM450
Message-ID: <YlhTo+F0p7ggPAQb@latitude>
References: <20220409173319.2491196-1-j.neuschaefer@gmx.net>
 <67f42821-34ad-cee6-98fb-7086599c4c0f@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CriTeMWGrgldN1YF"
Content-Disposition: inline
In-Reply-To: <67f42821-34ad-cee6-98fb-7086599c4c0f@molgen.mpg.de>
X-Provags-ID: V03:K1:HleZRsYeRGlcyquio1uGh5BtUVQnRZObaESvNLFrTwpkwguPN5z
 jN3UhDqho6+2397VcnM1Jy8c0wFvDjgrpmgq7PXMT/hjw4deakdViknMaI0eLkfGtxtWtv1
 mYkoi+KOGd6wg55D5GziaKWhFYQ9SVNDEmz/higaX0f7vWCb0ehTs+NOVXMqu0fez61xcds
 CVEzimHLQhZfVsDUE0BxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dACZIqHKJrI=:SgpM1icXExh1Ai3XjT47/+
 VdErA6zZJuGu/fXRKtdHFy+iIM3uxeW7i4B2cdRghb/VpoItiG4CRNRw3lpkdCJa725pt7VKB
 K5iGvrwS2OL47KsvP4eeD8/TuSlzbHJzJrJGprHfkSiRfCAKmQ+/Pj2zopnE358RC5OJdGpJ4
 fMZCG0AD3uHwHxD9PUwZrEC0hq2I+ttoo1FA4c92YlZ5GKNIhc2mlY9cvoQcNYglCDBFimG6y
 1emSiMJhiBZ4OA0V5M5wK1AUOswPr969ruIQED4lqqcmNPp9tDgjCGVkG/2TglP0rKmXQKVUV
 8hMxt4Gm2hubbW2juWFls4aJhrOlU3EoLLC8NS/TfQ664PZUJFTuTR0QF59p/5G2TI1ld/XFd
 n7a2iUikIv9rJmW0cV+9IMUIs+KJB5YX0WWjVWOjJOQVTP/00VebXbSgy3dFWX8n+h8JfWVsA
 4evtvIF/iboCDj5eggsDwhx/mF0T6RCRfGvsCo/nJ5/UqeMaUBsChlBEb+XlALTe9uv2jvFs4
 7oob+1RJnQ8rfTri2eM2UB9F8Pf5RH8XSPAxYPjzClvENueJmhq/OpnBeROz3e0Vsk6AWkNMb
 U95s6XBVPiL2Szo/042ICDz0K73KuuERMmxq+D64bRYKkpgmmhJNJkfVloCFskYp1ViuUFfQV
 aen7F6I/GxwO7O2u9lo9VpStZmw7aaYrkj+sySQ14oHPo4umYsi5wuVobAp/3fO7mCRwmELCI
 qwh6W8v+6+2REJ1NyeUkFIM/GDhF4dh+qaKRxzQ68nkSIpggPqMFHlLqvZk6ar15u4uGnuCa2
 pud1c/FLx8S52Y6WzIO5xhMo7sS82AGwDjbJvAe4F6YghXFohxwttPYz+3vYrwerEBXQrf9Qd
 DiRBInrkkhuw9Fa4d0WMWzldGgdIWJb71DMlzMxBrZsp23skFQOUhaSt32TrvBSuUcJ1sKtUR
 Vvpgds1CGD8HmTWYkOloKMqVRFtrSR0KxsGPjiN14pNC0Xzo96zdtmUiKZb/EQtQJgiSNGZsX
 YuxhzTcKSVMux4bogWWcs86xW27ewD6Kcf2+4/7HEf5bRlThNGGiJUlcMoH/cu8O9W43MTAv3
 Go8Im7cGbJWehM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CriTeMWGrgldN1YF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 09, 2022 at 07:55:09PM +0200, Paul Menzel wrote:
> Dear Jonathan,
>=20
>=20
> Thank you for your patch.
>=20
> Am 09.04.22 um 19:33 schrieb Jonathan Neusch=C3=A4fer:
> > Add a SoC information driver for Nuvoton WPCM450 SoCs. It provides
> > information such as the SoC revision.
>=20
> Maybe add an example command, how to read the model and revision.

Will do.


>=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > ---
[...]
> > +#define GCR_PDID	0
> > +#define PDID_CHIP(x)	((x) & 0x00ffffff)
> > +#define CHIP_WPCM450	0x926450
> > +#define PDID_REV(x)	((x) >> 24)
> > +
> > +struct revision {
> > +	u8 number;
>=20
> Can this be just be `unsigned int`s

It could be, but it's unnecessary because I'm dealing with a 8-bit value
here.

The same amount of space is used in the struct whether I declare the
value as unsigned int or as u8, but with u8 it's clearer that it's
really (always) just an 8-bit value.

>=20
> > +	const char *name;
> > +};
> > +
> > +const struct revision revisions[] __initconst =3D {

Unrelated to your comments, I noticed that this table can and should be
declared static.

> > +	{ 0x00, "Z1" },
> > +	{ 0x03, "Z2" },
> > +	{ 0x04, "Z21" },
> > +	{ 0x08, "A1" },
> > +	{ 0x09, "A2" },
> > +	{ 0x0a, "A3" },
> > +	{}
> > +};
> > +
> > +static const char * __init get_revision(u8 rev)
> > +{
> > +	int i;
>=20
> I=E2=80=99d do `unsigned int`, though it does not make a difference in th=
e end
> result.

To avoid unexpected silent truncation that sort of makes sense.
>=20
> > +
> > +	for (i =3D 0; revisions[i].name; i++)
> > +		if (revisions[i].number =3D=3D rev)
> > +			return revisions[i].name;
> > +	return NULL;
> > +}
> > +
> > +static int __init wpcm450_soc_init(void)
> > +{
[...]
> > +
> > +	revision =3D get_revision(PDID_REV(pdid));
>=20
> The signature of `get_revision()` is u8, but you pass u32, if I am not
> mistaken.

The truncation to u8 is fine in this case, because PDID_REV extracts an
8 bit value and the upper 24 bits of the result of PDID_REV are thus
always already zero.

>=20
> > +	if (!revision) {
> > +		pr_warn("Unknown chip revision in GCR.PDID: 0x%02x\n", PDID_REV(pdid=
));
> > +		return -ENODEV;
> > +	}
[...]
> >=20
>=20
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thank you!

Jonathan

--CriTeMWGrgldN1YF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmJYU0QACgkQCDBEmo7z
X9siGxAAvy8O9oAp5j51Gf3zhjCJBG4fN/W3gS2M4SIQBgXCgR0n6VLOoXd6XI4V
dR5JOAQece9dMiQvA9X4ByFa/zKM6JL1N9Y2u8WGQoe6ayAWQHhy21+uQ2pABLT9
O7/7u8qmbrwW2Oi1egpE5Ezym1i211OzjU0R3LhbHlNg5Iuu7BecR6+akuHOjq18
CcOpPKgYxRrPBISqMmIJBrbo1DVJclBJ5OGrGY+5d5tt3st1dgy3EvOqglj1d1Sm
QIya1Sx6oCADjuVoUtGpImjF/Xm3NVGnQMu2FXpHkBd5Z++2gaO7RtaHffXyRd7h
mtfo8NXvuCVfW1mkTSqkV6/EIwOEeRIJiCAbEq1tnxr5NpWjum0hk7cJKJHhkNZ8
p5apPXVSUpTdU4bmVHwlbMGrhpIfYz5AQIE5Ec8naNiWuLYpUQZRo1F4y8BCZ69G
geB/n/Od7/NIiIdLOzban1dhbHrVUtfGKUE8/LxpKPxzBVtNMiFB1Fz4FSF23vAV
9cwZ3Em8pl2C5sy6nfhWg1WGmalUBTvoK4gmy1Lxudd7DbdkRNa9Bryo4VZ7wgjP
27ug9qFBu4EKUmbGzRczBj73vdsqAKrm6J7saSwqYmxxEDCqQ4KCsm3w0KWKD3k6
uCd0rQ1fJsdjZu1dVjhCgqa4X3RVmVdDWvxU6BDO4suZwShkNKM=
=qLqA
-----END PGP SIGNATURE-----

--CriTeMWGrgldN1YF--
