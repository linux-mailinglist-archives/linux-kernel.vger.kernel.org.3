Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748A848366B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiACRwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:52:30 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49542 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbiACRw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:52:28 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 384041F4258E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641232347;
        bh=RKPWW6WVTcvI+KVmsBT29XfDDBXyaIWr/TN8Y6paCbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QLAtpUxWoa4FO395frdN5TgX1T02DLQy3Uos2IH8dHRvsa4ifeQw/QQZAIy3EPq6u
         QkyUVLqDAJH5gqrytiZ92eAvn9qAPgXUd3cNdDE6UL/0Gp2eLGzYL9iPuhZleL2CS+
         clBBSbNZdTvqEnfNjjvp8YzMjk22ABHwpScNuCYqduG+ylpbUPPqUKnC9dKn+s2aX5
         x2VMJ0vO2ucIwEEiqBEuyMbM4911pQLvuyDEfIkLIswCxbuVqYv37cAQ5UifQFuDKk
         uGSqe+yYY+UE0V6+/+f9vGdMCBKlxntDuQ5PBOVRLctzUUoIBCIQsd9O6Qnqg9v2Y2
         mPOydwSBH+ZuA==
Received: by earth.universe (Postfix, from userid 1000)
        id 1E7233C0CB7; Mon,  3 Jan 2022 18:52:25 +0100 (CET)
Date:   Mon, 3 Jan 2022 18:52:25 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jack Wu <wjack@google.com>
Cc:     kernel-team@android.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] power: supply: add dock type
Message-ID: <20220103175225.2w37ey76lhmqshap@earth.universe>
References: <20211215033410.4113857-1-wjack@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uwy2ongk2e4bu3cu"
Content-Disposition: inline
In-Reply-To: <20211215033410.4113857-1-wjack@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uwy2ongk2e4bu3cu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 15, 2021 at 11:34:09AM +0800, Jack Wu wrote:
> Add dock power_supply_type for the drivers which supports dock can
> register a power supply class device with POWER_SUPPLY_TYPE_DOCK.
>=20
> Signed-off-by: Jack Wu <wjack@google.com>
> ---

This is missing updates to Documentation and a driver using this
feature.

-- Sebastian

>  drivers/power/supply/power_supply_sysfs.c | 1 +
>  include/linux/power_supply.h              | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index c3d7cbcd4fad..53494b56bbb4 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -57,6 +57,7 @@ static const char * const POWER_SUPPLY_TYPE_TEXT[] =3D {
>  	[POWER_SUPPLY_TYPE_USB_PD_DRP]		=3D "USB_PD_DRP",
>  	[POWER_SUPPLY_TYPE_APPLE_BRICK_ID]	=3D "BrickID",
>  	[POWER_SUPPLY_TYPE_WIRELESS]		=3D "Wireless",
> +	[POWER_SUPPLY_TYPE_DOCK]		=3D "Dock",
>  };
> =20
>  static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] =3D {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 9ca1f120a211..fa80eaa54242 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -187,6 +187,7 @@ enum power_supply_type {
>  	POWER_SUPPLY_TYPE_USB_PD_DRP,		/* PD Dual Role Port */
>  	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
>  	POWER_SUPPLY_TYPE_WIRELESS,		/* Wireless */
> +	POWER_SUPPLY_TYPE_DOCK,			/* Dock Charging */
>  };
> =20
>  enum power_supply_usb_type {
> --=20
> 2.34.1.173.g76aa8bc2d0-goog
>=20

--uwy2ongk2e4bu3cu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmHTN9gACgkQ2O7X88g7
+pocMg//ZjofQpr2IjppKSf1Sz3m9h4cZCM1UIS3kn5SoCaeSzMf1Y7ceHBDPd06
1sU11n7oowRu72yyenVJwKIFu6MRkoKNaQr7E7HcOlyWiqjd9VG/8z0MsoX1Pr5z
wZ9uZvKrEkkez2eLQpeQp3q8uSQctwC3Hm1IxBUL11FmoOHtaCf37QSh4TUZSAIO
EPejyy7VfS+nPISHzNPqrRm1IKEArKJCBZUeNqgFA/n4uWOra5mCxcmkCcIXF/ck
tO9N4OgFVFhYjGJ91Ncq42pTowojLiLOl1THHj79TrQxSkW+2VSlss9g1NphSvjf
duwNOjJ2Y0OS+CdjAdyScnGuaJcNInDY/q4zkr4PK0xiGeRbF12NM0GXJm1M+lUY
zPOOuB10udxC/bwBTa4gaUZK3KGbw8pg3Ru9n5hLGfipcZEw98DijAKlHbcm1QXd
CPRCyJZbjo3Z2BugA/7wisS6izcKT0cNhN7V05B32afoSzAwePB3xQC4OgmAcAQ6
X7iqjstz8x4uREbUd2cxtAjaiVmHDLBPLWc65aWZaBX5YKu1CZ3DpsWU6Ts7BlV4
3IZDU9VTqgX5cbRWyIQZRj6hJTfHQocsrH+hPGir/NgFb9Qbm8lFb+8hPuowvhFl
rVASqPyxDEGvl2FVt++fKDUfiX+jaoeiT/i8AUZ041hQVNW/DhY=
=xdwQ
-----END PGP SIGNATURE-----

--uwy2ongk2e4bu3cu--
