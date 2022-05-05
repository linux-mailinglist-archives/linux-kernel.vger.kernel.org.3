Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA6B51C0DB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379916AbiEENf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379794AbiEENex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:34:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F4857161;
        Thu,  5 May 2022 06:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651757457; x=1683293457;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bBeL7VG4B1BfSIJpQYXGtLTM84mhXf094fNxVcH+l0c=;
  b=sB3JoVSNsKLBwGzkNmncp0yVZ6RUx+QjsyNRNRdKFhRu3c9KWRBo41t7
   xI3gZ+ezFtNp9fiwdZa9/AgfFE7s4V6VTwwKGNcsRbTkGk0T8DB0wXh8W
   ok36/fEsCo5oNPWjKacDt2EqmzA3GV+mHOZN9bEvbq7Z1dGMsHQf21Shq
   3/wA6BJb0sK6U0RvRln9rRfDu5ULLaW8ClnlUYUGHObl2QCCay+nLQpYi
   sp1rQpSEFcTOowfMoOYqsd61GUwmCDIuVjluRIBlKhDLsTxtzwHNG6mC6
   aF8Kw1habsKUqVJGBB9V86jTNAfDCu6I40c3/N0Gjuasrmzy5FBe9jx40
   A==;
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="154927945"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2022 06:30:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 5 May 2022 06:30:54 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 5 May 2022 06:30:52 -0700
Message-ID: <71390da3-1130-3595-b7f2-8c0ac2d4cd9d@microchip.com>
Date:   Thu, 5 May 2022 15:30:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v10 4/5] ARM: configs: at91: sama7: add xisc and csi2dc
Content-Language: en-US
To:     Eugen Hristev <eugen.hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <claudiu.beznea@microchip.com>, <jacopo@jmondi.org>
References: <20220503095127.48710-1-eugen.hristev@microchip.com>
 <20220503095127.48710-5-eugen.hristev@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220503095127.48710-5-eugen.hristev@microchip.com>
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

On 03/05/2022 at 11:51, Eugen Hristev wrote:
> Enable XISC and CSI2DC drivers.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
and queued in at91-defconfig branch for 5.19, as the drivers and 
defconfig options are already there in 5.18-rc1.

Thanks, best regards,
   Nicolas

> ---
>   arch/arm/configs/sama7_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
> index 07b0494ef743..b375bf5f924c 100644
> --- a/arch/arm/configs/sama7_defconfig
> +++ b/arch/arm/configs/sama7_defconfig
> @@ -138,6 +138,8 @@ CONFIG_MEDIA_SUPPORT_FILTER=y
>   CONFIG_MEDIA_CAMERA_SUPPORT=y
>   CONFIG_MEDIA_PLATFORM_SUPPORT=y
>   CONFIG_V4L_PLATFORM_DRIVERS=y
> +CONFIG_VIDEO_ATMEL_XISC=y
> +CONFIG_VIDEO_MICROCHIP_CSI2DC=y
>   CONFIG_VIDEO_IMX219=m
>   CONFIG_VIDEO_IMX274=m
>   CONFIG_VIDEO_OV5647=m


-- 
Nicolas Ferre
