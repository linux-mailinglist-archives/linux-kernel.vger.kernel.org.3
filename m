Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1115545713
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 00:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345566AbiFIWSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 18:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiFIWR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:17:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13191CC1;
        Thu,  9 Jun 2022 15:17:54 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 846836601752;
        Thu,  9 Jun 2022 23:17:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654813073;
        bh=MDbdaDhtE3Q+wc17/NHVK22+YjezJBLMU2iTMKmf188=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RFBQ7SbMoeV0jgvXumEArTw8ahybc5BKeUgwJmN5A41Q65wEhOc6+jbewnEnRJhin
         xeSkLxzN7z5ef95PXfxXFMhyQ0qbAa3Q7a0nJCiqf/U5stDRToFJaqTZsecSgX6sGe
         0OhBTPIXHcb2raI7tfU5nrmQ3piSrq9guDcikE9suMJ3SYdo/yOkftqtguOj38kyxX
         K5ouKuhIjpj/6Rp4FZ4ef3ysT+4XEA7rM/SfkkXyDGAOjwvFkbygOfEKwuSsw46Sfa
         /H17V88uI6cpjOhasQhdvBYv4+zvIHkKQGHmkiwxI1L/5rwTvGci180DG+xhN54Oij
         D3vpJj6Ztf6gA==
Received: by mercury (Postfix, from userid 1000)
        id A8A0010605B9; Fri, 10 Jun 2022 00:17:51 +0200 (CEST)
Date:   Fri, 10 Jun 2022 00:17:51 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@google.com,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
Subject: Re: [RESEND 2/2] power_supply: Use of-thermal cdev registration API
Message-ID: <20220609221751.wjgazwamzodejfxt@mercury.elektranox.org>
References: <20220531183054.6476-1-quic_manafm@quicinc.com>
 <20220531183054.6476-2-quic_manafm@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="koppcha23r66m7mj"
Content-Disposition: inline
In-Reply-To: <20220531183054.6476-2-quic_manafm@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--koppcha23r66m7mj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 01, 2022 at 12:00:54AM +0530, Manaf Meethalavalappu Pallikunhi =
wrote:
> With thermal frameworks of-thermal interface, thermal zone parameters can
> be defined in devicetree. This includes cooling device mitigation levels
> for a thermal zone. To take advantage of this, cooling device should use
> the thermal_of_cooling_device_register API to register a cooling device.
>=20
> Use thermal_of_cooling_device_register API to register the power supply
> cooling device. This enables power supply cooling device be included in t=
he
> thermal zone parameter in devicetree.
>=20
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> ---
>
>  drivers/power/supply/power_supply_core.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 74623c4977db..4593450920a4 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1157,9 +1157,15 @@ static int psy_register_cooler(struct power_supply=
 *psy)
>  	for (i =3D 0; i < psy->desc->num_properties; i++) {
>  		if (psy->desc->properties[i] =3D=3D
>  				POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT) {
> -			psy->tcd =3D thermal_cooling_device_register(
> -							(char *)psy->desc->name,
> -							psy, &psy_tcd_ops);
> +			if (psy->dev.parent)
> +				psy->tcd =3D thermal_of_cooling_device_register(
> +						dev_of_node(psy->dev.parent),
> +						(char *)psy->desc->name,
> +						psy, &psy_tcd_ops);

if (psy->of_node)
    psy->tcd =3D thermal_of_cooling_device_register(psy->of_node, ...);
else
    psy->tcd =3D thermal_cooling_device_register(...);

--- Sebastian

> +			else
> +				psy->tcd =3D thermal_cooling_device_register(
> +						(char *)psy->desc->name,
> +						psy, &psy_tcd_ops);
>  			return PTR_ERR_OR_ZERO(psy->tcd);
>  		}
>  	}

--koppcha23r66m7mj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKicY8ACgkQ2O7X88g7
+ppnJA/+KPGz3XV7XmAFhZKzeHyCLLToNsB3415VF1viueQ8uXD1lgE3KDXhBPiY
H1TC4phj8lzNDNJekbH03bZB61P/9pMco/fmKXsqFeumL2Ubtl1FOqEoutRUeUff
yjGD+X/pV+dvfelv/6S1Fo6QcHoLfrVMw0vMn9FYlS/ijh1C8mYVrLY1EMMrI7sT
i4pZ6SRODWogwqKogRQhcOg/odOzHOlD01N+rtas06+IRNmuv8ijAYp0ZVbw0AH6
MjD+hOVi6se7s+7l5vo1ZBhlVn+P/m1pKUaGkmdykZr62w40qClyapX3ojtSB6jZ
bkG7MkSWDtB5M96/pw+MZR49J+zlkXwN7Vou4pMmG9EKm7QaYKSGRo4cEH+3fzil
TXB6IrXnDYI42+9rTLYW/+cU9/eRYJYzUzDadehTRvXhk3T7vCF6Im35FoFPcznd
RoDAip5VbkFVUHxGr9dO6ggvMiEZcO/qD0NWpujAWmkzzMvZw1qdMjq/od/FHjwf
73sColCqzJJPw2CJVUBPn01uci0Df67SwYs5jNjg1Ug9UCstRGrx/keVoMUFduPm
tsR2pOW7oRkXvlyoxBx6ENO7nJP2mBALs4sdRSHX3qxCALqxJproAWX3NVi3x5hz
n1x/PjaGc5rzTq9UflK0t5963VJGOcJ3Zcy69AMPQoqv2JJZz08=
=J1bd
-----END PGP SIGNATURE-----

--koppcha23r66m7mj--
