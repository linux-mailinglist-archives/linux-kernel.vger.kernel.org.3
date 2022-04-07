Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F744F725D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 04:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbiDGC5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 22:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDGC5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:57:02 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4C613F8DA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 19:55:01 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220407025459epoutp033d4cca8371262c8dd076bfc4f307b4b0~jfbO85FJI2522225222epoutp03k
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:54:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220407025459epoutp033d4cca8371262c8dd076bfc4f307b4b0~jfbO85FJI2522225222epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649300099;
        bh=FHGgDd3j9QmedAxNGYRVun1IXthSwRBPHPAMo1pJs+Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=c5wT/0Nps5VtecSqazBkF/hzLR0EY8obkpOYllREf4pJTvaSkdagIr4uaNtID9kIV
         84wRUJQYBeectIsuCxKhHHw07VmfguvB0PDnnVMsAhL2BxmK14mE4cMk1toATy/edw
         a6RSj30wYq9GJc9nPRudSi1HBtg+k4WI7AOPLKEY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220407025458epcas1p4d702c2aede60ac3031cbd5828f443212~jfbN9z5jO1163011630epcas1p4b;
        Thu,  7 Apr 2022 02:54:58 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.234]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KYmFX32kbz4x9Pv; Thu,  7 Apr
        2022 02:54:56 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.4E.28648.0825E426; Thu,  7 Apr 2022 11:54:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220407025455epcas1p236e9bf6e53428d7f9942cbd383e4e125~jfbLl72nD2044120441epcas1p2M;
        Thu,  7 Apr 2022 02:54:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220407025455epsmtrp1745bf1cb3122d0db64d094f70914a831~jfbLkrQxF0320203202epsmtrp1a;
        Thu,  7 Apr 2022 02:54:55 +0000 (GMT)
X-AuditID: b6c32a39-003ff70000006fe8-67-624e52803e15
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.BC.03370.F725E426; Thu,  7 Apr 2022 11:54:55 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220407025455epsmtip25d005140d9cae5e75a277da632964c41~jfbLOlJMb3167731677epsmtip29;
        Thu,  7 Apr 2022 02:54:55 +0000 (GMT)
