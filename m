Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D34B4C2102
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 02:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiBXBdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 20:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiBXBdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 20:33:17 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271634AE38
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:32:45 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id x15so624618wrg.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4e/Dnvb9YoryIhdTdufKPGz6hPEp9xb9MXXu9Z2tkes=;
        b=JCFtRmGYiQtsLAv3rnw5tWOfOC90RRwv2f9AUUFq/YozNBiu88clQpOm6YJEyg717J
         fWBVXoKeaK9KJp+DgOwv1LSMhNUDge91NpJyqwctN0uC3kCNeW5zKJPQH2ZzrMCwvspm
         Tec720f6qxbR2CG1kPA396ITMOwpcgyKQt2/+RvThEqPKPGfmr80/CuqLsP3QtnXJ/AO
         xOtbtGeuHEEbsR4EPtxcDvyB0uTM9mGGUVG/gh8DOXlw4/UE/G81VuUEzkaRQDgAtLrt
         cHC15C2634RTP5lT0wJ5lHaWkyrVuGkZMtz1YfsE2NnTaK7zGGvag4iDfEJNp/gKUyBw
         9g2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4e/Dnvb9YoryIhdTdufKPGz6hPEp9xb9MXXu9Z2tkes=;
        b=S6vrmnxOTQEf8s3KKzQQBaaRLuRS54Yai3vn8xtdyQHo8v9Bi69xtxpbz3g7gK1kd9
         TkirsaBe99egkGww2jCX4n7nLcmhRzcmsN5e3EduvaPX4xgFs7ww6cPZ3BfOUD6Joxb2
         MI5Dk3ANVvxR/NLOTPyp9kZL77iN+pq/iox4FgmSVBq8ENGLh0z59kHa4H2YpypDOAgx
         ZrFiaKf11o6whW/oZANjYMsNXd1n8yTtm5TuK8dvEo7VlXQKKKuvRvDlvLY7qdfWdKcw
         3+lZcq1NoTeda68uyRR4YJZGfhkZLS6AqYe0ASS4SlCpUNM4XtfN8Y9EYu7o4vd8p1Mg
         l6xw==
X-Gm-Message-State: AOAM530wUYYvY6XtGMNx5ZttmKReOVIwA2oRBeqJvlG4ubBokpjemOoI
        iHVhbVmECS78RxFR1r49uLKD7+Q/k/B3mg==
X-Google-Smtp-Source: ABdhPJzd71Svvs+9vb34rVpI3x2LL2LRf43Sjc2JTuzUKjBhmXKAYZpDbpI7YkNZJndN4rzKu1Kfcg==
X-Received: by 2002:adf:dd50:0:b0:1ea:8de3:9372 with SMTP id u16-20020adfdd50000000b001ea8de39372mr204367wrm.495.1645664511727;
        Wed, 23 Feb 2022 17:01:51 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id r17sm971856wrp.64.2022.02.23.17.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 17:01:51 -0800 (PST)
