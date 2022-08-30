Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3970C5A62DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiH3MIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiH3MIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:08:07 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A4C6C117
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:08:06 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m16so13904239wru.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=txqy7IQO4adVXLjCmBxiWt9FrkxitKDVktW9zB6/Sm0=;
        b=g//nI5O/Y/KJQSCTUTpEiWS6dJSa42IgP52RT+hemywKAxqRoyjX8pYJ24cixRkWYI
         GEDj2pCiprB0hRpChqywALjnyBpdy9LP3MR5VvmuhI9DH7IXfwLGofuotjN1Kh/RGX3j
         RnNaWh+adrEqWOcAUTTHOr6KhppcfLFkCRH0cum5EVFTbJoUEJ2rEmKN+pDzbf7nwj/w
         V7t+KkdnXEVbFDnJBaVxJmBWUKAUVegUW3XRxeqIpJvCPxyTiOXYaUmGVS7eOdIG0/ss
         URJ8FTgWx8CUHey0TpAbAnhy99RQwMk8IX/ZYz96cV0jHEM1gy7oX4oVYhuFKKC0UGCo
         5rMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=txqy7IQO4adVXLjCmBxiWt9FrkxitKDVktW9zB6/Sm0=;
        b=i0eUi7VGwvcSYAzlNco3RVhQRxuCS4Z3ej75fl8L4QpGDuP7v1kE4rKbCRW6qZdXAS
         4hKEBDxDgGz2YST5fsIoQmtGoTP4lEo7wyYAkUAdXw2ApwRe7X8mqfZwOt8MoX4EuvtO
         59ZIhsIEB9UIRO5JhUKCQCGlA03NVvAtD1SDmF+banpwpMcKXm2Ida11TvTIk/M7Ycpd
         1P5TQb995qRD2JoDaCvPjRXZ6anOguLNsWX4l/Rq57GYGjfKd4Z+4G2h2tLorotsqJzm
         8d6lCNZVphXAlFnNpHfQDqd3cW4vuZwqwDJr2MWzRd9py8U0A3wrkvxG3saCGyr5j/5R
         eBIw==
X-Gm-Message-State: ACgBeo2lcbgRTgOJputQzGwkmHzcuRVRFhyD+aCPkiecKpzV99GO/WkE
        1XcelZXxYmxxcrSy+8hPhe6LYWa65muyAQ==
X-Google-Smtp-Source: AA6agR7ENt6NZEpV9I2ZJp2WfCdYLW90CRY+gNQYrk08+S7A9SBlvu2Fic2vPHQAU7Nq+nJ1FiafuQ==
X-Received: by 2002:a05:6000:1d84:b0:224:f447:b1a7 with SMTP id bk4-20020a0560001d8400b00224f447b1a7mr8455663wrb.688.1661861284570;
        Tue, 30 Aug 2022 05:08:04 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id z7-20020a05600c0a0700b003a5c1e916c8sm3545673wmp.1.2022.08.30.05.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 05:08:04 -0700 (PDT)
Message-ID: <4788e399-b292-9da7-3d62-75bb0312d4b9@linaro.org>
Date:   Tue, 30 Aug 2022 13:08:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] nvmem: lan9662-otp: add support.
Content-Language: en-US
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        UNGLinuxDriver@microchip.com
References: <20220825204041.1485731-1-horatiu.vultur@microchip.com>
 <20220825204041.1485731-3-horatiu.vultur@microchip.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220825204041.1485731-3-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 25/08/2022 21:40, Horatiu Vultur wrote:
> Add support for OTP controller available on LAN9662. The OTPC controls
> the access to a non-volatile memory. The size of the memory is 8KB.
> The OTPC can access the memory based on an offset.
> Implement both the read and the write functionality.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>   drivers/nvmem/Kconfig        |   8 ++
>   drivers/nvmem/Makefile       |   2 +
>   drivers/nvmem/lan9662-otpc.c | 249 +++++++++++++++++++++++++++++++++++
>   3 files changed, 259 insertions(+)
>   create mode 100644 drivers/nvmem/lan9662-otpc.c
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 967d0084800e..c9929ec35a39 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -84,6 +84,14 @@ config NVMEM_LPC18XX_OTP
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called nvmem_lpc18xx_otp.
>   
> +config NVMEM_LAN9662_OTPC
> +	tristate "Microchip LAN9662 OTP controller support"
> +	depends on SOC_LAN966 || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This driver enables the OTP controller available on Microchip LAN9662
> +	  SoCs. It controlls the access to the OTP memory connected to it.
> +

