Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F99B570B05
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiGKTzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiGKTzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:55:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2512220CF;
        Mon, 11 Jul 2022 12:55:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E739615E8;
        Mon, 11 Jul 2022 19:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A30C34115;
        Mon, 11 Jul 2022 19:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657569344;
        bh=kNlJIxiwnx/Jz9ORsgKYmrxeQISai+EO3gqqPQ/78Eg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YK11Ds0WgAPE31aa05DI9NWkb41tJs06nL2tpg+c9PEsu9meOdh8K1ee5c+3EZEUs
         eodEovFCBkLAWxg2w4AUFAyOcWm5voEtxh7sqeonMpwKXAbCp++Dg5+LChb9DeHrOG
         nUokUbkwHcIkreBttczalf/8gE51kpSvINZK1GDgH5z2+lJAZsMObcylD93PEnFYyT
         jnJQtedDQ+cNxORe+JVXiRIOArU1XVohf9f4mf2WCbfHWSim7BDW2D92lg8zK5Wahq
         7xAOoeq1+C6aTSfqy01OVHDosQ2zTyUNrGWKFTUuT2o7o4yPNp7U5SdAUZz4rwBkAG
         2TOxC8Pl4zS8w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220711123519.217219-5-tmaimon77@gmail.com>
References: <20220711123519.217219-1-tmaimon77@gmail.com> <20220711123519.217219-5-tmaimon77@gmail.com>
Subject: Re: [PATCH v8 04/16] clk: npcm8xx: add clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tomer Maimon <tmaimon77@gmail.com>
To:     Tomer Maimon <tmaimon77@gmail.com>, arnd@arndb.de,
        avifishman70@gmail.com, benjaminfair@google.com,
        biju.das.jz@bp.renesas.com, bjorn.andersson@linaro.org,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        geert+renesas@glider.be, gregkh@linuxfoundation.org,
        j.neuschaefer@gmx.net, jirislaby@kernel.org, joel@jms.id.au,
        krzysztof.kozlowski+dt@linaro.org, linux@roeck-us.net,
        lkundrak@v3.sk, marcel.ziswiler@toradex.com,
        mturquette@baylibre.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        olof@lixom.net, p.zabel@pengutronix.de, robert.hancock@calian.com,
        robh+dt@kernel.org, shawnguo@kernel.org, tali.perry1@gmail.com,
        tglx@linutronix.de, venture@google.com, vkoul@kernel.org,
        will@kernel.org, wim@linux-watchdog.org, yuenn@google.com
Date:   Mon, 11 Jul 2022 12:55:42 -0700
User-Agent: alot/0.10
Message-Id: <20220711195544.70A30C34115@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tomer Maimon (2022-07-11 05:35:07)
> Nuvoton Arbel BMC NPCM8XX contains an integrated clock controller which
> generates and supplies clocks to all modules within the BMC.
>=20
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  drivers/clk/Kconfig       |   6 +
>  drivers/clk/Makefile      |   1 +
>  drivers/clk/clk-npcm8xx.c | 610 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 617 insertions(+)
>  create mode 100644 drivers/clk/clk-npcm8xx.c
>=20
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 48f8f4221e21..9aa915f6e233 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -428,6 +428,12 @@ config COMMON_CLK_K210
>         help
>           Support for the Canaan Kendryte K210 RISC-V SoC clocks.
> =20
> +config COMMON_CLK_NPCM8XX
> +       tristate "Clock driver for the NPCM8XX SoC Family"
> +       depends on ARCH_NPCM || COMPILE_TEST
> +       help
> +          This driver supports the clocks on the Nuvoton BMC NPCM8XX SoC=
 Family.

Please put this next to COMMON_CLK_NXP so that it is sort of sorted
based on Kconfig symbol.

