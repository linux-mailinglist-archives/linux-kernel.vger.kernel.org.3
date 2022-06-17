Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D1D54F506
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381686AbiFQKMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378259AbiFQKMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:12:40 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB1227A;
        Fri, 17 Jun 2022 03:12:36 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m24so5113181wrb.10;
        Fri, 17 Jun 2022 03:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=rttnl0mkG4fXonLsOjcgYohoVPmLWo3lA8pP9cQDfvk=;
        b=YpVR1MT6XgxMpP/2nVhWw6Vg1Hp7RkwGE626CCSHJjk/9TybQm/3Ein14VOl9mXfd3
         wk3mdL/v9v7i0qGDyX78OSitDVNFQ2VUaeeSNcagC7dWxI/YlQluQ2XcWUefAmGUoW+I
         acXaxK2JI88PLYyrZ9Xgf2vC+tybdCkyu0X0nk5gb4rf2voP5fuST1LxFIpenK6SWY1+
         nD2/pteXdyH0pp7Tfd7J+88F4DSh/rkr/eQCVS9rFxn8qOCBNAvunGMQzYcR5NTDi0AD
         SgeSmI7UFOc0R0rhcRkvFo3mUDaiz/83Kk0xSjyaxn/rn53wvkoRj4ce86NAF58Ujv25
         AUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=rttnl0mkG4fXonLsOjcgYohoVPmLWo3lA8pP9cQDfvk=;
        b=v5tPc1M8WIEq7p6wXonxuaaKnSP3HuyBcABvEGZ3XwTmyzHN4SheM7E1I9Krydlxpt
         SnfefwEZIiJP0H9KBhpdreud8aokserrAh1M7QKjxM2hBlx3yXHmQIjyQXuGXxfgQCOR
         eYDU7qpAIw3yq0BQImX+6zPCqEMYH03drHKhjQaysbDlJYVD3XJt81R7fmyRP5iS1gqm
         JCxhcJDSHqf6sJ/Co3aVTBLJTQ4rM4JHqntxDrIvIX0XZfR4W7HWeoQIkIsLg4DuXz44
         UQePX26G5QM6UGrbAOD7Sew5Ku2waRd5JtftspMePv9KjXvb63AFga/9I/ma3ov7jtiJ
         DH+w==
X-Gm-Message-State: AJIora+F8SUNFfEzzVmT+s2lQ197XfmHDF5E4GRC7cObz/+ZGIyb9Tn/
        VriZB0GFf9/6NF5tJO6t3G8=
X-Google-Smtp-Source: AGRyM1uN3IWiRvjf+8qRT1Hr0immTCAPNW3Qmze/WcApWqf5T9ukLJkXvWK6f4rTI9B9uxNxPfB72g==
X-Received: by 2002:adf:fa81:0:b0:20e:69df:5f06 with SMTP id h1-20020adffa81000000b0020e69df5f06mr8855160wrr.188.1655460754343;
        Fri, 17 Jun 2022 03:12:34 -0700 (PDT)
Received: from [192.168.0.24] (80.174.78.229.dyn.user.ono.com. [80.174.78.229])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d678f000000b0021b8208fa51sm483475wru.80.2022.06.17.03.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 03:12:33 -0700 (PDT)
Message-ID: <870ec36b-bc3c-377b-114a-4a9417942be2@gmail.com>
Date:   Fri, 17 Jun 2022 12:12:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johnson.wang@mediatek.com, hsin-hsiung.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220616091531.12646-1-angelogioacchino.delregno@collabora.com>
 <20220616091531.12646-3-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 2/2] mfd: mt6397: Add basic support for MT6331+MT6332
 PMIC
