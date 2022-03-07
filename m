Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB134D079A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245091AbiCGTX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245043AbiCGTXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:23:55 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B2512A96
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 11:22:59 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4FE843F4C2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 19:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646680976;
        bh=GiqimrdZ4RbGlQELkeReY9CaMQL0L1JkZToKe0gjU/8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=wAKJx5KNsLBsHgGsyorikhR/ZklgW+ITWqB+DbC3L9sc43AT2OtjHG6LS6um+qWPq
         Ms624XZvjlQA832HU5mI3L6KkinxJwNY4n6NwpeS+vvoS2QoxDysgB60QKD9CSiHfo
         SIH2H1a4wzIU1ZwndcJkwlAMu3sCEPI7XLClIWDfOX35eK7PloB2QjzUxYqB1CTHlR
         30beDlaKHRAzAig0zKHJ0lcIptynUkZr7UC7pU5PtFr7+oGonMISORVGiOELAhCneE
         E+6EHEfw1aO6viQBmmYobzlPnn6jLwu4mAs7BAQEJNuHXd+CymIs/S5iyZU+DNBwok
         7APH9iijXiGhw==
Received: by mail-ej1-f71.google.com with SMTP id d7-20020a1709061f4700b006bbf73a7becso7440134ejk.17
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 11:22:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GiqimrdZ4RbGlQELkeReY9CaMQL0L1JkZToKe0gjU/8=;
        b=f0wQIxUaFCfHGMPoUlXzGY6Qj/OojzFglmT2GyyNV6sKdo17B/UA1FcHxIMzQQoteI
         uy6hQlbfkREUOslMBsPT9l4KiTUStmIxT0HGRhL12PoepSQZAQAxiylbSqN/mrFML278
         TYb7RbN9uE57U9Ec2VJTeWte1uUmjnpDr9kdXXVvG10g1iQiOwBZnighiPWv1gSIV15Q
         WSpaobv33IFt8xCnY7VX0nBqyhRYnUEXGBkgkfAfpzxsFCuL6UJoDNTS5gfeGfZuWfyE
         4Vex/v1jLU35njZCpfFlT2L0GK/cu4m/mgZKpBIHJMT7BS96MPsQql9JMEES7s9EotQx
         YhTw==
X-Gm-Message-State: AOAM531Hpb0SZb+YukE4C9ul/akDWJLHcdi+dM7/YCey+oqgtEeILbCe
        gzkQSD+an2EGlXiEkNeBKU2/3X4oQpBsMD4iGXnTxBKW8OPe6STMZrpPYpDUtb7RoK42f5wEoNO
        poiY0lcXLYozWG1hn4tSBsQHHgDeJjTn/l+gG0WrFLw==
X-Received: by 2002:aa7:d991:0:b0:416:5f6c:e260 with SMTP id u17-20020aa7d991000000b004165f6ce260mr2956321eds.268.1646680975678;
        Mon, 07 Mar 2022 11:22:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxxI/c4ZIx6tI4eIG1RupApGRKfCzCn0y7R0Xxr/TcQcy301EeyfYItsr4IHien3Jr1KZh1aw==
X-Received: by 2002:aa7:d991:0:b0:416:5f6c:e260 with SMTP id u17-20020aa7d991000000b004165f6ce260mr2956296eds.268.1646680975246;
        Mon, 07 Mar 2022 11:22:55 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id jl2-20020a17090775c200b006dabe8887b8sm3757171ejc.21.2022.03.07.11.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 11:22:54 -0800 (PST)
Message-ID: <16d98dfa-66f9-f9a4-08c9-d68d78c33b23@canonical.com>
Date:   Mon, 7 Mar 2022 20:22:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 2/2] misc: Add iop driver for Sunplus SP7021
Content-Language: en-US
To:     Tony Huang <tonyhuang.sunplus@gmail.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        derek.kiernan@xilinx.com, Dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com
References: <cover.1646629400.git.tonyhuang.sunplus@gmail.com>
 <c6b959b3ac966f0c95487df0f9b9efc79c93983f.1646629400.git.tonyhuang.sunplus@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <c6b959b3ac966f0c95487df0f9b9efc79c93983f.1646629400.git.tonyhuang.sunplus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 06:25, Tony Huang wrote:
> This driver is load 8051 bin code.
> Processor for I/O control:
> SP7021 has its own GPIO device driver.
> The user can configure the gpio pin for 8051 use.
> The 8051 support wake-up with IR key after system poweroff.
> 
> Monitor RTC interrupt:
> SP7021 system has its own RTC device driver (rtc-sunplus.c).
> The user can set the RTC wake-up time through rtc-sunplus.c.
> The IOP code does not need to increase the RTC subsystem function,
> set the RTC register.	When the linux kernel system is poweroff.
> Only the 8051 CPU has power and can monitor the RTC wake-up interrupt.
> 
> PMC in power management purpose:
> Add sp_iop_poweroff() function. pm_power_off=sp_iop_poweroff.
> When the poweroff command is executed.
> The 8051 has a register to control the power-on and power-off 
> of the system. If you turn off the power through the 8051 
> register(DEF_PWR_EN_0=0). The current measured by the circuit 
> board is 0.4mA only. In order to save power.
> 
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> ---
> Changes in v10:
>  - Added sp_iop_poweroff function for poweroff command.
> 
>  MAINTAINERS                |   1 +
>  drivers/misc/Kconfig       |  36 ++++
>  drivers/misc/Makefile      |   1 +
>  drivers/misc/sunplus_iop.c | 438 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 476 insertions(+)
>  create mode 100644 drivers/misc/sunplus_iop.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6f336c9..11ecefa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18246,6 +18246,7 @@ SUNPLUS IOP DRIVER
>  M:	Tony Huang <tonyhuang.sunplus@gmail.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/misc/sunplu-iop.yaml
> +F:	drivers/misc/sunplus_iop.c
>  
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 0f5a49f..3106f15 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -470,6 +470,42 @@ config HISI_HIKEY_USB
>  	  switching between the dual-role USB-C port and the USB-A host ports
>  	  using only one USB controller.
>  
> +config SUNPLUS_IOP
> +	tristate "Sunplus IOP support"
> +	default ARCH_SUNPLUS
> +	help
> +	  This driver is load 8051 bin code.
> +	  Processor for I/O control:
> +	  SP7021 has its own GPIO device driver.
> +	  The user can configure the gpio pin for 8051 use.
> +	  8051 support wake-up with IR key after system poweroff.
> +
> +	  Monitor RTC interrupt:
> +	  SP7021 system has its own RTC device driver (rtc-sunplus.c).
> +	  The user can set the RTC wake-up time through rtc-sunplus.c.
> +	  The IOP code does not need to increase the RTC subsystem function,
> +	  set the RTC register.	When the linux kernel system is poweroff.
> +	  Only the 8051 CPU has power and can monitor the RTC wake-up interrupt.
> +
> +	  PMC in power management purpose:
> +	  Add sp_iop_poweroff() function. pm_power_off=sp_iop_poweroff.
> +	  When the poweroff command is executed.
> +	  The 8051 has a register to control the power-on and power-off of the system.
> +	  If you turn off the power through the 8051 register(DEF_PWR_EN_0=0),
> +	  The current measured by the circuit board is 0.4mA only. In order to save power.
> +
> +	  The IOP core is DQ8051, so also named IOP8051.
> +	  Need Install DQ8051, The DQ8051 bin file generated by keil C.
> +	  We will provide users with 8051 normal and standby source code.
> +	  Path: https://sunplus.atlassian.net/wiki/spaces/doc/pages/610172933/
> +	  How+to+use+I+O+processor+8051+of+SP7021#5.-Write-C-or-assembly-source-files-for-IOP
> +	  Users can follow the operation steps to generate normal.bin and standby.bin.
> +	  Path: https://sunplus.atlassian.net/wiki/spaces/doc/pages/466190338/26.+IOP8051
> +	  26.5?How To Create 8051 bin file
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called sunplus_iop.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index a086197..eafeab6 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -52,6 +52,7 @@ obj-$(CONFIG_DW_XDATA_PCIE)	+= dw-xdata-pcie.o
>  obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
>  obj-$(CONFIG_OCXL)		+= ocxl/
>  obj-$(CONFIG_BCM_VK)		+= bcm-vk/
> +obj-$(CONFIG_SUNPLUS_IOP)	+= sunplus_iop.o
>  obj-y				+= cardreader/
>  obj-$(CONFIG_PVPANIC)   	+= pvpanic/
>  obj-$(CONFIG_HABANA_AI)		+= habanalabs/
> diff --git a/drivers/misc/sunplus_iop.c b/drivers/misc/sunplus_iop.c
> new file mode 100644
> index 0000000..03301b4
> --- /dev/null
> +++ b/drivers/misc/sunplus_iop.c
> @@ -0,0 +1,438 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * The IOP driver for Sunplus SP7021
> + *
> + * Copyright (C) 2021 Sunplus Technology Inc.
> + *
> + * All Rights Reserved.
> + */
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/firmware.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/of_gpio.h>
> +