Message-ID: <4b972404-578a-b13b-b036-4033c89fafa9@linaro.org>
Date:   Thu, 24 Feb 2022 01:01:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] ASoC: codecs: Add power domains support in digital
 macro codecs
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1645631198-4701-1-git-send-email-quic_srivasam@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1645631198-4701-1-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/02/2022 15:46, Srinivasa Rao Mandadapu wrote:
> Add support for enabling required power domains in digital macro codecs.
> macro and dcodec power domains are being requested as clocks by HLOS
> in ADSP based architectures and ADSP internally handling as powerdomains.
> In ADSP bypass case need to handle them as power domains explicitly.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> Changes since v1:
>      -- Add missing macros in Kconfig.
> 
>   sound/soc/codecs/Kconfig              |  7 ++++
>   sound/soc/codecs/Makefile             |  2 +
>   sound/soc/codecs/lpass-macro-common.c | 72 +++++++++++++++++++++++++++++++++++
>   sound/soc/codecs/lpass-macro-common.h | 18 +++++++++
>   sound/soc/codecs/lpass-rx-macro.c     | 13 ++++++-
>   sound/soc/codecs/lpass-tx-macro.c     | 10 +++++
>   sound/soc/codecs/lpass-va-macro.c     | 11 +++++-
>   sound/soc/qcom/Kconfig                |  1 +
>   8 files changed, 132 insertions(+), 2 deletions(-)
>   create mode 100644 sound/soc/codecs/lpass-macro-common.c
>   create mode 100644 sound/soc/codecs/lpass-macro-common.h
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index c2627f7..4de029a 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -244,6 +244,7 @@ config SND_SOC_ALL_CODECS
>   	imply SND_SOC_WCD9335
>   	imply SND_SOC_WCD934X
>   	imply SND_SOC_WCD938X_SDW
> +	imply SND_SOC_LPASS_MACRO_COMMON
>   	imply SND_SOC_LPASS_RX_MACRO
>   	imply SND_SOC_LPASS_TX_MACRO
>   	imply SND_SOC_WL1273
> @@ -2008,6 +2009,9 @@ config SND_SOC_TPA6130A2
>   	tristate "Texas Instruments TPA6130A2 headphone amplifier"
>   	depends on I2C
>   
> +config SND_SOC_LPASS_MACRO_COMMON
> +        tristate
> +
>   config SND_SOC_LPASS_WSA_MACRO
>   	depends on COMMON_CLK
>   	select REGMAP_MMIO
> @@ -2016,16 +2020,19 @@ config SND_SOC_LPASS_WSA_MACRO
>   config SND_SOC_LPASS_VA_MACRO
>   	depends on COMMON_CLK
>   	select REGMAP_MMIO
> +	select SND_SOC_LPASS_MACRO_COMMON
>   	tristate "Qualcomm VA Macro in LPASS(Low Power Audio SubSystem)"
>   
>   config SND_SOC_LPASS_RX_MACRO
>   	depends on COMMON_CLK
>   	select REGMAP_MMIO
> +	select SND_SOC_LPASS_MACRO_COMMON
>   	tristate "Qualcomm RX Macro in LPASS(Low Power Audio SubSystem)"
>   
>   config SND_SOC_LPASS_TX_MACRO
>   	depends on COMMON_CLK
>   	select REGMAP_MMIO
> +	select SND_SOC_LPASS_MACRO_COMMON
>   	tristate "Qualcomm TX Macro in LPASS(Low Power Audio SubSystem)"
>   
>   endmenu
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index b4e11c3..c3c6059 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -112,6 +112,7 @@ snd-soc-l3-objs := l3.o
>   snd-soc-lm4857-objs := lm4857.o
>   snd-soc-lm49453-objs := lm49453.o
>   snd-soc-lochnagar-sc-objs := lochnagar-sc.o
> +snd-soc-lpass-macro-common-objs := lpass-macro-common.o
>   snd-soc-lpass-rx-macro-objs := lpass-rx-macro.o
>   snd-soc-lpass-tx-macro-objs := lpass-tx-macro.o
>   snd-soc-lpass-wsa-macro-objs := lpass-wsa-macro.o
> @@ -676,6 +677,7 @@ obj-$(CONFIG_SND_SOC_MAX9877)	+= snd-soc-max9877.o
>   obj-$(CONFIG_SND_SOC_MAX98504)	+= snd-soc-max98504.o
>   obj-$(CONFIG_SND_SOC_SIMPLE_AMPLIFIER)	+= snd-soc-simple-amplifier.o
>   obj-$(CONFIG_SND_SOC_TPA6130A2)	+= snd-soc-tpa6130a2.o
> +obj-$(CONFIG_SND_SOC_LPASS_MACRO_COMMON)	+= snd-soc-lpass-macro-common.o
>   obj-$(CONFIG_SND_SOC_LPASS_WSA_MACRO)	+= snd-soc-lpass-wsa-macro.o
>   obj-$(CONFIG_SND_SOC_LPASS_VA_MACRO)	+= snd-soc-lpass-va-macro.o
>   obj-$(CONFIG_SND_SOC_LPASS_RX_MACRO)	+= snd-soc-lpass-rx-macro.o
> diff --git a/sound/soc/codecs/lpass-macro-common.c b/sound/soc/codecs/lpass-macro-common.c
> new file mode 100644
> index 0000000..b8e50e6
> --- /dev/null
> +++ b/sound/soc/codecs/lpass-macro-common.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) 2022, The Linux Foundation. All rights reserved.
> +
> +#include <linux/export.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "lpass-macro-common.h"
> +
> +int lpass_macro_pds_init(struct platform_device *pdev, struct lpass_macro **pds)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct lpass_macro *l_pds;
> +	int ret;
> +
> +	const struct property *prop = of_find_property(dev->of_node, "power-domains", NULL);
> +
> +	if (!prop)
> +		return 0;

how about
	if (!of_property_read_bool(dev->of_node, "power-domains"))
		return 0;

