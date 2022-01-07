Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE97486F94
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345072AbiAGBSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345081AbiAGBSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:18:21 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BADCC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 17:18:21 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id v6so6163710oib.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 17:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xT6Mj/0HtBbta//8DeuQVVkRCmAe7/UWCbuf6iNteLU=;
        b=FBODblplRCTd97+iM+j0EVQtb2c0zCl3kkafCHxVcteG2hNlv0kEa3KrwyebnQDRkz
         WDNQVbflNX40Qn/g+U8/Pkm5nJx6kCZ4EX/z3W5u2wv/xVkgMIgtJ06ODPwyEvb1Nf8/
         aWcPNXzBuoVodubba0+id56ErBB/PDeKjs6jbL+hOE4GSolWoOpvT8rXLrqe6HytnhGY
         d7ABtvK/a0ASioYPxVN6mO4nyXurhJr6dUZS8NeiWKtVneAGUQJ4Z7pbgtdFZJN/HG7E
         AAeUOn21OrOufWewYzp1cbJKKzB9W36BJgVfYARvMUxqgbGe7g1Y2xOT3I+oi3AQCLZ0
         Vosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xT6Mj/0HtBbta//8DeuQVVkRCmAe7/UWCbuf6iNteLU=;
        b=tNTQAjXqxlXj/wcIqi3HVbOGbyNVhpv1Pb+UiqtTAEgOlxuqebiaxlhuBGIUtu2vZr
         r10BK6hLFA40aSVIas0/gpklL9OhvM5R61E8WbR1tblsXRifBvH7hksWPSksE7SvrEpP
         NVvNpkGhWYWEC2QPNInqod8EUkIkc855kquuLSwBSF0TtcPtGdLmCMSHANLbp36EWrzO
         javUC6iXSqxbzAjWxzvDdKEvN1eHs1c6s6HrCI3LjEggn4HtmGhKiNYFzkQgDhYfvfh/
         3fzDht8rVdigCrKnmGperQH+XLlkrUz+1aMv1aPNg+HPnGv/3C2/9SL7+bre4uXf0LYn
         d67Q==
X-Gm-Message-State: AOAM530etDPASrybT2lfB27aLBLP7myltpK6PlfcH/xY9UtbyM2nzimr
        L2kLPEBx1DMB8l+M+6E/Q5jfVA==
X-Google-Smtp-Source: ABdhPJwdnIFCRzSm0Q8yZa6LlnXdydKdqzb9HxJi8tmsz6s8LJAdLhXNfqTzixuGzDL+mhR2vfrMIg==
X-Received: by 2002:aca:ea55:: with SMTP id i82mr7993275oih.96.1641518300278;
        Thu, 06 Jan 2022 17:18:20 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k25sm686479oik.19.2022.01.06.17.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 17:18:19 -0800 (PST)
Date:   Thu, 6 Jan 2022 17:19:07 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, pure.logic@nexus-software.ie,
        greg@kroah.com, linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, satyap@codeaurora.org,
        pheragu@codeaurora.org, rnayak@codeaurora.org,
        sibis@codeaurora.org, saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH V3 4/7] soc: qcom: eud: Add driver support for Embedded
 USB Debugger(EUD)
Message-ID: <YdeVC3d3OzbCSDTQ@ripper>
References: <cover.1641288286.git.quic_schowdhu@quicinc.com>
 <654a9529015d2d5cf9ee1c263cdc0a970bbe4f91.1641288286.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <654a9529015d2d5cf9ee1c263cdc0a970bbe4f91.1641288286.git.quic_schowdhu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04 Jan 03:58 PST 2022, Souradeep Chowdhury wrote:

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
>  Documentation/ABI/testing/sysfs-driver-eud |   9 +
>  drivers/soc/qcom/Kconfig                   |  10 ++
>  drivers/soc/qcom/Makefile                  |   1 +
>  drivers/soc/qcom/qcom_eud.c                | 260 +++++++++++++++++++++++++++++
>  4 files changed, 280 insertions(+)
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
> +Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
> +Description:
> +		The Enable/Disable sysfs interface for Embedded
> +		USB Debugger(EUD). This enables and disables the
> +		EUD based on a 1 or a 0 value. By enabling EUD,
> +		the user is able to activate the mini-usb hub of
> +		EUD for debug and trace capabilities.
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 79b568f..a4db41b 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -42,6 +42,16 @@ config QCOM_CPR
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called qcom-cpr
>  
> +config QCOM_EUD
> +	tristate "QCOM Embedded USB Debugger(EUD) Driver"
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
> index ad675a6..3331a40 100644
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
> index 0000000..7c4cc7d
> --- /dev/null
> +++ b/drivers/soc/qcom/qcom_eud.c
> @@ -0,0 +1,260 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2015-2021, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/delay.h>

