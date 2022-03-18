Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CB14DDB26
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbiCROD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbiCROD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:03:56 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790692B5EE9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:02:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j18so2264014wrd.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=MSfe0oNqlxTc3hvFVxCHI7kIYgD3mVI4QDSibjDlGsU=;
        b=nMhlwQ7fYXVSj9Kxm6vqRqlZnpDQarVv0lQR0Hg11heP3FNNsF4h5gZiEb3MvyQTej
         jYSBWp7kxj44YE3MPxa0GbgcOrOWm4RJobVSYibpGv90gL07vkwEQ0qYbgtRD16tFpFv
         X7Yz+1T7u4QyHZSdgEvEoShJRmYU9LXuD8ASt44rcjYN05lFuk+D5/nwJNOOGBZHfkQn
         +XEkjSzN+Slwothm8OyrVqyCklqXtF2Pmgg7ENPkMN/zr3PtOO7Kt7L5G7HpxoIXKHPm
         iqCvEQM7YjfUDPlTsmQlulYSBe741JioYea2Oo9Ns/zYMioEac1mSRL62d8Aqy27Y7Lj
         XxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=MSfe0oNqlxTc3hvFVxCHI7kIYgD3mVI4QDSibjDlGsU=;
        b=gB+iOwJRLnQ4kUeOcG5uicU2vnNRuJUtlr6hsXKuLihkRV4BFsxffqssE2at0IEJLi
         5JRBnC/C7Bc6ey58iFr7flMAHfUAj7z6vz8aK/uNTsixkbAlEOxlL2eP1e+naTBV+OMz
         x43lPVG8HTXU3exNru5ekTBZB8bzbSz7W3zdFR0GBRHLxt+VZMOeMXxMlV6QKRicASCz
         2Kj8rrMDrxZ/XkSX8ZPrsYF0xVhKytuyH/GBWG8RBxoQDYApcapocgMi6kl3zolJdZ9F
         A7Jvzoc0mirNhl+8d2tBmcFn6CX3IZtyqgYqgT5/AMABiD7Fa7Bnio+JGnOSuY9hgicc
         7+4Q==
X-Gm-Message-State: AOAM530GG7TtKlEA2iZ0djt72xz9oPiRlN9HP/ZX7IR533DUEVb3FSy3
        MIjFpLEV9X3vao9H9hNHrU1ALA==
X-Google-Smtp-Source: ABdhPJzlx1nTpb3i5pgvyJajDxSfqFs4eVc0qGGx7Z0lDoyM6Sev+Wxrf/asoUJYby5Nx1ty10WW8w==
X-Received: by 2002:a5d:4609:0:b0:203:e792:3add with SMTP id t9-20020a5d4609000000b00203e7923addmr7416026wrq.657.1647612154903;
        Fri, 18 Mar 2022 07:02:34 -0700 (PDT)
Received: from [192.168.1.10] (i16-les01-ntr-213-44-230-108.sfr.lns.abo.bbox.fr. [213.44.230.108])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b00381141f4967sm8613506wmq.35.2022.03.18.07.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 07:02:34 -0700 (PDT)
Message-ID: <afeff479-624c-73c8-3a1a-7d21f85ac09b@baylibre.com>
Date:   Fri, 18 Mar 2022 15:02:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/2] mtd: rawnand: meson: discard the common MMC sub
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
References: <20220318124121.26117-1-liang.yang@amlogic.com>
 <20220318124121.26117-2-liang.yang@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220318124121.26117-2-liang.yang@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/03/2022 13:41, Liang Yang wrote:
> EMMC and NAND have the same clock control register named 'SD_EMMC_CLOCK' which is
> defined in EMMC port internally. bit0~5 of 'SD_EMMC_CLOCK' is the divider and
> bit6~7 is the mux for fix pll and xtal.A common MMC and NAND sub-clock has been
> implemented and can be used by the eMMC and NAND controller (which are mutually
> exclusive anyway). Let's use this new clock.
> 
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> ---
>   drivers/mtd/nand/raw/meson_nand.c | 101 ++++++++++++++++--------------
>   1 file changed, 53 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index ac3be92872d0..257ffc8a41ab 100644
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
> -	if (ret) {
> -		dev_err(nfc->dev, "failed to enable TX clock\n");
> -		goto err_phase_tx;
> -	}
> -
> -	ret = clk_prepare_enable(nfc->phase_rx);
> +	ret = clk_prepare_enable(nfc->nand_clk);
>   	if (ret) {
> -		dev_err(nfc->dev, "failed to enable RX clock\n");
> -		goto err_phase_rx;
> +		dev_err(nfc->dev, "pre enable NFC divider fail\n");
> +		goto err_nand_clk;
>   	}
>   
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
> @@ -1373,9 +1375,10 @@ MODULE_DEVICE_TABLE(of, meson_nfc_id_table);
>   static int meson_nfc_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
>   	struct meson_nfc *nfc;
> -	struct resource *res;
> -	int ret, irq;
> +	struct resource res;
> +	int ret, irq, i;
>   
>   	nfc = devm_kzalloc(dev, sizeof(*nfc), GFP_KERNEL);
>   	if (!nfc)
> @@ -1388,21 +1391,23 @@ static int meson_nfc_probe(struct platform_device *pdev)
>   	nand_controller_init(&nfc->controller);
>   	INIT_LIST_HEAD(&nfc->chips);
>   	init_completion(&nfc->completion);
> -
>   	nfc->dev = dev;
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	nfc->reg_base = devm_ioremap_resource(dev, res);
> +	i = of_property_match_string(node, "reg-names", "nfc");
> +	if (of_address_to_resource(node, i, &res))
> +		return -ENOENT;
> +
> +	nfc->reg_base = devm_ioremap_resource(dev, &res);
>   	if (IS_ERR(nfc->reg_base))
>   		return PTR_ERR(nfc->reg_base);

You can use devm_platform_ioremap_resource_byname() here which is musch simpler,
and permits dropping platform_get_resource() at the same time.

>   
> -	nfc->reg_clk =
> -		syscon_regmap_lookup_by_phandle(dev->of_node,
> -						"amlogic,mmc-syscon");
> -	if (IS_ERR(nfc->reg_clk)) {
> -		dev_err(dev, "Failed to lookup clock base\n");
> -		return PTR_ERR(nfc->reg_clk);
> -	}
> +	i = of_property_match_string(node, "reg-names", "emmc");
> +	if (of_address_to_resource(node, i, &res))
> +		return -ENOENT;
> +
> +	nfc->sd_emmc_clock = devm_ioremap_resource(dev, &res);
> +	if (IS_ERR(nfc->sd_emmc_clock))
> +		return PTR_ERR(nfc->sd_emmc_clock);

Same here.

>   
>   	irq = platform_get_irq(pdev, 0);
>   	if (irq < 0)

Thanks !
Neil