Subject: Re: [PATCH 2/3] devfreq: mediatek: add mt8183 cci devfreq driver
To:     Tim Chang <jia-wei.chang@mediatek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        roger.lu@mediatek.com, Allen-yy.Lin@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <7fbc8167-1a0a-889c-e747-94703f3c8f1c@samsung.com>
Date:   Thu, 7 Apr 2022 12:20:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20220307122513.11822-3-jia-wei.chang@mediatek.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0wTZxjHee/KtXWBnUXkHUsUD2ci4UcLLTsU0G0Mu0wNG4kmzrUccCml
        0Ha9dptkc+XHAMuPQWZlHihmYDaIYRmgQCvBIGoKapgFArKaERhFEFGxuMwlrOVw47/P8+Tz
        vM997+4VoKIpLFSg1hppg5bKI7BNvCvXd4ujzB8fzhTfbwsmr7nGENI6NYORjQN3/cmV318i
        ZK9tHCVv9TXzydtDEzzyTtEjPrkyUo6Q7dNj/qTT1oCRzuLfALlcNQDIfkspShaVxJGThT9j
        5LO2ch75be8An3RO/4rtD5L3sC6+/EK7Sd7eegqTdzR/Iy9x9PHkp2etPHl1ZyuQL7dvSxMc
        0yTm0FQ2bQijtVm6bLVWlUR8mK58TymLF0uiJAnk20SYlsqnk4iUg2lRqeo8bxwi7HMqz+Rt
        pVEMQ8QkJxp0JiMdlqNjjEkErc/O08v00QyVz5i0qmgtbdwjEYtjZV4xQ5Mz73jO1y/Ugi/Z
        wVwzWGIsQCiAuBQ+7Z7FLGCTQIR3A/igop7PFc8A7HI0+vssEb4MYO/fka8m7D/MAU6yAVhW
        UbEuLQHoKYnwcRD+AbxkeYL6pC14HQI9btvaBIrXoJA9PYX6LAyPgH1z45iPX8d3wNG/poGP
        A/BkeNuxtObw8J3Q3dm71g/Gj0DHlZJ1ZzN0nJ3h+ViI74d19ueIj1E8BN6faVzn7bBrsQHl
        HrtMCNkXCo5T4C82D5/jIDh/q3OdQ+HD70rX8kO8GEDz3CTgikoAb8xW8zgrDvZd/N67QeDd
        sNt7UgzX3gF7Xp4D3OJA+NhT6e9TIB4Ay0tFnBIOnX+4EI7fgE1lp7AaQLAb4rAbIrAbIrD/
        L7sAeK1gK61n8lU0I9HL/vvcWbr8drD2r0ckdIO6xSfR/QARgH4ABSixJaAg/2CmKCCbOlFA
        G3RKgymPZvqBzPuCa9HQ4Cyd97JojUqJNEEsjY+Nk5KSeAkREtB6ZogS4SrKSGtoWk8bXs0h
        AmGoGfnIGvtU1+EOs7iqKguzfrx4/sAuv6jAxeF6c7TkuPqda+B42Yq0N5W1+q0a64xoXcw+
        1UTGjTZn0wnXVlNk4IOjf1qG7346FRnupwk5WVuktItOtnxmVRZ2RBuLG5sa7igyGz3SogRF
        izp9pCe35tKxkEc3NaubU2Xhe14kCGsR9xRrZxbP20aaf3KluEWTrsJua7CfSL939K1to4+/
        2ndPdejeznnR10spsY7xwQqx9h/tJ/SbE4mCM+6FqsNWzDxIsMk9ifrLuxTvtjilXQsPh5sV
        Y6+1HUmfrM/B3189cNQzhFTvHTg7flNo/+JqboHy+lXh9mxhyWW1PVnBzyB4TA4liUANDPUv
        VYStfHQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCSvG59kF+SwYt7uhYH7l5jspj68Amb
        xfwj51gtvt35zWSxd9cNZovj+5ewW5w5fZPF4mzTG3aLb1c6mCw2Pb7GanF51xw2i8vNFxkt
        PvceYbQ41NXGbNHUYmxxu3EFm8WndR0sFq17j7BbXH68kc1B2GPnrLvsHgs2lXpsWtXJ5rF5
        Sb1Hy8n9LB5Tnk1l8ejbsorR4/MmuQCOKC6blNSczLLUIn27BK6MVye/sBe8nshYMetUVgPj
        ++IuRk4OCQETid0zXjB2MXJxCAnsYJRY+7GTCSIhKTHt4lHmLkYOIFtY4vDhYoiat4wS7ctv
        M4LUCAt4Sqzp+sAMYosIzGSSWHQ4EaSIWWACs8SaT8/YIDpOMkp833sdrIpNQEti/4sbbCA2
        v4CixNUfj8Em8QrYSZw5+R6shkVAReL5lr1gcVGBMImdSx4zQdQISpyc+YQFxOYUcJCYvvsL
        WJxZQF3iz7xLzBC2uMStJ/Oh4vIS29/OYZ7AKDwLSfssJC2zkLTMQtKygJFlFaNkakFxbnpu
        sWGBUV5quV5xYm5xaV66XnJ+7iZGcIRrae1g3LPqg94hRiYOxkOMEhzMSiK8Vbk+SUK8KYmV
        ValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwZe8UX3A1725Ixo0X
        f3R3687kXjcx+xh7bouxQELMHWbFS5aFam6Sp3I3LHaVdV383HHu12cf/IR1l7MHn5pydjrz
        yQV7nk3w+5XZekeVpWg2g43//bPbjmT8eKn1TtEv8tac5VnLXGcrtMxn9Z5iZbE6+mRRYKqY
        kMTxtu0ckxfHtKe+uf+wVD3uAn/tdK4rTDpXD5q5f32V8b85IO5p2oPXB2IEd227cqTxfK45
        m9Tqo79eaWRqdr196Wy44NuG7bLTzM79KdeXu+S7T8XG7YpI4/RMh69GK55wBP0Se79z+pTi
        k9E1GT/KV/bdMrPJMNqnuHoZkyzXVZ3QQE7bS4xpu3q3pwZdCjMOyVu6VomlOCPRUIu5qDgR
        AF2+LJZfAwAA
