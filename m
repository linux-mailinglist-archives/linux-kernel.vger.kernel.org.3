Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296324E1B5A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 12:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244872AbiCTLzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 07:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiCTLzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 07:55:37 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6567BA5EA4;
        Sun, 20 Mar 2022 04:54:13 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id yy13so24998089ejb.2;
        Sun, 20 Mar 2022 04:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/UFxCB7mWHoPubmiv83UEs9JBstUXqJkXebs9WtHMjA=;
        b=crw98axOQGmnm5gfYHyFy5tCEW54d7yR0yaMtq/Rbfj0AiwZ3+kSY8OIcNIJAhDF9z
         B/tB6iKYSWORWDEGwXVeRZcUdQ72JnDRVmQYicwGBU73FDSJKXj3tl2LpgNQLFZjbVqF
         MLlzuZH492D5StkvoBhFVTaKcM/wBGbUJ3eFVgfcAIrpKX+lSA7ozNPZypRebowEDDAq
         oYs4Ns7U2jqRjTy7EskBBjb0x76D2i/YgffJtBV8VsTLjFc3OZS2CMf3KKoEUQjxtp6r
         xm9vGvUqJqGq8yjjQbT8XHr+4LUIFjlOiUN9MumVzIwUMgGGz/G2xn8JPqtU7V+ctqA7
         Wheg==
X-Gm-Message-State: AOAM532y3oZA/hZIUDY0WyGsCb2Z0VqYpYFfHn71AJs/PjpK5eeRfvvu
        2W1t5eC0D5VG4jHMUmCvdcpTbt9nAGI=
X-Google-Smtp-Source: ABdhPJwRAvMyZYSEhttGpsClF6c4pIpv9qP/jijqpRV9lUSB4zAG+YhTuneWv4QxU+oXrYzK3doCJA==
X-Received: by 2002:a17:906:99c5:b0:6df:8215:4ccd with SMTP id s5-20020a17090699c500b006df82154ccdmr16665631ejn.684.1647777251712;
        Sun, 20 Mar 2022 04:54:11 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id hs12-20020a1709073e8c00b006dfdfdac005sm1562882ejc.174.2022.03.20.04.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 04:54:11 -0700 (PDT)
Message-ID: <e5426768-1dd0-0bef-25e8-2ab494f7723d@kernel.org>
Date:   Sun, 20 Mar 2022 12:54:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/2] mmc: Add mmc driver for Sunplus SP7021
Content-Language: en-US
To:     Tony Huang <tonyhuang.sunplus@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, lhjeff911@gmail.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com
References: <cover.1647652688.git.tonyhuang.sunplus@gmail.com>
 <f954fb1c0d1c4950b71a8fc360c78edcca9954de.1647652688.git.tonyhuang.sunplus@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <f954fb1c0d1c4950b71a8fc360c78edcca9954de.1647652688.git.tonyhuang.sunplus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2022 02:50, Tony Huang wrote:
> Add mmc driver for Sunplus SP7021
> 
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> ---
> Changes in v4:
>  - combine sdcard and eMMC into one driver.
> 
>  MAINTAINERS                    |    1 +
>  drivers/mmc/host/Kconfig       |    9 +
>  drivers/mmc/host/Makefile      |    1 +
>  drivers/mmc/host/sunplus_mmc.c | 2195 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 2206 insertions(+)
>  create mode 100644 drivers/mmc/host/sunplus_mmc.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2d91431..451adba 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18247,6 +18247,7 @@ M:	Tony Huang <tonyhuang.sunplus@gmail.com>
>  M:  Li-hao Kuo <lhjeff911@gmail.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/mmc/sunplu,mmc.yaml
> +F:	drivers/mmc/host/sunplus_mmc.c
>  
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 5af8494..285daa1 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -14,6 +14,15 @@ config MMC_DEBUG
>  	  added host drivers please don't invent their private macro for
>  	  debugging.
>  
> +config MMC_SUNPLUS
> +	tristate "Sunplus SP7021 MMC Controller"
> +	depends on ARCH_SUNPLUS

