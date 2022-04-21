Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B575650992C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385780AbiDUHfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343901AbiDUHfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:35:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5433C13CE7;
        Thu, 21 Apr 2022 00:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650526328;
        bh=d4cra4r4KWeFgyQyIWhnv7yaeNTSKz33JnFGCXb+oD4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=E4tm+3padg0e8oo4pEcle4GTKcCVQlmvkHW3BTjuBRUPHo9Ajy/k2gCrGYxXHxOYW
         RCbVVG4BcO3/gc3BLQzqNSH70zLbxOf1z0JcfRk+jvT/8Ek+R2guwDN6aLNEFaAFmj
         yHySsgFj2+ITDaZKtJTnHMdu3h5AucENjwHQuSMM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.103]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBDjA-1ncWPC0Xi2-00Cg3c; Thu, 21
 Apr 2022 09:32:08 +0200
Date:   Thu, 21 Apr 2022 09:32:00 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Peng Wu <wupeng58@huawei.com>
Cc:     j.neuschaefer@gmx.net, linus.walleij@linaro.org,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, liwei391@huawei.com
Subject: Re: [PATCH] pinctrl: nuvoton: Add missing fwnode_handle_put in
 wpcm450_gpio_register
Message-ID: <YmEIcO5FHNvywPXH@latitude>
References: <20220421055356.8163-1-wupeng58@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pfzm36elNCLmliEt"
Content-Disposition: inline
In-Reply-To: <20220421055356.8163-1-wupeng58@huawei.com>
X-Provags-ID: V03:K1:RFBxEMY7lY14/M4SrB1kHXJgZT6WeRjJIy/ReQLKzATgSz+hQwk
 DvPPs7rFq1UD9YacLyxBumvyIaFFQP8DR++VUh3ccZXGFVcCROsdJccqp0959wK3OEaCLpa
 OUKHxTkMaY0Rko65ZnmgIc1kj+3w/3IKPXeTfgjqy33cuywd0XikwA13Bo9I9gzsqNxPznc
 XSku+ybluLyIovRb1dbyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J2BGZyAQDVc=:FtMn3u/EZ/lDLn4zMmO4ZV
 ZVNoBAOR2Vn+gq52X9uc4QBah5iCUJJTpdp7mkPHWUsFLdYvu41QVjFF9pNkDsZVzE9/8gFPM
 ZaWjTpjQXNQBbaqhW8yBU/1BmloJ3iJ5gB13zQgH5Jelp1P3thLj4Jwu4sW60DJfSPQPjMz9f
 CwbUKKzWY8X9dRrvkDQGqSDSNDEetnM6bA6zcwWDElmHb5vudStZn+dNCT/dO5jvFd0+uOoYu
 jyRk0htvWVYEVi5/6iSo/AOLUJs2F1ePX+iPR+O6y7kS0JUUCRKC0oB98zSOCmxBN3aZyRf8z
 GyJUy96TL7Q2+LqkKfBAiLn3IUEBqjcICScRJ8cahjQOGF87m5eXBWmcrkFwGx3rN/NGZDFR2
 cAH8JTtwd2lDH6T+tqeH5mlw7TXrp0wNcY7ko7jwUDuSCCBVmezFerI2dE2RUOMGDsi1NA22U
 IbscJtWLRUcsVl6DQm4EvFUZ0LEmaRfBRC+LgB98rVCa3tjL8rV8vDV92B/SGnLYbM1oKw/F3
 jMZZ4tukzgH3RzFKUxU16+4CQFEI8b2cidfHb+rHh7/uq7DyZOcADOzvyj+p5yaQa9yA+fPGl
 jE1mTrmTybSd/K4q2GrcjC1O4RzPKA3OWGWPrNNwsY4awXKPwRT2PcUcuQKQia98w/aWvYXLB
 Rhghi0IdobH0UgIOXP11WFnADdyaYphql2nKdlxaCrLfqXGL+ODLTscN4dV3J5x3CcVFk8TFi
 U9jOMlxYPTCrDFI06KPTU0SD/+B39th1UmxhcoflOBf1+hFOdlqZEBJjrYMbNKnFXFRc/vKWE
 mJcr0vdMFjV8jbPYPG96BTOXtBowJE/AhOIEZWUHN1Tu/hkSzYPYl0nYNxhxHw1yyBOhpQpdA
 arXvs5PMJkMAPlUmT40hbsGRh/qnipSDs5y42RL5yhKt+MJ2jrcKt4TVP1QzBdV7BWq/7Oxue
 hNkoa02msujJaTRFxl4onOGmQGmU27GODThZEp/Dx5TXDwXjei58INyhUywyX2jqd3vPgCPHG
 tjAu1U3urmU7AeRHo35XjKInouwT6HJbpdEmy9RBr90UPsdeSW5mvjRQEXbOD/xsvVZAvs1iJ
 6DUQngVHmGZYng=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pfzm36elNCLmliEt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

thank you for your patch!

On Thu, Apr 21, 2022 at 05:53:56AM +0000, Peng Wu wrote:
> In one of the error paths of the device_for_each_child_node() loop
> in wpcm450_gpio_register, add missing call to fwnode_handle_put.

Your patch changes multiple error patches, not just one of them. Please
change the commit message accordingly.

