Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AE15AD48B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbiIEOLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237921AbiIEOLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:11:01 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02F527FE9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:10:58 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z25so13344785lfr.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 07:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=miiXUh9DQ+9qeFDUPgGUqMPd1aCcaXXBEiiUKPHd0Gg=;
        b=Mb//nflmO5nD3GweNzcAfgWJfqqqaU5Jc9TO2LzHx7G02VKO8wEvaE5Z1A+ZI+vaTa
         +L+qRy6cOMNlSGv+gUObIxpCjwyf8fIZ3+/uc6dMCrHBA3ywsk5MP1zS5ZA2FTQux7N1
         m/Ur/mm9Sdcm6jtsMvdXp1nvggpMR3Je0vkLS1Te8WTi1CaXh4japTVwRrVvNZgkaSam
         dVmXVR/m3KpBMXtqEzq1OWNuKy0MmoJbcR1OydHloyNLNxBco9uaQKYtzPgJ1k8snBru
         DEHsxZBAoo73t8LXDvaqo3dUqWRyCNGXsoo24c4KMvxvC19QXnx2+pUmnlfknXuSGFVv
         npuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=miiXUh9DQ+9qeFDUPgGUqMPd1aCcaXXBEiiUKPHd0Gg=;
        b=OP7d9LUzZMk0nzn5cjXWzds15vFD1Km1gEaUzkx0OFfOtgZ/573EJC2GQRTl9lSns+
         gYMTzDThiLhZmEjb0+r2vzw2Hi9NdE1nA+NX8DaXEhJSuteGE7ZbVLLDctRX9QEEVFgU
         diV8AlHZmWVUdtpn62vEBpQVrDaZ07JxqFZRW9jgMBYq4Q4iko/pGCbwqBRwv6y08BwQ
         wersxsVtlbrrY+Tji5ss4K8wOsgsajlqvmato5lq0EItFCegCY2/3HUQZ5QbbGBCW5sZ
         TfXpTUJ67/dcA/0oNysf79S54r+Rf6Iu8pIsVPcjPC/Fmma5YGX1lPzgOktIzt50kl7R
         3sYQ==
X-Gm-Message-State: ACgBeo3hOLMhiIKskJkgt5cwBtbRUKHVULzFkdv8WwLLu/X3Kyk3ZLiU
        tDG5TEskYoM1ZChbHEfjb2WQzz5Y7LWwtdFxDwiSQw==
X-Google-Smtp-Source: AA6agR40GZ56VM7jazs6Q3+/b1JiDI3uxtySu2Qtf+Y987i3iWpIxYi0gOmU7DMVNKscdQpcX5jsr4xt8vnaEDy7CYM=
X-Received: by 2002:a05:6512:2a8a:b0:494:8746:bfb4 with SMTP id
 dt10-20020a0565122a8a00b004948746bfb4mr9353569lfb.233.1662387056381; Mon, 05
 Sep 2022 07:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662302950.git.tonyhuang.sunplus@gmail.com> <792626f8c01d91a12506762a3380ba8c8c150012.1662302950.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <792626f8c01d91a12506762a3380ba8c8c150012.1662302950.git.tonyhuang.sunplus@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 5 Sep 2022 16:10:19 +0200
