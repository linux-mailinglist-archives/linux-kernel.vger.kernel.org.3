Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331974675E0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380251AbhLCLI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:08:26 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:57755 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232412AbhLCLIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:08:25 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id B183D580186;
        Fri,  3 Dec 2021 06:05:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 03 Dec 2021 06:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=ly7Qh9L4OGdMO5OUB1lCPCeZ/2O
        QECslXma5zOZU7ug=; b=STx8VBqY1luyKLSVp8tg1YCC2R/UaVbvK+vwF8k1kPj
        N7vbpFceJS4LrsuzirAOLAE9r7mwKB2bQyAdWFJdTp1SMOMa2XCQg/3NGDaM8pIY
        oE0zTb9mht8kKnv6kWCAIOIgDmZhLqfxPFCjmxhADYbNwaAIRR7zTfraO/PDr8wU
        F85W9inth2QevHhjJPsgtbWDDB1imBLZcX2o8w6eETGYyIqv53w+pUl37rAutHVC
        xoWJLAwMzqDot2yb4Cr3vRe1F5EyTf46EFNSHogpvMeQRSEsDpD5Ip91YUEngZZV
        0fjA95+/x03tS1hlQKDQPn+7Ll7Q/KZabUV7VcLb5QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ly7Qh9
        L4OGdMO5OUB1lCPCeZ/2OQECslXma5zOZU7ug=; b=KLmlaMNprWTK+tS95PZGm0
        u9OrYDp27yuCPf0OCVSCIkzLnnXuI7UmCNUqv863Z/4BeLVw0Ceg9aupq+YgAhKk
        S/0yEGlFe4qdggPOe8uzgYecBk5GhCKzCdwcinq8d9o8Q89IFAc+1Rp+MvNhTpZX
        fJ6WOQtPIOUYhKe91I6u5S8nHgdoZGt+PC0f9cAa3rs2qITm8v3J1iI0wwELu28r
        WZpWmcF0TKJwaWS/r2iIPr6/QfQEMjwgug7Eq+BCiZQIZ6vV3mZEyNoha5wY1xTB
        n/Jz0rosscnA+1d83e0OQQwk91xHKU+uYc000pnZE8wVp5Xr3nEMXoA9So68IIXQ
        ==
X-ME-Sender: <xms:3fmpYfg4zsmCzVvwoi_Ywe8705Kpj-76ukJuJi-QY3Dk1XhDAzY_7w>
    <xme:3fmpYcAtkxDhp761OrWLygels-r1FK7kNBMkNISt2MGR-PpcsR-2mZJBqUctd5xDE
    VGtoWqVHZWzEw>
X-ME-Received: <xmr:3fmpYfFSJe7EuW7BenTpMrvbdi-E5xSrcCdD7r9irxZBTLebN6ouDzye78ieS6sQywnHOUSk5kBd5B6Tw7Z6QIhvuNugduqf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieejgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeevueehjefgfffgiedvudekvdektdelleelgefhleejieeuge
    egveeuuddukedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:3fmpYcRCeKcnEaHdFuWCdbxtf8WFW2yx03PmswrOhT85ofuHVNs0Pg>
    <xmx:3fmpYcxJJBuECXMIMQyQIFGLO2lF4bKwUCD-NfOeeBdLDuUpfzhLXw>
    <xmx:3fmpYS5Qt5mtS4XJ9CeXTgjIAD9hoaYQq5igkaoIVWhTPF-DzHr_Fg>
    <xmx:3fmpYUcw0Mh3RCW8OeCN0JdYAmi9lCC9nK1kVtx3FjtJ-gG0Rozr8A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Dec 2021 06:05:00 -0500 (EST)
Date:   Fri, 3 Dec 2021 12:04:58 +0100
From:   Greg KH <greg@kroah.com>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, pure.logic@nexus-software.ie,
        bjorn.andersson@linaro.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_psodagud@quicinc.com, quic_satyap@quicinc.com,
        quic_pheragu@quicinc.com, quic_rjendra@quicinc.com,
        quic_sibis@quicinc.com, quic_saipraka@quicinc.com
Subject: Re: [PATCH V2 5/8] soc: qcom: eud: Add driver support for Embedded
 USB Debugger(EUD)
Message-ID: <Yan52hNKKZMgzleI@kroah.com>
References: <cover.1638430506.git.quic_schowdhu@quicinc.com>
 <e13421cebfcddda5e7df99a8cf767854d121976e.1638430506.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e13421cebfcddda5e7df99a8cf767854d121976e.1638430506.git.quic_schowdhu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 03:21:24PM +0530, Souradeep Chowdhury wrote:
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
>  drivers/soc/qcom/qcom_eud.c                | 268 +++++++++++++++++++++++++++++
>  4 files changed, 288 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-eud
>  create mode 100644 drivers/soc/qcom/qcom_eud.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-eud b/Documentation/ABI/testing/sysfs-driver-eud
> new file mode 100644
> index 0000000..eaf2e82
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-eud
> @@ -0,0 +1,9 @@
> +What:		/sys/bus/platform/drivers/eud/.../enable
> +Date:           October 2021

You sent this patch in December 2021 :(



> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
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
> index 0000000..613ac41
> --- /dev/null
> +++ b/drivers/soc/qcom/qcom_eud.c
> @@ -0,0 +1,268 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2015-2021, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
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
> +	void __iomem			*eud_mode_mgr2_phys_base;
> +	unsigned int			int_status;
> +	int				eud_irq;
> +	bool				enable;
> +	bool				usb_attach;
> +
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
> +
> +static struct attribute_group attr_group = {
> +	.attrs = eud_attrs,
> +};
> +
> +static const struct attribute_group *attr_groups[] = {
> +	&attr_group,
> +	NULL
> +};

ATTRIBUTE_GROUPS()?

thanks,

greg k-h
