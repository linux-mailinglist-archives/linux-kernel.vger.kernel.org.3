Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094E05112E6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359112AbiD0Hye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359048AbiD0Hy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:54:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE05DEAF;
        Wed, 27 Apr 2022 00:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651045879; x=1682581879;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hv6fHgeIQZHcenF/6YwhqZqdu/V0rQKHOkVPgpJ76XE=;
  b=cYnSxTLJ2iaydl/s9SLg/Fizl+HF2LPZrr8SVlIvkMlHNISwLXsAHkyo
   8pERkLicbqslNjSmrfXsWxbwsAF6/THW/tNMB8IriI3v2nEzzxtc3fUwq
   7tp/GDzRg54kV39vb3iaEio3ctgxhSK4N17lT9uStTg8XJr81446k3ls0
   nUJOabkroLv4qhyxWG61OYuUbhznZ4aK0NdzelkDZoGR6HLO2U/CUDFXL
   IZ62eZWiy//vLXDRbuJ+Y3X+2XCWptkvOA24LTZ0nH7iGfuQRf2/rpusu
   9C0wy6C0SEhLXPtB7fjXEgmLZBHzFOe+86M5He9BZznFiM8E/3IYUBnJo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="326341330"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="326341330"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 00:51:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="580450828"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 00:51:14 -0700
Message-ID: <f94d82bb-297b-e1cd-9dd1-b25eccc64744@intel.com>
Date:   Wed, 27 Apr 2022 10:51:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCHv1 09/19] mmc: sdhci-of-dwcmshc: rename rk3568 to rk35xx
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        kernel@collabora.com
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
 <20220422170920.401914-10-sebastian.reichel@collabora.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220422170920.401914-10-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/22 20:09, Sebastian Reichel wrote:
