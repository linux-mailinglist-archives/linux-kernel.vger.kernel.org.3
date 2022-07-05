Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3C65665D6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiGEJJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiGEJJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:09:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC03C110C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 02:09:12 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v14so16584965wra.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 02:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yJ3/p/b20rd9gITr340jXdoH64eB6vygRRljkiC3keQ=;
        b=ZkMdT84ipj39vCO/c7Hf55PtVWpnxXpU4nIqZoPE9TBg3nzHvLN5uXiLRJJWJZUaFH
         IVV75UQbUT+9xDfo9XPMnzulnGXkf0TEsJjRSIzZUi4Ckh7/Svqgm6oN4TBOEqX64CxG
         h1KaOpT1pmbUcEpWFyctI/tMq+QCjPS5Hr+2hYok5wrZ/PJK3CVduRzjKGmy3YoOQBrb
         SRQRym6k4u4qGoicGUV4zLsVl6uHpRCNWbzTsrDP8oIWC04qpRxzkL622nDV/MlfMoZu
         H9yzQ2Y0LwSktRRbqcW3hWnun7r1kUQ63dSBNCTL7dvAD9Aw2G8GXycOd7X0Cd+7J08O
         JYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yJ3/p/b20rd9gITr340jXdoH64eB6vygRRljkiC3keQ=;
        b=wAkpjLWPxvx9S3Q5ibuQlf+U9HBE5RiXqIY793NDhkei18SyDNzJ7Ajjth5EuN1ssI
         yATdEl+tVfuu07IDb5guMAqfZDpfE6LFyFw6ScBdB4NR8j/H49j2CC70vwJDXBIrSz6m
         DMM3mU+FyKivA/zTcdMx1Y5KvVZiJKuuSjsYhwriFV6Vm8lTwZyZKXEpxzgsji/xXaEJ
         fUWeTNDPciQPgGHkiiNMkFePiZBcKOVo16zQRKCjbDN8pDXgHrdgdbKsy7pjTlq/Xql6
         hjezTBpzHNsM4lOKT/HgVTorgi9u6VJQBKAwIbnCAg8L6z4cY4ZbvIbuLKt/FtAReHxr
         mLxg==
X-Gm-Message-State: AJIora8AldFWTcjxIHGVqmOilcSYt2XHh77Wbh6nNAvRcpkObW0txF1b
        a+Nnlnbdpa/YE2oGaihRZAOUxQ==
X-Google-Smtp-Source: AGRyM1uOmYs7yfGw762F2c9Ek0zTm5wi/+qAG9KZ9cTFCOZgYur4sj1hP42/yknm4nKxzPH5BLFvaw==
X-Received: by 2002:a5d:4345:0:b0:21a:3b82:ad57 with SMTP id u5-20020a5d4345000000b0021a3b82ad57mr31677768wrr.176.1657012151232;
        Tue, 05 Jul 2022 02:09:11 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id l14-20020a05600c4f0e00b003a199ed4f44sm10760635wmq.27.2022.07.05.02.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 02:09:10 -0700 (PDT)
Message-ID: <3b0ce952-0674-d01d-3fc0-795d35743723@linaro.org>
Date:   Tue, 5 Jul 2022 11:09:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/4] PM: EM: convert power field to micro-Watts precision
 and align drivers
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, viresh.kumar@linaro.org,
        rafael@kernel.org, dietmar.eggemann@arm.com, nm@ti.com,
        sboyd@kernel.org, sudeep.holla@arm.com, cristian.marussi@arm.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20220622145802.13032-1-lukasz.luba@arm.com>
 <20220622145802.13032-2-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220622145802.13032-2-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2022 16:57, Lukasz Luba wrote:
> The milli-Watts precision causes rounding errors while calculating
> efficiency cost for each OPP. This is especially visible in the 'simple'
> Energy Model (EM), where the power for each OPP is provided from OPP
> framework. This can cause some OPPs to be marked inefficient, while
> using micro-Watts precision that might not happen.
> 
> Update all EM users which access 'power' field and assume the value is
> in milli-Watts.
> 
> Solve also an issue with potential overflow in calculation of energy
> estimation on 32bit machine. It's needed now since the power value
> (thus the 'cost' as well) are higher.
> 
> Example calculation which shows the rounding error and impact:
> 
> power = 'dyn-power-coeff' * volt_mV * volt_mV * freq_MHz
> 
> power_a_uW = (100 * 600mW * 600mW * 500MHz) / 10^6 = 18000
> power_a_mW = (100 * 600mW * 600mW * 500MHz) / 10^9 = 18
> 
> power_b_uW = (100 * 605mW * 605mW * 600MHz) / 10^6 = 21961
> power_b_mW = (100 * 605mW * 605mW * 600MHz) / 10^9 = 21
> 
> max_freq = 2000MHz
> 
> cost_a_mW = 18 * 2000MHz/500MHz = 72
> cost_a_uW = 18000 * 2000MHz/500MHz = 72000
> 
> cost_b_mW = 21 * 2000MHz/600MHz = 70 // <- artificially better
> cost_b_uW = 21961 * 2000MHz/600MHz = 73203
> 
> The 'cost_b_mW' (which is based on old milli-Watts) is misleadingly
> better that the 'cost_b_uW' (this patch uses micro-Watts) and such
> would have impact on the 'inefficient OPPs' information in the Cpufreq
> framework. This patch set removes the rounding issue.

