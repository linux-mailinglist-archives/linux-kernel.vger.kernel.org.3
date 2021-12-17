Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029F24791DE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbhLQQu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:50:58 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:42578 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhLQQuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:50:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639759855; x=1671295855;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=RC3FnMFpifE9fNebjGu/kjokm/vsi7FxGu0UtnO2J/g=;
  b=KfrXre7uLeWBN0VIugl3UQsqm4qpXty7ctU9bf3Pr5sAx36xuYDZa12K
   L7FJ/DZq4im7AOfmb/kYR5t9gg7HZIisfYfJlB3r5JoRv8C4amfSyCmXw
   1CVPhRpN6TiIDBdL9wI7RGt+iWQ6npEBAD5LmCDlGoqaX2uUg+U+n76YF
   g2FnKR+Ef0BB+DXqh96JOi0Z4NtqcU5WMamcq+sXIRb77Kv1/e5F5wcJ1
   a1XhFqEddIeNcp/ACivinCwY1LB45Kwuod5sihZE03jzIcUwwsg9Du3Lf
   BONdyrAWvUiou1OeRGY+jMYFmFYbGx5q5t3qB6AfrXE02IaRIIKjb6ZKB
   w==;
IronPort-SDR: KduGrjma49C9zIhYZ/5JhpvSrpydtCWCg61Xo5/z7vIE79xJIZzPiAMRXW3WW2609htLNC9uMR
 iHtZn93Za/SQPKuygDyzy16DjyRbz2xXz12yDF0OzyijgE6c0pElJLOjgU6Sb8lMQnqB0qUr4I
 9QLF2ZV3laIQOWL3d4k2nOsPakXlbZ9rcB7PP1FCDizfm3wNO7IZQAU3+gEf+sVIYj+dN7A72B
 ZjTjd2iCQOPWZe9UEyRVVN4pXceqfley8YV+5Og3WQ8W+DOmVV8+abMEZ9N7MRH7Rr0l8jo2ET
 drkVVEsAjaXCkPZ1corgHTHv
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="79935474"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Dec 2021 09:50:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 09:50:46 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 17 Dec 2021 09:50:45 -0700
Subject: Re: [PATCH] ARM: configs: at91: sama7: Enable SPI NOR and QSPI
 controller
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <linux@armlinux.org.uk>, <claudiu.beznea@microchip.com>,
        <codrin.ciubotariu@microchip.com>, <eugen.hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211209153744.357465-1-tudor.ambarus@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <cb18bbec-1bc1-731d-65c0-57c5229f2c91@microchip.com>
Date:   Fri, 17 Dec 2021 17:50:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211209153744.357465-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2021 at 16:37, Tudor Ambarus wrote:
> sama7g5ek comes with a SPI NOR flash connected to the QSPI
> controller. Enable the SPI NOR subsystem and the QSPI controller.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Best regards,
   Nicolas

> ---
>   arch/arm/configs/sama7_defconfig | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
> index 938aae4bd80b..0368068e04d9 100644
> --- a/arch/arm/configs/sama7_defconfig
> +++ b/arch/arm/configs/sama7_defconfig
> @@ -33,7 +33,6 @@ CONFIG_MODULES=y
>   CONFIG_MODULE_FORCE_LOAD=y
>   CONFIG_MODULE_UNLOAD=y
>   CONFIG_MODULE_FORCE_UNLOAD=y
> -# CONFIG_BLK_DEV_BSG is not set
>   CONFIG_PARTITION_ADVANCED=y
>   # CONFIG_EFI_PARTITION is not set
>   # CONFIG_COREDUMP is not set
> @@ -83,6 +82,7 @@ CONFIG_DEVTMPFS_MOUNT=y
>   CONFIG_MTD=y
>   CONFIG_MTD_TESTS=m
>   CONFIG_MTD_CMDLINE_PARTS=y
> +CONFIG_MTD_SPI_NOR=y
>   CONFIG_BLK_DEV_LOOP=y
>   CONFIG_BLK_DEV_RAM=y
>   CONFIG_BLK_DEV_RAM_COUNT=1
> @@ -90,6 +90,7 @@ CONFIG_BLK_DEV_RAM_SIZE=8192
>   CONFIG_EEPROM_AT24=y
>   CONFIG_SCSI=y
>   CONFIG_BLK_DEV_SD=y
> +# CONFIG_BLK_DEV_BSG is not set
>   CONFIG_NETDEVICES=y
>   CONFIG_MACB=y
>   CONFIG_MICREL_PHY=y
> @@ -104,8 +105,8 @@ CONFIG_I2C=y
>   CONFIG_I2C_CHARDEV=y
>   CONFIG_I2C_AT91=y
>   CONFIG_SPI=y
> -CONFIG_SPI_MEM=y
>   CONFIG_SPI_ATMEL=y
> +CONFIG_SPI_ATMEL_QUADSPI=y
>   CONFIG_SPI_GPIO=y
>   CONFIG_PINCTRL_AT91=y
>   CONFIG_PINCTRL_AT91PIO4=y
> 


-- 
Nicolas Ferre
