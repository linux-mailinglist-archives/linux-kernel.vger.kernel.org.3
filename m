Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571CD46EC43
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240500AbhLIPyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbhLIPyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:54:19 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860C3C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 07:50:45 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u1so10373336wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 07:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3CC2+Z6p/h9qiJ+Eyu7jSbZzM4S4qy9XqmndPZl7YoY=;
        b=mH0M/Ga7bXSSXzYtIi1/VHrNkGwoIgdNBe6NZy0cYWKHNJrhux09i7v1ksAH2uc2Qr
         TeBQvQ4Lgx4bQIpq/uKKX7fjvN0wcyyKMfFosLGhTgRVpO0Fjmu1mcfoexzbrlTppV7b
         FsumXcb8OpujtllmSxI0tM++uKD2XcNMsDjvV1YAHhB1LRgSbgVSOeGz0FOOKpSpSL0S
         Zhh0r4FCJn4867OpuRAS1EOJ4og885xxbqUOmXG1rsbvHwYjz3/1M2GAsCYvg6ru0vHg
         9KcqkXMVhYUbnyWjExIP7o3eefObl4KXfOFF2lC91syEetB5k8kqkndmR2qDqVdGvLMS
         n7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3CC2+Z6p/h9qiJ+Eyu7jSbZzM4S4qy9XqmndPZl7YoY=;
        b=TfGDr10fPsD62DbU965I+mpuzLl/zqyG5UcrHjh3UEBBQD5qZ9izRvF28giiU5R7eC
         BJYc2yp4Xuera5egqV9AewKmtPc13W59Vb6QXRT9+OKirqVpu+2XVNy/5vBXshQjMMbF
         7xS68BMdKbcooMd9cxJjnB4KneC6lCl/X+3bq8wOGJ8xr3kuxVw4+9j/iClm+NW2O4sp
         8cTCPyRETYQf1wi/zNwpIq4LkoCigZn6Lcc+6mTTlREZ2bKpwBKcPTdtkXZIUavD5YIr
         Zl/cSXwiPJym7mzlo5UOl+px9ivjwRv+xjpXVDKIAx6bdGJwqNfsLIYrc7TGEJQ+tdDL
         Qn1g==
X-Gm-Message-State: AOAM533FHGrV8ksKvhoNyOXcEbRM2rYtaJyyqbhcRR8w59dRL8ZG/8Lc
        alraalveQwZzVBbiM9GX/mgMAXwIhHyMFw==
X-Google-Smtp-Source: ABdhPJz/FMH3CFXSv12m0+XKr4odkgUzDciQT5IljvMKhXBtw4WTuyZm5s7pBrfG0B89ou9NvABxew==
X-Received: by 2002:adf:fb05:: with SMTP id c5mr7184988wrr.497.1639065044005;
        Thu, 09 Dec 2021 07:50:44 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id p12sm79970wro.33.2021.12.09.07.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 07:50:43 -0800 (PST)
Subject: Re: [PATCH v2 1/2] nvmem: Add driver for OCOTP in Sunplus SP7021
To:     Vincent Shih <vincent.sunplus@gmail.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
References: <1638867233-8383-1-git-send-email-vincent.sunplus@gmail.com>
 <1638867233-8383-2-git-send-email-vincent.sunplus@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1b336b98-7546-93e3-f1ed-92d041c2df35@linaro.org>
Date:   Thu, 9 Dec 2021 15:50:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638867233-8383-2-git-send-email-vincent.sunplus@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/12/2021 08:53, Vincent Shih wrote:
> Add driver for OCOTP in Sunplus SP7021
> 
> Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
> ---
> Changes in v2:
>   - Merge sunplus-ocotp.h and sunplus-ocotp0.c to sunplus-ocotp.c
>   - Clean up codes.
> 
>   MAINTAINERS                   |   5 +
>   drivers/nvmem/Kconfig         |  12 ++
>   drivers/nvmem/Makefile        |   2 +
>   drivers/nvmem/sunplus-ocotp.c | 268 ++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 287 insertions(+)
>   create mode 100644 drivers/nvmem/sunplus-ocotp.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 80eebc1..0e6593a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17947,6 +17947,11 @@ L:	netdev@vger.kernel.org
>   S:	Maintained
>   F:	drivers/net/ethernet/dlink/sundance.c
>   
> +SUNPLUS OCOTP DRIVER
> +M:	Vincent Shih <vincent.sunplus@gmail.com>
> +S:	Maintained
> +F:	drivers/nvmem/sunplus-ocotp.c
> +
>   SUPERH
>   M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>   M:	Rich Felker <dalias@libc.org>
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index da41461..fb053d6 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -300,4 +300,16 @@ config NVMEM_BRCM_NVRAM
>   	  This driver provides support for Broadcom's NVRAM that can be accessed
>   	  using I/O mapping.
>   
> +config NVMEM_SUNPLUS_OCOTP
> +	tristate "Sunplus SoC OTP support"
> +	depends on SOC_SP7021