Message-ID: <CAPDyKFoVgySg0FKw67JS_azWtCcU8hkDNuf8NiaZPUav3QW0Lg@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] mmc: Add mmc driver for Sunplus SP7021
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.huang@sunplus.com, wells.lu@sunplus.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Sept 2022 at 18:02, Tony Huang <tonyhuang.sunplus@gmail.com> wrote:
>
> This is a patch for mmc driver for Sunplus SP7021 SOC.
> Supports eMMC 4.41 DDR 104MB/s speed mode.
>
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> ---
> Changes in v5:
>  - Addressed comments from Krzysztof.
>  - Remove the relevant sdcard code.
>  - Submit the emmc code only.
>
> Changes in v6:
>  - Addressed comments from Arnd.
>  - Use SYSTEM_SLEEP_PM_OPS instead of SET_SYSTEM_SLEEP_PM_OPS.
>  - Use RUNTIME_PM_OPS instead of SET_RUNTIME_PM_OPS.
>  - Remove #ifdef check.
>  - Fixed mutex lock and unlock imbalance issue.
>
> Changes in v7:
>  - Addressed comments from kernel test robot.
>  - Remove unused vairable.
>  - Add previous prototype.
>  - Addressed make error and warning in kernel 5.18-rc1.
>
> Changes in v8:
>  - Addressed comments from Uffe.
>
> Changes in v9:
>  - Addressed comments from Uffe.
>
>  MAINTAINERS                    |   1 +
>  drivers/mmc/host/Kconfig       |   9 +
>  drivers/mmc/host/Makefile      |   1 +
>  drivers/mmc/host/sunplus-mmc.c | 964 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 975 insertions(+)
>  create mode 100644 drivers/mmc/host/sunplus-mmc.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cdd809a..2439234 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18874,6 +18874,7 @@ M:      Tony Huang <tonyhuang.sunplus@gmail.com>
>  M:     Li-hao Kuo <lhjeff911@gmail.com>
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
> +F:     drivers/mmc/host/sunplus-mmc.c
>
>  SUNPLUS OCOTP DRIVER
>  M:     Vincent Shih <vincent.sunplus@gmail.com>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index af6c3c3..d99ee3b 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -14,6 +14,15 @@ config MMC_DEBUG
>           added host drivers please don't invent their private macro for
>           debugging.
>
> +config MMC_SUNPLUS
> +       tristate "Sunplus SP7021 MMC Controller"
> +       depends on ARCH_SUNPLUS || COMPILE_TEST
> +       help
> +         If you say yes here, you will get support for eMMC host interface
> +         on Sunplus SoCs.
> +
> +         If unsure, say N
> +
>  config MMC_ARMMMCI
>         tristate "ARM AMBA Multimedia Card Interface support"
>         depends on ARM_AMBA
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 4e4ceb3..ba0c6d0 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -97,6 +97,7 @@ obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)       += sdhci-pic32.o
>  obj-$(CONFIG_MMC_SDHCI_BRCMSTB)                += sdhci-brcmstb.o
>  obj-$(CONFIG_MMC_SDHCI_OMAP)           += sdhci-omap.o
>  obj-$(CONFIG_MMC_SDHCI_SPRD)           += sdhci-sprd.o
> +obj-$(CONFIG_MMC_SUNPLUS)              += sunplus-mmc.o
>  obj-$(CONFIG_MMC_CQHCI)                        += cqhci.o
>  cqhci-y                                        += cqhci-core.o
>  cqhci-$(CONFIG_MMC_CRYPTO)             += cqhci-crypto.o
> diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
> new file mode 100644
> index 0000000..5032678
> --- /dev/null
> +++ b/drivers/mmc/host/sunplus-mmc.c
> @@ -0,0 +1,964 @@
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
> +#include <linux/iopoll.h>
> +#include <linux/mmc/core.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/sdio.h>
> +#include <linux/mmc/slot-gpio.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +
> +#define SPMMC_MIN_CLK                  400000
> +#define SPMMC_MAX_CLK                  52000000
> +#define SPMMC_MAX_BLK_COUNT            65536
> +#define SPMMC_MAX_TUNABLE_DLY  7
> +
> +#define SPMMC_CARD_MEDIATYPE_SRCDST_REG 0x0000
> +#define SPMMC_MEDIA_TYPE               GENMASK(2, 0)
> +#define SPMMC_DMA_SOURCE               GENMASK(6, 4)
> +#define SPMMC_DMA_DESTINATION          GENMASK(10, 8)
> +#define SPMMC_MEDIA_NONE       0
> +#define SPMMC_MEDIA_SD         6
> +#define SPMMC_MEDIA_MS         7
> +
> +#define SPMMC_SDRAM_SECTOR_0_SIZE_REG  0x0008
> +#define SPMMC_DMA_BASE_ADDR_REG                0x000C
> +#define SPMMC_HW_DMA_CTRL_REG          0x0010
> +#define SPMMC_HW_DMA_RST       BIT(9)
> +#define SPMMC_DMAIDLE          BIT(10)
> +
> +#define SPMMC_MAX_DMA_MEMORY_SECTORS   8
> +
> +#define SPMMC_SDRAM_SECTOR_1_ADDR_REG 0x0018
> +
> +#define SPMMC_SD_INT_REG       0x0088
> +#define SPMMC_SDINT_SDCMPEN    BIT(0)
> +#define SPMMC_SDINT_SDCMP      BIT(1)
> +#define SPMMC_SDINT_SDCMPCLR   BIT(2)
> +#define SPMMC_SDINT_SDIOEN     BIT(3)
> +#define SPMMC_SDINT_SDIO       BIT(4)
> +#define SPMMC_SDINT_SDIOCLR    BIT(5)
> +
> +#define SPMMC_SD_PAGE_NUM_REG  0x008C
> +
> +#define SPMMC_SD_CONFIG0_REG   0x0090
> +#define SPMMC_SD_PIO_MODE      BIT(0)
> +#define SPMMC_SD_DDR_MODE      BIT(1)
> +#define SPMMC_SD_LEN_MODE      BIT(2)
> +#define SPMMC_SD_TRANS_MODE    GENMASK(5, 4)
> +#define SPMMC_SD_AUTO_RESPONSE BIT(6)
> +#define SPMMC_SD_CMD_DUMMY     BIT(7)
> +#define SPMMC_SD_RSP_CHK_EN    BIT(8)
> +#define SPMMC_SDIO_MODE                BIT(9)
> +#define SPMMC_SD_MMC_MODE      BIT(10)
> +#define SPMMC_SD_DATA_WD       BIT(11)
> +#define SPMMC_RX4_EN           BIT(14)
> +#define SPMMC_SD_RSP_TYPE      BIT(15)
> +#define SPMMC_MMC8_EN          BIT(18)
> +#define SPMMC_CLOCK_DIVISION   GENMASK(31, 20)
> +
> +#define SPMMC_SDIO_CTRL_REG            0x0094
> +#define SPMMC_INT_MULTI_TRIG           BIT(6)
> +
> +#define SPMMC_SD_RST_REG               0x0098
> +#define SPMMC_SD_CTRL_REG              0x009C
> +#define SPMMC_NEW_COMMAND_TRIGGER      BIT(0)
> +#define SPMMC_DUMMY_CLOCK_TRIGGER      BIT(1)
> +
> +#define SPMMC_SD_STATUS_REG                                            0x00A0
> +#define SPMMC_SDSTATUS_DUMMY_READY                             BIT(0)
> +#define SPMMC_SDSTATUS_RSP_BUF_FULL                            BIT(1)
> +#define SPMMC_SDSTATUS_TX_DATA_BUF_EMPTY               BIT(2)
> +#define SPMMC_SDSTATUS_RX_DATA_BUF_FULL                        BIT(3)
> +#define SPMMC_SDSTATUS_CMD_PIN_STATUS                  BIT(4)
> +#define SPMMC_SDSTATUS_DAT0_PIN_STATUS                 BIT(5)
> +#define SPMMC_SDSTATUS_RSP_TIMEOUT                             BIT(6)
> +#define SPMMC_SDSTATUS_CARD_CRC_CHECK_TIMEOUT  BIT(7)
> +#define SPMMC_SDSTATUS_STB_TIMEOUT                             BIT(8)
> +#define SPMMC_SDSTATUS_RSP_CRC7_ERROR                  BIT(9)
> +#define SPMMC_SDSTATUS_CRC_TOKEN_CHECK_ERROR   BIT(10)
> +#define SPMMC_SDSTATUS_RDATA_CRC16_ERROR               BIT(11)
> +#define SPMMC_SDSTATUS_SUSPEND_STATE_READY             BIT(12)
> +#define SPMMC_SDSTATUS_BUSY_CYCLE                              BIT(13)
> +#define SPMMC_SDSTATUS_DAT1_PIN_STATUS                 BIT(14)
> +#define SPMMC_SDSTATUS_SD_SENSE_STATUS                 BIT(15)
> +#define SPMMC_SDSTATUS_BOOT_ACK_TIMEOUT                        BIT(16)
> +#define SPMMC_SDSTATUS_BOOT_DATA_TIMEOUT               BIT(17)
> +#define SPMMC_SDSTATUS_BOOT_ACK_ERROR                  BIT(18)
> +
> +#define SPMMC_SD_STATE_REG             0x00A4
> +#define SPMMC_CRCTOKEN_CHECK_RESULT    GENMASK(6, 4)
> +#define SPMMC_SDSTATE_ERROR            BIT(13)
> +#define SPMMC_SDSTATE_FINISH   BIT(14)
> +
> +#define SPMMC_SD_HW_STATE_REG          0x00A8
> +#define SPMMC_SD_BLOCKSIZE_REG         0x00AC
> +
> +#define SPMMC_SD_CONFIG1_REG           0x00B0
> +#define SPMMC_TX_DUMMY_NUM             GENMASK(8, 0)
> +#define SPMMC_SD_HIGH_SPEED_EN         BIT(31)
> +
> +#define SPMMC_SD_TIMING_CONFIG0_REG 0x00B4
> +#define SPMMC_SD_CLOCK_DELAY   GENMASK(2, 0)
> +#define SPMMC_SD_WRITE_DATA_DELAY      GENMASK(6, 4)
> +#define SPMMC_SD_WRITE_COMMAND_DELAY   GENMASK(10, 8)
> +#define SPMMC_SD_READ_RESPONSE_DELAY   GENMASK(14, 12)
> +#define SPMMC_SD_READ_DATA_DELAY       GENMASK(18, 16)
> +#define SPMMC_SD_READ_CRC_DELAY        GENMASK(22, 20)
> +
> +#define SPMMC_SD_PIODATATX_REG         0x00BC
> +#define SPMMC_SD_PIODATARX_REG         0x00C0
> +#define SPMMC_SD_CMDBUF0_3_REG         0x00C4
> +#define SPMMC_SD_CMDBUF4_REG           0x00C8
> +#define SPMMC_SD_RSPBUF0_3_REG         0x00CC
> +#define SPMMC_SD_RSPBUF4_5_REG         0x00D0
> +
> +#define SPMMC_MAX_RETRIES (8 * 8)
> +
> +struct spmmc_tuning_info {
> +       int enable_tuning;
> +       int need_tuning;
> +       int retried; /* how many times has been retried */
> +       u32 rd_crc_dly:3;
> +       u32 rd_dat_dly:3;
> +       u32 rd_rsp_dly:3;
> +       u32 wr_cmd_dly:3;
> +       u32 wr_dat_dly:3;
> +       u32 clk_dly:3;
> +};
> +
> +#define SPMMC_DMA_MODE 0
> +#define        SPMMC_PIO_MODE 1
> +
> +struct spmmc_host {
> +       void __iomem *base;
> +       struct clk *clk;
> +       struct reset_control *rstc;
> +       spinlock_t lock; /* Prevent races with irq handler */
> +       struct mutex mrq_lock; /* protect spmmc_set_ios() context and spmmc_request() */
> +       struct mmc_host *mmc;
> +       struct mmc_request *mrq; /* current mrq */
> +       int irq;
> +       int power_state; /* current power state: off/up/on */
> +       int ddr_enabled;

By looking at how this variable is being used (in
spmmc_set_bus_timing()), there is no need to store this in the struct
spmmc_host, right?

Please, go through the other variables here too, to make sure the
similar pattern isn't repeated.

> +       int signal_voltage;
> +       int dmapio_mode;
> +       struct sg_mapping_iter sg_miter; /* for pio mode to access sglist */
> +       struct spmmc_tuning_info tuning_info;
> +};
> +
> +/*
> + * wait for transaction done, return -1 if error.
> + */

