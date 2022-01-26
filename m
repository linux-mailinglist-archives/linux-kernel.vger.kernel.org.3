Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C7749C2C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 05:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiAZEri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 23:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiAZErg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 23:47:36 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8FAC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 20:47:36 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id s9so35339614oib.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 20:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qg4dufdEZxAYOTkMHdGZGgR0NpNiD5ib05dJ5SVtPDg=;
        b=nfac7OYaBWv5VZ8RUZvJUZWAQp0W0d7XJdchWNckgzZToA8lUNeLdMLQ+GcURSU4vR
         PdyvkJih2lu2JILKhdwcAZEPDP7sEZEcl8LLqTU8vsuRj32zyAk8/droH6hew2zWABjf
         gcQNVg9BjFiA/GShYp3wBJpObGrvxhmaMCqB4VdVrXpp9+i+9ydukx+Tw8gm//n9ZBdb
         3FQ8NvKC1U5ANgxj96G848Ltx3VRo7AgKxUf4WqAtR9XCkqxYfPSBtCKMNsdxGS/L8Fu
         8otdKpsY+Hqiu0MTLFlRJ5Mc0pWjxc1SoVapIp1jX0fluIa1wSoY18UF9unPuZnffCSX
         kSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qg4dufdEZxAYOTkMHdGZGgR0NpNiD5ib05dJ5SVtPDg=;
        b=aoBvx4BDzrrZm7nZ2zqww9Lv5qtBXwpgFvWJE6vARlfCaUjZQ8r/Hc3TAq2luC1Pa9
         mcGW+wjLxli0+iTton5LKYjH4n6fUwrrVuFwDek3jvOMUxMGXpcVFxrUAWIs1NAuHydp
         Xkn7FkgtSq46IrFsVhvCCekAkslMmdi/YTOC8Yl/taGk4a5c6u06LMP/VvPmVmP31NHk
         p27E2YwmBM352hvIkkQg1sDxpoCYcEROfDzMhXK5z0TRXULnWgatHNJkm1YQf7tdnrQc
         yMy9zSP5Vrt6NXHu2ihEIUUx52BTTXOdEEX78jPDGZr0ik/X226UjzTClqouFAwDy8aJ
         F8ZQ==
X-Gm-Message-State: AOAM531+CNkkFQsu39gm0PgzEwOEzf6iH5kd88JWCAkkhHLRfYGRq+LY
        Kzm280GX5E7NwgKmzT488dhS/A==
X-Google-Smtp-Source: ABdhPJxycrRi7qg11Zdf87PblHTB9MYDeyhENdy5YuP/sLV3MbPv+ZOGgNviTuB62eAcSYp6AkwyCA==
X-Received: by 2002:a05:6808:1829:: with SMTP id bh41mr2679219oib.249.1643172455650;
        Tue, 25 Jan 2022 20:47:35 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id i10sm8068839otf.72.2022.01.25.20.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 20:47:35 -0800 (PST)
Date:   Tue, 25 Jan 2022 22:47:33 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, pure.logic@nexus-software.ie,
        greg@kroah.com, robh@kernel.org, linux-kernel@vger.kernel.org,
        quic_tsoni@quicinc.com, quic_psodagud@quicinc.com,
        quic_satyap@quicinc.com, quic_pheragu@quicinc.com,
        quic_rjendra@quicinc.com, quic_sibis@quicinc.com,
        quic_saipraka@quicinc.com
Subject: Re: [PATCH V4 3/6] soc: qcom: eud: Add driver support for Embedded
 USB Debugger(EUD)
Message-ID: <YfDSZTZOryQuWIlJ@builder.lan>
References: <cover.1642768837.git.quic_schowdhu@quicinc.com>
 <7ccee5ae484e6917f5838c8abde368680ec63d05.1642768837.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ccee5ae484e6917f5838c8abde368680ec63d05.1642768837.git.quic_schowdhu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21 Jan 07:53 CST 2022, Souradeep Chowdhury wrote:

