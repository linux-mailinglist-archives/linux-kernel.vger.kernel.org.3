Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF174CD3D0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbiCDLyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiCDLyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:54:38 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A111B0C46
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 03:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646394831; x=1677930831;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HDKAvks5ADg8aGexQOs3eBnOClZQJx3qdhcPIsq8Po0=;
  b=nx8Yc6/4yCdiHcQHt+3eo/8LSbj2NgGWMJZwLdsysprX23OkVj21lYqX
   YB+aUbNeBtJNZ4rZBiSjgj2if36N5tCzHpJcyVeGBqoHe7Z+yZqEyRcwg
   62ZM/34OwREU1qIGMiJPfntoYKLlhu/I1/T9JApnGslNKd9u2ygjNJANU
   h9JNf+MGE6DIVQNdYr0e5CIcDYIQPBMBSldoDGXjJfvOwXQFth8aVNOUs
   Wx71OJ04A9+YO/3VpMlH52fqQ92YyqpDmJ3zP5IlmGL9I9GxTgCByFTNI
   qswJoPKGns+V3o7W3e84XcDmYbz844MTxXwmcTHCayZnckEZl4JFVwiGy
   w==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="155260811"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 04:53:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 04:53:36 -0700
Received: from [10.12.72.98] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 4 Mar 2022 04:53:34 -0700
Message-ID: <a2b84623-3b11-0e3e-ff06-ac87c41450c7@microchip.com>
Date:   Fri, 4 Mar 2022 12:53:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ARM: configs: at91: sama7: Unselect CONFIG_DMATEST
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <claudiu.beznea@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <eugen.hristev@microchip.com>, <codrin.ciubotariu@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220228085906.18508-1-tudor.ambarus@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220228085906.18508-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2022 at 09:59, Tudor Ambarus wrote:
> The DMA test client should be selected only when one is debugging a DMA
> Device driver. There's no need to select the DMA test client by default,
> unselect it.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Queued for 5.18 in at91-defconfig.
Regards,
   Nicolas

> ---
>   arch/arm/configs/sama7_defconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
> index 0368068e04d9..17e8bed22791 100644
> --- a/arch/arm/configs/sama7_defconfig
> +++ b/arch/arm/configs/sama7_defconfig
> @@ -170,7 +170,6 @@ CONFIG_RTC_DRV_AT91RM9200=y
>   CONFIG_RTC_DRV_AT91SAM9=y
>   CONFIG_DMADEVICES=y
>   CONFIG_AT_XDMAC=y
> -CONFIG_DMATEST=y
>   CONFIG_STAGING=y
>   CONFIG_MICROCHIP_PIT64B=y
>   # CONFIG_IOMMU_SUPPORT is not set


-- 
Nicolas Ferre
