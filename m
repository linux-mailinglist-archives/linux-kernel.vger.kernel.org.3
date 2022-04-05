Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628D64F4C61
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578408AbiDEXTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349249AbiDEJt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:49:29 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F21023169;
        Tue,  5 Apr 2022 02:43:13 -0700 (PDT)
Received: from ktm (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id BC9D683AE1;
        Tue,  5 Apr 2022 11:43:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1649151790;
        bh=1fJSTQimapdvTFOsOLTaalsnG3fZ3YCLp6YlkcdShas=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l2VQnCrZSzmt9jxKdKmlmq5n5CRBplpofuIkxpPVa12/L4P0Gb5w5IDgmIWffjbFH
         2+Aez7+QEPsblwTnNP9g0FIrdxilBhRAn/6Utmy1s/9SFPCC1vI8SzEtKP6hRiSApW
         nK98jMpaGh9QXUovhVpvVTSnqT5hBbI/gxOykUJ86tFvWY9uctw97fxCHepkym2gy7
         fSqhyUEi5zVAPCLu9hhC/PhkpoDZ5in651LiIDM022UULQ+lORU/uJaNdjwECVdfni
         5ZCJ+GlZCc6YxJMrwQhkw924nit8w8Sp1tzqrbWoULyoHWneAPyLwB5PnhvCAvz9kh
         tG2dSyh5WFhxQ==
Date:   Tue, 5 Apr 2022 11:43:08 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hubert Feurstein <hubert.feurstein@contec.at>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 04/12] ARM: ep93xx: make mach/ep93xx-regs.h local
Message-ID: <20220405114308.065cba5a@ktm>
In-Reply-To: <20220405091750.3076973-5-arnd@kernel.org>
References: <20220405091750.3076973-1-arnd@kernel.org>
        <20220405091750.3076973-5-arnd@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/nGHjeZXx_2J2ZxPBDD7GYEW"; protocol="application/pgp-signature"
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nGHjeZXx_2J2ZxPBDD7GYEW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue,  5 Apr 2022 11:17:42 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Nothing relies on it outside of arch/arm/mach-ep93xx/, so just move
> it there.
>=20
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-ep93xx/{include/mach =3D> }/ep93xx-regs.h | 4 ----
>  arch/arm/mach-ep93xx/gpio-ep93xx.h                    | 2 +-
>  arch/arm/mach-ep93xx/include/mach/uncompress.h        | 1 -
>  arch/arm/mach-ep93xx/soc.h                            | 2 +-
>  4 files changed, 2 insertions(+), 7 deletions(-)
>  rename arch/arm/mach-ep93xx/{include/mach =3D> }/ep93xx-regs.h (94%)
>=20
> diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> b/arch/arm/mach-ep93xx/ep93xx-regs.h similarity index 94%
> rename from arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> rename to arch/arm/mach-ep93xx/ep93xx-regs.h
> index 6839ea032e58..8fa3646de0a4 100644
> --- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> +++ b/arch/arm/mach-ep93xx/ep93xx-regs.h
> @@ -1,8 +1,4 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> - */
> -
>  #ifndef __ASM_ARCH_EP93XX_REGS_H
>  #define __ASM_ARCH_EP93XX_REGS_H
> =20
> diff --git a/arch/arm/mach-ep93xx/gpio-ep93xx.h
> b/arch/arm/mach-ep93xx/gpio-ep93xx.h index 242af4a401ea..7b46eb7e5507
> 100644 --- a/arch/arm/mach-ep93xx/gpio-ep93xx.h
> +++ b/arch/arm/mach-ep93xx/gpio-ep93xx.h
> @@ -4,7 +4,7 @@
>  #ifndef __GPIO_EP93XX_H
>  #define __GPIO_EP93XX_H
> =20
> -#include <mach/ep93xx-regs.h>
> +#include "ep93xx-regs.h"
> =20
>  #define EP93XX_GPIO_PHYS_BASE
> EP93XX_APB_PHYS(0x00040000) #define EP93XX_GPIO_BASE
> EP93XX_APB_IOMEM(0x00040000) diff --git
> a/arch/arm/mach-ep93xx/include/mach/uncompress.h
> b/arch/arm/mach-ep93xx/include/mach/uncompress.h index
> b3ec1db988db..e20bcab702b2 100644 ---
> a/arch/arm/mach-ep93xx/include/mach/uncompress.h +++
> b/arch/arm/mach-ep93xx/include/mach/uncompress.h @@ -5,7 +5,6 @@
>   * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
>   */
> =20
> -#include <mach/ep93xx-regs.h>
>  #include <asm/mach-types.h>
> =20
>  static unsigned char __raw_readb(unsigned int ptr)
> diff --git a/arch/arm/mach-ep93xx/soc.h b/arch/arm/mach-ep93xx/soc.h
> index f0986e288d19..3245ebbd5069 100644
> --- a/arch/arm/mach-ep93xx/soc.h
> +++ b/arch/arm/mach-ep93xx/soc.h
> @@ -9,7 +9,7 @@
>  #ifndef _EP93XX_SOC_H
>  #define _EP93XX_SOC_H
> =20
> -#include <mach/ep93xx-regs.h>
> +#include "ep93xx-regs.h"
>  #include "irqs.h"
> =20
>  /*

Reviewed-by: Lukasz Majewski <lukma@denx.de>


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/nGHjeZXx_2J2ZxPBDD7GYEW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmJMDywACgkQAR8vZIA0
zr0hrAf/Te1BA5RI9t1ZN09TwZ6OTGw02iUdC2+jJJHNOg254kPI/b4ip+1wLDg4
f+4aTt6u5gKdNei1yNxzxKuKob9J2h12w9BhgIDKqsd88TfOi+fit+u3tYuC9VHF
h/jVvPfvatAw28jnpH/IZrjXw007cC5yNbHz+rAGSij5+y2FAhCBqD29N2iP82Zp
LNN6CBOhumNHcGXhofo5RFXXM1SJ8XjJsssSbSBggjqwuRA5ni4qbLRN1/493VHj
paqqX51H9BcfPujAonLFpI9XMHPXjW4x8JDT6DV7YxRifILkdfKFWA2wkCun1J4U
JYwoUksaa08GrJHmPsztQcKJjC7f2A==
=grVr
-----END PGP SIGNATURE-----

--Sig_/nGHjeZXx_2J2ZxPBDD7GYEW--