> Add support for control peripheral of EUD (Embedded USB Debugger) to
> listen to events such as USB attach/detach, pet EUD to indicate software
> is functional.Reusing the platform device kobj, sysfs entry 'enable' is
> created to enable or disable EUD.
> 
> To enable the eud the following needs to be done
> echo 1 > /sys/bus/platform/.../enable
> 
> To disable eud, following is the command
> echo 0 > /sys/bus/platform/.../enable
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-eud |   9 ++
>  drivers/soc/qcom/Kconfig                   |  10 ++
>  drivers/soc/qcom/Makefile                  |   1 +
>  drivers/soc/qcom/qcom_eud.c                | 250 +++++++++++++++++++++++++++++
>  4 files changed, 270 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-eud
>  create mode 100644 drivers/soc/qcom/qcom_eud.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-eud b/Documentation/ABI/testing/sysfs-driver-eud
> new file mode 100644
> index 0000000..2381552
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-eud
> @@ -0,0 +1,9 @@
> +What:		/sys/bus/platform/drivers/eud/.../enable
> +Date:           January 2022
> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +Description:
> +		The Enable/Disable sysfs interface for Embedded
> +		USB Debugger(EUD). This enables and disables the
> +		EUD based on a 1 or a 0 value. By enabling EUD,
> +		the user is able to activate the mini-usb hub of
> +		EUD for debug and trace capabilities.
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index e718b87..abc6be0 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -42,6 +42,16 @@ config QCOM_CPR
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called qcom-cpr
> 
> +config QCOM_EUD
> +        tristate "QCOM Embedded USB Debugger(EUD) Driver"

The indentation looks off here.

> +	select USB_ROLE_SWITCH
> +	help
> +	  This module enables support for Qualcomm Technologies, Inc.
> +	  Embedded USB Debugger (EUD). The EUD is a control peripheral
> +	  which reports VBUS attach/detach events and has USB-based
> +	  debug and trace capabilities. On selecting m, the module name
> +	  that is built is qcom_eud.ko
> +
>  config QCOM_GENI_SE
>  	tristate "QCOM GENI Serial Engine Driver"
>  	depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 70d5de6..e0c7d2d 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
>  obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
>  obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
>  obj-$(CONFIG_QCOM_CPR)		+= cpr.o
> +obj-$(CONFIG_QCOM_EUD)          += qcom_eud.o
>  obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
>  obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
>  obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
> diff --git a/drivers/soc/qcom/qcom_eud.c b/drivers/soc/qcom/qcom_eud.c
> new file mode 100644
> index 0000000..a538645
> --- /dev/null
> +++ b/drivers/soc/qcom/qcom_eud.c
> @@ -0,0 +1,250 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2015-2021, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/usb/role.h>
> +
> +#define EUD_REG_INT1_EN_MASK	0x0024
> +#define EUD_REG_INT_STATUS_1	0x0044
> +#define EUD_REG_CTL_OUT_1	0x0074
> +#define EUD_REG_VBUS_INT_CLR	0x0080
> +#define EUD_REG_CSR_EUD_EN	0x1014
> +#define EUD_REG_SW_ATTACH_DET	0x1018
> +#define EUD_REG_EUD_EN2         0x0000
> +
> +#define EUD_ENABLE		BIT(0)
> +#define EUD_INT_PET_EUD		BIT(0)
> +#define EUD_INT_VBUS		BIT(2)
> +#define EUD_INT_SAFE_MODE	BIT(4)
> +#define EUD_INT_ALL		(EUD_INT_VBUS|EUD_INT_SAFE_MODE)
> +
> +struct eud_chip {
> +	struct device			*dev;
> +	struct usb_role_switch		*role_sw;
> +	void __iomem			*base;
> +	void __iomem			*mode_mgr;
> +	unsigned int			int_status;
> +	int				irq;
> +	bool				enabled;
> +	bool				usb_attached;
> +};
> +
> +static int enable_eud(struct eud_chip *priv)
> +{
> +	writel(EUD_ENABLE, priv->base + EUD_REG_CSR_EUD_EN);
> +	writel(EUD_INT_VBUS | EUD_INT_SAFE_MODE,
> +			priv->base + EUD_REG_INT1_EN_MASK);
> +	writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
> +
> +	return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);