s/controlls/controls/


>   config NVMEM_MXS_OCOTP
>   	tristate "Freescale MXS On-Chip OTP Memory Support"
>   	depends on ARCH_MXS || COMPILE_TEST
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index 00e136a0a123..e1baface2c53 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -21,6 +21,8 @@ obj-$(CONFIG_NVMEM_LPC18XX_EEPROM)	+= nvmem_lpc18xx_eeprom.o
>   nvmem_lpc18xx_eeprom-y	:= lpc18xx_eeprom.o
>   obj-$(CONFIG_NVMEM_LPC18XX_OTP)	+= nvmem_lpc18xx_otp.o
>   nvmem_lpc18xx_otp-y		:= lpc18xx_otp.o
> +obj-$(CONFIG_NVMEM_LAN9662_OTPC)	+= nvmem-lan9662-otpc.o
> +nvmem-lan9662-otpc-y		:= lan9662-otpc.o
>   obj-$(CONFIG_NVMEM_MXS_OCOTP)	+= nvmem-mxs-ocotp.o
>   nvmem-mxs-ocotp-y		:= mxs-ocotp.o
>   obj-$(CONFIG_NVMEM_NINTENDO_OTP)	+= nvmem-nintendo-otp.o
> diff --git a/drivers/nvmem/lan9662-otpc.c b/drivers/nvmem/lan9662-otpc.c
> new file mode 100644
> index 000000000000..302a5bae04dc
> --- /dev/null
> +++ b/drivers/nvmem/lan9662-otpc.c
> @@ -0,0 +1,249 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +#define OTP_OTP_PWR_DN(t)			(t + 0x00)
> +#define OTP_OTP_PWR_DN_OTP_PWRDN_N		BIT(0)
> +#define OTP_OTP_ADDR_HI(t)			(t + 0x04)
> +#define OTP_OTP_ADDR_LO(t)			(t + 0x08)
> +#define OTP_OTP_PRGM_DATA(t)			(t + 0x10)
> +#define OTP_OTP_PRGM_MODE(t)			(t + 0x14)
> +#define OTP_OTP_PRGM_MODE_OTP_PGM_MODE_BYTE	BIT(0)
> +#define OTP_OTP_RD_DATA(t)			(t + 0x18)
> +#define OTP_OTP_FUNC_CMD(t)			(t + 0x20)
> +#define OTP_OTP_FUNC_CMD_OTP_PROGRAM		BIT(1)
> +#define OTP_OTP_FUNC_CMD_OTP_READ		BIT(0)
> +#define OTP_OTP_CMD_GO(t)			(t + 0x28)
> +#define OTP_OTP_CMD_GO_OTP_GO			BIT(0)
> +#define OTP_OTP_PASS_FAIL(t)			(t + 0x2c)
> +#define OTP_OTP_PASS_FAIL_OTP_READ_PROHIBITED	BIT(3)
> +#define OTP_OTP_PASS_FAIL_OTP_WRITE_PROHIBITED	BIT(2)
> +#define OTP_OTP_PASS_FAIL_OTP_FAIL		BIT(0)
> +#define OTP_OTP_STATUS(t)			(t + 0x30)
> +#define OTP_OTP_STATUS_OTP_CPUMPEN		BIT(1)
> +#define OTP_OTP_STATUS_OTP_BUSY			BIT(0)
> +
> +#define OTP_MEM_SIZE 8192
> +#define OTP_SLEEP_US 10
> +#define OTP_TIMEOUT_US 500000
> +
> +struct lan9662_otp {
> +	struct device *dev;
> +	void __iomem *base;
> +};
> +
> +static inline void lan9662_writel(void __iomem *addr, u32 val)
> +{
> +	writel(val, addr);
> +}
> +
> +static inline u32 lan9662_readl(void __iomem *addr)
> +{
> +	return readl(addr);
> +}
> +

Why these boiler plate functions?