To make it easier to understand for the unfamiliar, please also mention:
- Where fwnode is acquired (in device_for_each_child_node?)
- Where the fwnode is released or used in the success (non-error) path.
  I think (part of) the answer is: It is assigned to gpio->gc.fwnode

>=20
> Signed-off-by: Peng Wu <wupeng58@huawei.com>
> ---
>  drivers/pinctrl/nuvoton/pinctrl-wpcm450.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c b/drivers/pinctrl/=
nuvoton/pinctrl-wpcm450.c
> index 0dbeb91f0bf2..de4388b512d7 100644
> --- a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
> +++ b/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
> @@ -1038,15 +1038,19 @@ static int wpcm450_gpio_register(struct platform_=
device *pdev,
>  		if (!fwnode_property_read_bool(child, "gpio-controller"))
>  			continue;

Does the 'continue' also need a fwnode_handle_put call?

> =20
>  		ret =3D fwnode_property_read_u32(child, "reg", &reg);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			fwnode_handle_put(child);
>  			return ret;
> +		}
> =20
>  		gpio =3D &pctrl->gpio_bank[reg];
>  		gpio->pctrl =3D pctrl;
> =20
> -		if (reg >=3D WPCM450_NUM_BANKS)
> +		if (reg >=3D WPCM450_NUM_BANKS) {
> +			fwnode_handle_put(child);
>  			return dev_err_probe(dev, -EINVAL,
> -					     "GPIO index %d out of range!\n", reg);
> +					"GPIO index %d out of range!\n", reg);

Please leave the indentation as is, in this line.

> +		}
> =20
>  		bank =3D &wpcm450_banks[reg];
>  		gpio->bank =3D bank;
> @@ -1060,8 +1064,10 @@ static int wpcm450_gpio_register(struct platform_d=
evice *pdev,
>  		}
>  		ret =3D bgpio_init(&gpio->gc, dev, 4,
>  				 dat, set, NULL, dirout, NULL, flags);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			fwnode_handle_put(child);
>  			return dev_err_probe(dev, ret, "GPIO initialization failed\n");
> +		}
> =20
>  		gpio->gc.ngpio =3D bank->length;
>  		gpio->gc.set_config =3D wpcm450_gpio_set_config;
> @@ -1074,8 +1080,11 @@ static int wpcm450_gpio_register(struct platform_d=
evice *pdev,
>  		girq->parent_handler =3D wpcm450_gpio_irqhandler;
>  		girq->parents =3D devm_kcalloc(dev, WPCM450_NUM_GPIO_IRQS,
>  					     sizeof(*girq->parents), GFP_KERNEL);
> -		if (!girq->parents)
> +		if (!girq->parents) {
> +			fwnode_handle_put(child);
>  			return -ENOMEM;
> +		}
> +
>  		girq->default_type =3D IRQ_TYPE_NONE;
>  		girq->handler =3D handle_bad_irq;
> =20
> @@ -1091,8 +1100,10 @@ static int wpcm450_gpio_register(struct platform_d=
evice *pdev,
>  		}
> =20
>  		ret =3D devm_gpiochip_add_data(dev, &gpio->gc, gpio);
> -		if (ret)
> +		if (ret) {
> +			fwnode_handle_put(child);
>  			return dev_err_probe(dev, ret, "Failed to add GPIO chip\n");
> +		}
>  	}
> =20
>  	return 0;
> --=20
> 2.17.1
>=20


Thanks,
Jonathan

--pfzm36elNCLmliEt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmJhCEcACgkQCDBEmo7z
X9viehAAra7S9FCE9v6tVkbZ2G7HXKr4evTu5Y6GTcaUxZNmWuq6iRDMp+ST0/X3
Rjl/kxia3tWiS3gZRufJaG3LacOcvvE7HDyBwQ9zBHDHq8Qiq9Z8OXCLonhja1HH
iQxe9pv8ZzbMqrqnkdPzJCO9sUoMnM3zIzBlUtoasbBYu1ee5QUKZS6EhTbDdXL0
f/WPnbPNLMQyTM6l5SCkL0ljiaEMnhcAzhB9p8llYIh4aaZcPm6k2whXzsy0gM81
vp2zp+5ggWfXWEnma4yoSBnjFMra5jbM0q+PnyPrT3BuvQUIkRspZbrJyOpxx0SS
kIs6kofuF7FIfivJoqwnBwVCU294ipYvauSXmCWo3iea4lLUWkgwftP1lnqAE+Gq
O08GLqe/VGMfvoSq59AncluzQ4NT5Jn+tBwglN/jzNdtzc9x3Smecob0P/XMlGaQ
4Kns4eTwv/hw0jOdzTlicAaOPRLL+r09XThBPGypuh5cHnyJbZW4KCBUs5sqQ+E8
jQNm68kHj92xiMpZ6KvvlfmTAJA5pnAOmV9eZQxodlLjDIQvGOWFnxQYfucrXsXi
QO3evrqeNUwaE1ggRnapWfCYuNEnLmeNId0FeofbUO716CXiXKCKrqfiTI+JmCE5
6mOez34G1ex7CoWMLb5qVOf2pFflnNqML2U91EAZpp3GbHykVrQ=
=5xn2
-----END PGP SIGNATURE-----

--pfzm36elNCLmliEt--
