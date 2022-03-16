Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B739A4DAF4E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355541AbiCPMBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355524AbiCPMBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:01:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9AF6581E;
        Wed, 16 Mar 2022 05:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647432019;
        bh=+9JC4UpgP/dnb0RksxqNoNEQdUUz7+Ntu6Z5TSUnjq8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Z5FQqbm3W7aNOXVLiDIAuaHab5gvl0yxrSwTtRn4pF0lBvIiH1jDqILJBOxR7h6QA
         vUCVP0vT9fdL7wQbXit60MahsjkKg7oyhA7zXd1YgqDHvhsshFMxZfEy94JzS+14t5
         aiOlOEWuzbM3f1TVHAKA6Ikl5jB3YyU4e3gixaME=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYLa-1o1JAR3EAC-00g2zk; Wed, 16
 Mar 2022 13:00:19 +0100
Date:   Wed, 16 Mar 2022 13:00:17 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree  (in
 pinctrl-npcm7xx)
Message-ID: <YjHRUdXqHHdr/XXL@latitude>
References: <20220316183227.725bfd37@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lY7qAAELnZeQE9Dl"
Content-Disposition: inline
In-Reply-To: <20220316183227.725bfd37@canb.auug.org.au>
X-Provags-ID: V03:K1:btAUbzbso2Qx5nou2Aru6cfXDsfQeMZ9k4e5b+zmdy5IvY1xMLU
 xFQK300fatYGVnHDST1cssuNqCesvtR2K89ryZpwf0+US+mACxkDLK8zSrgZziHE+aYO9pK
 eJWxuW/xxyW7UHWw9jCOrAz16SogB4lPmNq5ommouIpHHAAqSan4YCMeIYYovoZkhz6+9Dd
 O/EKMNofUbdnMCGllpUew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CfFtgFwNEo0=:BnmlwAhv81bBBl7mL+bREh
 V4oPtl+znm580rgMqnoVlPIx4sSUWaz6Pdh+SVsOTT/agYuFcgoT2sTUAfpUKGrscx5f7C5Yi
 KFKgUjg2RLb5MOD7C5wbZbEeGE8gPTvEybJPBbMJRxX965FNQmq9GvAwzE9XRGSMWUYLzmllf
 SE4MGRgABJ04TGqOXdxMEbQzQ3G9d1km5zZbQbAd6A7mn5Is0Zq2OZGFnxgcJ9t1NSgJ3oCVY
 KvpYiDWEmfHShr7wA5iOCrv6zvEkN3y+ex56Rqn0OdBNgmxQF/6HNZcooRCym9LQof0Cjt7bS
 h0mp3/5M5Yv/911oJjfNCrt1QJ9MP9h7lYOg4kSivcDSut2QicMfgC1A5WfZwgxAMc8PBP4nP
 J9mSBX8jdLu5un1b0oIiyu3in1ku8gwmoZBMekBJfx/DtBHnCPy26JuJNV2s6bTIXv3WOP9BO
 hsG7t9dRqXq51vHOu0wyQMhmtkahvR/f68UVRKqi9ihoItsLeJ9NnAuOjE0k0vaouuQZayiYB
 f9VofsZIyC44ej+cUmCUixSX1ME/nQvHjozTCMJ4qOmbFjp0MAGi2GsRdeSqkdY/6T+QTLuwq
 kkJxtJtx8NZQxreHLZjGxspcTKvH/lsy0yFPfdfCUez6soV0tN+h0QyyiUEFzjbBB8a0hpr0b
 MXEIsha2atLjBVNJOdQLNukyrmIRPh7a8uYX+lD6PzPR+jnnnOrhRhx1SioP1chJjCT8xFgvg
 CZIqvJQ3hkvpAfhxO7OT4jY2NfRhHmgiwbbH4gWormbqoi8omsKy1okVJcP+jMOtKQF8aqEg5
 waZXknfBMzKSK/syOKUczsIQBtDepkKeqv3+O2e9+kMEkcK6RzJEH0Zy9CcVsYHijSJFhTR9a
 aojYJOEVlfNCAY18CLoPwVjrfDm2XSIRGTSnj4py6uC1FkZZzpdBeuBkWRFuvN7rdRHCjxvpQ
 xaD+SIy4uCRnOW28MKfEEgg2sJa4nq8qIKJjbLqjar1g9RzHlUplmVWKG0Z/e+ObuRd2RZSq1
 benj9qXxfhWaphoCTLateCAWAPsM5I1SpV+NR1WijX9X+B0PIdx2eNyOsEUbF165eqqNVDSZ6
 hQ01xJ9JqCrElI=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lY7qAAELnZeQE9Dl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Stephen, Tomer, and others,


