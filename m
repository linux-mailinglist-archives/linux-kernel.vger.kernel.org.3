Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A57458C51F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 10:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbiHHI4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 04:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241999AbiHHIzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 04:55:33 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C3E13E93
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 01:55:06 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id r17so11643611lfm.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 01:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cPqwRWeE4/S1JD/fo4jnPHpdXgNZooH7iDuF5yuHS48=;
        b=Q7BydZJCDPleJlvg9vnOY3J+jYXEXN8MbtGHOTs9nrX/4ib75vxDYNvptqLlitUEPZ
         1udIlx2bidHQhMrEAMZCeYCCL3MEyqQozTawiRUnxqWAe+exh1HbthYt0B1Az4keyrUM
         WDwTKplaCCZZ+gC94a3sFy2zdIGMn7NfKPY4fZqmDm6Emy0hO5FDLNpUF5GwTS5tgAtH
         i6cthbFe0Mf886pwfe+LB867e/r6ut/TC9CzjSLbwjT8ZVjmdET1C4Goz4/cTn2iIN4h
         8cFXzKBTDMrwaT8HtYwBmFGSuzOHGGI+/CUAQyPkb7tBWc/0F70Rp/3NCDEN80BTJ9US
         loSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cPqwRWeE4/S1JD/fo4jnPHpdXgNZooH7iDuF5yuHS48=;
        b=aV1iAxLB2qK+8+kJsYE8M3G0S6dyhEFqofpyEW/4ZD+qUQYuV/KNg+/f7EGKG0RTFe
         chayjpZHT+UxWztPbB0hOXOhAqoDK5uA0BKuC7rsDJFFgeRYngori8X3VIcD1KW1l+ao
         tqkA6034Ap1BPibH6neuYZIF0/WJ2F6K3ul/MJ8bmf7OOXxnjUaNFQHlU+7gsVdGTDEq
         qWjJIswdn2v18ELV66AYGhNdqky1OMOFzhvRmblOiKebqtKBeUOJeM9cpKXSqq1ctk1l
         y2hj/hbqj2qd5/mNlQC26kODrY0V6azAmrW3WPoH/xOLji3wvRIKuibNcmf/FX38NQxc
         +hNA==
X-Gm-Message-State: ACgBeo0BSSvxdhSdZ8dyXsMm7HtFJpbiNSZmD1Z5GMlqvlJgb9IK0Ssd
        ohVXq73HbP1L+i9WDO9nkjiAsw==
X-Google-Smtp-Source: AA6agR5VEL/vmT5yA/4c0HszWg1qtgPbVKTAyNQ0BhudGO3OlBLD3MKqFDDQytEb9RFPWLGoaz3wng==
X-Received: by 2002:a05:6512:220e:b0:48b:48e0:d010 with SMTP id h14-20020a056512220e00b0048b48e0d010mr4997464lfu.78.1659948904446;
        Mon, 08 Aug 2022 01:55:04 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id o11-20020ac24e8b000000b0048a9356cd63sm1353540lfr.11.2022.08.08.01.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 01:55:03 -0700 (PDT)
Message-ID: <02243d57-d7aa-7aa9-4f95-24c417ff8c69@linaro.org>
Date:   Mon, 8 Aug 2022 11:55:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 8/8] power: supply: Add driver for Qualcomm SMBCHG
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220808073459.396278-1-y.oudjana@protonmail.com>
 <20220808073459.396278-9-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220808073459.396278-9-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2022 10:34, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add a driver for the switch-mode battery charger found on