X-CMS-MailID: 20220407025455epcas1p236e9bf6e53428d7f9942cbd383e4e125
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220307122645epcas1p1c2d964e26084b9c1ec928e1a199f315d
References: <20220307122513.11822-1-jia-wei.chang@mediatek.com>
        <CGME20220307122645epcas1p1c2d964e26084b9c1ec928e1a199f315d@epcas1p1.samsung.com>
        <20220307122513.11822-3-jia-wei.chang@mediatek.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems that this patch depends on patches[1] of devfreq-testing branch.
[1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing

I'll send the updated patches[1]. And I add the my comment below.


On 3/7/22 9:25 PM, Tim Chang wrote:
> This adds a devfreq driver for the Cache Coherent Interconnect (CCI) of
> the Mediatek MT8183.
> 
> On mt8183 the cci is supplied by the same regulator as the little cores.
> The driver is notified when the regulator voltage changes (driven by
> cpufreq) and adjusts the cci frequency to the maximum possible value.
> 
> Add need_voltage_tracking variable to platforma data. if true, it
> indicates soc is required to realize the voltage tracking between
> voltage of sram and voltage of cci by software approach. otherwise, the
> voltage tracking is realized by hardware appraoch.
> 
> Add the notifier to cci so that it could react after svs driver changes
> opp table of cci.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
> ---
>  drivers/devfreq/Kconfig           |  11 +-
>  drivers/devfreq/Makefile          |   2 +-
>  drivers/devfreq/mtk-cci-devfreq.c | 471 ++++++++++++++++++++++++++++++
>  3 files changed, 482 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/devfreq/mtk-cci-devfreq.c
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 1ec36ae93f31..a6be3c6b5691 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -110,7 +110,7 @@ config ARM_IMX8M_DDRC_DEVFREQ
>  
>  config ARM_MT8183_CCI_DEVFREQ
>  	tristate "MT8183 CCI DEVFREQ Driver"
> -	depends on ARM_MEDIATEK_CPUFREQ
> +	depends on OF && ARM_MEDIATEK_CPUFREQ
>  	help

ARM_MT8183_CCI_DEVFREQ is not existed on mainline kernel.
You need to rework this patch on the latest kernel (either devfreq-next
or linux-next.git).

>  		This adds a devfreq driver for Cache Coherent Interconnect
>  		of Mediatek MT8183, which is shared the same regulator
> @@ -130,6 +130,15 @@ config ARM_TEGRA_DEVFREQ
>  	  It reads ACTMON counters of memory controllers and adjusts the
>  	  operating frequencies and voltages with OPP support.
>  
> +config ARM_MEDIATEK_CCI_DEVFREQ
> +	tristate "MEDIATEK CCI DEVFREQ Driver"
> +	depends on OF && ARM_MEDIATEK_CPUFREQ
> +	help
> +	  This adds a devfreq driver for Mediatek Cache Coherent Interconnect
> +	  which is shared the same regulator with cpu cluster. It can track
> +	  buck voltage and update a proper CCI frequency. Use notification
> +	  to get regulator status.
> +
>  config ARM_RK3399_DMC_DEVFREQ
>  	tristate "ARM RK3399 DMC DEVFREQ Driver"
>  	depends on (ARCH_ROCKCHIP && HAVE_ARM_SMCCC) || \
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 991ef7740759..0493516a16f2 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -11,7 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>  obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)	+= imx-bus.o
>  obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
> -obj-$(CONFIG_ARM_MT8183_CCI_DEVFREQ)	+= mt8183-cci-devfreq.o
> +obj-$(CONFIG_ARM_MEDIATEK_CCI_DEVFREQ)	+= mtk-cci-devfreq.o