On Wed, Mar 16, 2022 at 06:32:27PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the kspp tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
[...]
> drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c: In function 'npcmgpio_irq_hand=
ler':
> include/linux/find.h:40:23: error: array subscript 'long unsigned int[0]'=
 is partly outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Werro=
r=3Darray-bounds]
>    40 |                 val =3D *addr & GENMASK(size - 1, offset);
>       |                       ^~~~~
> drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c:219:13: note: while referencing=
 'sts'
>   219 |         u32 sts, en, bit;
>       |             ^~~


Quoting the code in pinctrl-npcm7xx:

	for_each_set_bit(bit, (const void *)&sts, NPCM7XX_GPIO_PER_BANK)
		generic_handle_domain_irq(gc->irq.domain, bit);

The cast is indeed already a bit suspicious, because such casts can hide
type mismatch bugs.

The pinctrl-npcm7xx driver probably won't actually *run* on a 64-bit
platform (I guess there will be a separate pinctrl-npcm8xx driver for
the upcoming 64-bit platform from Nuvoton) but it's better not to have
unnecessary 32bit-isms.

>=20
> Caused by commit
>=20
>   3b588e43ee5c ("pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO driver")
>=20
> probably exposed by commit
>=20
>   a1d1e0e3d80a ("pinctrl: nuvoton: Add driver for WPCM450")
>=20
> from the pinctrl tree and enabling -Werror=3Darray-bounds.
>=20
> I have applied the following hack patch for today.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 16 Mar 2022 18:12:14 +1100
> Subject: [PATCH] fixup for "pinctrl: nuvoton: add NPCM7xx pinctrl and GPI=
O driver"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/=
nuvoton/pinctrl-npcm7xx.c
> index 41136f63014a..fddcb7d6bdf4 100644
> --- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
> +++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
> @@ -216,7 +216,8 @@ static void npcmgpio_irq_handler(struct irq_desc *des=
c)
>  	struct gpio_chip *gc;
>  	struct irq_chip *chip;
>  	struct npcm7xx_gpio *bank;
> -	u32 sts, en, bit;
> +	unsigned long sts, bit;
> +	u32 en;
> =20
>  	gc =3D irq_desc_get_handler_data(desc);
>  	bank =3D gpiochip_get_data(gc);
> @@ -225,7 +226,7 @@ static void npcmgpio_irq_handler(struct irq_desc *des=
c)
>  	chained_irq_enter(chip, desc);
>  	sts =3D ioread32(bank->base + NPCM7XX_GP_N_EVST);
>  	en  =3D ioread32(bank->base + NPCM7XX_GP_N_EVEN);
> -	dev_dbg(bank->gc.parent, "=3D=3D> got irq sts %.8x %.8x\n", sts,
> +	dev_dbg(bank->gc.parent, "=3D=3D> got irq sts %.8lx %.8x\n", sts,
>  		en);

This fix looks reasonable to me.



Thanks,
Jonathan

--lY7qAAELnZeQE9Dl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmIx0S0ACgkQCDBEmo7z
X9ut6A//XKv4DPD0MPpnCCcq/PV79GMjhPsdEh+4Dv/Mkxj2Nv5d9fUi5KIAPv8L
ZrSYYLB4np+Usw1lgF7Z5wq0pkM7ltwtMzYHx1BG/XKURRdrncSxJkUqlKUrjzeB
vszZlhGi7SJ/K8SwSwL1nwSNoVAfv2ukOWW53KJ30FHAZqfjB3/4j3/0UzYixbUw
2vmJpSgqKL3eiG5eX1guVo1nn5HAAmwtX6KeTAsKPCyk0LrZjQOT6Ofl0VrDrDgY
rYdvp/o+KvjDA7KtadTNhAkV9+ljjms+3R8dzPJXQwvD80yQrV1XM1xSfnT3SmnL
YT95MeYfQXPDsCIXL9TOYf9Bz/gBO1scqjitLfAcSiB1QgZQtCUGsxkIWTR3JLxX
EjDNMsh81cqHTP/P6kFiIgtMpfqcfE2Pp0Zh4rDociadq/VMHJ7xcfWLN0kxRhNo
N+C9v96sueeZUPZvqYqCqnNotL1I0Z/DddGSVGEZGrOVoGbyx/9tqauxI0hvEXzY
TxiS0k6unGQJrWm0drxefAobIAClGBA+hJzPjA14XGyWK4hR3vF3dKh3KeYzrJCQ
N9KLg+J+sbx7qyLGThchbpxA3nVH4z5oBH7klEJgD7GcDjoE+oDCiiRJS/EOwwZV
WcbWaAsXfAHNddMTkxKoPzxsO3eWagph9OcCVX6pYVNCxHG3oKg=
=Hj/o
-----END PGP SIGNATURE-----

--lY7qAAELnZeQE9Dl--
