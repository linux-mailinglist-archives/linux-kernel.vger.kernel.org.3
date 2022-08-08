Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD4B58C2F3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 07:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiHHFmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 01:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiHHFmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 01:42:40 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81ADDECD
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 22:42:38 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bq11so11143203lfb.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 22:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8K1ox/jV0U8nj81jXXePp8rlDteCuzxR7Q+od8bNCV8=;
        b=plOy+iz7wRUwWnwhYqa/ufkw/Wbt6L0dQuP0xtjoDNQ3OfJF5Pu2fx0xmq6Z5rkFmC
         82KGS9AX+PhcZVT7IhnXHrX6Hz5fnmcD6iqP6rJCFZi0N8FchcFZzC5zZMvpn0fPqqsL
         zI+LvxdxNC2imAlN9V4R88YKxSIFMt3yZ8R6T+NfH9brk2W/+5oLcKdFyQMlgpjp/aw4
         fht4+EHvG8P7R51rtGElVugX0Ne0b2cFi3RwVWKdRsO3eI0qUfJAX9YmxbrljzW5V2Pw
         zjDLOc/WGAnyE4ijdiZusIrJHUXL0LckVxWAQYgpDtlrsMsBSN3cLWM1EBuRBFwy3z4C
         bpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8K1ox/jV0U8nj81jXXePp8rlDteCuzxR7Q+od8bNCV8=;
        b=FMDmuIDzkUtOfICesm62uGPNZg1GJ70xM2QKwf1fILsSI6PU+adfNlggLpauNBxG4V
         72CEvlz2mz+jmSykAQ6OxJY3Cszix3P4Wo5FbuVm9m31WbujAQDar5/p8bchyN08tEuF
         2TUtBMKWrIl8391TmkrwSOZpL3NUJusnjPsHGdkxagtEOTaulHKQLv9p9DQ/lVxAIYGr
         OFP8lV5wLMK/jsZhEIRqwbDqobPCniAljY0IH74FjwzpXaclpMuTOWPUd3NeaBof08sG
         aIL9P1m/HZsCv7PBhwrFGbpAIf6gUGL2nMwCxTqxLBLKqlBlIXU7p+gxoWDt9YGFAZ/M
         4mbA==
X-Gm-Message-State: ACgBeo2aDbZHUUvUQPsX9Z2BOFPHrC0pKmAeArcmIVvI1t4vMdisQ89k
        W8PFrQRhjQi6otOmSRdIZvGeiQ==
X-Google-Smtp-Source: AA6agR5GkCqH+omv0iLbVmZwmb1QVcZqCsjnJehLjyT2RmHFI1rH4HUOes1EsBGzfyrKVi3eGdEaqw==
X-Received: by 2002:ac2:5cd9:0:b0:48b:18dd:c41f with SMTP id f25-20020ac25cd9000000b0048b18ddc41fmr6114318lfq.112.1659937357211;
        Sun, 07 Aug 2022 22:42:37 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id q1-20020a2eb4a1000000b0025e6d665a3fsm1260107ljm.18.2022.08.07.22.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 22:42:36 -0700 (PDT)
Message-ID: <eb153484-6216-c4bd-deb2-c25e177b2d59@linaro.org>
Date:   Mon, 8 Aug 2022 07:42:35 +0200
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
 <3597d068-2c44-9450-4a0c-4704f3639a37@linaro.org>
 <4119d339-0570-2132-3e9f-19ec45ef6e8d@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4119d339-0570-2132-3e9f-19ec45ef6e8d@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2022 11:55, Jiucheng Xu wrote:
>>> +static int __init g12_ddr_pmu_probe(struct platform_device *pdev)
>>> +{
>>> +	struct ddr_pmu *pmu;
>>> +
>>> +	if (of_device_is_compatible(pdev->dev.of_node,
>>> +				    "amlogic,g12a-ddr-pmu")) {
>>> +		format_attr_nna.attr.mode = 0;
>>> +		format_attr_gdc.attr.mode = 0;
>>> +		format_attr_arm1.attr.mode = 0;
>>> +		format_attr_mipi_isp.attr.mode = 0;
>> No. That's not correct patter. You must use variant specific driver data.
> 
> Do you mean use of_device_id.data? Could your please give me an
> 
> example code in kernel source?

90% of Linux kernel drivers?

> 
>>
>>> +	} else if (of_device_is_compatible(pdev->dev.of_node,
>>> +					   "amlogic,sm1-ddr-pmu")) {
>>> +		format_attr_gdc.attr.mode = 0;
>>> +		format_attr_arm1.attr.mode = 0;
>>> +		format_attr_mipi_isp.attr.mode = 0;
>> No. That's not correct patter. You must use variant specific driver data.
>>
>>> +	}
>>> +
>>> +	pmu = devm_kzalloc(&pdev->dev, sizeof(struct ddr_pmu), GFP_KERNEL);
>>> +	if (!pmu)
>>> +		return -ENOMEM;
>>> +
>>> +	/*
>>> +	 * G12 series Soc have single dmc controller and
>>> +	 * 4x ddr bandwidth monitor channels
>>> +	 */
>>> +	pmu->info.dmc_nr = 1;
>>> +	pmu->info.chann_nr = 4;
>>> +	pmu->info.ops = &g12_ops;
>>> +	pmu->info.fmt_attr = g12_pmu_format_attrs;
>>> +
>>> +	return meson_ddr_pmu_create(pdev, pmu);
>>> +}
>>> +
>>> +static int __exit g12_ddr_pmu_remove(struct platform_device *pdev)
>>> +{
>>> +	meson_ddr_pmu_remove(pdev);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct of_device_id meson_ddr_pmu_dt_match[] = {
>>> +	{
>>> +		.compatible = "amlogic,g12-ddr-pmu",
>> Undocumented compatible. Did you run checkpatch and fix all the errors?
> 
> Yes, I run "./scripts/checkpatch --strict *.patch", and no errors/warnings.
> 
> Any other options should be used to check strictly?
> 
> I think it could be removed.

Either you document it or drop it. It anyway looks a bit odd -
unspecific (neither for g12a, nor for g12b).

> 
>>
>>> +	},
>>> +	{
>>> +		.compatible = "amlogic,g12a-ddr-pmu",
>>> +	},
>>> +	{
>>> +		.compatible = "amlogic,g12b-ddr-pmu",
>>> +	},
>>> +	{
>>> +		.compatible = "amlogic,sm1-ddr-pmu",
>> Why four different entries for the same devices without driver data?
>> This is confusing.
> Do you mean use a common compatible and different driver data?

What I meant is that current version this is useless and confusing.
Different devices have different compatibles with different driver data.
Same devices have just the same compatible (so same driver data). You
mixed two different approaches.

>>
>>> +	},
>>> +	{}
>>> +};
>>> +
>>> +static struct platform_driver g12_ddr_pmu_driver = {
>>> +	.driver = {
>>> +		.name = "amlogic,ddr-pmu",
>>> +		.of_match_table = meson_ddr_pmu_dt_match,
>>> +	},
>>> +	.remove = __exit_p(g12_ddr_pmu_remove),
>> You made the driver non-hotpluggable - why?
>> In the same time it is still unbindable, whis is a bit confusing. If you
>> can unbind it, you should be able to hot-unplug it.
> Sorry, I couldn't know why the driver is non-hotpluggable. Could you 
> tell the detail?

You used module_platform_driver_probe, so the one with documentation:
 /* non-hotpluggable platform devices may use this so that probe() and

  * its support may live in __init sections, conserving runtime memory.

  */



>>> +};
>>> +
>>> +module_platform_driver_probe(g12_ddr_pmu_driver, g12_ddr_pmu_probe);
>>> +MODULE_AUTHOR("Jiucheng Xu");
>>> +MODULE_LICENSE("GPL");
>>> +MODULE_DESCRIPTION("Amlogic G12 series SoC DDR PMU");
>>> diff --git a/include/soc/amlogic/meson_ddr_pmu.h b/include/soc/amlogic/meson_ddr_pmu.h
>>> new file mode 100644
>>> index 000000000000..882efe3c2f58
>>> --- /dev/null
>>> +++ b/include/soc/amlogic/meson_ddr_pmu.h
>>> @@ -0,0 +1,76 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Copyright (c) 2022 Amlogic, Inc. All rights reserved.
>>> + */
>>> +
>>> +#ifndef __MESON_DDR_PMU_H__
>>> +#define __MESON_DDR_PMU_H__
>>> +
>>> +#define MAX_CHANNEL_NUM		8
>>> +
>>> +enum {
>>> +	ALL_CHAN_COUNTER_ID,
>>> +	CHAN1_COUNTER_ID,
>>> +	CHAN2_COUNTER_ID,
>>> +	CHAN3_COUNTER_ID,
>>> +	CHAN4_COUNTER_ID,
>>> +	CHAN5_COUNTER_ID,
>>> +	CHAN6_COUNTER_ID,
>>> +	CHAN7_COUNTER_ID,
>>> +	CHAN8_COUNTER_ID,
>>> +	COUNTER_MAX_ID,
>>> +};
>>> +
>>> +struct dmc_hw_info;
>>> +
>>> +struct dmc_counter {
>>> +	u64 all_cnt;	/* The count of all requests come in/out ddr controller */
>>> +	union {
>>> +		u64 all_req;
>>> +		struct {
>>> +			u64 all_idle_cnt;
>>> +			u64 all_16bit_cnt;
>>> +		};
>>> +	};
>>> +	u64 channel_cnt[MAX_CHANNEL_NUM]; /* To save a DMC bandwidth-monitor channel counter */
>>> +};
>>> +
>>> +struct dmc_pmu_hw_ops {
>>> +	void (*enable)(struct dmc_hw_info *info);
>>> +	void (*disable)(struct dmc_hw_info *info);
>>> +	/* Bind an axi line to a bandwidth-monitor channel */
>>> +	void (*config_axi_id)(struct dmc_hw_info *info, int axi_id, int chann);
>>> +	int (*irq_handler)(struct dmc_hw_info *info,
>>> +			   struct dmc_counter *counter);
>>> +	void (*get_counters)(struct dmc_hw_info *info,
>>> +			     struct dmc_counter *counter);
>>> +};
>>> +
>>> +struct dmc_hw_info {
>>> +	struct dmc_pmu_hw_ops *ops;
>>> +	void __iomem *ddr_reg[4];
>>> +	unsigned long timer_value;	/* Timer value in TIMER register */
>>> +	void __iomem *pll_reg;
>>> +	int irq_num;			/* irq vector number */
>>> +	int dmc_nr;			/* The number of dmc controller */
>>> +	int chann_nr;			/* The number of dmc bandwidth monitor channels */
>>> +	int id;				/* The number of supported channels */
>>> +	struct attribute **fmt_attr;
>>> +};
>>> +
>>> +struct ddr_pmu {
>>> +	struct pmu pmu;
>>> +	struct dmc_hw_info info;
>>> +	struct dmc_counter counters;	/* save counters from hw */
>>> +	bool pmu_enabled;
>>> +	struct device *dev;
>>> +	char *name;
>>> +	struct hlist_node node;
>>> +	enum cpuhp_state cpuhp_state;
>>> +	int cpu;			/* for cpu hotplug */
>>> +};
>> Linux-wide headers should not include your private data structures.
>> Entier header looks unused - should be made private.
> Do you mean the header should be in driver dir, or the structures should 
> be within .c file?

This or that, up to you. Definitely not in include/linux/.


Best regards,
Krzysztof