This comment isn't correct anymore. I suggest just dropping it.

> +static inline int spmmc_wait_finish(struct spmmc_host *host)
> +{
> +       u32 val = 0;
> +       int ret;
> +
> +       ret = readl_poll_timeout_atomic(host->base + SPMMC_SD_STATE_REG, val,
> +                                       (val & SPMMC_SDSTATE_FINISH), 1, 50000);
> +
> +       if (ret == -ETIMEDOUT)
> +               return -ETIMEDOUT;
> +       else
> +               return 0;

This looks unnecessarily complicated, to me.
readl_poll_timeout_atomic() returns 0 on success or -ETIMEDOUT on
failure, thus we can just do the below instead:

return readl_poll_timeout_atomic(host->base + SPMMC_SD_STATE_REG, val,
(val & SPMMC_SDSTATE_FINISH), 1, 50000);

Moreover, it looks like spmmc_wait_finish() isn't being called from
atomic context, so I think it would be better to use
readl_poll_timeout() instead. And finally, please make the timeout
values defined as constant values.

> +}
> +
> +static inline int spmmc_wait_sdstatus(struct spmmc_host *host, unsigned int status_bit)
> +{
> +       u32 val = 0;
> +       int ret;
> +
> +       ret = readl_poll_timeout_atomic(host->base + SPMMC_SD_STATUS_REG, val,
> +                                       (val & status_bit), 1, 50000);
> +
> +       if (ret == -ETIMEDOUT)
> +               return -ETIMEDOUT;
> +       else
> +               return 0;

Similar comments as above, except that this seems to need the *atomic() version.

> +}
> +
> +#define spmmc_wait_rspbuf_full(host) spmmc_wait_sdstatus(host, SPMMC_SDSTATUS_RSP_BUF_FULL)
> +#define spmmc_wait_rxbuf_full(host) spmmc_wait_sdstatus(host, SPMMC_SDSTATUS_RX_DATA_BUF_FULL)
> +#define spmmc_wait_txbuf_empty(host) spmmc_wait_sdstatus(host, SPMMC_SDSTATUS_TX_DATA_BUF_EMPTY)
> +

