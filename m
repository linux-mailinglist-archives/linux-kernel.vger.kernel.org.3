Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCC54F493C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391783AbiDEWIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349248AbiDEJt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:49:29 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE5923154;
        Tue,  5 Apr 2022 02:43:03 -0700 (PDT)
Received: from ktm (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 425BF83AEF;
        Tue,  5 Apr 2022 11:42:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1649151780;
        bh=dixxNpypPVsrmhYjsGTnVj0V4vyqiddS+avaCICiwsk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oVnMd9Tit1+ICT6sscqUC1DhD6fEE34RdJXUpbKngv8WOU0rg6xyIQ0q6Ao9npGi4
         tn94SaQxTdOIqyea09+TlL1SgPIFQ+wfXblS1785Zsw0Aaezftmag6MBBRO+XwS3Oo
         GZNMx2WLIpiSJDk05wNW8naILFBjEghi2O5qiyssUIuWRvXKQpXY5Qs3d0g628rSFs
         pSTpN0DAAUNL/5JFsnUAjbrCVzN++575NmRWK3YLGyw25zDeZnsIL+76eLgZ4V7/zm
         D4utiElMDhUUEqee71gh/k7yu9/hfsCHUim0teBeTamcUASnzSW/7M7kfF+SlYDsY9
         CPsocQSMww0BA==
Date:   Tue, 5 Apr 2022 11:42:58 +0200
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
Subject: Re: [PATCH 03/12] ARM: ep93xx: enable SPARSE_IRQ
Message-ID: <20220405114258.1ee218d6@ktm>
In-Reply-To: <20220405091750.3076973-4-arnd@kernel.org>
References: <20220405091750.3076973-1-arnd@kernel.org>
        <20220405091750.3076973-4-arnd@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/efY+hmlk8r0DJR4I.DiqSlM"; protocol="application/pgp-signature"
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

--Sig_/efY+hmlk8r0DJR4I.DiqSlM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue,  5 Apr 2022 11:17:41 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Without CONFIG_SPARSE_IRQ, we rely on mach/irqs.h to define NR_IRQS
> globally. Do the minimal conversion by setting .nr_irqs in each
> machine descriptor.
>=20
> Only the vision_ep9307 machine has extra IRQs for GPIOs, so make
> .nr_irqs the original value there, while using the plain
> NR_EP93XX_IRQS everywhere else.
>=20
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Hubert Feurstein <hubert.feurstein@contec.at>
> Cc: Lukasz Majewski <lukma@denx.de>
> Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig                               | 2 ++
>  arch/arm/mach-ep93xx/adssphere.c               | 1 +
>  arch/arm/mach-ep93xx/core.c                    | 1 +
>  arch/arm/mach-ep93xx/edb93xx.c                 | 8 ++++++++
>  arch/arm/mach-ep93xx/gesbc9312.c               | 1 +
>  arch/arm/mach-ep93xx/{include/mach =3D> }/irqs.h | 7 -------
>  arch/arm/mach-ep93xx/micro9.c                  | 4 ++++
>  arch/arm/mach-ep93xx/simone.c                  | 1 +
>  arch/arm/mach-ep93xx/snappercl15.c             | 1 +
>  arch/arm/mach-ep93xx/soc.h                     | 1 +
>  arch/arm/mach-ep93xx/ts72xx.c                  | 3 ++-
>  arch/arm/mach-ep93xx/vision_ep9307.c           | 1 +
>  12 files changed, 23 insertions(+), 8 deletions(-)
>  rename arch/arm/mach-ep93xx/{include/mach =3D> }/irqs.h (96%)
>=20
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 31f024e6e925..5177e54cc14c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -358,6 +358,8 @@ config ARCH_EP93XX
>  	select CPU_ARM920T
>  	select GPIOLIB
>  	select COMMON_CLK
> +	select IRQ_DOMAIN
> +	select SPARSE_IRQ
>  	help
>  	  This enables support for the Cirrus EP93xx series of CPUs.
> =20
> diff --git a/arch/arm/mach-ep93xx/adssphere.c
> b/arch/arm/mach-ep93xx/adssphere.c index 8d5e349a7a6d..0c48d3c5b8e7
> 100644 --- a/arch/arm/mach-ep93xx/adssphere.c
> +++ b/arch/arm/mach-ep93xx/adssphere.c
> @@ -32,6 +32,7 @@ static void __init adssphere_init_machine(void)
>  MACHINE_START(ADSSPHERE, "ADS Sphere board")
>  	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
>  	.atag_offset	=3D 0x100,
> +	.nr_irqs	=3D NR_EP93XX_IRQS,
>  	.map_io		=3D ep93xx_map_io,
>  	.init_irq	=3D ep93xx_init_irq,
>  	.init_time	=3D ep93xx_timer_init,
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index e4569a5acc3f..2d58e273c96d 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -47,6 +47,7 @@
>  #include <asm/mach/map.h>
> =20
>  #include "soc.h"
> +#include "irqs.h"
> =20
>  /***********************************************************************=
**
>   * Static I/O mappings that are needed for all EP93xx platforms
> diff --git a/arch/arm/mach-ep93xx/edb93xx.c
> b/arch/arm/mach-ep93xx/edb93xx.c index af0e22471ebd..4b90899a66e9
> 100644 --- a/arch/arm/mach-ep93xx/edb93xx.c
> +++ b/arch/arm/mach-ep93xx/edb93xx.c
> @@ -243,6 +243,7 @@ static void __init edb93xx_init_machine(void)
>  MACHINE_START(EDB9301, "Cirrus Logic EDB9301 Evaluation Board")
>  	/* Maintainer: H Hartley Sweeten
> <hsweeten@visionengravers.com> */ .atag_offset	=3D 0x100,
> +	.nr_irqs	=3D NR_EP93XX_IRQS,
>  	.map_io		=3D ep93xx_map_io,
>  	.init_irq	=3D ep93xx_init_irq,
>  	.init_time	=3D ep93xx_timer_init,
> @@ -255,6 +256,7 @@ MACHINE_END
>  MACHINE_START(EDB9302, "Cirrus Logic EDB9302 Evaluation Board")
>  	/* Maintainer: George Kashperko <george@chas.com.ua> */
>  	.atag_offset	=3D 0x100,
> +	.nr_irqs	=3D NR_EP93XX_IRQS,
>  	.map_io		=3D ep93xx_map_io,
>  	.init_irq	=3D ep93xx_init_irq,
>  	.init_time	=3D ep93xx_timer_init,
> @@ -267,6 +269,7 @@ MACHINE_END
>  MACHINE_START(EDB9302A, "Cirrus Logic EDB9302A Evaluation Board")
>  	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
>  	.atag_offset	=3D 0x100,
> +	.nr_irqs	=3D NR_EP93XX_IRQS,
>  	.map_io		=3D ep93xx_map_io,
>  	.init_irq	=3D ep93xx_init_irq,
>  	.init_time	=3D ep93xx_timer_init,
> @@ -279,6 +282,7 @@ MACHINE_END
>  MACHINE_START(EDB9307, "Cirrus Logic EDB9307 Evaluation Board")
>  	/* Maintainer: Herbert Valerio Riedel <hvr@gnu.org> */
>  	.atag_offset	=3D 0x100,
> +	.nr_irqs	=3D NR_EP93XX_IRQS,
>  	.map_io		=3D ep93xx_map_io,
>  	.init_irq	=3D ep93xx_init_irq,
>  	.init_time	=3D ep93xx_timer_init,
> @@ -291,6 +295,7 @@ MACHINE_END
>  MACHINE_START(EDB9307A, "Cirrus Logic EDB9307A Evaluation Board")
>  	/* Maintainer: H Hartley Sweeten
> <hsweeten@visionengravers.com> */ .atag_offset	=3D 0x100,
> +	.nr_irqs	=3D NR_EP93XX_IRQS,
>  	.map_io		=3D ep93xx_map_io,
>  	.init_irq	=3D ep93xx_init_irq,
>  	.init_time	=3D ep93xx_timer_init,
> @@ -303,6 +308,7 @@ MACHINE_END
>  MACHINE_START(EDB9312, "Cirrus Logic EDB9312 Evaluation Board")
>  	/* Maintainer: Toufeeq Hussain <toufeeq_hussain@infosys.com>
> */ .atag_offset	=3D 0x100,
> +	.nr_irqs	=3D NR_EP93XX_IRQS,
>  	.map_io		=3D ep93xx_map_io,
>  	.init_irq	=3D ep93xx_init_irq,
>  	.init_time	=3D ep93xx_timer_init,
> @@ -315,6 +321,7 @@ MACHINE_END
>  MACHINE_START(EDB9315, "Cirrus Logic EDB9315 Evaluation Board")
>  	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
>  	.atag_offset	=3D 0x100,
> +	.nr_irqs	=3D NR_EP93XX_IRQS,
>  	.map_io		=3D ep93xx_map_io,
>  	.init_irq	=3D ep93xx_init_irq,
>  	.init_time	=3D ep93xx_timer_init,
> @@ -327,6 +334,7 @@ MACHINE_END
>  MACHINE_START(EDB9315A, "Cirrus Logic EDB9315A Evaluation Board")
>  	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
>  	.atag_offset	=3D 0x100,
> +	.nr_irqs	=3D NR_EP93XX_IRQS,
>  	.map_io		=3D ep93xx_map_io,
>  	.init_irq	=3D ep93xx_init_irq,
>  	.init_time	=3D ep93xx_timer_init,
> diff --git a/arch/arm/mach-ep93xx/gesbc9312.c
> b/arch/arm/mach-ep93xx/gesbc9312.c index d7f9890321eb..0b7043e3e178
> 100644 --- a/arch/arm/mach-ep93xx/gesbc9312.c
> +++ b/arch/arm/mach-ep93xx/gesbc9312.c
> @@ -32,6 +32,7 @@ static void __init gesbc9312_init_machine(void)
>  MACHINE_START(GESBC9312, "Glomation GESBC-9312-sx")
>  	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
>  	.atag_offset	=3D 0x100,
> +	.nr_irqs	=3D NR_EP93XX_IRQS,
>  	.map_io		=3D ep93xx_map_io,
>  	.init_irq	=3D ep93xx_init_irq,
>  	.init_time	=3D ep93xx_timer_init,
> diff --git a/arch/arm/mach-ep93xx/include/mach/irqs.h
> b/arch/arm/mach-ep93xx/irqs.h similarity index 96%
> rename from arch/arm/mach-ep93xx/include/mach/irqs.h
> rename to arch/arm/mach-ep93xx/irqs.h
> index 60c69c4ed7e1..353201b90c66 100644
> --- a/arch/arm/mach-ep93xx/include/mach/irqs.h
> +++ b/arch/arm/mach-ep93xx/irqs.h
> @@ -1,8 +1,4 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * arch/arm/mach-ep93xx/include/mach/irqs.h
> - */
> -
>  #ifndef __ASM_ARCH_IRQS_H
>  #define __ASM_ARCH_IRQS_H
> =20
> @@ -77,7 +73,4 @@
>  #define EP93XX_BOARD_IRQ(x)		(NR_EP93XX_IRQS + (x))
>  #define EP93XX_BOARD_IRQS		32
> =20
> -#define NR_IRQS				(NR_EP93XX_IRQS +
> EP93XX_BOARD_IRQS) -
> -
>  #endif
> diff --git a/arch/arm/mach-ep93xx/micro9.c
> b/arch/arm/mach-ep93xx/micro9.c index e6ead8ded6ee..c121c459aa17
> 100644 --- a/arch/arm/mach-ep93xx/micro9.c
> +++ b/arch/arm/mach-ep93xx/micro9.c
> @@ -76,6 +76,7 @@ static void __init micro9_init_machine(void)
>  MACHINE_START(MICRO9, "Contec Micro9-High")
>  	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at>
> */ .atag_offset	=3D 0x100,
> +	.nr_irqs	=3D NR_EP93XX_IRQS,
>  	.map_io		=3D ep93xx_map_io,
>  	.init_irq	=3D ep93xx_init_irq,
>  	.init_time	=3D ep93xx_timer_init,
> @@ -88,6 +89,7 @@ MACHINE_END
>  MACHINE_START(MICRO9M, "Contec Micro9-Mid")
>  	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at>
> */ .atag_offset	=3D 0x100,
> +	.nr_irqs	=3D NR_EP93XX_IRQS,
>  	.map_io		=3D ep93xx_map_io,
>  	.init_irq	=3D ep93xx_init_irq,
>  	.init_time	=3D ep93xx_timer_init,
> @@ -100,6 +102,7 @@ MACHINE_END
>  MACHINE_START(MICRO9L, "Contec Micro9-Lite")
>  	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at>
> */ .atag_offset	=3D 0x100,
> +	.nr_irqs	=3D NR_EP93XX_IRQS,
>  	.map_io		=3D ep93xx_map_io,
>  	.init_irq	=3D ep93xx_init_irq,
>  	.init_time	=3D ep93xx_timer_init,
> @@ -112,6 +115,7 @@ MACHINE_END
>  MACHINE_START(MICRO9S, "Contec Micro9-Slim")
>  	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at>
> */ .atag_offset	=3D 0x100,
> +	.nr_irqs	=3D NR_EP93XX_IRQS,
>  	.map_io		=3D ep93xx_map_io,
>  	.init_irq	=3D ep93xx_init_irq,
>  	.init_time	=3D ep93xx_timer_init,
> diff --git a/arch/arm/mach-ep93xx/simone.c
> b/arch/arm/mach-ep93xx/simone.c index 5291053023b2..569e72413561
> 100644 --- a/arch/arm/mach-ep93xx/simone.c
> +++ b/arch/arm/mach-ep93xx/simone.c
> @@ -119,6 +119,7 @@ static void __init simone_init_machine(void)
>  MACHINE_START(SIM_ONE, "Simplemachines Sim.One Board")
>  	/* Maintainer: Ryan Mallon */
>  	.atag_offset	=3D 0x100,
> +	.nr_irqs	=3D NR_EP93XX_IRQS,
>  	.map_io		=3D ep93xx_map_io,
>  	.init_irq	=3D ep93xx_init_irq,
>  	.init_time	=3D ep93xx_timer_init,
> diff --git a/arch/arm/mach-ep93xx/snappercl15.c
> b/arch/arm/mach-ep93xx/snappercl15.c index e200d69471e9..1dfb725671b1
> 100644 --- a/arch/arm/mach-ep93xx/snappercl15.c
> +++ b/arch/arm/mach-ep93xx/snappercl15.c
> @@ -153,6 +153,7 @@ static void __init snappercl15_init_machine(void)
>  MACHINE_START(SNAPPER_CL15, "Bluewater Systems Snapper CL15")
>  	/* Maintainer: Ryan Mallon */
>  	.atag_offset	=3D 0x100,
> +	.nr_irqs	=3D NR_EP93XX_IRQS,
>  	.map_io		=3D ep93xx_map_io,
>  	.init_irq	=3D ep93xx_init_irq,
>  	.init_time	=3D ep93xx_timer_init,
> diff --git a/arch/arm/mach-ep93xx/soc.h b/arch/arm/mach-ep93xx/soc.h
> index 94ef7f275f94..f0986e288d19 100644
> --- a/arch/arm/mach-ep93xx/soc.h
> +++ b/arch/arm/mach-ep93xx/soc.h
> @@ -10,6 +10,7 @@
>  #define _EP93XX_SOC_H
> =20
>  #include <mach/ep93xx-regs.h>
> +#include "irqs.h"
> =20
>  /*
>   * EP93xx Physical Memory Map:
> diff --git a/arch/arm/mach-ep93xx/ts72xx.c
> b/arch/arm/mach-ep93xx/ts72xx.c index 12eff8c8074d..e70bac011407
> 100644 --- a/arch/arm/mach-ep93xx/ts72xx.c
> +++ b/arch/arm/mach-ep93xx/ts72xx.c
> @@ -22,7 +22,6 @@
> =20
>  #include "gpio-ep93xx.h"
>  #include "hardware.h"
> -#include <mach/irqs.h>
> =20
>  #include <asm/mach-types.h>
>  #include <asm/mach/map.h>
> @@ -350,6 +349,7 @@ static void __init ts72xx_init_machine(void)
>  MACHINE_START(TS72XX, "Technologic Systems TS-72xx SBC")
>  	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
>  	.atag_offset	=3D 0x100,
> +	.nr_irqs	=3D NR_EP93XX_IRQS,
>  	.map_io		=3D ts72xx_map_io,
>  	.init_irq	=3D ep93xx_init_irq,
>  	.init_time	=3D ep93xx_timer_init,
> @@ -413,6 +413,7 @@ static void __init bk3_init_machine(void)
>  MACHINE_START(BK3, "Liebherr controller BK3.1")
>  	/* Maintainer: Lukasz Majewski <lukma@denx.de> */
>  	.atag_offset	=3D 0x100,
> +	.nr_irqs	=3D NR_EP93XX_IRQS,
>  	.map_io		=3D ts72xx_map_io,
>  	.init_irq	=3D ep93xx_init_irq,
>  	.init_time	=3D ep93xx_timer_init,
> diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c
> b/arch/arm/mach-ep93xx/vision_ep9307.c index
> e46281e60bf7..30d9cf3791eb 100644 ---
> a/arch/arm/mach-ep93xx/vision_ep9307.c +++
> b/arch/arm/mach-ep93xx/vision_ep9307.c @@ -302,6 +302,7 @@ static
> void __init vision_init_machine(void) MACHINE_START(VISION_EP9307,
> "Vision Engraving Systems EP9307") /* Maintainer: H Hartley Sweeten
> <hsweeten@visionengravers.com> */ .atag_offset	=3D 0x100,
> +	.nr_irqs	=3D NR_EP93XX_IRQS + EP93XX_BOARD_IRQS,
>  	.map_io		=3D vision_map_io,
>  	.init_irq	=3D ep93xx_init_irq,
>  	.init_time	=3D ep93xx_timer_init,

Reviewed-by: Lukasz Majewski <lukma@denx.de>


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/efY+hmlk8r0DJR4I.DiqSlM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmJMDyIACgkQAR8vZIA0
zr1prQf+LM4SDlQ/ElhqNkQip7bPDlrhgAJmbSMYaNSDX+cwZONwnlG1y029+V35
pMXY5CtE17krFdsgKcsPwZawe3oOB7rUKdHp/y1uHCT10dfrz3NIl+InCBVUVaZr
I8tKtsLQ0UkAmVGvgtBe//i/jsvjNA53g4dROFx3I45sg5+0JuFd/GEeaMPT0udh
fFXc2sPkiExjJ0+6zpz8Jt5E5ooSB9nwhCJvUclc8P3TK7TniE77xPOUXM+u3mLJ
0JVoWajmNroiX8bI/gdFrBbrMLRct7qLHNNG+SBvNHyukaA0PZA1kF0L2Xn57Z/a
IJ/Zv/EzeEAwYj3VzBCEHOooOvueWg==
=BySi
-----END PGP SIGNATURE-----

--Sig_/efY+hmlk8r0DJR4I.DiqSlM--
