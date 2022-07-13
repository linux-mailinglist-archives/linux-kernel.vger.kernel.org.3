Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD0C572ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiGMHLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiGMHLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:11:15 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22245C1C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:11:12 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a9so17595145lfk.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pj6NgNKL4vAnlMFEcNMerErEfaDWIKDLQ90CHB7mEkg=;
        b=EohwjlrL16Uok9V2KQFx43UgaO8SLmskdUaV77yOytm5x1aF5r52AppDHxIKxHJyYY
         i9aYxOkgb0pxz74b8kTsErFArSpkYM8HVzoeCHQM3IMJ42zF7bPfnAESXm5rl2YwCVmt
         eivyvceuzsti0C0vt85l3bEg9c3lDJRnV3zfJMEOAewIxOnap8Ci3D2j0gEAauB+eNyv
         nEfX/S5AKg6nbhnaf/twxssiNMWK5j9TCMUAuqa5V7wRWRNeKT5toWn6XLm4xzhJ9UMR
         d7Mk593F0TV4ee3tc9YL2BsCvthiN5RxbB3c1Vpb5jCiUIIGMOJg5Y8XmZncmgDhxjOr
         FaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pj6NgNKL4vAnlMFEcNMerErEfaDWIKDLQ90CHB7mEkg=;
        b=aa0ik6u/huL9fDFwPM3oNzlrKuo3ViZ5jwU6Ys2WQkfuMlHjM+V4PG6QeWf9Oh4xiS
         AV6nw183kwm6ZRUJWeigboqf+LrpQaHubrvJyp4vovxqp594OP8NS1RUrEj17aALRu5d
         43i614EiJhyJceDvZTFYdHICqJ2JnCCUgKAgxfMBEUoOWTeOgRvEzadEnz+kfEVvpn5x
         +bzvAEN8LUJRF0sazYLlRZSe3jr5VwRF0DsDTKkGBnf4Q0LHVR64Sg1tPGFK7xh3LmOm
         OzK3vYU89ARP5wQ2RkMg6cyYmhNTDovwo8bjxIRNwNQ1LrxjIe/YGTRzaqD7jSfckKaE
         aJ3w==
X-Gm-Message-State: AJIora9JfdbOcZqbDu7AuKVlewjfFgVIOt2a773+xMacNeug1BoYvb8e
        onb934YwA5GG2COlB8kmSt8Dhg==
X-Google-Smtp-Source: AGRyM1vi7x/hjfQbmDniqJ+s3bTFZlCFmSPr57pwq2zLgg7t5VzvrbeCTb8QaRc2n0nYNNF1uNEihQ==
X-Received: by 2002:a05:6512:10d2:b0:489:e71e:cce9 with SMTP id k18-20020a05651210d200b00489e71ecce9mr1082505lfg.656.1657696270458;
        Wed, 13 Jul 2022 00:11:10 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id k3-20020ac257c3000000b0047255d211d7sm2615951lfo.262.2022.07.13.00.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 00:11:09 -0700 (PDT)
Message-ID: <aec4ffd0-368d-e71a-06e4-a084138fbab9@linaro.org>
Date:   Wed, 13 Jul 2022 09:11:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/4] firmware: Samsung: Add secure monitor driver
Content-Language: en-US
To:     dj76.yang@samsung.com,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
Cc:     "javierm@redhat.com" <javierm@redhat.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Wangseok Lee <wangseok.lee@samsung.com>
References: <CGME20220713045516epcms1p86b3f6a8795d767faac65eb947405f911@epcms1p8>
 <20220713045516epcms1p86b3f6a8795d767faac65eb947405f911@epcms1p8>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220713045516epcms1p86b3f6a8795d767faac65eb947405f911@epcms1p8>
Content-Type: text/plain; charset=UTF-8
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

On 13/07/2022 06:55, Dongjin Yang wrote:
> Introduce a driver to provide calls into secure monitor mode.
> This driver is used for SoCs produced by Samsung Foundry to provide
> SMC call. This patch supports register read/write request to secure
> monitor. Also, SMC call request which uses shared memory to exchange
> the data between kernel and secure monitor.
> 
> Signed-off-by: Dongjin Yang <dj76.yang@samsung.com>
> ---
>  MAINTAINERS                              |   2 +
>  drivers/firmware/Kconfig                 |  11 +++
>  drivers/firmware/Makefile                |   1 +
>  drivers/firmware/samsung-smc-svc.c       | 154 +++++++++++++++++++++++++++++++
>  include/linux/firmware/samsung-smc-svc.h |  59 ++++++++++++
>  5 files changed, 227 insertions(+)
>  create mode 100644 drivers/firmware/samsung-smc-svc.c
>  create mode 100644 include/linux/firmware/samsung-smc-svc.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6763746c349f..d173043ffb46 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1868,8 +1868,10 @@ F:	arch/arm/boot/dts/artpec6*
>  F:	arch/arm/mach-artpec
>  F:	drivers/clk/axis
>  F:	drivers/crypto/axis
> +F:	drivers/firmware/samsung-smc-svc.c
>  F:	drivers/mmc/host/usdhi6rol0.c
>  F:	drivers/pinctrl/pinctrl-artpec*
> +F:	include/linux/firmware/samsung-smc-svc.h