> +
>  source "drivers/clk/actions/Kconfig"
>  source "drivers/clk/analogbits/Kconfig"
>  source "drivers/clk/baikal-t1/Kconfig"
> diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
> new file mode 100644
> index 000000000000..392f1fbba49b
> --- /dev/null
> +++ b/drivers/clk/clk-npcm8xx.c
> @@ -0,0 +1,610 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Nuvoton NPCM8xx Clock Generator
> + * All the clocks are initialized by the bootloader, so this driver allo=
w only
> + * reading of current settings directly from the hardware.
> + *
> + * Copyright (C) 2020 Nuvoton Technologies
> + * Author: Tomer Maimon <tomer.maimon@nuvoton.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <dt-bindings/clock/nuvoton,npcm845-clk.h>
> +
> +#define NPCM8XX_REF_CLK                25000000
> +
> +struct npcm8xx_clk_pll {
> +       struct clk_hw   hw;
> +       void __iomem    *pllcon;
> +       u8              flags;
> +};
> +
> +#define to_npcm8xx_clk_pll(_hw) container_of(_hw, struct npcm8xx_clk_pll=
, hw)
> +
> +#define PLLCON_LOKI    BIT(31)
> +#define PLLCON_LOKS    BIT(30)
> +#define PLLCON_FBDV    GENMASK(27, 16)
> +#define PLLCON_OTDV2   GENMASK(15, 13)
> +#define PLLCON_PWDEN   BIT(12)
> +#define PLLCON_OTDV1   GENMASK(10, 8)
> +#define PLLCON_INDV    GENMASK(5, 0)
> +
> +static unsigned long npcm8xx_clk_pll_recalc_rate(struct clk_hw *hw,
> +                                                unsigned long parent_rat=
e)
> +{
> +       struct npcm8xx_clk_pll *pll =3D to_npcm8xx_clk_pll(hw);
> +       unsigned long fbdv, indv, otdv1, otdv2;
> +       unsigned int val;
> +       u64 ret;
> +
> +       if (parent_rate =3D=3D 0) {
> +               pr_debug("%s: parent rate is zero\n", __func__);
> +               return 0;
> +       }
> +
> +       val =3D readl_relaxed(pll->pllcon);
> +
> +       indv =3D FIELD_GET(PLLCON_INDV, val);
> +       fbdv =3D FIELD_GET(PLLCON_FBDV, val);
> +       otdv1 =3D FIELD_GET(PLLCON_OTDV1, val);
> +       otdv2 =3D FIELD_GET(PLLCON_OTDV2, val);
> +
> +       ret =3D (u64)parent_rate * fbdv;
> +       do_div(ret, indv * otdv1 * otdv2);
> +
> +       return ret;
> +}
> +
> +static const struct clk_ops npcm8xx_clk_pll_ops =3D {
> +       .recalc_rate =3D npcm8xx_clk_pll_recalc_rate,
> +};
> +
> +static struct clk_hw *
> +npcm8xx_clk_register_pll(struct device *dev, void __iomem *pllcon,
> +                        const char *name, const char *parent_name,
> +                        unsigned long flags)
> +{
> +       struct npcm8xx_clk_pll *pll;
> +       struct clk_init_data init;
> +       struct clk_hw *hw;
> +       int ret;
> +
> +       pll =3D devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
> +       if (!pll)
> +               return ERR_PTR(-ENOMEM);
> +
> +       pr_debug("%s reg, name=3D%s, p=3D%s\n", __func__, name, parent_na=
me);
> +
> +       init.name =3D name;
> +       init.ops =3D &npcm8xx_clk_pll_ops;
> +       init.parent_names =3D &parent_name;
> +       init.num_parents =3D 1;
> +       init.flags =3D flags;
> +
> +       pll->pllcon =3D pllcon;
> +       pll->hw.init =3D &init;
> +
> +       hw =3D &pll->hw;
> +
> +       ret =3D devm_clk_hw_register(dev, hw);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return hw;
> +}
> +
> +#define NPCM8XX_CLKEN1          (0x00)
> +#define NPCM8XX_CLKEN2          (0x28)
> +#define NPCM8XX_CLKEN3          (0x30)
> +#define NPCM8XX_CLKEN4          (0x70)
> +#define NPCM8XX_CLKSEL          (0x04)
> +#define NPCM8XX_CLKDIV1         (0x08)
> +#define NPCM8XX_CLKDIV2         (0x2C)
> +#define NPCM8XX_CLKDIV3         (0x58)
> +#define NPCM8XX_CLKDIV4         (0x7C)
> +#define NPCM8XX_PLLCON0         (0x0C)
> +#define NPCM8XX_PLLCON1         (0x10)
> +#define NPCM8XX_PLLCON2         (0x54)
> +#define NPCM8XX_SWRSTR          (0x14)
> +#define NPCM8XX_IRQWAKECON      (0x18)
> +#define NPCM8XX_IRQWAKEFLAG     (0x1C)
> +#define NPCM8XX_IPSRST1         (0x20)
> +#define NPCM8XX_IPSRST2         (0x24)
> +#define NPCM8XX_IPSRST3         (0x34)
> +#define NPCM8XX_WD0RCR          (0x38)
> +#define NPCM8XX_WD1RCR          (0x3C)
> +#define NPCM8XX_WD2RCR          (0x40)
> +#define NPCM8XX_SWRSTC1         (0x44)
> +#define NPCM8XX_SWRSTC2         (0x48)
> +#define NPCM8XX_SWRSTC3         (0x4C)
> +#define NPCM8XX_SWRSTC4         (0x50)
> +#define NPCM8XX_CORSTC          (0x5C)
> +#define NPCM8XX_PLLCONG         (0x60)
> +#define NPCM8XX_AHBCKFI         (0x64)
> +#define NPCM8XX_SECCNT          (0x68)
> +#define NPCM8XX_CNTR25M         (0x6C)
> +#define NPCM8XX_THRTL_CNT       (0xC0)
> +
> +struct npcm8xx_clk_mux_data {
> +       u8 shift;
> +       u8 mask;
> +       u32 *table;
> +       const char *name;
> +       const char * const *parent_names;
> +       u8 num_parents;
> +       unsigned long flags;
> +       /*
> +        * If this clock is exported via DT, set onecell_idx to constant
> +        * defined in include/dt-bindings/clock/nuvoton, NPCM8XX-clock.h =
for
> +        * this specific clock.  Otherwise, set to -1.
> +        */
> +       int onecell_idx;
> +};
> +
> +struct npcm8xx_clk_div_data {
> +       u32 reg;
> +       u8 shift;
> +       u8 width;
> +       const char *name;
> +       const char *parent_name;
> +       u8 clk_divider_flags;
> +       unsigned long flags;
> +       /*
> +        * If this clock is exported via DT, set onecell_idx to constant
> +        * defined in include/dt-bindings/clock/nuvoton, NPCM8XX-clock.h =
for
> +        * this specific clock.  Otherwise, set to -1.
> +        */
> +       int onecell_idx;
> +};
> +
> +struct npcm8xx_clk_pll_data {
> +       u32 reg;
> +       const char *name;
> +       const char *parent_name;

Any reason why we're not using clk_parent_data or direct clk_hw
pointers?

> +       unsigned long flags;
> +       /*
> +        * If this clock is exported via DT, set onecell_idx to constant
> +        * defined in include/dt-bindings/clock/nuvoton, NPCM8XX-clock.h =
for
> +        * this specific clock.  Otherwise, set to -1.
> +        */
> +       int onecell_idx;
> +};
> +
> +/*
> + * Single copy of strings used to refer to clocks within this driver ind=
exed by
> + * above enum.
> + */
> +#define NPCM8XX_CLK_S_REFCLK      "refclk"
> +#define NPCM8XX_CLK_S_SYSBYPCK    "sysbypck"
> +#define NPCM8XX_CLK_S_MCBYPCK     "mcbypck"
> +#define NPCM8XX_CLK_S_PLL0        "pll0"
> +#define NPCM8XX_CLK_S_PLL1        "pll1"
> +#define NPCM8XX_CLK_S_PLL1_DIV2   "pll1_div2"
> +#define NPCM8XX_CLK_S_PLL2        "pll2"
> +#define NPCM8XX_CLK_S_PLL_GFX     "pll_gfx"
> +#define NPCM8XX_CLK_S_PLL2_DIV2   "pll2_div2"
> +#define NPCM8XX_CLK_S_PIX_MUX     "gfx_pixel"
> +#define NPCM8XX_CLK_S_MC_MUX      "mc_phy"
> +#define NPCM8XX_CLK_S_CPU_MUX     "cpu"  /* AKA system clock */
> +#define NPCM8XX_CLK_S_MC          "mc"
> +#define NPCM8XX_CLK_S_AXI         "axi"  /* AKA CLK2 */
> +#define NPCM8XX_CLK_S_AHB         "ahb"  /* AKA CLK4 */
> +#define NPCM8XX_CLK_S_CLKOUT_MUX  "clkout_mux"
> +#define NPCM8XX_CLK_S_UART_MUX    "uart_mux"
> +#define NPCM8XX_CLK_S_SD_MUX      "sd_mux"
> +#define NPCM8XX_CLK_S_GFXM_MUX    "gfxm_mux"
> +#define NPCM8XX_CLK_S_SU_MUX      "serial_usb_mux"
> +#define NPCM8XX_CLK_S_DVC_MUX     "dvc_mux"
> +#define NPCM8XX_CLK_S_GFX_MUX     "gfx_mux"
> +#define NPCM8XX_CLK_S_ADC_MUX     "adc_mux"
> +#define NPCM8XX_CLK_S_SPI0        "spi0"
> +#define NPCM8XX_CLK_S_SPI1        "spi1"
> +#define NPCM8XX_CLK_S_SPI3        "spi3"
> +#define NPCM8XX_CLK_S_SPIX        "spix"
> +#define NPCM8XX_CLK_S_APB1        "apb1"
> +#define NPCM8XX_CLK_S_APB2        "apb2"
> +#define NPCM8XX_CLK_S_APB3        "apb3"
> +#define NPCM8XX_CLK_S_APB4        "apb4"
> +#define NPCM8XX_CLK_S_APB5        "apb5"
> +#define NPCM8XX_CLK_S_APB19       "apb19"
> +#define NPCM8XX_CLK_S_TOCK        "tock"
> +#define NPCM8XX_CLK_S_CLKOUT      "clkout"
> +#define NPCM8XX_CLK_S_PRE_ADC     "pre adc"
> +#define NPCM8XX_CLK_S_UART        "uart"
> +#define NPCM8XX_CLK_S_UART2       "uart2"
> +#define NPCM8XX_CLK_S_TIMER       "timer"
> +#define NPCM8XX_CLK_S_MMC         "mmc"
> +#define NPCM8XX_CLK_S_SDHC        "sdhc"
> +#define NPCM8XX_CLK_S_ADC         "adc"
> +#define NPCM8XX_CLK_S_GFX         "gfx0_gfx1_mem"
> +#define NPCM8XX_CLK_S_USBIF       "serial_usbif"
> +#define NPCM8XX_CLK_S_USB_HOST    "usb_host"
> +#define NPCM8XX_CLK_S_USB_BRIDGE  "usb_bridge"
> +#define NPCM8XX_CLK_S_PCI         "pci"
> +#define NPCM8XX_CLK_S_TH          "th"
> +#define NPCM8XX_CLK_S_ATB         "atb"
> +#define NPCM8XX_CLK_S_PRE_CLK     "pre_clk"
> +
> +#define NPCM8XX_CLK_S_RG_MUX     "rg_mux"
> +#define NPCM8XX_CLK_S_RCP_MUX    "rcp_mux"
> +#define NPCM8XX_CLK_S_RG         "rg"
> +#define NPCM8XX_CLK_S_RCP        "rcp"
> +
> +static u32 pll_mux_table[] =3D {0, 1, 2, 3};
> +static const char * const pll_mux_parents[] =3D {
> +       NPCM8XX_CLK_S_PLL0,
> +       NPCM8XX_CLK_S_PLL1,
> +       NPCM8XX_CLK_S_REFCLK,
> +       NPCM8XX_CLK_S_PLL2_DIV2,
> +};
> +
> +static u32 cpuck_mux_table[] =3D {0, 1, 2, 3, 7};
> +static const char * const cpuck_mux_parents[] =3D {
> +       NPCM8XX_CLK_S_PLL0,
> +       NPCM8XX_CLK_S_PLL1,
> +       NPCM8XX_CLK_S_REFCLK,
> +       NPCM8XX_CLK_S_SYSBYPCK,
> +       NPCM8XX_CLK_S_PLL2,
> +};
> +
> +static u32 pixcksel_mux_table[] =3D {0, 2};
> +static const char * const pixcksel_mux_parents[] =3D {
> +       NPCM8XX_CLK_S_PLL_GFX,
> +       NPCM8XX_CLK_S_REFCLK,
> +};
> +
> +static u32 sucksel_mux_table[] =3D {2, 3};
> +static const char * const sucksel_mux_parents[] =3D {
> +       NPCM8XX_CLK_S_REFCLK,
> +       NPCM8XX_CLK_S_PLL2_DIV2,
> +};
> +
> +static u32 mccksel_mux_table[] =3D {0, 2, 3};
> +static const char * const mccksel_mux_parents[] =3D {
> +       NPCM8XX_CLK_S_PLL1_DIV2,
> +       NPCM8XX_CLK_S_REFCLK,
> +       NPCM8XX_CLK_S_MCBYPCK,
> +};
> +
> +static u32 clkoutsel_mux_table[] =3D {0, 1, 2, 3, 4};
> +static const char * const clkoutsel_mux_parents[] =3D {
> +       NPCM8XX_CLK_S_PLL0,
> +       NPCM8XX_CLK_S_PLL1,
> +       NPCM8XX_CLK_S_REFCLK,
> +       NPCM8XX_CLK_S_PLL_GFX, // divided by 2
> +       NPCM8XX_CLK_S_PLL2_DIV2,
> +};
> +
> +static u32 gfxmsel_mux_table[] =3D {2, 3};
> +static const char * const gfxmsel_mux_parents[] =3D {
> +       NPCM8XX_CLK_S_REFCLK,
> +       NPCM8XX_CLK_S_PLL2_DIV2,
> +};
> +
> +static u32 dvcssel_mux_table[] =3D {2, 3};
> +static const char * const dvcssel_mux_parents[] =3D {
> +       NPCM8XX_CLK_S_REFCLK,
> +       NPCM8XX_CLK_S_PLL2,
> +};
> +
> +static const struct npcm8xx_clk_pll_data npcm8xx_plls[] =3D {
> +       {NPCM8XX_PLLCON0, NPCM8XX_CLK_S_PLL0, NPCM8XX_CLK_S_REFCLK, 0, -1=
},
> +       {NPCM8XX_PLLCON1, NPCM8XX_CLK_S_PLL1, NPCM8XX_CLK_S_REFCLK, 0, -1=
},
> +       {NPCM8XX_PLLCON2, NPCM8XX_CLK_S_PLL2, NPCM8XX_CLK_S_REFCLK, 0, -1=
},
> +       {NPCM8XX_PLLCONG, NPCM8XX_CLK_S_PLL_GFX, NPCM8XX_CLK_S_REFCLK, 0,=
 -1},
> +};
> +
> +static const struct npcm8xx_clk_mux_data npcm8xx_muxes[] =3D {
> +       {0, GENMASK(1, 0), cpuck_mux_table, NPCM8XX_CLK_S_CPU_MUX,
> +       cpuck_mux_parents, ARRAY_SIZE(cpuck_mux_parents), CLK_IS_CRITICAL,
> +       NPCM8XX_CLK_CPU},
> +
> +       {4, GENMASK(1, 0), pixcksel_mux_table, NPCM8XX_CLK_S_PIX_MUX,
> +       pixcksel_mux_parents, ARRAY_SIZE(pixcksel_mux_parents), 0,
> +       NPCM8XX_CLK_GFX_PIXEL},
> +
> +       {6, GENMASK(1, 0), pll_mux_table, NPCM8XX_CLK_S_SD_MUX,
> +       pll_mux_parents, ARRAY_SIZE(pll_mux_parents), 0, -1},
> +
> +       {8, GENMASK(1, 0), pll_mux_table, NPCM8XX_CLK_S_UART_MUX,
> +       pll_mux_parents, ARRAY_SIZE(pll_mux_parents), 0, -1},
> +
> +       {10, GENMASK(1, 0), sucksel_mux_table, NPCM8XX_CLK_S_SU_MUX,
> +       sucksel_mux_parents, ARRAY_SIZE(sucksel_mux_parents), 0, -1},
> +
> +       {12, GENMASK(1, 0), mccksel_mux_table, NPCM8XX_CLK_S_MC_MUX,
> +       mccksel_mux_parents, ARRAY_SIZE(mccksel_mux_parents), 0, -1},
> +
> +       {14, GENMASK(1, 0), pll_mux_table, NPCM8XX_CLK_S_ADC_MUX,
> +       pll_mux_parents, ARRAY_SIZE(pll_mux_parents), 0, -1},
> +
> +       {16, GENMASK(1, 0), pll_mux_table, NPCM8XX_CLK_S_GFX_MUX,
> +       pll_mux_parents, ARRAY_SIZE(pll_mux_parents), 0, -1},
> +
> +       {18, GENMASK(2, 0), clkoutsel_mux_table, NPCM8XX_CLK_S_CLKOUT_MUX,
> +       clkoutsel_mux_parents, ARRAY_SIZE(clkoutsel_mux_parents), 0, -1},
> +
> +       {21, GENMASK(1, 0), gfxmsel_mux_table, NPCM8XX_CLK_S_GFXM_MUX,
> +       gfxmsel_mux_parents, ARRAY_SIZE(gfxmsel_mux_parents), 0, -1},
> +
> +       {23, GENMASK(1, 0), dvcssel_mux_table, NPCM8XX_CLK_S_DVC_MUX,
> +       dvcssel_mux_parents, ARRAY_SIZE(dvcssel_mux_parents), 0, -1},
> +
> +       {25, GENMASK(1, 0), pll_mux_table, NPCM8XX_CLK_S_RG_MUX,
> +       pll_mux_parents, ARRAY_SIZE(pll_mux_parents), 0, -1},
> +
> +       {27, GENMASK(1, 0), pll_mux_table, NPCM8XX_CLK_S_RCP_MUX,
> +       pll_mux_parents, ARRAY_SIZE(pll_mux_parents), 0, -1},
> +};
> +
> +/* configurable dividers: */
> +static const struct npcm8xx_clk_div_data npcm8xx_divs[] =3D {
> +       {NPCM8XX_CLKDIV1, 28, 3, NPCM8XX_CLK_S_ADC, NPCM8XX_CLK_S_PRE_ADC,
> +               CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0,
> +               NPCM8XX_CLK_ADC},
> +       /* bit 30-28 ADCCKDIV*/
> +       {NPCM8XX_CLKDIV1, 26, 2, NPCM8XX_CLK_S_AHB, NPCM8XX_CLK_S_PRE_CLK,
> +               CLK_DIVIDER_READ_ONLY, CLK_IS_CRITICAL, NPCM8XX_CLK_AHB},
> +       /* bit 28-26 CLK4DIV*/
> +       {NPCM8XX_CLKDIV1, 21, 5, NPCM8XX_CLK_S_PRE_ADC,
> +       NPCM8XX_CLK_S_ADC_MUX, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_PRE_=
ADC},
> +       /* bit 25-21 PRE-ADCCKDIV*/
> +       {NPCM8XX_CLKDIV1, 16, 5, NPCM8XX_CLK_S_UART,
> +       NPCM8XX_CLK_S_UART_MUX, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_UAR=
T},
> +       /* bit 20-16 UARTDIV*/
> +       {NPCM8XX_CLKDIV1, 11, 5, NPCM8XX_CLK_S_MMC,
> +       NPCM8XX_CLK_S_SD_MUX, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_MMC},
> +       /* bit 15-11 MMCCKDIV*/
> +       {NPCM8XX_CLKDIV1, 6, 5, NPCM8XX_CLK_S_SPI3,
> +       NPCM8XX_CLK_S_AHB, 0, 0, NPCM8XX_CLK_SPI3},
> +       /* bit 10-6 AHB3CKDIV*/
> +       {NPCM8XX_CLKDIV1, 2, 4, NPCM8XX_CLK_S_PCI,
> +       NPCM8XX_CLK_S_GFX_MUX, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_PCI},
> +       /* bit 5-2 PCICKDIV*/
> +
> +       {NPCM8XX_CLKDIV2, 30, 2, NPCM8XX_CLK_S_APB4, NPCM8XX_CLK_S_AHB,
> +               CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0,
> +               NPCM8XX_CLK_APB4},
> +       /* bit 31-30 APB4CKDIV*/
> +       {NPCM8XX_CLKDIV2, 28, 2, NPCM8XX_CLK_S_APB3, NPCM8XX_CLK_S_AHB,
> +               CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0,
> +               NPCM8XX_CLK_APB3},
> +       /* bit 29-28 APB3CKDIV*/
> +       {NPCM8XX_CLKDIV2, 26, 2, NPCM8XX_CLK_S_APB2, NPCM8XX_CLK_S_AHB,
> +               CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0,
> +               NPCM8XX_CLK_APB2},
> +       /* bit 28-26 APB2CKDIV*/
> +       {NPCM8XX_CLKDIV2, 24, 2, NPCM8XX_CLK_S_APB1, NPCM8XX_CLK_S_AHB,
> +               CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0,
> +               NPCM8XX_CLK_APB1},
> +       /* bit 25-24 APB1CKDIV*/
> +       {NPCM8XX_CLKDIV2, 22, 2, NPCM8XX_CLK_S_APB5, NPCM8XX_CLK_S_AHB,
> +               CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0,
> +               NPCM8XX_CLK_APB5},
> +       /* bit 23-22 APB5CKDIV*/
> +       {NPCM8XX_CLKDIV2, 16, 5, NPCM8XX_CLK_S_CLKOUT, NPCM8XX_CLK_S_CLKO=
UT_MUX,
> +                CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_CLKOUT},
> +       /* bit 20-16 CLKOUTDIV*/
> +       {NPCM8XX_CLKDIV2, 13, 3, NPCM8XX_CLK_S_GFX, NPCM8XX_CLK_S_GFX_MUX,
> +               CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_GFX},
> +       /* bit 15-13 GFXCKDIV*/
> +       {NPCM8XX_CLKDIV2, 8, 5, NPCM8XX_CLK_S_USB_BRIDGE, NPCM8XX_CLK_S_S=
U_MUX,
> +               CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SU},
> +       /* bit 12-8 SUCKDIV*/
> +       {NPCM8XX_CLKDIV2, 4, 4, NPCM8XX_CLK_S_USB_HOST, NPCM8XX_CLK_S_SU_=
MUX,
> +               CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SU48},
> +       /* bit 8-4 SU48CKDIV*/
> +       {NPCM8XX_CLKDIV2, 0, 4, NPCM8XX_CLK_S_SDHC,
> +       NPCM8XX_CLK_S_SD_MUX, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SDHC}
> +       ,/* bit 3-0 SD1CKDIV*/
> +
> +       {NPCM8XX_CLKDIV3, 16, 8, NPCM8XX_CLK_S_SPI1,
> +       NPCM8XX_CLK_S_AHB, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPI1},
> +       /* bit 23-16 SPI1CKDV*/
> +       {NPCM8XX_CLKDIV3, 11, 5, NPCM8XX_CLK_S_UART2,
> +       NPCM8XX_CLK_S_UART_MUX, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_UAR=
T2},
> +       /* bit 15-11 UARTDIV2*/
> +       {NPCM8XX_CLKDIV3, 6, 5, NPCM8XX_CLK_S_SPI0,

Please run checkpatch, add a space after '{' and before '}'

> +       NPCM8XX_CLK_S_AHB, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPI0},
> +       /* bit 10-6 SPI0CKDV*/
> +       {NPCM8XX_CLKDIV3, 1, 5, NPCM8XX_CLK_S_SPIX,
> +       NPCM8XX_CLK_S_AHB, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPIX},
> +       /* bit 5-1 SPIXCKDV*/
> +
> +       {NPCM8XX_CLKDIV4, 28, 4, NPCM8XX_CLK_S_RG, NPCM8XX_CLK_S_RG_MUX,
> +       CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_RG},
> +       /* bit 31-28 RGREFDIV*/
> +       {NPCM8XX_CLKDIV4, 12, 4, NPCM8XX_CLK_S_RCP, NPCM8XX_CLK_S_RCP_MUX,
> +       CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_RCP},
> +       /* bit 15-12 RCPREFDIV*/
> +       {NPCM8XX_THRTL_CNT, 0, 2, NPCM8XX_CLK_S_TH, NPCM8XX_CLK_S_CPU_MUX,
> +       CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_=
TH},
> +       /* bit 1-0 TH_DIV*/
> +};
> +
> +static DEFINE_SPINLOCK(npcm8xx_clk_lock);
> +
> +static int npcm8xx_clk_probe(struct platform_device *pdev)
> +{
> +       struct clk_hw_onecell_data *npcm8xx_clk_data;
> +       struct device *dev =3D &pdev->dev;
> +       struct device_node *np =3D dev->of_node;
> +       void __iomem *clk_base;
> +       struct resource res;
> +       struct clk_hw *hw;
> +       int i, err;
> +
> +       npcm8xx_clk_data =3D devm_kzalloc(dev, struct_size(npcm8xx_clk_da=
ta, hws,
> +                                                        NPCM8XX_NUM_CLOC=
KS),
> +                                       GFP_KERNEL);
> +       if (!npcm8xx_clk_data)
> +               return -ENOMEM;
> +
> +       err =3D of_address_to_resource(np, 0, &res);

Why can't we use platform_get_resource()?

> +       if (err) {
> +               dev_err(dev, "Failed to get resource, ret %d\n", err);
> +               return err;
> +       }
> +
> +       clk_base =3D ioremap(res.start, resource_size(&res));

And use devm_platform_ioremap_resource()?

> +       if (!clk_base) {
> +               dev_err(&pdev->dev, "Failed to remap I/O memory\n");
> +               return -ENOMEM;
> +       }
> +
> +       npcm8xx_clk_data->num =3D NPCM8XX_NUM_CLOCKS;
> +
> +       for (i =3D 0; i < NPCM8XX_NUM_CLOCKS; i++)
> +               npcm8xx_clk_data->hws[i] =3D ERR_PTR(-EPROBE_DEFER);
> +
> +       /* Reference 25MHz clock */

Does this exist on the board? If so, I'd make a fixed rate clk in the
dts and have 'refclk' be an input in the binding for this clk controller.

> +       hw =3D clk_hw_register_fixed_rate(dev, "refclk", NULL, 0, NPCM8XX=
_REF_CLK);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       npcm8xx_clk_data->hws[NPCM8XX_CLK_REFCLK] =3D hw;
> +
> +       /* Register plls */
> +       for (i =3D 0; i < ARRAY_SIZE(npcm8xx_plls); i++) {
> +               const struct npcm8xx_clk_pll_data *pll_data =3D &npcm8xx_=
plls[i];
> +
> +               hw =3D npcm8xx_clk_register_pll(dev, clk_base + pll_data-=
>reg,
> +                                             pll_data->name,
> +                                             pll_data->parent_name,
> +                                             pll_data->flags);
> +               if (IS_ERR(hw)) {
> +                       dev_err(dev, "npcm8xx_clk: Can't register pll\n");
> +                       goto unregister_refclk;
> +               }
> +
> +               if (pll_data->onecell_idx >=3D 0)
> +                       npcm8xx_clk_data->hws[pll_data->onecell_idx] =3D =
hw;
> +       }
> +
> +       /* Register fixed dividers */
> +       hw =3D devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL1_=
DIV2,
> +                                              NPCM8XX_CLK_S_PLL1, 0, 1, =
2);
> +       if (IS_ERR(hw)) {
> +               dev_err(dev, "npcm8xx_clk: Can't register fixed div\n");
> +               goto unregister_refclk;
> +       }
> +
> +       hw =3D devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL2_=
DIV2,
> +                                              NPCM8XX_CLK_S_PLL2, 0, 1, =
2);
> +       if (IS_ERR(hw)) {
> +               dev_err(dev, "npcm8xx_clk: Can't register pll div2\n");
> +               goto unregister_refclk;
> +       }
> +
> +       hw =3D devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PRE_C=
LK,
> +                                              NPCM8XX_CLK_S_CPU_MUX, 0, =
1, 2);
> +       if (IS_ERR(hw)) {
> +               dev_err(dev, "npcm8xx_clk: Can't register ckclk div2\n");
> +               goto unregister_refclk;
> +       }
> +
> +       hw =3D devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_AXI,
> +                                              NPCM8XX_CLK_S_TH, 0, 1, 2);
> +       if (IS_ERR(hw)) {
> +               dev_err(dev, "npcm8xx_clk: Can't register axi div2\n");
> +               goto unregister_refclk;
> +       }
> +
> +       hw =3D devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_ATB,
> +                                              NPCM8XX_CLK_S_AXI, 0, 1, 2=
);
> +       if (IS_ERR(hw)) {
> +               dev_err(dev, "npcm8xx_clk: Can't register atb div2\n");
> +               goto unregister_refclk;
> +       }
> +
> +       /* Register clock dividers specified in npcm8xx_divs */
> +       for (i =3D 0; i < ARRAY_SIZE(npcm8xx_divs); i++) {
> +               const struct npcm8xx_clk_div_data *div_data =3D &npcm8xx_=
divs[i];
> +
> +               hw =3D devm_clk_hw_register_divider(dev, div_data->name,
> +                                                 div_data->parent_name,
> +                                                 div_data->flags,
> +                                                 clk_base + div_data->re=
g,
> +                                                 div_data->shift,
> +                                                 div_data->width,
> +                                                 div_data->clk_divider_f=
lags,
> +                                                 &npcm8xx_clk_lock);
> +               if (IS_ERR(hw)) {
> +                       dev_err(dev, "npcm8xx_clk: Can't register div tab=
le\n");
> +                       goto unregister_refclk;
> +               }
> +
> +               if (div_data->onecell_idx >=3D 0)
> +                       npcm8xx_clk_data->hws[div_data->onecell_idx] =3D =
hw;
> +       }
> +
> +       /* Register muxes */
> +       for (i =3D 0; i < ARRAY_SIZE(npcm8xx_muxes); i++) {
> +               const struct npcm8xx_clk_mux_data *mux_data =3D &npcm8xx_=
muxes[i];
> +
> +               hw =3D clk_hw_register_mux_table(dev, mux_data->name,
> +                                              mux_data->parent_names,
> +                                              mux_data->num_parents,
> +                                              mux_data->flags,
> +                                              clk_base + NPCM8XX_CLKSEL,
> +                                              mux_data->shift,
> +                                              mux_data->mask, 0,
> +                                              mux_data->table,
> +                                              &npcm8xx_clk_lock);
> +
> +               if (IS_ERR(hw)) {
> +                       dev_err(dev, "npcm8xx_clk: Can't register mux\n");
> +                       goto err_mux_clk;
> +               }
> +
> +               if (mux_data->onecell_idx >=3D 0)
> +                       npcm8xx_clk_data->hws[mux_data->onecell_idx] =3D =
hw;
> +       }
> +
> +       err =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +                                         npcm8xx_clk_data);
> +       if (err) {
> +               dev_err(dev, "unable to add clk provider\n");
> +               goto unregister_refclk;

The 'hw' pointer doesn't contain 'err' here so probe will return some
positive number when this fails?

> +       }
> +
> +       return err;
> +
> +err_mux_clk:
> +       while (i--) {
> +               if (npcm8xx_muxes[i].onecell_idx >=3D 0)
> +                       clk_hw_unregister_mux(npcm8xx_clk_data->hws[npcm8=
xx_muxes[i].onecell_idx]);
> +       }
> +unregister_refclk:
> +       clk_hw_unregister(npcm8xx_clk_data->hws[NPCM8XX_CLK_REFCLK]);
> +       return PTR_ERR(hw);
> +}
> +
> +static const struct of_device_id npcm8xx_clk_dt_ids[] =3D {
> +       { .compatible =3D "nuvoton,npcm845-clk", },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, npcm8xx_clk_dt_ids);
> +
> +static struct platform_driver npcm8xx_clk_driver =3D {
> +       .probe  =3D npcm8xx_clk_probe,
> +       .driver =3D {
> +               .name =3D "npcm8xx_clk",
> +               .of_match_table =3D npcm8xx_clk_dt_ids,
> +       },
> +};
> +
> +static int __init npcm8xx_clk_driver_init(void)
> +{
> +       return platform_driver_register(&npcm8xx_clk_driver);
> +}
> +arch_initcall(npcm8xx_clk_driver_init);
> +

If it can be a module it needs to unregister the driver on module exit.
