Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D86468332
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 08:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354763AbhLDHdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 02:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbhLDHdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 02:33:02 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D469C061751;
        Fri,  3 Dec 2021 23:29:37 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso4357257pjb.2;
        Fri, 03 Dec 2021 23:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ns52/GUBo3SS73Cf25FqywqleT/XDwN+7zt0OmhJ234=;
        b=JxwoH+tAX9Oy5yHHCYJGy/P98XrUZ0aTNVfxfM0w5gxqFZOCsPmmep2FTOlBKzg1UU
         Ggst204MI1wbHHzoJ+Hl6/DkqDBJ32TLv9V4u1NqRziwgp1fZPB5SlC5GFT21LC6EEHR
         0E5lfsvyPSUoCvjkXVxipq9ZYH0uEFKGzFy4+lAmjG2Cr2I8PyGUPizuLSVQDLakHv9X
         2R48ubhW8N74cnbOWKuXf30ooPKPfC12XF12HR5bAnPoZrXLPr2TSTSVQzjNBPRJhqS2
         I0UHUOVU2IvdOFfarzE0zNFLmXQom81cke0wrrykuGJRK57Q3O3LmQ81I7j/vZv4iXSy
         3v6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ns52/GUBo3SS73Cf25FqywqleT/XDwN+7zt0OmhJ234=;
        b=f07RZjtOHJ0Y8lUuGf2fY8d8bI0Mqm6b7z818bomzYkIztIjImnQ3G3PgNScjtikJz
         vRlt7QJ9MoYD33wXcl7JRUL3z0T8PETJavHKgUo/Sr3gc88iNeSmkbpTIGLAB5cwOesg
         ZZnn7eRXLcftQJFtYzLjbG63G/3sihriRdnuEVx+GHeAwxIm8s2jPeV7wEhD3Ff6D7R+
         y5PfycoY8aUIhCZC/BtvRLC1Ha/YhhsSYCJErQB48YC0WBqv7htM7dbHkO9FHQX8PCTY
         LpafcrmfCZGGCboK3QctLwB1VpZ1WaQ+Bw9vCTJecu2rBJTL66oKK+q32wYbRubR8F27
         N/Xw==
X-Gm-Message-State: AOAM533phCO9TkgZW92V4nctJZUc9fJxdfpi9PMoULjfiDzM8dx6/J69
        GPD19NMMrPl5YDn2mPKzHYIoGU6SgIUIyw==
X-Google-Smtp-Source: ABdhPJw9P2aIOniBmrz81UIzCQmQFUxKMfpU1IKXhJHYsTyDDY4oMLTgn+9b3WlodfX0Y/I6Dh7BsA==
X-Received: by 2002:a17:90b:4f4c:: with SMTP id pj12mr20521023pjb.218.1638602976503;
        Fri, 03 Dec 2021 23:29:36 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id ip5sm4449255pjb.5.2021.12.03.23.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 23:29:35 -0800 (PST)
Date:   Sat, 4 Dec 2021 16:29:34 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, kgugala@antmicro.com,
        mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        geert@linux-m68k.org, david.abdurachmanov@sifive.com,
        florent@enjoy-digital.fr