Same as for bindings - not related to Artpec platforms. Either add
dedicated entry or put it under Samsung SoC.

>  
>  ARM/ASPEED I2C DRIVER
>  M:	Brendan Higgins <brendanhiggins@google.com>
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index e5cfb01353d8..4b0f2d033f58 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -217,6 +217,17 @@ config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
>  
>  	  Say Y here to enable "download mode" by default.
>  
> +config SAMSUNG_SECURE_SERVICE
> +	bool "Samsung Foundry Secure Service Layer"
> +	depends on HAVE_ARM_SMCCC
> +	default n
> +	help
> +	  Support secure service layer for SoCs which is manufactured by
> +	  Samsung Foundry.
> +
> +	  This option provide support of secure monitor service call using
> +	  Trusted Foundations.
> +
>  config SYSFB
>  	bool
>  	default y
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 4e58cb474a68..985e30a9665f 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
>  obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
>  obj-$(CONFIG_QCOM_SCM)		+= qcom-scm.o
>  qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
> +obj-$(CONFIG_SAMSUNG_SECURE_SERVICE) += samsung-smc-svc.o
>  obj-$(CONFIG_SYSFB)		+= sysfb.o
>  obj-$(CONFIG_SYSFB_SIMPLEFB)	+= sysfb_simplefb.o
>  obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
> diff --git a/drivers/firmware/samsung-smc-svc.c b/drivers/firmware/samsung-smc-svc.c
> new file mode 100644
> index 000000000000..eb3a5285cf2b
> --- /dev/null
> +++ b/drivers/firmware/samsung-smc-svc.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 Samsung Electronics Co., Ltd.
> + * Author: Kihyun Yoon<kihyun.yoon@samsung.com>
> + * Author: Dongjin Yang<dj76.yang@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *

Drop boiler plate with trailing empty '*' comment.

> + */
> +
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/firmware/samsung-smc-svc.h>

Order the headers by name.

> +
> +struct samsung_smc_version {
> +	u32 major;
> +	u32 minor;
> +};
> +
> +struct samsung_smc_data {
> +	struct samsung_smc_version version;
> +	u32 svc_cmd_list[SAMSUNG_SIP_NR_SIP];
> +};
> +
> +struct samsung_smc_data *svc_data;

No, no globals. Even no static variables.