Except comments from Arnd also:

> +enum IOP_Status_e {
> +	IOP_SUCCESS,		/* successful */
> +	IOP_ERR_IOP_BUSY,	/* IOP is busy */
> +};

please do not redefine true/false or ERRNO.

> +
> +/* moon0 register offset */
> +#define IOP_CLKEN0	0x04
> +#define IOP_RESET0	0x54
> +
> +/* IOP register offset */
> +#define IOP_CONTROL	0x00
> +#define IOP_DATA0	0x20
> +#define IOP_DATA1	0x24
> +#define IOP_DATA2	0x28
> +#define IOP_DATA3	0x2c
> +#define IOP_DATA4	0x30
> +#define IOP_DATA5	0x34
> +#define IOP_DATA6	0x38
> +#define IOP_DATA7	0x3c
> +#define IOP_DATA8	0x40
> +#define IOP_DATA9	0x44
> +#define IOP_DATA10	0x48
> +#define IOP_DATA11	0x4c
> +#define IOP_BASE_ADR_L	0x50
> +#define IOP_BASE_ADR_H	0x54
> +
> +/* PMC register offset */
> +#define IOP_PMC_TIMER		0x00
> +#define IOP_PMC_CTRL		0x04
> +#define IOP_XTAL27M_PASSWORD_I	0x08
> +#define IOP_XTAL27M_PASSWORD_II	0x0c
> +#define IOP_XTAL32K_PASSWORD_I	0x10
> +#define IOP_XTAL32K_PASSWORD_II	0x14
> +#define IOP_CLK27M_PASSWORD_I	0x18
> +#define IOP_CLK27M_PASSWORD_II	0x1c
> +#define IOP_PMC_TIMER2		0x20
> +
> +#define NORMAL_CODE_MAX_SIZE 0X1000	/* Max size of normal.bin that can be received */
> +#define STANDBY_CODE_MAX_SIZE 0x4000	/* Max size of standby.bin that can be received */

Empty line.

