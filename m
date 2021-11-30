Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C004631C6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236929AbhK3LG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:06:57 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51900 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbhK3LG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:06:56 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 58B1A1F44BD9
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638270216; bh=ZCcAJm8XMTByN8/s2WCB4XZxCSS3MKuWYhisPzrM2CI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jD5LhWuHDWI7252zmLEAakU/zbisVktPIU6kqg/dz7Pp2fdaeR6MJhYG885EPIIz3
         GE/Ffto9bBL62uX83laQmUotIQiBJ6d4MLQy+Zf74/SBsTdaE5qn5eAis9Q0gKMWwt
         VUPzrTazexBGWkRa2qvm7MpYzd0NYXKr74IHb9eGiCIZE/te0AkG42TM8Rk31AO66J
         OXq9Z6aKGzP4Qbg12yBbtvGqT5FVp8EQnRAJrtu021pyHQOoRNoihvu82veyx06WaP
         w39PEcrsjUuT7B8MeFn7AWHhX7BGwApNBegpID4NO/LPtK+avSWdXonpEqJOnjzK24
         rE4+eKoapA10g==
Received: by earth.universe (Postfix, from userid 1000)
        id 985443C0CA8; Tue, 30 Nov 2021 12:03:34 +0100 (CET)
Date:   Tue, 30 Nov 2021 12:03:34 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] power: supply: qcom_smbb: support pm8226
Message-ID: <20211130110334.egzcne2l7mgmqjfg@earth.universe>
References: <20211118210210.160895-1-luca@z3ntu.xyz>
 <20211118210210.160895-2-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4bgpwtsgwzqugjwz"
Content-Disposition: inline
In-Reply-To: <20211118210210.160895-2-luca@z3ntu.xyz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4bgpwtsgwzqugjwz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 18, 2021 at 10:02:05PM +0100, Luca Weiss wrote:
> PM8226 (used in MSM8226) has v1 smbb hardware and works fine with the
> current driver.
>=20
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/qcom_smbb.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/qcom_smbb.c b/drivers/power/supply/qcom=
_smbb.c
> index 84cc9fba029d..bd50124eef9f 100644
> --- a/drivers/power/supply/qcom_smbb.c
> +++ b/drivers/power/supply/qcom_smbb.c
> @@ -863,8 +863,8 @@ static int smbb_charger_probe(struct platform_device =
*pdev)
>  	}
> =20
>  	chg->revision +=3D 1;
> -	if (chg->revision !=3D 2 && chg->revision !=3D 3) {
> -		dev_err(&pdev->dev, "v1 hardware not supported\n");
> +	if (chg->revision !=3D 1 && chg->revision !=3D 2 && chg->revision !=3D =
3) {
> +		dev_err(&pdev->dev, "v%d hardware not supported\n", chg->revision);
>  		return -ENODEV;
>  	}
>  	dev_info(&pdev->dev, "Initializing SMBB rev %u", chg->revision);
> @@ -1012,6 +1012,7 @@ static int smbb_charger_remove(struct platform_devi=
ce *pdev)
>  }
> =20
>  static const struct of_device_id smbb_charger_id_table[] =3D {
> +	{ .compatible =3D "qcom,pm8226-charger" },
>  	{ .compatible =3D "qcom,pm8941-charger" },
>  	{ }
>  };
> --=20
> 2.34.0
>=20

--4bgpwtsgwzqugjwz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGmBQYACgkQ2O7X88g7
+ppn1A/9GOI9SeAReTku+iJlF65N2VycqAlNWdy4zCDMpjs4Vet1y6qbHfJXWbrW
bnS/xrj2zClX8bp2vOlkhR8u5qX+YMjpHtFl+QITk9/D/cWcN42VviQqm9sq6YMa
bQ+NoyygoRAOAbL25dJlv+hZVTke3Kmc4g2F1ULWQ4gvMbnAEzUx8bXCD8o2amLk
86vwmcGVKsIvKujrx/luu8dr8Y8/UHnSaGVULYVCX4N7wJkDsKMp6nfkYYmoyYxU
X0YfJ8839IZpQ7qOQUuMgVHQzDBt0707olfj5TB1dFlarx+eQq912EVACDN4ZbEA
nQ2iVF+4jUhoG46XyyOFqLp0Vc/nSVfSSeeh3IxjLTl0D6SRUe1SToyGbV1slNvV
YvEpGsFx9Zb23C/SiucxQi8eMUPyK2KFYi1wIuYVMo6D9QUMiJ+CKnpT2RyXXye1
GW4d4Wx2Y/oKlo/4NNDBieCT8kJPlNB5DT1LFjz/ZVB+eneyBHTcjIRkwO8tq6wR
pEmuxa0IbecYXNI9d8GUdwVwILyQsN9JRt3IP9nxb40dyKv9GM42GZ2pwXNHF/EG
/YwsVd2Mjvl/LkL60eTVOJ/zIgigiDR+wpwt4QEuYT1unqMh6HJAaw0NODbCpzPg
n5Gve9cZO9rd4mdDYC645gysMW04mSjYawIpZt9yEyWMRyKcBcE=
=0Lrx
-----END PGP SIGNATURE-----

--4bgpwtsgwzqugjwz--
