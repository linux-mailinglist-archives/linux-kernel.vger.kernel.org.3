Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99DE493E98
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344405AbiASQxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:53:17 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:38658 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbiASQxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:53:16 -0500
Received: by mail-qt1-f182.google.com with SMTP id bb9so2589637qtb.5;
        Wed, 19 Jan 2022 08:53:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rSEzk8BcF5dmOAChCxcAbNaCIVCH+wJKAituA5N0HnY=;
        b=uSm0CheGzLFBIntxYknUew/xQTQooK0Rt7XoO0jUsqGg+rpBTYQjbCYicb1swD/KNB
         8k03tqdpxLWtvJwlJl1kOU5IZw7+5BryeUXhYLNMW0rpdj7tSnldhgzLSN0DA95/QqtZ
         Gp1SwmpltAKQ0r1ODmqEpNEOHb/vfRdkWTgeCWvuK5WrA8R4FozV/5kvsH06SgHClSua
         A3Bo9NizYTQnBfEBGbJouRMwJ6H34qlzZA+SamLsspkEBaAq4cPgzNSUrXpYShVRjHOg
         cqPmawZ2esMCeZiZTtlny+PkFqVX2iihWEl8xEs4Qsk0uMwsr1f0Z58+/vlR+wE5x+e5
         jsMA==
X-Gm-Message-State: AOAM5306ejJ/pmgQZbA/2vZ2TWUgoLIc9w5TmTLWl2eAFs1zJodUS6K2
        dZxcHR1qXCCqRCe4w8OUCRxY8NQpuOTKXk3+H+mBsEmi
X-Google-Smtp-Source: ABdhPJxL6fAiWPnaDWtmGlMi8gk6mzbi83/3qUonNzAa3s8SLHRIwSduaptcTiEeu+Awb67ILI4/Jr/XlzTEvfA7fWw=
X-Received: by 2002:a05:622a:1881:: with SMTP id v1mr25662181qtc.327.1642611196009;
 Wed, 19 Jan 2022 08:53:16 -0800 (PST)
MIME-Version: 1.0
References: <20220118145251.1548-1-sbinding@opensource.cirrus.com> <20220118145251.1548-6-sbinding@opensource.cirrus.com>
In-Reply-To: <20220118145251.1548-6-sbinding@opensource.cirrus.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Jan 2022 17:53:05 +0100
Message-ID: <CAJZ5v0g0n201FPcG9LBNG3e4UdNYSWmj_1sN3MxLxmK=GoF+tA@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] platform/x86: i2c-multi-instantiate: Move it to
 drivers/acpi folder
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

On Tue, Jan 18, 2022 at 3:53 PM Stefan Binding
<sbinding@opensource.cirrus.com> wrote:
>
> From: Lucas Tanure <tanureal@opensource.cirrus.com>
>
> Moving I2C multi instantiate driver to drivers/acpi folder for
> upcoming conversion into a generic bus multi instantiate
> driver for SPI and I2C
>
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>

Why are you moving it away from platform/x86?

Adding SPI to the mix doesn't seem to be a sufficient reason.

If this were going to be needed on non-x86, that would be a good
reason for moving it, but is that actually the case?  If so, why isn't
that mentioned in the changelog above?

