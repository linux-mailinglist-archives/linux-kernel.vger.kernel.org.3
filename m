Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD724681DD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 02:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384035AbhLDBts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 20:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhLDBtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 20:49:47 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DE5C061751;
        Fri,  3 Dec 2021 17:46:22 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p18so3256401plf.13;
        Fri, 03 Dec 2021 17:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5DWPJB5T9d6eLjilcsFjparqq5m5Bs4XW3dv5oWZcZE=;
        b=A5fTjhkKcF3zMVkUdoOADHjKh5LHly+NONZ9szawXcAF85Lbo8szH42gDBdA5dgqvi
         ybh7Wh3peMBUOGJdtaccyDHP+v+yn6N3jDEnfmCkBkbp/MN2sLQZfhCGXllof+Mn8DY5
         446v1uqRSDny56onUOrh7+JeJ4mdenDmDyMh7/11UvRIDCT4MtpUqxgd+Cl1o22oflUj
         05Z5psSONAuIQRsbl2ua5he5Ysf1kL4/yGz8rPH2+T6umpv1NZQp5RR/0UvU9tre8gMG
         K8GZQXZozY1lpdV+w9w1Zzwd37giDT4PIVg2uEPLlAL/OoreecK4KglNt/I2Gfe0qiX/
         NX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5DWPJB5T9d6eLjilcsFjparqq5m5Bs4XW3dv5oWZcZE=;
        b=2BX3B1gC9JeQacjA5F+n5kWD4YtUqnHpGR6Du58FcbBhJwnqvM+vwFgDICcVVNsw5E
         UezdQ1m/s1654ZGrvYUFsW/LdvEkiRq9tDzChoJ3SPboWWUDOBP9zqgA7IZx4o9DFMVP
         dcCDrSHz0vu/UliTgcRbTCnwYgULmEFI+F93ny3Hj5Nb6S2KymUTCqLxH6yYrAc8iVk5
         DeAnaK8KOHylXpZ1clI1R/jgg3BMToGr4lDqA15CxlFO35F3BLagxBDfx5nO6JYVL1AM
         0gAkVyCp04x2CIxCl/kWVQKMYMaloDlQHuItBvvW6cQAOgvW9NSMn+QQ4LIGv7cYMYU2
         MfPQ==
X-Gm-Message-State: AOAM531Zd5hscG6uXOB5tFw7Sk3dQY86LW0/5w7p7PFKNxH+1keYpQ3q
        i46/snXEdokUYHHPp8gOgCVaiRNVMr6F3A==
X-Google-Smtp-Source: ABdhPJy+J9awEAExhgaatQkDgCwvJq8uHLbiOJZSpO8h6/SHnUezxDjWB2vRD34RKvlnZUfxN9NpCw==
X-Received: by 2002:a17:90b:4c4f:: with SMTP id np15mr18324239pjb.65.1638582382451;
        Fri, 03 Dec 2021 17:46:22 -0800 (PST)
Received: from shinobu ([37.120.154.45])
        by smtp.gmail.com with ESMTPSA id a22sm4397533pfh.111.2021.12.03.17.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 17:46:21 -0800 (PST)
