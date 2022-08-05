Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5492058A82F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbiHEIiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240208AbiHEIiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:38:10 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E5F1012
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 01:38:08 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t1so2451455lft.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 01:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ru95pcY29ysrzztwTIPBRMhkSbEiCS+jLcRwqJCZJdU=;
        b=TLDoHtOISqPKSZBs9irgoGEUTKZBNrThDe4lTlPHvHkbbOMNJamMRd0+QIg4TrrvJW
         sImYvjiKRqbslr8KnCx8kpivS2yrBvALCSoQtUBUGQB7eYFKvoDol1k4JA7px/o2Yeg8
         A84G+dJv1PTOlLqaqXEIUhcl2Hs0iiI4gpYaOubNjD5D8nJufdvDsLnUzfHFQ6Vk2z1u
         nF0m2itjX4Om6Vr6Nf3ds4TyOgZ4UioT+/YdZ8k+x4abtHFVAjoaWxbJq70rdMK4wFxK
         dpvdcC1ht5bAIoUhURwpAtLbEzRKsuyb9S8CYImxgwD73BCxRKb352y8pgYlIIAi0Kht
         scAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ru95pcY29ysrzztwTIPBRMhkSbEiCS+jLcRwqJCZJdU=;
        b=iFHRTuN9cfeKpe+SZMDPGQJqTq3iKaQXJHIjabRZRHRyBF8DmJob0Jthq9GMbSj9jo
         smmyFHIF+thYE8J/X95/ccetZLzKLWk5RJeI1jMC3iELpVoOGGyN7vc2e08vJbo+Wt19
         tdMC4LGoyWN2EUEYYiZ8D2h83e2JMBh6HctKSa2gK7ExHJ0E5tlMIJxvs/9hYS+Hm7oe
         Cya3sKQAup8iKPkJaADawJ6MU+DiTCQKOtSgw4MjXfDxbAeVOFuukKjuhju8STeL0eTz
         JmTRj+mIQ3lkx9N5zl44mumlQAxqH7AdKSiCZwgT+vpoZSX52XhCfq2MRg3T2PX7moEq
         jpZw==
X-Gm-Message-State: ACgBeo2in/qfEI1fk6llCr3Ei78pBEbE4hUmYl5Eg07l5Ry2cdnkgn/Z
        M165lg+flyfhVqdBw9+9x398BA==
X-Google-Smtp-Source: AA6agR6szmluNvoQnqbtmKKsz9SWsN1TKB7TPBWrD668iC98iW+KCfJszC4Ett2dP8UHUBYdYV421Q==
X-Received: by 2002:a05:6512:3e13:b0:48a:9371:3ccb with SMTP id i19-20020a0565123e1300b0048a93713ccbmr1914248lfv.504.1659688686989;
        Fri, 05 Aug 2022 01:38:06 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id y1-20020a056512044100b0048a88c07bcdsm396413lfk.20.2022.08.05.01.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 01:38:06 -0700 (PDT)
Message-ID: <3597d068-2c44-9450-4a0c-4704f3639a37@linaro.org>
Date:   Fri, 5 Aug 2022 10:38:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 1/4] perf/amlogic: Add support for Amlogic meson G12
 SoC DDR PMU driver
Content-Language: en-US
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chris Healy <cphealy@gmail.com>,
        kernel test robot <lkp@intel.com>
References: <20220805071426.2598818-1-jiucheng.xu@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220805071426.2598818-1-jiucheng.xu@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2022 09:14, Jiucheng Xu wrote:
> This patch adds support Amlogic meson G12 series SoC
> DDR bandwidth PMU driver framework and interfaces.
> 
> The PMU not only can monitor the total DDR bandwidth,
> but also the bandwidth which is from individual IP module.
> 
> Example usage:
> 
>  $ perf stat -a -e aml_ddr_bw/total_rw_bytes/ -I 1000 sleep 10
> 
> - or -

Thank you for your patch. There is something to discuss/improve.

