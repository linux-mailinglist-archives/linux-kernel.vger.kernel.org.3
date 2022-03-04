Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C414CD3C6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbiCDLwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiCDLwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:52:16 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE0E1B2AD8;
        Fri,  4 Mar 2022 03:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646394689; x=1677930689;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FxwcU+/OZL3whMMuPBQkDX2LZjf2mVv8lduqCz1axG0=;
  b=qhYCa4gTufDvva+IbgBsJQfSCdjP7/3PDPuA4+kA/jfEPw3ZdDrCVliA
   O69VRWicIuqj6E+TK+ORhfGztH47rqaiNFcJwqNJDRHVjiQ0eD+9COkww
   yFTuiVHVoVDASKnLEql1zUOrl2L6Ar+xI8JP8abqbyBx0LWwNjPvI0yZ5
   +bjxXsrZcZBd91R4nbw4h203cFf+vKY1FxODq4yezwKjMrRCv091SvUAx
   qanEsVSbC9wuCqxxw+RMxPMmprTg0nbRtc1FENZUplEy5gl7Ne+Oq/8cI
   ffSWcpCV6UFNHT30wHRJ+qgOrdBKSgxLcP06gLS72gn8lCGkYbjCBiYBy
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="87826740"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 04:51:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 04:51:28 -0700
Received: from [10.12.72.98] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 4 Mar 2022 04:51:26 -0700
Message-ID: <67d0ca93-cf95-8d7c-3658-bf6843c2bb51@microchip.com>
Date:   Fri, 4 Mar 2022 12:51:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] ARM: configs: at91: add eic
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <robh+dt@kernel.org>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220228122326.1400954-1-claudiu.beznea@microchip.com>
 <20220228122326.1400954-3-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220228122326.1400954-3-claudiu.beznea@microchip.com>
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

On 28/02/2022 at 13:23, Claudiu Beznea wrote:
> Add eic.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Queued for 5.18 in at91-defconfig
Regards,
   Nicolas

> ---
>   arch/arm/configs/sama7_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
> index aad10ae85a7d..ecb5c4b750e1 100644
> --- a/arch/arm/configs/sama7_defconfig
> +++ b/arch/arm/configs/sama7_defconfig
> @@ -190,6 +190,7 @@ CONFIG_IIO_SW_TRIGGER=y
>   CONFIG_AT91_SAMA5D2_ADC=y
>   CONFIG_PWM=y
>   CONFIG_PWM_ATMEL=y
> +CONFIG_MCHP_EIC=y
>   CONFIG_EXT2_FS=y
>   CONFIG_EXT3_FS=y
>   CONFIG_FANOTIFY=y


-- 
Nicolas Ferre