COMPILE_TEST ?

> +	depends on HAS_IOMEM
> +	help
> +	  This is a driver for the On-chip OTP controller (OCOTP) available
> +	  on Sunplus SoCs. It provids access to 128 bytes of one-time

s/provids/provides

> +	  programmable eFuse.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nvmem-sunplus-ocotp.
> +
>   endif
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index dcbbde3..0f14cd9 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -61,3 +61,5 @@ obj-$(CONFIG_NVMEM_RMEM) 	+= nvmem-rmem.o
>   nvmem-rmem-y			:= rmem.o
>   obj-$(CONFIG_NVMEM_BRCM_NVRAM)	+= nvmem_brcm_nvram.o
>   nvmem_brcm_nvram-y		:= brcm_nvram.o
> +obj-$(CONFIG_NVMEM_SUNPLUS_OCOTP)	+= nvmem_sunplus_ocotp.o
> +nvmem_sunplus_ocotp-y		:= sunplus-ocotp.o
> diff --git a/drivers/nvmem/sunplus-ocotp.c b/drivers/nvmem/sunplus-ocotp.c
> new file mode 100644
> index 0000000..2997b29
> --- /dev/null
> +++ b/drivers/nvmem/sunplus-ocotp.c
> @@ -0,0 +1,268 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * The OCOTP driver for Sunplus	SP7021
> + *
> + * Copyright (C) 2019 Sunplus Technology Inc., All rights reseerved.

