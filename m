Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BD0475A29
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243043AbhLON6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237655AbhLON6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:58:52 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B2EC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 05:58:51 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t26so2049894wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 05:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=TqEc5n7d35qtPSsCSbkwAvBwmMC8o+HYErb7IhcRicM=;
        b=Gf1bjIuOhSkiOyLdUSL9ZYPLQVIHUwl8oo14UhcOoZFYxI6YhFOwXhH7pXPjDvYfEw
         tCUZd/AFFccni8UH0r2NX4/X1zAy2KITDymhsTimr5Larm14dq9DXLVDtu96ailQ+fvy
         b5pqCRgaN65wPxW5kd8NLBb1pLJrC+6OiC+tuwljWho8R/bvnQ04zhPp+LH1EtK9iv49
         JgpftPG37PM7zm9pcUvO2ezDlIyzIWgeal0DgDqZeA1BObSRUsb4qT48FtGlG5ZO+vjQ
         NA9FhvhdrPfFKEQpwYdnwKKiJIZGGzuB6jC2UID3bmIPtlMVSZyK9/JCc/VK8m/kniI8
         /CGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TqEc5n7d35qtPSsCSbkwAvBwmMC8o+HYErb7IhcRicM=;
        b=U3wy/HNOfvpt3mspzdbAOjI6iVH+IIlXQlnwsuuoVl+vaIzMOQ+cQGjpvAtwLvpNKv
         /lPvwNdf53jGsBbY9MZOf2c1MCenjDFqOmiR2smOHC5DQsa2J9wMBnEpGSGi5q7SPKhC
         iVBQ3lUJUWZIcnu5vdTwflWSw0TSxph8ocsCVeX19xxcNGSIK4hlSgnSMBXVDIpKXIOI
         EZ51e8YcWjzA5GQTRBZ3WnDsTM6DDCf96DrrwUClPILsAi9xKiPg060vtUUd4JCONY6J
         mRwQrsCFB/DXKZh5fJ4ABLp6l/6892pVVInrOhBFnHmsoWJCjuE7XgzbyrA0+3iaR+cq
         sJcA==
X-Gm-Message-State: AOAM533x60A+1rwzeP/SnNEI1A1Y6XYXUMc21PDj0DbLbvTfk8eNW7il
        C0Pd1Pn55Vky0D+j1Ou9dHYJc9gA2x3/AQ==
X-Google-Smtp-Source: ABdhPJyBoX9EGe5vY7msnrYkPfO14lPH8rDfDMPSQ6YpeiEaAsvXckk3fWkEqoutMOnA7sjQRfyiEw==
X-Received: by 2002:a5d:60d1:: with SMTP id x17mr4477982wrt.208.1639576730438;
        Wed, 15 Dec 2021 05:58:50 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id q8sm2069182wrx.71.2021.12.15.05.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 05:58:49 -0800 (PST)
Subject: Re: [PATCH v3 1/2] nvmem: Add driver for OCOTP in Sunplus SP7021
To:     Vincent Shih <vincent.sunplus@gmail.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com,
        vincent.shih@sunplus.com
References: <1639568148-22872-1-git-send-email-vincent.sunplus@gmail.com>
 <1639568148-22872-2-git-send-email-vincent.sunplus@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d1e940fb-80fb-4507-d950-f7c8db3ad3bb@linaro.org>
Date:   Wed, 15 Dec 2021 13:58:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1639568148-22872-2-git-send-email-vincent.sunplus@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/12/2021 11:35, Vincent Shih wrote:
> Add driver for OCOTP in Sunplus SP7021
> 
> Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
> ---
> Changes in v3:
>   - Addressed the comments by Mr. Srinivas Kandagatla.
>   - Replaced sp_otp_wait() with readl_poll_timeout().
> 
>   MAINTAINERS                   |   5 +
>   drivers/nvmem/Kconfig         |  12 +++
>   drivers/nvmem/Makefile        |   2 +
>   drivers/nvmem/sunplus-ocotp.c | 244 ++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 263 insertions(+)
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
> index da41461..4559950 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -300,4 +300,16 @@ config NVMEM_BRCM_NVRAM
>   	  This driver provides support for Broadcom's NVRAM that can be accessed
>   	  using I/O mapping.
>   
> +config NVMEM_SUNPLUS_OCOTP
> +	tristate "Sunplus SoC OTP support"
> +	depends on SOC_SP7021 || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This is a driver for the On-chip OTP controller (OCOTP) available
> +	  on Sunplus SoCs. It provides access to 128 bytes of one-time
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
> index 0000000..cbaeaf3
> --- /dev/null
> +++ b/drivers/nvmem/sunplus-ocotp.c
> @@ -0,0 +1,244 @@
> +// SPDX-License-Identifier: GPL-2.0
...

