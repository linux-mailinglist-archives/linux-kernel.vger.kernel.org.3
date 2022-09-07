Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911EF5B0ED4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiIGVFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiIGVFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:05:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF207B29E;
        Wed,  7 Sep 2022 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662584681;
        bh=mqDtg+l0I6e79d4lOPRDS6Gf1c/cE2AsBE/OA5HiMHY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=E+u2GcA2zqCy96AsnW0YmNBYKHmSTK2EK+IiukuhZg+8oGS89CUGWKJgHHHLCCe3T
         A+N8+/7PAppi1VbXAUfWyjJXkjDXk5/iXCA3DePIjnKCgFnWxTWeiIDKHiad4t4LXk
         lUeqA3MlE1zQ8nMScPCIURoYWFetISCyEqrKDd3w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from probook ([87.79.82.18]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2O2W-1oVUG71qog-003u4x; Wed, 07
 Sep 2022 23:04:41 +0200
Date:   Wed, 7 Sep 2022 23:04:40 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] pinctrl: wpcm450: Correct the fwnode_irq_get()
 return value check
Message-ID: <YxkHaBKtiO9zVuKM@probook>
References: <20220905191408.73794-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QyHwNmfZawVS5MLu"
Content-Disposition: inline
In-Reply-To: <20220905191408.73794-1-andriy.shevchenko@linux.intel.com>
X-Provags-ID: V03:K1:MMJ2EtvCzJlyagONLJ1LhxvzZyuz2bsFbWUr3Em88DhlvZPX1D1
 CpLHvVudL8anyRIuSYIJMWBXcMkEmeR1MoJLXf2hXNW8t6+X41TjcRVK1juuuS1H8bMq5Xc
 H2d63MhR+izfn1PAsp4THWjN7NwGiogKg/QS/qD0k2wO12BtUJOXiZpvfDvH70eDx5KyDIC
 O5kMAygGiB1iLxe7Sksgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+kdghG9z2xU=:Dl93sjQ2Ci6fO4dZ5WeWB8
 u/jp2HhujDI29lcWKUySUivB6tVGKmXy1GlIJHvCxPiHv8yd4MoKPkbiKwl2Y03AH0qVSacZt
 npGpZ7KTJOYOK+04lJRQs3fy3cGryYb2uM9GAmZ9ImW+RN/KM2C72uQ58c0Gb0q5vC7ZVsVXF
 UqcciUMFvHxyojpxWylf06zs9ORl7apoDJ4+1xBI4pPBy7dShMTE/MEI1pUZYrjbh6Fn/Ecy8
 Tc0uEAb4XF6e4Hnh8Wi/y0sWx+Wd8peBisQ8ZfLX73vuniD6iU0OVTcY/hfxl3o71QZLaAvWX
 H63yEBLgXJ0hVqT0aLtxv8kst2ZO7H39xqnrcmnlkn9rdUgTBDXCXwgabKaLCofCciKqFLtdf
 g2OZjiP/3NKt9bp2r9wzfx3MZ1EPVN10gI1A4j/ok/RyjZyURNGnwM7216WnCN0sTmXbKRXmo
 gKiSR577Ydn+S8j/KdJb6bIph5wiNinmKuG1es5frWYkD04uhWuFmlK6iNSwQ97RJF5jFka78
 VLIqgqGUwV5ze6gv3r3GjhZuLIQCcRyZVr1TGCAP1yk3gvujAFs0YfwynKue5j31Mvzwpsith
 gakfwpKMZJquPF/j4ptzFuVawGs6S4/4RG89fUg7RMTuz06zcJjEKXv/U5jg+deU76+Qfgp68
 H8/R/StdHIVqMdoqus4mNJXOOZNZVyAMTlgnJOfBGeQgR4rJ4ZRUmgV6aRnDNFE8wh+NyRCMl
 3wTXgCbFv1UcJ1y3gEedRBzWhm146i5xIsB93+JSm4hTSqyPzokyxF1DK7btbIUcxfmb8MqDg
 +tkS2tYnGXFmiY+sfumOHwbVzME6BgGSIM06AwYfVTEHa6/hbI24POYT6slC1AlplO88+6CVN
 guceJ2kF3GqoNzGFInwSDKevY4yc7YHqo3cqF170GoPNfvAg9108Em06oUv1w+AHB+63Mn2J2
 sOSDkYdhwgXAgbmusG7fD6icVNGKeZxG6Pp0MJMZeAM7JTAWNWWyv6zMTJs9n6qEryeCQHtSU
 3wi2CrBHT5mHgv9d8nQ7naucOO60P+2NzffKU2TrnQ5BAcfPps8lGpritMHkOsUEf5GD21s03
 Kwsxc3ejTuxk69lbflJbsyqoF8eHfaMlRVjbH3AKlW91qhndIeFg8f8l1vF3bLhlSiF3TlqCO
 9tsL0Ni7EX3dYCRxc4zCZ2G9ce
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QyHwNmfZawVS5MLu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Sep 05, 2022 at 10:14:08PM +0300, Andy Shevchenko wrote:
> fwnode_irq_get() may return all possible signed values, such as Linux
> error code. Fix the code to handle this properly.

