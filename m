Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231EB4617E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343606AbhK2OYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 09:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350722AbhK2OWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:22:33 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B88C08EC92
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 05:01:12 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a18so36642571wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 05:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YuDZQ+w6Hc8OiavcGXlnDPiWix6KnGw20xisnoy3oq4=;
        b=p9T8XL65IIam07J0uTWlQmqIc8eUB2z1KONAu+8lWsc/9pCVZ7llhDBHeFmaFb0nSm
         XJLlKX5EB4fM/dOsMM9zV5bnyL16rOpLiE1WcNDqf0hhak7Eppdt0XXRkuY/ulJ7kSuO
         3becgABrB+684EvOJkJ3ByuBG16owogmyaCwXI1YNSQLhmZVRCx8eI/VqGNQQKtXYF0E
         3GeKkTN4neXoLcF24zT28Fgz40qhojXLgi6PhwKrhJhOKgv2vi3Rz6RRRB8ZNHNSuO4v
         h3Tj108pv78j78Tr8V0W/cgR7WWo9tBgC/r6DNjcvluCR0R89ATcPUrqETM0izC3IqaI
         7XlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YuDZQ+w6Hc8OiavcGXlnDPiWix6KnGw20xisnoy3oq4=;
        b=8NJfbU+VKcKoOIu2agHzIdpc90eqgVqVhQAGn7hPEQMImcwKiD8SfEn4HKx+6rUUN0
         wYlNgV35w2K/xo00LEM6n5zlnxg/jHKvwACo4RwHHD6xh80dsAg/kvlLPC9HueUQld0t
         VsbEcXuStiD/KJoHIMUuWBtHSjpnS/oyeNC/mAvRj3MBqNFiKISruf6kbN70H1MCFM+6
         SVWKd7SHfxohwmCSMN7XpS18BJvBuFAG3zv9JIGd6RFQuxupXzVeXjX2J4a1AE/ieI6s
         66WpaL8zjgFi2P4sYXP/rp9QySVwegOHoLzUoFjoLUHOGUsqkb08jzhstFcNZe5YKtdg
         Ipcg==
X-Gm-Message-State: AOAM533XvEh87WiecJHj9GS4EaxtyXGUMoGjfst5Ty3hII7kgxMii/f4
        HD0XBeb0AeizM4XXVsDpWweKsw==
X-Google-Smtp-Source: ABdhPJxK6mFrZqwrM8W8VMdkKB82NMm5CAx+Hin5GLPtdn69nKqGiSw7Dy3oMwVsImFr36Q73N0GCQ==
X-Received: by 2002:adf:ce8b:: with SMTP id r11mr34018639wrn.294.1638190870607;
        Mon, 29 Nov 2021 05:01:10 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id o4sm16748891wry.80.2021.11.29.05.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 05:01:10 -0800 (PST)
Date:   Mon, 29 Nov 2021 13:01:08 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: Kconfig: change INTEL_SOC_PMIC_CHTDC_TI to bool
Message-ID: <YaTPFEXmAEduJ916@google.com>
References: <f12ed3dea697e6fdcfcaf9b6cc862ffa7aac005b.1635490923.git.mchehab+huawei@kernel.org>
 <YZ5c0LO5Ocaq+B7c@google.com>
 <ed1e0e2f-25a0-91a9-9f0b-a41b391ee869@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed1e0e2f-25a0-91a9-9f0b-a41b391ee869@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021, Hans de Goede wrote:

> Hi,
> 
> On 11/24/21 16:40, Lee Jones wrote:
> > On Fri, 29 Oct 2021, Mauro Carvalho Chehab wrote:
> > 
> >> The INTEL_SOC_PMIC_CHTDC_TI should be initialized early, before
> >> loading the fbcon driver, as otherwise the i915 driver will
> >> fail to configure pwm:
> >>
> >> [   13.674287] fb0: switching to inteldrmfb from EFI VGA
> >> [   13.682380] Console: switching to colour dummy device 80x25
> >> [   13.682468] i915 0000:00:02.0: vgaarb: deactivate vga console
> >> [   13.682686] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> >> [   13.685773] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> >> [   13.686219] i915 0000:00:02.0: [drm] *ERROR* Failed to configure the pwm chip
> >> [   13.699572] [drm] Initialized i915 1.6.0 20200313 for 0000:00:02.0 on minor 0
> >> [   13.739044] fbcon: i915drmfb (fb0) is primary device
> >> [   14.037792] intel_soc_pmic_exec_mipi_pmic_seq_element: No PMIC registered
> >> ...
> >> [   24.621403] intel_pmic_install_opregion_handler: Ask to register OpRegion for bus ID=PMI2, HID=INT33F5
> >> [   24.630540] intel_pmic_install_opregion_handler: OpRegion registered
> >>
> >> (some extra debug printk's were added to the above)
> >>
> >> As suggested by Hans, this patch also addresses an issue with
> >> the dependencies, as, for this driver to be a bool, it also
> >> need the I2C core and the I2C_DESIGNWARE driver to be builtin.
> >>
> >> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> >> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >> ---
> >>  drivers/mfd/Kconfig | 6 +++++-
> >>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> >> index ca0edab91aeb..f9092c79c4e8 100644
> >> --- a/drivers/mfd/Kconfig
> >> +++ b/drivers/mfd/Kconfig
> >> @@ -632,7 +632,7 @@ config INTEL_SOC_PMIC_CHTWC
> >>  config INTEL_SOC_PMIC_CHTDC_TI
> >>  	tristate "Support for Intel Cherry Trail Dollar Cove TI PMIC"
> >>  	depends on GPIOLIB
> >> -	depends on I2C
> >> +	depends on I2C = y && I2C_DESIGNWARE_PLATFORM=y
> > 
> > The lack of formatting consistency here is eating me up inside!
> > 
> >>  	depends on ACPI
> >>  	depends on X86
> >>  	select MFD_CORE
> >> @@ -642,6 +642,10 @@ config INTEL_SOC_PMIC_CHTDC_TI
> >>  	  Select this option for supporting Dollar Cove (TI version) PMIC
> >>  	  device that is found on some Intel Cherry Trail systems.
> >>  
> >> +	  This option is a bool as it provides an ACPI OpRegion which must be
> >> +	  available before any devices using it are probed. This option also
> >> +	  needs the designware-i2c driver to be builtin for the same reason.
> > 
> > Is there no way around this?
> 
> No unfortunately not, the ACPI device-scan is done really early,
> and in ACPI everything is a function, including e.g. _HID,
> so I've seen _HID method-s reading e.g. GPIOs. So while the
> initial ACPI scan is figuring out what sort of devices it
> is dealing with, we already need working GPIOs (for example).
> 
> Various early ACPI code (AML / the DSDT) tends to access the
> PMICs OpRegion and various problems happen when it is not
> available. For the same reason the other BYT/CHT related
> INTEL_SOC_PMIC_FOO options are already bools.
> 
> I guess that the DSDTs for other Intel SoCs then the BYT/CHT
> SoCs might be a bit cleaner. BYT/CHT was Intel's first serious
> attempt at standard x86 tablet SoC and this shows in various
> places.

Thanks for the explanation.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