> PMICs such as PMI8994. This block is referred to in the vendor
> kernel[1] as smbcharger or SMBCHG. It has USB and DC inputs,
> and can generate VBUS for USB OTG with a boost regulator.
> It supports Qualcomm Quick Charge 2.0, and can operate along
> with a parallel charger (SMB1357, or SMB1351 for added Quick
> Charge 3.0 support) for improved efficiency at higher currents.
> 
> At the moment, this driver supports charging off of the USB input
> at 5V with input current limit up to 3A. It also includes support
> for operating the OTG boost regulator as well as extcon
> functionality, reporting states of USB and USB_HOST with VBUS and
> charge port types.
> 
> Co-developed-by: Alejandro Tafalla <atafalla@dnyon.com>
> Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> [1] https://github.com/android-linux-stable/msm-3.18/blob/kernel.lnx.3.18.r34-rel/drivers/power/qpnp-smbcharger.c
> ---
>  MAINTAINERS                        |    2 +
>  drivers/power/supply/Kconfig       |   11 +
>  drivers/power/supply/Makefile      |    1 +
>  drivers/power/supply/qcom-smbchg.c | 1664 ++++++++++++++++++++++++++++
>  drivers/power/supply/qcom-smbchg.h |  428 +++++++
>  5 files changed, 2106 insertions(+)
>  create mode 100644 drivers/power/supply/qcom-smbchg.c
>  create mode 100644 drivers/power/supply/qcom-smbchg.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f6cf3a27d132..9b8693050890 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16964,6 +16964,8 @@ L:	linux-pm@vger.kernel.org
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/power/supply/qcom,smbchg.yaml
> +F:	drivers/power/supply/qcom-smbchg.c
> +F:	drivers/power/supply/qcom-smbchg.h
>  
>  QUALCOMM TSENS THERMAL DRIVER
>  M:	Amit Kucheria <amitk@kernel.org>
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 1aa8323ad9f6..246bfc118d9f 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -633,6 +633,17 @@ config CHARGER_QCOM_SMBB
>  	  documentation for more detail.  The base name for this driver is
>  	  'pm8941_charger'.
>  
> +config CHARGER_QCOM_SMBCHG
> +	tristate "Qualcomm Switch-Mode Battery Charger"

As I mentioned in cover letter, this should be either squashed into
Caleb's work, merged into some common part or kept separate but with
clear explaining why it cannot be merged.

Some incomplete review follows:

> +	depends on MFD_SPMI_PMIC || COMPILE_TEST
> +	depends on OF
> +	depends on EXTCON
> +	depends on REGULATOR
> +	select QCOM_PMIC_SEC_WRITE
> +	help
> +	  Say Y to include support for the Switch-Mode Battery Charger block
> +	  found in Qualcomm PMICs such as PMI8994.
> +
>  config CHARGER_BQ2415X
>  	tristate "TI BQ2415x battery charger driver"
>  	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 7f02f36aea55..7c2c037cd8b1 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -83,6 +83,7 @@ obj-$(CONFIG_CHARGER_MAX8998)	+= max8998_charger.o
>  obj-$(CONFIG_CHARGER_MP2629)	+= mp2629_charger.o
>  obj-$(CONFIG_CHARGER_MT6360)	+= mt6360_charger.o
>  obj-$(CONFIG_CHARGER_QCOM_SMBB)	+= qcom_smbb.o
> +obj-$(CONFIG_CHARGER_QCOM_SMBCHG)	+= qcom-smbchg.o
>  obj-$(CONFIG_CHARGER_BQ2415X)	+= bq2415x_charger.o
>  obj-$(CONFIG_CHARGER_BQ24190)	+= bq24190_charger.o
>  obj-$(CONFIG_CHARGER_BQ24257)	+= bq24257_charger.o
> diff --git a/drivers/power/supply/qcom-smbchg.c b/drivers/power/supply/qcom-smbchg.c
> new file mode 100644
> index 000000000000..23a9667953c9
> --- /dev/null
> +++ b/drivers/power/supply/qcom-smbchg.c
> @@ -0,0 +1,1664 @@
> +// SPDX-License-Identifier: GPL-2.0-only

Several things look like based from original sources, so please retain
original copyright.

> +/*
> + * Power supply driver for Qualcomm PMIC switch-mode battery charger
> + *
> + * Copyright (c) 2021 Yassine Oudjana <y.oudjana@protonmail.com>
> + * Copyright (c) 2021 Alejandro Tafalla <atafalla@dnyon.com>
> + */
> +
> +#include <asm/unaligned.h>
> +#include <linux/errno.h>
> +#include <linux/extcon-provider.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/reboot.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/util_macros.h>
> +#include <soc/qcom/pmic-sec-write.h>
> +
> +#include "qcom-smbchg.h"
> +


(...)

