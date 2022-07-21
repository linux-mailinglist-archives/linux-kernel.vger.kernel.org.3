Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA8457D226
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiGURBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGURBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:01:06 -0400
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF9E419B7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:01:03 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id EZXhoxRl0LFqbEZXhozq3f; Thu, 21 Jul 2022 19:01:02 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 21 Jul 2022 19:01:02 +0200
X-ME-IP: 90.11.190.129
Message-ID: <4feebd9e-d1c3-aeea-8294-e7ae182f7918@wanadoo.fr>
Date:   Thu, 21 Jul 2022 19:00:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 7/7] clk: mediatek: Add MediaTek Helio X10 MT6795 clock
 drivers
Content-Language: fr
References: <20220629110254.184213-1-angelogioacchino.delregno@collabora.com>
 <20220629110254.184213-8-angelogioacchino.delregno@collabora.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     angelogioacchino.delregno@collabora.com
Cc:     bgolaszewski@baylibre.com, chun-jie.chen@mediatek.com,
        ck.hu@mediatek.com, devicetree@vger.kernel.org,
        fparent@baylibre.com, ikjn@chromium.org, jason-jh.lin@mediatek.com,
        kernel@collabora.com, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        matthias.bgg@gmail.com, miles.chen@mediatek.com,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        paul.bouchara@somainline.org, phone-devel@vger.kernel.org,
        rex-bc.chen@mediatek.com, robh+dt@kernel.org,
        sam.shih@mediatek.com, sboyd@kernel.org, tinghan.shen@mediatek.com,
        weiyi.lu@mediatek.com, wenst@chromium.org,
        y.oudjana@protonmail.com, ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20220629110254.184213-8-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 29/06/2022 à 13:02, AngeloGioacchino Del Regno a écrit :
> Add the clock drivers for the entire clock tree of MediaTek Helio X10
> MT6795, including system clocks (apmixedsys, infracfg, pericfg, topckgen)
> and multimedia clocks (mmsys, mfg, vdecsys, vencsys).
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> Reviewed-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/clk/mediatek/Kconfig                 |  37 ++
>   drivers/clk/mediatek/Makefile                |   6 +
>   drivers/clk/mediatek/clk-mt6795-apmixedsys.c | 157 +++++
>   drivers/clk/mediatek/clk-mt6795-infracfg.c   | 148 +++++
>   drivers/clk/mediatek/clk-mt6795-mfg.c        |  50 ++
>   drivers/clk/mediatek/clk-mt6795-mm.c         | 106 ++++
>   drivers/clk/mediatek/clk-mt6795-pericfg.c    | 160 +++++
>   drivers/clk/mediatek/clk-mt6795-topckgen.c   | 610 +++++++++++++++++++
>   drivers/clk/mediatek/clk-mt6795-vdecsys.c    |  55 ++
>   drivers/clk/mediatek/clk-mt6795-vencsys.c    |  50 ++
>   10 files changed, 1379 insertions(+)
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-apmixedsys.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-infracfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-mfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-mm.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-pericfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-topckgen.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-vdecsys.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-vencsys.c
> 


[...]

> diff --git a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
> new file mode 100644
> index 000000000000..e87db76799af
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c

[...]

> +static int clk_mt6795_apmixed_probe(struct platform_device *pdev)
> +{
> +	struct clk_hw_onecell_data *clk_data;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	void __iomem *base;
> +	struct clk_hw *hw;
> +	int ret;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	ret = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
> +	if (ret)
> +		goto free_clk_data;
> +
> +	hw = mtk_clk_register_ref2usb_tx("ref2usb_tx", "clk26m", base + REG_REF2USB);

This calls kzalloc() and clk_hw_register() but...

> +	if (IS_ERR(hw)) {
> +		ret = PTR_ERR(hw);
> +		dev_err(dev, "Failed to register ref2usb_tx: %d\n", ret);
> +		goto unregister_plls;
> +	}
> +	clk_data->hws[CLK_APMIXED_REF2USB_TX] = hw;
> +
> +	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> +	if (ret) {
> +		dev_err(dev, "Cannot register clock provider: %d\n", ret);
> +		goto unregister_ref2usb;
> +	}
> +
> +	/* Setup MD1 to avoid random crashes */
> +	dev_dbg(dev, "Performing initial setup for MD1\n");
> +	clk_mt6795_apmixed_setup_md1(base);
> +
> +	return 0;
> +
> +unregister_ref2usb:
> +	clk_hw_unregister(clk_data->hws[CLK_APMIXED_REF2USB_TX]);

... only clk_hw_register() is undone here. Should a 
mtk_clk_unregister_ref2usb_tx() be useful?

Or is it already handled somewhere else?

> +unregister_plls:
> +	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
> +free_clk_data:
> +	mtk_free_clk_data(clk_data);
> +	return ret;
> +}
> +
> +static int clk_mt6795_apmixed_remove(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
> +
> +	of_clk_del_provider(node);
> +	clk_hw_unregister(clk_data->hws[CLK_APMIXED_REF2USB_TX]);

Same here.

> +	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
> +	mtk_free_clk_data(clk_data);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver clk_mt6795_apmixed_drv = {
> +	.probe = clk_mt6795_apmixed_probe,
> +	.remove = clk_mt6795_apmixed_remove,
> +	.driver = {
> +		.name = "clk-mt6795-apmixed",
> +		.of_match_table = of_match_clk_mt6795_apmixed,
> +	},
> +};
> +module_platform_driver(clk_mt6795_apmixed_drv);
> +
> +MODULE_DESCRIPTION("MediaTek MT6795 apmixed clocks driver");
> +MODULE_LICENSE("GPL v2");

[...]

> diff --git a/drivers/clk/mediatek/clk-mt6795-mm.c b/drivers/clk/mediatek/clk-mt6795-mm.c
> new file mode 100644
> index 000000000000..27a8859ff5b5
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt6795-mm.c

[...]

> +static int clk_mt6795_mm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->parent->of_node;
> +	struct clk_hw_onecell_data *clk_data;
> +	int ret;
> +
> +	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	ret = mtk_clk_register_gates(node, mm_gates, ARRAY_SIZE(mm_gates), clk_data);
> +	if (ret)

Add an error handling path and call mtk_free_clk_data(clk_data); if this 
fails?

> +		return ret;
> +
> +	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);

Same here, + mtk_clk_unregister_gates()?

> +}
> +
> +static struct platform_driver clk_mt6795_mm_drv = {
> +	.driver = {
> +		.name = "clk-mt6795-mm",
> +	},
> +	.probe = clk_mt6795_mm_probe,

.remove function that mimics the (non existent) error handling path of 
the probe?

> +};
> +module_platform_driver(clk_mt6795_mm_drv);
> +
> +MODULE_DESCRIPTION("MediaTek MT6795 multimedia clocks driver");
> +MODULE_LICENSE("GPL v2");

[...]

