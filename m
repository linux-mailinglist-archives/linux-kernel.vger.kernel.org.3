Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED1851FCAA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbiEIM2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiEIM2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:28:39 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACBF1F68C1
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 05:24:45 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id x88so1457513pjj.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=y53b9ixDReppd2DWHYI1/PNfj9l8HObe8KfsvczAMsQ=;
        b=U1oxtxbQZhZSTbJeTmSJwLFOhHCEObIAZVF9vkC0YGECLm6L8COiYv6NEklZF28vnu
         FeCIZSq9yXJ5k4w3GsGVeteIK5D3SIneKGyim6JJDo3qtBT9f8LPramWEAQumQ5XUwzL
         PnsYQ7B4JHFBOrt36kYyhVGU82PWB4trUEIsa6UgW8KvNLDh5ytWDyrVqCC/NnGMQ6aj
         gK7SHKzsVjcqxwUtIYoVGLseRk72V6ckt9f25q8ACWHboxXOBrPAtJhNe0m+Msxq0gS7
         IDGVV+Zvcy9On7Gr4mfK2qckobmt99r7/aUBzdTrySWZCZ1avF8OZObQmCJj5imUQGKd
         64Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=y53b9ixDReppd2DWHYI1/PNfj9l8HObe8KfsvczAMsQ=;
        b=yBDQ0I84nemGgS+Qye52eWjYR6txp8/pS6UpNlIp3hKGdObLwrGSeldmGT8scmH92B
         iTExkatENCPd8CZnHJv8fM7/doHiMcMHUeTWGrHdl6XdnEsaxXpn1gZF0ogrMV+g3Xxs
         GDE0VW0iP04kPcX1ZZiI39nnAIK09Sag5NMZ0DeaLPyqdGJ/rK4MbPjwehkr8CNsx8sI
         TWhOVRyu547pecO5nqGOMTWdCmSN5740VTCGiHjkYwbloXmeFkevehEAWRgq3ihzNW8i
         pLxJX19o+xh3syXoAmXRqXmzdY38noTuu65xI/2In/2C53+U6ekymEQ+ar6qAk1R3pNV
         eG3Q==
X-Gm-Message-State: AOAM532QCxloblOEJj2jP40hsuEBRgzlmkUcO51DmHMl8LkIlvd2u6rv
        f+u2mC7JtldbT8Z6+aR+U6k=
X-Google-Smtp-Source: ABdhPJy6E0U3IUCDyLTg36y0+J95UyYMZig5qeSjmklEyJt7Z//M3aMgmSMgxO+vALApCVZKAyar/Q==
X-Received: by 2002:a17:902:bb02:b0:15e:d294:8d0f with SMTP id im2-20020a170902bb0200b0015ed2948d0fmr16261689plb.35.1652099084860;
        Mon, 09 May 2022 05:24:44 -0700 (PDT)
Received: from [172.30.1.40] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id ng17-20020a17090b1a9100b001da160621d1sm8806217pjb.45.2022.05.09.05.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 05:24:43 -0700 (PDT)
Message-ID: <e27ff1b2-c82f-8335-340f-ae1fa914ed30@gmail.com>
Date:   Mon, 9 May 2022 21:24:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/2] extcon: Add extcon-regulator driver
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org
References: <20220505232557.10936-1-zev@bewilderbeest.net>
 <20220505232557.10936-3-zev@bewilderbeest.net>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220505232557.10936-3-zev@bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zev,

I checked this patch. But, it doesn't look like the extcon provider
driver. Because basically, extcon provider driver need the circuit
in order to detect the kind of external connector. But, there are
no any code for detection. Just add the specific sysfs attribute
for only this driver. It is not standard interface.

Thanks,
Chanwoo Choi