> Prepare driver for rk3588 support by renaming the internal data
> structures.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 46 ++++++++++++++---------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index d95ae6ca1256..54ae0268e002 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -56,14 +56,14 @@
>  #define DLL_LOCK_WO_TMOUT(x) \
>  	((((x) & DWCMSHC_EMMC_DLL_LOCKED) == DWCMSHC_EMMC_DLL_LOCKED) && \
>  	(((x) & DWCMSHC_EMMC_DLL_TIMEOUT) == 0))
> -#define RK3568_MAX_CLKS 3
> +#define RK35xx_MAX_CLKS 3
>  
>  #define BOUNDARY_OK(addr, len) \
>  	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
>  
> -struct rk3568_priv {
> +struct rk35xx_priv {
>  	/* Rockchip specified optional clocks */
> -	struct clk_bulk_data rockchip_clks[RK3568_MAX_CLKS];
> +	struct clk_bulk_data rockchip_clks[RK35xx_MAX_CLKS];
>  	struct reset_control *reset;
>  	u8 txclk_tapnum;
>  };
> @@ -178,7 +178,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> -	struct rk3568_priv *priv = dwc_priv->priv;
> +	struct rk35xx_priv *priv = dwc_priv->priv;
>  	u8 txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
>  	u32 extra, reg;
>  	int err;
> @@ -283,7 +283,7 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
>  	.adma_write_desc	= dwcmshc_adma_write_desc,
>  };
>  
> -static const struct sdhci_ops sdhci_dwcmshc_rk3568_ops = {
> +static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
>  	.set_clock		= dwcmshc_rk3568_set_clock,
>  	.set_bus_width		= sdhci_set_bus_width,
>  	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
> @@ -298,18 +298,18 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>  
> -static const struct sdhci_pltfm_data sdhci_dwcmshc_rk3568_pdata = {
> -	.ops = &sdhci_dwcmshc_rk3568_ops,
> +static const struct sdhci_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
> +	.ops = &sdhci_dwcmshc_rk35xx_ops,
>  	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
>  		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>  		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>  };
>  
> -static int dwcmshc_rk3568_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
> +static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
>  {
>  	int err;
> -	struct rk3568_priv *priv = dwc_priv->priv;
> +	struct rk35xx_priv *priv = dwc_priv->priv;
>  
>  	priv->reset = devm_reset_control_array_get_exclusive(mmc_dev(host->mmc));
>  	if (IS_ERR_OR_NULL(priv->reset)) {
> @@ -321,14 +321,14 @@ static int dwcmshc_rk3568_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
>  	priv->rockchip_clks[0].id = "axi";
>  	priv->rockchip_clks[1].id = "block";
>  	priv->rockchip_clks[2].id = "timer";
> -	err = devm_clk_bulk_get_optional(mmc_dev(host->mmc), RK3568_MAX_CLKS,
> +	err = devm_clk_bulk_get_optional(mmc_dev(host->mmc), RK35xx_MAX_CLKS,
>  					 priv->rockchip_clks);
>  	if (err) {
>  		dev_err(mmc_dev(host->mmc), "failed to get clocks %d\n", err);
>  		return err;
>  	}
>  
> -	err = clk_bulk_prepare_enable(RK3568_MAX_CLKS, priv->rockchip_clks);
> +	err = clk_bulk_prepare_enable(RK35xx_MAX_CLKS, priv->rockchip_clks);
>  	if (err) {
>  		dev_err(mmc_dev(host->mmc), "failed to enable clocks %d\n", err);
>  		return err;
> @@ -350,7 +350,7 @@ static int dwcmshc_rk3568_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
>  static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>  	{
>  		.compatible = "rockchip,rk3568-dwcmshc",
> -		.data = &sdhci_dwcmshc_rk3568_pdata,
> +		.data = &sdhci_dwcmshc_rk35xx_pdata,
>  	},
>  	{
>  		.compatible = "snps,dwcmshc-sdhci",
> @@ -373,7 +373,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_host *host;
>  	struct dwcmshc_priv *priv;
> -	struct rk3568_priv *rk_priv = NULL;
> +	struct rk35xx_priv *rk_priv = NULL;
>  	const struct sdhci_pltfm_data *pltfm_data;
>  	int err;
>  	u32 extra;
> @@ -428,8 +428,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	host->mmc_host_ops.request = dwcmshc_request;
>  	host->mmc_host_ops.hs400_enhanced_strobe = dwcmshc_hs400_enhanced_strobe;
>  
> -	if (pltfm_data == &sdhci_dwcmshc_rk3568_pdata) {
> -		rk_priv = devm_kzalloc(&pdev->dev, sizeof(struct rk3568_priv), GFP_KERNEL);
> +	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata) {
> +		rk_priv = devm_kzalloc(&pdev->dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
>  		if (!rk_priv) {
>  			err = -ENOMEM;
>  			goto err_clk;
> @@ -437,7 +437,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  
>  		priv->priv = rk_priv;
>  
> -		err = dwcmshc_rk3568_init(host, priv);
> +		err = dwcmshc_rk35xx_init(host, priv);
>  		if (err)
>  			goto err_clk;
>  	}
> @@ -454,7 +454,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	clk_disable_unprepare(pltfm_host->clk);
>  	clk_disable_unprepare(priv->bus_clk);
>  	if (rk_priv)
> -		clk_bulk_disable_unprepare(RK3568_MAX_CLKS,
> +		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
>  					   rk_priv->rockchip_clks);
>  free_pltfm:
>  	sdhci_pltfm_free(pdev);
> @@ -466,14 +466,14 @@ static int dwcmshc_remove(struct platform_device *pdev)
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -	struct rk3568_priv *rk_priv = priv->priv;
> +	struct rk35xx_priv *rk_priv = priv->priv;
>  
>  	sdhci_remove_host(host, 0);
>  
>  	clk_disable_unprepare(pltfm_host->clk);
>  	clk_disable_unprepare(priv->bus_clk);
>  	if (rk_priv)
> -		clk_bulk_disable_unprepare(RK3568_MAX_CLKS,
> +		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
>  					   rk_priv->rockchip_clks);
>  	sdhci_pltfm_free(pdev);
>  
> @@ -486,7 +486,7 @@ static int dwcmshc_suspend(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -	struct rk3568_priv *rk_priv = priv->priv;
> +	struct rk35xx_priv *rk_priv = priv->priv;
>  	int ret;
>  
>  	ret = sdhci_suspend_host(host);
> @@ -498,7 +498,7 @@ static int dwcmshc_suspend(struct device *dev)
>  		clk_disable_unprepare(priv->bus_clk);
>  
>  	if (rk_priv)
> -		clk_bulk_disable_unprepare(RK3568_MAX_CLKS,
> +		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
>  					   rk_priv->rockchip_clks);
>  
>  	return ret;
> @@ -509,7 +509,7 @@ static int dwcmshc_resume(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -	struct rk3568_priv *rk_priv = priv->priv;
> +	struct rk35xx_priv *rk_priv = priv->priv;
>  	int ret;
>  
>  	ret = clk_prepare_enable(pltfm_host->clk);
> @@ -523,7 +523,7 @@ static int dwcmshc_resume(struct device *dev)
>  	}
>  
>  	if (rk_priv) {
> -		ret = clk_bulk_prepare_enable(RK3568_MAX_CLKS,
> +		ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS,
>  					      rk_priv->rockchip_clks);
>  		if (ret)
>  			return ret;

