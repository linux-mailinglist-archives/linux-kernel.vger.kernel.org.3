Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8356B4961D4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 16:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351064AbiAUPMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 10:12:16 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:39475 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241694AbiAUPMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 10:12:15 -0500
Received: by mail-qt1-f172.google.com with SMTP id bp39so10200117qtb.6;
        Fri, 21 Jan 2022 07:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lwwwetj9Z15qdGPN+sfrnFK0+GPWwzzJ2o52G648rd4=;
        b=ZFGv0tecV4Hqqc1NHkKp6uoUF9DKBLGJ1N6wlrLnFVFPqZDTfDsX9GeFtbAVA5oROf
         3+fsbDzhNVOXYJQWjK+2grBmrBMUxznwH/0VqyKt7voozBgJftivSyrR8WLWcQc7hlSs
         /faAAav8BOONe5YMCjJLwlIN/Qg90m5XxvN/yKL5kpGLKyj/vuy9LL9eZH2ATp8KOVxj
         U6E/OUEI8dgvKCCDcjyFWonKAsHyqQuX+8GayX7iHQTOEZzYYXmXww2bSQPk80ozyuJe
         Eh0kiQH6tYWft703Ir+cv/GxqGQihNoqwM4GnUvBBI2kcSq/YnOFpK5Tj9NdG4x6PKjd
         F0yA==
X-Gm-Message-State: AOAM531FyAkReNOmbA+x1dIICbpQLgKM2XfgOGugD5rxCJK3l8zRQCA8
        YgWRpBuSe0n3nH3cR+269CeT53iIsPknCnAkPuU=
X-Google-Smtp-Source: ABdhPJxPEC4wES1aap24N/oCcrtkVJsipKGFgzSFP6VvIs+kZnPssUE7gxkWND5KdtbzVSrQGzM8FgjwIX1MTwyafQo=
X-Received: by 2002:ac8:7d46:: with SMTP id h6mr3610275qtb.344.1642777934498;
 Fri, 21 Jan 2022 07:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20220121143254.6432-1-sbinding@opensource.cirrus.com> <20220121143254.6432-6-sbinding@opensource.cirrus.com>
