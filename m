Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ED85391E8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344799AbiEaNjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344784AbiEaNjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:39:13 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51E64A3FD
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:39:09 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id l13so21424471lfp.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=btwuVJJduXqnSF+V3q9iWM5+3Zcv1LxijPuc1zWO+QY=;
        b=uKhctOJtyOqlllbp7ZuR/rKBTZU6dNQImP4sfCHCccVv1N3fYshhztRbeJ6xzp++n4
         GRsSAk6j/GDUkQ8Jjo3vhkaPDbPPSfL8XMfTLZxJIBZf23Cpx4S6F2azLOaMWT/V52ji
         4gQZSJW5edRgVQqzZM4mt31K5NpSUIevwjkLR7yxQ8hsFdi+I3Epa0cdR5oWWrGW222j
         m4p0UAqEFG/8PjpvOAnCpEjGSN/wCWbetVnyc/yeBi0YU4iFFSBlIf1beOOpi7a1rAlH
         /pMLdaZ3AB8HV5t+BdDPcp/rdFE99OWQe7Mf+t6VJcK1rgkxWxD65tBGR/9u165QeMQZ
         4PrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btwuVJJduXqnSF+V3q9iWM5+3Zcv1LxijPuc1zWO+QY=;
        b=gPoLLH4QxgY1Ug7x2OHqHL+nGg+ptc0FaUiSak240+92Eww8uzJToHTcd1PgJJgc2L
         COTIMqvHwrD37zL8bPnyRRQ3Ze58yfG4f9asuvFEL+tMUvqoCTM22SJsEbixtTnQLKOD
         q5gkSATcTdwYkCBkTNwy7itvHiR8lpmoH0tr0zSN7Y1DnEeLKies2FrkOmW0UMsP4EIj
         fXKgbRNoCPG3tX+3AqDe79jUWlI6mltpjoZPywlq2QWRBe9BLHDEZ3JNaTeWmtMPS88p
         Md1mTXe2/jF1x73jAf2SN/X5IKjFod7chvTZvnKALttkeVxeEPV0xWMzPJhruUT90gN4
         geJA==
X-Gm-Message-State: AOAM533nV/w8JfgD6tBBYkJEWv58fORkaf84DRP0vNToD0RhS25Y3Ukq
        90IbqROazVFF6EKwHdAVoSmKASKCCrJOISUvl/iGxA==
X-Google-Smtp-Source: ABdhPJyS7PTt0N0HtvrZ/AHpf3/+02IhL+tURlHL/v4I42sP5oUvgNqJquz4RBjGLlnajYVPp4XQjzbTvKusuE3JJq4=
X-Received: by 2002:a05:6512:e93:b0:478:70ed:6dfb with SMTP id
 bi19-20020a0565120e9300b0047870ed6dfbmr29507089lfb.358.1654004348038; Tue, 31
 May 2022 06:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220504213251.264819-1-sebastian.reichel@collabora.com> <20220504213251.264819-12-sebastian.reichel@collabora.com>