On 22. 5. 6. 08:25, Zev Weiss wrote:
> This driver supports power connectors supplied by a regulator, such as
> outlets on a power distribution unit (PDU).
> 
> Its extcon functionality is currently quite limited, since the
> hardware it's initially targeting is very simple and doesn't really
> provide anything for the driver to interact with, but it can be
> extended as required for hardware that might offer more for it to do
> (e.g. a presence-detection mechanism).
> 
> Its sole feature is a read/write sysfs attribute allowing userspace to
> switch the output on and off by enabling and disabling the supply
> regulator.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>   .../ABI/testing/sysfs-driver-extcon-regulator |   8 ++
>   MAINTAINERS                                   |   8 ++
>   drivers/extcon/Kconfig                        |   8 ++
>   drivers/extcon/Makefile                       |   1 +
>   drivers/extcon/extcon-regulator.c             | 133 ++++++++++++++++++
>   5 files changed, 158 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-driver-extcon-regulator
>   create mode 100644 drivers/extcon/extcon-regulator.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-extcon-regulator b/Documentation/ABI/testing/sysfs-driver-extcon-regulator
> new file mode 100644
> index 000000000000..b2f3141a1c49
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-extcon-regulator
> @@ -0,0 +1,8 @@
> +What:		/sys/bus/platform/drivers/extcon-regulator/*/state
> +Date:		May 2022
> +KernelVersion:	5.18
> +Contact:	Zev Weiss <zev@bewilderbeest.net>
> +Description:	When read, provides the current power state of the connector,
> +		either "on" or "off".  Either string may also be written to
> +		set the power state of the connector.
> +Users:		OpenBMC <openbmc@lists.ozlabs.org>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index edc96cdb85e8..c30b6cf95ff1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16740,6 +16740,14 @@ F:	Documentation/devicetree/bindings/regmap/
>   F:	drivers/base/regmap/
>   F:	include/linux/regmap.h
>   
> +REGULATOR EXTCON DRIVER
> +M:	Zev Weiss <zev@bewilderbeest.net>
> +L:	openbmc@lists.ozlabs.org
> +S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-driver-extcon-regulator
> +F:	Documentation/devicetree/bindings/connector/regulator-connector.yaml
> +F:	drivers/extcon/extcon-regulator.c
> +
>   REISERFS FILE SYSTEM
>   L:	reiserfs-devel@vger.kernel.org
>   S:	Supported
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index 0d42e49105dd..19fe76da6c75 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -143,6 +143,14 @@ config EXTCON_QCOM_SPMI_MISC
>   	  Say Y here to enable SPMI PMIC based USB cable detection
>   	  support on Qualcomm PMICs such as PM8941.
>   
> +config EXTCON_REGULATOR
> +	tristate "Regulator output extcon support"
> +	depends on REGULATOR
> +	help
> +	  Say y here to enable support for regulator-supplied external
> +	  power output connections, such as the outlets of a power
> +	  distribution unit (PDU).
> +
>   config EXTCON_RT8973A
>   	tristate "Richtek RT8973A EXTCON support"
>   	depends on I2C
> diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
> index 1b390d934ca9..1a1c32d4b23e 100644
> --- a/drivers/extcon/Makefile
> +++ b/drivers/extcon/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_EXTCON_MAX8997)	+= extcon-max8997.o
>   obj-$(CONFIG_EXTCON_PALMAS)	+= extcon-palmas.o
>   obj-$(CONFIG_EXTCON_PTN5150)	+= extcon-ptn5150.o
>   obj-$(CONFIG_EXTCON_QCOM_SPMI_MISC) += extcon-qcom-spmi-misc.o
> +obj-$(CONFIG_EXTCON_REGULATOR)	+= extcon-regulator.o
>   obj-$(CONFIG_EXTCON_RT8973A)	+= extcon-rt8973a.o
>   obj-$(CONFIG_EXTCON_SM5502)	+= extcon-sm5502.o
>   obj-$(CONFIG_EXTCON_USB_GPIO)	+= extcon-usb-gpio.o
> diff --git a/drivers/extcon/extcon-regulator.c b/drivers/extcon/extcon-regulator.c
> new file mode 100644
> index 000000000000..eec1bb3f4c09
> --- /dev/null
> +++ b/drivers/extcon/extcon-regulator.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * extcon-regulator: extcon driver for regulator-supplied external power
> + * output connectors
> + *
> + * Copyright (C) 2022 Zev Weiss <zev@bewilderbeest.net>
> + */
> +
> +#include <linux/extcon-provider.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +
> +struct regulator_extcon_data {
> +	struct extcon_dev *edev;
> +	struct regulator *reg;
> +	struct mutex lock;
> +	unsigned int extcon_id;
> +};
> +
> +static ssize_t state_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct regulator_extcon_data *data = dev_get_drvdata(dev);
> +	int status = regulator_is_enabled(data->reg);
> +
> +	if (status < 0)
> +		return status;
> +
> +	return sysfs_emit(buf, "%s\n", status ? "on" : "off");
> +}
> +
> +static ssize_t state_store(struct device *dev, struct device_attribute *attr, const char *buf,
> +			   size_t count)
> +{
> +	int status, wantstate;
> +	struct regulator_extcon_data *data = dev_get_drvdata(dev);
> +	struct regulator *reg = data->reg;
> +
> +	if (sysfs_streq(buf, "on"))
> +		wantstate = 1;
> +	else if (sysfs_streq(buf, "off"))
> +		wantstate = 0;
> +	else
> +		return -EINVAL;
> +
> +	mutex_lock(&data->lock);
> +
> +	status = regulator_is_enabled(reg);
> +
> +	/*
> +	 * We need to ensure our enable/disable calls don't get imbalanced, so
> +	 * bail if we can't determine the current state.
> +	 */
> +	if (status < 0)
> +		goto out;
> +
> +	/* Nothing further needed if we're already in the desired state */
> +	if (!!status == wantstate) {
> +		status = 0;
> +		goto out;
> +	}
> +
> +	if (wantstate)
> +		status = regulator_enable(reg);
> +	else
> +		status = regulator_disable(reg);
> +
> +out:
> +	mutex_unlock(&data->lock);
> +
> +	return status ? : count;
> +}
> +
> +static DEVICE_ATTR_RW(state);
> +
> +static struct attribute *regulator_extcon_attrs[] = {
> +	&dev_attr_state.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(regulator_extcon);
> +
> +static int regulator_extcon_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct regulator_extcon_data *data;
> +	struct device *dev = &pdev->dev;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->reg = devm_regulator_get_exclusive(&pdev->dev, "vout");
> +	if (IS_ERR(data->reg))
> +		return PTR_ERR(data->reg);
> +
> +	mutex_init(&data->lock);
> +
> +	/* No cables currently supported */
> +	data->extcon_id = EXTCON_NONE;
> +
> +	data->edev = devm_extcon_dev_allocate(dev, &data->extcon_id);
> +	if (IS_ERR(data->edev))
> +		return PTR_ERR(data->edev);
> +
> +	ret = devm_extcon_dev_register(dev, data->edev);
> +	if (ret < 0)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id regulator_extcon_of_match_table[] = {
> +	{ .compatible = "regulator-connector" },
> +	{ },
> +};
> +
> +static struct platform_driver regulator_extcon_driver = {
> +	.driver = {
> +		.name = "extcon-regulator",
> +		.of_match_table = of_match_ptr(regulator_extcon_of_match_table),
> +		.dev_groups = regulator_extcon_groups,
> +	},
> +	.probe = regulator_extcon_probe,
> +};
> +module_platform_driver(regulator_extcon_driver);
> +
> +MODULE_AUTHOR("Zev Weiss <zev@bewilderbeest.net>");
> +MODULE_DESCRIPTION("Regulator extcon driver");
> +MODULE_LICENSE("GPL");