As I commented, mt8183-cci-devfreq.c is not existed on latest kernel.

>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
>  
> diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
> new file mode 100644
> index 000000000000..986f34689f5c
> --- /dev/null
> +++ b/drivers/devfreq/mtk-cci-devfreq.c
> @@ -0,0 +1,471 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 MediaTek Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/devfreq.h>
> +#include <linux/minmax.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/regulator/consumer.h>
> +
> +struct mtk_ccifreq_platform_data;

Instead of unneeded declaration,
just define 'strcut mmk_ccifreq_platform_data' at here.

> +
> +struct mtk_ccifreq_drv {
> +	struct device *cci_dev;
> +	struct devfreq *devfreq;
> +	struct regulator *proc_reg;
> +	struct regulator *sram_reg;
> +	struct clk *cci_clk;
> +	struct clk *inter_clk;
> +	int inter_voltage;
> +	int old_voltage;
> +	unsigned long old_freq;
> +	struct mutex lock;  /* avoid notify and policy race condition */
> +	struct notifier_block opp_nb;
> +	const struct mtk_ccifreq_platform_data *soc_data;
> +};
> +
> +struct mtk_ccifreq_platform_data {
> +	int min_volt_shift;
> +	int max_volt_shift;
> +	int proc_max_volt;
> +	int sram_min_volt;
> +	int sram_max_volt;
> +	bool need_voltage_tracking;
> +};

As I commented, move it before struct mtk_ccifreq_drv.

