Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20EF4A8304
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350161AbiBCLQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:16:30 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:3605 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiBCLQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643886988; x=1675422988;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gbMFmOFt64U0aNyD3zRSkRuWmUxfmMF1AdUkMwdMciA=;
  b=IlGoPoYEuN7RnIV6+P6aYbwl2aIiiGOtLAl8dMPEl0/72ASlSeXRDUl+
   jtvhLMRHf4hHXZXHOt3kymVsJfYdlV27XmG9ZWXrb2ID9KDiiXks3C0do
   cpUPBAjtNcS6/yC5afserYLeAUseBsSWjyXs2KGpASCT4DDUO562pQ+mW
   KffNfuyTfxBY3dJlprTRqCVz9qecX2E+GWXD4VNd3scju7v2HZy+CRSgB
   v547LiqMwdEmobnT4SF9xvkKMGWagZLSiMa4hRRl+kM7qqX0wXhDgOpgV
   DM08+PEuLcIaLm4WkyyLQh1SZeH8ZQCK/VUJoW8zyFVf5v8TFCKNe033N
   A==;
IronPort-SDR: U8Syc/spqEJ6vXNR+O0ebBpcE67LcRBlDK/tHHyGVn9w4I8yvAXzsNLstF8DPNWEwvDT0jdcYE
 A1FVwWCHfxyFAGSvjVhBE/Z3EXBxWUOlQ9s9PR4yVxVuvqF6gt50eHjbXxwageJrAOsHATY6eR
 8MLd33lkQkhhtvAxZorJNeuIZ8Hbg6SXgM/Z/nX9kh+76CoxiYXsPnoWEJR4Q4XBZaWY0kLauN
 xUAwZYyKp7pM/YpweqF/cqMPwF3HAwc7mvCiHqmH6gq0NMe+mroFM/Z3JEgq7Wi+H/kwL4yUCq
 43DWlMAzRkMGJMzXpNEWOQ/9
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="144763130"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Feb 2022 04:16:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 3 Feb 2022 04:16:28 -0700
Received: from [10.12.82.10] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 3 Feb 2022 04:16:26 -0700
Message-ID: <eb1d1014-7e88-b79c-8404-891b87c917f0@microchip.com>
Date:   Thu, 3 Feb 2022 12:16:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ARM: configs: at91: sama7: Enable UBIFS_FS
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <claudiu.beznea@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220202070244.150022-1-tudor.ambarus@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220202070244.150022-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2022 at 08:02, Tudor Ambarus wrote:
> sama7g5 contains a Static Memory Controller that can communicate with
> NAND flashes. Enable UBIFS_FS in case one wants to put an ubifs rootfs
> on a NAND flash. CONFIG_CRYPTO_LZO and CONFIG_CRYPTO_DEFLATE appear as
> removed because they are selected by CONFIG_UBIFS_FS.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Thanks Tudor. Best regards,
   Nicolas

> ---
>   arch/arm/configs/sama7_defconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
> index 342d9f30d9d2..c12278174579 100644
> --- a/arch/arm/configs/sama7_defconfig
> +++ b/arch/arm/configs/sama7_defconfig
> @@ -86,6 +86,7 @@ CONFIG_MTD_RAW_NAND=y
>   CONFIG_MTD_NAND_ATMEL=y
>   # CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
>   CONFIG_MTD_SPI_NOR=y
> +CONFIG_MTD_UBI=y
>   CONFIG_BLK_DEV_LOOP=y
>   CONFIG_BLK_DEV_RAM=y
>   CONFIG_BLK_DEV_RAM_COUNT=1
> @@ -187,6 +188,7 @@ CONFIG_EXT3_FS=y
>   CONFIG_FANOTIFY=y
>   CONFIG_VFAT_FS=y
>   CONFIG_TMPFS=y
> +CONFIG_UBIFS_FS=y
>   CONFIG_NFS_FS=y
>   CONFIG_ROOT_NFS=y
>   CONFIG_NLS_CODEPAGE_437=y
> @@ -194,8 +196,6 @@ CONFIG_NLS_CODEPAGE_850=y
>   CONFIG_NLS_ISO8859_1=y
>   CONFIG_NLS_UTF8=y
>   CONFIG_LSM="N"
> -CONFIG_CRYPTO_DEFLATE=y
> -CONFIG_CRYPTO_LZO=y
>   # CONFIG_CRYPTO_HW is not set
>   CONFIG_CRC_CCITT=y
>   CONFIG_CRC_ITU_T=y


-- 
Nicolas Ferre
