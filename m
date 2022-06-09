Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51AA5454B8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239568AbiFITNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiFITNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:13:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430B32DC23D;
        Thu,  9 Jun 2022 12:13:17 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CF550660174E;
        Thu,  9 Jun 2022 20:13:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654801995;
        bh=dZUConaYM83SfxNLQoz8Wi5Nga/Nc8xILd55p6CeL9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gPZ+sDSBhBzyI0z2WjWDsL3XAuoOjIHmVZ9BJp2FE21OPDHNH9bGvJiDO7q0l6Iyg
         G+31ODeCbZ57/k3/6uNRw3ptOz7wq9cf9j8Ox7mk/OUU6OqHwCVY5/oFCv3vDrUE3/
         KDKLJ0+9lRdnDHNq+LjomB+AqJurqTwSNYGzZYh1a20MnV6iMu63BcMiOytPQ5RWw3
         UK157KBGKAPK4rH51s9sRNmv1hT0wzTgXPl1V7zPVBuRGkscM9lZlee2toOZ0aGf6M
         uieITgCQJ12xYD1d+z150DiMpR6J1fkMqEEBgbFFoU4TypNJrOY26bcYNKm5BhWJDB
         vPZgSEpxAxyWg==
Received: by mercury (Postfix, from userid 1000)
        id C218C10605B9; Thu,  9 Jun 2022 21:13:13 +0200 (CEST)
Date:   Thu, 9 Jun 2022 21:13:13 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     gaochao <gaochao49@huawei.com>
Cc:     alexs@kernel.org, linus.walleij@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhengbin13@huawei.com
Subject: Re: [PATCH v2 -next] power: supply: ab8500_fg: add missing
 destroy_workqueue in ab8500_fg_probe
Message-ID: <20220609191313.ck3ea4dvl7h4kqy3@mercury.elektranox.org>
References: <20220607033328.1846-1-gaochao49@huawei.com>
 <20220608024249.1075-1-gaochao49@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hbyckli7snwn67wj"
Content-Disposition: inline
In-Reply-To: <20220608024249.1075-1-gaochao49@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hbyckli7snwn67wj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 08, 2022 at 10:42:49AM +0800, gaochao wrote:
> From: Gao Chao <gaochao49@huawei.com>
>=20
> In ab8500_fg_probe,  misses destroy_workqueue in error path,
> this patch fixes that.
>=20
> Fixes: 010ddb813f35 ("power: supply: ab8500_fg: Allocate wq in probe")
> Signed-off-by: Gao Chao <gaochao49@huawei.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> v1->v2: add Reviewed-by Linus Walleij
> ---

Thanks, queued to power-supply's fixes branch.
Next time please put the v1->v2 changelog below the --- line when
sending the patch.

-- Sebastian

>  drivers/power/supply/ab8500_fg.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab85=
00_fg.c
> index ec8a404d71b4..4339fa9ff009 100644
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -3148,6 +3148,7 @@ static int ab8500_fg_probe(struct platform_device *=
pdev)
>  	ret =3D ab8500_fg_init_hw_registers(di);
>  	if (ret) {
>  		dev_err(dev, "failed to initialize registers\n");
> +		destroy_workqueue(di->fg_wq);
>  		return ret;
>  	}
>=20
> @@ -3159,6 +3160,7 @@ static int ab8500_fg_probe(struct platform_device *=
pdev)
>  	di->fg_psy =3D devm_power_supply_register(dev, &ab8500_fg_desc, &psy_cf=
g);
>  	if (IS_ERR(di->fg_psy)) {
>  		dev_err(dev, "failed to register FG psy\n");
> +		destroy_workqueue(di->fg_wq);
>  		return PTR_ERR(di->fg_psy);
>  	}
>=20
> @@ -3174,8 +3176,10 @@ static int ab8500_fg_probe(struct platform_device =
*pdev)
>  	/* Register primary interrupt handlers */
>  	for (i =3D 0; i < ARRAY_SIZE(ab8500_fg_irq); i++) {
>  		irq =3D platform_get_irq_byname(pdev, ab8500_fg_irq[i].name);
> -		if (irq < 0)
> +		if (irq < 0) {
> +			destroy_workqueue(di->fg_wq);
>  			return irq;
> +		}
>=20
>  		ret =3D devm_request_threaded_irq(dev, irq, NULL,
>  				  ab8500_fg_irq[i].isr,
> @@ -3185,6 +3189,7 @@ static int ab8500_fg_probe(struct platform_device *=
pdev)
>  		if (ret !=3D 0) {
>  			dev_err(dev, "failed to request %s IRQ %d: %d\n",
>  				ab8500_fg_irq[i].name, irq, ret);
> +			destroy_workqueue(di->fg_wq);
>  			return ret;
>  		}
>  		dev_dbg(dev, "Requested %s IRQ %d: %d\n",
> @@ -3200,6 +3205,7 @@ static int ab8500_fg_probe(struct platform_device *=
pdev)
>  	ret =3D ab8500_fg_sysfs_init(di);
>  	if (ret) {
>  		dev_err(dev, "failed to create sysfs entry\n");
> +		destroy_workqueue(di->fg_wq);
>  		return ret;
>  	}
>=20
> @@ -3207,6 +3213,7 @@ static int ab8500_fg_probe(struct platform_device *=
pdev)
>  	if (ret) {
>  		dev_err(dev, "failed to create FG psy\n");
>  		ab8500_fg_sysfs_exit(di);
> +		destroy_workqueue(di->fg_wq);
>  		return ret;
>  	}
>=20
> --
> 2.17.1
>=20

--hbyckli7snwn67wj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKiRkYACgkQ2O7X88g7
+prwRxAAj1r50ofWvR1IVXTNuYUUVCYJeZCf6+mqfXM0EPJXcycV3ed/Rpg2JQNI
umj10hMp5mMvAAVou4TacUAuhtgns/YpcjPDf57qbwWFarEItRpFeDUDxrmHfg9b
NXUc0P2UOU3RupNXbf24DXc44gtlARHMW8KtH+aJnEtc4ieViEcjJqOBpfHYwfyX
5oVBTtd+QuR3crdHdfr28liJUaC9dxUh0oxfFHW/gVXoC8iL7ytTRuWoq0sMR0s3
qKzG7JSCbwCJmwgHx4k4fqtlU5HBBxVKwhhrtE2a4BlAIeUyN2feaVCBc5tabgGI
YSICEjqISFDu4ANXOr5jf4GrB2YohvCBHmAg9J5vuFspwaBYCMMU9CNeTbiyW23H
yUnsgJLTb701aPsy71xkV7ajWREd11QQxEKrAWOlL+9D/LVZVSPvm1A6dj2dgEgZ
o4OSLKH0XO31zv9FILEcMvcT5T/yLhloaUwd0qAWr1QfaXzFj0rByP5ou6fKlDif
EYsvqoRbQBxRaR6kGNwDfOzFxPHGCdI61Pp7lanoc60y17PBgvZTVnf5C2+evF5R
ZnQC3HVMLbc2/R8PMZ8xt4PqiCOxnHOx0fKazSwJIwzFKfiHaFCf8Las8lu9Wdq3
ARrOVQsLA5ebXsE4xs9SB0N6Mmcbr/1k6WOPp20MkyA7FcTCsjM=
=4O+f
-----END PGP SIGNATURE-----

--hbyckli7snwn67wj--
