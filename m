Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734BE5391E6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344782AbiEaNjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344767AbiEaNjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:39:08 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBC0692AD
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:39:06 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id a23so14700589ljd.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z7akxYTZO1n5hGBdUKvsACb0aYZqvZd4WKpx24anh2Q=;
        b=aVqK+eGh6U5ZxN+/sy3i1jQIg0aI5Zf42/qEDr8+QPva7b2fcH5Hjoufp+S6xhZUi4
         w1rYm2d+oiAYiXy9cZFb/SB8athYS19y3tN/mNGCyaitQwLzqetMbSrt/Xac5zAmtiy3
         Kt1nMbAQI/++3zCPjq4FDIej1nHrPLrFTMPWw9aJv/K7DWW7FUt3ThmI9LzT2H+mqGiP
         +aRcv7BZE78HMfrFJIIA6/QykQAs3hb6dpO62gJ3bT5AVo3VRXycRxFC87ss/2N6NLoj
         yYcm3JdMgHzwPe8Qi7Mu1JBXkuo+qxLDNo6JZsH0Hzm7bZe3x1oN1c22UqebB72A6NeP
         qSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z7akxYTZO1n5hGBdUKvsACb0aYZqvZd4WKpx24anh2Q=;
        b=7N90Ap6tVu+xN5tYfvGncqKuGZX46St0Mbl5o9QL/Pr80dTB/bTO7uAPW4qEG0tUH5
         mNF2T/IZA4cB/QAG1PeWvSvjzzxlZpA18MGn8KAcWymQDOWZNGCYrfpTN5mkBOxL0ZEN
         1G0Bx98NXwESsU+fYi7IH7zbaSdRXOSmZ28wT4JYpVREx1YSLvDMyMFzIh2EF3y4Cd4/
         g32Rv/Wv+bHsIztT5ESjPXMEFlCeARVNswkd2Kd5LdgD5B5OD3HWZW0MlJJgafyYRxmy
         BlrhAvvh2WnSY5p+mOxmDaSTvE7ajLBpOLc9s6vOE7bF1YOxJli23y0PySTr1z4WBAmz
         OdYg==
X-Gm-Message-State: AOAM531gh6f3LRa41mTr83Bbpygn6Y5BCN/VWSAKNOWXwERaErj44sek
        7Tulg3fVouoOieZJKfv15Vp1VfZztny3oWTlDmhnQg==
X-Google-Smtp-Source: ABdhPJwW/c1bJlMkiebT8YPGfe/ycmePS1OwkzMEJRtOVwabPwHajbg7juGNK47YLhhdudVJ1MU5aii5JNigtMjXGDs=
X-Received: by 2002:a05:651c:158e:b0:253:d4c5:86f3 with SMTP id
 h14-20020a05651c158e00b00253d4c586f3mr34451417ljq.273.1654004344325; Tue, 31
 May 2022 06:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220504213251.264819-1-sebastian.reichel@collabora.com> <20220504213251.264819-11-sebastian.reichel@collabora.com>