|| COMPILE_TEST
and please test it

> +	help
> +	  If you say yes here, you will get support for eMMC host interface
> +	  on Sunplus SoCs.
> +
> +	  If unsure, say N
> +
>  config MMC_ARMMMCI
>  	tristate "ARM AMBA Multimedia Card Interface support"
>  	depends on ARM_AMBA
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index ea36d37..e6958e7 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -97,6 +97,7 @@ obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)	+= sdhci-pic32.o
>  obj-$(CONFIG_MMC_SDHCI_BRCMSTB)		+= sdhci-brcmstb.o
>  obj-$(CONFIG_MMC_SDHCI_OMAP)		+= sdhci-omap.o
>  obj-$(CONFIG_MMC_SDHCI_SPRD)		+= sdhci-sprd.o
> +obj-$(CONFIG_MMC_SUNPLUS)		+= sunplus_mmc.o

Almost all files use '-', not underscore. Do not bring inconsistencies.

>  obj-$(CONFIG_MMC_CQHCI)			+= cqhci.o
>  cqhci-y					+= cqhci-core.o
>  cqhci-$(CONFIG_MMC_CRYPTO)		+= cqhci-crypto.o
> diff --git a/drivers/mmc/host/sunplus_mmc.c b/drivers/mmc/host/sunplus_mmc.c
> new file mode 100644
> index 0000000..a3cb408
> --- /dev/null
> +++ b/drivers/mmc/host/sunplus_mmc.c
> @@ -0,0 +1,2195 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Sunplus Inc.
> + * Author: Tony Huang <tonyhuang.sunplus@gmail.com>
> + * Author: Li-hao Kuo <lhjeff911@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/mmc/core.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/sdio.h>
> +#include <linux/mmc/slot-gpio.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +
> +#define SPMMC_MIN_CLK			400000
> +#define SPMMC_MAX_CLK			52000000
> +#define SPMMC_MAX_BLK_COUNT		65536
> +#define SPMMC_MAX_TUNABLE_DLY	7
> +
> +#define SPMMC_CARD_MEDIATYPE_SRCDST_REG 0x0000
> +#define SPMMC_MEDIA_TYPE		GENMASK(2, 0)
> +#define SPMMC_DMA_SOURCE		GENMASK(6, 4)
> +#define SPMMC_DMA_DESTINATION		GENMASK(10, 8)
> +#define SPMMC_MEDIA_NONE	0
> +#define SPMMC_MEDIA_SD		6
> +#define SPMMC_MEDIA_MS		7
> +
> +#define SPMMC_SDRAM_SECTOR_0_SIZE_REG	0x0008
> +#define SPMMC_DMA_BASE_ADDR_REG		0x000C
> +#define SPMMC_HW_DMA_CTRL_REG		0x0010
> +#define SPMMC_HW_DMA_RST	BIT(9)
> +#define SPMMC_DMAIDLE		BIT(10)
> +
> +#define SPMMC_MAX_DMA_MEMORY_SECTORS	8
> +
> +#define SPMMC_SDRAM_SECTOR_1_ADDR_REG 0x0018
> +
> +#define SPMMC_SD_INT_REG	0x0088
> +#define SPMMC_SDINT_SDCMPEN	BIT(0)
> +#define SPMMC_SDINT_SDCMP	BIT(1)
> +#define SPMMC_SDINT_SDCMPCLR	BIT(2)
> +#define SPMMC_SDINT_SDIOEN	BIT(3)
> +#define SPMMC_SDINT_SDIO	BIT(4)
> +#define SPMMC_SDINT_SDIOCLR	BIT(5)
> +
> +#define SPMMC_SD_PAGE_NUM_REG	0x008C
> +
> +#define SPMMC_SD_CONFIG0_REG	0x0090
> +#define SPMMC_SD_PIO_MODE	BIT(0)
> +#define SPMMC_SD_DDR_MODE	BIT(1)
> +#define SPMMC_SD_LEN_MODE	BIT(2)
> +#define SPMMC_SD_TRANS_MODE	GENMASK(5, 4)
> +#define SPMMC_SD_AUTO_RESPONSE	BIT(6)
> +#define SPMMC_SD_CMD_DUMMY	BIT(7)
> +#define SPMMC_SD_RSP_CHK_EN	BIT(8)
> +#define SPMMC_SDIO_MODE		BIT(9)
> +#define SPMMC_SD_MMC_MODE	BIT(10)
> +#define SPMMC_SD_DATA_WD	BIT(11)
> +#define SPMMC_RX4_EN		BIT(14)
> +#define SPMMC_SD_RSP_TYPE	BIT(15)
> +#define SPMMC_MMC8_EN		BIT(18)
> +#define SPMMC_CLOCK_DIVISION	GENMASK(31, 20)
> +
> +#define SPMMC_MODE_SD			0
> +#define SPMMC_MODE_EMMC			1
> +#define SPMMC_MODE_SDIO			2
> +
> +#define SPMMC_SDIO_CTRL_REG		0x0094
> +#define SPMMC_INT_MULTI_TRIG		BIT(6)
> +
> +#define SPMMC_SD_RST_REG		0x0098
> +#define SPMMC_SD_CTRL_REG		0x009C
> +#define SPMMC_NEW_COMMAND_TRIGGER	BIT(0)
> +#define SPMMC_DUMMY_CLOCK_TRIGGER	BIT(1)
> +
> +#define SPMMC_SD_STATUS_REG						0x00A0
> +#define SPMMC_SDSTATUS_DUMMY_READY				BIT(0)
> +#define SPMMC_SDSTATUS_RSP_BUF_FULL				BIT(1)
> +#define SPMMC_SDSTATUS_TX_DATA_BUF_EMPTY		BIT(2)
> +#define SPMMC_SDSTATUS_RX_DATA_BUF_FULL			BIT(3)
> +#define SPMMC_SDSTATUS_CMD_PIN_STATUS			BIT(4)
> +#define SPMMC_SDSTATUS_DAT0_PIN_STATUS			BIT(5)
> +#define SPMMC_SDSTATUS_RSP_TIMEOUT				BIT(6)
> +#define SPMMC_SDSTATUS_CARD_CRC_CHECK_TIMEOUT	BIT(7)
> +#define SPMMC_SDSTATUS_STB_TIMEOUT				BIT(8)
> +#define SPMMC_SDSTATUS_RSP_CRC7_ERROR			BIT(9)
> +#define SPMMC_SDSTATUS_CRC_TOKEN_CHECK_ERROR	BIT(10)
> +#define SPMMC_SDSTATUS_RDATA_CRC16_ERROR		BIT(11)
> +#define SPMMC_SDSTATUS_SUSPEND_STATE_READY		BIT(12)
> +#define SPMMC_SDSTATUS_BUSY_CYCLE				BIT(13)
> +#define SPMMC_SDSTATUS_DAT1_PIN_STATUS			BIT(14)
> +#define SPMMC_SDSTATUS_SD_SENSE_STATUS			BIT(15)
> +#define SPMMC_SDSTATUS_BOOT_ACK_TIMEOUT			BIT(16)
> +#define SPMMC_SDSTATUS_BOOT_DATA_TIMEOUT		BIT(17)
> +#define SPMMC_SDSTATUS_BOOT_ACK_ERROR			BIT(18)
> +
> +#define SPMMC_SD_STATE_REG		0x00A4
> +#define SPMMC_CRCTOKEN_CHECK_RESULT	GENMASK(6, 4)
> +#define SPMMC_SDSTATE_ERROR		BIT(13)
> +#define SPMMC_SDSTATE_FINISH	BIT(14)
> +
> +#define SPMMC_SD_HW_STATE_REG		0x00A8
> +#define SPMMC_SD_BLOCKSIZE_REG		0x00AC
> +
> +#define SPMMC_SD_CONFIG1_REG		0x00B0
> +#define SPMMC_TX_DUMMY_NUM		GENMASK(8, 0)
> +#define SPMMC_SD_HIGH_SPEED_EN		BIT(31)
> +
> +#define SPMMC_SD_TIMING_CONFIG0_REG 0x00B4
> +#define SPMMC_SD_CLOCK_DELAY	GENMASK(2, 0)
> +#define SPMMC_SD_WRITE_DATA_DELAY	GENMASK(6, 4)
> +#define SPMMC_SD_WRITE_COMMAND_DELAY	GENMASK(10, 8)
> +#define SPMMC_SD_READ_RESPONSE_DELAY	GENMASK(14, 12)
> +#define SPMMC_SD_READ_DATA_DELAY	GENMASK(18, 16)
> +#define SPMMC_SD_READ_CRC_DELAY	GENMASK(22, 20)
> +
> +#define SPMMC_SD_PIODATATX_REG		0x00BC
> +#define SPMMC_SD_PIODATARX_REG		0x00C0
> +#define SPMMC_SD_CMDBUF0_3_REG		0x00C4
> +#define SPMMC_SD_CMDBUF4_REG		0x00C8
> +#define SPMMC_SD_RSPBUF0_3_REG		0x00CC
> +#define SPMMC_SD_RSPBUF4_5_REG		0x00D0
> +
> +struct spmmc_tuning_info {
> +	int enable_tuning;
> +	int need_tuning;
> +#define SPMMC_MAX_RETRIES (8 * 8)
> +	int retried; /* how many times has been retried */
> +	u32 rd_crc_dly:3;
> +	u32 rd_dat_dly:3;
> +	u32 rd_rsp_dly:3;
> +	u32 wr_cmd_dly:3;
> +	u32 wr_dat_dly:3;
> +	u32 clk_dly:3;
> +};
> +
> +struct spmmc_compatible {
> +	u8 mode;
> +	u32 min_clk;
> +	u32 max_clk;
> +	u32 max_blk_count;
> +	u32 max_dma_memory_sectors;
> +	u32 blk_size;
> +};
> +
> +static const u8 tuning_blk_pattern_4bit[] = {
> +	0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
> +	0xc3, 0x3c, 0xcc, 0xff, 0xfe, 0xff, 0xfe, 0xef,
> +	0xff, 0xdf, 0xff, 0xdd, 0xff, 0xfb, 0xff, 0xfb,
> +	0xbf, 0xff, 0x7f, 0xff, 0x77, 0xf7, 0xbd, 0xef,
> +	0xff, 0xf0, 0xff, 0xf0, 0x0f, 0xfc, 0xcc, 0x3c,
> +	0xcc, 0x33, 0xcc, 0xcf, 0xff, 0xef, 0xff, 0xee,
> +	0xff, 0xfd, 0xff, 0xfd, 0xdf, 0xff, 0xbf, 0xff,
> +	0xbb, 0xff, 0xf7, 0xff, 0xf7, 0x7f, 0x7b, 0xde,
> +};
> +
> +static const u8 tuning_blk_pattern_8bit[] = {
> +	0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0x00, 0x00,
> +	0xff, 0xff, 0xcc, 0xcc, 0xcc, 0x33, 0xcc, 0xcc,
> +	0xcc, 0x33, 0x33, 0xcc, 0xcc, 0xcc, 0xff, 0xff,
> +	0xff, 0xee, 0xff, 0xff, 0xff, 0xee, 0xee, 0xff,
> +	0xff, 0xff, 0xdd, 0xff, 0xff, 0xff, 0xdd, 0xdd,
> +	0xff, 0xff, 0xff, 0xbb, 0xff, 0xff, 0xff, 0xbb,
> +	0xbb, 0xff, 0xff, 0xff, 0x77, 0xff, 0xff, 0xff,
> +	0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee, 0xff,
> +	0xff, 0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0x00,
> +	0x00, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0x33, 0xcc,
> +	0xcc, 0xcc, 0x33, 0x33, 0xcc, 0xcc, 0xcc, 0xff,
> +	0xff, 0xff, 0xee, 0xff, 0xff, 0xff, 0xee, 0xee,
> +	0xff, 0xff, 0xff, 0xdd, 0xff, 0xff, 0xff, 0xdd,
> +	0xdd, 0xff, 0xff, 0xff, 0xbb, 0xff, 0xff, 0xff,
> +	0xbb, 0xbb, 0xff, 0xff, 0xff, 0x77, 0xff, 0xff,
> +	0xff, 0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee,
> +};
> +
> +/* Produces a mask of set bits covering a range of a 32-bit value */
> +static inline u32 bitfield_mask(u32 shift, u32 width)
> +{
> +	return ((1 << width) - 1) << shift;

Aren't you re-inventing GENMASK?

> +}
> +
> +#define SPSDC_MIN_CLK			400000
> +#define SPSDC_MAX_CLK			52000000
> +#define SPSDC_50M_CLK			50000000
> +#define SPSDC_MAX_BLK_COUNT		65536
> +
> +#define SPSD2_MEDIA_TYPE_REG		0x0000
> +#define SPSDC_MEDIA_MASK		GENMASK(2, 0)
> +#define SPSDC_MEDIA_NONE		0
> +#define SPSDC_MEDIA_SD			6
> +#define SPSDC_MEDIA_MS			7
> +
> +#define SPSD2_SDRAM_SECTOR_SIZE_REG	0x0010
> +#define SPSDC_MAX_DMA_MEMORY_SECTORS	8
> +
> +#define SPSD2_SDRAM_SECTOR_ADDR_REG	0x001C
> +#define SPSD2_SD_INT_REG		0x00B0
> +#define SPSDC_SDINT_SDCMPEN		BIT(0)
> +#define SPSDC_SDINT_SDCMP		BIT(1)
> +#define SPSDC_SDINT_SDCMP_CLR		BIT(2)
> +#define SPSDC_SDINT_SDIOEN		BIT(4)
> +#define SPSDC_SDINT_SDIO		BIT(5)
> +#define SPSDC_SDINT_SDIO_CLR		BIT(6)
> +
> +#define SPSD2_SD_PAGE_NUM_REG		0x00B4
> +#define SPSD2_SD_CONF0_REG		0x00B8
> +#define SPSDC_CONF0_SDPIO_MODE		BIT(0)
> +#define SPSDC_CONF0_SDLEN_MODE		BIT(2)
> +#define SPSDC_CONF0_TRANS_MODE		GENMASK(5, 4)
> +#define SPSDC_TRANS_CMD_MODE		0
> +#define SPSDC_TRANS_WR_MODE		1
> +#define SPSDC_TRANS_RD_MODE		2
> +#define SPSDC_CONF0_AUTORSP		BIT(6)
> +#define SPSDC_CONF0_CMDDUMMY		BIT(7)
> +#define SPSDC_CONF0_RSPCHK		BIT(8)
> +
> +#define SPSD2_SDIO_CTRL_REG		0x00BC
> +#define SPSDC_SDIO_CTRL_MULTI_TRIG	BIT(6)
> +
> +#define SPSD2_SD_RST_REG		0x00C0
> +#define SPSDC_RST_ALL			0x07
> +
> +#define SPSD2_SD_CONF_REG		0x00C4
> +#define SPSDC_CONF_CLK_DIV		GENMASK(11, 0)
> +#define SPSDC_CONF_4BIT_MODE		BIT(12)
> +#define SPSDC_CONF_SDRSP_TYPE		BIT(13)
> +#define SPSDC_CONF_SD_MODE		BIT(16)
> +#define SPSDC_CONF_MMC8BIT		BIT(18)
> +#define SPSDC_CONF_SDIO_MODE		BIT(20)
> +
> +#define SPSD2_SD_CTRL_REG		0x00C8
> +#define SPSDC_CTRL_CMD_TRIG		BIT(0)
> +#define SPSDC_CTRL_TXDUMMY_TRIG		BIT(1)
> +
> +#define SPSD2_SD_STATUS_REG		0x00CC
> +#define SPSDC_STS_DUMMY_RDY		BIT(0)
> +#define SPSDC_STS_RSP_BUF_FULL		BIT(1)
> +#define SPSDC_STS_TX_BUF_EMP		BIT(2)
> +#define SPSDC_STS_RX_BUF_FULL		BIT(3)
> +#define SPSDC_STS_CMD_PIN_STS		BIT(4)
> +#define SPSDC_STS_DAT0_PIN_STS		BIT(5)
> +#define SPSDC_STS_RSP_TIMEOUT		BIT(6)
> +#define SPSDC_STS_CARD_CRC_TIMEOUT	BIT(7)
> +#define SPSDC_STS_STB_TIMEOUT		BIT(8)
> +#define SPSDC_STS_RSP_CRC7_ERR		BIT(9)
> +#define SPSDC_STS_CRC_TOKEN_ERR		BIT(10)
> +#define SPSDC_STS_RDATA_CRC16_ERR	BIT(11)
> +#define SPSDC_STS_SUSPEND_STATE_RDY	BIT(12)
> +#define SPSDC_STS_BUSY_CYCLE		BIT(13)
> +
> +#define SPSD2_SD_STATE_REG		0x00D0
> +#define SPSDC_STATE_IDLE		(0x0)
> +#define SPSDC_STATE_TXDUMMY		(0x1)
> +#define SPSDC_STATE_TXCMD		(0x2)
> +#define SPSDC_STATE_RXRSP		(0x3)
> +#define SPSDC_STATE_TXDATA		(0x4)
> +#define SPSDC_STATE_RXCRC		(0x5)
> +#define SPSDC_STATE_RXDATA		(0x6)
> +#define SPSDC_STATE_MASK		(0x7)
> +#define SPSDC_STATE_ERROR		BIT(13)
> +#define SPSDC_STATE_FINISH		BIT(14)
> +
> +#define SPSD2_BLOCKSIZE_REG		0x00D4
> +#define SPSD2_SD_TIMING_CONF0_REG	0x00DC
> +#define SPSDC_TIMING_CONF0_HS_EN	BIT(11)
> +#define SPSDC_TIMING_CONF0_WRTD		GENMASK(14, 12)
> +
> +#define SPSD2_SD_TIMING_CONF1_REG	0x00E0
> +#define SPSDC_TIMING_CONF1_RDTD		GENMASK(15, 13)
> +
> +#define SPSD2_SD_PIO_TX_REG		0x00E4
> +#define SPSD2_SD_PIO_RX_REG		0x00E8
> +#define SPSD2_SD_CMD_BUF0_REG		0x00EC
> +#define SPSD2_SD_CMD_BUF1_REG		0x00F0
> +#define SPSD2_SD_CMD_BUF2_REG		0x00F4
> +#define SPSD2_SD_CMD_BUF3_REG		0x00F8
> +#define SPSD2_SD_CMD_BUF4_REG		0x00FC
> +#define SPSD2_SD_RSP_BUF0_3_REG		0x0100
> +#define SPSD2_SD_RSP_BUF4_5_REG		0x0104
> +#define SPSD2_DMA_SRCDST_REG		0x0204
> +#define SPSD2_DMA_SIZE_REG		0x0208
> +#define SPSD2_DMA_STOP_RST_REG		0x020c
> +#define SPSD2_DMA_CTRL_REG		0x0210
> +#define SPSD2_DMA_BASE_ADDR0_REG	0x0214
> +#define SPSD2_DMA_BASE_ADDR16_REG	0x0218
> +
> +struct spsdc_tuning_info {
> +	int need_tuning;
> +#define SPSDC_MAX_RETRIES (8 * 8)
> +	int retried; /* how many times has been retried */
> +	u32 wr_dly:3;
> +	u32 rd_dly:3;
> +	u32 clk_dly:3;
> +};

