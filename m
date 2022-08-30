Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B237F5A5F67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiH3J2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiH3J2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:28:37 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37711D6BB7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:28:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e20so13333815wri.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=iugsfgF14+MI2KNN6yDNoZ7R2eQVPNVHIFDGsQj0lN4=;
        b=d+AW3FhmOh2qgNknkKJdC/OK6Yei02PYaAINfEgEdlZmldIAwGpuOo2QYZUNkTS/Dz
         Jk98PRKn54Ec+c+wdKPNJ5uO5xCg3InFT5JVHe57UWPshBXitp9zO0V2NhYggL5Com0v
         NqXELWz30gySqMGaD+VgGiz3KOW6Q/XjS/epTdqXOr2ygO3q/mL2K8PLmOrjdsACuGKw
         wR5Ez4hy9RAbUMrPL27xgFrkAU7JdyXipteOB+BwfgBV1A9nlLEZvFKYv3JVDr/DcT0b
         RhKRJ5tbXoOsjeg4r+XnC9m49zlKa1CwiNnr89kgjjVLbxFbrQh6lpm1RqpikCu2M2p3
         2OfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=iugsfgF14+MI2KNN6yDNoZ7R2eQVPNVHIFDGsQj0lN4=;
        b=6AfSgebOE3vY4xQRRgQnvB/yxgg5ELyD1xh4o7wusUQej549cvIYzE0Ecf+VD380KC
         wOJrglvpBDknJ741S4R1KXlJWu5JdZlLOn+PEwTOfGGEX9mCRHvbaewaivGACSIzLAbs
         EkOGzp/TBq4lCe4sNZb4iuSjkhmev7YgAtuY4yS2F7zWJTbSTI63JXTECCt9Ur1W8Xe0
         ZcdIhM9l/xRf/iLiK7SzbujKUAmIFrVvHmDsKpqQTP7vUN515wHiaujaqwT48nI0ZHxy
         iHSkcuilLMFsZJ066RpGQJVvbKxKPv9ajEfsIDaKn3Wny/kj9mpvmNQRJ0F63sbK6oxx
         WnTw==
X-Gm-Message-State: ACgBeo0TNtmR4rySBUVvx5Px+mTmYneUdssw4YCfNAgNMrxkrzMOugCj
        lnEw92MV/n8MeGYv3XZhCAGklQ==
X-Google-Smtp-Source: AA6agR4/aP5dBfZMViF+E4gJCwxVOwZZZksTRud7IZbpmE3KX/0yCE5hOoLjOPaXZwdTWsW0SfYRIg==
X-Received: by 2002:a5d:5846:0:b0:222:c899:cb66 with SMTP id i6-20020a5d5846000000b00222c899cb66mr8067129wrf.521.1661851713303;
        Tue, 30 Aug 2022 02:28:33 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id k25-20020adfd239000000b0021e43b4edf0sm9044310wrh.20.2022.08.30.02.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 02:28:32 -0700 (PDT)
Message-ID: <fc04fe2f-330e-7cbe-73bb-0d50fdd37a9e@linaro.org>
Date:   Tue, 30 Aug 2022 10:28:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvmem: sort config symbols alphabetically
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220818050900.30062-1-zajec5@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220818050900.30062-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rafał,

