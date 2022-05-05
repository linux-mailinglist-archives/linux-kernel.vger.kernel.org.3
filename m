Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F77151C316
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380907AbiEEO7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380893AbiEEO7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:59:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF8319036;
        Thu,  5 May 2022 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651762525; x=1683298525;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8u8iQQdbFCIjYVkUVW1oE+jbyTZg2TDE6RFS2HVSKm4=;
  b=MPlTVriwYQhco9Q/A99oo5TqOFP6/L4C2j4p4vbNivGuwG/0ntUqdADY
   N7POBn+8gliTnwkOi6h3eizcK1cU1J/LnUNq4djilGZq0y+rQaKrk9lJC
   KQFR/GAC5rNRoxmLi8hyEzJYycHBJ964/11tuaBzRXjHKrWiQcDzvWoNN
   0E2xFFhzPZmbJpktSVIeNBhTdNPGO427PFtUQDM8+T0h99KAd6vpRhqxx
   rQi6ltieZ9N4IhR8qUKr1iR/8mbNuqAP5ZMg24210DhVk96JRdSufL1WW
   tByxFfHQrxfeMdJZo7C8Jqev/Ib65h+xn5eRuTFM0qEUdZiJTO1ne73AC
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="154938494"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2022 07:55:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 5 May 2022 07:55:24 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 5 May 2022 07:55:21 -0700
Message-ID: <3dba24d7-8555-aa33-3bc7-2f0e19af2f48@microchip.com>
Date:   Thu, 5 May 2022 16:55:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 10/10] ARM: configs: sama7: enable
 CONFIG_RESET_CONTROLLER
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <robh+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <p.zabel@pengutronix.de>, <linux@armlinux.org.uk>,
        <sre@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <cristian.birsan@microchip.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220408080031.2527232-1-claudiu.beznea@microchip.com>
 <20220408080031.2527232-11-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220408080031.2527232-11-claudiu.beznea@microchip.com>
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

On 08/04/2022 at 10:00, Claudiu Beznea wrote:
> Enable CONFIG_RESET_CONTROLLER. It is necessary for resetting individual
> in SoC devices.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
and queued in at91-defconfig for 5.19.

Best regards,
   Nicolas

> ---
>   arch/arm/configs/sama7_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
> index 0368068e04d9..ce20bef1246e 100644
> --- a/arch/arm/configs/sama7_defconfig
> +++ b/arch/arm/configs/sama7_defconfig
> @@ -180,6 +180,7 @@ CONFIG_IIO_SW_TRIGGER=y
>   CONFIG_AT91_SAMA5D2_ADC=y
>   CONFIG_PWM=y
>   CONFIG_PWM_ATMEL=y
> +CONFIG_RESET_CONTROLLER=y
>   CONFIG_EXT2_FS=y
>   CONFIG_EXT3_FS=y
>   CONFIG_FANOTIFY=y


-- 
Nicolas Ferre
