Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B1347AA8C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhLTNor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhLTNoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:44:46 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D98C061574;
        Mon, 20 Dec 2021 05:44:46 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id i31so6521795lfv.10;
        Mon, 20 Dec 2021 05:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZJ+JK+pfn0imHjNFNKchOvyzFKd3KqFBqEefWoEXz1s=;
        b=mXxOgs4E45UQpcIPa+i03UP+F/hlBWYU8MTpNZeGGUbbkOnTA3Ng6fJqpvvyjdI1s3
         lVfm0mBuXp2hopqUFwanCoKZpFibdiwSWUoyjrZHS93LdC6JGw9gqrpHOMY7ixG3QsPp
         a+ibkrZE5cfSKqK8MqWXAuUMEkbMDnt5MHozI7Q/117olBmKTIAOQQJQjKARfkk1UjyO
         WnFQykUNta9oLbuVVynDyiAQBz6Fr7HfW8UeZKLIhq6il5268y5ttXnS5DkU39lbIJwq
         k674OZ+oRgLwalv/1mpF1RIrmD1G1Ktr0qqFzB7WXxUY3LkaZ/05x9N+URrEDjZ87PrV
         eYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZJ+JK+pfn0imHjNFNKchOvyzFKd3KqFBqEefWoEXz1s=;
        b=yf8rywxnSnlo3rYaxmkwqMlEwvH93/83xlCfnnNv8pVJb1sBxM+owI/oBt2hOcB/hF
         d9HPzfHBChvEpEFDh/g31kMWuLiamLPrEq66sLK4XP4hrcDE4PYeebBV3V/r13AqsewQ
         lszOtSHXqwf3nLPAo3T1GHEJL9tFqbZ7biqLC7NhRl6TDLM1g01/E+P/G6XeINy+9gtL
         Z1Ywa+MlSVm4Ah850WmdQirAd3tYx9OoEsyKIEJOQAucFGZRKaPepxPsFlWn/HuLgBmz
         NwIGfQEFlJqFhHBIKrmX8SjO94CAid7WbEx09qaIdBLW8OpGf9f+CUasOumqUxqDTkar
         Ah9Q==
X-Gm-Message-State: AOAM5338hDnxy5USUzyHvJybaQou7vXtnnAk6Akr4z5Q6nmQ/V2he/2N
        7H09aKDpQx7Exq84eAi99u60PT4b3j0=
X-Google-Smtp-Source: ABdhPJwpkellGn0HrdFtc57hzJguKuhCIpK6l18UEP5GytSxEKfm5gR7nPxaIktl8NXS7OvSzsIyBQ==
X-Received: by 2002:a19:6f08:: with SMTP id k8mr16043018lfc.16.1640007884002;
        Mon, 20 Dec 2021 05:44:44 -0800 (PST)
Received: from [192.168.2.145] (46-138-43-24.dynamic.spd-mgts.ru. [46.138.43.24])
        by smtp.googlemail.com with ESMTPSA id u7sm2537045lja.58.2021.12.20.05.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 05:44:43 -0800 (PST)
Subject: Re: [PATCH v1] memory: tegra30-emc: Print additional memory info
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20211217234711.8353-1-digetx@gmail.com>
 <fc5601e7-40e7-03c5-a433-859539f82144@canonical.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <03a09ff5-fe2d-3ce2-a93b-4e44fd030ffb@gmail.com>