In-Reply-To: <20220121143254.6432-6-sbinding@opensource.cirrus.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Jan 2022 16:12:03 +0100
Message-ID: <CAJZ5v0iSUCbuw0bhCMNyGA0GGmH6sBU9SjM56SALSnVhjQEDhw@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] platform/x86: i2c-multi-instantiate: Rename it for
 a generic serial driver name
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        patches@opensource.cirrus.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 3:33 PM Stefan Binding
<sbinding@opensource.cirrus.com> wrote:
>
> From: Lucas Tanure <tanureal@opensource.cirrus.com>
>
> Rename I2C multi instantiate driver to serial-multi-instantiate for
> upcoming addition of SPI support
>
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---
>  MAINTAINERS                                   |  4 +-
>  drivers/acpi/scan.c                           |  2 +-
>  drivers/platform/x86/Kconfig                  |  4 +-
>  drivers/platform/x86/Makefile                 |  2 +-
>  ...stantiate.c => serial-multi-instantiate.c} | 89 +++++++++----------
>  5 files changed, 50 insertions(+), 51 deletions(-)
>  rename drivers/platform/x86/{i2c-multi-instantiate.c => serial-multi-instantiate.c} (52%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4e828542b089..be50537ea6bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -388,11 +388,11 @@ L:        linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     drivers/acpi/arm64
>
> -ACPI I2C MULTI INSTANTIATE DRIVER
> +ACPI SERIAL MULTI INSTANTIATE DRIVER
>  M:     Hans de Goede <hdegoede@redhat.com>
>  L:     platform-driver-x86@vger.kernel.org
>  S:     Maintained
> -F:     drivers/platform/x86/i2c-multi-instantiate.c
> +F:     drivers/platform/x86/serial-multi-instantiate.c
>
>  ACPI PCC(Platform Communication Channel) MAILBOX DRIVER
>  M:     Sudeep Holla <sudeep.holla@arm.com>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 1331756d4cfc..8b237eb4e029 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1738,7 +1738,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>          * must be instantiated for each, each with its own i2c_device_id.
>          * Normally we only instantiate an i2c-client for the first resource,
>          * using the ACPI HID as id. These special cases are handled by the
> -        * drivers/platform/x86/i2c-multi-instantiate.c driver, which knows
> +        * drivers/platform/x86/serial-multi-instantiate.c driver, which knows
>          * which i2c_device_id to use for each resource.

This entire comment needs to be updated as well as the Kconfig option
description and the comment in the driver file.

I have noticed that this is generalized when adding the SPI support,
but it can be done right away here, for example as follows:

+ * These devices have multiple SerialBus resources and a client
+ * device must be instantiated for each of them, each with
+ * its own device id.
+ * Normally we only instantiate one client device for the first
+ * resource, using the ACPI HID as id. These special cases are handled
+ * by the drivers/platform/x86/serial-multi-instantiate.c driver, which
+ * knows which client device id to use for each resource.

>          */
>                 {"BSG1160", },
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 24deeeb29af2..5b65d687f046 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -990,7 +990,7 @@ config TOPSTAR_LAPTOP
>
>           If you have a Topstar laptop, say Y or M here.
>
> -config I2C_MULTI_INSTANTIATE
> +config SERIAL_MULTI_INSTANTIATE
>         tristate "I2C multi instantiate pseudo device driver"

So this would be "Serial bus multi instantiate pseudo device driver"

>         depends on I2C && ACPI
>         help
> @@ -999,7 +999,7 @@ config I2C_MULTI_INSTANTIATE
>           for each device in the firmware-node.
>
>           To compile this driver as a module, choose M here: the module
> -         will be called i2c-multi-instantiate.
> +         will be called serial-multi-instantiate.
>
>  config MLX_PLATFORM
>         tristate "Mellanox Technologies platform support"
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index c12a9b044fd8..9527088bba7f 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -110,7 +110,7 @@ obj-$(CONFIG_TOPSTAR_LAPTOP)        += topstar-laptop.o
>
>  # Platform drivers
>  obj-$(CONFIG_FW_ATTR_CLASS)            += firmware_attributes_class.o
> -obj-$(CONFIG_I2C_MULTI_INSTANTIATE)    += i2c-multi-instantiate.o
> +obj-$(CONFIG_SERIAL_MULTI_INSTANTIATE) += serial-multi-instantiate.o
>  obj-$(CONFIG_MLX_PLATFORM)             += mlx-platform.o
>  obj-$(CONFIG_TOUCHSCREEN_DMI)          += touchscreen_dmi.o
>  obj-$(CONFIG_WIRELESS_HOTKEY)          += wireless-hotkey.o
> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
> similarity index 52%
> rename from drivers/platform/x86/i2c-multi-instantiate.c
> rename to drivers/platform/x86/serial-multi-instantiate.c
> index 4956a1df5b90..32fb3f904547 100644
> --- a/drivers/platform/x86/i2c-multi-instantiate.c
> +++ b/drivers/platform/x86/serial-multi-instantiate.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * I2C multi-instantiate driver, pseudo driver to instantiate multiple
> + * Serial multi-instantiate driver, pseudo driver to instantiate multiple
>   * i2c-clients from a single fwnode.

s/i2c-clients/client devices/

so you don't have to touch these comments again in the subsequent patches.

>   *
>   * Copyright 2018 Hans de Goede <hdegoede@redhat.com>
> @@ -21,29 +21,29 @@
>  #define IRQ_RESOURCE_GPIO      1
>  #define IRQ_RESOURCE_APIC      2
>
> -struct i2c_inst_data {
> +struct smi_instance {
>         const char *type;
>         unsigned int flags;
>         int irq_idx;
>  };
>
> -struct i2c_multi_inst_data {
> -       int num_clients;
> -       struct i2c_client *clients[];
> +struct smi {
> +       int i2c_num;
> +       struct i2c_client *i2c_devs[];
>  };
>
> -static int i2c_multi_inst_probe(struct platform_device *pdev)
> +static int smi_probe(struct platform_device *pdev)
>  {
> -       struct i2c_multi_inst_data *multi;
> -       const struct i2c_inst_data *inst_data;
>         struct i2c_board_info board_info = {};
> +       const struct smi_instance *inst;
>         struct device *dev = &pdev->dev;
>         struct acpi_device *adev;
> +       struct smi *smi;
>         char name[32];
>         int i, ret;
>
> -       inst_data = device_get_match_data(dev);
> -       if (!inst_data) {
> +       inst = device_get_match_data(dev);
> +       if (!inst) {
>                 dev_err(dev, "Error ACPI match data is missing\n");
>                 return -ENODEV;
>         }
> @@ -55,33 +55,32 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
>         if (ret < 0)
>                 return ret;
>
> -       multi = devm_kmalloc(dev, struct_size(multi, clients, ret), GFP_KERNEL);
> -       if (!multi)
> +       smi = devm_kmalloc(dev, struct_size(smi, i2c_devs, ret), GFP_KERNEL);
> +       if (!smi)
>                 return -ENOMEM;
>
> -       multi->num_clients = ret;
> +       smi->i2c_num = ret;
>
> -       for (i = 0; i < multi->num_clients && inst_data[i].type; i++) {
> +       for (i = 0; i < smi->i2c_num && inst[i].type; i++) {
>                 memset(&board_info, 0, sizeof(board_info));
> -               strlcpy(board_info.type, inst_data[i].type, I2C_NAME_SIZE);
> -               snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev),
> -                        inst_data[i].type, i);
> +               strlcpy(board_info.type, inst[i].type, I2C_NAME_SIZE);
> +               snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev), inst[i].type, i);
>                 board_info.dev_name = name;
> -               switch (inst_data[i].flags & IRQ_RESOURCE_TYPE) {
> +               switch (inst[i].flags & IRQ_RESOURCE_TYPE) {
>                 case IRQ_RESOURCE_GPIO:
> -                       ret = acpi_dev_gpio_irq_get(adev, inst_data[i].irq_idx);
> +                       ret = acpi_dev_gpio_irq_get(adev, inst[i].irq_idx);
>                         if (ret < 0) {
>                                 dev_err(dev, "Error requesting irq at index %d: %d\n",
> -                                       inst_data[i].irq_idx, ret);
> +                                               inst[i].irq_idx, ret);
>                                 goto error;
>                         }
>                         board_info.irq = ret;
>                         break;
>                 case IRQ_RESOURCE_APIC:
> -                       ret = platform_get_irq(pdev, inst_data[i].irq_idx);
> +                       ret = platform_get_irq(pdev, inst[i].irq_idx);
>                         if (ret < 0) {
>                                 dev_dbg(dev, "Error requesting irq at index %d: %d\n",
> -                                       inst_data[i].irq_idx, ret);
> +                                       inst[i].irq_idx, ret);
>                                 goto error;
>                         }
>                         board_info.irq = ret;
> @@ -90,48 +89,48 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
>                         board_info.irq = 0;
>                         break;
>                 }
> -               multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
> -               if (IS_ERR(multi->clients[i])) {
> -                       ret = dev_err_probe(dev, PTR_ERR(multi->clients[i]),
> +               smi->i2c_devs[i] = i2c_acpi_new_device(dev, i, &board_info);
> +               if (IS_ERR(smi->i2c_devs[i])) {
> +                       ret = dev_err_probe(dev, PTR_ERR(smi->i2c_devs[i]),
>                                             "Error creating i2c-client, idx %d\n", i);
>                         goto error;
>                 }
>         }
> -       if (i < multi->num_clients) {
> +       if (i < smi->i2c_num) {
>                 dev_err(dev, "Error finding driver, idx %d\n", i);
>                 ret = -ENODEV;
>                 goto error;
>         }
>
> -       platform_set_drvdata(pdev, multi);
> +       platform_set_drvdata(pdev, smi);
>         return 0;
>
>  error:
>         while (--i >= 0)
> -               i2c_unregister_device(multi->clients[i]);
> +               i2c_unregister_device(smi->i2c_devs[i]);
>
>         return ret;
>  }
>
> -static int i2c_multi_inst_remove(struct platform_device *pdev)
> +static int smi_remove(struct platform_device *pdev)
>  {
> -       struct i2c_multi_inst_data *multi = platform_get_drvdata(pdev);
> +       struct smi *smi = platform_get_drvdata(pdev);
>         int i;
>
> -       for (i = 0; i < multi->num_clients; i++)
> -               i2c_unregister_device(multi->clients[i]);
> +       for (i = 0; i < smi->i2c_num; i++)
> +               i2c_unregister_device(smi->i2c_devs[i]);
>
>         return 0;
>  }
>
> -static const struct i2c_inst_data bsg1160_data[]  = {
> +static const struct smi_instance bsg1160_data[]  = {
>         { "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
>         { "bmc150_magn" },
>         { "bmg160" },
>         {}
>  };
>
> -static const struct i2c_inst_data bsg2150_data[]  = {
> +static const struct smi_instance bsg2150_data[]  = {
>         { "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
>         { "bmc150_magn" },
>         /* The resources describe a 3th client, but it is not really there. */
> @@ -139,7 +138,7 @@ static const struct i2c_inst_data bsg2150_data[]  = {
>         {}
>  };
>
> -static const struct i2c_inst_data int3515_data[]  = {
> +static const struct smi_instance int3515_data[]  = {
>         { "tps6598x", IRQ_RESOURCE_APIC, 0 },
>         { "tps6598x", IRQ_RESOURCE_APIC, 1 },
>         { "tps6598x", IRQ_RESOURCE_APIC, 2 },
> @@ -148,27 +147,27 @@ static const struct i2c_inst_data int3515_data[]  = {
>  };
>
>  /*
> - * Note new device-ids must also be added to i2c_multi_instantiate_ids in
> + * Note new device-ids must also be added to serial_multi_instantiate_ids in
>   * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
>   */
> -static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
> +static const struct acpi_device_id smi_acpi_ids[] = {
>         { "BSG1160", (unsigned long)bsg1160_data },
>         { "BSG2150", (unsigned long)bsg2150_data },
>         { "INT3515", (unsigned long)int3515_data },
>         { }
>  };
> -MODULE_DEVICE_TABLE(acpi, i2c_multi_inst_acpi_ids);
> +MODULE_DEVICE_TABLE(acpi, smi_acpi_ids);
>
> -static struct platform_driver i2c_multi_inst_driver = {
> +static struct platform_driver smi_driver = {
>         .driver = {
> -               .name = "I2C multi instantiate pseudo device driver",
> -               .acpi_match_table = i2c_multi_inst_acpi_ids,
> +               .name = "Serial multi instantiate pseudo device driver",
> +               .acpi_match_table = smi_acpi_ids,
>         },
> -       .probe = i2c_multi_inst_probe,
> -       .remove = i2c_multi_inst_remove,
> +       .probe = smi_probe,
> +       .remove = smi_remove,
>  };
> -module_platform_driver(i2c_multi_inst_driver);
> +module_platform_driver(smi_driver);
>
> -MODULE_DESCRIPTION("I2C multi instantiate pseudo device driver");
> +MODULE_DESCRIPTION("Serial multi instantiate pseudo device driver");
>  MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
>  MODULE_LICENSE("GPL");
> --
> 2.25.1
>