On 18/08/2022 06:09, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> 1. Match what most subsystems do
> 2. Simplify maintenance a bit
> 3. Reduce amount of conflicts for new drivers patches
> 
> While at it unify indent level in Makefile.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   drivers/nvmem/Kconfig  | 342 +++++++++++++++++++++--------------------
>   drivers/nvmem/Makefile | 120 +++++++--------
>   2 files changed, 232 insertions(+), 230 deletions(-)
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index bab8a29c9861..cb4036f81a25 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -21,6 +21,90 @@ config NVMEM_SYSFS
>   	 This interface is mostly used by userspace applications to
>   	 read/write directly into nvmem.
>   
> +# Devices
> +
> +config JZ4780_EFUSE
> +	tristate "JZ4780 EFUSE Memory Support"
> +	depends on MACH_INGENIC || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	depends on OF
> +	select REGMAP_MMIO
> +	help
> +	  Say Y here to include support for JZ4780 efuse memory found on
> +	  all JZ4780 SoC based devices.
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called nvmem_jz4780_efuse.
> +
> +config MESON_EFUSE
> +	tristate "Amlogic Meson GX eFuse Support"
> +	depends on (ARCH_MESON || COMPILE_TEST) && MESON_SM
> +	help
> +	  This is a driver to retrieve specific values from the eFuse found on
> +	  the Amlogic Meson GX SoCs.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nvmem_meson_efuse.
> +
> +config MESON_MX_EFUSE
> +	tristate "Amlogic Meson6/Meson8/Meson8b eFuse Support"
> +	depends on ARCH_MESON || COMPILE_TEST
> +	help
> +	  This is a driver to retrieve specific values from the eFuse found on
> +	  the Amlogic Meson6, Meson8 and Meson8b SoCs.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nvmem_meson_mx_efuse.
> +
> +config MICROCHIP_OTPC
> +	tristate "Microchip OTPC support"
> +	depends on ARCH_AT91 || COMPILE_TEST
> +	help
> +	  This driver enable the OTP controller available on Microchip SAMA7G5
> +	  SoCs. It controlls the access to the OTP memory connected to it.
> +
> +config MTK_EFUSE
> +	tristate "Mediatek SoCs EFUSE support"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This is a driver to access hardware related data like sensor
> +	  calibration, HDMI impedance etc.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called efuse-mtk.
> +
Looks like we ended up with mix two styles of Kconfig symbols here,
Pefered way is it prefix the mwith NVMEM_.
While you are at it, can you clean this as well.

--srini