> +
> +static void fmt_attr_fill(struct attribute **fmt_attr)
> +{
> +	int i;
> +
> +	for (i = 0; fmt_attr[i]; i++)
> +		ddr_perf_format_attrs[i] = fmt_attr[i];
> +
> +	ddr_perf_format_attrs[i] = NULL;
> +}
> +
> +static int ddr_pmu_parse_dt(struct platform_device *pdev, struct dmc_hw_info *info)
> +{
> +	/*struct pinctrl *p;*/

No dead code in kernel.

> +	void __iomem *base;
> +	int i, ret = -EINVAL;
> +
> +	for (i = 0; i < info->dmc_nr; i++) {

Your binding does not allow to have more than 1. Remove dead code.

> +		/* resource 0 for ddr register base */
> +		base = devm_platform_ioremap_resource(pdev, i);
> +		if (IS_ERR(base)) {
> +			dev_err(&pdev->dev, "couldn't ioremap ddr reg %d\n", i);

Error message is not needed.

> +			return PTR_ERR(base);
> +		}
> +		info->ddr_reg[i] = base;
> +	}
> +
> +	/* resource i for pll register base */
> +	base = devm_platform_ioremap_resource(pdev, i);
> +	if (IS_ERR(base)) {
> +		dev_err(&pdev->dev, "couldn't ioremap for pll reg\n");

Error message is not needed.

> +		return PTR_ERR(base);
> +	}
> +	info->pll_reg = base;
> +
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "couldn't get irq\n");

Error message is not needed.

> +		return ret;
> +	}
> +	info->irq_num = ret;
> +
> +	ret = devm_request_irq(&pdev->dev, info->irq_num, dmc_irq_handler,
> +			       IRQF_NOBALANCING, dev_name(&pdev->dev),
> +			       (void *)info);
> +	if (ret < 0)
> +		dev_err(&pdev->dev, "ddr request irq failed\n");
> +
> +	return ret;
> +}
> +
> +int meson_ddr_pmu_create(struct platform_device *pdev, struct ddr_pmu *pmu)
> +{
> +	int ret;
> +	char *name;
> +	struct pmu tmp_pmu = {
> +		.module		= THIS_MODULE,
> +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> +		.task_ctx_nr	= perf_invalid_context,
> +		.attr_groups	= attr_groups,
> +		.event_init	= meson_ddr_perf_event_init,
> +		.add		= meson_ddr_perf_event_add,
> +		.del		= meson_ddr_perf_event_del,
> +		.start		= meson_ddr_perf_event_start,
> +		.stop		= meson_ddr_perf_event_stop,
> +		.read		= meson_ddr_perf_event_update,
> +	};
> +
> +	pmu->pmu = tmp_pmu;
> +
> +	ret = ddr_pmu_parse_dt(pdev, &pmu->info);
> +	if (ret < 0)
> +		return ret;
> +
> +	fmt_attr_fill(pmu->info.fmt_attr);
> +
> +	pmu->cpu = raw_smp_processor_id();

smp_processor_id()
(or why do you need to use raw?)


> +
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, DDR_PERF_DEV_NAME);
> +	if (!name) {
> +		dev_err(&pdev->dev, "couldn't allocat name\n");

No error messages for allocation. Run basic tools on your code -
coccinelle, checkaptch, smatch and sparse.

> +		return -ENOMEM;
> +	}
> +
> +	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, name, NULL,
> +				      ddr_perf_offline_cpu);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "cpuhp_setup_state_multi failed\n");
> +		return ret;
> +	}
> +	pmu->cpuhp_state = ret;
> +
> +	/* Register the pmu instance for cpu hotplug */
> +	ret = cpuhp_state_add_instance_nocalls(pmu->cpuhp_state, &pmu->node);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Error %d registering hotplug\n", ret);
> +		goto cpuhp_instance_err;
> +	}
> +
> +	fill_event_attr(pmu);
> +
> +	ret = perf_pmu_register(&pmu->pmu, name, -1);
> +	if (ret) {
> +		dev_err(&pdev->dev, "perf pmu register failed\n");
> +		goto pmu_register_err;
> +	}
> +
> +	pmu->name = name;
> +	pmu->dev = &pdev->dev;
> +	pmu->pmu_enabled = false;
> +
> +	platform_set_drvdata(pdev, pmu);
> +
> +	return 0;
> +
> +pmu_register_err:
> +	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
> +cpuhp_instance_err:
> +	cpuhp_remove_state(pmu->cpuhp_state);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(meson_ddr_pmu_create);

