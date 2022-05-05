Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD8F51C3B5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349165AbiEEPVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347238AbiEEPVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:21:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC1E47054;
        Thu,  5 May 2022 08:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651763877; x=1683299877;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X6h6rS6jN3qu9nIBCNmP+TfMLkXzjzPBQUYyg739b9o=;
  b=05iRsWRJgYQkFdtN5RbjELZ1Vlmi6VHODVulMmGLsmRyHs6axfzMq9KM
   dHH1jonND1aqLRaicnIwPMEk5SqW3Y+GpspffOdJkhB2R16HdXiARNcW2
   fLw5rTPf6G6G4PaBJckhqPUnmWNVjuANc4Am25/D6BzC8yYLCTjKJZMNh
   x49lsZ47jmrmjRuWjKyDepeyTzrzKbS0Om5gWnkQzZDZ8vBClZOje92kx
   Qk80nzirSAGSWfZpLheOFz0+NBk80LHm4GpuwRXb98exyMbiW+X4dda8M
   DwRsmV9e3YLH6TivWzeF3qZFr+Y2blDl7ULtrdXsz3HfczCnYW+AKAgbF
   w==;
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="162455081"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2022 08:17:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 5 May 2022 08:17:56 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 5 May 2022 08:17:54 -0700
Message-ID: <10b7ac7b-b996-cc24-e116-3a76c2683dad@microchip.com>
Date:   Thu, 5 May 2022 17:17:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v10 5/5] ARM: multi_v7_defconfig: add atmel video pipeline
 modules
Content-Language: en-US
To:     Eugen Hristev <eugen.hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <claudiu.beznea@microchip.com>, <jacopo@jmondi.org>
References: <20220503095127.48710-1-eugen.hristev@microchip.com>
 <20220503095127.48710-6-eugen.hristev@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220503095127.48710-6-eugen.hristev@microchip.com>
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
> Add drivers for the atmel video capture pipeline: atmel isc, xisc and
> microchip csi2dc.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Queued in at91-defconfig for 5.19.
Best regards,
   Nicolas

> ---
>   arch/arm/configs/multi_v7_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 6e0c8c19b35c..621bd1cbaf7c 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -662,7 +662,10 @@ CONFIG_VIDEO_S5P_MIPI_CSIS=m
>   CONFIG_VIDEO_EXYNOS_FIMC_LITE=m
>   CONFIG_VIDEO_EXYNOS4_FIMC_IS=m
>   CONFIG_VIDEO_RCAR_VIN=m
> +CONFIG_VIDEO_ATMEL_ISC=m
> +CONFIG_VIDEO_ATMEL_XISC=m
>   CONFIG_VIDEO_ATMEL_ISI=m
> +CONFIG_VIDEO_MICROCHIP_CSI2DC=m
>   CONFIG_V4L_MEM2MEM_DRIVERS=y
>   CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
>   CONFIG_VIDEO_SAMSUNG_S5P_MFC=m


-- 
Nicolas Ferre