> +
> +static int samsung_smc_svc_init(void);
> +
> +static int __samsung_get_svc_cmd(u32 cmd_idx)
> +{
> +	if (cmd_idx >= SAMSUNG_SIP_NR_SIP)
> +		return SAMSUNG_SIP_NOT_SUPPORTED;
> +
> +	/* Initialize this driver if it is not ready */
> +	if (!svc_data && samsung_smc_svc_init()) {
> +		pr_err("samsung,smccc_service initialization is failed\n");
> +		return SAMSUNG_SIP_NOT_SUPPORTED;
> +	}
> +
> +	return svc_data->svc_cmd_list[cmd_idx];
> +}
> +
> +int samsung_smc_call(u32 cmd_idx,
> +		     unsigned long a0, unsigned long a1,
> +		     unsigned long a2, unsigned long a3,
> +		     u32 *val)
> +
> +{
> +	struct arm_smccc_res res;
> +	u32 cmd = __samsung_get_svc_cmd(cmd_idx);
> +
> +	if (cmd == SAMSUNG_SIP_NOT_SUPPORTED)
> +		return -EOPNOTSUPP;
> +
> +	arm_smccc_smc(cmd, a0, a1, a2, a3, 0, 0, 0, &res);
> +	if (res.a0 == SMCCC_RET_NOT_SUPPORTED)
> +		return -EINVAL;
> +
> +	if (val)
> +		*val = (u32)res.a1;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(samsung_smc_call);

EXPORT_SYMBOL_GPL

You need kerneldoc for all these.

> +
> +int samsung_smc_reg_read(void *base, u32 reg, u32 *val)
> +{
> +	return samsung_smc_call(SAMSUNG_SIP_READ_REG,
> +				(unsigned long)base, reg, 0, 0, val);
> +}
> +EXPORT_SYMBOL(samsung_smc_reg_read);
> +
> +int samsung_smc_reg_write(void *base, u32 reg, u32 val)
> +{
> +	return samsung_smc_call(SAMSUNG_SIP_WRITE_REG,
> +				  (unsigned long)base, reg, val, 0, NULL);
> +}
> +EXPORT_SYMBOL(samsung_smc_reg_write);
> +
> +static int samsung_smc_check_version(struct samsung_smc_version *ver)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(SAMSUNG_SIP_SVC_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
> +
> +	if ((u32)res.a0 != ver->major || (u32)res.a1 != ver->minor)
> +		return -EINVAL;
> +
> +	pr_info("Samsung SVC version [%d.%d] is detected\n",
> +		ver->major, ver->minor);
> +
> +	return 0;
> +}
> +
> +static const struct samsung_smc_data svc_0_1 = {
> +	.version = {
> +		.major = 0,
> +		.minor = 1
> +	},
> +	.svc_cmd_list = {
> +		[SAMSUNG_SIP_READ_REG] = 0x82000020,
> +		[SAMSUNG_SIP_WRITE_REG] = 0x82000021,
> +		/* TODO: SMC call for clock driver should be added */
> +	}
> +};
> +
> +static const struct of_device_id samsung_smc_of_match[] = {
> +	{ .compatible = "samsung,smccc-svc", .data = &svc_0_1 },
> +	{ /* sentinel */ }
> +};
> +
> +static int samsung_smc_svc_init(void)
> +{
> +	struct device_node *fw_np;
> +	struct device_node *np;
> +	const struct of_device_id *match;
> +	int ret;
> +
> +	if (svc_data) {
> +		pr_info("samsung,smccc_service is already initialized\n");
> +		return 0;
> +	}
> +
> +	fw_np = of_find_node_by_name(NULL, "firmware");
> +	if (!fw_np)
> +		return -ENODEV;
> +
> +	np = of_find_matching_node_and_match(fw_np, samsung_smc_of_match,
> +					     &match);
> +	if (!np)
> +		return -ENODEV;
> +
> +	svc_data = (struct samsung_smc_data *)match->data;
> +	if (!svc_data)
> +		return -ENODEV;
> +
> +	ret = samsung_smc_check_version(&svc_data->version);
> +	if (ret) {
> +		pr_err("samsung svc version is not matched\n");
> +		return ret;
> +	}
> +
> +	pr_info("samsung smc svc is initialized\n");

No useless success printks. We have tracing and sysfs for that.

> +	return 0;
> +}
> +
> +early_initcall(samsung_smc_svc_init);

No. Make it a platform driver.

> diff --git a/include/linux/firmware/samsung-smc-svc.h b/include/linux/firmware/samsung-smc-svc.h
> new file mode 100644
> index 000000000000..9c94fd3e10a2
> --- /dev/null
> +++ b/include/linux/firmware/samsung-smc-svc.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __SAMSUNG_SMC_H
> +#define __SAMSUNG_SMC_H

Extend the header gaurd to match path.

> +
> +#include <linux/arm-smccc.h>
> +
> +#ifdef CONFIG_SAMSUNG_SECURE_SERVICE

No ifdefs in headers. This is not a subsystem.

> +
> +#define SAMSUNG_SIP_CALL_VAL(x) \
> +		ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
> +		ARM_SMCCC_SMC_32, ARM_SMCCC_OWNER_SIP, x)

Need kerneldoc.

> +
> +/* Common SIP SVC number */
> +#define SAMSUING_SIP_SVC_CALL_COUNT	SAMSUNG_SIP_CALL_VAL(0xff00)
> +#define SAMSUING_SIP_SVC_UID		SAMSUNG_SIP_CALL_VAL(0xff01)
> +#define SAMSUNG_SIP_SVC_VERSION		SAMSUNG_SIP_CALL_VAL(0xff03)
> +#define SAMSUNG_SIP_NOT_SUPPORTED	0x0

Need kerneldoc.


> +
> +enum {
> +	/* SIP enumeration for V0.1 */
> +	SAMSUNG_SIP_READ_REG,
> +	SAMSUNG_SIP_WRITE_REG,
> +	/* Add here for later version */
> +	SAMSUNG_SIP_NR_SIP
> +};

Need kerneldoc.


> +
> +int samsung_smc_call(u32 cmd_idx,
> +		     unsigned long a0, unsigned long a1,
> +		     unsigned long a2, unsigned long a3,
> +		     u32 *val);
> +int samsung_smc_reg_read(void *addr, unsigned int reg, u32 *val);
> +int samsung_smc_reg_write(void *addr, unsigned int reg, u32 val);
> +

Need kerneldoc in the driver.


> +#else
> +

No stubs, no ifdefs. It's not a subsystem.



Best regards,
Krzysztof