> +/**
> + * @brief smbchg_otg_enable() - Enable OTG regulator
> + *
> + * @param rdev Pointer to regulator_dev
> + * @return 0 on success, -errno on failure
> + */
> +static int smbchg_otg_enable(struct regulator_dev *rdev)
> +{
> +	struct smbchg_chip *chip = rdev_get_drvdata(rdev);
> +	int ret;
> +
> +	dev_dbg(chip->dev, "Enabling OTG VBUS regulator");
> +
> +	ret = regmap_update_bits(chip->regmap,
> +				 chip->base + SMBCHG_BAT_IF_CMD_CHG, OTG_EN_BIT,
> +				 OTG_EN_BIT);
> +	if (ret)
> +		dev_err(chip->dev, "Failed to enable OTG regulator: %pe\n",
> +			ERR_PTR(ret));
> +
> +	return ret;
> +}
> +
> +/**
> + * @brief smbchg_otg_disable() - Disable OTG regulator
> + *
> + * @param rdev Pointer to regulator_dev
> + * @return 0 on success, -errno on failure
> + */
> +static int smbchg_otg_disable(struct regulator_dev *rdev)
> +{
> +	struct smbchg_chip *chip = rdev_get_drvdata(rdev);
> +	int ret;
> +
> +	dev_dbg(chip->dev, "Disabling OTG VBUS regulator");

Here and in other places - no dbg messages replacing tracing. We have
tracing for that.

> +
> +	ret = regmap_update_bits(chip->regmap,
> +				 chip->base + SMBCHG_BAT_IF_CMD_CHG, OTG_EN_BIT,
> +				 0);
> +	if (ret) {
> +		dev_err(chip->dev, "Failed to disable OTG regulator: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +

(...)

> +static irqreturn_t smbchg_handle_charger_error(int irq, void *data)
> +{
> +	struct smbchg_chip *chip = data;
> +
> +	dev_err(chip->dev, "Charger error");
> +
> +	power_supply_changed(chip->usb_psy);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t smbchg_handle_p2f(int irq, void *data)
> +{
> +	struct smbchg_chip *chip = data;
> +
> +	dev_dbg(chip->dev, "Fast charging threshold reached");
> +
> +	power_supply_changed(chip->usb_psy);
> +
> +	return IRQ_HANDLED;

Several interrupts which are exactly the same... no, use one interrupt
handler for all such cases. Anyway I have some doubts about these 20 or
more separate interrupt lines...

> +}
> +
> +static irqreturn_t smbchg_handle_rechg(int irq, void *data)
> +{
> +	struct smbchg_chip *chip = data;
> +
> +	dev_dbg(chip->dev, "Recharge threshold reached");
> +
> +	/* Auto-recharge is enabled, nothing to do here */
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t smbchg_handle_taper(int irq, void *data)
> +{
> +	struct smbchg_chip *chip = data;
> +
> +	dev_dbg(chip->dev, "Taper charging threshold reached");
> +
> +	power_supply_changed(chip->usb_psy);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t smbchg_handle_tcc(int irq, void *data)
> +{
> +	struct smbchg_chip *chip = data;
> +
> +	dev_dbg(chip->dev, "Termination current reached");
> +
> +	power_supply_changed(chip->usb_psy);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t smbchg_handle_batt_temp(int irq, void *data)
> +{
> +	struct smbchg_chip *chip = data;
> +
> +	power_supply_changed(chip->usb_psy);
> +
> +	return IRQ_HANDLED;
> +}

(...)

> +
> +const struct smbchg_irq smbchg_irqs[] = {

You mix everywhere functions with static variables. All variables -
except platform_driver related go to the beginning of the file.

> +	{ "chg-error", smbchg_handle_charger_error },
> +	{ "chg-inhibit", NULL },
> +	{ "chg-prechg-sft", NULL },
> +	{ "chg-complete-chg-sft", NULL },
> +	{ "chg-p2f-thr", smbchg_handle_p2f },
> +	{ "chg-rechg-thr", smbchg_handle_rechg },
> +	{ "chg-taper-thr", smbchg_handle_taper },
> +	{ "chg-tcc-thr", smbchg_handle_tcc },
> +	{ "batt-hot", smbchg_handle_batt_temp },
> +	{ "batt-warm", smbchg_handle_batt_temp },
> +	{ "batt-cold", smbchg_handle_batt_temp },
> +	{ "batt-cool", smbchg_handle_batt_temp },
> +	{ "batt-ov", NULL },
> +	{ "batt-low", NULL },
> +	{ "batt-missing", smbchg_handle_batt_presence },
> +	{ "batt-term-missing", NULL },
> +	{ "usbin-uv", NULL },
> +	{ "usbin-ov", NULL },
> +	{ "usbin-src-det", smbchg_handle_usb_source_detect },
> +	{ "usbid-change", smbchg_handle_usbid_change },
> +	{ "otg-fail", smbchg_handle_otg_fail },
> +	{ "otg-oc", smbchg_handle_otg_oc },
> +	{ "aicl-done", smbchg_handle_aicl_done },
> +	{ "dcin-uv", NULL },
> +	{ "dcin-ov", NULL },
> +	{ "power-ok", NULL },
> +	{ "temp-shutdown", smbchg_handle_temp_shutdown },
> +	{ "wdog-timeout", NULL },
> +	{ "flash-fail", NULL },
> +	{ "otst2", NULL },
> +	{ "otst3", NULL },
> +};
> +
> +/**

(...)

> +
> +static int smbchg_probe(struct platform_device *pdev)
> +{
> +	struct smbchg_chip *chip;
> +	struct regulator_config config = {};
> +	struct power_supply_config supply_config = {};
> +	int i, irq, ret;
> +
> +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->dev = &pdev->dev;
> +
> +	chip->regmap = dev_get_regmap(chip->dev->parent, NULL);
> +	if (!chip->regmap) {
> +		dev_err(chip->dev, "Failed to get regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = of_property_read_u32(chip->dev->of_node, "reg", &chip->base);

First: device_xxx
Second: what if address is bigger than u32? Shouldn't this be
of_read_number or something similar in device_xxx API?



> +	if (ret) {
> +		dev_err(chip->dev, "Failed to get base address: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	spin_lock_init(&chip->sec_access_lock);
> +	INIT_WORK(&chip->otg_reset_work, smbchg_otg_reset_worker);
> +
> +	/* Initialize OTG regulator */
> +	chip->otg_rdesc.id = -1;
> +	chip->otg_rdesc.name = "otg-vbus";
> +	chip->otg_rdesc.ops = &smbchg_otg_ops;
> +	chip->otg_rdesc.owner = THIS_MODULE;
> +	chip->otg_rdesc.type = REGULATOR_VOLTAGE;
> +	chip->otg_rdesc.of_match = "otg-vbus";
> +
> +	config.dev = chip->dev;
> +	config.driver_data = chip;
> +
> +	chip->otg_reg =
> +		devm_regulator_register(chip->dev, &chip->otg_rdesc, &config);

This wrapping is difficult to read.

> +	if (IS_ERR(chip->otg_reg)) {
> +		dev_err(chip->dev,
> +			"Failed to register OTG VBUS regulator: %pe\n",
> +			chip->otg_reg);
> +		return PTR_ERR(chip->otg_reg);
> +	}
> +
> +	chip->data = of_device_get_match_data(chip->dev);
> +
> +	supply_config.drv_data = chip;
> +	supply_config.of_node = pdev->dev.of_node;
> +	chip->usb_psy = devm_power_supply_register(

This wrapping is difficult to read.

> +		chip->dev, &smbchg_usb_psy_desc, &supply_config);
> +	if (IS_ERR(chip->usb_psy)) {
> +		dev_err(chip->dev, "Failed to register USB power supply: %pe\n",
> +			chip->usb_psy);
> +		return PTR_ERR(chip->usb_psy);
> +	}
> +
> +	ret = power_supply_get_battery_info(chip->usb_psy, &chip->batt_info);
> +	if (ret) {
> +		dev_err(chip->dev, "Failed to get battery info: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	if (chip->batt_info->voltage_max_design_uv == -EINVAL) {
> +		dev_err(chip->dev,
> +			"Battery info missing maximum design voltage\n");
> +		return -EINVAL;
> +	}
> +
> +	if (chip->batt_info->constant_charge_current_max_ua == -EINVAL) {
> +		dev_err(chip->dev,
> +			"Battery info missing maximum constant charge current\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Initialize extcon */
> +	chip->edev = devm_extcon_dev_allocate(chip->dev, smbchg_extcon_cable);
> +	if (IS_ERR(chip->edev)) {
> +		dev_err(chip->dev, "Failed to allocate extcon device: %pe\n",
> +			chip->edev);
> +		return PTR_ERR(chip->edev);
> +	}
> +
> +	ret = devm_extcon_dev_register(chip->dev, chip->edev);
> +	if (ret) {
> +		dev_err(chip->dev, "Failed to register extcon device: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	extcon_set_property_capability(chip->edev, EXTCON_USB,
> +				       EXTCON_PROP_USB_VBUS);
> +	extcon_set_property_capability(chip->edev, EXTCON_USB_HOST,
> +				       EXTCON_PROP_USB_VBUS);
> +
> +	/* Initialize charger */
> +	ret = smbchg_init(chip);
> +	if (ret)
> +		return ret;
> +
> +	/* Request IRQs */
> +	for (i = 0; i < ARRAY_SIZE(smbchg_irqs); ++i) {
> +		/* IRQ unused */
> +		if (!smbchg_irqs[i].handler)
> +			continue;
> +
> +		irq = of_irq_get_byname(pdev->dev.of_node, smbchg_irqs[i].name);
> +		if (irq < 0) {
> +			dev_err(chip->dev, "Failed to get %s IRQ: %pe\n",
> +				smbchg_irqs[i].name, ERR_PTR(irq));
> +			return irq;
> +		}
> +
> +		ret = devm_request_threaded_irq(chip->dev, irq, NULL,
> +						smbchg_irqs[i].handler,
> +						IRQF_ONESHOT,
> +						smbchg_irqs[i].name, chip);
> +		if (ret) {
> +			dev_err(chip->dev, "failed to request %s IRQ: %pe\n",
> +				smbchg_irqs[i].name, ERR_PTR(irq));
> +			return ret;
> +		}
> +	}
> +
> +	platform_set_drvdata(pdev, chip);
> +
> +	return 0;
> +}
> +
> +static int smbchg_remove(struct platform_device *pdev)
> +{
> +	struct smbchg_chip *chip = platform_get_drvdata(pdev);
> +
> +	smbchg_usb_enable(chip, false);
> +	smbchg_charging_enable(chip, false);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id smbchg_id_table[] = {
> +	{ .compatible = "qcom,pmi8994-smbchg", .data = &smbchg_pmi8994_data },
> +	{ .compatible = "qcom,pmi8996-smbchg", .data = &smbchg_pmi8996_data },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, smbchg_id_table);
> +
> +static struct platform_driver smbchg_driver = {
> +	.probe = smbchg_probe,
> +	.remove = smbchg_remove,
> +	.driver = {
> +		.name = "qcom-smbchg",
> +		.of_match_table = smbchg_id_table,
> +	},
> +};
> +module_platform_driver(smbchg_driver);
> +
> +MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
> +MODULE_AUTHOR("Alejandro Tafalla <atafalla@dnyon.com>");
> +MODULE_DESCRIPTION("Qualcomm PMIC switch-mode battery charger driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/power/supply/qcom-smbchg.h b/drivers/power/supply/qcom-smbchg.h
> new file mode 100644
> index 000000000000..06445e10b4db
> --- /dev/null
> +++ b/drivers/power/supply/qcom-smbchg.h
> @@ -0,0 +1,428 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +/* Registers */
> +/* CHGR */
> +#define SMBCHG_CHGR_FV_STS			0x00c
> +#define SMBCHG_CHGR_STS				0x00e
> +#define SMBCHG_CHGR_RT_STS			0x010
> +#define SMBCHG_CHGR_FCC_CFG			0x0f2
> +#define SMBCHG_CHGR_FCC_CMP_CFG			0x0f3
> +#define SMBCHG_CHGR_FV_CFG			0x0f4
> +#define SMBCHG_CHGR_FV_CMP			0x0f5
> +#define SMBCHG_CHGR_AFVC_CFG			0x0f6
> +#define SMBCHG_CHGR_CHG_INHIB_CFG		0x0f7
> +#define SMBCHG_CHGR_TCC_CFG			0x0f9
> +#define SMBCHG_CHGR_CCMP_CFG			0x0fa
> +#define SMBCHG_CHGR_CHGR_CFG1			0x0fb
> +#define SMBCHG_CHGR_CHGR_CFG2			0x0fc
> +#define SMBCHG_CHGR_SFT_CFG			0x0fd
> +#define SMBCHG_CHGR_CFG				0x0ff
> +
> +/* OTG */
> +#define SMBCHG_OTG_RT_STS			0x110
> +#define SMBCHG_OTG_OTG_CFG			0x1f1
> +#define SMBCHG_OTG_TRIM6			0x1f6
> +#define SMBCHG_OTG_LOW_PWR_OPTIONS		0x1ff
> +
> +/* BAT-IF */
> +#define SMBCHG_BAT_IF_BAT_PRES_STS		0x208
> +#define SMBCHG_BAT_IF_RT_STS			0x210
> +#define SMBCHG_BAT_IF_CMD_CHG			0x242
> +#define SMBCHG_BAT_IF_CMD_CHG_LED		0x243
> +#define SMBCHG_BAT_IF_BM_CFG			0x2f3
> +#define SMBCHG_BAT_IF_BAT_IF_TRIM7		0x2f7
> +#define SMBCHG_BAT_IF_BB_CLMP_SEL		0x2f8
> +#define SMBCHG_BAT_IF_ZIN_ICL_PT		0x2fc
> +#define SMBCHG_BAT_IF_ZIN_ICL_LV		0x2fd
> +#define SMBCHG_BAT_IF_ZIN_ICL_HV		0x2fe
> +
> +/* USB-CHGPTH */
> +#define SMBCHG_USB_CHGPTH_ICL_STS_1		0x307
> +#define SMBCHG_USB_CHGPTH_PWR_PATH		0x308
> +#define SMBCHG_USB_CHGPTH_ICL_STS_2		0x309
> +#define SMBCHG_USB_CHGPTH_RID_STS		0x30b
> +#define SMBCHG_USB_CHGPTH_USBIN_HVDCP_STS	0x30c
> +#define SMBCHG_USB_CHGPTH_INPUT_STS		0x30d
> +#define SMBCHG_USB_CHGPTH_USBID_MSB		0x30e
> +#define SMBCHG_USB_CHGPTH_RT_STS		0x310
> +#define SMBCHG_USB_CHGPTH_CMD_IL		0x340
> +#define SMBCHG_USB_CHGPTH_CMD_APSD		0x341
> +#define SMBCHG_USB_CHGPTH_CMD_HVDCP_1		0x342
> +#define SMBCHG_USB_CHGPTH_CMD_HVDCP_2		0x343
> +#define SMBCHG_USB_CHGPTH_USBIN_CHGR_CFG	0x3f1
> +#define SMBCHG_USB_CHGPTH_IL_CFG		0x3f2
> +#define SMBCHG_USB_CHGPTH_AICL_CFG		0x3f3
> +#define SMBCHG_USB_CHGPTH_CFG			0x3f4
> +#define SMBCHG_USB_CHGPTH_APSD_CFG		0x3f5
> +#define SMBCHG_USB_CHGPTH_TR_RID		0x3fa
> +#define SMBCHG_USB_CHGPTH_ICL_BUF_CONFIG	0x3fc
> +#define SMBCHG_USB_CHGPTH_TR_8OR32B		0x3fe
> +
> +/* DC-CHGPTH */
> +#define SMBCHG_DC_CHGPTH_RT_STS			0x410
> +#define SMBCHG_DC_CHGPTH_IL_CFG			0x4f2
> +#define SMBCHG_DC_CHGPTH_AICL_CFG		0x4f3
> +#define SMBCHG_DC_CHGPTH_AICL_WL_SEL_CFG	0x4f5
> +
> +/* MISC */
> +#define SMBCHG_MISC_REVISION1			0x600
> +#define SMBCHG_MISC_IDEV_STS			0x608
> +#define SMBCHG_MISC_RT_STS			0x610
> +#define SMBCHG_MISC_TEST			0x6e2
> +#define SMBCHG_MISC_NTC_VOUT_CFG		0x6f3
> +#define SMBCHG_MISC_TRIM_OPT_15_8		0x6f5
> +#define SMBCHG_MISC_TRIM_OPT_7_0		0x6f6
> +#define SMBCHG_MISC_TRIM_14			0x6fe
> +
> +/* Bits */
> +/* CHGR_STS bits */
> +#define CHG_TYPE_MASK			GENMASK(2, 1)
> +#define CHG_HOLD_OFF_BIT		BIT(3)\
> +
> +/* CHGR_FCC_CFG bits */
> +#define FCC_MASK			GENMASK(4, 0)
> +
> +/* CHGR_RT_STS bits */
> +#define CHG_INHIBIT_BIT			BIT(1)
> +#define CHG_COMP_SFT_BIT		BIT(3)
> +#define BAT_TCC_REACHED_BIT		BIT(7)
> +
> +/* CHGR_FV_CFG bits */
> +#define FV_MASK				GENMASK(5, 0)
> +
> +/* CHGR_TCC_CFG bits */
> +#define CHG_ITERM_MASK			GENMASK(2, 0)
> +
> +/* CHGR_CHGR_CFG1 bits */
> +#define RECHG_THRESHOLD_SRC_BIT		BIT(1)
> +#define TERM_I_SRC_BIT			BIT(2)
> +
> +/* CHGR_CHGR_CFG2 bits */
> +#define CHARGER_INHIBIT_BIT		BIT(0)
> +#define AUTO_RECHG_BIT			BIT(2)
> +#define I_TERM_BIT			BIT(3)
> +#define P2F_CHG_TRAN_BIT		BIT(5)
> +#define CHG_EN_POLARITY_BIT		BIT(6)
> +#define CHG_EN_SRC_BIT			BIT(7)
> +
> +/* CHGR_CFG bits */
> +#define RCHG_LVL_BIT			BIT(0)
> +
> +/* BAT_IF_CMD_CHG bits */
> +#define OTG_EN_BIT			BIT(0)
> +#define CHG_EN_BIT			BIT(1)
> +
> +/* BAT_IF_RT_STS bits */
> +#define HOT_BAT_HARD_BIT		BIT(0)
> +#define HOT_BAT_SOFT_BIT		BIT(1)
> +#define COLD_BAT_HARD_BIT		BIT(2)
> +#define COLD_BAT_SOFT_BIT		BIT(3)
> +#define BAT_OV_BIT			BIT(4)
> +#define BAT_LOW_BIT			BIT(5)
> +#define BAT_MISSING_BIT			BIT(6)
> +#define BAT_TERM_MISSING_BIT		BIT(7)
> +
> +/* USB_CHGPTH_ICL_STS_1 bits */
> +#define ICL_STS_MASK			GENMASK(4, 0)
> +#define AICL_STS_BIT			BIT(5)
> +#define AICL_SUSP_BIT			BIT(6)
> +
> +/* USB_CHGPTH_CFG bits */
> +#define USB51AC_CTRL			BIT(1)
> +#define USB51_COMMAND_POL		BIT(2)
> +#define CFG_USB3P0_SEL_BIT		BIT(7)
> +
> +/* USB_CHGPTH_RT_STS bits */
> +#define USBIN_OV_BIT			BIT(1)
> +#define USBIN_SRC_DET_BIT		BIT(2)
> +
> +/* USB_CHGPTH_RID_STS bits */
> +#define RID_MASK			GENMASK(3, 0)
> +
> +/* USB_CHGPTH_CMD_IL bits */
> +#define USBIN_MODE_HC_BIT		BIT(0)
> +#define USB51_MODE_BIT			BIT(1)
> +#define ICL_OVERRIDE_BIT		BIT(2)
> +#define USBIN_SUSPEND_BIT		BIT(4)
> +
> +/* USB_CHGPTH_IL_CFG bits */
> +#define USBIN_INPUT_MASK		GENMASK(4, 0)
> +
> +/* USB_CHGPTH_AICL_CFG bits */
> +#define USB_CHGPTH_AICL_EN		BIT(2)
> +
> +/* USB_CHGPTH_APSD_CFG bits */
> +#define USB_CHGPTH_APSD_EN		BIT(0)
> +
> +/* MISC_IDEV_STS bits */
> +#define FMB_STS_MASK			GENMASK(3, 0)
> +
> +/* MISC_TRIM_OPT_15_8 bits */
> +#define AICL_RERUN_MASK			GENMASK(5, 4)
> +#define AICL_RERUN_DC_BIT		BIT(4)
> +#define AICL_RERUN_USB_BIT		BIT(5)
> +
> +/* Values */
> +/* CHGR_STS values */
> +#define CHG_TYPE_SHIFT			1
> +#define BATT_NOT_CHG_VAL		0x0
> +#define BATT_PRE_CHG_VAL		0x1
> +#define BATT_FAST_CHG_VAL		0x2
> +#define BATT_TAPER_CHG_VAL		0x3
> +
> +/* CHGR_CHGR_CFG1 values */
> +#define	RCHG_SRC_ANA			0
> +#define RCHG_SRC_FG			BIT(1)
> +#define TERM_SRC_ANA			0
> +#define TERM_SRC_FG			BIT(2)
> +
> +/* CHGR_CHGR_CFG2 values */
> +#define CHG_INHIBIT_DIS			0
> +#define CHG_INHIBIT_EN			BIT(0)
> +#define AUTO_RCHG_EN			0
> +#define AUTO_RCHG_DIS			BIT(2)
> +#define CURRENT_TERM_EN			0
> +#define CURRENT_TERM_DIS		BIT(3)
> +#define PRE_FAST_AUTO			0
> +#define PRE_FAST_CMD			BIT(5)
> +#define CHG_EN_SRC_CMD			0
> +#define CHG_EN_SRC_PIN			BIT(7)
> +
> +/* CHGR_CFG values */
> +#define RCHG_THRESH_100MV		0
> +#define RCHG_THRESH_200MV		BIT(0)
> +
> +/* USB_CHGPTH_INPUT_STS values */
> +#define USBIN_9V			BIT(5)
> +#define USBIN_UNREG			BIT(4)
> +#define USBIN_LV			BIT(3)
> +
> +/* USB_CHGPTH_USBID_MSB values */
> +#define USBID_GND_THRESHOLD		0x495
> +
> +/* USB_CHGPTH_CFG values */
> +#define USB51_COMMAND_CONTROL		0
> +#define USB51_PIN_CONTROL		BIT(1)
> +#define USB51AC_COMMAND1_500		0
> +#define USB51AC_COMMAND1_100		BIT(2)
> +#define USB_2P0_SEL			0
> +#define USB_3P0_SEL			BIT(7)
> +
> +/* MISC_IDEV_STS values */
> +#define USB_TYPE_SDP_BIT		BIT(4)
> +#define USB_TYPE_OTHER_BIT		BIT(5)
> +#define USB_TYPE_DCP_BIT		BIT(6)
> +#define USB_TYPE_CDP_BIT		BIT(7)
> +
> +/* Constant parameters */
> +#define NUM_OTG_RESET_RETRIES		5
> +#define OTG_RESET_DELAY_MS		20
> +
> +/*
> + * These values can be indexed using a bitmask:
> + * 0: USB 2.0/3.0
> + * 1: Limited/full current
> + */
> +static const int smbchg_lc_ilim_options[] = {
> +	[0b00] = 100000,
> +	[0b01] = 150000,
> +	[0b10] = 500000,
> +	[0b11] = 900000
> +};
> +#define LC_ILIM_USB3_BIT		BIT(0)
> +#define LC_ILIM_FULL_CURRENT_BIT	BIT(1)
> +#define smbchg_lc_ilim(usb_3, full_current) smbchg_lc_ilim_options[usb_3 | full_current << 1]
> +
> +struct smbchg_chip {
> +	unsigned int base;
> +	struct device *dev;
> +	struct regmap *regmap;
> +
> +	struct power_supply_battery_info *batt_info;
> +	struct power_supply *usb_psy;
> +
> +	struct regulator_desc otg_rdesc;
> +	struct regulator_dev *otg_reg;
> +	int otg_resets;
> +
> +	struct extcon_dev *edev;
> +
> +	spinlock_t sec_access_lock;
> +	struct work_struct otg_reset_work;
> +
> +	const struct smbchg_data *data;
> +};
> +
> +struct smbchg_irq {
> +	const char *name;
> +	irq_handler_t handler;
> +};
> +
> +struct smbchg_data {
> +	const int *iterm_table;
> +	unsigned int iterm_table_len;
> +	const int *ilim_table;
> +	unsigned int ilim_table_len;
> +
> +	bool reset_otg_on_oc;
> +};
> +
> +static const int smbchg_fv_table[] = {

No static data in headers.

Best regards,
Krzysztof