> +};
> +
> +static int sp_otp_read_real(struct sp_ocotp_priv *otp, int addr, char *value)
> +{
> +	unsigned int addr_data;
> +	unsigned int byte_shift;
> +	unsigned int status;
> +	int ret;
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
> +	       OTP_LOAD_SECURE_DONE_MASK, otp->base[OTPRX] + OTP_STATUS);
> +	writel(addr, otp->base[OTPRX] + OTP_READ_ADDRESS);
> +	writel(readl(otp->base[OTPRX] + OTP_CONTROL_2) | OTP_READ,
> +	       otp->base[OTPRX] + OTP_CONTROL_2);
> +	writel(readl(otp->base[OTPRX] + OTP_CONTROL_2) & SEL_BAK_KEY2_MASK & SW_TRIM_EN_MASK
> +	       & SEL_BAK_KEY_MASK & OTP_LOAD_SECURE_DATA_MASK & OTP_DO_CRC_MASK,
> +	       otp->base[OTPRX] + OTP_CONTROL_2);
> +	writel((readl(otp->base[OTPRX] + OTP_CONTROL_2) & OTP_RD_PERIOD_MASK) |
> +	       ((ONE_CPU_CLOCK * 0x1e) << 8), otp->base[OTPRX] + OTP_CONTROL_2);

these magic values need a proper define

> +
> +	ret = readl_poll_timeout(otp->base[OTPRX] + OTP_STATUS, status,
> +				 status & OTP_READ_DONE, 10, OTP_READ_TIMEOUT_US);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	*value = (readl(otp->base[HB_GPIO] + ADDRESS_8_DATA + addr_data * OTP_WORD_SIZE)
> +		  >> (8 * byte_shift)) & 0xff;
> +
> +	return ret;
> +}
> +
> +static int sp_ocotp_read(void *priv, unsigned int offset, void *value, size_t bytes)
> +{
> +	struct sp_ocotp_priv *otp = priv;
> +	unsigned int addr;
> +	char *buf = value;
> +	char val[4];
> +	int ret;
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
> +	const struct sp_ocotp_data *otp_data;
> +	struct device *dev = &pdev->dev;
> +	struct nvmem_device *nvmem;
> +	struct sp_ocotp_priv *otp;
> +	struct resource *res;
> +	int ret;
> +
> +	match = of_match_device(dev->driver->of_match_table, dev);
> +	if (match && match->data)
> +		otp_data = match->data;

this looks like dead code, otp_data is never used anywhere in the code.

> +
> +	otp = devm_kzalloc(dev, sizeof(*otp), GFP_KERNEL);
> +	if (!otp)
> +		return -ENOMEM;
> +
> +	otp->dev = dev;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hb_gpio");
> +	otp->base[HB_GPIO] = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(otp->base[HB_GPIO]))
> +		return PTR_ERR(otp->base[HB_GPIO]);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otprx");
> +	otp->base[OTPRX] = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(otp->base[OTPRX]))
> +		return PTR_ERR(otp->base[OTPRX]);
> +
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

<---
> +static int __init sp_otp0_drv_new(void)
> +{
> +	return platform_driver_register(&sp_otp_driver);
> +}
> +module_init(sp_otp0_drv_new);
> +
> +static void __exit sp_otp0_drv_del(void)
> +{
> +	platform_driver_unregister(&sp_otp_driver);
> +}
> +module_exit(sp_otp0_drv_del);
--->

use
  module_platform_driver(sp_otp_driver);


--srini

> +
> +MODULE_AUTHOR("Vincent Shih <vincent.sunplus@gmail.com>");
> +MODULE_DESCRIPTION("Sunplus On-Chip OTP driver");
> +MODULE_LICENSE("GPL");
> +
> 