It would be good to note explicitly here what a return value of zero
means, i.e., as the documentation of of_irq_get says, "IRQ mapping
failure", and why it should result in skipping this IRQ.

> Fixes: a1d1e0e3d80a ("pinctrl: nuvoton: Add driver for WPCM450")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pinctrl/nuvoton/pinctrl-wpcm450.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c b/drivers/pinctrl/=
nuvoton/pinctrl-wpcm450.c
> index 0dbeb91f0bf2..8193b92da403 100644
> --- a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
> +++ b/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
> @@ -1081,10 +1081,13 @@ static int wpcm450_gpio_register(struct platform_=
device *pdev,
> =20
>  		girq->num_parents =3D 0;
>  		for (i =3D 0; i < WPCM450_NUM_GPIO_IRQS; i++) {
> -			int irq =3D fwnode_irq_get(child, i);
> +			int irq;
> =20
> +			irq =3D fwnode_irq_get(child, i);

(Unneccesary churn, but I'll allow it)

>  			if (irq < 0)
>  				break;
> +			if (!irq)
> +				continue;

Since irq =3D=3D 0 seems to be an error condition, the following seems fine
to me, and simpler:

-			if (irq < 0)
+			if (irq <=3D 0)
 				break;



Thanks,
Jonathan

--QyHwNmfZawVS5MLu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmMZB0UACgkQCDBEmo7z
X9tvsA//ToHzTHoeMYZ0PQTlohG0yLPn60E96bE2iggwWBRQ5QU/nUHseXFgTin5
tGid5OfhqxHsnX8TDCFHq7S+29MPm+H1lmx7GKNeM73IK2HUjwdJ3hqG2jpcPIOa
5Og+hagJq1IrKcrD8Dmwb/7Hud/68gw8ry1b9W7faP0+16wiyYdm8+Pf8ZZ1QXca
YlQLIhqhL0WhxalEW7RGcBQW4n0vkxgmXVP8ZMUzFshJDTgk05vAp334US1n74xj
3qp7gsshpo0qJRGFN5znfgnc1EeqSQVJV1DNNP+sLVMTBVI+Yj3bHIhz601zORaY
Tvdh7KnouxCXLNaTHfUGUF0nXk6N8Ilyz4USDQG2B3+Jtyh4SxeJnBKp/WRMKRw2
+2GStxVtQoZSc3YvUTd4zgOIOI4Gs54lpy1grE4U0/9/RdK/2yYOtgww62qE50lb
nYnLkxwhkkgHLfAaWJwTOmj0qoxtQ3ANPMatY9573YHC0WTaLFl6W7qoUOYBB0q7
9L1Lz/HzL+Rta/1ujq1c9ElnmHGShH2mPBGUAxXslvxlSD52Z2yhPeMgrhJ2Zxx4
xKQcUxt3DY9H4R9RYseXUbpZt+27x0HYVuhkiXip0BHvFEpHtWxK2frKqvti8EdR
VF+Ggle0U21LXIBjZkRaH7Fj4/CdP2mvBdz/3yv++KgLwPwVVSY=
=u7tt
-----END PGP SIGNATURE-----

--QyHwNmfZawVS5MLu--
