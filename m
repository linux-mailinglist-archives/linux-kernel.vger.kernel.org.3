Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A8952E154
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344076AbiETApK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbiETApG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:45:06 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE451312B5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:45:04 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220520004500epoutp03bd1b78d947343249955c2bf48fa1e1dc~wqZAxi5v41540415404epoutp03f
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:45:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220520004500epoutp03bd1b78d947343249955c2bf48fa1e1dc~wqZAxi5v41540415404epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653007500;
        bh=H+x9whNKKDyPMWBsb72tWC82bJcv/wbdUdOuWAik8ps=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=UPU8VKDU/ariXBwXSXSBljdSF35AHEXybmPgHUnKOqFPwgyYl7edL5i+8/Ti3ji1G
         Cc6IwsBNEThUAXL2Go5UlkkOOSzktaN2+30XYOK+VGhRkUhu+wYSRFjaFfq1uMwsVg
         TfntTt3ay9KFOCfxV6XhSg+RTPCtzROrcl9HcmWs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220520004459epcas1p3e45169ab386611018776b054d6588cd5~wqZAHBRvB2114221142epcas1p31;
        Fri, 20 May 2022 00:44:59 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.133]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4L47Kk1lsTz4x9Q7; Fri, 20 May
        2022 00:44:58 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.1C.10063.A84E6826; Fri, 20 May 2022 09:44:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220520004457epcas1p19606a414121e8b7ed880d83d2f41caa2~wqY_gUed-1036810368epcas1p1m;
        Fri, 20 May 2022 00:44:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220520004457epsmtrp1f19fa1669821a8b466dc4031ef8155b2~wqY_fR48G1295112951epsmtrp1R;
        Fri, 20 May 2022 00:44:57 +0000 (GMT)
