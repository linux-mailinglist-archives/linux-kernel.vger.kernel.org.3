Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E99467F5F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353990AbhLCVge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:36:34 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32924 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhLCVgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:36:33 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 15B4B1F473C5
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638567188; bh=TWfhDoZ7T3kxFpcrRg2+1+vWc0efe2B9az0y9QpaEWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k1ThvJqbs8oj2qIPoCfZCCR6/TF/KqH+SPdgv4FIk7+3DcQuZ7x8VygZ5Wh44hvLh
         PLR92hwRlCfSjCPtlUAkvH3DVvROoS6Twts5N+WlaqbsVdIS4VgJPG6+BktRQ8Cf15
         bG8DSQ2TWplsPe+yhiVhRPZUrazDw6ZQKAmh4M8uXdTwZq/ijBR7I8IQJH8FBkEQic
         67sibRlvpNBUPefzDiq+nj+es0KL7Sxfs7Gjynctnh1YlOIeHUjQ3p5K9fyYNdxmtz
         0hUtAXh8EDefU6MpGF5DXAiKwysS1SQ2ytoS/Tdz35barzKs3eC5IAykTCMycopAd2
         H2SBQH5oznvCQ==
Received: by earth.universe (Postfix, from userid 1000)
        id AA1843C0CA8; Fri,  3 Dec 2021 22:33:05 +0100 (CET)
Date:   Fri, 3 Dec 2021 22:33:05 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-pm@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        linux-kernel@vger.kernel.org, linrunner@gmx.net, bberg@redhat.com,
        hadess@hadess.net, markpearson@lenovo.com,
        nicolopiazzalunga@gmail.com, njoshi1@lenovo.com, smclt30p@gmail.com
Subject: Re: [PATCH 0/4] power: supply: add charge_behaviour property
 (force-discharge, inhibit-charge)
Message-ID: <20211203213305.dfjedjj3b25ftj2z@earth.universe>
References: <20211123232704.25394-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j3n753rkkc5fqnaj"
Content-Disposition: inline
In-Reply-To: <20211123232704.25394-1-linux@weissschuh.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j3n753rkkc5fqnaj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 24, 2021 at 12:27:00AM +0100, Thomas Wei=DFschuh wrote:
> This series adds support for the charge_behaviour property to the power
> subsystem and thinkpad_acpi driver.
>=20
> As thinkpad_acpi has to use the 'struct power_supply' created by the gene=
ric
> ACPI driver it has to rely on custom sysfs attributes instead of proper
> power_supply properties to implement this property.
>=20
> Patch 1: Adds the power_supply documentation and basic public API
> Patch 2: Adds helpers to power_supply core to help drivers implement the
>   charge_behaviour attribute
> Patch 3: Adds support for force-discharge to thinkpad_acpi.
> Patch 4: Adds support for inhibit-discharge to thinkpad_acpi.
>=20
> Patch 3 and 4 are largely taken from other patches and adapted to the new=
 API.
> (Links are in the patch trailer)
>=20
> Ognjen Galic:
>=20
> Your S-o-b is on the original inhibit_charge and force_discharge patches.
> I would like to add you as Co-developed-by but to do that it will also re=
quire
> your S-o-b. Could you give your sign-offs for the new patches, so you can=
 be
> properly attributed?
>=20
> Sebastian Reichel:
>=20
> Currently the series does not actually support the property as a proper
> powersupply property handled fully by power_supply_sysfs.c because there =
would
> be no user for this property.

I'm not too happy how the acpi-battery hooks work, but that's not
your fault and this patchset does not really make the situation
worse. So:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> Previous discussions about the API:
>=20
> https://lore.kernel.org/platform-driver-x86/20211108192852.357473-1-linux=
@weissschuh.net/
> https://lore.kernel.org/platform-driver-x86/21569a89-8303-8573-05fb-c2fec=
29983d1@gmail.com/
>=20
> v1: https://lore.kernel.org/lkml/20211113104225.141333-1-linux@weissschuh=
=2Enet/
> v1 -> v2:
>=20
> * Use sysfs_emit-APIs instead of plain sprintf
> * More cecks for actual feature availability
> * Validation of the written values
> * Read inhibit-charge via BICG instead of PSSG (peak shift state)
> * Don't mangle error numbers in charge_behaviour_store()
>=20
> Open points:
>=20
> Thomas Koch has observed that on a T450s with two batteries
> inhibit-charge on BAT0 will affect both batteries and for BAT1 it is igno=
red
> entirely, this seems to be a bug in the EC.
> On my T460s with two batteries it works correctly.
>=20
> Thomas Wei=DFschuh (4):
>   power: supply: add charge_behaviour attributes
>   power: supply: add helpers for charge_behaviour sysfs
>   platform/x86: thinkpad_acpi: support force-discharge
>   platform/x86: thinkpad_acpi: support inhibit-charge
>=20
>  Documentation/ABI/testing/sysfs-class-power |  14 ++
>  drivers/platform/x86/thinkpad_acpi.c        | 191 +++++++++++++++++++-
>  drivers/power/supply/power_supply_sysfs.c   |  51 ++++++
>  include/linux/power_supply.h                |  16 ++
>  4 files changed, 268 insertions(+), 4 deletions(-)
>=20
>=20
> base-commit: 66f4beaa6c1d28161f534471484b2daa2de1dce0
> --=20
> 2.34.0
>=20

--j3n753rkkc5fqnaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGqjQ4ACgkQ2O7X88g7
+pr7EQ//TwLf4PlRgra/IFkj+OYy3nFZzj7g3Wd/FaZBjGY9y6YCMddso8OTFKjU
DgHHqZnfIxNdRYN0cGRTAc1Z0f3l01S+9PIN6AdLDAuCgOWwCYD8qev//O4YOY7P
kg940EozI+PXog5yDFMB1Ig96tezWUG6ze3Ayga0BQ7ZtuheKAVyqvj6t2UUxGO4
147ZLMko5+02pcPCnHRifikGkP840ramtjJCL19mqsxYUg/VWwphkxsrjUV0hvEl
Fnrs1yKMcrp59GKCLK2gKdyTEdIlEKh93mkFzYw9xbnNUfFNQ09x8qmL9Z44GKqG
5tmva2v4Adrr82xogDq576xP3nwj6UfxTWP5C4FASnHfD2OV9FYeUKgT49/jXy+L
mniHt9FpeTMrBr+wtEJdpIaBT6uskuXkz7uUAV2eI+zPG6zCLq0Y8vd6FJzisxlI
GV09P7UE52CsT6uHjKjCwhXJhWD+FuFXtS5xx7i+S/baYcTITrrObizoSjEyd4iT
dau4mrLseASWD4gGLIzJYHRADYHkCZzVgxh1w+68kLQxdTd++/6ML9LcQ8hIWcif
Gp354YHKfYV2CIuOcei/DtftRksHG2Ljry+gRAanzvgHKOalOoj9o3UtRj6btDbY
GzWnoJkklOTe7GwGN0SEWE6QkVQz1mj4K9lpNNnZN10XcjloSpA=
=2DMK
-----END PGP SIGNATURE-----

--j3n753rkkc5fqnaj--