reserved ?

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +/*
> + * OTP memory
> + * Each bank contains 4 words (32 bits).
> + * Bank 0 starts at offset 0 from the base.
> + */
> +
> +#define OTP_WORDS_PER_BANK		4
> +#define OTP_WORD_SIZE			sizeof(u32)
> +#define OTP_BIT_ADDR_OF_BANK		(8 * OTP_WORD_SIZE * OTP_WORDS_PER_BANK)
> +#define QAC628_OTP_NUM_BANKS            8
> +#define QAC628_OTP_SIZE                 (QAC628_OTP_NUM_BANKS * OTP_WORDS_PER_BANK * OTP_WORD_SIZE)
> +#define OTP_READ_TIMEOUT                20000
> +
> +/* HB_GPIO */
> +#define ADDRESS_8_DATA			0x20
> +
> +/* OTP_RX */
> +#define OTP_CONTROL_2			0x48
> +#define OTP_RD_PERIOD			GENMASK(15, 8)
> +#define OTP_RD_PERIOD_MASK		~GENMASK(15, 8)
> +#define ONE_CPU_CLOCK			0x1
> +#define SEL_BAK_KEY2			BIT(5)
> +#define SEL_BAK_KEY2_MASK		~BIT(5)
> +#define SW_TRIM_EN			BIT(4)
> +#define SW_TRIM_EN_MASK			~BIT(4)
> +#define SEL_BAK_KEY			BIT(3)
> +#define SEL_BAK_KEY_MASK		~BIT(3)
> +#define OTP_READ			BIT(2)
> +#define OTP_LOAD_SECURE_DATA		BIT(1)
> +#define OTP_LOAD_SECURE_DATA_MASK	~BIT(1)
> +#define OTP_DO_CRC			BIT(0)
> +#define OTP_DO_CRC_MASK			~BIT(0)
> +#define OTP_STATUS			0x4c
> +#define OTP_READ_DONE			BIT(4)
> +#define OTP_READ_DONE_MASK		~BIT(4)
> +#define OTP_LOAD_SECURE_DONE_MASK	~BIT(2)
> +#define OTP_READ_ADDRESS		0x50
> +
> +enum base_type {
> +	HB_GPIO,
> +	OTPRX,
> +	BASEMAX,
> +};
> +
> +struct sp_otp_data_t {
> +	struct device *dev;
> +	void __iomem *base[BASEMAX];
> +	struct clk *clk;
> +	struct nvmem_config *config;

totally redundant to store config in this stucture as you will never use 
this after probe.

> +};
> +
> +struct sp_otp_vX_t {

does X needs to be caps?

> +	int size;
> +};
> +
> +const struct sp_otp_vX_t  sp_otp_v0 = {
> +	.size = QAC628_OTP_SIZE,
> +};
> +
> +static int sp_otp_wait(void __iomem *reg_base)
> +{
> +	int timeout = OTP_READ_TIMEOUT;
> +	unsigned int status;
> +
> +	do {
> +		usleep_range(10);

Doesn't this take two arguments?

> +		if (timeout-- == 0)
> +			return -ETIMEDOUT;
> +
> +		status = readl(reg_base + OTP_STATUS);
> +	} while ((status & OTP_READ_DONE) != OTP_READ_DONE);
> +
> +	return 0;
> +}
> +
> +static int sp_otp_read_real(struct sp_otp_data_t *otp, int addr, char *value)
> +{
> +	unsigned int addr_data;
> +	unsigned int byte_shift;
> +	int ret = 0;

unnecessary initializatoin here.

> +
> +	addr_data = addr % (OTP_WORD_SIZE * OTP_WORDS_PER_BANK);
> +	addr_data = addr_data / OTP_WORD_SIZE;
> +
> +	byte_shift = addr % (OTP_WORD_SIZE * OTP_WORDS_PER_BANK);
> +	byte_shift = byte_shift % OTP_WORD_SIZE;
> +
> +	addr = addr / (OTP_WORD_SIZE * OTP_WORDS_PER_BANK);
> +	addr = addr * OTP_BIT_ADDR_OF_BANK;
> +
> +	writel(readl(otp->base[OTPRX] + OTP_STATUS) & OTP_READ_DONE_MASK &
> +		     OTP_LOAD_SECURE_DONE_MASK, otp->base[OTPRX] + OTP_STATUS);
> +	writel(addr, otp->base[OTPRX] + OTP_READ_ADDRESS);
> +	writel(readl(otp->base[OTPRX] + OTP_CONTROL_2) | OTP_READ,
> +	       otp->base[OTPRX] + OTP_CONTROL_2);
> +	writel(readl(otp->base[OTPRX] + OTP_CONTROL_2) & SEL_BAK_KEY2_MASK & SW_TRIM_EN_MASK
> +	       & SEL_BAK_KEY_MASK & OTP_LOAD_SECURE_DATA_MASK & OTP_DO_CRC_MASK,
> +	       otp->base[OTPRX] + OTP_CONTROL_2);
> +	writel((readl(otp->base[OTPRX] + OTP_CONTROL_2) & OTP_RD_PERIOD_MASK) |
> +	       ((ONE_CPU_CLOCK * 0x1e) << 8), otp->base[OTPRX] + OTP_CONTROL_2);
> +
> +	ret = sp_otp_wait(otp->base[OTPRX]);
> +	if (ret < 0)
> +		return ret;
> +
> +	*value = (readl(otp->base[HB_GPIO] + ADDRESS_8_DATA + addr_data * OTP_WORD_SIZE)
> +			>> (8 * byte_shift)) & 0xFF;
> +
> +	return ret;
> +}
> +
> +static int sp_ocotp_read(void *priv, unsigned int offset, void *value, size_t bytes)
> +{
> +	struct sp_otp_data_t *otp = priv;
> +	unsigned int addr;
> +	char *buf = value;
> +	char val[4];
> +	int ret;
> +
> +	dev_dbg(otp->dev, "OTP read %u bytes at %u", bytes, offset);
> +
why do we need all these debug ?

> +	if (offset >= QAC628_OTP_SIZE || bytes == 0 || ((offset + bytes) > QAC628_OTP_SIZE))
> +		return -EINVAL;

Core should already do this sanity test, if not these checks belong to 
nvmem core.

> +
> +	ret = clk_enable(otp->clk);
> +	if (ret)
> +		return ret;
> +
> +	*buf = 0;
> +	for (addr = offset; addr < (offset + bytes); addr++) {
> +		ret = sp_otp_read_real(otp, addr, val);
> +		if (ret < 0) {
> +			dev_err(otp->dev, "OTP read fail:%d at %d", ret, addr);
> +			goto disable_clk;
> +		}
> +
> +		*buf++ = *val;
> +	}
> +
> +disable_clk:
> +	clk_disable(otp->clk);
> +	dev_dbg(otp->dev, "OTP read complete");
> +
> +	return ret;
> +}
> +
> +static struct nvmem_config sp_ocotp_nvmem_config = {
> +	.name = "sp-ocotp",
> +	.read_only = true,
> +	.word_size = 1,
> +	.size = QAC628_OTP_SIZE,
> +	.stride = 1,
> +	.reg_read = sp_ocotp_read,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int sp_ocotp_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match;
> +	const struct sp_otp_vX_t *sp_otp_vX;
> +	struct device *dev = &pdev->dev;
> +	struct nvmem_device *nvmem;
> +	struct sp_otp_data_t *otp;
> +	struct resource *res;
> +	int ret;
> +

<---
> +	match = of_match_device(dev->driver->of_match_table, dev);
> +	if (match && match->data)
> +		sp_otp_vX = match->data;
> +	else
> +		dev_err(dev, "OTP vX does not match");
--->

This looks like dead code, variable is set but not used anywhere.
Error case is ignored.


> +
> +	otp = devm_kzalloc(dev, sizeof(*otp), GFP_KERNEL);
> +	if (!otp)
> +		return -ENOMEM;
> +
> +	otp->dev = dev;
> +	otp->config = &sp_ocotp_nvmem_config;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hb_gpio");
> +	otp->base[HB_GPIO] = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(otp->base[HB_GPIO]))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(otp->base[HB_GPIO]),
> +						"hb_gpio devm_ioremap_resource fail\n");