> +struct sp_iop {
> +	struct device *dev;
> +	struct mutex write_lock;	/* avoid parallel access */

This comment is useless. It is obvious that mutex is used to avoid
parallel access, what else could it be used?

Instead, you need to describe which members/variables/parts of code are
protected with the mutex.

> +	void __iomem *iop_regs;
> +	void __iomem *pmc_regs;
> +	void __iomem *moon0_regs;
> +	int irq;
> +	int gpio_wakeup;
> +	unsigned char iop_normal_code[NORMAL_CODE_MAX_SIZE];
> +	unsigned char iop_standby_code[STANDBY_CODE_MAX_SIZE];

Why not using firmware? include/linux/firmware.h? Do not reimplement
existing solutions...

> +	resource_size_t iop_mem_start;
> +	resource_size_t iop_mem_size;
> +	unsigned char bin_code_mode;
> +};
> +
> +static struct sp_iop *iop_poweroff;
> +
> +static void sp_iop_run_normal_code(struct sp_iop *iop)
> +{
> +	void __iomem *iop_kernel_base;
> +	unsigned int reg;
> +
> +	iop_kernel_base = ioremap(iop->iop_mem_start, NORMAL_CODE_MAX_SIZE);
> +	memset(iop_kernel_base, 0, NORMAL_CODE_MAX_SIZE);
> +	memcpy(iop_kernel_base, iop->iop_normal_code, NORMAL_CODE_MAX_SIZE);
> +
> +	writel(0x00100010, iop->moon0_regs + IOP_CLKEN0);
> +
> +	reg = readl(iop->iop_regs + IOP_CONTROL);
> +	reg |= 0x01;
> +	writel(reg, iop->iop_regs + IOP_CONTROL);
> +
> +	reg = readl(iop->iop_regs + IOP_CONTROL);
> +	reg &= ~(0x8000);
> +	writel(reg, iop->iop_regs + IOP_CONTROL);
> +
> +	reg = readl(iop->iop_regs + IOP_CONTROL);
> +	reg |= 0x0200;// disable watchdog event reset IOP
> +	writel(reg, iop->iop_regs + IOP_CONTROL);
> +
> +	reg = (iop->iop_mem_start & 0xFFFF);
> +	writel(reg, iop->iop_regs + IOP_BASE_ADR_L);
> +	reg	= (iop->iop_mem_start >> 16);
> +	writel(reg, iop->iop_regs + IOP_BASE_ADR_H);
> +
> +	reg = readl(iop->iop_regs + IOP_CONTROL);
> +	reg &= ~(0x01);
> +	writel(reg, iop->iop_regs + IOP_CONTROL);
> +	iop->bin_code_mode = 0;
> +}
> +
> +static void sp_iop_run_standby_code(struct sp_iop *iop)
> +{
> +	void __iomem *iop_kernel_base;
> +	unsigned long reg;
> +
> +	iop_kernel_base = ioremap(iop->iop_mem_start, STANDBY_CODE_MAX_SIZE);
> +	memset(iop_kernel_base, 0, STANDBY_CODE_MAX_SIZE);
> +	memcpy(iop_kernel_base, iop->iop_standby_code, STANDBY_CODE_MAX_SIZE);
> +
> +	writel(0x00100010, iop->moon0_regs + IOP_CLKEN0);
> +
> +	reg = readl(iop->iop_regs + IOP_CONTROL);
> +	reg |= 0x01;
> +	writel(reg, iop->iop_regs + IOP_CONTROL);
> +
> +	reg = readl(iop->iop_regs + IOP_CONTROL);
> +	reg &= ~(0x8000);
> +	writel(reg, iop->iop_regs + IOP_CONTROL);
> +
> +	reg = readl(iop->iop_regs + IOP_CONTROL);
> +	reg |= 0x0200;// disable watchdog event reset IOP
> +	writel(reg, iop->iop_regs + IOP_CONTROL);
> +
> +	reg = (iop->iop_mem_start & 0xFFFF);
> +	writel(reg, iop->iop_regs + IOP_BASE_ADR_L);
> +	reg = (iop->iop_mem_start >> 16);
> +	writel(reg, iop->iop_regs + IOP_BASE_ADR_H);
> +
> +	reg = readl(iop->iop_regs + IOP_CONTROL);
> +	reg &= ~(0x01);
> +	writel(reg, iop->iop_regs + IOP_CONTROL);
> +	iop->bin_code_mode = 1;
> +}
> +
> +/* 8051 informs linux kerenl. 8051 has been switched to standby.bin code. */
> +#define IOP_READY	0x0004
> +#define RISC_READY	0x0008
> +
> +/* System linux kernel tells 8051 which  gpio pin to wake-up through. */
> +#define WAKEUP_PIN	0xFE02
> +
> +/* System linux kernel tells 8051 to execute S1 or S3 mode. */
> +#define S1	0x5331
> +#define S3	0x5333

Keep defines together, so beginning of file.

