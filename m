Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7AE4B2D2D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbiBKS4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:56:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbiBKS4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:56:00 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE15CE7;
        Fri, 11 Feb 2022 10:55:58 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 666B31F472A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644605757;
        bh=hM+hHJr3fdj9ugZG7+HFqqYSdy/q300W7FFxTpyKpE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aPPNH7qe2vJG9RZeM86qZQ5kgn4hE971Pvtjzw54qP70tfIiuyszMhyhvUS0dTG2e
         V5jsnUNA70ovr6ZE/d+gXfSt6dHeALAClNsplZd7dzG+JX4dsY8rFhlUHEyummJZ7T
         2g7KhTu/aSvAwIEnsZdu61RpdGHCOzu5wTyJbIpSNjcNq+EbC3Rtw2HMcmW+N88k7O
         8JI+kocWzWsOD6G12jWSp7CrnZTBICgGl2aHNc2ntL/+uwJKlF4h+0uPFCaN9gAt5Z
         csp24ubq0M7Qm0CQV56eDD9XgjWfN0W847TULQ4hHMScu7Yo4IWrxgrnwKJThObWx6
         AznsjwCyvDPKw==
Received: by mercury (Postfix, from userid 1000)
        id 867991060908; Fri, 11 Feb 2022 19:55:54 +0100 (CET)
Date:   Fri, 11 Feb 2022 19:55:54 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] power: supply: core: Use
 device_property_string_array_count()
Message-ID: <20220211185554.mof2hd3lwo2dcddw@mercury.elektranox.org>
References: <20220202182325.54680-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="32wvy5chmbq6tonm"
Content-Disposition: inline
In-Reply-To: <20220202182325.54680-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--32wvy5chmbq6tonm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 02, 2022 at 08:23:25PM +0200, Andy Shevchenko wrote:
> Use device_property_string_array_count() to get number of strings
> in a string array property.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index df4471e50d33..fb638774577e 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -283,8 +283,7 @@ static int power_supply_check_supplies(struct power_s=
upply *psy)
>  	if (!psy->dev.parent)
>  		return 0;
> =20
> -	nval =3D device_property_read_string_array(psy->dev.parent,
> -						 "supplied-from", NULL, 0);
> +	nval =3D device_property_string_array_count(psy->dev.parent, "supplied-=
=66rom");
>  	if (nval <=3D 0)
>  		return 0;
> =20
> --=20
> 2.34.1
>=20

--32wvy5chmbq6tonm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIGsToACgkQ2O7X88g7
+potDRAAhkl4IuH3tT8fYlKoSIbAldZn9kN4YbRnHevH59BAcF8Mmy3lHqO/UfVY
k0bREZVC8lHogWdfh6wXn0T9N7bgTUe4m0wtjWT5OyI5Ff1HgV94gg/J2EF5WphK
KYOdVs6VvR4GLYPT8unPdNL8Do74nug8O/Im/7wuU9YD/sBICN/pDuNOOOpjxklL
8qicpNxfvdVjkP1fVaHPcAV4HxRRtlgZayvnxhvYSz9nUKxgErABvD1EAoR7yqKe
+AXYnKN6I6pt7cov6+DiJeUgX2ZuQ2/HbtvSfS1aVwA2/QHghiTU5HCjM4h2IR9j
ID447BVd+dmmGGBNbZYFBj15wirswps2fKOHmaHEoDuIt6QCyXwSAJbeqKOm+kJA
z8FYfRBMaR4VM7/tGhQNki40ZPVrtPqVhiOySqqDO17QJhCUdie44xCBwabAjnw8
7jxHHObPHlOP2PeHGPQTCqjDNpUL7ukCGY3oS9l0hAr0oUKLP1ApcW+LM4itVHZI
dvgVo0Pj3UsSEW+QrEki/rI9dpqxr9tDp3lTiexQv0lzepT+zvK5qtyBiMwzm8QM
GzpsrgA13DVLsl0Sgf2sgfTX4iz59wl6+PdQuKYgEdttt/4Uge1T+i244d9hi9IG
uEEWiN1UD6UoxWXb+kb1qSB1M4TFabFaojKNihPx2Q/CaOY7w4s=
=ogf0
-----END PGP SIGNATURE-----

--32wvy5chmbq6tonm--
