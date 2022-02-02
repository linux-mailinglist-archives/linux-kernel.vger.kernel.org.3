Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273924A7881
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 20:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346869AbiBBTGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 14:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiBBTGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:06:16 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B6BC061714;
        Wed,  2 Feb 2022 11:06:15 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5B8D51F44A86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643828774;
        bh=pnJYMQnocKqaSHZAoESmT/s7AHzQaVIvJvrK5HrPS/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JXsqG06L0GERFcYx0wT7nGX4frg3b9BU//3O9afKJ8obSUNUviwXFg0uXnnmfRt4H
         hodhvSttk7TRnHAaxxpbbMYSTUnzOgsUzPvcJurMEMgMs9X0z1JGx8/xjjFz+8Arui
         srhmWsl0NPUUwHxnJ3/rPFCLXmrKHGZ0p83VJQkOJLhB/odm9Mx6GJ/ESVGocpodYM
         e2eMB4a2oNQu5DuAOhKNz+umPcemFdCOgy+nmjpCVK7Tdv/kLVfVDk/TFJS3z4iJpQ
         VYm2tQYhPrPkhL8/VpJPyiTcoNarHfjEFRPDuentW9kC9gXP1PXlAZWZi5inqCuBBs
         31vWPMdb40vpQ==
Received: by earth.universe (Postfix, from userid 1000)
        id F1AC03C0CCE; Wed,  2 Feb 2022 20:06:11 +0100 (CET)
Date:   Wed, 2 Feb 2022 20:06:11 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] power: supply: axp288_fuel_gauge: Fix spelling
 mistake "resisitor" -> "resistor"
Message-ID: <20220202190611.wfzp3qacb2dyds74@earth.universe>
References: <20220202091246.580091-1-colin.i.king@gmail.com>
 <8386b5bf-46bd-5927-9119-cdf77e1df082@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lecfetpmufqm7vqu"
Content-Disposition: inline
In-Reply-To: <8386b5bf-46bd-5927-9119-cdf77e1df082@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lecfetpmufqm7vqu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 02, 2022 at 01:45:55PM +0100, Hans de Goede wrote:
> Hi,
>=20
> On 2/2/22 10:12, Colin Ian King wrote:
> > There is a spelling mistake in a MODULE_PARM_DESC description. Fix it.
> >=20
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>=20
> Oops my bad, patch looks good to me:
>=20
> Acked-by: Hans de Goede <hdegoede@redhat.com>
>=20
> Regards,
>=20
> Hans

Thanks, queued.

-- Sebastian

>=20
> > ---
> >  drivers/power/supply/axp288_fuel_gauge.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/s=
upply/axp288_fuel_gauge.c
> > index dcedbc59732d..13be2c1d6528 100644
> > --- a/drivers/power/supply/axp288_fuel_gauge.c
> > +++ b/drivers/power/supply/axp288_fuel_gauge.c
> > @@ -91,7 +91,7 @@
> > =20
> >  static bool no_current_sense_res;
> >  module_param(no_current_sense_res, bool, 0444);
> > -MODULE_PARM_DESC(no_current_sense_res, "No (or broken) current sense r=
esisitor");
> > +MODULE_PARM_DESC(no_current_sense_res, "No (or broken) current sense r=
esistor");
> > =20
> >  enum {
> >  	QWBTU_IRQ =3D 0,
> >=20
>=20

--lecfetpmufqm7vqu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmH61h0ACgkQ2O7X88g7
+ppnhw/8CA8ZHeI3ic57A52w676LcT3Ds58ZkauZtkb848URRS9a/k+HGmvYtrHz
YHQa6HGb8YAYNjYSTv+KcbJ+insT02uKxGf2aiAUnVD6ImgsH3oKIvCMZU7m2YqC
fMh7fIadn9fB5ReR8+Lj/h/zdi8kbSFeRh8QPv/qwUXeeP29c5L0SYdUiAHwqnvy
kRu4jexscqod5LUQ3BZwe9kIAWD1Hq2Z5p8gqbtgCcYVRxriuoIs0WqIqRGfOxfw
kf6ifzYLF96NQZdKZtO3TKt3s1BJP/i4RtExFvshQ3I3mkzXm+uPppMDTgjLcjzg
6noghaPWWdNqECfbiUYxwFIAZKRt5U9K1/uUcihjf8J/zU1ALfm9KxolFiG0r5iR
REW44VP7TZELJZpAbDX6jJuZ/Jr93GIhynogzeF13SVrPdMDwqj5VMaYtGmVri/K
bpfG9mtCkfHfG59PejCPeO76r5PD0XdthjpoxcS9H1u3c+tvSKZdcW9Ye9E21o/F
99ZbVMQxtGnpxvFmp+wEJgh2Mj/4IGMKZFFKbHPmf1FaFArXz5M6+n2Ahq2j0DnY
3edmJ1UaEzFyJb3z02imf+Ed4/MG5Fz2VdoGQ4nV7NMkqRilHJH/mqF6MvmkAfsk
9CS9asAKEES0u6tzIgItLEPUlSHj/VmZDmTOUsK7yki3fzxZZZM=
=5VWk
-----END PGP SIGNATURE-----

--lecfetpmufqm7vqu--