Date:   Sat, 4 Dec 2021 10:46:17 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jason Kridner <jkridner@beagleboard.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: ti-eqep: Enable for TDA4VM/J721E
Message-ID: <YarIaXSfewK/nCZs@shinobu>
References: <20211130193346.678544-1-jkridner@beagleboard.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ytbyk5ErfLA/LQ3L"
Content-Disposition: inline
In-Reply-To: <20211130193346.678544-1-jkridner@beagleboard.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ytbyk5ErfLA/LQ3L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 30, 2021 at 02:33:46PM -0500, Jason Kridner wrote:
> Counter TI-EQEP was tested on TDA4VM/J721E SoC.
>=20
> Overlay used for testing EQEP0 and EQEP1:
>=20
>     &cbass_main {
> 	#address-cells =3D <2>;
> 	#size-cells =3D <2>;
>=20
> 	eqep0: qep@3200000 {
> 		compatible =3D "ti,am3352-eqep";
> 		reg =3D <0 0x3200000 0 0x100>;
> 		power-domains =3D <&k3_pds 94 TI_SCI_PD_EXCLUSIVE>;
> 		clocks =3D <&k3_clks 94 0>;
> 		clock-names =3D "eqep0-ficlk";
> 		interrupts =3D <GIC_SPI 322 IRQ_TYPE_EDGE_RISING>;
> 		interrupt-names =3D "eqep0";
> 		symlink =3D "bone/eQEP0"; /* A - P9_42, B - P9_27 */
>=20
> 		count_mode =3D <0>;
> 		swap_input =3D <0>;
> 		invert_qa =3D <1>;
> 		invert_qb =3D <1>;
> 		invert_qi =3D <0>;
> 		invert_qs =3D <0>;
> 	};
>=20
> 	eqep1: qep@3210000 {
> 		compatible =3D "ti,am3352-eqep";
> 		reg =3D <0 0x3210000 0 0x100>;
> 		power-domains =3D <&k3_pds 95 TI_SCI_PD_EXCLUSIVE>;
> 		clocks =3D <&k3_clks 95 0>;
> 		clock-names =3D "eqep1-ficlk";
> 		interrupts =3D <GIC_SPI 323 IRQ_TYPE_EDGE_RISING>;
> 		interrupt-names =3D "eqep1";
> 		symlink =3D "bone/eQEP1"; /* A - P8_35, B - P8_33 */
>=20
> 		count_mode =3D <0>;
> 		swap_input =3D <0>;
> 		invert_qa =3D <1>;
> 		invert_qb =3D <1>;
> 		invert_qi =3D <0>;
> 		invert_qs =3D <0>;
> 	};
>=20
> 	eqep2: qep@3220000 {
> 		status =3D "disabled";
> 		compatible =3D "ti,am3352-eqep";
> 		reg =3D <0 0x3220000 0 0x100>;
> 		power-domains =3D <&k3_pds 96 TI_SCI_PD_EXCLUSIVE>;
> 		clocks =3D <&k3_clks 96 0>;
> 		clock-names =3D "eqep2-ficlk";
> 		interrupts =3D <GIC_SPI 324 IRQ_TYPE_EDGE_RISING>;
> 		interrupt-names =3D "eqep2";
>=20
> 		count_mode =3D <0>;
> 		swap_input =3D <0>;
> 		invert_qa =3D <1>;
> 		invert_qb =3D <1>;
> 		invert_qi =3D <0>;
> 		invert_qs =3D <0>;
> 	};
>     };
>=20
> Signed-off-by: Jason Kridner <jkridner@beagleboard.org>

Hello Jason,

The change in this patch is a simple architecture enablement so I don't
have a problem with it given that it's been tested. However, I would
like the commit message simplified as Nishanth recommends before we
merge this patch, so please resubmit it to clean that up. Regardless,
for the code change itself I'll give my ack.

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 2de53ab0dd25..453490059c88 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -51,7 +51,7 @@ config STM32_LPTIMER_CNT
> =20
>  config TI_EQEP
>  	tristate "TI eQEP counter driver"
> -	depends on (SOC_AM33XX || COMPILE_TEST)
> +	depends on (SOC_AM33XX || ARCH_K3 || COMPILE_TEST)
>  	select REGMAP_MMIO
>  	help
>  	  Select this option to enable the Texas Instruments Enhanced Quadrature
> --=20
> 2.30.2
>=20

--ytbyk5ErfLA/LQ3L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmGqyEkACgkQhvpINdm7
VJIk8w/+M2rvWvbZoEfqexSfGV9Et/Td040UGwdDojE6tsRnftjhQESZqgSl45DS
2OHUMWm26NWfKJeSjlTiaMa8/FhxkkszASZiAg0KAI0bT25RHTAHacUKbNcd3T54
IWF/mk0sL+M75o/NF/EUT3d0pqgEFir8qWLlQ39o5p4gLhcahwUAk3a6lgF0AfiY
tFbK8TzUhkaWqtVj5HajUhhuP8IiZvyRGfoREl4Es0awhMS0MdVQpWL2uLvHCJWn
X5zMhWUoVs7s33y4UT1dG0dPVmbvY6XhuTh2a4QPyLrlVevqi2nzcW0gQPxjRoHi
f03tjqrIz/46m61bk43eDASxEGJDGIU2MNcC6v4ay+pDkj7zpsHH8R55H2/kNV58
vHARh9EQDfO1UVyTE+KicEec1NO/aZmAOhgGim0ChHRyPQgxojYtwAIrB0d8Ny/w
h03rHp451q757LcZpX89bdbsl0wVxWISs7SRMimVSvwCF2ClusFrEwzlh4RFZYch
qUD6Gbu71jYzNpk4g2vUxBL+OxLFjR2L95Lhdd4BZ62q3u725t+HELv7v4jD6aWX
dzgIIii6c2mBGklmwrTSkkR2WZDNfyn10bYN8QUcSyFnJ/PD1ZCwxAKrryXtCl10
NxRn149WFcS6Rxv2pBuPyVUUl82WzGMHlDlv8DcmwuBj/XME9VY=
=oFUa
-----END PGP SIGNATURE-----

--ytbyk5ErfLA/LQ3L--