Date:   Mon, 20 Dec 2021 16:44:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <fc5601e7-40e7-03c5-a433-859539f82144@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.12.2021 14:03, Krzysztof Kozlowski пишет:
> On 18/12/2021 00:47, Dmitry Osipenko wrote:
>> Print out memory type and LPDDR2 configuration on Tegra30, making it
>> similar to the memory info printed by the Tegra20 memory driver. This
>> info is useful for debugging purposes.
>>
>> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # T30 ASUS TF201 LPDDR2
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/memory/tegra/Kconfig       |   1 +
>>  drivers/memory/tegra/tegra30-emc.c | 131 ++++++++++++++++++++++++++---
>>  2 files changed, 122 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
>> index 7951764b4efe..3fe83d7c2bf8 100644
>> --- a/drivers/memory/tegra/Kconfig
>> +++ b/drivers/memory/tegra/Kconfig
>> @@ -28,6 +28,7 @@ config TEGRA30_EMC
>>  	default y
>>  	depends on ARCH_TEGRA_3x_SOC || COMPILE_TEST
>>  	select PM_OPP
>> +	select DDR
>>  	help
>>  	  This driver is for the External Memory Controller (EMC) found on
>>  	  Tegra30 chips. The EMC controls the external DRAM on the board.
>> diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
>> index 80f98d717e13..4c0432704f46 100644
>> --- a/drivers/memory/tegra/tegra30-emc.c
>> +++ b/drivers/memory/tegra/tegra30-emc.c
>> @@ -9,6 +9,7 @@
>>   * Copyright (C) 2019 GRATE-DRIVER project
>>   */
>>  
>> +#include <linux/bitfield.h>
>>  #include <linux/clk.h>
>>  #include <linux/clk/tegra.h>
>>  #include <linux/debugfs.h>
>> @@ -31,11 +32,15 @@
>>  #include <soc/tegra/common.h>
>>  #include <soc/tegra/fuse.h>
>>  
>> +#include "../jedec_ddr.h"
>> +#include "../of_memory.h"
>> +
>>  #include "mc.h"
>>  
>>  #define EMC_INTSTATUS				0x000
>>  #define EMC_INTMASK				0x004
>>  #define EMC_DBG					0x008
>> +#define EMC_ADR_CFG				0x010
>>  #define EMC_CFG					0x00c
>>  #define EMC_REFCTRL				0x020
>>  #define EMC_TIMING_CONTROL			0x028
>> @@ -81,6 +86,7 @@
>>  #define EMC_EMRS				0x0d0
>>  #define EMC_SELF_REF				0x0e0
>>  #define EMC_MRW					0x0e8
>> +#define EMC_MRR					0x0ec
>>  #define EMC_XM2DQSPADCTRL3			0x0f8
>>  #define EMC_FBIO_SPARE				0x100
>>  #define EMC_FBIO_CFG5				0x104
>> @@ -208,6 +214,13 @@
>>  
>>  #define EMC_REFRESH_OVERFLOW_INT		BIT(3)
>>  #define EMC_CLKCHANGE_COMPLETE_INT		BIT(4)
>> +#define EMC_MRR_DIVLD_INT			BIT(5)
>> +
>> +#define EMC_MRR_DEV_SELECTN			GENMASK(31, 30)
>> +#define EMC_MRR_MRR_MA				GENMASK(23, 16)
>> +#define EMC_MRR_MRR_DATA			GENMASK(15, 0)
>> +
>> +#define EMC_ADR_CFG_EMEM_NUMDEV			BIT(0)
>>  
>>  enum emc_dram_type {
>>  	DRAM_TYPE_DDR3,
>> @@ -378,6 +391,8 @@ struct tegra_emc {
>>  
>>  	/* protect shared rate-change code path */
>>  	struct mutex rate_lock;
>> +
>> +	bool mrr_error;
>>  };
>>  
>>  static int emc_seq_update_timing(struct tegra_emc *emc)
>> @@ -1008,12 +1023,18 @@ static int emc_load_timings_from_dt(struct tegra_emc *emc,
>>  	return 0;
>>  }
>>  
>> -static struct device_node *emc_find_node_by_ram_code(struct device *dev)
>> +static struct device_node *emc_find_node_by_ram_code(struct tegra_emc *emc)
>>  {
>> +	struct device *dev = emc->dev;
>>  	struct device_node *np;
>>  	u32 value, ram_code;
>>  	int err;
>>  
>> +	if (emc->mrr_error) {
>> +		dev_warn(dev, "memory timings skipped due to MRR error\n");
>> +		return NULL;
>> +	}
>> +
>>  	if (of_get_child_count(dev->of_node) == 0) {
>>  		dev_info_once(dev, "device-tree doesn't have memory timings\n");
>>  		return NULL;
>> @@ -1035,11 +1056,73 @@ static struct device_node *emc_find_node_by_ram_code(struct device *dev)
>>  	return NULL;
>>  }
>>  
>> +static int emc_read_lpddr_mode_register(struct tegra_emc *emc,
>> +					unsigned int emem_dev,
>> +					unsigned int register_addr,
>> +					unsigned int *register_data)
>> +{
>> +	u32 memory_dev = emem_dev + 1;
>> +	u32 val, mr_mask = 0xff;
>> +	int err;
>> +
>> +	/* clear data-valid interrupt status */
>> +	writel_relaxed(EMC_MRR_DIVLD_INT, emc->regs + EMC_INTSTATUS);
>> +
>> +	/* issue mode register read request */
>> +	val  = FIELD_PREP(EMC_MRR_DEV_SELECTN, memory_dev);
>> +	val |= FIELD_PREP(EMC_MRR_MRR_MA, register_addr);
>> +
>> +	writel_relaxed(val, emc->regs + EMC_MRR);
>> +
>> +	/* wait for the LPDDR2 data-valid interrupt */
>> +	err = readl_relaxed_poll_timeout_atomic(emc->regs + EMC_INTSTATUS, val,
>> +						val & EMC_MRR_DIVLD_INT,
>> +						1, 100);
>> +	if (err) {
>> +		dev_err(emc->dev, "mode register %u read failed: %d\n",
>> +			register_addr, err);
>> +		emc->mrr_error = true;
>> +		return err;
>> +	}
>> +
>> +	/* read out mode register data */
>> +	val = readl_relaxed(emc->regs + EMC_MRR);
>> +	*register_data = FIELD_GET(EMC_MRR_MRR_DATA, val) & mr_mask;
>> +
>> +	return 0;
>> +}
>> +
>> +static void emc_read_lpddr_sdram_info(struct tegra_emc *emc,
>> +				      unsigned int emem_dev)
>> +{
>> +	union lpddr2_basic_config4 basic_conf4;
>> +	unsigned int manufacturer_id;
>> +	unsigned int revision_id1;
>> +	unsigned int revision_id2;
>> +
>> +	/* these registers are standard for all LPDDR JEDEC memory chips */
>> +	emc_read_lpddr_mode_register(emc, emem_dev, 5, &manufacturer_id);
>> +	emc_read_lpddr_mode_register(emc, emem_dev, 6, &revision_id1);
>> +	emc_read_lpddr_mode_register(emc, emem_dev, 7, &revision_id2);
>> +	emc_read_lpddr_mode_register(emc, emem_dev, 8, &basic_conf4.value);
>> +
>> +	dev_info(emc->dev, "SDRAM[dev%u]: manufacturer: 0x%x (%s) rev1: 0x%x rev2: 0x%x prefetch: S%u density: %uMbit iowidth: %ubit\n",
>> +		 emem_dev, manufacturer_id,
>> +		 lpddr2_jedec_manufacturer(manufacturer_id),
>> +		 revision_id1, revision_id2,
>> +		 4 >> basic_conf4.arch_type,
>> +		 64 << basic_conf4.density,
>> +		 32 >> basic_conf4.io_width);
>> +}
>> +
> 
> Quickly looking, these two functions are exactly the same as ones in
> tegra20-emc.c
> . Later you might come up with another set for other SoCs, so it looks
> it is worth to share these.

Should be too much trouble for not much gain, IMO. How many bytes will
be shared in the end? There is no much code here, we may lose more than
win. All these Tegra EMC drivers can be compiled as a loadable modules,
that's what distro kernels usually do. There are no plans for other SoCs
for today.

I don't see how that sharing could be done easily and nicely. Please
tell if you see.
