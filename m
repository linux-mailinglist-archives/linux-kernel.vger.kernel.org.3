Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051F9493F43
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356524AbiASRor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:44:47 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]:46044 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356519AbiASRo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:44:26 -0500
Received: by mail-qv1-f53.google.com with SMTP id 15so3897845qvp.12;
        Wed, 19 Jan 2022 09:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w6ErTGvgHe67gNzRtGnvhidwqqNvSKerDvzsL2m5wv8=;
        b=gJx1oCoMxbYAQBjyW8yEmVIAspH5Xe/W7LBPb0b5gX7598TQa+ZBY+/57CEzvQ/pWW
         GDtSAgDZBpduRIXgN+CdyVd5izoIx+qfTtp/QjK4J9HbsrR5zPXPzZfwZaCWVS6LFGiC
         PCxNRiXsjua/asPq8z4LGLSZuBsFMR8SnUQ08z/VkbB+voAA7x1LSKDshWL2tpD4w1Id
         WtqduDWw5aJ/KjQDVqcun7/9Z8oGi3URVDxBchuW3YGoJWymKzecWzp9g6or72r3yPsj
         fAu4TxRGi4WgTHGcfYDDS+KVBkrZbMWd32x9EQMi0Cu6qywVwwd/6q8Eg/srDni4SVEW
         Ra9A==
X-Gm-Message-State: AOAM531A7pT32R5O+11jEgwLasMgntwD9Q/5lwMPHwKdJt18I+dtS8/u
        aBqZiWQdH4pzTvjXK4Gwcb1ce9MYx/L3/okYCr0=
X-Google-Smtp-Source: ABdhPJzI3lLGuR3qUzh5KbBVc/sdRf2oVrQ/kIBS+lpxwoBt3e1yuaPz0CEjFf17i0UqEVApbLEKOwx1R40x8nHA6I4=
X-Received: by 2002:a05:6214:2469:: with SMTP id im9mr16635370qvb.52.1642614265659;
 Wed, 19 Jan 2022 09:44:25 -0800 (PST)
MIME-Version: 1.0
References: <20220118145251.1548-1-sbinding@opensource.cirrus.com>
 <20220118145251.1548-6-sbinding@opensource.cirrus.com> <CAJZ5v0g0n201FPcG9LBNG3e4UdNYSWmj_1sN3MxLxmK=GoF+tA@mail.gmail.com>
 <a3522b5e-fb36-b959-d2ea-d141d3ad9999@opensource.cirrus.com>
In-Reply-To: <a3522b5e-fb36-b959-d2ea-d141d3ad9999@opensource.cirrus.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Jan 2022 18:44:14 +0100
Message-ID: <CAJZ5v0h8MWb3sSuqWHUcm9TVWP0uJ+=GmzAuqVtNag2LP+0kYQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] platform/x86: i2c-multi-instantiate: Move it to
 drivers/acpi folder
To:     Lucas tanure <tanureal@opensource.cirrus.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>,
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
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 6:33 PM Lucas tanure
<tanureal@opensource.cirrus.com> wrote:
>
> On 1/19/22 16:53, Rafael J. Wysocki wrote:
> > On Tue, Jan 18, 2022 at 3:53 PM Stefan Binding
> > <sbinding@opensource.cirrus.com> wrote:
> >>
> >> From: Lucas Tanure <tanureal@opensource.cirrus.com>
> >>
> >> Moving I2C multi instantiate driver to drivers/acpi folder for
> >> upcoming conversion into a generic bus multi instantiate
> >> driver for SPI and I2C
> >>
> >> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> >> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> >
> > Why are you moving it away from platform/x86?
> >
> > Adding SPI to the mix doesn't seem to be a sufficient reason.
> >
> > If this were going to be needed on non-x86, that would be a good
> > reason for moving it, but is that actually the case?  If so, why isn't
> > that mentioned in the changelog above?
> >
>
> It was a request made by Andy Shevchenko:
> https://lkml.org/lkml/2021/12/3/347

But he hasn't given any reasons why that'd be better.

> There is no plan to use our CS35L41 HDA with non-x86 platforms and we
> can't comment about i2c-multi-instantiate use.
> For us it can stay in x86 folder until an actual request.

I'd prefer that if Hans agrees.