In-Reply-To: <20220504213251.264819-12-sebastian.reichel@collabora.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 31 May 2022 15:38:31 +0200
Message-ID: <CAPDyKFo5RRXZncZHHCs=yN11pvW8HakpOAp+2Qfc9QVWimJQug@mail.gmail.com>
Subject: Re: [PATCHv2 11/21] mmc: sdhci-of-dwcmshc: add support for rk3588
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2022 at 23:33, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> From: Yifeng Zhao <yifeng.zhao@rock-chips.com>
>
> Add support for RK3588's DWCMSHC controller, which is used for
> providing the rootfs on the RK3588 evaluation board.
>
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> [port from vendor BSP]
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Queued for v5.20 on the devel branch, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 121 +++++++++++++++++++++++-----
>  1 file changed, 103 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index f5fd88c7adef..4e904850973c 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -31,6 +31,7 @@
>  /* Offset inside the  vendor area 1 */
>  #define DWCMSHC_HOST_CTRL3             0x8
>  #define DWCMSHC_EMMC_CONTROL           0x2c
> +#define DWCMSHC_CARD_IS_EMMC           BIT(0)
>  #define DWCMSHC_ENHANCED_STROBE                BIT(8)
>  #define DWCMSHC_EMMC_ATCTRL            0x40
>
> @@ -39,7 +40,7 @@
>  #define DWCMSHC_EMMC_DLL_RXCLK         0x804
>  #define DWCMSHC_EMMC_DLL_TXCLK         0x808
>  #define DWCMSHC_EMMC_DLL_STRBIN                0x80c
> -#define DLL_STRBIN_TAPNUM_FROM_SW      BIT(24)
> +#define DECMSHC_EMMC_DLL_CMDOUT                0x810
>  #define DWCMSHC_EMMC_DLL_STATUS0       0x840
>  #define DWCMSHC_EMMC_DLL_START         BIT(0)
>  #define DWCMSHC_EMMC_DLL_LOCKED                BIT(8)
> @@ -48,11 +49,21 @@
>  #define DWCMSHC_EMMC_DLL_START_POINT   16
>  #define DWCMSHC_EMMC_DLL_INC           8
>  #define DWCMSHC_EMMC_DLL_DLYENA                BIT(27)
> -#define DLL_TXCLK_TAPNUM_DEFAULT       0x8
> -#define DLL_STRBIN_TAPNUM_DEFAULT      0x8
> +#define DLL_TXCLK_TAPNUM_DEFAULT       0x10
> +#define DLL_TXCLK_TAPNUM_90_DEGREES    0xA
>  #define DLL_TXCLK_TAPNUM_FROM_SW       BIT(24)
> +#define DLL_STRBIN_TAPNUM_DEFAULT      0x8
> +#define DLL_STRBIN_TAPNUM_FROM_SW      BIT(24)
> +#define DLL_STRBIN_DELAY_NUM_SEL       BIT(26)
> +#define DLL_STRBIN_DELAY_NUM_OFFSET    16
> +#define DLL_STRBIN_DELAY_NUM_DEFAULT   0x16
>  #define DLL_RXCLK_NO_INVERTER          1
>  #define DLL_RXCLK_INVERTER             0
> +#define DLL_CMDOUT_TAPNUM_90_DEGREES   0x8
> +#define DLL_CMDOUT_TAPNUM_FROM_SW      BIT(24)
> +#define DLL_CMDOUT_SRC_CLK_NEG         BIT(28)
> +#define DLL_CMDOUT_EN_SRC_CLK_NEG      BIT(29)
> +
>  #define DLL_LOCK_WO_TMOUT(x) \
>         ((((x) & DWCMSHC_EMMC_DLL_LOCKED) == DWCMSHC_EMMC_DLL_LOCKED) && \
>         (((x) & DWCMSHC_EMMC_DLL_TIMEOUT) == 0))
> @@ -61,10 +72,16 @@
>  #define BOUNDARY_OK(addr, len) \
>         ((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
>
> +enum dwcmshc_rk_type {
> +       DWCMSHC_RK3568,
> +       DWCMSHC_RK3588,
> +};
> +
>  struct rk35xx_priv {
>         /* Rockchip specified optional clocks */
>         struct clk_bulk_data rockchip_clks[RK35xx_MAX_CLKS];
>         struct reset_control *reset;
> +       enum dwcmshc_rk_type devtype;
>         u8 txclk_tapnum;
>  };
>
> @@ -133,7 +150,9 @@ static void dwcmshc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
>                                       unsigned int timing)
>  {
> -       u16 ctrl_2;
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +       u16 ctrl, ctrl_2;
>
>         ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>         /* Select Bus Speed Mode for host */
> @@ -151,8 +170,15 @@ static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
>         else if ((timing == MMC_TIMING_UHS_DDR50) ||
>                  (timing == MMC_TIMING_MMC_DDR52))
>                 ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
> -       else if (timing == MMC_TIMING_MMC_HS400)
> +       else if (timing == MMC_TIMING_MMC_HS400) {
> +               /* set CARD_IS_EMMC bit to enable Data Strobe for HS400 */
> +               ctrl = sdhci_readw(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> +               ctrl |= DWCMSHC_CARD_IS_EMMC;
> +               sdhci_writew(host, ctrl, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> +
>                 ctrl_2 |= DWCMSHC_CTRL_HS400;
> +       }
> +
>         sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>  }
>
> @@ -185,17 +211,11 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>
>         host->mmc->actual_clock = 0;
>
> -       /*
> -        * DO NOT TOUCH THIS SETTING. RX clk inverter unit is enabled
> -        * by default, but it shouldn't be enabled. We should anyway
> -        * disable it before issuing any cmds.
> -        */
> -       extra = DWCMSHC_EMMC_DLL_DLYENA |
> -               DLL_RXCLK_NO_INVERTER << DWCMSHC_EMMC_DLL_RXCLK_SRCSEL;
> -       sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_RXCLK);
> -
> -       if (clock == 0)
> +       if (clock == 0) {
> +               /* Disable interface clock at initial state. */
> +               sdhci_set_clock(host, clock);
>                 return;
> +       }
>
>         /* Rockchip platform only support 375KHz for identify mode */
>         if (clock <= 400000)
> @@ -213,9 +233,21 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>         extra &= ~BIT(0);
>         sdhci_writel(host, extra, reg);
>
> -       if (clock <= 400000) {
> -               /* Disable DLL to reset sample clock */
> +       if (clock <= 52000000) {
> +               /* Disable DLL and reset both of sample and drive clock */
>                 sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_CTRL);
> +               sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_RXCLK);
> +               sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
> +               sdhci_writel(host, 0, DECMSHC_EMMC_DLL_CMDOUT);
> +               /*
> +                * Before switching to hs400es mode, the driver will enable
> +                * enhanced strobe first. PHY needs to configure the parameters
> +                * of enhanced strobe first.
> +                */
> +               extra = DWCMSHC_EMMC_DLL_DLYENA |
> +                       DLL_STRBIN_DELAY_NUM_SEL |
> +                       DLL_STRBIN_DELAY_NUM_DEFAULT << DLL_STRBIN_DELAY_NUM_OFFSET;
> +               sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
>                 return;
>         }
>
> @@ -224,6 +256,15 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>         udelay(1);
>         sdhci_writel(host, 0x0, DWCMSHC_EMMC_DLL_CTRL);
>
> +       /*
> +        * We shouldn't set DLL_RXCLK_NO_INVERTER for identify mode but
> +        * we must set it in higher speed mode.
> +        */
> +       extra = DWCMSHC_EMMC_DLL_DLYENA;
> +       if (priv->devtype == DWCMSHC_RK3568)
> +               extra |= DLL_RXCLK_NO_INVERTER << DWCMSHC_EMMC_DLL_RXCLK_SRCSEL;
> +       sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_RXCLK);
> +
>         /* Init DLL settings */
>         extra = 0x5 << DWCMSHC_EMMC_DLL_START_POINT |
>                 0x2 << DWCMSHC_EMMC_DLL_INC |
> @@ -246,8 +287,20 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>             host->mmc->ios.timing == MMC_TIMING_MMC_HS400)
>                 txclk_tapnum = priv->txclk_tapnum;
>
> +       if ((priv->devtype == DWCMSHC_RK3588) && host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
> +               txclk_tapnum = DLL_TXCLK_TAPNUM_90_DEGREES;
> +
> +               extra = DLL_CMDOUT_SRC_CLK_NEG |
> +                       DLL_CMDOUT_EN_SRC_CLK_NEG |
> +                       DWCMSHC_EMMC_DLL_DLYENA |
> +                       DLL_CMDOUT_TAPNUM_90_DEGREES |
> +                       DLL_CMDOUT_TAPNUM_FROM_SW;
> +               sdhci_writel(host, extra, DECMSHC_EMMC_DLL_CMDOUT);
> +       }
> +
>         extra = DWCMSHC_EMMC_DLL_DLYENA |
>                 DLL_TXCLK_TAPNUM_FROM_SW |
> +               DLL_RXCLK_NO_INVERTER << DWCMSHC_EMMC_DLL_RXCLK_SRCSEL |
>                 txclk_tapnum;
>         sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_TXCLK);
>
> @@ -345,7 +398,25 @@ static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
>         return 0;
>  }
>
> +static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
> +{
> +       /*
> +        * Don't support highspeed bus mode with low clk speed as we
> +        * cannot use DLL for this condition.
> +        */
> +       if (host->mmc->f_max <= 52000000) {
> +               dev_info(mmc_dev(host->mmc), "Disabling HS200/HS400, frequency too low (%d)\n",
> +                        host->mmc->f_max);
> +               host->mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400);
> +               host->mmc->caps &= ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR);
> +       }
> +}
> +
>  static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
> +       {
> +               .compatible = "rockchip,rk3588-dwcmshc",
> +               .data = &sdhci_dwcmshc_rk35xx_pdata,
> +       },
>         {
>                 .compatible = "rockchip,rk3568-dwcmshc",
>                 .data = &sdhci_dwcmshc_rk35xx_pdata,
> @@ -433,6 +504,11 @@ static int dwcmshc_probe(struct platform_device *pdev)
>                         goto err_clk;
>                 }
>
> +               if (of_device_is_compatible(pdev->dev.of_node, "rockchip,rk3588-dwcmshc"))
> +                       rk_priv->devtype = DWCMSHC_RK3588;
> +               else
> +                       rk_priv->devtype = DWCMSHC_RK3568;
> +
>                 priv->priv = rk_priv;
>
>                 err = dwcmshc_rk35xx_init(host, priv);
> @@ -442,12 +518,21 @@ static int dwcmshc_probe(struct platform_device *pdev)
>
>         host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>
> -       err = sdhci_add_host(host);
> +       err = sdhci_setup_host(host);
>         if (err)
>                 goto err_clk;
>
> +       if (rk_priv)
> +               dwcmshc_rk35xx_postinit(host, priv);
> +
> +       err = __sdhci_add_host(host);
> +       if (err)
> +               goto err_setup_host;
> +
>         return 0;
>
> +err_setup_host:
> +       sdhci_cleanup_host(host);
>  err_clk:
>         clk_disable_unprepare(pltfm_host->clk);
>         clk_disable_unprepare(priv->bus_clk);
> --
> 2.35.1
>