Thanks for this detailed description, it really helps to understand why 
this change is needed.

Perhaps it would make sense to add a power_uw in the EM structure and 
keeping the old one with the milli-watts in order to reduce the impact 
of the change.

It is a suggestion if you find it more convenient. Otherwise I'm fine 
with this approach too.

A few comments below.

> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   drivers/cpufreq/mediatek-cpufreq-hw.c |  7 +--
>   drivers/cpufreq/scmi-cpufreq.c        |  6 +++
>   drivers/opp/of.c                      | 15 ++++---
>   drivers/powercap/dtpm_cpu.c           |  5 +--
>   drivers/thermal/cpufreq_cooling.c     | 13 +++++-
>   drivers/thermal/devfreq_cooling.c     | 19 ++++++--
>   include/linux/energy_model.h          | 63 ++++++++++++++++++++-------
>   kernel/power/energy_model.c           | 31 ++++++++-----
>   8 files changed, 114 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
> index 813cccbfe934..f0e0a35c7f21 100644
> --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -51,7 +51,7 @@ static const u16 cpufreq_mtk_offsets[REG_ARRAY_SIZE] = {
>   };
>   

[ ... ]

> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index b8151d95a806..dc19e7c80751 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -21,6 +21,7 @@
>   #include <linux/pm_qos.h>
>   #include <linux/slab.h>
>   #include <linux/thermal.h>
> +#include <linux/units.h>
>   
>   #include <trace/events/thermal.h>
>   
> @@ -101,6 +102,7 @@ static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
>   static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_cdev,
>   			     u32 freq)
>   {
> +	unsigned long power_mw;
>   	int i;
>   
>   	for (i = cpufreq_cdev->max_level - 1; i >= 0; i--) {
> @@ -108,16 +110,23 @@ static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_cdev,
>   			break;
>   	}
>   
> -	return cpufreq_cdev->em->table[i + 1].power;
> +	power_mw = cpufreq_cdev->em->table[i + 1].power;
> +	power_mw /= MICROWATT_PER_MILLIWATT;

Won't this fail with an unresolved symbols on some archs ? I mean may be 
do_div should be used instead ?

> +
> +	return power_mw;
>   }

[ ... ]