Subject: Re: [PATCH v1 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <YasY3npZ6vlhbtFz@antec>
References: <20211203234155.2319803-1-gsomlo@gmail.com>
 <20211203234155.2319803-4-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203234155.2319803-4-gsomlo@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 06:41:55PM -0500, Gabriel Somlo wrote:
> LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> that targets FPGAs. LiteSDCard is a small footprint, configurable
> SDCard core commonly used in LiteX designs.
> 
> The driver was first written in May 2020 and has been maintained
> cooperatively by the LiteX community. Thanks to all contributors!
> 
> Co-developed-by: Kamil Rakoczy <krakoczy@antmicro.com>
> Signed-off-by: Kamil Rakoczy <krakoczy@antmicro.com>
> Co-developed-by: Maciej Dudek <mdudek@internships.antmicro.com>
> Signed-off-by: Maciej Dudek <mdudek@internships.antmicro.com>
> Co-developed-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Cc: Karol Gugala <kgugala@antmicro.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: David Abdurachmanov <david.abdurachmanov@sifive.com>
> Cc: Florent Kermarrec <florent@enjoy-digital.fr>
> ---
>  drivers/mmc/host/Kconfig     |   6 +
>  drivers/mmc/host/Makefile    |   1 +
>  drivers/mmc/host/litex_mmc.c | 677 +++++++++++++++++++++++++++++++++++
>  3 files changed, 684 insertions(+)
>  create mode 100644 drivers/mmc/host/litex_mmc.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 5af8494c31b5..84c64e72195d 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1093,3 +1093,9 @@ config MMC_OWL
>  
>  config MMC_SDHCI_EXTERNAL_DMA
>  	bool
> +
> +config MMC_LITEX
> +	tristate "Support for the MMC Controller in LiteX SOCs"
> +	depends on OF && LITEX

Shall we allow compile test here like this?

       depends on OF || COMPILE_TEST
       depends on LITEX || COMPILE_TEST

This is what was added for liteuart [0].

[0] https://lore.kernel.org/all/CAHp75Ve9MB4MW9KDPoNhnPa8TCabmMgLbt6H7qrGgwmA8CpdNg@mail.gmail.com/T/#mad93ad951031f8e975a1c632873f516598aec272

> +	help
> +	  Generic MCC driver for LiteX
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index ea36d379bd3c..4e4ceb32c4b4 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -101,6 +101,7 @@ obj-$(CONFIG_MMC_CQHCI)			+= cqhci.o
>  cqhci-y					+= cqhci-core.o
>  cqhci-$(CONFIG_MMC_CRYPTO)		+= cqhci-crypto.o
>  obj-$(CONFIG_MMC_HSQ)			+= mmc_hsq.o
> +obj-$(CONFIG_MMC_LITEX)			+= litex_mmc.o
>  
>  ifeq ($(CONFIG_CB710_DEBUG),y)
>  	CFLAGS-cb710-mmc	+= -DDEBUG
> diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
> new file mode 100644
> index 000000000000..3877379757cd
> --- /dev/null
> +++ b/drivers/mmc/host/litex_mmc.c
> @@ -0,0 +1,677 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * LiteX LiteSDCard driver
> + *
> + * Copyright (C) 2019-2020 Antmicro <www.antmicro.com>
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/litex.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/mmc/sd.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/slot-gpio.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +
> +#define LITEX_PHY_CARDDETECT  0x00
> +#define LITEX_PHY_CLOCKERDIV  0x04
> +#define LITEX_PHY_INITIALIZE  0x08
> +#define LITEX_PHY_WRITESTATUS 0x0C
> +#define LITEX_CORE_CMDARG     0x00
> +#define LITEX_CORE_CMDCMD     0x04
> +#define LITEX_CORE_CMDSND     0x08
> +#define LITEX_CORE_CMDRSP     0x0C
> +#define LITEX_CORE_CMDEVT     0x1C
> +#define LITEX_CORE_DATAEVT    0x20
> +#define LITEX_CORE_BLKLEN     0x24
> +#define LITEX_CORE_BLKCNT     0x28
> +#define LITEX_BLK2MEM_BASE    0x00
> +#define LITEX_BLK2MEM_LEN     0x08
> +#define LITEX_BLK2MEM_ENA     0x0C
> +#define LITEX_BLK2MEM_DONE    0x10
> +#define LITEX_BLK2MEM_LOOP    0x14
> +#define LITEX_MEM2BLK_BASE    0x00
> +#define LITEX_MEM2BLK_LEN     0x08
> +#define LITEX_MEM2BLK_ENA     0x0C
> +#define LITEX_MEM2BLK_DONE    0x10
> +#define LITEX_MEM2BLK_LOOP    0x14
> +#define LITEX_MEM2BLK         0x18
> +#define LITEX_IRQ_STATUS      0x00
> +#define LITEX_IRQ_PENDING     0x04
> +#define LITEX_IRQ_ENABLE      0x08
> +
> +#define SDCARD_CTRL_DATA_TRANSFER_NONE  0
> +#define SDCARD_CTRL_DATA_TRANSFER_READ  1
> +#define SDCARD_CTRL_DATA_TRANSFER_WRITE 2
> +
> +#define SDCARD_CTRL_RESPONSE_NONE       0
> +#define SDCARD_CTRL_RESPONSE_SHORT      1
> +#define SDCARD_CTRL_RESPONSE_LONG       2
> +#define SDCARD_CTRL_RESPONSE_SHORT_BUSY 3
> +
> +#define SD_OK         0
> +#define SD_WRITEERROR 1
> +#define SD_TIMEOUT    2
> +#define SD_CRCERROR   3
> +#define SD_ERR_OTHER  4
> +
> +#define SDIRQ_CARD_DETECT    1
> +#define SDIRQ_SD_TO_MEM_DONE 2
> +#define SDIRQ_MEM_TO_SD_DONE 4
> +#define SDIRQ_CMD_DONE       8
> +
> +struct litex_mmc_host {
> +	struct mmc_host *mmc;
> +	struct platform_device *dev;
> +
> +	void __iomem *sdphy;
> +	void __iomem *sdcore;
> +	void __iomem *sdreader;
> +	void __iomem *sdwriter;
> +	void __iomem *sdirq;
> +
> +	u32 resp[4];
> +	u16 rca;
> +
> +	void *buffer;
> +	size_t buf_size;
> +	dma_addr_t dma;
> +
> +	unsigned int freq;
> +	unsigned int clock;
> +	bool is_bus_width_set;
> +	bool app_cmd;
> +
> +	int irq;
> +	struct completion cmd_done;
> +};
> +
> +static int
> +sdcard_wait_done(void __iomem *reg)
> +{
> +	u8 evt;
> +
> +	for (;;) {
> +		evt = litex_read8(reg);
> +		if (evt & 0x1)
> +			break;
> +		udelay(5);
> +	}
Should we replace this with something like read_poll_timeout?

	if (read_poll_timeout(litex_read8, evt, (evt & 0x1),
			      5, 20000, false, reg)) {
       		pr_err ("read timeout ....");
		return SD_TIMEOUT;
	}

Otherwise we could be locked here forever.

> +	if (evt == 0x1)
> +		return SD_OK;
> +	if (evt & 0x2)
> +		return SD_WRITEERROR;
> +	if (evt & 0x4)
> +		return SD_TIMEOUT;
> +	if (evt & 0x8)
> +		return SD_CRCERROR;
> +	pr_err("%s: unknown error evt=%x\n", __func__, evt);
> +	return SD_ERR_OTHER;
> +}
> +
> +static int
> +send_cmd(struct litex_mmc_host *host,
> +	 u8 cmd, u32 arg, u8 response_len, u8 transfer)
> +{
> +	void __iomem *reg;
> +	ulong n;
> +	u8 i;
> +	int status;
> +
> +	litex_write32(host->sdcore + LITEX_CORE_CMDARG, arg);
> +	litex_write32(host->sdcore + LITEX_CORE_CMDCMD,
> +		      cmd << 8 | transfer << 5 | response_len);
> +	litex_write8(host->sdcore + LITEX_CORE_CMDSND, 1);
> +
> +	/* Wait for an interrupt if we have an interrupt and either there is
> +	 * data to be transferred, or if the card can report busy via DAT0.
> +	 */
> +	if (host->irq > 0 &&
> +	    (transfer != SDCARD_CTRL_DATA_TRANSFER_NONE ||
> +	     response_len == SDCARD_CTRL_RESPONSE_SHORT_BUSY)) {
> +		reinit_completion(&host->cmd_done);
> +		litex_write32(host->sdirq + LITEX_IRQ_ENABLE,
> +			      SDIRQ_CMD_DONE | SDIRQ_CARD_DETECT);
> +		wait_for_completion(&host->cmd_done);
> +	}
> +
> +	status = sdcard_wait_done(host->sdcore + LITEX_CORE_CMDEVT);
> +
> +	if (status != SD_OK) {
> +		pr_err("Command (cmd %d) failed, status %d\n", cmd, status);
> +		return status;
> +	}
> +
> +	if (response_len != SDCARD_CTRL_RESPONSE_NONE) {
> +		reg = host->sdcore + LITEX_CORE_CMDRSP;
> +		for (i = 0; i < 4; i++) {
> +			host->resp[i] = litex_read32(reg);
> +			reg += sizeof(u32);
> +		}
> +	}
> +
> +	if (!host->app_cmd && cmd == SD_SEND_RELATIVE_ADDR)
> +		host->rca = (host->resp[3] >> 16) & 0xffff;
> +
> +	host->app_cmd = (cmd == MMC_APP_CMD);
> +
> +	if (transfer == SDCARD_CTRL_DATA_TRANSFER_NONE)
> +		return status; /* SD_OK from prior sdcard_wait_done(cmd_evt) */
> +
> +	status = sdcard_wait_done(host->sdcore + LITEX_CORE_DATAEVT);
> +	if (status != SD_OK) {
> +		pr_err("Data xfer (cmd %d) failed, status %d\n", cmd, status);
> +		return status;
> +	}
> +
> +	/* wait for completion of (read or write) DMA transfer */
> +	reg = (transfer == SDCARD_CTRL_DATA_TRANSFER_READ) ?
> +		host->sdreader + LITEX_BLK2MEM_DONE :
> +		host->sdwriter + LITEX_MEM2BLK_DONE;
> +	n = jiffies + (HZ << 1);
> +	while ((litex_read8(reg) & 0x01) == 0)
> +		if (time_after(jiffies, n)) {
> +			pr_err("DMA timeout (cmd %d)\n", cmd);
> +			return SD_TIMEOUT;
> +		}

We could use read_poll_timeout here too.

> +
> +	return status;
> +}
> +

-Stafford