> +
> +	l_pds = devm_kzalloc(dev, sizeof(*l_pds), GFP_KERNEL);
> +	if (!l_pds)
> +		return -ENOMEM;
> +
> +	l_pds->macro_pd = dev_pm_domain_attach_by_name(dev,  "macro");
> +	if (IS_ERR_OR_NULL(l_pds->macro_pd)) {
> +		ret = PTR_ERR(l_pds->macro_pd) ? : -ENODATA;
> +		return ret;
> +	}
> +	ret = pm_runtime_get_sync(l_pds->macro_pd);
> +	if (ret < 0) {
> +		dev_err(dev, "%s failed for macro_pd, ret %d\n", __func__, ret);
> +		dev_pm_domain_detach(l_pds->macro_pd, false);
> +		pm_runtime_put_noidle(l_pds->macro_pd);
> +		return ret;
> +	}
> +
> +	l_pds->dcodec_pd = dev_pm_domain_attach_by_name(dev, "dcodec");
> +	if (IS_ERR_OR_NULL(l_pds->dcodec_pd)) {
> +		ret = PTR_ERR(l_pds->dcodec_pd) ? : -ENODATA;
> +		dev_pm_domain_detach(l_pds->macro_pd, false);
> +		return ret;
> +	}
> +
> +	ret = pm_runtime_get_sync(l_pds->dcodec_pd);
> +	if (ret < 0) {
> +		dev_err(dev, "%s failed for dcodec_pd, ret %d\n", __func__, ret);
> +
> +		dev_pm_domain_detach(l_pds->dcodec_pd, false);
should you not detach and do pm_put on macro_pd here?

> +		pm_runtime_put_noidle(l_pds->dcodec_pd);
> +		return ret;
> +	}
> +	*pds = l_pds;
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(lpass_macro_pds_init);
> +
> +void lpass_macro_pds_exit(struct platform_device *pdev, struct lpass_macro *pds)
> +{
> +	pm_runtime_put(pds->macro_pd);
> +	pm_runtime_put(pds->dcodec_pd);
> +	dev_pm_domain_detach(pds->macro_pd, false);
> +	dev_pm_domain_detach(pds->dcodec_pd, false);
> +}
> +EXPORT_SYMBOL_GPL(lpass_macro_pds_exit);
> +
> +MODULE_DESCRIPTION("QTI SC7280 LPI GPIO pin control driver");
Seems incorrect description for the module.