> +
> +static int sp_iop_s3mode(struct device *dev, struct sp_iop *iop)
> +{
> +	unsigned int reg;
> +	int ret, value;
> +
> +	/* PMC set */
> +	writel(0x00010001, iop->pmc_regs + IOP_PMC_TIMER);
> +	reg = readl(iop->pmc_regs + IOP_PMC_CTRL);
> +	/* disable system reset PMC, enalbe power down IOP Domain, enable gating clock 27Mhz */
> +	reg |= 0x23;
> +	writel(reg, iop->pmc_regs + IOP_PMC_CTRL);
> +
> +	writel(0x55aa00ff, iop->pmc_regs + IOP_XTAL27M_PASSWORD_I);
> +	writel(0x00ff55aa, iop->pmc_regs + IOP_XTAL27M_PASSWORD_II);
> +	writel(0xaa00ff55, iop->pmc_regs + IOP_XTAL32K_PASSWORD_I);
> +	writel(0xff55aa00, iop->pmc_regs + IOP_XTAL32K_PASSWORD_II);
> +	writel(0xaaff0055, iop->pmc_regs + IOP_CLK27M_PASSWORD_I);
> +	writel(0x5500aaff, iop->pmc_regs + IOP_CLK27M_PASSWORD_II);
> +	writel(0x01000100, iop->pmc_regs + IOP_PMC_TIMER2);
> +
> +	/* IOP Hardware IP reset */
> +	reg = readl(iop->moon0_regs + IOP_RESET0);
> +	reg |= 0x10;
> +	writel(reg, (iop->moon0_regs + IOP_RESET0));
> +	reg &= ~(0x10);
> +	writel(reg, (iop->moon0_regs + IOP_RESET0));
> +
> +	writel(0x00ff0085, (iop->moon0_regs + 32 * 4 * 1 + 4 * 1));
> +
> +	reg = readl(iop->moon0_regs + 32 * 4 * 1 + 4 * 2);
> +	reg |= 0x08000800;
> +	writel(reg, (iop->moon0_regs + 32 * 4 * 1 + 4 * 2));
> +
> +	writel(WAKEUP_PIN, iop->iop_regs + IOP_DATA0);
> +	writel(iop->gpio_wakeup, iop->iop_regs + IOP_DATA1);
> +
> +	ret = readl_poll_timeout(iop->iop_regs + IOP_DATA2, value,
> +				 (value & IOP_READY) == IOP_READY, 1000, 10000);
> +	if (ret) {
> +		dev_err(dev, "timed out\n");
> +		return ret;
> +	}
> +
> +	reg = RISC_READY;
> +	writel(reg, iop->iop_regs + IOP_DATA2);
> +	reg = 0x0000;
> +	writel(reg, iop->iop_regs + IOP_DATA5);
> +	reg = 0x0060;
> +	writel(reg, iop->iop_regs + IOP_DATA6);
> +
> +	ret = readl_poll_timeout(iop->iop_regs + IOP_DATA7, value,
> +				 value == 0xaaaa, 1000, 10000);
> +	if (ret) {
> +		dev_err(dev, "timed out\n");
> +		return ret;
> +	}
> +
> +	/* 8051 bin file call Ultra low function. */
> +	writel(0xdd, iop->iop_regs + IOP_DATA1);
> +	/*
> +	 * When the execution is here, the system linux kernel
> +	 * is about to be powered off
> +	 * The purpose of mdelay(10): Do not let the system linux
> +	 * kernel continue to run other programs.
> +	 */
> +	mdelay(10);
> +	return 0;
> +}
> +
> +static int sp_iop_s1mode(struct device *dev, struct sp_iop *iop)
> +{
> +	int ret, value;
> +
> +	ret = readl_poll_timeout(iop->iop_regs + IOP_DATA2, value,
> +				 (value & IOP_READY) == IOP_READY, 1000, 10000);
> +	if (ret) {
> +		dev_err(dev, "timed out\n");
> +		return ret;
> +	}
> +
> +	writel(RISC_READY, iop->iop_regs + IOP_DATA2);
> +	writel(0x0000, iop->iop_regs + IOP_DATA5);
> +	writel(0x0060, iop->iop_regs + IOP_DATA6);
> +
> +	ret = readl_poll_timeout(iop->iop_regs + IOP_DATA7, value,
> +				 value == 0xaaaa, 1000, 10000);

Hundreds of magical constants... Almost all of these should be defined
or described.

> +	if (ret) {
> +		dev_err(dev, "timed out\n");
> +		return ret;
> +	}
> +
> +	/* 8051 bin file call S1_mode function. */
> +	writel(0xee, iop->iop_regs + IOP_DATA1);
> +	/*
> +	 * When the execution is here, the system linux kernel
> +	 * is about to be powered off
> +	 * The purpose of mdelay(10): Do not let the system linux
> +	 * kernel continue to run other programs.
> +	 */
> +	mdelay(10);
> +	return 0;
> +}
> +
> +static int  sp_iop_get_normal_code(struct device *dev, struct sp_iop *iop)
> +{
> +	const struct firmware *fw;
> +	static const char file[] = "normal.bin";
> +	unsigned int err, i;
> +
> +	err = request_firmware(&fw, file, dev);
> +	if (err) {
> +		dev_err(dev, "get bin file error\n");
> +		return err;
> +	}
> +
> +	for (i = 0; i < NORMAL_CODE_MAX_SIZE; i++) {
> +		char temp;
> +
> +		temp = fw->data[i];
> +		iop->iop_normal_code[i] = temp;
> +	}
> +	release_firmware(fw);
> +	return err;
> +}
> +
> +static int  sp_iop_get_standby_code(struct device *dev, struct sp_iop *iop)
> +{
> +	const struct firmware *fw;
> +	static const char file[] = "standby.bin";
> +	unsigned int err, i;
> +
> +	err = request_firmware(&fw, file, dev);
> +	if (err) {
> +		dev_err(dev, "get bin file error\n");
> +		return err;
> +	}
> +
> +	for (i = 0; i < STANDBY_CODE_MAX_SIZE; i++) {
> +		char temp;
> +
> +		temp = fw->data[i];
> +		iop->iop_standby_code[i] = temp;
> +	}
> +	release_firmware(fw);
> +	return err;
> +}
> +
> +static void sp_iop_poweroff(void)
> +{
> +	struct sp_iop *iop = iop_poweroff;
> +	unsigned int ret, value;
> +
> +	value = readl(iop->iop_regs + IOP_DATA11);
> +	sp_iop_run_standby_code(iop);
> +
> +	ret = readl_poll_timeout(iop->iop_regs + IOP_DATA0, value,
> +				 value == 0x2222, 1000, 100000);
> +	if (ret)
> +		dev_warn(iop->dev, "timed out\n");
> +
> +	if (value == S1)
> +		sp_iop_s1mode(iop->dev, iop);
> +	else
> +		sp_iop_s3mode(iop->dev, iop);
> +}
> +
> +static int sp_iop_get_resources(struct platform_device *pdev, struct sp_iop *p_sp_iop_info)
> +{
> +	struct resource *r;
> +
> +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "iop");
> +	p_sp_iop_info->iop_regs = devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(p_sp_iop_info->iop_regs)) {
> +		dev_err(&pdev->dev, "ioremap fail\n");
> +		return PTR_ERR(p_sp_iop_info->iop_regs);
> +	}
> +
> +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "iop_pmc");
> +	p_sp_iop_info->pmc_regs = devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(p_sp_iop_info->pmc_regs)) {
> +		dev_err(&pdev->dev, "ioremap fail\n");
> +		return PTR_ERR(p_sp_iop_info->pmc_regs);
> +	}
> +
> +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "moon0");
> +	p_sp_iop_info->moon0_regs = devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(p_sp_iop_info->moon0_regs)) {
> +		dev_err(&pdev->dev, "ioremap fail\n");
> +		return PTR_ERR(p_sp_iop_info->moon0_regs);
> +	}
> +	return IOP_SUCCESS;
> +}
> +
> +static int sp_iop_platform_driver_probe(struct platform_device *pdev)
> +{
> +	int ret = -ENXIO;
> +	int rc;
> +	struct sp_iop *iop;
> +	struct device_node *memnp;
> +	struct resource mem_res;
> +
> +	iop = devm_kzalloc(&pdev->dev, sizeof(struct sp_iop), GFP_KERNEL);
> +	if (!iop) {
> +		ret	= -ENOMEM;

Wrong spacing before '='.

> +		goto fail_kmalloc;
> +	}
> +	/* init */

Remove useless comments.

> +	mutex_init(&iop->write_lock);

Where are lock/unlock operations? What is this all code? This looks like
half-baked solution...

> +	ret = sp_iop_get_resources(pdev, iop);
> +
> +	// Get reserve address

Keep consistent style. For comments /* is preferred. But definitely do
not mix one with another.

This code is difficult to read.

> +	memnp = of_parse_phandle(pdev->dev.of_node, "memory-region", 0);
> +	if (!memnp) {
> +		dev_err(&pdev->dev, "no memory-region node\n");
> +		return -EINVAL;
> +	}
> +
> +	rc = of_address_to_resource(memnp, 0, &mem_res);
> +	of_node_put(memnp);
> +	if (rc) {
> +		dev_err(&pdev->dev, "failed to translate memory-region to a resource\n");
> +		return -EINVAL;
> +	}
> +
> +	iop->dev = &pdev->dev;
> +	iop->iop_mem_start = mem_res.start;
> +	iop->iop_mem_size = resource_size(&mem_res);
> +
> +	/*
> +	 * 8051 has two bin files, normal.bin and standby.bin in rootfs.
> +	 * Normally, 8051 executes normal.bin code. Normal.bin code size can exceed 16K.
> +	 * When system linux kernel is shutdown, 8051 is to execute standby.bin code.
> +	 * Standby.bin code cannot exceed 16K bytes. Because 8051 Icache size is 16k.
> +	 * 8051 runs with standby.bin code in the Icache before the system(linux kernel)
> +	 * is poweroff.
> +	 */
> +	ret = sp_iop_get_normal_code(&pdev->dev, iop);
> +	if (ret != 0) {
> +		dev_err(&pdev->dev, "get normal code err=%d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = sp_iop_get_standby_code(&pdev->dev, iop);
> +	if (ret != 0) {
> +		dev_err(&pdev->dev, "get standby code err=%d\n", ret);
> +		return ret;
> +	}
> +
> +	sp_iop_run_normal_code(iop);
> +	platform_set_drvdata(pdev, iop);
> +	iop->gpio_wakeup = of_get_named_gpio(pdev->dev.of_node, "iop-wakeup", 0);
> +	iop_poweroff = iop;
> +	pm_power_off = sp_iop_poweroff;

Blank line. Before every such return. Please, open some recent drivers
and look at their code style.

> +	return 0;
> +
> +fail_kmalloc:
> +	return ret;
> +}
> +
> +static int sp_iop_remove(struct platform_device *pdev)
> +{
> +	pm_power_off = NULL;
> +	return 0;
> +}
> +
> +static const struct of_device_id sp_iop_of_match[] = {
> +	{ .compatible = "sunplus,sp7021-iop" },
> +	{ /* sentinel */ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, sp_iop_of_match);
> +
> +static struct platform_driver sp_iop_platform_driver = {
> +	.probe		= sp_iop_platform_driver_probe,
> +	.remove		= sp_iop_remove,
> +	.driver = {
> +		.name	= "sunplus,sp7021-iop",
> +		.of_match_table = sp_iop_of_match,
> +	}
> +};
> +
> +module_platform_driver(sp_iop_platform_driver);
> +
> +MODULE_AUTHOR("Tony Huang <tonyhuang.sunplus@gmail.com>");
> +MODULE_DESCRIPTION("Sunplus IOP Driver");
> +MODULE_LICENSE("GPL v2");


Best regards,
Krzysztof