Why is this exported?

Also misses kerneldoc.

> +
> +int meson_ddr_pmu_remove(struct platform_device *pdev)
> +{
> +	struct ddr_pmu *pmu = platform_get_drvdata(pdev);
> +
> +	perf_pmu_unregister(&pmu->pmu);
> +	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
> +	cpuhp_remove_state(pmu->cpuhp_state);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(meson_ddr_pmu_remove);

Why is this exported?

Also misses kerneldoc.

> diff --git a/drivers/perf/amlogic/meson_g12_ddr_pmu.c b/drivers/perf/amlogic/meson_g12_ddr_pmu.c
> new file mode 100644
> index 000000000000..ba1908733bee
> --- /dev/null
> +++ b/drivers/perf/amlogic/meson_g12_ddr_pmu.c
> @@ -0,0 +1,388 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Amlogic, Inc. All rights reserved.
> + */

(...)

> +static int dmc_g12_irq_handler(struct dmc_hw_info *info,
> +			       struct dmc_counter *counter)
> +{
> +	unsigned int val;
> +	int ret = -EINVAL;
> +
> +	val = readl(info->ddr_reg[0] + DMC_MON_G12_CTRL0);
> +	if (val & DMC_QOS_IRQ) {
> +		dmc_g12_get_counters(info, counter);
> +		/* clear irq flags */
> +		writel(val, info->ddr_reg[0] + DMC_MON_G12_CTRL0);
> +		ret = 0;
> +	}
> +	return ret;
> +}
> +
> +static struct dmc_pmu_hw_ops g12_ops = {

static const?

> +	.enable		= dmc_g12_counter_enable,
> +	.disable	= dmc_g12_counter_disable,
> +	.irq_handler	= dmc_g12_irq_handler,
> +	.get_counters	= dmc_g12_get_counters,
> +	.config_axi_id	= dmc_g12_config_axi_id,
> +};
> +
> +static int __init g12_ddr_pmu_probe(struct platform_device *pdev)
> +{
> +	struct ddr_pmu *pmu;
> +
> +	if (of_device_is_compatible(pdev->dev.of_node,
> +				    "amlogic,g12a-ddr-pmu")) {
> +		format_attr_nna.attr.mode = 0;
> +		format_attr_gdc.attr.mode = 0;
> +		format_attr_arm1.attr.mode = 0;
> +		format_attr_mipi_isp.attr.mode = 0;

No. That's not correct patter. You must use variant specific driver data.

> +	} else if (of_device_is_compatible(pdev->dev.of_node,
> +					   "amlogic,sm1-ddr-pmu")) {
> +		format_attr_gdc.attr.mode = 0;
> +		format_attr_arm1.attr.mode = 0;
> +		format_attr_mipi_isp.attr.mode = 0;

No. That's not correct patter. You must use variant specific driver data.

> +	}
> +
> +	pmu = devm_kzalloc(&pdev->dev, sizeof(struct ddr_pmu), GFP_KERNEL);
> +	if (!pmu)
> +		return -ENOMEM;
> +
> +	/*
> +	 * G12 series Soc have single dmc controller and
> +	 * 4x ddr bandwidth monitor channels
> +	 */
> +	pmu->info.dmc_nr = 1;
> +	pmu->info.chann_nr = 4;
> +	pmu->info.ops = &g12_ops;
> +	pmu->info.fmt_attr = g12_pmu_format_attrs;
> +
> +	return meson_ddr_pmu_create(pdev, pmu);
> +}
> +
> +static int __exit g12_ddr_pmu_remove(struct platform_device *pdev)
> +{
> +	meson_ddr_pmu_remove(pdev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id meson_ddr_pmu_dt_match[] = {
> +	{
> +		.compatible = "amlogic,g12-ddr-pmu",

Undocumented compatible. Did you run checkpatch and fix all the errors?

> +	},
> +	{
> +		.compatible = "amlogic,g12a-ddr-pmu",
> +	},
> +	{
> +		.compatible = "amlogic,g12b-ddr-pmu",
> +	},
> +	{
> +		.compatible = "amlogic,sm1-ddr-pmu",

Why four different entries for the same devices without driver data?
This is confusing.

> +	},
> +	{}
> +};
> +
> +static struct platform_driver g12_ddr_pmu_driver = {
> +	.driver = {
> +		.name = "amlogic,ddr-pmu",
> +		.of_match_table = meson_ddr_pmu_dt_match,
> +	},
> +	.remove = __exit_p(g12_ddr_pmu_remove),

You made the driver non-hotpluggable - why?
In the same time it is still unbindable, whis is a bit confusing. If you
can unbind it, you should be able to hot-unplug it.

> +};
> +
> +module_platform_driver_probe(g12_ddr_pmu_driver, g12_ddr_pmu_probe);
> +MODULE_AUTHOR("Jiucheng Xu");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Amlogic G12 series SoC DDR PMU");
> diff --git a/include/soc/amlogic/meson_ddr_pmu.h b/include/soc/amlogic/meson_ddr_pmu.h
> new file mode 100644
> index 000000000000..882efe3c2f58
> --- /dev/null
> +++ b/include/soc/amlogic/meson_ddr_pmu.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2022 Amlogic, Inc. All rights reserved.
> + */
> +
> +#ifndef __MESON_DDR_PMU_H__
> +#define __MESON_DDR_PMU_H__
> +
> +#define MAX_CHANNEL_NUM		8
> +
> +enum {
> +	ALL_CHAN_COUNTER_ID,
> +	CHAN1_COUNTER_ID,
> +	CHAN2_COUNTER_ID,
> +	CHAN3_COUNTER_ID,
> +	CHAN4_COUNTER_ID,
> +	CHAN5_COUNTER_ID,
> +	CHAN6_COUNTER_ID,
> +	CHAN7_COUNTER_ID,
> +	CHAN8_COUNTER_ID,
> +	COUNTER_MAX_ID,
> +};
> +
> +struct dmc_hw_info;
> +
> +struct dmc_counter {
> +	u64 all_cnt;	/* The count of all requests come in/out ddr controller */
> +	union {
> +		u64 all_req;
> +		struct {
> +			u64 all_idle_cnt;
> +			u64 all_16bit_cnt;
> +		};
> +	};
> +	u64 channel_cnt[MAX_CHANNEL_NUM]; /* To save a DMC bandwidth-monitor channel counter */
> +};
> +
> +struct dmc_pmu_hw_ops {
> +	void (*enable)(struct dmc_hw_info *info);
> +	void (*disable)(struct dmc_hw_info *info);
> +	/* Bind an axi line to a bandwidth-monitor channel */
> +	void (*config_axi_id)(struct dmc_hw_info *info, int axi_id, int chann);
> +	int (*irq_handler)(struct dmc_hw_info *info,
> +			   struct dmc_counter *counter);
> +	void (*get_counters)(struct dmc_hw_info *info,
> +			     struct dmc_counter *counter);
> +};
> +
> +struct dmc_hw_info {
> +	struct dmc_pmu_hw_ops *ops;
> +	void __iomem *ddr_reg[4];
> +	unsigned long timer_value;	/* Timer value in TIMER register */
> +	void __iomem *pll_reg;
> +	int irq_num;			/* irq vector number */
> +	int dmc_nr;			/* The number of dmc controller */
> +	int chann_nr;			/* The number of dmc bandwidth monitor channels */
> +	int id;				/* The number of supported channels */
> +	struct attribute **fmt_attr;
> +};
> +
> +struct ddr_pmu {
> +	struct pmu pmu;
> +	struct dmc_hw_info info;
> +	struct dmc_counter counters;	/* save counters from hw */
> +	bool pmu_enabled;
> +	struct device *dev;
> +	char *name;
> +	struct hlist_node node;
> +	enum cpuhp_state cpuhp_state;
> +	int cpu;			/* for cpu hotplug */
> +};

Linux-wide headers should not include your private data structures.
Entier header looks unused - should be made private.

Best regards,
Krzysztof