> +MODULE_LICENSE("GPL");
> diff --git a/sound/soc/codecs/lpass-macro-common.h b/sound/soc/codecs/lpass-macro-common.h
> new file mode 100644
> index 0000000..c343f0e
> --- /dev/null
> +++ b/sound/soc/codecs/lpass-macro-common.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef __LPASS_MACRO_COMMON_H__
> +#define __LPASS_MACRO_COMMON_H__
> +
> +
> +struct lpass_macro {
> +	struct device *macro_pd;
> +	struct device *dcodec_pd;
> +};
> +
> +int lpass_macro_pds_init(struct platform_device *pdev, struct lpass_macro **pds);
> +void lpass_macro_pds_exit(struct platform_device *pdev, struct lpass_macro *pds);
> +
> +#endif /* __LPASS_MACRO_COMMON_H__ */
> diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
> index 29d214f..db32090 100644
> --- a/sound/soc/codecs/lpass-rx-macro.c
> +++ b/sound/soc/codecs/lpass-rx-macro.c
> @@ -14,6 +14,8 @@
>   #include <linux/of_clk.h>
>   #include <linux/clk-provider.h>
>   
> +#include "lpass-macro-common.h"
> +
>   #define CDC_RX_TOP_TOP_CFG0		(0x0000)
>   #define CDC_RX_TOP_SWR_CTRL		(0x0008)
>   #define CDC_RX_TOP_DEBUG		(0x000C)
> @@ -606,7 +608,7 @@ struct rx_macro {
>   	int is_softclip_on;
>   	int is_aux_hpf_on;
>   	int softclip_clk_users;
> -
> +	struct lpass_macro *pds;
>   	struct regmap *regmap;
>   	struct clk_bulk_data clks[RX_NUM_CLKS_MAX];
>   	struct clk_hw hw;
> @@ -3537,6 +3539,12 @@ static int rx_macro_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> +	ret = lpass_macro_pds_init(pdev, &rx->pds);
> +	if (ret < 0) {
> +		dev_err(dev, "Enabling power domains failed in %s\n", __func__);
> +		return ret;
> +	}
> +
>   	base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
> @@ -3575,6 +3583,9 @@ static int rx_macro_remove(struct platform_device *pdev)
>   
>   	of_clk_del_provider(pdev->dev.of_node);
>   	clk_bulk_disable_unprepare(RX_NUM_CLKS_MAX, rx->clks);
> +
> +	lpass_macro_pds_exit(pdev, rx->pds);
> +
>   	return 0;
>   }
>   
> diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
> index 9c96ab1..4d1e5ab 100644
> --- a/sound/soc/codecs/lpass-tx-macro.c
> +++ b/sound/soc/codecs/lpass-tx-macro.c
> @@ -13,6 +13,8 @@
>   #include <linux/of_clk.h>
>   #include <linux/clk-provider.h>
>   
> +#include "lpass-macro-common.h"
> +
>   #define CDC_TX_CLK_RST_CTRL_MCLK_CONTROL (0x0000)
>   #define CDC_TX_MCLK_EN_MASK		BIT(0)
>   #define CDC_TX_MCLK_ENABLE		BIT(0)
> @@ -266,6 +268,7 @@ struct tx_macro {
>   	u16 dmic_clk_div;
>   	bool bcs_enable;
>   	int dec_mode[NUM_DECIMATORS];
> +	struct lpass_macro *pds;
>   	bool bcs_clk_en;
>   };
>   #define to_tx_macro(_hw) container_of(_hw, struct tx_macro, hw)
> @@ -1802,6 +1805,11 @@ static int tx_macro_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> +	ret = lpass_macro_pds_init(pdev, &tx->pds);
> +	if (ret < 0) {
> +		dev_err(dev, "Enabling power domains failed in %s\n", __func__);
> +		return ret;
> +	}
>   	base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
> @@ -1859,6 +1867,8 @@ static int tx_macro_remove(struct platform_device *pdev)
>   
>   	clk_bulk_disable_unprepare(TX_NUM_CLKS_MAX, tx->clks);
>   
> +	lpass_macro_pds_exit(pdev, tx->pds);
> +
>   	return 0;
>   }
>   
> diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
> index 11147e3..b29b9a1 100644
> --- a/sound/soc/codecs/lpass-va-macro.c
> +++ b/sound/soc/codecs/lpass-va-macro.c
> @@ -15,6 +15,8 @@
>   #include <sound/soc-dapm.h>
>   #include <sound/tlv.h>
>   
> +#include "lpass-macro-common.h"
> +
>   /* VA macro registers */
>   #define CDC_VA_CLK_RST_CTRL_MCLK_CONTROL	(0x0000)
>   #define CDC_VA_MCLK_CONTROL_EN			BIT(0)
> @@ -195,6 +197,7 @@ struct va_macro {
>   	struct regmap *regmap;
>   	struct clk_bulk_data clks[VA_NUM_CLKS_MAX];
>   	struct clk_hw hw;
> +	struct lpass_macro *pds;
>   
>   	s32 dmic_0_1_clk_cnt;
>   	s32 dmic_2_3_clk_cnt;
> @@ -1413,7 +1416,11 @@ static int va_macro_probe(struct platform_device *pdev)
>   		dev_err(dev, "Error getting VA Clocks (%d)\n", ret);
>   		return ret;
>   	}
> -
> +	ret = lpass_macro_pds_init(pdev, &va->pds);
> +	if (ret < 0) {
> +		dev_err(dev, "Enabling power domains failed %s\n", __func__);
> +		return ret;
> +	}
>   	ret = of_property_read_u32(dev->of_node, "qcom,dmic-sample-rate",
>   				   &sample_rate);
>   	if (ret) {
> @@ -1468,6 +1475,8 @@ static int va_macro_remove(struct platform_device *pdev)
>   
>   	clk_bulk_disable_unprepare(VA_NUM_CLKS_MAX, va->clks);
>   
> +	lpass_macro_pds_exit(pdev, va->pds);
> +
>   	return 0;
>   }
>   
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 52db003..6ffd51a 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -194,6 +194,7 @@ config SND_SOC_SC7280
>   	select SND_SOC_LPASS_SC7280
>   	select SND_SOC_MAX98357A
>   	select SND_SOC_WCD938X
> +	select SND_SOC_LPASS_MACRO_COMMON
>   	select SND_SOC_LPASS_RX_MACRO
>   	select SND_SOC_LPASS_TX_MACRO
>   	help