>   #ifdef CONFIG_64BIT
> -#define em_scale_power(p) ((p) * 1000)
> +#define em_estimate_energy(cost, sum_util, scale_cpu) \
> +	(((cost) * (sum_util)) / (scale_cpu))
>   #else
> -#define em_scale_power(p) (p)
> +#define em_estimate_energy(cost, sum_util, scale_cpu) \
> +	(((cost) / (scale_cpu)) * (sum_util))
>   #endif
>   
>   struct em_data_callback {
> @@ -112,7 +143,7 @@ struct em_data_callback {
>   	 * and frequency.
>   	 *
>   	 * In case of CPUs, the power is the one of a single CPU in the domain,
> -	 * expressed in milli-Watts or an abstract scale. It is expected to
> +	 * expressed in micro-Watts or an abstract scale. It is expected to
>   	 * fit in the [0, EM_MAX_POWER] range.
>   	 *
>   	 * Return 0 on success.
> @@ -148,7 +179,7 @@ struct em_perf_domain *em_cpu_get(int cpu);
>   struct em_perf_domain *em_pd_get(struct device *dev);
>   int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>   				struct em_data_callback *cb, cpumask_t *span,
> -				bool milliwatts);
> +				bool microwatts);
>   void em_dev_unregister_perf_domain(struct device *dev);
>   
>   /**
> @@ -273,7 +304,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>   	 *   pd_nrg = ------------------------                       (4)
>   	 *                  scale_cpu
>   	 */
> -	return ps->cost * sum_util / scale_cpu;
> +	return em_estimate_energy(ps->cost, sum_util, scale_cpu);
>   }
>   
>   /**
> @@ -297,7 +328,7 @@ struct em_data_callback {};
>   static inline
>   int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>   				struct em_data_callback *cb, cpumask_t *span,
> -				bool milliwatts)
> +				bool microwatts)
>   {
>   	return -EINVAL;
>   }
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 6c373f2960e7..910668ec8838 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -108,10 +108,11 @@ static void em_debug_remove_pd(struct device *dev) {}
>   
>   static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>   				int nr_states, struct em_data_callback *cb,
> -				unsigned long flags)
> +				unsigned long flags, int num_devs)
>   {
>   	unsigned long power, freq, prev_freq = 0, prev_cost = ULONG_MAX;
>   	struct em_perf_state *table;
> +	unsigned long max_cost = 0;
>   	int i, ret;
>   	u64 fmax;
>   
> @@ -145,7 +146,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>   
>   		/*
>   		 * The power returned by active_state() is expected to be
> -		 * positive and to fit into 16 bits.
> +		 * positive and be in range.
>   		 */
>   		if (!power || power > EM_MAX_POWER) {
>   			dev_err(dev, "EM: invalid power: %lu\n",
> @@ -170,7 +171,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>   				goto free_ps_table;
>   			}
>   		} else {
> -			power_res = em_scale_power(table[i].power);
> +			power_res = table[i].power;
>   			cost = div64_u64(fmax * power_res, table[i].frequency);
>   		}
>   
> @@ -183,6 +184,15 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>   		} else {
>   			prev_cost = table[i].cost;
>   		}
> +
> +		if (max_cost < table[i].cost)
> +			max_cost = table[i].cost;
> +	}
> +
> +	/* Check if it won't overflow during energy estimation. */
> +	if (em_validate_cost(max_cost, num_devs)) {

I'm not finding the em_validate_cost() function

> +		dev_err(dev, "EM: too big 'cost' value: %lu\n",	max_cost);
> +		goto free_ps_table;
>   	}
>   
>   	pd->table = table;
> @@ -199,9 +209,9 @@ static int em_create_pd(struct device *dev, int nr_states,
>   			struct em_data_callback *cb, cpumask_t *cpus,
>   			unsigned long flags)
>   {
> +	int cpu, ret, num_devs = 1;
>   	struct em_perf_domain *pd;
>   	struct device *cpu_dev;
> -	int cpu, ret;
>   
>   	if (_is_cpu_device(dev)) {
>   		pd = kzalloc(sizeof(*pd) + cpumask_size(), GFP_KERNEL);
> @@ -209,13 +219,14 @@ static int em_create_pd(struct device *dev, int nr_states,
>   			return -ENOMEM;
>   
>   		cpumask_copy(em_span_cpus(pd), cpus);
> +		num_devs = cpumask_weight(cpus);

Why is this change needed ? What is the connection with the uW unit change ?


>   	} else {
>   		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
>   		if (!pd)
>   			return -ENOMEM;
>   	}
>   
> -	ret = em_create_perf_table(dev, pd, nr_states, cb, flags);
> +	ret = em_create_perf_table(dev, pd, nr_states, cb, flags, num_devs);
>   	if (ret) {
>   		kfree(pd);
>   		return ret;
> @@ -314,13 +325,13 @@ EXPORT_SYMBOL_GPL(em_cpu_get);
>    * @cpus	: Pointer to cpumask_t, which in case of a CPU device is
>    *		obligatory. It can be taken from i.e. 'policy->cpus'. For other
>    *		type of devices this should be set to NULL.
> - * @milliwatts	: Flag indicating that the power values are in milliWatts or
> + * @microwatts	: Flag indicating that the power values are in micro-Watts or
>    *		in some other scale. It must be set properly.
>    *
>    * Create Energy Model tables for a performance domain using the callbacks
>    * defined in cb.
>    *
> - * The @milliwatts is important to set with correct value. Some kernel
> + * The @microwatts is important to set with correct value. Some kernel
>    * sub-systems might rely on this flag and check if all devices in the EM are
>    * using the same scale.
>    *
> @@ -331,7 +342,7 @@ EXPORT_SYMBOL_GPL(em_cpu_get);
>    */
>   int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>   				struct em_data_callback *cb, cpumask_t *cpus,
> -				bool milliwatts)
> +				bool microwatts)
>   {
>   	unsigned long cap, prev_cap = 0;
>   	unsigned long flags = 0;
> @@ -381,8 +392,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>   		}
>   	}
>   
> -	if (milliwatts)
> -		flags |= EM_PERF_DOMAIN_MILLIWATTS;
> +	if (microwatts)
> +		flags |= EM_PERF_DOMAIN_MICROWATTS;
>   	else if (cb->get_cost)
>   		flags |= EM_PERF_DOMAIN_ARTIFICIAL;
>   


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