> ---
>  MAINTAINERS                                           |  2 +-
>  drivers/acpi/Kconfig                                  | 11 +++++++++++
>  drivers/acpi/Makefile                                 |  1 +
>  .../{platform/x86 => acpi}/i2c-multi-instantiate.c    |  0
>  drivers/acpi/scan.c                                   |  2 +-
>  drivers/platform/x86/Kconfig                          | 11 -----------
>  drivers/platform/x86/Makefile                         |  1 -
>  7 files changed, 14 insertions(+), 14 deletions(-)
>  rename drivers/{platform/x86 => acpi}/i2c-multi-instantiate.c (100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4e828542b089..546f9e149d28 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -392,7 +392,7 @@ ACPI I2C MULTI INSTANTIATE DRIVER
>  M:     Hans de Goede <hdegoede@redhat.com>
>  L:     platform-driver-x86@vger.kernel.org
>  S:     Maintained
> -F:     drivers/platform/x86/i2c-multi-instantiate.c
> +F:     drivers/acpi/i2c-multi-instantiate.c
>
>  ACPI PCC(Platform Communication Channel) MAILBOX DRIVER
>  M:     Sudeep Holla <sudeep.holla@arm.com>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index ba45541b1f1f..2fd78366af6f 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -295,6 +295,17 @@ config ACPI_PROCESSOR
>           To compile this driver as a module, choose M here:
>           the module will be called processor.
>
> +config ACPI_I2C_MULTI_INST
> +       tristate "I2C multi instantiate pseudo device driver"
> +       depends on I2C
> +       help
> +         Some ACPI-based systems list multiple i2c-devices in a single ACPI
> +         firmware-node. This driver will instantiate separate i2c-clients
> +         for each device in the firmware-node.
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called i2c-multi-instantiate.
> +
>  config ACPI_IPMI
>         tristate "IPMI"
>         depends on IPMI_HANDLER
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index bb757148e7ba..d4db7fb0baf0 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -104,6 +104,7 @@ obj-$(CONFIG_ACPI_SPCR_TABLE)       += spcr.o
>  obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
>  obj-$(CONFIG_ACPI_PPTT)        += pptt.o
>  obj-$(CONFIG_ACPI_PFRUT)       += pfr_update.o pfr_telemetry.o
> +obj-$(CONFIG_ACPI_I2C_MULTI_INST)      += i2c-multi-instantiate.o
>
>  # processor has its own "processor." module_param namespace
>  processor-y                    := processor_driver.o
> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/acpi/i2c-multi-instantiate.c
> similarity index 100%
> rename from drivers/platform/x86/i2c-multi-instantiate.c
> rename to drivers/acpi/i2c-multi-instantiate.c
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 1331756d4cfc..3e85a02f6ba2 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1738,7 +1738,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>          * must be instantiated for each, each with its own i2c_device_id.
>          * Normally we only instantiate an i2c-client for the first resource,
>          * using the ACPI HID as id. These special cases are handled by the
> -        * drivers/platform/x86/i2c-multi-instantiate.c driver, which knows
> +        * drivers/acpi/i2c-multi-instantiate.c driver, which knows
>          * which i2c_device_id to use for each resource.
>          */
>                 {"BSG1160", },
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 24deeeb29af2..37c1c150508d 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -990,17 +990,6 @@ config TOPSTAR_LAPTOP
>
>           If you have a Topstar laptop, say Y or M here.
>
> -config I2C_MULTI_INSTANTIATE
> -       tristate "I2C multi instantiate pseudo device driver"
> -       depends on I2C && ACPI
> -       help
> -         Some ACPI-based systems list multiple i2c-devices in a single ACPI
> -         firmware-node. This driver will instantiate separate i2c-clients
> -         for each device in the firmware-node.
> -
> -         To compile this driver as a module, choose M here: the module
> -         will be called i2c-multi-instantiate.
> -
>  config MLX_PLATFORM
>         tristate "Mellanox Technologies platform support"
>         depends on I2C && REGMAP
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index c12a9b044fd8..6c7870190564 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -110,7 +110,6 @@ obj-$(CONFIG_TOPSTAR_LAPTOP)        += topstar-laptop.o
>
>  # Platform drivers
>  obj-$(CONFIG_FW_ATTR_CLASS)            += firmware_attributes_class.o
> -obj-$(CONFIG_I2C_MULTI_INSTANTIATE)    += i2c-multi-instantiate.o
>  obj-$(CONFIG_MLX_PLATFORM)             += mlx-platform.o
>  obj-$(CONFIG_TOUCHSCREEN_DMI)          += touchscreen_dmi.o
>  obj-$(CONFIG_WIRELESS_HOTKEY)          += wireless-hotkey.o
> --
> 2.25.1
>
