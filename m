Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE54F4F1504
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347108AbiDDMmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346841AbiDDMmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:42:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BE42CC9D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 05:40:11 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso7626739wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 05:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ZeotdEyuaTGdsdLJ4Jmy4Ks/jM3YHCk6KKZJjilIqN8=;
        b=d2ACJ4FMKOj+ZM4t31aUYUvlo+gq5OXoKso3xQjGB0BTJw3j0494Vvff+SqZczkhmH
         48/p0IUyMek7zMIvV0edVPA15DEb3kduZ0HwkUeKioDT9+GARrqJ35+uy+fMQEUrJlXu
         21ELX9Sur5wPriXnF6/OdKMfYvFhmccQVe7WOKEjnf6Ad3os32/r2Zo2Z+cIOiCxxZl5
         tH+1gy3y8tnbRN+10wgkIO5LcQESPxqcRCWbzI3Pt4pAWgbsp1LQwDLPL9l1iz85ttdr
         XlQRuhDPoYmIafzzxonjT1E5KAwIdKOmHY2zbltzxk7qW/MfCA/I0ItDkpnFnGTtki3y
         f5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ZeotdEyuaTGdsdLJ4Jmy4Ks/jM3YHCk6KKZJjilIqN8=;
        b=cIaM/eT3eQCz75idvMNUsHQLvT/ElWUJhIP1N2zbPzM5Ze7TxdTlOiddapBTI7JlW9
         MErANljGmFLb7hfpZhUgTe1AnlvCSpRk1P+kqzmC6yoNuI0+bzByrnsqgiyTBqNHjd+F
         jnyYkoRMddx1BhI5dm052KRf+H6VklcicJOrh1gXpVGWQ6TZKBUqiMvkGzoBsJaOOhVa
         YEy7owYuTMEUUc/YXjiw9YmspzeEuXFihwDGs2FThfYJN/VC8ILWxfXifLbftY8MH2PO
         2+JD0ctImwUUh4eOgS4UjiHGxJE5tZiZZ8rgCKqi7UhSLU5tnYmfZYig70iPZBfCLR8A
         3eeQ==
X-Gm-Message-State: AOAM532vXO56goPDX7d65wyKZ2l6WgwmKS7Ev8FPhhKSJ3cwMAhJI8s3
        cZfKciPFYHgNQoNjSZP5DEyxbQ==
X-Google-Smtp-Source: ABdhPJzuy3b3TtMxOWHYxOYY54z4mIT4gXGcVATO1XYdj1uwDkn7Dkq4yjzBf0nohbQq8Q4aC57KwQ==
X-Received: by 2002:a7b:c382:0:b0:388:2e76:49ed with SMTP id s2-20020a7bc382000000b003882e7649edmr19337941wmj.195.1649076009796;
        Mon, 04 Apr 2022 05:40:09 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:1add:1b28:2457:eb46? ([2001:861:44c0:66c0:1add:1b28:2457:eb46])
        by smtp.gmail.com with ESMTPSA id l28-20020a05600c1d1c00b0038e72a95ec4sm2849603wms.13.2022.04.04.05.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 05:40:09 -0700 (PDT)
Message-ID: <d30b32fe-e1d4-0684-a1fa-710c1da3faea@baylibre.com>
Date:   Mon, 4 Apr 2022 14:40:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/2] mtd: rawnand: meson: discard the common MMC sub
 clock framework
Content-Language: en-US
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220402074921.13316-1-liang.yang@amlogic.com>
 <20220402074921.13316-2-liang.yang@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220402074921.13316-2-liang.yang@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/04/2022 09:49, Liang Yang wrote:
> EMMC and NAND have the same clock control register named 'SD_EMMC_CLOCK' which is
> defined in EMMC port internally. bit0~5 of 'SD_EMMC_CLOCK' is the divider and
> bit6~7 is the mux for fix pll and xtal.A common MMC and NAND sub-clock has been
> implemented and can be used by the eMMC and NAND controller (which are mutually
> exclusive anyway). Let's use this new clock.
> 
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> ---
>   drivers/mtd/nand/raw/meson_nand.c | 89 +++++++++++++++----------------
>   1 file changed, 42 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index ac3be92872d0..1b1a9407fb2f 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -10,6 +10,7 @@
>   #include <linux/dma-mapping.h>
>   #include <linux/interrupt.h>
>   #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>   #include <linux/mtd/rawnand.h>
>   #include <linux/mtd/mtd.h>
>   #include <linux/mfd/syscon.h>
> @@ -19,6 +20,7 @@
>   #include <linux/iopoll.h>
>   #include <linux/of.h>
>   #include <linux/of_device.h>
> +#include <linux/of_address.h>
>   #include <linux/sched/task_stack.h>
>   
>   #define NFC_REG_CMD		0x00
> @@ -104,6 +106,9 @@
>   
>   #define PER_INFO_BYTE		8
>   
> +#define CLK_DIV_SHIFT		0
> +#define CLK_DIV_WIDTH		6
> +
>   struct meson_nfc_nand_chip {
>   	struct list_head node;
>   	struct nand_chip nand;
> @@ -151,15 +156,15 @@ struct meson_nfc {
>   	struct nand_controller controller;
>   	struct clk *core_clk;
>   	struct clk *device_clk;
> -	struct clk *phase_tx;
> -	struct clk *phase_rx;
> +	struct clk *nand_clk;
> +	struct clk_divider nand_divider;
>   
>   	unsigned long clk_rate;
>   	u32 bus_timing;
>   
>   	struct device *dev;
>   	void __iomem *reg_base;
> -	struct regmap *reg_clk;
> +	void __iomem *sd_emmc_clock;

The name could still be reg_clk, even if not a regmap anymore.

>   	struct completion completion;
>   	struct list_head chips;
>   	const struct meson_nfc_data *data;
> @@ -235,7 +240,7 @@ static void meson_nfc_select_chip(struct nand_chip *nand, int chip)
>   	nfc->timing.tbers_max = meson_chip->tbers_max;
>   
>   	if (nfc->clk_rate != meson_chip->clk_rate) {
> -		ret = clk_set_rate(nfc->device_clk, meson_chip->clk_rate);
> +		ret = clk_set_rate(nfc->nand_clk, meson_chip->clk_rate);
>   		if (ret) {
>   			dev_err(nfc->dev, "failed to set clock rate\n");
>   			return;
> @@ -406,7 +411,6 @@ static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
>   	cmd = NFC_CMD_RB | NFC_CMD_RB_INT
>   		| nfc->param.chip_select | nfc->timing.tbers_max;
>   	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> -
>   	ret = wait_for_completion_timeout(&nfc->completion,
>   					  msecs_to_jiffies(timeout_ms));
>   	if (ret == 0)
> @@ -985,9 +989,11 @@ static const struct mtd_ooblayout_ops meson_ooblayout_ops = {
>   	.free = meson_ooblayout_free,
>   };
>   
> +struct clk_parent_data nfc_divider_parent_data[1];

This should be in the meson_nfc_clk_init() function, not global

>   static int meson_nfc_clk_init(struct meson_nfc *nfc)
>   {
>   	int ret;
> +	struct clk_init_data init = {0};
>   
>   	/* request core clock */
>   	nfc->core_clk = devm_clk_get(nfc->dev, "core");
> @@ -1002,21 +1008,26 @@ static int meson_nfc_clk_init(struct meson_nfc *nfc)
>   		return PTR_ERR(nfc->device_clk);
>   	}
>   
> -	nfc->phase_tx = devm_clk_get(nfc->dev, "tx");
> -	if (IS_ERR(nfc->phase_tx)) {
> -		dev_err(nfc->dev, "failed to get TX clk\n");
> -		return PTR_ERR(nfc->phase_tx);
> -	}
> -
> -	nfc->phase_rx = devm_clk_get(nfc->dev, "rx");
> -	if (IS_ERR(nfc->phase_rx)) {
> -		dev_err(nfc->dev, "failed to get RX clk\n");
> -		return PTR_ERR(nfc->phase_rx);
> -	}
> +	init.name = devm_kstrdup(nfc->dev, "nfc#div", GFP_KERNEL);

name = devm_kasprintf(nfc->dev, GFP_KERNEL, "%s#div", dev_name(dev));

would be better.

> +	init.ops = &clk_divider_ops;
> +	nfc_divider_parent_data[0].fw_name = "device";
> +	init.parent_data = nfc_divider_parent_data;
> +	init.num_parents = 1;
> +	nfc->nand_divider.reg = nfc->sd_emmc_clock;
> +	nfc->nand_divider.shift = CLK_DIV_SHIFT;
> +	nfc->nand_divider.width = CLK_DIV_WIDTH;
> +	nfc->nand_divider.hw.init = &init;
> +	nfc->nand_divider.flags = CLK_DIVIDER_ONE_BASED |
> +				  CLK_DIVIDER_ROUND_CLOSEST |
> +				  CLK_DIVIDER_ALLOW_ZERO;
> +
> +	nfc->nand_clk = devm_clk_register(nfc->dev, &nfc->nand_divider.hw);
> +	if (IS_ERR(nfc->nand_clk))
> +		return PTR_ERR(nfc->nand_clk);
>   
>   	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
> -	regmap_update_bits(nfc->reg_clk,
> -			   0, CLK_SELECT_NAND, CLK_SELECT_NAND);
> +	writel(CLK_SELECT_NAND | readl(nfc->sd_emmc_clock),
> +	       nfc->sd_emmc_clock);
>   
>   	ret = clk_prepare_enable(nfc->core_clk);
>   	if (ret) {
> @@ -1030,29 +1041,21 @@ static int meson_nfc_clk_init(struct meson_nfc *nfc)
>   		goto err_device_clk;
>   	}
>   
> -	ret = clk_prepare_enable(nfc->phase_tx);
> +	ret = clk_prepare_enable(nfc->nand_clk);
>   	if (ret) {
> -		dev_err(nfc->dev, "failed to enable TX clock\n");
> -		goto err_phase_tx;
> +		dev_err(nfc->dev, "pre enable NFC divider fail\n");
> +		goto err_nand_clk;
>   	}
>   
> -	ret = clk_prepare_enable(nfc->phase_rx);
> -	if (ret) {
> -		dev_err(nfc->dev, "failed to enable RX clock\n");
> -		goto err_phase_rx;
> -	}
> -
> -	ret = clk_set_rate(nfc->device_clk, 24000000);
> +	ret = clk_set_rate(nfc->nand_clk, 24000000);
>   	if (ret)
> -		goto err_disable_rx;
> +		goto err_disable_clk;
>   
>   	return 0;
>   
> -err_disable_rx:
> -	clk_disable_unprepare(nfc->phase_rx);
> -err_phase_rx:
> -	clk_disable_unprepare(nfc->phase_tx);
> -err_phase_tx:
> +err_disable_clk:
> +	clk_disable_unprepare(nfc->nand_clk);
> +err_nand_clk:
>   	clk_disable_unprepare(nfc->device_clk);
>   err_device_clk:
>   	clk_disable_unprepare(nfc->core_clk);
> @@ -1061,8 +1064,7 @@ static int meson_nfc_clk_init(struct meson_nfc *nfc)
>   
>   static void meson_nfc_disable_clk(struct meson_nfc *nfc)
>   {
> -	clk_disable_unprepare(nfc->phase_rx);
> -	clk_disable_unprepare(nfc->phase_tx);
> +	clk_disable_unprepare(nfc->nand_clk);
>   	clk_disable_unprepare(nfc->device_clk);
>   	clk_disable_unprepare(nfc->core_clk);
>   }
> @@ -1374,7 +1376,6 @@ static int meson_nfc_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct meson_nfc *nfc;
> -	struct resource *res;
>   	int ret, irq;
>   
>   	nfc = devm_kzalloc(dev, sizeof(*nfc), GFP_KERNEL);
> @@ -1388,21 +1389,15 @@ static int meson_nfc_probe(struct platform_device *pdev)
>   	nand_controller_init(&nfc->controller);
>   	INIT_LIST_HEAD(&nfc->chips);
>   	init_completion(&nfc->completion);
> -
>   	nfc->dev = dev;
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	nfc->reg_base = devm_ioremap_resource(dev, res);
> +	nfc->reg_base = devm_platform_ioremap_resource_byname(pdev, "nfc");
>   	if (IS_ERR(nfc->reg_base))
>   		return PTR_ERR(nfc->reg_base);
>   
> -	nfc->reg_clk =
> -		syscon_regmap_lookup_by_phandle(dev->of_node,
> -						"amlogic,mmc-syscon");
> -	if (IS_ERR(nfc->reg_clk)) {
> -		dev_err(dev, "Failed to lookup clock base\n");
> -		return PTR_ERR(nfc->reg_clk);
> -	}
> +	nfc->sd_emmc_clock = devm_platform_ioremap_resource_byname(pdev, "emmc");
> +	if (IS_ERR(nfc->sd_emmc_clock))
> +		return PTR_ERR(nfc->sd_emmc_clock);
>   
>   	irq = platform_get_irq(pdev, 0);
>   	if (irq < 0)

Thanks,
Neil