> >> ---
> >>   MAINTAINERS                                           |  2 +-
> >>   drivers/acpi/Kconfig                                  | 11 +++++++++++
> >>   drivers/acpi/Makefile                                 |  1 +
> >>   .../{platform/x86 => acpi}/i2c-multi-instantiate.c    |  0
> >>   drivers/acpi/scan.c                                   |  2 +-
> >>   drivers/platform/x86/Kconfig                          | 11 -----------
> >>   drivers/platform/x86/Makefile                         |  1 -
> >>   7 files changed, 14 insertions(+), 14 deletions(-)
> >>   rename drivers/{platform/x86 => acpi}/i2c-multi-instantiate.c (100%)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 4e828542b089..546f9e149d28 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -392,7 +392,7 @@ ACPI I2C MULTI INSTANTIATE DRIVER
> >>   M:     Hans de Goede <hdegoede@redhat.com>
> >>   L:     platform-driver-x86@vger.kernel.org
> >>   S:     Maintained
> >> -F:     drivers/platform/x86/i2c-multi-instantiate.c
> >> +F:     drivers/acpi/i2c-multi-instantiate.c
> >>
> >>   ACPI PCC(Platform Communication Channel) MAILBOX DRIVER
> >>   M:     Sudeep Holla <sudeep.holla@arm.com>
> >> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> >> index ba45541b1f1f..2fd78366af6f 100644
> >> --- a/drivers/acpi/Kconfig
> >> +++ b/drivers/acpi/Kconfig
> >> @@ -295,6 +295,17 @@ config ACPI_PROCESSOR
> >>            To compile this driver as a module, choose M here:
> >>            the module will be called processor.
> >>
> >> +config ACPI_I2C_MULTI_INST
> >> +       tristate "I2C multi instantiate pseudo device driver"
> >> +       depends on I2C
> >> +       help
> >> +         Some ACPI-based systems list multiple i2c-devices in a single ACPI
> >> +         firmware-node. This driver will instantiate separate i2c-clients
> >> +         for each device in the firmware-node.
> >> +
> >> +         To compile this driver as a module, choose M here: the module
> >> +         will be called i2c-multi-instantiate.
> >> +
> >>   config ACPI_IPMI
> >>          tristate "IPMI"
> >>          depends on IPMI_HANDLER
> >> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> >> index bb757148e7ba..d4db7fb0baf0 100644
> >> --- a/drivers/acpi/Makefile
> >> +++ b/drivers/acpi/Makefile
> >> @@ -104,6 +104,7 @@ obj-$(CONFIG_ACPI_SPCR_TABLE)       += spcr.o
> >>   obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
> >>   obj-$(CONFIG_ACPI_PPTT)        += pptt.o
> >>   obj-$(CONFIG_ACPI_PFRUT)       += pfr_update.o pfr_telemetry.o
> >> +obj-$(CONFIG_ACPI_I2C_MULTI_INST)      += i2c-multi-instantiate.o
> >>
> >>   # processor has its own "processor." module_param namespace
> >>   processor-y                    := processor_driver.o
> >> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/acpi/i2c-multi-instantiate.c
> >> similarity index 100%
> >> rename from drivers/platform/x86/i2c-multi-instantiate.c
> >> rename to drivers/acpi/i2c-multi-instantiate.c
> >> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> >> index 1331756d4cfc..3e85a02f6ba2 100644
> >> --- a/drivers/acpi/scan.c
> >> +++ b/drivers/acpi/scan.c
> >> @@ -1738,7 +1738,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
> >>           * must be instantiated for each, each with its own i2c_device_id.
> >>           * Normally we only instantiate an i2c-client for the first resource,
> >>           * using the ACPI HID as id. These special cases are handled by the
> >> -        * drivers/platform/x86/i2c-multi-instantiate.c driver, which knows
> >> +        * drivers/acpi/i2c-multi-instantiate.c driver, which knows
> >>           * which i2c_device_id to use for each resource.
> >>           */
> >>                  {"BSG1160", },
> >> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> >> index 24deeeb29af2..37c1c150508d 100644
> >> --- a/drivers/platform/x86/Kconfig
> >> +++ b/drivers/platform/x86/Kconfig
> >> @@ -990,17 +990,6 @@ config TOPSTAR_LAPTOP
> >>
> >>            If you have a Topstar laptop, say Y or M here.
> >>
> >> -config I2C_MULTI_INSTANTIATE
> >> -       tristate "I2C multi instantiate pseudo device driver"
> >> -       depends on I2C && ACPI
> >> -       help
> >> -         Some ACPI-based systems list multiple i2c-devices in a single ACPI
> >> -         firmware-node. This driver will instantiate separate i2c-clients
> >> -         for each device in the firmware-node.
> >> -
> >> -         To compile this driver as a module, choose M here: the module
> >> -         will be called i2c-multi-instantiate.
> >> -
> >>   config MLX_PLATFORM
> >>          tristate "Mellanox Technologies platform support"
> >>          depends on I2C && REGMAP
> >> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> >> index c12a9b044fd8..6c7870190564 100644
> >> --- a/drivers/platform/x86/Makefile
> >> +++ b/drivers/platform/x86/Makefile
> >> @@ -110,7 +110,6 @@ obj-$(CONFIG_TOPSTAR_LAPTOP)        += topstar-laptop.o
> >>
> >>   # Platform drivers
> >>   obj-$(CONFIG_FW_ATTR_CLASS)            += firmware_attributes_class.o
> >> -obj-$(CONFIG_I2C_MULTI_INSTANTIATE)    += i2c-multi-instantiate.o
> >>   obj-$(CONFIG_MLX_PLATFORM)             += mlx-platform.o
> >>   obj-$(CONFIG_TOUCHSCREEN_DMI)          += touchscreen_dmi.o
> >>   obj-$(CONFIG_WIRELESS_HOTKEY)          += wireless-hotkey.o
> >> --
> >> 2.25.1
> >>
>