> +static inline void lan9662_clrbits(void __iomem *addr, u32 clear)
> +{
> +	writel(readl(addr) & ~clear, addr);
> +}
> +
> +static inline void lan9662_setbits(void __iomem *addr, u32 set)
> +{
> +	writel(readl(addr) | set, addr);
> +}

These two functions are called just once and I see no point in having a 
wrapper function for this, instead you could use them directly or use 
./include/linux/bitfield.h helper macros.

> +
> +static bool lan9662_otp_wait_flag_clear(void __iomem *reg, u32 flag)
> +{
> +	u32 val;
> +
> +	return readl_poll_timeout(reg, val, !(val & flag),
> +				  OTP_SLEEP_US, OTP_TIMEOUT_US);
> +}
> +
> +static int lan9662_otp_power(struct lan9662_otp *otp, bool up)
> +{
> +	if (up) {
> +		lan9662_clrbits(OTP_OTP_PWR_DN(otp->base),
> +				OTP_OTP_PWR_DN_OTP_PWRDN_N);
> +		if (lan9662_otp_wait_flag_clear(OTP_OTP_STATUS(otp->base),
> +						OTP_OTP_STATUS_OTP_CPUMPEN))
> +			return -ETIMEDOUT;
> +	} else {
> +		lan9662_setbits(OTP_OTP_PWR_DN(otp->base),
> +				OTP_OTP_PWR_DN_OTP_PWRDN_N);
> +	}
> +
> +	return 0;
> +}
> +
> +static int lan9662_otp_execute(struct lan9662_otp *otp)
> +{
> +	if (lan9662_otp_wait_flag_clear(OTP_OTP_CMD_GO(otp->base),
> +					OTP_OTP_CMD_GO_OTP_GO))
> +		return -ETIMEDOUT;
> +
> +	if (lan9662_otp_wait_flag_clear(OTP_OTP_STATUS(otp->base),
> +					OTP_OTP_STATUS_OTP_BUSY))
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static void lan9662_otp_set_address(struct lan9662_otp *otp, u32 offset)
> +{
> +	WARN_ON(offset >= OTP_MEM_SIZE);
> +
would we ever hit this condition? looks like unecessary check.



> +	lan9662_writel(OTP_OTP_ADDR_HI(otp->base), 0xff & (offset >> 8));
> +	lan9662_writel(OTP_OTP_ADDR_LO(otp->base), 0xff & offset);
> +}
> +
> +static int lan9662_otp_read_byte(struct lan9662_otp *otp, u32 offset, u8 *dst)
> +{
> +	u32 pass;
> +	int rc;
> +
> +	lan9662_otp_set_address(otp, offset);
> +	lan9662_writel(OTP_OTP_FUNC_CMD(otp->base),
> +		       OTP_OTP_FUNC_CMD_OTP_READ);
> +	lan9662_writel(OTP_OTP_CMD_GO(otp->base),
> +		       OTP_OTP_CMD_GO_OTP_GO);
Can be wrapped into single line.

> +	rc = lan9662_otp_execute(otp);
> +	if (!rc) {
> +		pass = lan9662_readl(OTP_OTP_PASS_FAIL(otp->base));
> +		if (pass & OTP_OTP_PASS_FAIL_OTP_READ_PROHIBITED)
> +			return -EACCES;
> +		*dst = (u8) lan9662_readl(OTP_OTP_RD_DATA(otp->base));
> +	}
> +	return rc;
> +}
> +

...

thanks,
srini
> +
> +static const struct of_device_id lan9662_otp_match[] = {
> +	{ .compatible = "microchip,lan9662-otp", },
> +	{ .compatible = "microchip,lan9668-otp", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, lan9662_otp_match);
> +
> +static struct platform_driver lan9662_otp_driver = {
> +	.probe = lan9662_otp_probe,
> +	.driver = {
> +		.name = "lan9662-otp",
> +		.of_match_table = lan9662_otp_match,
> +	},
> +};
> +module_platform_driver(lan9662_otp_driver);
> +
> +MODULE_AUTHOR("Horatiu Vultur <horatiu.vultur@microchip.com>");
> +MODULE_DESCRIPTION("lan9662 OTP driver");
> +MODULE_LICENSE("GPL");