So we won't get EUD_INT_VBUS when we enable the EUD and can rely on the
irq handler to set the role?

> +}
> +
> +static void disable_eud(struct eud_chip *priv)
> +{
> +	writel(0, priv->base + EUD_REG_CSR_EUD_EN);
> +	writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
> +}
> +
> +static ssize_t enable_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct eud_chip *chip = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", chip->enabled);
> +}
> +
> +static ssize_t enable_store(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	struct eud_chip *chip = dev_get_drvdata(dev);
> +	bool enable;
> +	int ret;
> +
> +	if (kstrtobool(buf, &enable))
> +		return -EINVAL;
> +
> +	if (enable) {
> +		ret = enable_eud(chip);
> +		if (!ret)
> +			chip->enabled = enable;
> +		else
> +			disable_eud(chip);
> +	} else {
> +		disable_eud(chip);
> +	}
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(enable);
> +
> +static struct attribute *eud_attrs[] = {
> +	&dev_attr_enable.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(eud);
> +
> +static void usb_attach_detach(struct eud_chip *chip)
> +{
> +	u32 reg;
> +
> +	/* read ctl_out_1[4] to find USB attach or detach event */
> +	reg = readl(chip->base + EUD_REG_CTL_OUT_1);
> +	chip->usb_attached = reg & EUD_INT_SAFE_MODE;
> +}
> +
> +static void pet_eud(struct eud_chip *chip)
> +{
> +	u32 reg;
> +	int ret;
> +
> +	/* When the EUD_INT_PET_EUD in SW_ATTACH_DET is set, the cable has been
> +	 * disconnected and we need to detach the pet to check if EUD is in safe
> +	 * mode before attaching again.
> +	 */
> +	reg = readl(chip->base + EUD_REG_SW_ATTACH_DET);
> +	if (reg & EUD_INT_PET_EUD) {
> +		/* Detach & Attach pet for EUD */
> +		writel(0, chip->base + EUD_REG_SW_ATTACH_DET);
> +		/* Delay to make sure detach pet is done before attach pet */
> +		ret = readl_poll_timeout(chip->base + EUD_REG_SW_ATTACH_DET,
> +					reg, (reg == 0), 1, 100);
> +		if (ret) {
> +			dev_err(chip->dev, "Detach pet failed\n");
> +			return;
> +		}
> +	}
> +	/* Attach pet for EUD */
> +	writel(EUD_INT_PET_EUD, chip->base +EUD_REG_SW_ATTACH_DET);
> +}
> +
> +static irqreturn_t handle_eud_irq(int irq, void *data)
> +{
> +	struct eud_chip *chip = data;
> +	u32 reg;
> +
> +	reg = readl(chip->base + EUD_REG_INT_STATUS_1);
> +	switch (reg & EUD_INT_ALL) {
> +	case EUD_INT_VBUS:
> +		chip->int_status = EUD_INT_VBUS;

The first time that reg & EUD_INT_VBUS is set, you assign int_status
EUD_INT_VBUS, you never clear it again.

This is also the only path where you wake up the thread, so int_status
will always be EUD_INT_VBUS when you reach handle_eud_irq_thread().

Which means that int_status serves no purpose and if you're happy with
how this implementation currently works you can just drop "int_status"
and the conditional below.

> +		usb_attach_detach(chip);
> +		return IRQ_WAKE_THREAD;
> +	case EUD_INT_SAFE_MODE:
> +		pet_eud(chip);
> +		return IRQ_HANDLED;
> +	default:
> +		return IRQ_NONE;
> +	}
> +}
> +
> +static irqreturn_t handle_eud_irq_thread(int irq, void *data)
> +{
> +	struct eud_chip *chip = data;
> +	int ret;
> +
> +	if (chip->int_status == EUD_INT_VBUS) {
> +		if (chip->usb_attached)
> +			ret = usb_role_switch_set_role(chip->role_sw, USB_ROLE_DEVICE);
> +		else
> +			ret = usb_role_switch_set_role(chip->role_sw, USB_ROLE_HOST);
> +		if (ret)
> +			dev_err(chip->dev, "failed to set role switch\n");
> +	}
> +
> +	/* set and clear vbus_int_clr[0] to clear interrupt */
> +	writel(BIT(0), chip->base + EUD_REG_VBUS_INT_CLR);
> +	writel(0, chip->base + EUD_REG_VBUS_INT_CLR);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int eud_probe(struct platform_device *pdev)
> +{
> +	struct eud_chip *chip;
> +	struct fwnode_handle *fwnode = pdev->dev.fwnode, *dwc3;
> +	int ret;
> +
> +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->dev = &pdev->dev;
> +
> +	dwc3 = fwnode_graph_get_next_endpoint(fwnode, NULL);

This will pick the first endpoint, but if you instead use

    chip->role_sw = usb_role_switch_get(&pdev->dev);

you should get whichever port that points to a usb-role-switch node,
without having to do the fwnode dance (and refcounting, which you forgot
to release).

> +	if (!dwc3)
> +		return -ENODEV;
> +
> +	chip->role_sw = fwnode_usb_role_switch_get(dwc3);
> +	if (IS_ERR(chip->role_sw)) {
> +		ret = PTR_ERR(chip->role_sw);
> +		usb_role_switch_put(chip->role_sw);

You don't need to return the role_sw if it's IS_ERR().

> +		return dev_err_probe(chip->dev, ret,
> +					"failed to get role switch\n");
> +	}
> +
> +	chip->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(chip->base))

You're not usb_role_switch_put() your role_sw here, or below return
cases. I would recommend devm_add_action_or_reset() to avoid the hassle
of adding the necessary cleanup logic.

> +		return PTR_ERR(chip->base);
> +
> +	chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(chip->mode_mgr))
> +		return PTR_ERR(chip->mode_mgr);
> +
> +	chip->irq = platform_get_irq(pdev, 0);
> +	ret = devm_request_threaded_irq(&pdev->dev, chip->irq, handle_eud_irq,
> +			handle_eud_irq_thread, IRQF_ONESHOT, NULL, chip);
> +	if (ret)
> +		return dev_err_probe(chip->dev, ret, "failed to allocate irq\n");
> +
> +	enable_irq_wake(chip->irq);
> +
> +	platform_set_drvdata(pdev, chip);
> +
> +	return 0;

Per the updated binding, the EUD would now be a usb-role-switch as well
and when not enabled should simply propagate the incoming requests. So I
was expecting this to register as a usb_role_switch as well...

> +}
> +
> +static int eud_remove(struct platform_device *pdev)
> +{
> +	struct eud_chip *chip = platform_get_drvdata(pdev);
> +
> +	if (chip->enabled)
> +		disable_eud(chip);
> +
> +	device_init_wakeup(&pdev->dev, false);
> +	disable_irq_wake(chip->irq);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id eud_dt_match[] = {
> +	{ .compatible = "qcom,sc7280-eud" },

Do you see any reason for not just adding qcom,eud here? Are there any
differences from other platforms that has this block that means that we
need per-platform driver support (the dts should have both
compatibles still)?

Regards,
Bjorn

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, eud_dt_match);
> +
> +static struct platform_driver eud_driver = {
> +	.probe	= eud_probe,
> +	.remove	= eud_remove,
> +	.driver	= {
> +		.name = "qcom_eud",
> +		.dev_groups = eud_groups,
> +		.of_match_table = eud_dt_match,
> +	},
> +};
> +module_platform_driver(eud_driver);
> +
> +MODULE_DESCRIPTION("QTI EUD driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
> 