> +config NVMEM_APPLE_EFUSES
> +	tristate "Apple eFuse support"
> +	depends on ARCH_APPLE || COMPILE_TEST
> +	default ARCH_APPLE
> +	help
> +	  Say y here to enable support for reading eFuses on Apple SoCs
> +	  such as the M1. These are e.g. used to store factory programmed
> +	  calibration data required for the PCIe or the USB-C PHY.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called nvmem-apple-efuses.
> +
> +config NVMEM_BCM_OCOTP
> +	tristate "Broadcom On-Chip OTP Controller support"
> +	depends on ARCH_BCM_IPROC || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	default ARCH_BCM_IPROC
> +	help
> +	  Say y here to enable read/write access to the Broadcom OTP
> +	  controller.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nvmem-bcm-ocotp.
> +
> +config NVMEM_BRCM_NVRAM
> +	tristate "Broadcom's NVRAM support"
> +	depends on ARCH_BCM_5301X || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This driver provides support for Broadcom's NVRAM that can be accessed
> +	  using I/O mapping.
> +
>   config NVMEM_IMX_IIM
>   	tristate "i.MX IC Identification Module support"
>   	depends on ARCH_MXC || COMPILE_TEST
> @@ -52,17 +136,18 @@ config NVMEM_IMX_OCOTP_SCU
>   	  This is a driver for the SCU On-Chip OTP Controller (OCOTP)
>   	  available on i.MX8 SoCs.
>   
> -config JZ4780_EFUSE
> -	tristate "JZ4780 EFUSE Memory Support"
> -	depends on MACH_INGENIC || COMPILE_TEST
> +config NVMEM_LAYERSCAPE_SFP
> +	tristate "Layerscape SFP (Security Fuse Processor) support"
> +	depends on ARCH_LAYERSCAPE || COMPILE_TEST
>   	depends on HAS_IOMEM
> -	depends on OF
>   	select REGMAP_MMIO
>   	help
> -	  Say Y here to include support for JZ4780 efuse memory found on
> -	  all JZ4780 SoC based devices.
> -	  To compile this driver as a module, choose M here: the module
> -	  will be called nvmem_jz4780_efuse.
> +	  This driver provides support to read the eFuses on Freescale
> +	  Layerscape SoC's. For example, the vendor provides a per part
> +	  unique ID there.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called layerscape-sfp.
>   
>   config NVMEM_LPC18XX_EEPROM
>   	tristate "NXP LPC18XX EEPROM Memory Support"
> @@ -96,24 +181,6 @@ config NVMEM_MXS_OCOTP
>   	  This driver can also be built as a module. If so, the module
>   	  will be called nvmem-mxs-ocotp.
>   
> -config MTK_EFUSE
> -	tristate "Mediatek SoCs EFUSE support"
> -	depends on ARCH_MEDIATEK || COMPILE_TEST
> -	depends on HAS_IOMEM
> -	help
> -	  This is a driver to access hardware related data like sensor
> -	  calibration, HDMI impedance etc.
> -
> -	  This driver can also be built as a module. If so, the module
> -	  will be called efuse-mtk.
> -
> -config MICROCHIP_OTPC
> -	tristate "Microchip OTPC support"
> -	depends on ARCH_AT91 || COMPILE_TEST
> -	help
> -	  This driver enable the OTP controller available on Microchip SAMA7G5
> -	  SoCs. It controlls the access to the OTP memory connected to it.
> -
>   config NVMEM_NINTENDO_OTP
>   	tristate "Nintendo Wii and Wii U OTP Support"
>   	depends on WII || COMPILE_TEST
> @@ -126,16 +193,25 @@ config NVMEM_NINTENDO_OTP
>   	  This driver can also be built as a module. If so, the module
>   	  will be called nvmem-nintendo-otp.
>   
> -config QCOM_QFPROM
> -	tristate "QCOM QFPROM Support"
> -	depends on ARCH_QCOM || COMPILE_TEST
> +config NVMEM_RMEM
> +	tristate "Reserved Memory Based Driver Support"
>   	depends on HAS_IOMEM
>   	help
> -	  Say y here to enable QFPROM support. The QFPROM provides access
> -	  functions for QFPROM data to rest of the drivers via nvmem interface.
> +	  This driver maps reserved memory into an nvmem device. It might be
> +	  useful to expose information left by firmware in memory.
>   
>   	  This driver can also be built as a module. If so, the module
> -	  will be called nvmem_qfprom.
> +	  will be called nvmem-rmem.
> +
> +config NVMEM_SNVS_LPGPR
> +	tristate "Support for Low Power General Purpose Register"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	help
> +	  This is a driver for Low Power General Purpose Register (LPGPR) available on
> +	  i.MX6 and i.MX7 SoCs in Secure Non-Volatile Storage (SNVS) of this chip.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nvmem-snvs-lpgpr.
>   
>   config NVMEM_SPMI_SDAM
>   	tristate "SPMI SDAM Support"
> @@ -145,40 +221,6 @@ config NVMEM_SPMI_SDAM
>   	  Qualcomm Technologies, Inc. PMICs. It provides the clients
>   	  an interface to read/write to the SDAM module's shared memory.
>   
> -config ROCKCHIP_EFUSE
> -	tristate "Rockchip eFuse Support"
> -	depends on ARCH_ROCKCHIP || COMPILE_TEST
> -	depends on HAS_IOMEM
> -	help
> -	  This is a simple drive to dump specified values of Rockchip SoC
> -	  from eFuse, such as cpu-leakage.
> -
> -	  This driver can also be built as a module. If so, the module
> -	  will be called nvmem_rockchip_efuse.
> -
> -config ROCKCHIP_OTP
> -	tristate "Rockchip OTP controller support"
> -	depends on ARCH_ROCKCHIP || COMPILE_TEST
> -	depends on HAS_IOMEM
> -	help
> -	  This is a simple drive to dump specified values of Rockchip SoC
> -	  from otp, such as cpu-leakage.
> -
> -	  This driver can also be built as a module. If so, the module
> -	  will be called nvmem_rockchip_otp.
> -
> -config NVMEM_BCM_OCOTP
> -	tristate "Broadcom On-Chip OTP Controller support"
> -	depends on ARCH_BCM_IPROC || COMPILE_TEST
> -	depends on HAS_IOMEM
> -	default ARCH_BCM_IPROC
> -	help
> -	  Say y here to enable read/write access to the Broadcom OTP
> -	  controller.
> -
> -	  This driver can also be built as a module. If so, the module
> -	  will be called nvmem-bcm-ocotp.
> -
>   config NVMEM_STM32_ROMEM
>   	tristate "STMicroelectronics STM32 factory-programmed memory support"
>   	depends on ARCH_STM32 || COMPILE_TEST
> @@ -189,6 +231,18 @@ config NVMEM_STM32_ROMEM
>   	  This driver can also be built as a module. If so, the module
>   	  will be called nvmem-stm32-romem.
>   
> +config NVMEM_SUNPLUS_OCOTP
> +	tristate "Sunplus SoC OTP support"
> +	depends on SOC_SP7021 || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This is a driver for the On-chip OTP controller (OCOTP) available
> +	  on Sunplus SoCs. It provides access to 128 bytes of one-time
> +	  programmable eFuse.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nvmem-sunplus-ocotp.
> +
>   config NVMEM_SUNXI_SID
>   	tristate "Allwinner SoCs SID support"
>   	depends on ARCH_SUNXI
> @@ -199,16 +253,18 @@ config NVMEM_SUNXI_SID
>   	  This driver can also be built as a module. If so, the module
>   	  will be called nvmem_sunxi_sid.
>   
> -config UNIPHIER_EFUSE
> -	tristate "UniPhier SoCs eFuse support"
> -	depends on ARCH_UNIPHIER || COMPILE_TEST
> -	depends on HAS_IOMEM
> +config NVMEM_U_BOOT_ENV
> +	tristate "U-Boot environment variables support"
> +	depends on OF && MTD
> +	select CRC32
>   	help
> -	  This is a simple driver to dump specified values of UniPhier SoC
> -	  from eFuse.
> +	  U-Boot stores its setup as environment variables. This driver adds
> +	  support for verifying & exporting such data. It also exposes variables
> +	  as NVMEM cells so they can be referenced by other drivers.
>   
> -	  This driver can also be built as a module. If so, the module
> -	  will be called nvmem-uniphier-efuse.
> +	  Currently this drivers works only with env variables on top of MTD.
> +
> +	  If compiled as module it will be called nvmem_u-boot-env.
>   
>   config NVMEM_VF610_OCOTP
>   	tristate "VF610 SoC OCOTP support"
> @@ -221,35 +277,26 @@ config NVMEM_VF610_OCOTP
>   	  This driver can also be build as a module. If so, the module will
>   	  be called nvmem-vf610-ocotp.
>   
> -config MESON_EFUSE
> -	tristate "Amlogic Meson GX eFuse Support"
> -	depends on (ARCH_MESON || COMPILE_TEST) && MESON_SM
> -	help
> -	  This is a driver to retrieve specific values from the eFuse found on
> -	  the Amlogic Meson GX SoCs.
> -
> -	  This driver can also be built as a module. If so, the module
> -	  will be called nvmem_meson_efuse.
> -
> -config MESON_MX_EFUSE
> -	tristate "Amlogic Meson6/Meson8/Meson8b eFuse Support"
> -	depends on ARCH_MESON || COMPILE_TEST
> +config NVMEM_ZYNQMP
> +	bool "Xilinx ZYNQMP SoC nvmem firmware support"
> +	depends on ARCH_ZYNQMP
>   	help
> -	  This is a driver to retrieve specific values from the eFuse found on
> -	  the Amlogic Meson6, Meson8 and Meson8b SoCs.
> +	  This is a driver to access hardware related data like
> +	  soc revision, IDCODE... etc by using the firmware
> +	  interface.
>   
> -	  This driver can also be built as a module. If so, the module
> -	  will be called nvmem_meson_mx_efuse.
> +	  If sure, say yes. If unsure, say no.
>   
> -config NVMEM_SNVS_LPGPR
> -	tristate "Support for Low Power General Purpose Register"
> -	depends on ARCH_MXC || COMPILE_TEST
> +config QCOM_QFPROM
> +	tristate "QCOM QFPROM Support"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on HAS_IOMEM
>   	help
> -	  This is a driver for Low Power General Purpose Register (LPGPR) available on
> -	  i.MX6 and i.MX7 SoCs in Secure Non-Volatile Storage (SNVS) of this chip.
> +	  Say y here to enable QFPROM support. The QFPROM provides access
> +	  functions for QFPROM data to rest of the drivers via nvmem interface.
>   
>   	  This driver can also be built as a module. If so, the module
> -	  will be called nvmem-snvs-lpgpr.
> +	  will be called nvmem_qfprom.
>   
>   config RAVE_SP_EEPROM
>   	tristate "Rave SP EEPROM Support"
> @@ -257,6 +304,28 @@ config RAVE_SP_EEPROM
>   	help
>   	  Say y here to enable Rave SP EEPROM support.
>   
> +config ROCKCHIP_EFUSE
> +	tristate "Rockchip eFuse Support"
> +	depends on ARCH_ROCKCHIP || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This is a simple drive to dump specified values of Rockchip SoC
> +	  from eFuse, such as cpu-leakage.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nvmem_rockchip_efuse.
> +
> +config ROCKCHIP_OTP
> +	tristate "Rockchip OTP controller support"
> +	depends on ARCH_ROCKCHIP || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This is a simple drive to dump specified values of Rockchip SoC
> +	  from otp, such as cpu-leakage.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nvmem_rockchip_otp.
> +
>   config SC27XX_EFUSE
>   	tristate "Spreadtrum SC27XX eFuse Support"
>   	depends on MFD_SC27XX_PMIC || COMPILE_TEST
> @@ -268,16 +337,6 @@ config SC27XX_EFUSE
>   	  This driver can also be built as a module. If so, the module
>   	  will be called nvmem-sc27xx-efuse.
>   
> -config NVMEM_ZYNQMP
> -	bool "Xilinx ZYNQMP SoC nvmem firmware support"
> -	depends on ARCH_ZYNQMP
> -	help
> -	  This is a driver to access hardware related data like
> -	  soc revision, IDCODE... etc by using the firmware
> -	  interface.
> -
> -	  If sure, say yes. If unsure, say no.
> -
>   config SPRD_EFUSE
>   	tristate "Spreadtrum SoC eFuse Support"
>   	depends on ARCH_SPRD || COMPILE_TEST
> @@ -289,72 +348,15 @@ config SPRD_EFUSE
>   	  This driver can also be built as a module. If so, the module
>   	  will be called nvmem-sprd-efuse.
>   
> -config NVMEM_RMEM
> -	tristate "Reserved Memory Based Driver Support"
> -	depends on HAS_IOMEM
> -	help
> -	  This driver maps reserved memory into an nvmem device. It might be
> -	  useful to expose information left by firmware in memory.
> -
> -	  This driver can also be built as a module. If so, the module
> -	  will be called nvmem-rmem.
> -
> -config NVMEM_BRCM_NVRAM
> -	tristate "Broadcom's NVRAM support"
> -	depends on ARCH_BCM_5301X || COMPILE_TEST
> -	depends on HAS_IOMEM
> -	help
> -	  This driver provides support for Broadcom's NVRAM that can be accessed
> -	  using I/O mapping.
> -
> -config NVMEM_LAYERSCAPE_SFP
> -	tristate "Layerscape SFP (Security Fuse Processor) support"
> -	depends on ARCH_LAYERSCAPE || COMPILE_TEST
> -	depends on HAS_IOMEM
> -	select REGMAP_MMIO
> -	help
> -	  This driver provides support to read the eFuses on Freescale
> -	  Layerscape SoC's. For example, the vendor provides a per part
> -	  unique ID there.
> -
> -	  This driver can also be built as a module. If so, the module
> -	  will be called layerscape-sfp.
> -
> -config NVMEM_SUNPLUS_OCOTP
> -	tristate "Sunplus SoC OTP support"
> -	depends on SOC_SP7021 || COMPILE_TEST
> +config UNIPHIER_EFUSE
> +	tristate "UniPhier SoCs eFuse support"
> +	depends on ARCH_UNIPHIER || COMPILE_TEST
>   	depends on HAS_IOMEM
>   	help
> -	  This is a driver for the On-chip OTP controller (OCOTP) available
> -	  on Sunplus SoCs. It provides access to 128 bytes of one-time
> -	  programmable eFuse.
> +	  This is a simple driver to dump specified values of UniPhier SoC
> +	  from eFuse.
>   
>   	  This driver can also be built as a module. If so, the module
> -	  will be called nvmem-sunplus-ocotp.
> -
> -config NVMEM_APPLE_EFUSES
> -	tristate "Apple eFuse support"
> -	depends on ARCH_APPLE || COMPILE_TEST
> -	default ARCH_APPLE
> -	help
> -	  Say y here to enable support for reading eFuses on Apple SoCs
> -	  such as the M1. These are e.g. used to store factory programmed
> -	  calibration data required for the PCIe or the USB-C PHY.
> -
> -	  This driver can also be built as a module. If so, the module will
> -	  be called nvmem-apple-efuses.
> -
> -config NVMEM_U_BOOT_ENV
> -	tristate "U-Boot environment variables support"
> -	depends on OF && MTD
> -	select CRC32
> -	help
> -	  U-Boot stores its setup as environment variables. This driver adds
> -	  support for verifying & exporting such data. It also exposes variables
> -	  as NVMEM cells so they can be referenced by other drivers.
> -
> -	  Currently this drivers works only with env variables on top of MTD.
> -
> -	  If compiled as module it will be called nvmem_u-boot-env.
> +	  will be called nvmem-uniphier-efuse.
>   
>   endif
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index 399f9972d45b..53a6ca1d0e01 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -7,67 +7,67 @@ obj-$(CONFIG_NVMEM)		+= nvmem_core.o
>   nvmem_core-y			:= core.o
>   
>   # Devices
> -obj-$(CONFIG_NVMEM_BCM_OCOTP)	+= nvmem-bcm-ocotp.o
> -nvmem-bcm-ocotp-y		:= bcm-ocotp.o
> -obj-$(CONFIG_NVMEM_IMX_IIM)	+= nvmem-imx-iim.o
> -nvmem-imx-iim-y			:= imx-iim.o
> -obj-$(CONFIG_NVMEM_IMX_OCOTP)	+= nvmem-imx-ocotp.o
> -nvmem-imx-ocotp-y		:= imx-ocotp.o
> -obj-$(CONFIG_NVMEM_IMX_OCOTP_SCU)	+= nvmem-imx-ocotp-scu.o
> -nvmem-imx-ocotp-scu-y		:= imx-ocotp-scu.o
>   obj-$(CONFIG_JZ4780_EFUSE)		+= nvmem_jz4780_efuse.o
> -nvmem_jz4780_efuse-y		:= jz4780-efuse.o
> +nvmem_jz4780_efuse-y			:= jz4780-efuse.o
> +obj-$(CONFIG_MESON_EFUSE)		+= nvmem_meson_efuse.o
> +nvmem_meson_efuse-y			:= meson-efuse.o
> +obj-$(CONFIG_MESON_MX_EFUSE)		+= nvmem_meson_mx_efuse.o
> +nvmem_meson_mx_efuse-y			:= meson-mx-efuse.o
> +obj-$(CONFIG_MICROCHIP_OTPC)		+= nvmem-microchip-otpc.o
> +nvmem-microchip-otpc-y			:= microchip-otpc.o
> +obj-$(CONFIG_MTK_EFUSE)			+= nvmem_mtk-efuse.o
> +nvmem_mtk-efuse-y			:= mtk-efuse.o
> +obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
> +nvmem-apple-efuses-y 			:= apple-efuses.o
> +obj-$(CONFIG_NVMEM_BCM_OCOTP)		+= nvmem-bcm-ocotp.o
> +nvmem-bcm-ocotp-y			:= bcm-ocotp.o
> +obj-$(CONFIG_NVMEM_BRCM_NVRAM)		+= nvmem_brcm_nvram.o
> +nvmem_brcm_nvram-y			:= brcm_nvram.o
> +obj-$(CONFIG_NVMEM_IMX_IIM)		+= nvmem-imx-iim.o
> +nvmem-imx-iim-y				:= imx-iim.o
> +obj-$(CONFIG_NVMEM_IMX_OCOTP)		+= nvmem-imx-ocotp.o
> +nvmem-imx-ocotp-y			:= imx-ocotp.o
> +obj-$(CONFIG_NVMEM_IMX_OCOTP_SCU)	+= nvmem-imx-ocotp-scu.o
> +nvmem-imx-ocotp-scu-y			:= imx-ocotp-scu.o
> +obj-$(CONFIG_NVMEM_LAYERSCAPE_SFP)	+= nvmem-layerscape-sfp.o
> +nvmem-layerscape-sfp-y			:= layerscape-sfp.o
>   obj-$(CONFIG_NVMEM_LPC18XX_EEPROM)	+= nvmem_lpc18xx_eeprom.o
> -nvmem_lpc18xx_eeprom-y	:= lpc18xx_eeprom.o
> -obj-$(CONFIG_NVMEM_LPC18XX_OTP)	+= nvmem_lpc18xx_otp.o
> -nvmem_lpc18xx_otp-y		:= lpc18xx_otp.o
> -obj-$(CONFIG_NVMEM_MXS_OCOTP)	+= nvmem-mxs-ocotp.o
> -nvmem-mxs-ocotp-y		:= mxs-ocotp.o
> +nvmem_lpc18xx_eeprom-y			:= lpc18xx_eeprom.o
> +obj-$(CONFIG_NVMEM_LPC18XX_OTP)		+= nvmem_lpc18xx_otp.o
> +nvmem_lpc18xx_otp-y			:= lpc18xx_otp.o
> +obj-$(CONFIG_NVMEM_MXS_OCOTP)		+= nvmem-mxs-ocotp.o
> +nvmem-mxs-ocotp-y			:= mxs-ocotp.o
>   obj-$(CONFIG_NVMEM_NINTENDO_OTP)	+= nvmem-nintendo-otp.o
> -nvmem-nintendo-otp-y		:= nintendo-otp.o
> -obj-$(CONFIG_MTK_EFUSE)		+= nvmem_mtk-efuse.o
> -nvmem_mtk-efuse-y		:= mtk-efuse.o
> -obj-$(CONFIG_QCOM_QFPROM)	+= nvmem_qfprom.o
> -nvmem_qfprom-y			:= qfprom.o
> -obj-$(CONFIG_NVMEM_SPMI_SDAM)	+= nvmem_qcom-spmi-sdam.o
> -nvmem_qcom-spmi-sdam-y		+= qcom-spmi-sdam.o
> -obj-$(CONFIG_ROCKCHIP_EFUSE)	+= nvmem_rockchip_efuse.o
> -nvmem_rockchip_efuse-y		:= rockchip-efuse.o
> -obj-$(CONFIG_ROCKCHIP_OTP)	+= nvmem-rockchip-otp.o
> -nvmem-rockchip-otp-y		:= rockchip-otp.o
> -obj-$(CONFIG_NVMEM_SUNXI_SID)	+= nvmem_sunxi_sid.o
> -nvmem_stm32_romem-y 		:= stm32-romem.o
> -obj-$(CONFIG_NVMEM_STM32_ROMEM) += nvmem_stm32_romem.o
> -nvmem_sunxi_sid-y		:= sunxi_sid.o
> -obj-$(CONFIG_UNIPHIER_EFUSE)	+= nvmem-uniphier-efuse.o
> -nvmem-uniphier-efuse-y		:= uniphier-efuse.o
> -obj-$(CONFIG_NVMEM_VF610_OCOTP)	+= nvmem-vf610-ocotp.o
> -nvmem-vf610-ocotp-y		:= vf610-ocotp.o
> -obj-$(CONFIG_MESON_EFUSE)	+= nvmem_meson_efuse.o
> -nvmem_meson_efuse-y		:= meson-efuse.o
> -obj-$(CONFIG_MESON_MX_EFUSE)	+= nvmem_meson_mx_efuse.o
> -nvmem_meson_mx_efuse-y		:= meson-mx-efuse.o
> -obj-$(CONFIG_NVMEM_SNVS_LPGPR)	+= nvmem_snvs_lpgpr.o
> -nvmem_snvs_lpgpr-y		:= snvs_lpgpr.o
> -obj-$(CONFIG_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
> -nvmem-rave-sp-eeprom-y		:= rave-sp-eeprom.o
> -obj-$(CONFIG_SC27XX_EFUSE)	+= nvmem-sc27xx-efuse.o
> -nvmem-sc27xx-efuse-y		:= sc27xx-efuse.o
> -obj-$(CONFIG_NVMEM_ZYNQMP)	+= nvmem_zynqmp_nvmem.o
> -nvmem_zynqmp_nvmem-y		:= zynqmp_nvmem.o
> -obj-$(CONFIG_SPRD_EFUSE)	+= nvmem_sprd_efuse.o
> -nvmem_sprd_efuse-y		:= sprd-efuse.o
> -obj-$(CONFIG_NVMEM_RMEM) 	+= nvmem-rmem.o
> -nvmem-rmem-y			:= rmem.o
> -obj-$(CONFIG_NVMEM_BRCM_NVRAM)	+= nvmem_brcm_nvram.o
> -nvmem_brcm_nvram-y		:= brcm_nvram.o
> -obj-$(CONFIG_NVMEM_LAYERSCAPE_SFP)	+= nvmem-layerscape-sfp.o
> -nvmem-layerscape-sfp-y		:= layerscape-sfp.o
> +nvmem-nintendo-otp-y			:= nintendo-otp.o
> +obj-$(CONFIG_NVMEM_RMEM) 		+= nvmem-rmem.o
> +nvmem-rmem-y				:= rmem.o
> +obj-$(CONFIG_NVMEM_SNVS_LPGPR)		+= nvmem_snvs_lpgpr.o
> +nvmem_snvs_lpgpr-y			:= snvs_lpgpr.o
> +obj-$(CONFIG_NVMEM_SPMI_SDAM)		+= nvmem_qcom-spmi-sdam.o
> +nvmem_qcom-spmi-sdam-y			+= qcom-spmi-sdam.o
> +obj-$(CONFIG_NVMEM_STM32_ROMEM) 	+= nvmem_stm32_romem.o
> +nvmem_stm32_romem-y 			:= stm32-romem.o
>   obj-$(CONFIG_NVMEM_SUNPLUS_OCOTP)	+= nvmem_sunplus_ocotp.o
> -nvmem_sunplus_ocotp-y		:= sunplus-ocotp.o
> -obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
> -nvmem-apple-efuses-y 		:= apple-efuses.o
> -obj-$(CONFIG_MICROCHIP_OTPC)	+= nvmem-microchip-otpc.o
> -nvmem-microchip-otpc-y		:= microchip-otpc.o
> -obj-$(CONFIG_NVMEM_U_BOOT_ENV)	+= nvmem_u-boot-env.o
> -nvmem_u-boot-env-y		:= u-boot-env.o
> +nvmem_sunplus_ocotp-y			:= sunplus-ocotp.o
> +obj-$(CONFIG_NVMEM_SUNXI_SID)		+= nvmem_sunxi_sid.o
> +nvmem_sunxi_sid-y			:= sunxi_sid.o
> +obj-$(CONFIG_NVMEM_U_BOOT_ENV)		+= nvmem_u-boot-env.o
> +nvmem_u-boot-env-y			:= u-boot-env.o
> +obj-$(CONFIG_NVMEM_VF610_OCOTP)		+= nvmem-vf610-ocotp.o
> +nvmem-vf610-ocotp-y			:= vf610-ocotp.o
> +obj-$(CONFIG_NVMEM_ZYNQMP)		+= nvmem_zynqmp_nvmem.o
> +nvmem_zynqmp_nvmem-y			:= zynqmp_nvmem.o
> +obj-$(CONFIG_QCOM_QFPROM)		+= nvmem_qfprom.o
> +nvmem_qfprom-y				:= qfprom.o
> +obj-$(CONFIG_RAVE_SP_EEPROM)		+= nvmem-rave-sp-eeprom.o
> +nvmem-rave-sp-eeprom-y			:= rave-sp-eeprom.o
> +obj-$(CONFIG_ROCKCHIP_EFUSE)		+= nvmem_rockchip_efuse.o
> +nvmem_rockchip_efuse-y			:= rockchip-efuse.o
> +obj-$(CONFIG_ROCKCHIP_OTP)		+= nvmem-rockchip-otp.o
> +nvmem-rockchip-otp-y			:= rockchip-otp.o
> +obj-$(CONFIG_SC27XX_EFUSE)		+= nvmem-sc27xx-efuse.o
> +nvmem-sc27xx-efuse-y			:= sc27xx-efuse.o
> +obj-$(CONFIG_SPRD_EFUSE)		+= nvmem_sprd_efuse.o
> +nvmem_sprd_efuse-y			:= sprd-efuse.o
> +obj-$(CONFIG_UNIPHIER_EFUSE)		+= nvmem-uniphier-efuse.o
> +nvmem-uniphier-efuse-y			:= uniphier-efuse.o