Is this needed?

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
> +	void __iomem			*eud_reg_base;

This is unnecessarily long, "base" or "eud" seems sufficient.

> +	void __iomem			*eud_mode_mgr2_phys_base;

"mode_mgr"

> +	unsigned int			int_status;
> +	int				eud_irq;

"irq"

> +	bool				enable;

"enable" is an action, but you use it to track if the state of the EUD,
i.e if it's "enabled".

> +	bool				usb_attach;

"attach" vs "attached"

> +

Empty line.

> +};
> +
> +static int enable_eud(struct eud_chip *priv)
> +{
> +	writel(EUD_ENABLE, priv->eud_reg_base + EUD_REG_CSR_EUD_EN);
> +	writel(EUD_INT_VBUS | EUD_INT_SAFE_MODE,
> +			priv->eud_reg_base + EUD_REG_INT1_EN_MASK);
> +	writel(1, priv->eud_mode_mgr2_phys_base + EUD_REG_EUD_EN2);
> +
> +	return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);

When this fails, don't you want to disable the EUD again?

> +}
> +
> +static void disable_eud(struct eud_chip *priv)
> +{
> +	writel(0, priv->eud_reg_base + EUD_REG_CSR_EUD_EN);
> +	writel(0, priv->eud_mode_mgr2_phys_base + EUD_REG_EUD_EN2);
> +}
> +
> +static ssize_t enable_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct eud_chip *chip = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", chip->enable);
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
> +			chip->enable = enable;
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
> +	reg = readl(chip->eud_reg_base + EUD_REG_CTL_OUT_1);
> +	if (reg & EUD_INT_SAFE_MODE)
> +		chip->usb_attach = true;
> +	else
> +		chip->usb_attach = false;

chip->usb_attach = reg & EUD_INT_SAFE_MODE;

> +
> +	/* set and clear vbus_int_clr[0] to clear interrupt */
> +	writel(BIT(0), chip->eud_reg_base + EUD_REG_VBUS_INT_CLR);
> +	writel(0, chip->eud_reg_base + EUD_REG_VBUS_INT_CLR);

How come you do this before waking up the threaded handler?