Please put all type declarations together, after defines. Don't mix
defines/declarations/defines/declarations.

> +
> +enum {
> +	SPSDC_DMA_MODE = 0,
> +	SPSDC_PIO_MODE = 1,
> +};
> +
> +enum SPSDC_MODE {
> +	SPSDC_MODE_SD = 0,
> +	SPSDC_MODE_SDIO = 1,
> +};
> +
> +struct spmmc_host {
> +	void __iomem *base;
> +	struct clk *clk;
> +	struct reset_control *rstc;
> +	int mode; /* SD/SDIO/eMMC */

Didn't you define enum for this?


> +	spinlock_t lock; /* controller lock */
> +	struct mutex mrq_lock;

Please describe explicitly what is protected with which lock.
"controller lock" seems not specific enough.

> +	/* tasklet used to handle error then finish the request */
> +	struct tasklet_struct tsklet_finish_req;
> +	struct mmc_host *mmc;
> +	struct mmc_request *mrq; /* current mrq */
> +
> +	int irq;
> +	int use_int; /* should raise irq when done? */
> +	int power_state; /* current power state: off/up/on */
> +	int ddr_enabled;
> +	int signal_voltage;
> +#define SPMMC_DMA_MODE 0
> +#define SPMMC_PIO_MODE 1

You just have enum for it.

> +	int dmapio_mode;

One more enum...

> +	/* for purpose of reducing context switch, only when transfer data that*/
> +	/* length is greater than `dma_int_threshold' should use interrupt */

Use Linux coding style comments.

> +	int dma_int_threshold;
> +	struct sg_mapping_iter sg_miter; /* for pio mode to access sglist */
> +	int dma_use_int; /* should raise irq when dma done */
> +	struct spmmc_tuning_info emmc_tuning_info;
> +	struct spsdc_tuning_info sd_tuning_info;
> +	int restore_4bit_sdio_bus;
> +	const struct spmmc_compatible *dev_comp;
> +};
> +
> +struct spsdc_host {

Where is this used?

> +	void __iomem *base;
> +	struct clk *clk;
> +	struct reset_control *rstc;
> +	spinlock_t lock; /* controller lock */

Also a controller lock? Two same locks? No, really.

Sorry, this code is poor quality. Please go through it and clean it up
before sending. Duplicated structures should be caught up with some
internal review. Do not send code which is not ready.

(...)

> +
> +static struct platform_driver spmmc_driver = {
> +	.probe = spmmc_drv_probe,
> +	.remove = spmmc_drv_remove,
> +	.suspend = spmmc_drv_suspend,
> +	.resume = spmmc_drv_resume,
> +	.driver = {
> +		.name = "spmmc",
> +		.owner = THIS_MODULE,

No, no, no. Core sets it. Did you see it in any other driver? Why doing
it different than any other driver?

> +#ifdef CONFIG_PM
> +		.pm = &spmmc_pm_ops,
> +#endif
> +		.of_match_table = spmmc_of_table,
> +	},
> +};
> +module_platform_driver(spmmc_driver);
> +
> +MODULE_AUTHOR("Tony Huang <tonyhuang.sunplus@gmail.com>");
> +MODULE_AUTHOR("Li-hao Kuo <lhjeff911@gmail.com>");
> +MODULE_DESCRIPTION("Sunplus MMC controller driver");
> +MODULE_LICENSE("GPL");


Best regards,
Krzysztof