printing error here is totally redundant.

you could just do

if (IS_ERR(otp->base[HB_GPIO]))
	return PTR_ERR(otp->base[HB_GPIO]);


> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otprx");
> +	otp->base[OTPRX] = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(otp->base[OTPRX]))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(otp->base[OTPRX]),
> +						"otprx devm_ioremap_resource fail\n");
> +
same here,

> +	otp->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(otp->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(otp->clk),
> +						"devm_clk_get fail\n");
> +
> +	ret = clk_prepare(otp->clk);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to prepare clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	sp_ocotp_nvmem_config.priv = otp;
> +	sp_ocotp_nvmem_config.dev = dev;
> +
> +	nvmem = devm_nvmem_register(dev, &sp_ocotp_nvmem_config);
> +	if (IS_ERR(nvmem))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(nvmem),
> +						"register nvmem device fail\n");
> +
> +	platform_set_drvdata(pdev, nvmem);
> +
> +	dev_dbg(dev, "banks:%d x wpb:%d x wsize:%d = %d",
> +		QAC628_OTP_NUM_BANKS, OTP_WORDS_PER_BANK,
> +		OTP_WORD_SIZE, QAC628_OTP_SIZE);
> +
> +	dev_info(dev, "by Sunplus (C) 2020");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sp_ocotp_dt_ids[] = {
> +	{ .compatible = "sunplus,sp7021-ocotp", .data = &sp_otp_v0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sp_ocotp_dt_ids);
> +
> +static struct platform_driver sp_otp_driver = {
> +	.probe     = sp_ocotp_probe,
> +	.driver    = {
> +		.name           = "sunplus,sp7021-ocotp",
> +		.of_match_table = sp_ocotp_dt_ids,
> +	}
> +};
> +
> +static int __init sp_otp0_drv_new(void)
> +{
> +	return platform_driver_register(&sp_otp_driver);
> +}
> +subsys_initcall(sp_otp0_drv_new);

Why this needs to be subsys_initcall() why can't it be module_init?


> +
> +static void __exit sp_otp0_drv_del(void)
> +{
> +	platform_driver_unregister(&sp_otp_driver);
> +}
> +module_exit(sp_otp0_drv_del);
> +
> +MODULE_AUTHOR("Vincent Shih <vincent.sunplus@gmail.com>");
> +MODULE_DESCRIPTION("Sunplus On-Chip OTP driver");
> +MODULE_LICENSE("GPL v2");

Just GPL should be good here.

--srini
> +
> 
