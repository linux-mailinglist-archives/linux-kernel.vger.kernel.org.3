Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FEB4C350D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 19:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbiBXSw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 13:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiBXSw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 13:52:56 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875941F635D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 10:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645728746; x=1677264746;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w7MLgSozzXyrQ89B/PuCkyqNyePTml2zwIjW2nPnuOM=;
  b=dekrrvRFfPqLf5SB++EQBocz2wWitmz9IOmar7vRTJjB/UumiVEmKxVR
   yi8VUhwN49BYdEalI2AOclf76P4ynKfT3DJnYb5c6yJViclnL9HiqePDR
   XGj5tSDVXXn5i+7J8icEm5RywYcLb3a65rElKoQ4do0z8BmWaj0zl3y2y
   y7q1tVzDHF89h5qwkY5wpeXswFGJ8fP533iWhjZUZIqzuYWr/FOgg6oww
   xa+66tOCOg8p3pwc8rLEuZNifqyTBPZRh2jyLx8iYAm9OUJ76pxZOc/yM
   rRLoPVyeXYGEHJyYzPU+nbidfrmiMh/9JazH4MrdTM0ysBJ3LMciIjG6S
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,134,1643698800"; 
   d="scan'208";a="163542603"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2022 11:52:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 24 Feb 2022 11:52:25 -0700
Received: from [10.12.73.51] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 24 Feb 2022 11:52:24 -0700
Message-ID: <931a3b21-c6e7-18b7-b666-da0bdd98a204@microchip.com>
Date:   Thu, 24 Feb 2022 19:52:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ARM: configs: at91: sama7: Enable NAND / SMC
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <claudiu.beznea@microchip.com>, <eugen.hristev@microchip.com>,
        <codrin.ciubotariu@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220111125641.903624-1-tudor.ambarus@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220111125641.903624-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2022 at 13:56, Tudor Ambarus wrote:
> Enable the Static Memory Controller. Tested with Micron MT29F4G08ABAEAWP
> NAND flash. Software error correction is not needed, as the SMC includes
> a PMECC error correction hardware module.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Applied to at91-defconfig for 5.18.

Thanks, regards,
   Nicolas

> ---
>   arch/arm/configs/sama7_defconfig | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
> index 0368068e04d9..342d9f30d9d2 100644
> --- a/arch/arm/configs/sama7_defconfig
> +++ b/arch/arm/configs/sama7_defconfig
> @@ -82,6 +82,9 @@ CONFIG_DEVTMPFS_MOUNT=y
>   CONFIG_MTD=y
>   CONFIG_MTD_TESTS=m
>   CONFIG_MTD_CMDLINE_PARTS=y
> +CONFIG_MTD_RAW_NAND=y
> +CONFIG_MTD_NAND_ATMEL=y
> +# CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
>   CONFIG_MTD_SPI_NOR=y
>   CONFIG_BLK_DEV_LOOP=y
>   CONFIG_BLK_DEV_RAM=y
> @@ -174,7 +177,6 @@ CONFIG_DMATEST=y
>   CONFIG_STAGING=y
>   CONFIG_MICROCHIP_PIT64B=y
>   # CONFIG_IOMMU_SUPPORT is not set
> -# CONFIG_ATMEL_EBI is not set
>   CONFIG_IIO=y
>   CONFIG_IIO_SW_TRIGGER=y
>   CONFIG_AT91_SAMA5D2_ADC=y


-- 
Nicolas Ferre
