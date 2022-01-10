Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF89D489C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbiAJPqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiAJPqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:46:02 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8B0C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 07:46:01 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v6so27496602wra.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 07:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=C+UY/NmaE60AUbHu47tzLSymseBsSR2l/6lvMbytdBE=;
        b=ScP5DNP1elayP5hAM/lZFyiQ13O2ODkX0gEzgWTe7OqlwIiu2wffbT3hhsslzS4tlj
         /SzhTrzlrTDVdctxw9hD12IINnsHxfVe1c4qnCdM8Wt29Ti1jYv/e91ZkMaBJw5OTtBl
         OdSV8eeJxwSL3lLTVJuRTLNcdT/VpsTmZ4HA93PdTXma9JY23vyMvgofT1m1CyUZG1Pd
         GYEIxdHCokUEokEqqiTpeKBDvyLPCMWrp1KpC/DExh7rYuc/Qgj2u+kSHTOnGh3J6Iuc
         iBX7ymnW2p0jYYLnqbZvLsQko9RjiA14KWYPCbc0Fk561Ui5+ellw+hhFErhnv8YfnDJ
         GLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=C+UY/NmaE60AUbHu47tzLSymseBsSR2l/6lvMbytdBE=;
        b=AYsCB4n2QPuoMd8WNzxYuLx5GEtFSWOY3DM9T60Px4ZcjG4CmKMa2IRvhC35LsxfI1
         481GTynQAA09pTwAZPhceXKPTDEYX44sNqTzA0cQXzBPUEWv1DV2j/w6kDrz2bjPb3c+
         WhIFdWQyd2Ldb3gSfcHcdrs3bVkCuD2SGWqQfKWWGZrNYGPlUh2G5VruAMVOntuXWNB4
         M8U/inIesfWfjgsUESOpYm89FL9hQfe4r1uB5YhOxsmn0S48m9eHcxlXJbeyoI//nOzR
         3kQp+s88COp9U2Drv1ikVdp3pk042e+a7gkPh38b5vWw8tmJ5UT0/HLEr1FpXeFxoItR
         qRmw==
X-Gm-Message-State: AOAM530efCpw+4F7PwHak0k99WR/G7Kt1ygIydsVgvR4d9PKVIJRxhTc
        0HrRX9Jk62nJZ4bygj/bBrR5AA==
X-Google-Smtp-Source: ABdhPJyDPpSZ+cM/2H57+qk2lM37rw8wzFZPjIAbAJNcQVvFDfwSGONEfe039x1nXvmzdIiGDYETag==
X-Received: by 2002:a5d:50ca:: with SMTP id f10mr196893wrt.696.1641829560426;
        Mon, 10 Jan 2022 07:46:00 -0800 (PST)
Received: from google.com ([31.124.24.179])
        by smtp.gmail.com with ESMTPSA id ba18sm7039314wrb.40.2022.01.10.07.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 07:45:59 -0800 (PST)
Date:   Mon, 10 Jan 2022 15:45:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] mfd: Kconfig: change INTEL_SOC_PMIC_CHTDC_TI to bool
Message-ID: <YdxUtpI8nvjj2ss7@google.com>
References: <86f546b3233fd799b0c39b83afc521440ebfe004.1638192232.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86f546b3233fd799b0c39b83afc521440ebfe004.1638192232.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021, Mauro Carvalho Chehab wrote:

> The INTEL_SOC_PMIC_CHTDC_TI should be initialized early, before
> loading the fbcon driver, as otherwise the i915 driver will
> fail to configure pwm:
> 
> [   13.674287] fb0: switching to inteldrmfb from EFI VGA
> [   13.682380] Console: switching to colour dummy device 80x25
> [   13.682468] i915 0000:00:02.0: vgaarb: deactivate vga console
> [   13.682686] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [   13.685773] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [   13.686219] i915 0000:00:02.0: [drm] *ERROR* Failed to configure the pwm chip
> [   13.699572] [drm] Initialized i915 1.6.0 20200313 for 0000:00:02.0 on minor 0
> [   13.739044] fbcon: i915drmfb (fb0) is primary device
> [   14.037792] intel_soc_pmic_exec_mipi_pmic_seq_element: No PMIC registered
> ...
> [   24.621403] intel_pmic_install_opregion_handler: Ask to register OpRegion for bus ID=PMI2, HID=INT33F5
> [   24.630540] intel_pmic_install_opregion_handler: OpRegion registered
> 
> (some extra debug printk's were added to the above)
> 
> As suggested by Hans, this patch also addresses an issue with
> the dependencies, as, for this driver to be a bool, it also
> need the I2C core and the I2C_DESIGNWARE driver to be builtin.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/mfd/Kconfig | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3fb480818599..b756860ae551 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -634,7 +634,7 @@ config INTEL_SOC_PMIC_CHTWC
>  config INTEL_SOC_PMIC_CHTDC_TI
>  	tristate "Support for Intel Cherry Trail Dollar Cove TI PMIC"

Did you forget to actually make this a bool?

>  	depends on GPIOLIB
> -	depends on I2C
> +	depends on I2C=y && I2C_DESIGNWARE_PLATFORM=y
>  	depends on ACPI
>  	depends on X86
>  	select MFD_CORE
> @@ -644,6 +644,10 @@ config INTEL_SOC_PMIC_CHTDC_TI
>  	  Select this option for supporting Dollar Cove (TI version) PMIC
>  	  device that is found on some Intel Cherry Trail systems.
>  
> +	  This option is a bool as it provides an ACPI OpRegion which must be
> +	  available before any devices using it are probed. This option also
> +	  needs the designware-i2c driver to be builtin for the same reason.
> +
>  config INTEL_SOC_PMIC_MRFLD
>  	tristate "Support for Intel Merrifield Basin Cove PMIC"
>  	depends on GPIOLIB

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