> +
> +static int mtk_ccifreq_voltage_tracking(struct mtk_ccifreq_drv *drv, int new_voltage)
> +{
> +	const struct mtk_ccifreq_platform_data *soc_data = drv->soc_data;
> +	struct regulator *proc_reg = drv->proc_reg;
> +	struct regulator *sram_reg = drv->sram_reg;
> +	int old_voltage, old_vsram, new_vsram, vsram, voltage, ret;
> +
> +	old_voltage = regulator_get_voltage(proc_reg);
> +	if (old_voltage < 0) {
> +		pr_err("%s: invalid vproc value: %d\n", __func__, old_voltage);

Use dev_err instead of pr_err and don't use '__func__'.

> +		return old_voltage;
> +	}
> +
> +	old_vsram = regulator_get_voltage(sram_reg);
> +	if (old_vsram < 0) {
> +		pr_err("%s: invalid vsram value: %d\n", __func__, old_vsram);

ditto.

> +		return old_vsram;
> +	}
> +
> +	new_vsram = clamp(new_voltage + soc_data->min_volt_shift,
> +			  soc_data->sram_min_volt, soc_data->sram_max_volt);
> +
> +	do {
> +		if (old_voltage <= new_voltage) {
> +			vsram = clamp(old_voltage + soc_data->max_volt_shift,
> +				      soc_data->sram_min_volt, new_vsram);
> +			ret = regulator_set_voltage(sram_reg, vsram,
> +						    soc_data->sram_max_volt);
> +			if (ret)
> +				return ret;
> +
> +			if (vsram == soc_data->sram_max_volt ||
> +			    new_vsram == soc_data->sram_min_volt)
> +				voltage = new_voltage;
> +			else
> +				voltage = vsram - soc_data->min_volt_shift;
> +
> +			ret = regulator_set_voltage(proc_reg, voltage,
> +						    soc_data->proc_max_volt);
> +			if (ret) {
> +				regulator_set_voltage(sram_reg, old_vsram,
> +						      soc_data->sram_max_volt);
> +				return ret;
> +			}
> +		} else if (old_voltage > new_voltage) {
> +			voltage = max(new_voltage,
> +				    old_vsram - soc_data->max_volt_shift);
> +			ret = regulator_set_voltage(proc_reg, voltage,
> +						    soc_data->proc_max_volt);
> +			if (ret)
> +				return ret;
> +
> +			if (voltage == new_voltage)
> +				vsram = new_vsram;
> +			else
> +				vsram = max(new_vsram,
> +					    voltage + soc_data->min_volt_shift);
> +
> +			ret = regulator_set_voltage(sram_reg, vsram,
> +						    soc_data->sram_max_volt);
> +			if (ret) {
> +				regulator_set_voltage(proc_reg, old_voltage,
> +						      soc_data->proc_max_volt);
> +				return ret;
> +			}
> +		}
> +
> +		old_voltage = voltage;
> +		old_vsram = vsram;
> +	} while (voltage != new_voltage || vsram != new_vsram);
> +
> +	return 0;
> +}
> +
> +static int mtk_ccifreq_set_voltage(struct mtk_ccifreq_drv *drv, int voltage)
> +{
> +	int ret;
> +
> +	if (drv->soc_data->need_voltage_tracking)
> +		ret = mtk_ccifreq_voltage_tracking(drv, voltage);
> +	else
> +		ret = regulator_set_voltage(drv->proc_reg, voltage,
> +					    drv->soc_data->proc_max_volt);
> +
> +	if (!ret)
> +		drv->old_voltage = voltage;
> +
> +	return ret;
> +}
> +
> +static int mtk_ccifreq_target(struct device *dev, unsigned long *freq,
> +			      u32 flags)
> +{

I recommend that you handle the error case by using 'goto' statement
instead of handling them in each error case. You can refer the 
other devfreq device driver for handling error case with goto.

> +	struct mtk_ccifreq_drv *drv = dev_get_drvdata(dev);
> +	struct clk *cci_pll = clk_get_parent(drv->cci_clk);
> +	struct dev_pm_opp *opp;
> +	unsigned long opp_rate;
> +	int voltage, old_voltage, inter_voltage, target_voltage, ret;
> +
> +	if (!drv)
> +		return -EINVAL;
> +
> +	if (drv->old_freq == *freq)
> +		return 0;
> +
> +	inter_voltage = drv->inter_voltage;
> +
> +	opp_rate = *freq;
> +	opp = devfreq_recommended_opp(dev, &opp_rate, 1);
> +	if (IS_ERR(opp)) {
> +		pr_err("cci: failed to find opp for freq: %ld\n", opp_rate);

ditto.

> +		return PTR_ERR(opp);
> +	}
> +	voltage = dev_pm_opp_get_voltage(opp);
> +	dev_pm_opp_put(opp);
> +
> +	old_voltage = drv->old_voltage;
> +	if (old_voltage == 0)
> +		old_voltage = regulator_get_voltage(drv->proc_reg);
> +	if (old_voltage < 0) {
> +		pr_err("cci: invalid vproc value: %d\n", old_voltage);

ditto. Use dev_err instead of pr_err.

> +		return old_voltage;
> +	}
> +
> +	mutex_lock(&drv->lock);
> +
> +	/* scale up: set voltage first then freq. */
> +	target_voltage = max(inter_voltage, voltage);
> +	if (old_voltage <= target_voltage) {
> +		ret = mtk_ccifreq_set_voltage(drv, target_voltage);
> +		if (ret) {
> +			pr_err("cci: failed to scale up voltage\n");

ditto.

> +			mtk_ccifreq_set_voltage(drv, old_voltage);
> +			mutex_unlock(&drv->lock);
> +			return ret;
> +		}
> +	}
> +
> +	/* switch the cci clock to intermediate clock source. */
> +	ret = clk_set_parent(drv->cci_clk, drv->inter_clk);
> +	if (ret) {
> +		pr_err("cci: failed to re-parent cci clock\n");

ditto.

> +		mtk_ccifreq_set_voltage(drv, old_voltage);
> +		WARN_ON(1);

I think that it is not necessary. Please remove it.

> +		mutex_unlock(&drv->lock);
> +		return ret;
> +	}
> +
> +	/* set the original clock to target rate. */
> +	ret = clk_set_rate(cci_pll, *freq);
> +	if (ret) {
> +		pr_err("cci: failed to set cci pll rate: %d\n", ret);

ditto.

> +		clk_set_parent(drv->cci_clk, cci_pll);
> +		mtk_ccifreq_set_voltage(drv, old_voltage);
> +		mutex_unlock(&drv->lock);
> +		return ret;
> +	}
> +
> +	/* switch the cci clock back to the original clock source. */
> +	ret = clk_set_parent(drv->cci_clk, cci_pll);
> +	if (ret) {
> +		pr_err("cci: failed to re-parent cci clock\n");

ditto.

> +		mtk_ccifreq_set_voltage(drv, inter_voltage);
> +		WARN_ON(1);

ditto.

> +		mutex_unlock(&drv->lock);
> +		return ret;
> +	}
> +
> +	/*
> +	 * If the new voltage is lower than the intermediate voltage or the
> +	 * original voltage, scale down to the new voltage.
> +	 */
> +	if (voltage < inter_voltage || voltage < old_voltage) {
> +		ret = mtk_ccifreq_set_voltage(drv, voltage);
> +		if (ret) {
> +			pr_err("cci: failed to scale down voltage\n");

ditto.

> +			WARN_ON(1);

ditto.

> +			mutex_unlock(&drv->lock);
> +			return ret;
> +		}
> +	}
> +
> +	drv->old_freq = *freq;
> +	mutex_unlock(&drv->lock);
> +
> +	return 0;
> +}
> +
> +static int mtk_ccifreq_opp_notifier(struct notifier_block *nb,
> +				    unsigned long event, void *data)
> +{
> +	struct dev_pm_opp *opp = data;
> +	struct mtk_ccifreq_drv *drv;
> +	unsigned long freq, volt;
> +
> +	drv = container_of(nb, struct mtk_ccifreq_drv, opp_nb);
> +
> +	if (event == OPP_EVENT_ADJUST_VOLTAGE) {
> +		freq = dev_pm_opp_get_freq(opp);
> +
> +		mutex_lock(&drv->lock);
> +		/* current opp item is changed */
> +		if (freq == drv->old_freq) {
> +			volt = dev_pm_opp_get_voltage(opp);
> +			mtk_ccifreq_set_voltage(drv, volt);
> +		}
> +		mutex_unlock(&drv->lock);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct devfreq_dev_profile mtk_ccifreq_profile = {
> +	.target = mtk_ccifreq_target,
> +};
> +
> +static int mtk_ccifreq_probe(struct platform_device *pdev)
> +{
> +	struct device *cci_dev = &pdev->dev;
> +	struct mtk_ccifreq_drv *drv;
> +	struct devfreq_passive_data *passive_data;
> +	struct dev_pm_opp *opp;
> +	unsigned long rate, opp_volt;
> +	int ret;
> +
> +	drv = devm_kzalloc(cci_dev, sizeof(*drv), GFP_KERNEL);
> +	if (!drv)
> +		return -ENOMEM;
> +
> +	drv->cci_dev = cci_dev;
> +	drv->soc_data = (const struct mtk_ccifreq_platform_data *)
> +				of_device_get_match_data(&pdev->dev);
> +	mutex_init(&drv->lock);
> +	platform_set_drvdata(pdev, drv);
> +
> +	drv->cci_clk = devm_clk_get(cci_dev, "cci");
> +	if (IS_ERR(drv->cci_clk)) {
> +		ret = PTR_ERR(drv->cci_clk);
> +		return dev_err_probe(cci_dev, ret,
> +				     "cci: failed to get cci clk: %d\n",
> +				     ret);
> +	}
> +
> +	drv->inter_clk = devm_clk_get(cci_dev, "intermediate");
> +	if (IS_ERR(drv->inter_clk)) {
> +		ret = PTR_ERR(drv->inter_clk);
> +		return dev_err_probe(cci_dev, ret,
> +				     "cci: failed to get intermediate clk: %d\n",
> +				     ret);
> +	}
> +
> +	if (drv->soc_data->need_voltage_tracking) {
> +		drv->sram_reg = regulator_get_optional(cci_dev, "sram");
> +		if (IS_ERR_OR_NULL(drv->sram_reg)) {
> +			ret = PTR_ERR(drv->sram_reg);
> +			return dev_err_probe(cci_dev, ret,
> +					     "cci: failed to get sram regulator: %d\n",
> +					     ret);
> +		}
> +
> +		ret = regulator_enable(drv->sram_reg);
> +		if (ret) {
> +			dev_warn(cci_dev,
> +				 "cci: failed to enable sram regulator\n");

If you want to break the probe sequence, better to use 'dev_err'
instead of 'dev_warn' if there is no any reason to use dev_warn.


> +			return ret;
> +		}
> +	}
> +
> +	drv->proc_reg = devm_regulator_get_optional(cci_dev, "proc");
> +	if (IS_ERR(drv->proc_reg)) {
> +		ret = PTR_ERR(drv->proc_reg);
> +		dev_err_probe(cci_dev, ret,
> +			      "cci: failed to get proc regulator: %d\n",
> +			      ret);
> +		goto out_disable_sram_reg;
> +	}
> +
> +	ret = regulator_enable(drv->proc_reg);
> +	if (ret) {
> +		dev_warn(cci_dev, "cci: failed to enable proc regulator\n");

ditto. Use dev_err.

> +		goto out_disable_sram_reg;
> +	}
> +
> +	ret = clk_prepare_enable(drv->cci_clk);
> +	if (ret)
> +		goto out_disable_proc_reg;
> +
> +	ret = clk_prepare_enable(drv->inter_clk);
> +	if (ret)
> +		goto out_disable_cci_clk;
> +
> +	ret = dev_pm_opp_of_add_table(cci_dev);
> +	if (ret) {
> +		dev_warn(cci_dev, "cci: failed to add opp table: %d\n", ret);
> +		goto out_disable_inter_clk;
> +	}
> +
> +	rate = clk_get_rate(drv->inter_clk);
> +	opp = dev_pm_opp_find_freq_ceil(cci_dev, &rate);
> +	if (IS_ERR(opp)) {
> +		ret = PTR_ERR(opp);
> +		dev_err(cci_dev, "cci: failed to get intermediate opp: %d\n",
> +			ret);
> +		goto out_remove_opp_table;
> +	}
> +	drv->inter_voltage = dev_pm_opp_get_voltage(opp);
> +	dev_pm_opp_put(opp);
> +
> +	rate = U32_MAX;
> +	opp = dev_pm_opp_find_freq_floor(drv->cci_dev, &rate);
> +	if (IS_ERR(opp)) {
> +		pr_err("failed to get opp\n");
> +		ret = PTR_ERR(opp);
> +		goto out_remove_opp_table;
> +	}
> +
> +	opp_volt = dev_pm_opp_get_voltage(opp);
> +	dev_pm_opp_put(opp);
> +	ret = mtk_ccifreq_set_voltage(drv, opp_volt);
> +	if (ret) {
> +		pr_err("failed to scale to highest voltage %lu in proc_reg\n",
> +		       opp_volt);

Use dev_err.

> +		goto out_remove_opp_table;
> +	}
> +
> +	passive_data = devm_kzalloc(cci_dev, sizeof(struct devfreq_passive_data), GFP_KERNEL);
> +	if (!passive_data) {
> +		ret = -ENOMEM;
> +		goto out_remove_opp_table;
> +	}
> +
> +	passive_data->parent_type = CPUFREQ_PARENT_DEV;

It seems that depend on patchset[1]. I'll send the updated patch 
within one week.
[1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing

> +	drv->devfreq = devm_devfreq_add_device(cci_dev,
> +					       &mtk_ccifreq_profile,
> +					       DEVFREQ_GOV_PASSIVE,
> +					       passive_data);
> +	if (IS_ERR(drv->devfreq)) {
> +		ret = -EPROBE_DEFER;
> +		dev_err(cci_dev, "cci: failed to add devfreq device: %d\n",
> +			PTR_ERR(drv->devfreq));
> +		goto out_remove_opp_table;
> +	}
> +
> +	drv->opp_nb.notifier_call = mtk_ccifreq_opp_notifier;
> +	ret = dev_pm_opp_register_notifier(cci_dev, &drv->opp_nb);
> +	if (ret) {
> +		dev_warn(cci_dev, "cci: failed to register opp notifier: %d\n",
> +			 ret);
> +		goto out_remove_devfreq_device;
> +	}
> +
> +	return 0;
> +
> +out_remove_devfreq_device:
> +	devm_devfreq_remove_device(cci_dev, drv->devfreq);
> +
> +out_remove_opp_table:
> +	dev_pm_opp_of_remove_table(cci_dev);
> +
> +out_disable_inter_clk:
> +	clk_disable_unprepare(drv->inter_clk);
> +
> +out_disable_cci_clk:
> +	clk_disable_unprepare(drv->cci_clk);
> +
> +out_disable_proc_reg:
> +	regulator_disable(drv->proc_reg);
> +
> +out_disable_sram_reg:
> +	if (drv->soc_data->need_voltage_tracking)
> +		regulator_disable(drv->sram_reg);
> +
> +	return ret;
> +}
> +
> +static int mtk_ccifreq_remove(struct platform_device *pdev)
> +{
> +	struct device *cci_dev = &pdev->dev;
> +	struct mtk_ccifreq_drv *drv;
> +
> +	drv = platform_get_drvdata(pdev);
> +
> +	dev_pm_opp_unregister_notifier(cci_dev, &drv->opp_nb);
> +	dev_pm_opp_of_remove_table(cci_dev);
> +	regulator_disable(drv->proc_reg);
> +	if (!IS_ERR(drv->sram_reg))
> +		regulator_disable(drv->sram_reg);
> +
> +	return 0;
> +}
> +
> +static const struct mtk_ccifreq_platform_data mtk_platform_data = {
> +	.min_volt_shift = 0,
> +	.max_volt_shift = 0,
> +	.proc_max_volt = 1150000,
> +	.sram_min_volt = 0,
> +	.sram_max_volt = 0,
> +	.need_voltage_tracking = false,
> +};
> +
> +static const struct of_device_id mtk_ccifreq_machines[] = {
> +	{ .compatible = "mediatek,mt8183-cci", .data = &mtk_platform_data },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, mtk_ccifreq_machines);
> +
> +static struct platform_driver mtk_ccifreq_platdrv = {
> +	.probe	= mtk_ccifreq_probe,
> +	.remove	= mtk_ccifreq_remove,
> +	.driver = {
> +		.name = "mtk-ccifreq",
> +		.of_match_table = of_match_ptr(mtk_ccifreq_machines),
> +	},
> +};
> +
> +static int __init mtk_ccifreq_platdrv_init(void)
> +{
> +	return platform_driver_register(&mtk_ccifreq_platdrv);
> +}
> +module_init(mtk_ccifreq_platdrv_init)
> +
> +static void __exit mtk_ccifreq_platdrv_exit(void)
> +{
> +	platform_driver_unregister(&mtk_ccifreq_platdrv);
> +}
> +module_exit(mtk_ccifreq_platdrv_exit)
> +
> +MODULE_DESCRIPTION("Mediatek CCI devfreq driver");
> +MODULE_AUTHOR("Jia-Wei Chang <jia-wei.chang@mediatek.com>");
> +MODULE_LICENSE("GPL v2");
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
