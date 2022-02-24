Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9142B4C3510
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 19:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiBXSxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 13:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiBXSxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 13:53:37 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A679B24CCCB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 10:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645728785; x=1677264785;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=wyHJ3jK0TD+XAV49h9bt7bsXcAYfdoq9QfnG7CEkZuU=;
  b=XoUSDPYOkhDIxpKrlYpxDS48MeS6c9nZhe4Sl1dGFHNS5M8q6hu/uwHi
   ijINu8hRExIlA0WYTBwChYtCRJpsrTnrJUyiiDGlUmdMbbqpUof6MhFbI
   9qedQLlTjGk5MLj/ijjkTm4NPsJt9fzTdNZYefpUopjg6SzfboA8aw0mT
   tJ/wpFjJ319eod/8gC1wStd9auk5uBTBs63fxoLQwU7XZPAIb1eKwFj+e
   ZTrfSeNT3ZbiHvjBws8rhFxe7IGrVtMOcx3530N3N+nEtGZIh8IGV4WVI
   RB3YiMOxYd1mMYKKjfsxk8kmZQdHTNO/LIJRUmL9Eawt/r7FGOxdXHLKp
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,134,1643698800"; 
   d="scan'208";a="149904865"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2022 11:53:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 24 Feb 2022 11:53:04 -0700
Received: from [10.12.73.51] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 24 Feb 2022 11:53:03 -0700
Message-ID: <10b47a94-7059-8a17-d963-e17c7f391415@microchip.com>
Date:   Thu, 24 Feb 2022 19:53:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ARM: configs: at91: sama7: Enable UBIFS_FS
Content-Language: en-US
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <claudiu.beznea@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220202070244.150022-1-tudor.ambarus@microchip.com>
 <eb1d1014-7e88-b79c-8404-891b87c917f0@microchip.com>
Organization: microchip
In-Reply-To: <eb1d1014-7e88-b79c-8404-891b87c917f0@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2022 at 12:16, Nicolas Ferre wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 02/02/2022 at 08:02, Tudor Ambarus wrote:
>> sama7g5 contains a Static Memory Controller that can communicate with
>> NAND flashes. Enable UBIFS_FS in case one wants to put an ubifs rootfs
>> on a NAND flash. CONFIG_CRYPTO_LZO and CONFIG_CRYPTO_DEFLATE appear as
>> removed because they are selected by CONFIG_UBIFS_FS.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Thanks Tudor. Best regards,
>     Nicolas

Applied to at91-defconfig for 5.18.
Regards,
   Nicolas


> 
>> ---
>>    arch/arm/configs/sama7_defconfig | 4 ++--
>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
>> index 342d9f30d9d2..c12278174579 100644
>> --- a/arch/arm/configs/sama7_defconfig
>> +++ b/arch/arm/configs/sama7_defconfig
>> @@ -86,6 +86,7 @@ CONFIG_MTD_RAW_NAND=y
>>    CONFIG_MTD_NAND_ATMEL=y
>>    # CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
>>    CONFIG_MTD_SPI_NOR=y
>> +CONFIG_MTD_UBI=y
>>    CONFIG_BLK_DEV_LOOP=y
>>    CONFIG_BLK_DEV_RAM=y
>>    CONFIG_BLK_DEV_RAM_COUNT=1
>> @@ -187,6 +188,7 @@ CONFIG_EXT3_FS=y
>>    CONFIG_FANOTIFY=y
>>    CONFIG_VFAT_FS=y
>>    CONFIG_TMPFS=y
>> +CONFIG_UBIFS_FS=y
>>    CONFIG_NFS_FS=y
>>    CONFIG_ROOT_NFS=y
>>    CONFIG_NLS_CODEPAGE_437=y
>> @@ -194,8 +196,6 @@ CONFIG_NLS_CODEPAGE_850=y
>>    CONFIG_NLS_ISO8859_1=y
>>    CONFIG_NLS_UTF8=y
>>    CONFIG_LSM="N"
>> -CONFIG_CRYPTO_DEFLATE=y
>> -CONFIG_CRYPTO_LZO=y
>>    # CONFIG_CRYPTO_HW is not set
>>    CONFIG_CRC_CCITT=y
>>    CONFIG_CRC_ITU_T=y
> 
> 
> --
> Nicolas Ferre
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Nicolas Ferre