[...]

> +static void spmmc_sw_reset(struct spmmc_host *host)
> +{
> +       u32 value;
> +
> +       /*
> +        * Must reset dma operation first, or it will
> +        * be stuck on sd_state == 0x1c00 because of
> +        * a controller software reset bug
> +        */
> +       value = readl(host->base + SPMMC_HW_DMA_CTRL_REG);
> +       value |= SPMMC_DMAIDLE;
> +       writel(value, host->base + SPMMC_HW_DMA_CTRL_REG);
> +       value &= ~SPMMC_DMAIDLE;
> +       writel(value, host->base + SPMMC_HW_DMA_CTRL_REG);
> +       value = readl(host->base + SPMMC_HW_DMA_CTRL_REG);
> +       value |= SPMMC_HW_DMA_RST;
> +       writel(value, host->base + SPMMC_HW_DMA_CTRL_REG);
> +       writel(0x7, host->base + SPMMC_SD_RST_REG);
> +       while (readl(host->base + SPMMC_SD_HW_STATE_REG) & BIT(6))
> +               ;

This looks like it's better done with the readl_poll_timeout_atomic().

Sorry, that I didn't notice this during the last time I reviewed this.

[...]

> +static void spmmc_send_stop_cmd(struct spmmc_host *host)

Looks like this function is unused now (which is good), please drop it.

> +{
> +       struct mmc_command stop = {};
> +       u32 value;
> +
> +       stop.opcode = MMC_STOP_TRANSMISSION;
> +       stop.arg = 0;
> +       stop.flags = MMC_RSP_R1B;
> +       spmmc_prepare_cmd(host, &stop);
> +       value = readl(host->base + SPMMC_SD_INT_REG);
> +       value &= ~SPMMC_SDINT_SDCMPEN;
> +       value |= FIELD_PREP(SPMMC_SDINT_SDCMPEN, 0);
> +       writel(value, host->base + SPMMC_SD_INT_REG);
> +       spmmc_trigger_transaction(host);
> +       spmmc_wait_finish(host);
> +}

[...]

> +
> +/* Interrupt Service Routine */
> +static irqreturn_t spmmc_irq(int irq, void *dev_id)
> +{
> +       struct spmmc_host *host = dev_id;
> +       u32 value = readl(host->base + SPMMC_SD_INT_REG);
> +
> +       spin_lock(&host->lock);
> +       if ((value & SPMMC_SDINT_SDCMP) && (value & SPMMC_SDINT_SDCMPEN)) {
> +               value &= ~SPMMC_SDINT_SDCMPEN;
> +               value |= SPMMC_SDINT_SDCMPCLR;
> +               writel(value, host->base + SPMMC_SD_INT_REG);
> +               spmmc_finish_request(host, host->mrq);

I am not quite sure I understand how this is intended to work. So,
spmmc_finish_request() is being called to complete the request....

In some cases the spin_lock (host->lock) is being used to protect the
host->mrq, while in other cases the mutex (host->mrq_lock) is used.
This looks weird to me, but I may be wrong. Perhaps you can elaborate
why this is done like this?

In my opinion, it looks like we should be able to convert into using
solely a spin_lock. From non-atomic context, we then need to use
spin_lock_irqsave/spin_unlock |irqrestore() to protect the needed
parts.

We may also consider to use IRQF_ONESHOT when requesting the irq with
devm_request_threaded_irq(), as it looks like it may help to simplify
the locking code.

> +       }
> +       spin_unlock(&host->lock);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static void spmmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +       struct spmmc_host *host = mmc_priv(mmc);
> +       struct mmc_data *data;
> +       struct mmc_command *cmd;
> +
> +       mutex_lock(&host->mrq_lock);

As stated above, here it's the mutex that's being used. In this case,
I also don't think it's clear what the mutex is really protecting?

Note that the mmc core also manages a specific host lock. This enables
the mmc core to serialize calls into the host (via the host ops
callbacks). In principle, this means that host ops can't be invoked in
parallel with each other.

> +       host->mrq = mrq;
> +       data = mrq->data;
> +       cmd = mrq->cmd;
> +
> +       spmmc_prepare_cmd(host, cmd);
> +       /* we need manually read response R2. */
> +       if (cmd->flags & MMC_RSP_136) {
> +               spmmc_trigger_transaction(host);
> +               spmmc_get_rsp(host, cmd);
> +               spmmc_wait_finish(host);
> +               spmmc_check_error(host, mrq);
> +               host->mrq = NULL;
> +               mmc_request_done(host->mmc, mrq);
> +       } else {
> +               if (data)
> +                       spmmc_prepare_data(host, data);
> +
> +               if (host->dmapio_mode == SPMMC_PIO_MODE && data) {
> +                       u32 value;
> +                       /* pio data transfer do not use interrupt */
> +                       value = readl(host->base + SPMMC_SD_INT_REG);
> +                       value &= ~SPMMC_SDINT_SDCMPEN;
> +                       writel(value, host->base + SPMMC_SD_INT_REG);
> +                       spmmc_trigger_transaction(host);
> +                       spmmc_xfer_data_pio(host, data);
> +                       spmmc_wait_finish(host);
> +                       spmmc_finish_request(host, mrq);
> +               } else {
> +                       spmmc_trigger_transaction(host);
> +                       spmmc_wait_finish(host);
> +                       spmmc_finish_request(host, mrq);
> +               }
> +       }
> +       mutex_unlock(&host->mrq_lock);
> +}
> +
> +static void spmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +       struct spmmc_host *host = (struct spmmc_host *)mmc_priv(mmc);
> +
> +       mutex_lock(&host->mrq_lock);

Again, it's not really clear to me what is being protected with the
mutex here. Can you elaborate?

> +       spmmc_set_bus_clk(host, ios->clock);
> +       spmmc_set_bus_timing(host, ios->timing);
> +       spmmc_set_bus_width(host, ios->bus_width);
> +       /* ensure mode is correct, because we might have hw reset the controller */
> +       spmmc_set_sdmmc_mode(host);
> +       mutex_unlock(&host->mrq_lock);
> +}

[...]

> +
> +static irqreturn_t spmmc_func_finish_req(int irq, void *dev_id)
> +{
> +       struct spmmc_host *host = dev_id;
> +
> +       spin_lock(&host->lock);

This is non-atomic context, so using spin_lock() here is wrong. It may
cause deadlocks, if the IRQ is triggered at this point, as it would
mean that the hard IRQ handler would be stuck waiting for the same
spin_lock to be released.

We use spin_lock_irqsave() to protect this from happening.

> +       spmmc_finish_request(host, host->mrq);
> +       spin_unlock(&host->lock);
> +
> +       return IRQ_HANDLED;
> +}

[...]

> +static int spmmc_drv_remove(struct platform_device *dev)
> +{
> +       struct spmmc_host *host = platform_get_drvdata(dev);
> +
> +       mmc_remove_host(host->mmc);
> +       pm_runtime_get_sync(&dev->dev);
> +       clk_disable_unprepare(host->clk);
> +       pm_runtime_put_noidle(&dev->dev);

You need a pm_runtime_disable() here too.

> +       platform_set_drvdata(dev, NULL);
> +       mmc_free_host(host->mmc);
> +
> +       return 0;
> +}
> +

[...]

Kind regards
Uffe