X-AuditID: b6c32a35-1f1ff7000000274f-52-6286e48ad3f1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.89.11276.984E6826; Fri, 20 May 2022 09:44:57 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220520004457epsmtip271f1ec1de18c4fec2308090729f2a955~wqY_MAwOl3262732627epsmtip2Y;
        Fri, 20 May 2022 00:44:57 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] devfreq: qcom: Add L2 Krait Cache devfreq
 scaling driver
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <53bcf684-54e7-13e2-2b41-26b6791f7469@samsung.com>
Date:   Fri, 20 May 2022 10:11:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200929162926.139-1-ansuelsmth@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmnm7Xk7Ykg/1rOS3OPf7NYjH15DcW
        i9P737FYzD9yjtXibNMbdouJ+8+yW1zeNYfN4nPvEUaL240r2Cxa9x5hd+Dy2DnrLrvHplWd
        bB53ru1h8+jbsorR4/MmuQDWqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWF
        vMTcVFslF58AXbfMHKCrlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFpgV6xYm5
        xaV56Xp5qSVWhgYGRqZAhQnZGa0HLQt2RVW8PtzD1MA4xaOLkZNDQsBE4knzfeYuRi4OIYEd
        jBJflj5mh3A+MUr8uHOBFcL5xigxdeJ8FpiW/31rGSESexklrr2exwbhvGeUWLZwNytIlbBA
        mMTvN2fAbBEBT4mWpr1MIDazwHwmiea5ISA2m4CWxP4XN9hAbH4BRYmrPx4zgti8AnYSFy8/
        AYuzCKhKdD19wQ5iiwLNPLmtBapGUOLkzCdgF3EKWEj8mbKDBWK+uMStJ/OhdslLbH87B+w5
        CYG1HBLT709jhXjBRWLOqU5GCFtY4tXxLewQtpTEy/42doiGZkaJhhe3GSGcHkaJo8/6oAFg
        LLF/6WSgFRxAKzQl1u/ShwgrSuz8PZcRYjOfxLuvPawgJRICvBIdbUIQJcoSlx/cZYKwJSUW
        t3eyTWBUmoXkn1lIfpiF5IdZCMsWMLKsYhRLLSjOTU8tNiwwhEd3cn7uJkZwktUy3cE48e0H
        vUOMTByMhxglOJiVRHgZc1uShHhTEiurUovy44tKc1KLDzGaAkN4IrOUaHI+MM3nlcQbmlga
        mJgZGZtYGJoZKonzrpp2OlFIID2xJDU7NbUgtQimj4mDU6qBKbrDh6ml7eaCPRnNX3NY92sX
        z9hbva/ecHXiyQkVcduu+DeF+Ha/PDa1nus1f9OJg1MkXvPdFFlkMWOH9uQzQfbBKqpp8VfU
        zJmyqn9ptWx7cN9qvUde06IlNneaG/bb+ekG5G76c/bsfNMDjRcNPv6d33Hx99M/16emVH0K
        U1z+vYvPvsKQZ87WgvVPf0x7FLNoo3qRkWLx9VKzM9/KpwsvtF4n8CNGpPgzo7zD3skfjt2W
        bLtUpPrqx9/+G483adZdOb9F2SDaRMRyvX3L7b5Lht2ZZxY8CXnmOqGF9ca0jnUdN22WrvNI
        NeDddVVqr8e93P85L+UX251Y+d9iq9Cbb5evHtutOi9AtfPFq2tKLMUZiYZazEXFiQDMzqkp
        OwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvG7nk7Ykg7vtMhbnHv9msZh68huL
        xen971gs5h85x2pxtukNu8XE/WfZLS7vmsNm8bn3CKPF7cYVbBate4+wO3B57Jx1l91j06pO
        No871/awefRtWcXo8XmTXABrFJdNSmpOZllqkb5dAldG60HLgl1RFa8P9zA1ME7x6GLk5JAQ
        MJH437eWEcQWEtjNKHHrTBVEXFJi2sWjzF2MHEC2sMThw8VdjFxAJW8ZJU48WcMKUiMsECbx
        +uFHMFtEwFOipWkvE0gRs8BCJolX6++yQXR0M0qser2ZHaSKTUBLYv+LG2wgNr+AosTVH4/B
        NvMK2ElcvPwELM4ioCrR9fQFWL0o0IadSx4zQdQISpyc+YQFxOYUsJD4M2UHmM0soC7xZ94l
        ZghbXOLWk/lMELa8xPa3c5gnMArPQtI+C0nLLCQts5C0LGBkWcUomVpQnJueW2xYYJiXWq5X
        nJhbXJqXrpecn7uJERxrWpo7GLev+qB3iJGJg/EQowQHs5IIL2NuS5IQb0piZVVqUX58UWlO
        avEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTBOjXY/fOKTlt8XlrMqk3fq1N3Mt
        9UO/8gd83KpZe+/Wg2CDHGe/oKzos+/Cni+PCpvap8zeUZnGLL/ycpa3sYVyW/GngLwNjgEt
        DHLKN73ajJyUTPtMfKTXBtYpZE//vi/hyl89zRmLndKiatPf5WZM8jMK3iO0fO6/DxorSt5c
        POvLMGf6smU5vr/lNz3lOq556R3Xj8b3MSLbTCNEVmgUGfYnMv/aPN++kHFho8Y67bMHDc/l
        XXx2jOPm1EdzHPu0rmxfx88jErn42psOhh8bFznEVf7qlN/bs930Qu769lYrziMhf2yeK0TX
        cnILi69Y2Zhdc9wkbcMCt+xHBT4cf7bfEC6JuVESv/CMEktxRqKhFnNRcSIAfJklySQDAAA=
X-CMS-MailID: 20220520004457epcas1p19606a414121e8b7ed880d83d2f41caa2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200929162941epcas1p4a6f524f2406785934918c2a9f556ae4b
References: <CGME20200929162941epcas1p4a6f524f2406785934918c2a9f556ae4b@epcas1p4.samsung.com>
        <20200929162926.139-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ansuel,


The 5.19-rc1 will support the cpu based scaling support[2]
as your needed. So that if you use passive governor with CPUFREQ_PARENT_DEV,
you can scale the cache frequency according to cpu frequency change.

[1] https://patchwork.kernel.org/project/linux-pm/patch/3acd6c32-6e78-dfc2-3e45-84f69a7d5f36@samsung.com/
[2] PM / devfreq: Add cpu based scaling support to passive governor


