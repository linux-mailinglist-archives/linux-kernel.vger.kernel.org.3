Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828204F501A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1840516AbiDFBKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349247AbiDEJt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:49:29 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCF122BDB;
        Tue,  5 Apr 2022 02:43:00 -0700 (PDT)
Received: from ktm (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 112EF807DF;
        Tue,  5 Apr 2022 11:42:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1649151770;
        bh=D8nn68p20zH9IA29cWstg2/uav1hb5K8VVPH0v7EEls=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vMKzt9zYlaHl+ixw2bHKn/r5zqi7riTeWyBzT9s5Rg2z8bhbvgAsatYicfadOP5lS
         9hbejVZejRCPRoTNP1aTvSUQ0ydeB4tuoy1kVlfNgEossiKOI1S3vrOifrXlPo9Qka
         sMPi7FYHJqtSNI0/E0b/kfkEpwijuNT2V9WUeCi2/TlMyBZ1GfGfi6dpQDNk6i8mid
         hwaVxItt6Qwv9N73itgOMsuKUwSV00opFqDlbSxoBqqTjIiuJaoqNELlAoOD6gTeaw
         4fHEVKWtqxOvgPHHVDnqKTBmJQJt7OlwN8Ygq0RtjFsRR4RDEqsx1q/gl97b/O7iix
         aE5zaNS9CsVxg==
Date:   Tue, 5 Apr 2022 11:42:39 +0200
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
Subject: Re: [PATCH 02/12] ARM: ep93xx: renumber interrupts
Message-ID: <20220405114239.6c801983@ktm>
In-Reply-To: <20220405091750.3076973-3-arnd@kernel.org>
References: <20220405091750.3076973-1-arnd@kernel.org>
        <20220405091750.3076973-3-arnd@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/H22OkBcUjFxW3WCVBJL/tlR"; protocol="application/pgp-signature"
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

--Sig_/H22OkBcUjFxW3WCVBJL/tlR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue,  5 Apr 2022 11:17:40 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> With the move to irq domains, no irqchip must start at number 0,
> so shift all the hardwired IRQ numbers by one.
>=20
> Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-ep93xx/core.c              |   4 +-
>  arch/arm/mach-ep93xx/include/mach/irqs.h | 122
> ++++++++++++----------- 2 files changed, 65 insertions(+), 61
> deletions(-)
>=20
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index a3b4e843456a..e4569a5acc3f 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -75,8 +75,8 @@ void __init ep93xx_map_io(void)
>   ***********************************************************************=
**/
>  void __init ep93xx_init_irq(void)
>  {
> -	vic_init(EP93XX_VIC1_BASE, 0, EP93XX_VIC1_VALID_IRQ_MASK, 0);
> -	vic_init(EP93XX_VIC2_BASE, 32, EP93XX_VIC2_VALID_IRQ_MASK,
> 0);
> +	vic_init(EP93XX_VIC1_BASE, IRQ_EP93XX_VIC0,
> EP93XX_VIC1_VALID_IRQ_MASK, 0);
> +	vic_init(EP93XX_VIC2_BASE, IRQ_EP93XX_VIC1,
> EP93XX_VIC2_VALID_IRQ_MASK, 0); }
> =20
> =20
> diff --git a/arch/arm/mach-ep93xx/include/mach/irqs.h
> b/arch/arm/mach-ep93xx/include/mach/irqs.h index
> 244daf83ce6d..60c69c4ed7e1 100644 ---
> a/arch/arm/mach-ep93xx/include/mach/irqs.h +++
> b/arch/arm/mach-ep93xx/include/mach/irqs.h @@ -6,69 +6,73 @@
>  #ifndef __ASM_ARCH_IRQS_H
>  #define __ASM_ARCH_IRQS_H
> =20
> -#define IRQ_EP93XX_COMMRX		2
> -#define IRQ_EP93XX_COMMTX		3
> -#define IRQ_EP93XX_TIMER1		4
> -#define IRQ_EP93XX_TIMER2		5
> -#define IRQ_EP93XX_AACINTR		6
> -#define IRQ_EP93XX_DMAM2P0		7
> -#define IRQ_EP93XX_DMAM2P1		8
> -#define IRQ_EP93XX_DMAM2P2		9
> -#define IRQ_EP93XX_DMAM2P3		10
> -#define IRQ_EP93XX_DMAM2P4		11
> -#define IRQ_EP93XX_DMAM2P5		12
> -#define IRQ_EP93XX_DMAM2P6		13
> -#define IRQ_EP93XX_DMAM2P7		14
> -#define IRQ_EP93XX_DMAM2P8		15
> -#define IRQ_EP93XX_DMAM2P9		16
> -#define IRQ_EP93XX_DMAM2M0		17
> -#define IRQ_EP93XX_DMAM2M1		18
> -#define IRQ_EP93XX_GPIO0MUX		19
> -#define IRQ_EP93XX_GPIO1MUX		20
> -#define IRQ_EP93XX_GPIO2MUX		21
> -#define IRQ_EP93XX_GPIO3MUX		22
> -#define IRQ_EP93XX_UART1RX		23
> -#define IRQ_EP93XX_UART1TX		24
> -#define IRQ_EP93XX_UART2RX		25
> -#define IRQ_EP93XX_UART2TX		26
> -#define IRQ_EP93XX_UART3RX		27
> -#define IRQ_EP93XX_UART3TX		28
> -#define IRQ_EP93XX_KEY			29
> -#define IRQ_EP93XX_TOUCH		30
> +#define IRQ_EP93XX_VIC0			1
> +
> +#define IRQ_EP93XX_COMMRX		(IRQ_EP93XX_VIC0 + 2)
> +#define IRQ_EP93XX_COMMTX		(IRQ_EP93XX_VIC0 + 3)
> +#define IRQ_EP93XX_TIMER1		(IRQ_EP93XX_VIC0 + 4)
> +#define IRQ_EP93XX_TIMER2		(IRQ_EP93XX_VIC0 + 5)
> +#define IRQ_EP93XX_AACINTR		(IRQ_EP93XX_VIC0 + 6)
> +#define IRQ_EP93XX_DMAM2P0		(IRQ_EP93XX_VIC0 + 7)
> +#define IRQ_EP93XX_DMAM2P1		(IRQ_EP93XX_VIC0 + 8)
> +#define IRQ_EP93XX_DMAM2P2		(IRQ_EP93XX_VIC0 + 9)
> +#define IRQ_EP93XX_DMAM2P3		(IRQ_EP93XX_VIC0 + 10)
> +#define IRQ_EP93XX_DMAM2P4		(IRQ_EP93XX_VIC0 + 11)
> +#define IRQ_EP93XX_DMAM2P5		(IRQ_EP93XX_VIC0 + 12)
> +#define IRQ_EP93XX_DMAM2P6		(IRQ_EP93XX_VIC0 + 13)
> +#define IRQ_EP93XX_DMAM2P7		(IRQ_EP93XX_VIC0 + 14)
> +#define IRQ_EP93XX_DMAM2P8		(IRQ_EP93XX_VIC0 + 15)
> +#define IRQ_EP93XX_DMAM2P9		(IRQ_EP93XX_VIC0 + 16)
> +#define IRQ_EP93XX_DMAM2M0		(IRQ_EP93XX_VIC0 + 17)
> +#define IRQ_EP93XX_DMAM2M1		(IRQ_EP93XX_VIC0 + 18)
> +#define IRQ_EP93XX_GPIO0MUX		(IRQ_EP93XX_VIC0 + 19)
> +#define IRQ_EP93XX_GPIO1MUX		(IRQ_EP93XX_VIC0 + 20)
> +#define IRQ_EP93XX_GPIO2MUX		(IRQ_EP93XX_VIC0 + 21)
> +#define IRQ_EP93XX_GPIO3MUX		(IRQ_EP93XX_VIC0 + 22)
> +#define IRQ_EP93XX_UART1RX		(IRQ_EP93XX_VIC0 + 23)
> +#define IRQ_EP93XX_UART1TX		(IRQ_EP93XX_VIC0 + 24)
> +#define IRQ_EP93XX_UART2RX		(IRQ_EP93XX_VIC0 + 25)
> +#define IRQ_EP93XX_UART2TX		(IRQ_EP93XX_VIC0 + 26)
> +#define IRQ_EP93XX_UART3RX		(IRQ_EP93XX_VIC0 + 27)
> +#define IRQ_EP93XX_UART3TX		(IRQ_EP93XX_VIC0 + 28)
> +#define IRQ_EP93XX_KEY			(IRQ_EP93XX_VIC0 + 29)
> +#define IRQ_EP93XX_TOUCH		(IRQ_EP93XX_VIC0 + 30)
>  #define EP93XX_VIC1_VALID_IRQ_MASK	0x7ffffffc
> =20
> -#define IRQ_EP93XX_EXT0			32
> -#define IRQ_EP93XX_EXT1			33
> -#define IRQ_EP93XX_EXT2			34
> -#define IRQ_EP93XX_64HZ			35
> -#define IRQ_EP93XX_WATCHDOG		36
> -#define IRQ_EP93XX_RTC			37
> -#define IRQ_EP93XX_IRDA			38
> -#define IRQ_EP93XX_ETHERNET		39
> -#define IRQ_EP93XX_EXT3			40
> -#define IRQ_EP93XX_PROG			41
> -#define IRQ_EP93XX_1HZ			42
> -#define IRQ_EP93XX_VSYNC		43
> -#define IRQ_EP93XX_VIDEO_FIFO		44
> -#define IRQ_EP93XX_SSP1RX		45
> -#define IRQ_EP93XX_SSP1TX		46
> -#define IRQ_EP93XX_GPIO4MUX		47
> -#define IRQ_EP93XX_GPIO5MUX		48
> -#define IRQ_EP93XX_GPIO6MUX		49
> -#define IRQ_EP93XX_GPIO7MUX		50
> -#define IRQ_EP93XX_TIMER3		51
> -#define IRQ_EP93XX_UART1		52
> -#define IRQ_EP93XX_SSP			53
> -#define IRQ_EP93XX_UART2		54
> -#define IRQ_EP93XX_UART3		55
> -#define IRQ_EP93XX_USB			56
> -#define IRQ_EP93XX_ETHERNET_PME		57
> -#define IRQ_EP93XX_DSP			58
> -#define IRQ_EP93XX_GPIO_AB		59
> -#define IRQ_EP93XX_SAI			60
> +#define IRQ_EP93XX_VIC1			(IRQ_EP93XX_VIC0 + 32)
> +
> +#define IRQ_EP93XX_EXT0			(IRQ_EP93XX_VIC1 + 0)
> +#define IRQ_EP93XX_EXT1			(IRQ_EP93XX_VIC1 + 1)
> +#define IRQ_EP93XX_EXT2			(IRQ_EP93XX_VIC1 + 2)
> +#define IRQ_EP93XX_64HZ			(IRQ_EP93XX_VIC1 + 3)
> +#define IRQ_EP93XX_WATCHDOG		(IRQ_EP93XX_VIC1 + 4)
> +#define IRQ_EP93XX_RTC			(IRQ_EP93XX_VIC1 + 5)
> +#define IRQ_EP93XX_IRDA			(IRQ_EP93XX_VIC1 + 6)
> +#define IRQ_EP93XX_ETHERNET		(IRQ_EP93XX_VIC1 + 7)
> +#define IRQ_EP93XX_EXT3			(IRQ_EP93XX_VIC1 + 8)
> +#define IRQ_EP93XX_PROG			(IRQ_EP93XX_VIC1 + 9)
> +#define IRQ_EP93XX_1HZ			(IRQ_EP93XX_VIC1 + 10)
> +#define IRQ_EP93XX_VSYNC		(IRQ_EP93XX_VIC1 + 11)
> +#define IRQ_EP93XX_VIDEO_FIFO		(IRQ_EP93XX_VIC1 + 12)
> +#define IRQ_EP93XX_SSP1RX		(IRQ_EP93XX_VIC1 + 13)
> +#define IRQ_EP93XX_SSP1TX		(IRQ_EP93XX_VIC1 + 14)
> +#define IRQ_EP93XX_GPIO4MUX		(IRQ_EP93XX_VIC1 + 15)
> +#define IRQ_EP93XX_GPIO5MUX		(IRQ_EP93XX_VIC1 + 16)
> +#define IRQ_EP93XX_GPIO6MUX		(IRQ_EP93XX_VIC1 + 17)
> +#define IRQ_EP93XX_GPIO7MUX		(IRQ_EP93XX_VIC1 + 18)
> +#define IRQ_EP93XX_TIMER3		(IRQ_EP93XX_VIC1 + 19)
> +#define IRQ_EP93XX_UART1		(IRQ_EP93XX_VIC1 + 20)
> +#define IRQ_EP93XX_SSP			(IRQ_EP93XX_VIC1 + 21)
> +#define IRQ_EP93XX_UART2		(IRQ_EP93XX_VIC1 + 22)
> +#define IRQ_EP93XX_UART3		(IRQ_EP93XX_VIC1 + 23)
> +#define IRQ_EP93XX_USB			(IRQ_EP93XX_VIC1 + 24)
> +#define IRQ_EP93XX_ETHERNET_PME		(IRQ_EP93XX_VIC1 + 25)
> +#define IRQ_EP93XX_DSP			(IRQ_EP93XX_VIC1 + 26)
> +#define IRQ_EP93XX_GPIO_AB		(IRQ_EP93XX_VIC1 + 27)
> +#define IRQ_EP93XX_SAI			(IRQ_EP93XX_VIC1 + 28)
>  #define EP93XX_VIC2_VALID_IRQ_MASK	0x1fffffff
> =20
> -#define NR_EP93XX_IRQS			(64 + 24)
> +#define NR_EP93XX_IRQS			(IRQ_EP93XX_VIC1 + 32
> + 24)=20
>  #define EP93XX_BOARD_IRQ(x)		(NR_EP93XX_IRQS + (x))
>  #define EP93XX_BOARD_IRQS		32

Reviewed-by: Lukasz Majewski <lukma@denx.de>


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/H22OkBcUjFxW3WCVBJL/tlR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmJMDw8ACgkQAR8vZIA0
zr1SOAf8C3tls/6WR7Qy5iXu9WsEcgIEPTbRrhygLqd0tUh/tVFB4wcJ12aZH7Lg
MNAjl+U2OakSR/uDzz3yp6XBuyefC6yXeOOzFcTC/LR9Ej6JiOesx0iFwDC/ZcLR
IGdZfK9NTEoz+FrlVsx3GHYjKJqlC24EhSP+K0AUi8S4OPrqXFcrVDY6Lr+gY1RR
4twWwhdtgfk3hxHfcQwxgU4ixjaTvcTE11noapfPl9NpGGOyBeI94l+do1+tDVNH
RZK6mqc7xUBV7bzLvfF1FUpMabDf9t9slrhCHy35QXPMd/xHUfAPQjE+Da+dAcyp
ahfdu0NW55neEu2FtbMC8kdfmIH/3Q==
=VhiN
-----END PGP SIGNATURE-----

--Sig_/H22OkBcUjFxW3WCVBJL/tlR--
