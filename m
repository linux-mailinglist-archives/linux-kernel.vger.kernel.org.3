Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B6D483592
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbiACR2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiACR2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:28:40 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C00C061761;
        Mon,  3 Jan 2022 09:28:39 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id b77so19220444vka.11;
        Mon, 03 Jan 2022 09:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qNcWKQrLWBuk1ywuSBdmMpZzWFQaVsYbPlfcMZU1hxM=;
        b=kGrMKL8qFENKuqOZ8n99FxdgoanFjBmtIuB7d0TsiMfVF2Fd97aVV1x37ZAuR3h3dB
         IaYormZDYLVAviYCMX9h0cqeSfSLjaBS3FFT3bvbOrXU8NpJu+sQDYibg5IU5Yb5I63F
         m5F0BST///BHz6CvIFx9SoHyAdH9hv2TDMbuC6lIQOgkrqhT+FWjdSZQpHiY/N5hxGQc
         B8Y23k7VGOEps6drQxepoP4C+aG5adzJcS2XBo3qbi4zHYu32SzrGaK6ximJOol6KZ/P
         zYdxoUvTH41HEtYPzTIETPLKrT6dicTOfkE0GP3cMeqehrx9d37FZZdNiEUmcgSc0NSZ
         uStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qNcWKQrLWBuk1ywuSBdmMpZzWFQaVsYbPlfcMZU1hxM=;
        b=D4w8SdOtAC6IRR5UblasEBbHz7DRGIlhqHynj+UvMAx/kinK6T4sx4dHZwIZjxPzao
         xOQFQMiWnQSsF84zDdctvKs0QwcP8iekyQZJWmyEIDT9dsJVcmabjZaBFSmw4NAWNde/
         /WxfvIrdB/QrCzC+WSS37znH9mjIup05pmPYC46R5pg5yiaNzdDVTMFzNUrgE4CI5/8v
         Zn/KhqzR+E4JuWMK5UvpTZYuCsDEv1hjc3VGu7cdRd3w//baS+EcpBzAw3uNtk4X4iZQ
         NYER/Y1EVjv8l2LqI9ZUNyAAU4bhe3D1X1IB0tDLTOI+j5ZASLrXvrmH3xv78A9lcoxO
         7UCw==
X-Gm-Message-State: AOAM531MC5fyfXNajo2w9MaQOsyZrc/EDiIjqWFIwk94IhXJmWF8Fn36
        PaO7PL30igw0watsHOVlPW4=
X-Google-Smtp-Source: ABdhPJxcWHzy3oFxvqJxLjHexLOkAE5JFgtX0xE84zjJOeeN7L8F926irB6RNGZ2qLcZV/KsxwkKmg==
X-Received: by 2002:a05:6122:1799:: with SMTP id o25mr15425264vkf.3.1641230918902;
        Mon, 03 Jan 2022 09:28:38 -0800 (PST)
Received: from [10.230.2.158] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id x2sm8465299vsj.32.2022.01.03.09.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 09:28:38 -0800 (PST)
Message-ID: <0fb3ff91-a9d6-ef9f-6f3d-7f896da4d44a@gmail.com>
Date:   Mon, 3 Jan 2022 09:28:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 9/9] mtd: rawnand: brcmnand: Add BCMA shim
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM SPECIFIC AMBA DRIVER (BCMA)" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM STB NAND FLASH DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>
References: <20211223002225.3738385-1-f.fainelli@gmail.com>
 <20211223002225.3738385-10-f.fainelli@gmail.com>
 <20220103180639.681aca15@xps13>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220103180639.681aca15@xps13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/3/2022 9:06 AM, Miquel Raynal wrote:
> Hi Florian,
> 
> f.fainelli@gmail.com wrote on Wed, 22 Dec 2021 16:22:25 -0800:
> 
>> Add a BCMA shim to allow us to register the brcmnand driver using the
>> BCMA bus which provides indirect memory mapped access to SoC registers.
>>
>> There are a number of registers that need to be byte swapped because
>> they are natively big endian, coming directly from the NAND chip, and
>> there is no bus interface unlike the iProc or STB platforms that
>> performs the byte swapping for us.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>   drivers/mtd/nand/raw/Kconfig              |  11 ++
>>   drivers/mtd/nand/raw/brcmnand/Makefile    |   2 +
>>   drivers/mtd/nand/raw/brcmnand/bcma_nand.c | 131 ++++++++++++++++++++++
>>   3 files changed, 144 insertions(+)
>>   create mode 100644 drivers/mtd/nand/raw/brcmnand/bcma_nand.c
>>
>> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
>> index 0a45d3c6c15b..f643e02e5559 100644
>> --- a/drivers/mtd/nand/raw/Kconfig
>> +++ b/drivers/mtd/nand/raw/Kconfig
>> @@ -208,6 +208,17 @@ config MTD_NAND_BRCMNAND
>>   	  originally designed for Set-Top Box but is used on various BCM7xxx,
>>   	  BCM3xxx, BCM63xxx, iProc/Cygnus and more.
>>   
>> +if MTD_NAND_BRCMNAND
>> +
>> +config MTD_NAND_BRCMNAND_BCMA
>> +	tristate "Broadcom BCMA NAND controller"
>> +	depends on BCMA_NFLASH
>> +	depends on BCMA
>> +	help
>> +	  Enables the BRCMNAND controller over BCMA on BCM47186/BCM5358 SoCs.
>> +
>> +endif # MTD_NAND_BRCMNAND
>> +
>>   config MTD_NAND_BCM47XXNFLASH
>>   	tristate "BCM4706 BCMA NAND controller"
>>   	depends on BCMA_NFLASH
>> diff --git a/drivers/mtd/nand/raw/brcmnand/Makefile b/drivers/mtd/nand/raw/brcmnand/Makefile
>> index 195b845e48b8..16dc7254200e 100644
>> --- a/drivers/mtd/nand/raw/brcmnand/Makefile
>> +++ b/drivers/mtd/nand/raw/brcmnand/Makefile
>> @@ -6,3 +6,5 @@ obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= bcm63138_nand.o
>>   obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= bcm6368_nand.o
>>   obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmstb_nand.o
>>   obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand.o
>> +
>> +obj-$(CONFIG_MTD_NAND_BRCMNAND_BCMA)	+= bcma_nand.o
>> diff --git a/drivers/mtd/nand/raw/brcmnand/bcma_nand.c b/drivers/mtd/nand/raw/brcmnand/bcma_nand.c
>> new file mode 100644
>> index 000000000000..e3be9ecf0761
>> --- /dev/null
>> +++ b/drivers/mtd/nand/raw/brcmnand/bcma_nand.c
>> @@ -0,0 +1,131 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright © 2021 Broadcom
>> + */
>> +#include <linux/bcma/bcma.h>
>> +#include <linux/bcma/bcma_driver_chipcommon.h>
>> +#include <linux/device.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "brcmnand.h"
>> +
>> +struct brcmnand_bcma_soc {
>> +	struct brcmnand_soc soc;
>> +	struct bcma_drv_cc *cc;
>> +};
>> +
>> +static inline bool brcmnand_bcma_needs_swapping(u32 offset)
>> +{
>> +	switch (offset) {
>> +	case BCMA_CC_NAND_SPARE_RD0:
>> +	case BCMA_CC_NAND_SPARE_RD4:
>> +	case BCMA_CC_NAND_SPARE_RD8:
>> +	case BCMA_CC_NAND_SPARE_RD12:
>> +	case BCMA_CC_NAND_SPARE_WR0:
>> +	case BCMA_CC_NAND_SPARE_WR4:
>> +	case BCMA_CC_NAND_SPARE_WR8:
>> +	case BCMA_CC_NAND_SPARE_WR12:
>> +	case BCMA_CC_NAND_DEVID:
>> +	case BCMA_CC_NAND_DEVID_X:
>> +	case BCMA_CC_NAND_SPARE_RD16:
>> +	case BCMA_CC_NAND_SPARE_RD20:
>> +	case BCMA_CC_NAND_SPARE_RD24:
>> +	case BCMA_CC_NAND_SPARE_RD28:
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static u32 brcmnand_bcma_read_reg(struct brcmnand_soc *soc, u32 offset)
>> +{
>> +	struct brcmnand_bcma_soc *sc;
>> +	u32 val;
>> +
>> +	sc = container_of(soc, struct brcmnand_bcma_soc, soc);
>> +
>> +	/* Offset into the NAND block and deal with the flash cache separately */
>> +	if (offset == ~0)
>> +		offset = BCMA_CC_NAND_CACHE_DATA;
>> +	else
>> +		offset += BCMA_CC_NAND_REVISION;
>> +
>> +	val = bcma_cc_read32(sc->cc, offset);
>> +
>> +	/* Swap if necessary */
>> +	if (brcmnand_bcma_needs_swapping(offset))
>> +		val = be32_to_cpu(val);
>> +	return val;
>> +}
>> +
>> +static void brcmnand_bcma_write_reg(struct brcmnand_soc *soc, u32 val,
>> +				    u32 offset)
>> +{
>> +	struct brcmnand_bcma_soc *sc;
>> +
>> +	sc = container_of(soc, struct brcmnand_bcma_soc, soc);
>> +
>> +	/* Offset into the NAND block */
>> +	if (offset == ~0)
>> +		offset = BCMA_CC_NAND_CACHE_DATA;
>> +	else
>> +		offset += BCMA_CC_NAND_REVISION;
>> +
>> +	/* Swap if necessary */
>> +	if (brcmnand_bcma_needs_swapping(offset))
>> +		val = cpu_to_be32(val);
>> +
>> +	bcma_cc_write32(sc->cc, offset, val);
>> +}
>> +
>> +static struct brcmnand_io_ops brcmnand_bcma_io_ops = {
>> +	.read_reg	= brcmnand_bcma_read_reg,
>> +	.write_reg	= brcmnand_bcma_write_reg,
>> +};
>> +
>> +static void brcmnand_bcma_prepare_data_bus(struct brcmnand_soc *soc, bool prepare,
>> +					   bool is_param)
>> +{
>> +	struct brcmnand_bcma_soc *sc;
>> +
>> +	sc = container_of(soc, struct brcmnand_bcma_soc, soc);
> 
> A helper for that would be nice?

Sure, I can add a helper since we use the same construct about 3 times, 
thanks!
-- 
Florian