Best Regards,
Chanwoo Choi

On 9/30/20 1:29 AM, Ansuel Smith wrote:
> Qcom L2 Krait CPUs use the generic cpufreq-dt driver and doesn't actually
> scale the Cache frequency when the CPU frequency is changed. This
> devfreq driver register with the cpu notifier and scale the Cache
> based on the max Freq across all core as the CPU cache is shared across
> all of them. If provided this also scale the voltage of the regulator
> attached to the CPU cache. The scaling logic is based on the CPU freq
> and the 3 scaling interval are set by the device dts.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
> v2:
> * Change cpu-freq to qcom,cpu-freq
> * Skip freq change if prev is the same target freq
> 
>  drivers/devfreq/Kconfig               |  10 +
>  drivers/devfreq/Makefile              |   1 +
>  drivers/devfreq/krait-cache-devfreq.c | 301 ++++++++++++++++++++++++++
>  3 files changed, 312 insertions(+)
>  create mode 100644 drivers/devfreq/krait-cache-devfreq.c
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 37dc40d1fcfb..99051aaf9c5e 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -143,6 +143,16 @@ config ARM_RK3399_DMC_DEVFREQ
>  	  It sets the frequency for the memory controller and reads the usage counts
>  	  from hardware.
>  
> +config ARM_KRAIT_CACHE_DEVFREQ
> +	tristate "Scaling support for Krait CPU Cache Devfreq"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	help
> +	  This adds the DEVFREQ driver for the Krait CPU L2 Cache shared by all cores.
> +
> +	  The driver register with the cpufreq notifier and find the right frequency
> +	  based on the max frequency across all core and the range set in the device
> +	  dts. If provided this scale also the regulator attached to the l2 cache.
> +
>  source "drivers/devfreq/event/Kconfig"
>  
>  endif # PM_DEVFREQ
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 3ca1ad0ecb97..bb87925a6a2d 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
>  obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
> +obj-$(CONFIG_ARM_KRAIT_CACHE_DEVFREQ)	+= krait-cache-devfreq.o
>  
>  # DEVFREQ Event Drivers
>  obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
> diff --git a/drivers/devfreq/krait-cache-devfreq.c b/drivers/devfreq/krait-cache-devfreq.c
> new file mode 100644
> index 000000000000..101a13b6927a
> --- /dev/null
> +++ b/drivers/devfreq/krait-cache-devfreq.c
> @@ -0,0 +1,301 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/cpufreq.h>
> +#include <linux/devfreq.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/slab.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/pm_opp.h>
> +
> +#include "governor.h"
> +
> +struct krait_data {
> +	struct device *dev;
> +	struct devfreq *devfreq;
> +
> +	struct clk *l2_clk;
> +
> +	unsigned long *freq_table; /* L2 bus clock rate */
> +	unsigned int *l2_cpufreq; /* L2 target CPU frequency */
> +
> +	struct notifier_block nb;
> +};
> +
> +static int krait_cache_set_opp(struct dev_pm_set_opp_data *data)
> +{
> +	unsigned long old_freq = data->old_opp.rate, freq = data->new_opp.rate;
> +	struct dev_pm_opp_supply *supply = &data->new_opp.supplies[0];
> +	struct regulator *reg = data->regulators[0];
> +	struct clk *clk = data->clk;
> +	struct krait_data *kdata;
> +	unsigned long idle_freq;
> +	int ret;
> +
> +	kdata = (struct krait_data *)dev_get_drvdata(data->dev);
> +
> +	idle_freq = kdata->freq_table[0];
> +
> +	if (reg) {
> +		ret = regulator_set_voltage_triplet(reg, supply->u_volt_min,
> +						    supply->u_volt,
> +						    supply->u_volt_max);
> +		if (ret)
> +			goto exit;
> +	}
> +
> +	/*
> +	 * Set to idle bin if switching from normal to high bin
> +	 * or vice versa. It has been notice that a bug is triggered
> +	 * in cache scaling when more than one bin is scaled, to fix
> +	 * this we first need to transition to the base rate and then
> +	 * to target rate
> +	 */
> +	if (likely(freq != idle_freq && old_freq != idle_freq)) {
> +		ret = clk_set_rate(clk, idle_freq);
> +		if (ret)
> +			goto exit;
> +	}
> +
> +	ret = clk_set_rate(clk, freq);
> +	if (ret)
> +		goto exit;
> +
> +exit:
> +	return ret;
> +};
> +
> +static int krait_cache_target(struct device *dev, unsigned long *freq,
> +			      u32 flags)
> +{
> +	return dev_pm_opp_set_rate(dev, *freq);
> +};
> +
> +static int krait_cache_get_dev_status(struct device *dev,
> +				      struct devfreq_dev_status *stat)
> +{
> +	struct krait_data *data = dev_get_drvdata(dev);
> +
> +	stat->busy_time = 0;
> +	stat->total_time = 0;
> +	stat->current_frequency = clk_get_rate(data->l2_clk);
> +
> +	return 0;
> +};
> +
> +static int krait_cache_get_cur_freq(struct device *dev, unsigned long *freq)
> +{
> +	struct krait_data *data = dev_get_drvdata(dev);
> +
> +	*freq = clk_get_rate(data->l2_clk);
> +
> +	return 0;
> +};
> +
> +static struct devfreq_dev_profile tegra_devfreq_profile = {
> +	.target = krait_cache_target,
> +	.get_dev_status = krait_cache_get_dev_status,
> +	.get_cur_freq = krait_cache_get_cur_freq
> +};
> +
> +static int krait_cache_notifier(struct notifier_block *nb, unsigned long action,
> +				void *v)
> +{
> +	struct cpufreq_freqs *freqs;
> +	unsigned int cpu, cur_cpu;
> +	struct krait_data *data;
> +	struct devfreq *devfreq;
> +	unsigned long freq;
> +	int ret = 0;
> +
> +	if (action != CPUFREQ_POSTCHANGE)
> +		return NOTIFY_OK;
> +
> +	data = container_of(nb, struct krait_data, nb);
> +	devfreq = data->devfreq;
> +
> +	mutex_lock_nested(&devfreq->lock, SINGLE_DEPTH_NESTING);
> +
> +	freqs = (struct cpufreq_freqs *)v;
> +	freq = freqs->new;
> +	cur_cpu = freqs->policy->cpu;
> +
> +	/* find the max freq across all core */
> +	for_each_present_cpu(cpu)
> +		if (cpu != cur_cpu)
> +			freq = max(freq, (unsigned long)cpufreq_quick_get(cpu));
> +
> +	devfreq->governor->get_target_freq(devfreq, &freq);
> +
> +	if (devfreq->previous_freq == freq)
> +		goto out;
> +
> +	ret = devfreq->profile->target(data->dev, &freq, 0);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (devfreq->profile->freq_table &&
> +	    (devfreq_update_status(devfreq, freq)))
> +		dev_err(data->dev,
> +			"Couldn't update frequency transition information.\n");
> +
> +	devfreq->previous_freq = freq;
> +
> +out:
> +	mutex_unlock(&devfreq->lock);
> +	return notifier_from_errno(ret);
> +};
> +
> +static int krait_cache_governor_get_target(struct devfreq *devfreq,
> +					   unsigned long *freq)
> +{
> +	unsigned int *l2_cpufreq;
> +	unsigned long *freq_table;
> +	unsigned long target_freq = *freq;
> +	struct krait_data *data = dev_get_drvdata(devfreq->dev.parent);
> +
> +	l2_cpufreq = data->l2_cpufreq;
> +	freq_table = data->freq_table;
> +
> +	/*
> +	 * Find the highest l2 freq interval based on the max cpufreq
> +	 * across all core
> +	 */
> +	while (*(l2_cpufreq = l2_cpufreq + 1) && target_freq >= *l2_cpufreq)
> +		freq_table = freq_table + 1;
> +
> +	*freq = *freq_table;
> +
> +	return 0;
> +};
> +
> +static int krait_cache_governor_event_handler(struct devfreq *devfreq,
> +					      unsigned int event, void *data)
> +{
> +	struct krait_data *kdata = dev_get_drvdata(devfreq->dev.parent);
> +	int ret = 0;
> +
> +	switch (event) {
> +	case DEVFREQ_GOV_START:
> +		kdata->nb.notifier_call = krait_cache_notifier;
> +		ret = cpufreq_register_notifier(&kdata->nb,
> +						CPUFREQ_TRANSITION_NOTIFIER);
> +		break;
> +
> +	case DEVFREQ_GOV_STOP:
> +		cpufreq_unregister_notifier(&kdata->nb,
> +					    CPUFREQ_TRANSITION_NOTIFIER);
> +		break;
> +	}
> +
> +	return ret;
> +};
> +
> +static struct devfreq_governor krait_devfreq_governor = {
> +	.name = "krait_governor",
> +	.get_target_freq = krait_cache_governor_get_target,
> +	.event_handler = krait_cache_governor_event_handler,
> +	.immutable = true,
> +};
> +
> +static int krait_cache_probe(struct platform_device *pdev)
> +{
> +	int ret, count;
> +	struct opp_table *table;
> +	struct krait_data *data;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->dev = dev;
> +
> +	data->l2_clk = devm_clk_get(dev, "l2");
> +	if (IS_ERR(data->l2_clk))
> +		return PTR_ERR(data->l2_clk);
> +
> +	table = dev_pm_opp_set_regulators(dev, (const char *[]){ "l2" }, 1);
> +	if (IS_ERR(table)) {
> +		ret = PTR_ERR(table);
> +		dev_err(dev, "failed to set regulators %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = PTR_ERR_OR_ZERO(
> +		dev_pm_opp_register_set_opp_helper(dev, krait_cache_set_opp));
> +	if (ret)
> +		return ret;
> +
> +	ret = dev_pm_opp_of_add_table(dev);
> +	if (ret) {
> +		dev_err(dev, "failed to parse L2 freq thresholds\n");
> +		return ret;
> +	}
> +
> +	count = dev_pm_opp_get_opp_count(dev);
> +
> +	data->l2_cpufreq =
> +		devm_kzalloc(dev, sizeof(unsigned int) * count, GFP_KERNEL);
> +	if (!data->l2_cpufreq)
> +		return -ENOMEM;
> +
> +	ret = of_property_read_u32_array(node, "qcom,l2-cpufreq", data->l2_cpufreq,
> +					 count);
> +	if (ret) {
> +		dev_err(dev, "failed to parse L2 cpufreq thresholds\n");
> +		return ret;
> +	}
> +
> +	ret = devfreq_add_governor(&krait_devfreq_governor);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to add governor: %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	data->devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
> +					   "krait_governor", NULL);
> +
> +	/* Cache freq_table to quickly get it when needed */
> +	data->freq_table = data->devfreq->profile->freq_table;
> +
> +	if (IS_ERR(data->devfreq))
> +		return PTR_ERR(data->devfreq);
> +
> +	return 0;
> +};
> +
> +static int krait_cache_remove(struct platform_device *pdev)
> +{
> +	struct krait_data *data = platform_get_drvdata(pdev);
> +
> +	dev_pm_opp_remove_table(data->dev);
> +
> +	return 0;
> +};
> +
> +static const struct of_device_id krait_cache_match_table[] = {
> +	{ .compatible = "qcom,krait-cache" },
> +	{}
> +};
> +
> +static struct platform_driver krait_cache_driver = {
> +	.probe		= krait_cache_probe,
> +	.remove		= krait_cache_remove,
> +	.driver		= {
> +		.name   = "krait-cache-scaling",
> +		.of_match_table = krait_cache_match_table,
> +	},
> +};
> +module_platform_driver(krait_cache_driver);
> +
> +MODULE_DESCRIPTION("Krait CPU Cache Scaling driver");
> +MODULE_AUTHOR("Ansuel Smith <ansuelsmth@gmail.com>");
> +MODULE_LICENSE("GPL v2");
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