In-Reply-To: <20220504213251.264819-11-sebastian.reichel@collabora.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 31 May 2022 15:38:28 +0200
Message-ID: <CAPDyKFo2EANj+HSEX=g9Vu9vgPPFgkdnT-vRvToZK-brNiO5cQ@mail.gmail.com>
Subject: Re: [PATCHv2 10/21] mmc: sdhci-of-dwcmshc: rename rk3568 to rk35xx
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
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2022 at 23:33, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Prepare driver for rk3588 support by renaming the internal data
> structures.
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Queued for v5.20 on the devel branch, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 46 ++++++++++++++---------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 3a1b5ba36405..f5fd88c7adef 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -56,14 +56,14 @@
>  #define DLL_LOCK_WO_TMOUT(x) \
>         ((((x) & DWCMSHC_EMMC_DLL_LOCKED) == DWCMSHC_EMMC_DLL_LOCKED) && \
>         (((x) & DWCMSHC_EMMC_DLL_TIMEOUT) == 0))
> -#define RK3568_MAX_CLKS 3
> +#define RK35xx_MAX_CLKS 3
>
>  #define BOUNDARY_OK(addr, len) \
>         ((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
>
> -struct rk3568_priv {
> +struct rk35xx_priv {
>         /* Rockchip specified optional clocks */
> -       struct clk_bulk_data rockchip_clks[RK3568_MAX_CLKS];
> +       struct clk_bulk_data rockchip_clks[RK35xx_MAX_CLKS];
>         struct reset_control *reset;
>         u8 txclk_tapnum;
>  };
> @@ -178,7 +178,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> -       struct rk3568_priv *priv = dwc_priv->priv;
> +       struct rk35xx_priv *priv = dwc_priv->priv;
>         u8 txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
>         u32 extra, reg;
>         int err;
> @@ -281,7 +281,7 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
>         .adma_write_desc        = dwcmshc_adma_write_desc,
>  };
>
> -static const struct sdhci_ops sdhci_dwcmshc_rk3568_ops = {
> +static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
>         .set_clock              = dwcmshc_rk3568_set_clock,
>         .set_bus_width          = sdhci_set_bus_width,
>         .set_uhs_signaling      = dwcmshc_set_uhs_signaling,
> @@ -296,18 +296,18 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
>         .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>
> -static const struct sdhci_pltfm_data sdhci_dwcmshc_rk3568_pdata = {
> -       .ops = &sdhci_dwcmshc_rk3568_ops,
> +static const struct sdhci_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
> +       .ops = &sdhci_dwcmshc_rk35xx_ops,
>         .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
>                   SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
>         .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>                    SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>  };
>
> -static int dwcmshc_rk3568_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
> +static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
>  {
>         int err;
> -       struct rk3568_priv *priv = dwc_priv->priv;
> +       struct rk35xx_priv *priv = dwc_priv->priv;
>
>         priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
>         if (IS_ERR(priv->reset)) {
> @@ -319,14 +319,14 @@ static int dwcmshc_rk3568_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
>         priv->rockchip_clks[0].id = "axi";
>         priv->rockchip_clks[1].id = "block";
>         priv->rockchip_clks[2].id = "timer";
> -       err = devm_clk_bulk_get_optional(mmc_dev(host->mmc), RK3568_MAX_CLKS,
> +       err = devm_clk_bulk_get_optional(mmc_dev(host->mmc), RK35xx_MAX_CLKS,
>                                          priv->rockchip_clks);
>         if (err) {
>                 dev_err(mmc_dev(host->mmc), "failed to get clocks %d\n", err);
>                 return err;
>         }
>
> -       err = clk_bulk_prepare_enable(RK3568_MAX_CLKS, priv->rockchip_clks);
> +       err = clk_bulk_prepare_enable(RK35xx_MAX_CLKS, priv->rockchip_clks);
>         if (err) {
>                 dev_err(mmc_dev(host->mmc), "failed to enable clocks %d\n", err);
>                 return err;
> @@ -348,7 +348,7 @@ static int dwcmshc_rk3568_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
>  static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>         {
>                 .compatible = "rockchip,rk3568-dwcmshc",
> -               .data = &sdhci_dwcmshc_rk3568_pdata,
> +               .data = &sdhci_dwcmshc_rk35xx_pdata,
>         },
>         {
>                 .compatible = "snps,dwcmshc-sdhci",
> @@ -371,7 +371,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_host *host;
>         struct dwcmshc_priv *priv;
> -       struct rk3568_priv *rk_priv = NULL;
> +       struct rk35xx_priv *rk_priv = NULL;
>         const struct sdhci_pltfm_data *pltfm_data;
>         int err;
>         u32 extra;
> @@ -426,8 +426,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>         host->mmc_host_ops.request = dwcmshc_request;
>         host->mmc_host_ops.hs400_enhanced_strobe = dwcmshc_hs400_enhanced_strobe;
>
> -       if (pltfm_data == &sdhci_dwcmshc_rk3568_pdata) {
> -               rk_priv = devm_kzalloc(&pdev->dev, sizeof(struct rk3568_priv), GFP_KERNEL);
> +       if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata) {
> +               rk_priv = devm_kzalloc(&pdev->dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
>                 if (!rk_priv) {
>                         err = -ENOMEM;
>                         goto err_clk;
> @@ -435,7 +435,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>
>                 priv->priv = rk_priv;
>
> -               err = dwcmshc_rk3568_init(host, priv);
> +               err = dwcmshc_rk35xx_init(host, priv);
>                 if (err)
>                         goto err_clk;
>         }
> @@ -452,7 +452,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>         clk_disable_unprepare(pltfm_host->clk);
>         clk_disable_unprepare(priv->bus_clk);
>         if (rk_priv)
> -               clk_bulk_disable_unprepare(RK3568_MAX_CLKS,
> +               clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
>                                            rk_priv->rockchip_clks);
>  free_pltfm:
>         sdhci_pltfm_free(pdev);
> @@ -464,14 +464,14 @@ static int dwcmshc_remove(struct platform_device *pdev)
>         struct sdhci_host *host = platform_get_drvdata(pdev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -       struct rk3568_priv *rk_priv = priv->priv;
> +       struct rk35xx_priv *rk_priv = priv->priv;
>
>         sdhci_remove_host(host, 0);
>
>         clk_disable_unprepare(pltfm_host->clk);
>         clk_disable_unprepare(priv->bus_clk);
>         if (rk_priv)
> -               clk_bulk_disable_unprepare(RK3568_MAX_CLKS,
> +               clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
>                                            rk_priv->rockchip_clks);
>         sdhci_pltfm_free(pdev);
>
> @@ -484,7 +484,7 @@ static int dwcmshc_suspend(struct device *dev)
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -       struct rk3568_priv *rk_priv = priv->priv;
> +       struct rk35xx_priv *rk_priv = priv->priv;
>         int ret;
>
>         ret = sdhci_suspend_host(host);
> @@ -496,7 +496,7 @@ static int dwcmshc_suspend(struct device *dev)
>                 clk_disable_unprepare(priv->bus_clk);
>
>         if (rk_priv)
> -               clk_bulk_disable_unprepare(RK3568_MAX_CLKS,
> +               clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
>                                            rk_priv->rockchip_clks);
>
>         return ret;
> @@ -507,7 +507,7 @@ static int dwcmshc_resume(struct device *dev)
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -       struct rk3568_priv *rk_priv = priv->priv;
> +       struct rk35xx_priv *rk_priv = priv->priv;
>         int ret;
>
>         ret = clk_prepare_enable(pltfm_host->clk);
> @@ -521,7 +521,7 @@ static int dwcmshc_resume(struct device *dev)
>         }
>
>         if (rk_priv) {
> -               ret = clk_bulk_prepare_enable(RK3568_MAX_CLKS,
> +               ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS,
>                                               rk_priv->rockchip_clks);
>                 if (ret)
>                         return ret;
> --
> 2.35.1
>