> +}
> +
> +static void pet_eud(struct eud_chip *chip)
> +{
> +	u32 reg;
> +	int ret;
> +
> +	/* read sw_attach_det[0] to find attach/detach event */

Please instead describe what this means, like:

/*
 * When the EUD_INT_PET_EUD in SW_ATTACH_DET is set, the cable has been
 * disconnected and we need to detach the something because something.
 */

> +	reg = readl(chip->eud_reg_base +  EUD_REG_SW_ATTACH_DET);

Please drop the double space.

> +	if (reg & EUD_INT_PET_EUD) {
> +		/* Detach & Attach pet for EUD */
> +		writel(0, chip->eud_reg_base + EUD_REG_SW_ATTACH_DET);
> +		/* Delay to make sure detach pet is done before attach pet */
> +		ret = readl_poll_timeout(chip->eud_reg_base + EUD_REG_SW_ATTACH_DET,
> +					reg, (reg == 0), 1, 100);
> +		if (ret) {
> +			dev_err(chip->dev, "Detach pet failed\n");
> +			return;
> +		}
> +
> +		writel(EUD_INT_PET_EUD, chip->eud_reg_base +
> +				EUD_REG_SW_ATTACH_DET);

Can you please help me see what differs between this and the write in
the else statement?

> +	} else {
> +		/* Attach pet for EUD */
> +		writel(EUD_INT_PET_EUD, chip->eud_reg_base +
> +				EUD_REG_SW_ATTACH_DET);
> +	}
> +}
> +
> +static irqreturn_t handle_eud_irq(int irq, void *data)
> +{
> +	struct eud_chip *chip = data;
> +	u32 reg;
> +
> +	/* read status register and find out which interrupt triggered */

That's what the next line says as well, please drop this comment.

> +	reg = readl(chip->eud_reg_base +  EUD_REG_INT_STATUS_1);

Please drop the double space.

> +	switch (reg & EUD_INT_ALL) {

What if both of these bits are set? Won't you just end up with an
interrupt storm until someone disables the EUD again?

> +	case EUD_INT_VBUS:
> +		chip->int_status = EUD_INT_VBUS;
> +		usb_attach_detach(chip);
> +		return IRQ_WAKE_THREAD;
> +	case EUD_INT_SAFE_MODE:
> +		pet_eud(chip);
> +		break;

This is the only case where you break to return IRQ_HANDLED. Please be
consistent.

> +	default:
> +		return IRQ_NONE;
> +	}
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t handle_eud_irq_thread(int irq, void *data)
> +{
> +	struct eud_chip *chip = data;
> +	int ret;
> +
> +	if (chip->int_status == EUD_INT_VBUS) {

I presume you have this here to signal that EUD_INT_VBUS was set in
EUD_REG_INT_STATUS_1 in handle_eud_irq().

But 1) unless this was true you wouldn't have woken up the threaded
handler and 2) you never clear int_status, so once you've received the
EUD_INT_VBUS it seems to forever be true.

> +		if (chip->usb_attach)
> +			ret = usb_role_switch_set_role(chip->role_sw, USB_ROLE_DEVICE);
> +		else
> +			ret = usb_role_switch_set_role(chip->role_sw, USB_ROLE_HOST);
> +		if (ret)
> +			dev_err(chip->dev, "failed to set role switch\n");
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int eud_probe(struct platform_device *pdev)
> +{
> +	struct eud_chip *chip;
> +	struct fwnode_handle *fwnode = pdev->dev.fwnode, *ep, *connector;
> +	int ret;
> +
> +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->dev = &pdev->dev;
> +
> +	ep = fwnode_graph_get_next_endpoint(fwnode, NULL);
> +	if (!ep)
> +		return -ENODEV;
> +
> +	connector = fwnode_graph_get_remote_port_parent(ep);
> +	fwnode_handle_put(ep);
> +	if (!connector)
> +		return -ENODEV;
> +
> +	chip->role_sw = fwnode_usb_role_switch_get(connector);

Can't you just call usb_role_switch_get(&pdev->dev) to find the
"usb-role-switch", without having to traverse the fwnode_graph manually?

> +	if (IS_ERR(chip->role_sw)) {
> +		return dev_err_probe(chip->dev, PTR_ERR(chip->role_sw),
> +					"failed to get role switch\n");
> +	}

Note that from now on you must usb_role_switch_put(chip->role_sw);

> +
> +	chip->eud_reg_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(chip->eud_reg_base))
> +		return PTR_ERR(chip->eud_reg_base);
> +
> +	chip->eud_mode_mgr2_phys_base = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(chip->eud_mode_mgr2_phys_base))
> +		return PTR_ERR(chip->eud_mode_mgr2_phys_base);
> +
> +	chip->eud_irq = platform_get_irq(pdev, 0);
> +	ret = devm_request_threaded_irq(&pdev->dev, chip->eud_irq, handle_eud_irq,
> +			handle_eud_irq_thread, IRQF_ONESHOT, NULL, chip);
> +	if (ret)
> +		return dev_err_probe(chip->dev, ret, "failed to allocate irq\n");
> +
> +	enable_irq_wake(chip->eud_irq);
> +
> +	platform_set_drvdata(pdev, chip);
> +
> +	return 0;
> +}
> +
> +static int eud_remove(struct platform_device *pdev)
> +{
> +	struct eud_chip *chip = platform_get_drvdata(pdev);
> +
> +	if (chip->enable)
> +		disable_eud(chip);
> +
> +	device_init_wakeup(&pdev->dev, false);
> +	disable_irq_wake(chip->eud_irq);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id eud_dt_match[] = {
> +	{ .compatible = "qcom,sc7280-eud" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, eud_dt_match);
> +
> +static struct platform_driver eud_driver = {
> +	.probe		= eud_probe,

I would prefer if you didn't indent the assignments.

> +	.remove		= eud_remove,
> +	.driver		= {
> +		.name		= "eud",

"qcom_eud" please.

Regards,
Bjorn

> +		.dev_groups	= eud_groups,
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