In-Reply-To: <20220616091531.12646-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/06/2022 11:15, AngeloGioacchino Del Regno wrote:
> Add support for the MT6331 PMIC with MT6332 Companion PMIC, found
> in MT6795 Helio X10 smartphone platforms.
> 
> This combo has support for multiple devices but, for a start,
> only the following have been implemented:
> - Regulators (two instances, one in MT6331, one in MT6332)
> - RTC (MT6331)
> - Keys (MT6331)
> - Interrupts (MT6331 also dispatches MT6332's interrupts)
> 
> There's more to be implemented, especially for MT6332, which
> will come at a later stage.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/mfd/mt6397-core.c            |  47 ++
>   drivers/mfd/mt6397-irq.c             |   9 +-
>   include/linux/mfd/mt6331/core.h      |  53 +++
>   include/linux/mfd/mt6331/registers.h | 584 ++++++++++++++++++++++++
>   include/linux/mfd/mt6332/core.h      |  53 +++
>   include/linux/mfd/mt6332/registers.h | 642 +++++++++++++++++++++++++++
>   include/linux/mfd/mt6397/core.h      |   2 +
>   7 files changed, 1389 insertions(+), 1 deletion(-)
>   create mode 100644 include/linux/mfd/mt6331/core.h
>   create mode 100644 include/linux/mfd/mt6331/registers.h
>   create mode 100644 include/linux/mfd/mt6332/core.h
>   create mode 100644 include/linux/mfd/mt6332/registers.h
> 
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 1a368ad08f58..1c974132dc0b 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -12,10 +12,12 @@
>   #include <linux/regmap.h>
>   #include <linux/mfd/core.h>
>   #include <linux/mfd/mt6323/core.h>
> +#include <linux/mfd/mt6331/core.h>
>   #include <linux/mfd/mt6358/core.h>
>   #include <linux/mfd/mt6359/core.h>
>   #include <linux/mfd/mt6397/core.h>
>   #include <linux/mfd/mt6323/registers.h>
> +#include <linux/mfd/mt6331/registers.h>
>   #include <linux/mfd/mt6358/registers.h>
>   #include <linux/mfd/mt6359/registers.h>
>   #include <linux/mfd/mt6397/registers.h>
> @@ -23,6 +25,9 @@
>   #define MT6323_RTC_BASE		0x8000
>   #define MT6323_RTC_SIZE		0x40
>   
> +#define MT6331_RTC_BASE		0x4000
> +#define MT6331_RTC_SIZE		0x40
> +
>   #define MT6358_RTC_BASE		0x0588
>   #define MT6358_RTC_SIZE		0x3c
>   
> @@ -37,6 +42,11 @@ static const struct resource mt6323_rtc_resources[] = {
>   	DEFINE_RES_IRQ(MT6323_IRQ_STATUS_RTC),
>   };
>   
> +static const struct resource mt6331_rtc_resources[] = {
> +	DEFINE_RES_MEM(MT6331_RTC_BASE, MT6331_RTC_SIZE),
> +	DEFINE_RES_IRQ(MT6331_IRQ_STATUS_RTC),
> +};
> +
>   static const struct resource mt6358_rtc_resources[] = {
>   	DEFINE_RES_MEM(MT6358_RTC_BASE, MT6358_RTC_SIZE),
>   	DEFINE_RES_IRQ(MT6358_IRQ_RTC),
> @@ -66,6 +76,11 @@ static const struct resource mt6323_keys_resources[] = {
>   	DEFINE_RES_IRQ_NAMED(MT6323_IRQ_STATUS_FCHRKEY, "homekey"),
>   };
>   
> +static const struct resource mt6331_keys_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(MT6331_IRQ_STATUS_PWRKEY, "powerkey"),
> +	DEFINE_RES_IRQ_NAMED(MT6331_IRQ_STATUS_HOMEKEY, "homekey"),
> +};
> +
>   static const struct resource mt6397_keys_resources[] = {
>   	DEFINE_RES_IRQ_NAMED(MT6397_IRQ_PWRKEY, "powerkey"),
>   	DEFINE_RES_IRQ_NAMED(MT6397_IRQ_HOMEKEY, "homekey"),
> @@ -100,6 +115,27 @@ static const struct mfd_cell mt6323_devs[] = {
>   	},
>   };
>   
> +/* MT6331 is always used in combination with MT6332 */
> +static const struct mfd_cell mt6331_mt6332_devs[] = {
> +	{
> +		.name = "mt6331-rtc",
> +		.num_resources = ARRAY_SIZE(mt6331_rtc_resources),
> +		.resources = mt6331_rtc_resources,
> +		.of_compatible = "mediatek,mt6331-rtc",
> +	}, {
> +		.name = "mt6331-regulator",
> +		.of_compatible = "mediatek,mt6331-regulator"
> +	}, {
> +		.name = "mt6332-regulator",
> +		.of_compatible = "mediatek,mt6332-regulator"
> +	}, {
> +		.name = "mtk-pmic-keys",
> +		.num_resources = ARRAY_SIZE(mt6331_keys_resources),
> +		.resources = mt6331_keys_resources,
> +		.of_compatible = "mediatek,mt6331-keys"
> +	},
> +};
> +
>   static const struct mfd_cell mt6358_devs[] = {
>   	{
>   		.name = "mt6358-regulator",
> @@ -179,6 +215,14 @@ static const struct chip_data mt6323_core = {
>   	.irq_init = mt6397_irq_init,
>   };
>   
> +static const struct chip_data mt6331_mt6332_core = {
> +	.cid_addr = MT6331_HWCID,
> +	.cid_shift = 0,
> +	.cells = mt6331_mt6332_devs,
> +	.cell_size = ARRAY_SIZE(mt6331_mt6332_devs),
> +	.irq_init = mt6397_irq_init,
> +};
> +
>   static const struct chip_data mt6358_core = {
>   	.cid_addr = MT6358_SWCID,
>   	.cid_shift = 8,
> @@ -261,6 +305,9 @@ static const struct of_device_id mt6397_of_match[] = {
>   	{
>   		.compatible = "mediatek,mt6323",
>   		.data = &mt6323_core,
> +	}, {
> +		.compatible = "mediatek,mt6331",
> +		.data = &mt6331_mt6332_core,
>   	}, {
>   		.compatible = "mediatek,mt6358",
>   		.data = &mt6358_core,
> diff --git a/drivers/mfd/mt6397-irq.c b/drivers/mfd/mt6397-irq.c
> index 2924919da991..eff53fed8fe7 100644
> --- a/drivers/mfd/mt6397-irq.c
> +++ b/drivers/mfd/mt6397-irq.c
> @@ -12,6 +12,8 @@
>   #include <linux/suspend.h>
>   #include <linux/mfd/mt6323/core.h>
>   #include <linux/mfd/mt6323/registers.h>
> +#include <linux/mfd/mt6331/core.h>
> +#include <linux/mfd/mt6331/registers.h>
>   #include <linux/mfd/mt6397/core.h>
>   #include <linux/mfd/mt6397/registers.h>
>   
> @@ -172,7 +174,12 @@ int mt6397_irq_init(struct mt6397_chip *chip)
>   		chip->int_status[0] = MT6323_INT_STATUS0;
>   		chip->int_status[1] = MT6323_INT_STATUS1;
>   		break;
> -
> +	case MT6331_CHIP_ID:

I'm a bit puzzeld about the IDs of both are the same, should we at least add 
"case MT6332_CHIP_ID:" here to make clear this holds for bot chips?

> +		chip->int_con[0] = MT6331_INT_CON0;
> +		chip->int_con[1] = MT6331_INT_CON1;
> +		chip->int_status[0] = MT6331_INT_STATUS_CON0;
> +		chip->int_status[1] = MT6331_INT_STATUS_CON1;
> +		break;
>   	case MT6391_CHIP_ID:
>   	case MT6397_CHIP_ID:
>   		chip->int_con[0] = MT6397_INT_CON0;
> diff --git a/include/linux/mfd/mt6331/core.h b/include/linux/mfd/mt6331/core.h
> new file mode 100644
> index 000000000000..d0fabcd53eb4
> --- /dev/null
> +++ b/include/linux/mfd/mt6331/core.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2021 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +
> +#ifndef __MFD_MT6331_CORE_H__
> +#define __MFD_MT6331_CORE_H__
> +
> +enum mt6331_irq_status_numbers {
> +	MT6331_IRQ_STATUS_PWRKEY = 0,
> +	MT6331_IRQ_STATUS_HOMEKEY,
> +	MT6331_IRQ_STATUS_CHRDET,
> +	MT6331_IRQ_STATUS_THR_H,
> +	MT6331_IRQ_STATUS_THR_L,
> +	MT6331_IRQ_STATUS_BAT_H,
> +	MT6331_IRQ_STATUS_BAT_L,
> +	MT6331_IRQ_STATUS_RTC,
> +	MT6331_IRQ_STATUS_AUDIO,
> +	MT6331_IRQ_STATUS_MAD,
> +	MT6331_IRQ_STATUS_ACCDET,
> +	MT6331_IRQ_STATUS_ACCDET_EINT,
> +	MT6331_IRQ_STATUS_ACCDET_NEGV = 12,
> +	MT6331_IRQ_STATUS_VDVFS11_OC = 16,
> +	MT6331_IRQ_STATUS_VDVFS12_OC,
> +	MT6331_IRQ_STATUS_VDVFS13_OC,
> +	MT6331_IRQ_STATUS_VDVFS14_OC,
> +	MT6331_IRQ_STATUS_GPU_OC,
> +	MT6331_IRQ_STATUS_VCORE1_OC,
> +	MT6331_IRQ_STATUS_VCORE2_OC,
> +	MT6331_IRQ_STATUS_VIO18_OC,
> +	MT6331_IRQ_STATUS_LDO_OC,
> +	MT6331_IRQ_STATUS_NR,
> +};
> +
> +#define MT6331_IRQ_CON0_BASE	MT6331_IRQ_STATUS_PWRKEY
> +#define MT6331_IRQ_CON0_BITS	(MT6331_IRQ_STATUS_ACCDET_NEGV + 1)
> +#define MT6331_IRQ_CON1_BASE	MT6331_IRQ_STATUS_VDVFS11_OC
> +#define MT6331_IRQ_CON1_BITS	(MT6331_IRQ_STATUS_LDO_OC - MT6331_IRQ_STATUS_VDFS11_OC + 1)
> +
> +#define MT6331_INT_GEN(sp)				\
> +{							\
> +	.hwirq_base = MT6331_IRQ_##sp##_BASE,		\
> +	.num_int_regs =					\
> +		((MT6331_IRQ_##sp##_BITS - 1) /		\
> +		MTK_PMIC_REG_WIDTH) + 1,		\
> +	.en_reg = MT6331_INT_##sp##,			\
> +	.en_reg_shift = 0x6,				\
> +	.sta_reg = MT6331_INT_STATUS0_##sp##,		\
> +	.sta_reg_shift = 0x2,				\
> +	.top_offset = MT6331_##sp##_TOP,		\
> +}

What will we need this macro for? It's not used here.

> +
> +#endif /* __MFD_MT6331_CORE_H__ */
> diff --git a/include/linux/mfd/mt6331/registers.h b/include/linux/mfd/mt6331/registers.h
> new file mode 100644
> index 000000000000..1fcd727891b6
> --- /dev/null
> +++ b/include/linux/mfd/mt6331/registers.h
> @@ -0,0 +1,584 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2021 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +
> +#ifndef __MFD_MT6331_REGISTERS_H__
> +#define __MFD_MT6331_REGISTERS_H__
> +
> +/* PMIC Registers */
> +#define MT6331_STRUP_CON0		0x0
> +#define MT6331_STRUP_CON2		0x2
> +#define MT6331_STRUP_CON3		0x4
> +#define MT6331_STRUP_CON4		0x6
> +#define MT6331_STRUP_CON5		0x8
> +#define MT6331_STRUP_CON6		0xA
> +#define MT6331_STRUP_CON7		0xC
> +#define MT6331_STRUP_CON8		0xE
> +#define MT6331_STRUP_CON9		0x10
> +#define MT6331_STRUP_CON10		0x12
> +#define MT6331_STRUP_CON11		0x14
> +#define MT6331_STRUP_CON12		0x16
> +#define MT6331_STRUP_CON13		0x18
> +#define MT6331_STRUP_CON14		0x1A
> +#define MT6331_STRUP_CON15		0x1C
> +#define MT6331_STRUP_CON16		0x1E
> +#define MT6331_STRUP_CON17		0x20
> +#define MT6331_STRUP_CON18		0x22
> +#define MT6331_HWCID			0x100
> +#define MT6331_SWCID			0x102
> +#define MT6331_EXT_PMIC_STATUS		0x104
> +#define MT6331_TOP_CON			0x106
> +#define MT6331_TEST_OUT			0x108
> +#define MT6331_TEST_CON0		0x10A
> +#define MT6331_TEST_CON1		0x10C
> +#define MT6331_TESTMODE_SW		0x10E
> +#define MT6331_EN_STATUS0		0x110
> +#define MT6331_EN_STATUS1		0x112
> +#define MT6331_EN_STATUS2		0x114
> +#define MT6331_OCSTATUS0		0x116
> +#define MT6331_OCSTATUS1		0x118
> +#define MT6331_OCSTATUS2		0x11A
> +#define MT6331_PGSTATUS			0x11C
> +#define MT6331_TOPSTATUS		0x11E
> +#define MT6331_TDSEL_CON		0x120
> +#define MT6331_RDSEL_CON		0x122
> +#define MT6331_SMT_CON0			0x124
> +#define MT6331_SMT_CON1			0x126
> +#define MT6331_SMT_CON2			0x128
> +#define MT6331_DRV_CON0			0x12A
> +#define MT6331_DRV_CON1			0x12C
> +#define MT6331_DRV_CON2			0x12E
> +#define MT6331_DRV_CON3			0x130
> +#define MT6331_TOP_STATUS		0x132
> +#define MT6331_TOP_STATUS_SET		0x134
> +#define MT6331_TOP_STATUS_CLR		0x136
> +#define MT6331_TOP_CKPDN_CON0		0x138
> +#define MT6331_TOP_CKPDN_CON0_SET	0x13A
> +#define MT6331_TOP_CKPDN_CON0_CLR	0x13C
> +#define MT6331_TOP_CKPDN_CON1		0x13E
> +#define MT6331_TOP_CKPDN_CON1_SET	0x140
> +#define MT6331_TOP_CKPDN_CON1_CLR	0x142
> +#define MT6331_TOP_CKPDN_CON2		0x144
> +#define MT6331_TOP_CKPDN_CON2_SET	0x146
> +#define MT6331_TOP_CKPDN_CON2_CLR	0x148
> +#define MT6331_TOP_CKSEL_CON		0x14A
> +#define MT6331_TOP_CKSEL_CON_SET	0x14C
> +#define MT6331_TOP_CKSEL_CON_CLR	0x14E
> +#define MT6331_TOP_CKHWEN_CON		0x150
> +#define MT6331_TOP_CKHWEN_CON_SET	0x152
> +#define MT6331_TOP_CKHWEN_CON_CLR	0x154
> +#define MT6331_TOP_CKTST_CON0		0x156
> +#define MT6331_TOP_CKTST_CON1		0x158
> +#define MT6331_TOP_CLKSQ		0x15A
> +#define MT6331_TOP_CLKSQ_SET		0x15C
> +#define MT6331_TOP_CLKSQ_CLR		0x15E
> +#define MT6331_TOP_RST_CON		0x160
> +#define MT6331_TOP_RST_CON_SET		0x162
> +#define MT6331_TOP_RST_CON_CLR		0x164
> +#define MT6331_TOP_RST_MISC		0x166
> +#define MT6331_TOP_RST_MISC_SET		0x168
> +#define MT6331_TOP_RST_MISC_CLR		0x16A
> +#define MT6331_INT_CON0			0x16C
> +#define MT6331_INT_CON0_SET		0x16E
> +#define MT6331_INT_CON0_CLR		0x170
> +#define MT6331_INT_CON1			0x172
> +#define MT6331_INT_CON1_SET		0x174
> +#define MT6331_INT_CON1_CLR		0x176
> +#define MT6331_INT_MISC_CON		0x178
> +#define MT6331_INT_MISC_CON_SET		0x17A
> +#define MT6331_INT_MISC_CON_CLR		0x17C
> +#define MT6331_INT_STATUS_CON0		0x17E
> +#define MT6331_INT_STATUS_CON1		0x180
> +#define MT6331_OC_GEAR_0		0x182
> +#define MT6331_FQMTR_CON0		0x184
> +#define MT6331_FQMTR_CON1		0x186
> +#define MT6331_FQMTR_CON2		0x188
> +#define MT6331_RG_SPI_CON		0x18A
> +#define MT6331_DEW_DIO_EN		0x18C
> +#define MT6331_DEW_READ_TEST		0x18E
> +#define MT6331_DEW_WRITE_TEST		0x190
> +#define MT6331_DEW_CRC_SWRST		0x192
> +#define MT6331_DEW_CRC_EN		0x194
> +#define MT6331_DEW_CRC_VAL		0x196
> +#define MT6331_DEW_DBG_MON_SEL		0x198
> +#define MT6331_DEW_CIPHER_KEY_SEL	0x19A
> +#define MT6331_DEW_CIPHER_IV_SEL	0x19C
> +#define MT6331_DEW_CIPHER_EN		0x19E
> +#define MT6331_DEW_CIPHER_RDY		0x1A0
> +#define MT6331_DEW_CIPHER_MODE		0x1A2
> +#define MT6331_DEW_CIPHER_SWRST		0x1A4
> +#define MT6331_DEW_RDDMY_NO		0x1A6
> +#define MT6331_INT_TYPE_CON0		0x1A8
> +#define MT6331_INT_TYPE_CON0_SET	0x1AA
> +#define MT6331_INT_TYPE_CON0_CLR	0x1AC
> +#define MT6331_INT_TYPE_CON1		0x1AE
> +#define MT6331_INT_TYPE_CON1_SET	0x1B0
> +#define MT6331_INT_TYPE_CON1_CLR	0x1B2
> +#define MT6331_INT_STA			0x1B4
> +#define MT6331_BUCK_ALL_CON0		0x200
> +#define MT6331_BUCK_ALL_CON1		0x202
> +#define MT6331_BUCK_ALL_CON2		0x204
> +#define MT6331_BUCK_ALL_CON3		0x206
> +#define MT6331_BUCK_ALL_CON4		0x208
> +#define MT6331_BUCK_ALL_CON5		0x20A
> +#define MT6331_BUCK_ALL_CON6		0x20C
> +#define MT6331_BUCK_ALL_CON7		0x20E
> +#define MT6331_BUCK_ALL_CON8		0x210
> +#define MT6331_BUCK_ALL_CON9		0x212
> +#define MT6331_BUCK_ALL_CON10		0x214
> +#define MT6331_BUCK_ALL_CON11		0x216
> +#define MT6331_BUCK_ALL_CON12		0x218
> +#define MT6331_BUCK_ALL_CON13		0x21A
> +#define MT6331_BUCK_ALL_CON14		0x21C
> +#define MT6331_BUCK_ALL_CON15		0x21E
> +#define MT6331_BUCK_ALL_CON16		0x220
> +#define MT6331_BUCK_ALL_CON17		0x222
> +#define MT6331_BUCK_ALL_CON18		0x224
> +#define MT6331_BUCK_ALL_CON19		0x226
> +#define MT6331_BUCK_ALL_CON20		0x228
> +#define MT6331_BUCK_ALL_CON21		0x22A
> +#define MT6331_BUCK_ALL_CON22		0x22C
> +#define MT6331_BUCK_ALL_CON23		0x22E
> +#define MT6331_BUCK_ALL_CON24		0x230
> +#define MT6331_BUCK_ALL_CON25		0x232
> +#define MT6331_BUCK_ALL_CON26		0x234
> +#define MT6331_VDVFS11_CON0		0x236
> +#define MT6331_VDVFS11_CON1		0x238
> +#define MT6331_VDVFS11_CON2		0x23A
> +#define MT6331_VDVFS11_CON3		0x23C
> +#define MT6331_VDVFS11_CON4		0x23E
> +#define MT6331_VDVFS11_CON5		0x240
> +#define MT6331_VDVFS11_CON6		0x242
> +#define MT6331_VDVFS11_CON7		0x244
> +#define MT6331_VDVFS11_CON8		0x246
> +#define MT6331_VDVFS11_CON9		0x248
> +#define MT6331_VDVFS11_CON10		0x24A
> +#define MT6331_VDVFS11_CON11		0x24C
> +#define MT6331_VDVFS11_CON12		0x24E
> +#define MT6331_VDVFS11_CON13		0x250
> +#define MT6331_VDVFS11_CON14		0x252
> +#define MT6331_VDVFS11_CON18		0x25A
> +#define MT6331_VDVFS11_CON19		0x25C
> +#define MT6331_VDVFS11_CON20		0x25E
> +#define MT6331_VDVFS11_CON21		0x260
> +#define MT6331_VDVFS11_CON22		0x262
> +#define MT6331_VDVFS11_CON23		0x264
> +#define MT6331_VDVFS11_CON24		0x266
> +#define MT6331_VDVFS11_CON25		0x268
> +#define MT6331_VDVFS11_CON26		0x26A
> +#define MT6331_VDVFS11_CON27		0x26C
> +#define MT6331_VDVFS12_CON0		0x26E
> +#define MT6331_VDVFS12_CON1		0x270
> +#define MT6331_VDVFS12_CON2		0x272
> +#define MT6331_VDVFS12_CON3		0x274
> +#define MT6331_VDVFS12_CON4		0x276
> +#define MT6331_VDVFS12_CON5		0x278
> +#define MT6331_VDVFS12_CON6		0x27A
> +#define MT6331_VDVFS12_CON7		0x27C
> +#define MT6331_VDVFS12_CON8		0x27E
> +#define MT6331_VDVFS12_CON9		0x280
> +#define MT6331_VDVFS12_CON10		0x282
> +#define MT6331_VDVFS12_CON11		0x284
> +#define MT6331_VDVFS12_CON12		0x286
> +#define MT6331_VDVFS12_CON13		0x288
> +#define MT6331_VDVFS12_CON14		0x28A
> +#define MT6331_VDVFS12_CON18		0x292
> +#define MT6331_VDVFS12_CON19		0x294
> +#define MT6331_VDVFS12_CON20		0x296
> +#define MT6331_VDVFS13_CON0		0x298
> +#define MT6331_VDVFS13_CON1		0x29A
> +#define MT6331_VDVFS13_CON2		0x29C
> +#define MT6331_VDVFS13_CON3		0x29E
> +#define MT6331_VDVFS13_CON4		0x2A0
> +#define MT6331_VDVFS13_CON5		0x2A2
> +#define MT6331_VDVFS13_CON6		0x2A4
> +#define MT6331_VDVFS13_CON7		0x2A6
> +#define MT6331_VDVFS13_CON8		0x2A8
> +#define MT6331_VDVFS13_CON9		0x2AA
> +#define MT6331_VDVFS13_CON10		0x2AC
> +#define MT6331_VDVFS13_CON11		0x2AE
> +#define MT6331_VDVFS13_CON12		0x2B0
> +#define MT6331_VDVFS13_CON13		0x2B2
> +#define MT6331_VDVFS13_CON14		0x2B4
> +#define MT6331_VDVFS13_CON18		0x2BC
> +#define MT6331_VDVFS13_CON19		0x2BE
> +#define MT6331_VDVFS13_CON20		0x2C0
> +#define MT6331_VDVFS14_CON0		0x2C2
> +#define MT6331_VDVFS14_CON1		0x2C4
> +#define MT6331_VDVFS14_CON2		0x2C6
> +#define MT6331_VDVFS14_CON3		0x2C8
> +#define MT6331_VDVFS14_CON4		0x2CA
> +#define MT6331_VDVFS14_CON5		0x2CC
> +#define MT6331_VDVFS14_CON6		0x2CE
> +#define MT6331_VDVFS14_CON7		0x2D0
> +#define MT6331_VDVFS14_CON8		0x2D2
> +#define MT6331_VDVFS14_CON9		0x2D4
> +#define MT6331_VDVFS14_CON10		0x2D6
> +#define MT6331_VDVFS14_CON11		0x2D8
> +#define MT6331_VDVFS14_CON12		0x2DA
> +#define MT6331_VDVFS14_CON13		0x2DC
> +#define MT6331_VDVFS14_CON14		0x2DE
> +#define MT6331_VDVFS14_CON18		0x2E6
> +#define MT6331_VDVFS14_CON19		0x2E8
> +#define MT6331_VDVFS14_CON20		0x2EA
> +#define MT6331_VGPU_CON0		0x300
> +#define MT6331_VGPU_CON1		0x302
> +#define MT6331_VGPU_CON2		0x304
> +#define MT6331_VGPU_CON3		0x306
> +#define MT6331_VGPU_CON4		0x308
> +#define MT6331_VGPU_CON5		0x30A
> +#define MT6331_VGPU_CON6		0x30C
> +#define MT6331_VGPU_CON7		0x30E
> +#define MT6331_VGPU_CON8		0x310
> +#define MT6331_VGPU_CON9		0x312
> +#define MT6331_VGPU_CON10		0x314
> +#define MT6331_VGPU_CON11		0x316
> +#define MT6331_VGPU_CON12		0x318
> +#define MT6331_VGPU_CON13		0x31A
> +#define MT6331_VGPU_CON14		0x31C
> +#define MT6331_VGPU_CON15		0x31E
> +#define MT6331_VGPU_CON16		0x320
> +#define MT6331_VGPU_CON17		0x322
> +#define MT6331_VGPU_CON18		0x324
> +#define MT6331_VGPU_CON19		0x326
> +#define MT6331_VGPU_CON20		0x328
> +#define MT6331_VCORE1_CON0		0x32A
> +#define MT6331_VCORE1_CON1		0x32C
> +#define MT6331_VCORE1_CON2		0x32E
> +#define MT6331_VCORE1_CON3		0x330
> +#define MT6331_VCORE1_CON4		0x332
> +#define MT6331_VCORE1_CON5		0x334
> +#define MT6331_VCORE1_CON6		0x336
> +#define MT6331_VCORE1_CON7		0x338
> +#define MT6331_VCORE1_CON8		0x33A
> +#define MT6331_VCORE1_CON9		0x33C
> +#define MT6331_VCORE1_CON10		0x33E
> +#define MT6331_VCORE1_CON11		0x340
> +#define MT6331_VCORE1_CON12		0x342
> +#define MT6331_VCORE1_CON13		0x344
> +#define MT6331_VCORE1_CON14		0x346
> +#define MT6331_VCORE1_CON15		0x348
> +#define MT6331_VCORE1_CON16		0x34A
> +#define MT6331_VCORE1_CON17		0x34C
> +#define MT6331_VCORE1_CON18		0x34E
> +#define MT6331_VCORE1_CON19		0x350
> +#define MT6331_VCORE1_CON20		0x352
> +#define MT6331_VCORE2_CON0		0x354
> +#define MT6331_VCORE2_CON1		0x356
> +#define MT6331_VCORE2_CON2		0x358
> +#define MT6331_VCORE2_CON3		0x35A
> +#define MT6331_VCORE2_CON4		0x35C
> +#define MT6331_VCORE2_CON5		0x35E
> +#define MT6331_VCORE2_CON6		0x360
> +#define MT6331_VCORE2_CON7		0x362
> +#define MT6331_VCORE2_CON8		0x364
> +#define MT6331_VCORE2_CON9		0x366
> +#define MT6331_VCORE2_CON10		0x368
> +#define MT6331_VCORE2_CON11		0x36A
> +#define MT6331_VCORE2_CON12		0x36C
> +#define MT6331_VCORE2_CON13		0x36E
> +#define MT6331_VCORE2_CON14		0x370
> +#define MT6331_VCORE2_CON15		0x372
> +#define MT6331_VCORE2_CON16		0x374
> +#define MT6331_VCORE2_CON17		0x376
> +#define MT6331_VCORE2_CON18		0x378
> +#define MT6331_VCORE2_CON19		0x37A
> +#define MT6331_VCORE2_CON20		0x37C
> +#define MT6331_VCORE2_CON21		0x37E
> +#define MT6331_VIO18_CON0		0x380
> +#define MT6331_VIO18_CON1		0x382
> +#define MT6331_VIO18_CON2		0x384
> +#define MT6331_VIO18_CON3		0x386
> +#define MT6331_VIO18_CON4		0x388
> +#define MT6331_VIO18_CON5		0x38A
> +#define MT6331_VIO18_CON6		0x38C
> +#define MT6331_VIO18_CON7		0x38E
> +#define MT6331_VIO18_CON8		0x390
> +#define MT6331_VIO18_CON9		0x392
> +#define MT6331_VIO18_CON10		0x394
> +#define MT6331_VIO18_CON11		0x396
> +#define MT6331_VIO18_CON12		0x398
> +#define MT6331_VIO18_CON13		0x39A
> +#define MT6331_VIO18_CON14		0x39C
> +#define MT6331_VIO18_CON15		0x39E
> +#define MT6331_VIO18_CON16		0x3A0
> +#define MT6331_VIO18_CON17		0x3A2
> +#define MT6331_VIO18_CON18		0x3A4
> +#define MT6331_VIO18_CON19		0x3A6
> +#define MT6331_VIO18_CON20		0x3A8
> +#define MT6331_BUCK_K_CON0		0x3AA
> +#define MT6331_BUCK_K_CON1		0x3AC
> +#define MT6331_BUCK_K_CON2		0x3AE
> +#define MT6331_BUCK_K_CON3		0x3B0
> +#define MT6331_ZCD_CON0			0x400
> +#define MT6331_ZCD_CON1			0x402
> +#define MT6331_ZCD_CON2			0x404
> +#define MT6331_ZCD_CON3			0x406
> +#define MT6331_ZCD_CON4			0x408
> +#define MT6331_ZCD_CON5			0x40A
> +#define MT6331_ISINK0_CON0		0x40C
> +#define MT6331_ISINK0_CON1		0x40E
> +#define MT6331_ISINK0_CON2		0x410
> +#define MT6331_ISINK0_CON3		0x412
> +#define MT6331_ISINK0_CON4		0x414
> +#define MT6331_ISINK1_CON0		0x416
> +#define MT6331_ISINK1_CON1		0x418
> +#define MT6331_ISINK1_CON2		0x41A
> +#define MT6331_ISINK1_CON3		0x41C
> +#define MT6331_ISINK1_CON4		0x41E
> +#define MT6331_ISINK2_CON0		0x420
> +#define MT6331_ISINK2_CON1		0x422
> +#define MT6331_ISINK2_CON2		0x424
> +#define MT6331_ISINK2_CON3		0x426
> +#define MT6331_ISINK2_CON4		0x428
> +#define MT6331_ISINK3_CON0		0x42A
> +#define MT6331_ISINK3_CON1		0x42C
> +#define MT6331_ISINK3_CON2		0x42E
> +#define MT6331_ISINK3_CON3		0x430
> +#define MT6331_ISINK3_CON4		0x432
> +#define MT6331_ISINK_ANA0		0x434
> +#define MT6331_ISINK_ANA1		0x436
> +#define MT6331_ISINK_PHASE_DLY		0x438
> +#define MT6331_ISINK_EN_CTRL		0x43A
> +#define MT6331_ANALDO_CON0		0x500
> +#define MT6331_ANALDO_CON1		0x502
> +#define MT6331_ANALDO_CON2		0x504
> +#define MT6331_ANALDO_CON3		0x506
> +#define MT6331_ANALDO_CON4		0x508
> +#define MT6331_ANALDO_CON5		0x50A
> +#define MT6331_ANALDO_CON6		0x50C
> +#define MT6331_ANALDO_CON7		0x50E
> +#define MT6331_ANALDO_CON8		0x510
> +#define MT6331_ANALDO_CON9		0x512
> +#define MT6331_ANALDO_CON10		0x514
> +#define MT6331_ANALDO_CON11		0x516
> +#define MT6331_ANALDO_CON12		0x518
> +#define MT6331_ANALDO_CON13		0x51A
> +#define MT6331_SYSLDO_CON0		0x51C
> +#define MT6331_SYSLDO_CON1		0x51E
> +#define MT6331_SYSLDO_CON2		0x520
> +#define MT6331_SYSLDO_CON3		0x522
> +#define MT6331_SYSLDO_CON4		0x524
> +#define MT6331_SYSLDO_CON5		0x526
> +#define MT6331_SYSLDO_CON6		0x528
> +#define MT6331_SYSLDO_CON7		0x52A
> +#define MT6331_SYSLDO_CON8		0x52C
> +#define MT6331_SYSLDO_CON9		0x52E
> +#define MT6331_SYSLDO_CON10		0x530
> +#define MT6331_SYSLDO_CON11		0x532
> +#define MT6331_SYSLDO_CON12		0x534
> +#define MT6331_SYSLDO_CON13		0x536
> +#define MT6331_SYSLDO_CON14		0x538
> +#define MT6331_SYSLDO_CON15		0x53A
> +#define MT6331_SYSLDO_CON16		0x53C
> +#define MT6331_SYSLDO_CON17		0x53E
> +#define MT6331_SYSLDO_CON18		0x540
> +#define MT6331_SYSLDO_CON19		0x542
> +#define MT6331_SYSLDO_CON20		0x544
> +#define MT6331_SYSLDO_CON21		0x546
> +#define MT6331_DIGLDO_CON0		0x548
> +#define MT6331_DIGLDO_CON1		0x54A
> +#define MT6331_DIGLDO_CON2		0x54C
> +#define MT6331_DIGLDO_CON3		0x54E
> +#define MT6331_DIGLDO_CON4		0x550
> +#define MT6331_DIGLDO_CON5		0x552
> +#define MT6331_DIGLDO_CON6		0x554
> +#define MT6331_DIGLDO_CON7		0x556
> +#define MT6331_DIGLDO_CON8		0x558
> +#define MT6331_DIGLDO_CON9		0x55A
> +#define MT6331_DIGLDO_CON10		0x55C
> +#define MT6331_DIGLDO_CON11		0x55E
> +#define MT6331_DIGLDO_CON12		0x560
> +#define MT6331_DIGLDO_CON13		0x562
> +#define MT6331_DIGLDO_CON14		0x564
> +#define MT6331_DIGLDO_CON15		0x566
> +#define MT6331_DIGLDO_CON16		0x568
> +#define MT6331_DIGLDO_CON17		0x56A
> +#define MT6331_DIGLDO_CON18		0x56C
> +#define MT6331_DIGLDO_CON19		0x56E
> +#define MT6331_DIGLDO_CON20		0x570
> +#define MT6331_DIGLDO_CON21		0x572
> +#define MT6331_DIGLDO_CON22		0x574
> +#define MT6331_DIGLDO_CON23		0x576
> +#define MT6331_DIGLDO_CON24		0x578
> +#define MT6331_DIGLDO_CON25		0x57A
> +#define MT6331_DIGLDO_CON26		0x57C
> +#define MT6331_DIGLDO_CON27		0x57E
> +#define MT6331_DIGLDO_CON28		0x580
> +#define MT6331_OTP_CON0			0x600
> +#define MT6331_OTP_CON1			0x602
> +#define MT6331_OTP_CON2			0x604
> +#define MT6331_OTP_CON3			0x606
> +#define MT6331_OTP_CON4			0x608
> +#define MT6331_OTP_CON5			0x60A
> +#define MT6331_OTP_CON6			0x60C
> +#define MT6331_OTP_CON7			0x60E
> +#define MT6331_OTP_CON8			0x610
> +#define MT6331_OTP_CON9			0x612
> +#define MT6331_OTP_CON10		0x614
> +#define MT6331_OTP_CON11		0x616
> +#define MT6331_OTP_CON12		0x618
> +#define MT6331_OTP_CON13		0x61A
> +#define MT6331_OTP_CON14		0x61C
> +#define MT6331_OTP_DOUT_0_15		0x61E
> +#define MT6331_OTP_DOUT_16_31		0x620
> +#define MT6331_OTP_DOUT_32_47		0x622
> +#define MT6331_OTP_DOUT_48_63		0x624
> +#define MT6331_OTP_DOUT_64_79		0x626
> +#define MT6331_OTP_DOUT_80_95		0x628
> +#define MT6331_OTP_DOUT_96_111		0x62A
> +#define MT6331_OTP_DOUT_112_127		0x62C
> +#define MT6331_OTP_DOUT_128_143		0x62E
> +#define MT6331_OTP_DOUT_144_159		0x630
> +#define MT6331_OTP_DOUT_160_175		0x632
> +#define MT6331_OTP_DOUT_176_191		0x634
> +#define MT6331_OTP_DOUT_192_207		0x636
> +#define MT6331_OTP_DOUT_208_223		0x638
> +#define MT6331_OTP_DOUT_224_239		0x63A
> +#define MT6331_OTP_DOUT_240_255		0x63C
> +#define MT6331_OTP_VAL_0_15		0x63E
> +#define MT6331_OTP_VAL_16_31		0x640
> +#define MT6331_OTP_VAL_32_47		0x642
> +#define MT6331_OTP_VAL_48_63		0x644
> +#define MT6331_OTP_VAL_64_79		0x646
> +#define MT6331_OTP_VAL_80_95		0x648
> +#define MT6331_OTP_VAL_96_111		0x64A
> +#define MT6331_OTP_VAL_112_127		0x64C
> +#define MT6331_OTP_VAL_128_143		0x64E
> +#define MT6331_OTP_VAL_144_159		0x650
> +#define MT6331_OTP_VAL_160_175		0x652
> +#define MT6331_OTP_VAL_176_191		0x654
> +#define MT6331_OTP_VAL_192_207		0x656
> +#define MT6331_OTP_VAL_208_223		0x658
> +#define MT6331_OTP_VAL_224_239		0x65A
> +#define MT6331_OTP_VAL_240_255		0x65C
> +#define MT6331_RTC_MIX_CON0		0x65E
> +#define MT6331_RTC_MIX_CON1		0x660
> +#define MT6331_AUDDAC_CFG0		0x662
> +#define MT6331_AUDBUF_CFG0		0x664
> +#define MT6331_AUDBUF_CFG1		0x666
> +#define MT6331_AUDBUF_CFG2		0x668
> +#define MT6331_AUDBUF_CFG3		0x66A
> +#define MT6331_AUDBUF_CFG4		0x66C
> +#define MT6331_AUDBUF_CFG5		0x66E
> +#define MT6331_AUDBUF_CFG6		0x670
> +#define MT6331_AUDBUF_CFG7		0x672
> +#define MT6331_AUDBUF_CFG8		0x674
> +#define MT6331_IBIASDIST_CFG0		0x676
> +#define MT6331_AUDCLKGEN_CFG0		0x678
> +#define MT6331_AUDLDO_CFG0		0x67A
> +#define MT6331_AUDDCDC_CFG0		0x67C
> +#define MT6331_AUDDCDC_CFG1		0x67E
> +#define MT6331_AUDNVREGGLB_CFG0		0x680
> +#define MT6331_AUD_NCP0			0x682
> +#define MT6331_AUD_ZCD_CFG0		0x684
> +#define MT6331_AUDPREAMP_CFG0		0x686
> +#define MT6331_AUDPREAMP_CFG1		0x688
> +#define MT6331_AUDPREAMP_CFG2		0x68A
> +#define MT6331_AUDADC_CFG0		0x68C
> +#define MT6331_AUDADC_CFG1		0x68E
> +#define MT6331_AUDADC_CFG2		0x690
> +#define MT6331_AUDADC_CFG3		0x692
> +#define MT6331_AUDADC_CFG4		0x694
> +#define MT6331_AUDADC_CFG5		0x696
> +#define MT6331_AUDDIGMI_CFG0		0x698
> +#define MT6331_AUDDIGMI_CFG1		0x69A
> +#define MT6331_AUDMICBIAS_CFG0		0x69C
> +#define MT6331_AUDMICBIAS_CFG1		0x69E
> +#define MT6331_AUDENCSPARE_CFG0		0x6A0
> +#define MT6331_AUDPREAMPGAIN_CFG0	0x6A2
> +#define MT6331_AUDMADPLL_CFG0		0x6A4
> +#define MT6331_AUDMADPLL_CFG1		0x6A6
> +#define MT6331_AUDMADPLL_CFG2		0x6A8
> +#define MT6331_AUDLDO_NVREG_CFG0	0x6AA
> +#define MT6331_AUDLDO_NVREG_CFG1	0x6AC
> +#define MT6331_AUDLDO_NVREG_CFG2	0x6AE
> +#define MT6331_AUXADC_ADC0		0x700
> +#define MT6331_AUXADC_ADC1		0x702
> +#define MT6331_AUXADC_ADC2		0x704
> +#define MT6331_AUXADC_ADC3		0x706
> +#define MT6331_AUXADC_ADC4		0x708
> +#define MT6331_AUXADC_ADC5		0x70A
> +#define MT6331_AUXADC_ADC6		0x70C
> +#define MT6331_AUXADC_ADC7		0x70E
> +#define MT6331_AUXADC_ADC8		0x710
> +#define MT6331_AUXADC_ADC9		0x712
> +#define MT6331_AUXADC_ADC10		0x714
> +#define MT6331_AUXADC_ADC11		0x716
> +#define MT6331_AUXADC_ADC12		0x718
> +#define MT6331_AUXADC_ADC13		0x71A
> +#define MT6331_AUXADC_ADC14		0x71C
> +#define MT6331_AUXADC_ADC15		0x71E
> +#define MT6331_AUXADC_ADC16		0x720
> +#define MT6331_AUXADC_ADC17		0x722
> +#define MT6331_AUXADC_ADC18		0x724
> +#define MT6331_AUXADC_ADC19		0x726
> +#define MT6331_AUXADC_STA0		0x728
> +#define MT6331_AUXADC_STA1		0x72A
> +#define MT6331_AUXADC_RQST0		0x72C
> +#define MT6331_AUXADC_RQST0_SET		0x72E
> +#define MT6331_AUXADC_RQST0_CLR		0x730
> +#define MT6331_AUXADC_RQST1		0x732
> +#define MT6331_AUXADC_RQST1_SET		0x734
> +#define MT6331_AUXADC_RQST1_CLR		0x736
> +#define MT6331_AUXADC_CON0		0x738
> +#define MT6331_AUXADC_CON1		0x73A
> +#define MT6331_AUXADC_CON2		0x73C
> +#define MT6331_AUXADC_CON3		0x73E
> +#define MT6331_AUXADC_CON4		0x740
> +#define MT6331_AUXADC_CON5		0x742
> +#define MT6331_AUXADC_CON6		0x744
> +#define MT6331_AUXADC_CON7		0x746
> +#define MT6331_AUXADC_CON8		0x748
> +#define MT6331_AUXADC_CON9		0x74A
> +#define MT6331_AUXADC_CON10		0x74C
> +#define MT6331_AUXADC_CON11		0x74E
> +#define MT6331_AUXADC_CON12		0x750
> +#define MT6331_AUXADC_CON13		0x752
> +#define MT6331_AUXADC_CON14		0x754
> +#define MT6331_AUXADC_CON15		0x756
> +#define MT6331_AUXADC_CON16		0x758
> +#define MT6331_AUXADC_CON17		0x75A
> +#define MT6331_AUXADC_CON18		0x75C
> +#define MT6331_AUXADC_CON19		0x75E
> +#define MT6331_AUXADC_CON20		0x760
> +#define MT6331_AUXADC_CON21		0x762
> +#define MT6331_AUXADC_CON22		0x764
> +#define MT6331_AUXADC_CON23		0x766
> +#define MT6331_AUXADC_CON24		0x768
> +#define MT6331_AUXADC_CON25		0x76A
> +#define MT6331_AUXADC_CON26		0x76C
> +#define MT6331_AUXADC_CON27		0x76E
> +#define MT6331_AUXADC_CON28		0x770
> +#define MT6331_AUXADC_CON29		0x772
> +#define MT6331_AUXADC_CON30		0x774
> +#define MT6331_AUXADC_CON31		0x776
> +#define MT6331_AUXADC_CON32		0x778
> +#define MT6331_ACCDET_CON0		0x77A
> +#define MT6331_ACCDET_CON1		0x77C
> +#define MT6331_ACCDET_CON2		0x77E
> +#define MT6331_ACCDET_CON3		0x780
> +#define MT6331_ACCDET_CON4		0x782
> +#define MT6331_ACCDET_CON5		0x784
> +#define MT6331_ACCDET_CON6		0x786
> +#define MT6331_ACCDET_CON7		0x788
> +#define MT6331_ACCDET_CON8		0x78A
> +#define MT6331_ACCDET_CON9		0x78C
> +#define MT6331_ACCDET_CON10		0x78E
> +#define MT6331_ACCDET_CON11		0x790
> +#define MT6331_ACCDET_CON12		0x792
> +#define MT6331_ACCDET_CON13		0x794
> +#define MT6331_ACCDET_CON14		0x796
> +#define MT6331_ACCDET_CON15		0x798
> +#define MT6331_ACCDET_CON16		0x79A
> +#define MT6331_ACCDET_CON17		0x79C
> +#define MT6331_ACCDET_CON18		0x79E
> +#define MT6331_ACCDET_CON19		0x7A0
> +#define MT6331_ACCDET_CON20		0x7A2
> +#define MT6331_ACCDET_CON21		0x7A4
> +#define MT6331_ACCDET_CON22		0x7A6
> +#define MT6331_ACCDET_CON23		0x7A8
> +#define MT6331_ACCDET_CON24		0x7AA
> +
> +#endif /* __MFD_MT6331_REGISTERS_H__ */
> diff --git a/include/linux/mfd/mt6332/core.h b/include/linux/mfd/mt6332/core.h
> new file mode 100644
> index 000000000000..c9a77e1cde24
> --- /dev/null
> +++ b/include/linux/mfd/mt6332/core.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2021 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +
> +#ifndef __MFD_MT6332_CORE_H__
> +#define __MFD_MT6332_CORE_H__
> +
> +enum mt6332_irq_status_numbers {
> +	MT6332_IRQ_STATUS_PWRKEY = 0,
> +	MT6332_IRQ_STATUS_HOMEKEY,
> +	MT6332_IRQ_STATUS_CHRDET,
> +	MT6332_IRQ_STATUS_THR_H,
> +	MT6332_IRQ_STATUS_THR_L,
> +	MT6332_IRQ_STATUS_BAT_H,
> +	MT6332_IRQ_STATUS_BAT_L,
> +	MT6332_IRQ_STATUS_RTC,
> +	MT6332_IRQ_STATUS_AUDIO,
> +	MT6332_IRQ_STATUS_MAD,
> +	MT6332_IRQ_STATUS_ACCDET,
> +	MT6332_IRQ_STATUS_ACCDET_EINT,
> +	MT6332_IRQ_STATUS_ACCDET_NEGV = 12,
> +	MT6332_IRQ_STATUS_VDVFS11_OC = 16,
> +	MT6332_IRQ_STATUS_VDVFS12_OC,
> +	MT6332_IRQ_STATUS_VDVFS13_OC,
> +	MT6332_IRQ_STATUS_VDVFS14_OC,
> +	MT6332_IRQ_STATUS_GPU_OC,
> +	MT6332_IRQ_STATUS_VCORE1_OC,
> +	MT6332_IRQ_STATUS_VCORE2_OC,
> +	MT6332_IRQ_STATUS_VIO18_OC,
> +	MT6332_IRQ_STATUS_LDO_OC,
> +	MT6332_IRQ_STATUS_NR,
> +};
> +
> +#define MT6332_IRQ_CON0_BASE	MT6332_IRQ_STATUS_PWRKEY
> +#define MT6332_IRQ_CON0_BITS	(MT6332_IRQ_STATUS_ACCDET_NEGV + 1)
> +#define MT6332_IRQ_CON1_BASE	MT6332_IRQ_STATUS_VDVFS11_OC
> +#define MT6332_IRQ_CON1_BITS	(MT6332_IRQ_STATUS_LDO_OC - MT6332_IRQ_STATUS_VDFS11_OC + 1)
> +
> +#define MT6332_INT_GEN(sp)				\
> +{							\
> +	.hwirq_base = MT6332_IRQ_##sp##_BASE,		\
> +	.num_int_regs =					\
> +		((MT6332_IRQ_##sp##_BITS - 1) /		\
> +		MTK_PMIC_REG_WIDTH) + 1,		\
> +	.en_reg = MT6332_INT_##sp##,			\
> +	.en_reg_shift = 0x6,				\
> +	.sta_reg = MT6332_INT_STATUS0_##sp##,		\
> +	.sta_reg_shift = 0x2,				\
> +	.top_offset = MT6332_##sp##_TOP,		\
> +}


Same here.

Regards,
Matthias
