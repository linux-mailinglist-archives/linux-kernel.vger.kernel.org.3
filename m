Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B86E51C15A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380090AbiEENx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380110AbiEENxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:53:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6F658E51
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 06:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651758579; x=1683294579;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Agjxh3HFxA2toDGmJ/PZhTsshkA6Z3TtM10ts8mk98M=;
  b=ZMyqnXOluTYi/014NbLfZpgKkoE/Y25JUXnOhjKxT6OCzc2W7nVYJz7E
   ljcOwh8yEBlyi8wnw4lvb7744hZTvyb0t0ER9gXF03ywbwBrrpM2dKs2p
   2UuGvtYLhJhLFOC6JSU+Wh4lsCXgnn3b+mny+X/wXb5OuKFjDdfbUEwVE
   DWo7ObsmcLnjwufH5Vsjc0mz6A8h4l9yvEGNJkyCchjrQMd85LqxXPvBy
   /WCHdq9r3u0fqK/ad0acAby3O/5d5nEkfj1ivSSeC5kpP/pVe919RT4zG
   qiI830W0jHwsVt0Epx9uLoxfhqzdMfWZ8fcWsCUrkglUllaWoVSbJWXBd
   w==;
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="154930282"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2022 06:49:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 5 May 2022 06:49:38 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 5 May 2022 06:49:37 -0700
Message-ID: <a9d67590-e85f-1b9a-4e27-d4852ebecbcc@microchip.com>
Date:   Thu, 5 May 2022 15:49:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/3] ARM: configs: at91: sama7: Enable MTD_UBI_FASTMAP
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <claudiu.beznea@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <codrin.ciubotariu@microchip.com>, <eugen.hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220420134740.193563-1-tudor.ambarus@microchip.com>
 <20220420134740.193563-2-tudor.ambarus@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220420134740.193563-2-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2022 at 15:47, Tudor Ambarus wrote:
> Use fastmap to accelerate the attach procedure.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>   arch/arm/configs/sama7_defconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
> index 07b0494ef743..03652454274f 100644
> --- a/arch/arm/configs/sama7_defconfig
> +++ b/arch/arm/configs/sama7_defconfig
> @@ -94,6 +94,7 @@ CONFIG_MTD_NAND_ATMEL=y
>   # CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
>   CONFIG_MTD_SPI_NOR=y
>   CONFIG_MTD_UBI=y
> +CONFIG_MTD_UBI_FASTMAP=y
>   CONFIG_BLK_DEV_LOOP=y
>   CONFIG_BLK_DEV_RAM=y
>   CONFIG_BLK_DEV_RAM_COUNT=1
> @@ -221,9 +222,9 @@ CONFIG_CRC_ITU_T=y
>   CONFIG_DMA_CMA=y
>   CONFIG_CMA_SIZE_MBYTES=32
>   CONFIG_CMA_ALIGNMENT=9
> +# CONFIG_DEBUG_MISC is not set
>   # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
>   CONFIG_DEBUG_FS=y
> -# CONFIG_DEBUG_MISC is not set
>   # CONFIG_SCHED_DEBUG is not set
>   CONFIG_STACKTRACE=y
>   # CONFIG_FTRACE is not set

I understand the rationale of this change, but it should probably go 
into another patch or it's even sometimes done by arm-soc maintainers, 
so I removed it.
No need to resend, I'll remove while applying.

Best regards,
   Nicolas



-- 
Nicolas Ferre
