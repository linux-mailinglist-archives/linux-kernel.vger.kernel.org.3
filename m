Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541E24C3516
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 19:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiBXSzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 13:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiBXSzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 13:55:25 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1790924FB98;
        Thu, 24 Feb 2022 10:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645728895; x=1677264895;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yz3VSeeqS/d8vtsV1wM/LL37fEG9kXMUFrMpOBnMrT0=;
  b=Wr8dVCEqZiVfStV94KZJME9KB8cd8DcXJqqz8xINpM+HUqxYYmhasQ2F
   /tC/QnPEnavn20jC26Bij2geh9JcZPfAFBD9FAD5OIYYa6ceF0fOTeg7R
   DyRmkycdpxKByFGe3a1vftUhF/R3CnOCDaCqnHUrZ390fUXd2Sy1VSY5B
   C6x6f8cpTSgi40qEsJCXzQ1HUSc4dnNn/MunkOoLCP8V38fdMuk6bSnd8
   dTlbC07hSGNxxYvJ5Zf2uCqSFwxEWZ9hZkW8a+/ltK1FkwXaVvfZiKjbf
   1J00DgVihPs+3LxItK3U/QIEUHENyiZVuT/8fGkISo/dm4zlILVI5zSeU
   g==;
X-IronPort-AV: E=Sophos;i="5.90,134,1643698800"; 
   d="scan'208";a="154308419"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2022 11:54:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 24 Feb 2022 11:54:54 -0700
Received: from [10.12.73.51] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 24 Feb 2022 11:54:52 -0700
Message-ID: <c8eafea6-f530-1e17-7557-d4fa4224ee2a@microchip.com>
Date:   Thu, 24 Feb 2022 19:54:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ARM: configs: at91: sama7: Enable crypto IPs and software
 algs
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <claudiu.beznea@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>
References: <20220204135905.512013-1-tudor.ambarus@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220204135905.512013-1-tudor.ambarus@microchip.com>
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

On 04/02/2022 at 14:59, Tudor Ambarus wrote:
> Similar to sama5_defconfig, enable hardware acceleration for the
> sama7 crypto IPs, enable crypto software implementations in case
> the crypto IPs need a fallback to them, and enable the hash and
> skcipher user interfaces in case one wants to offload the crypto
> algs to the sama7 crypto IPs.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Queued for 5.18 in at91-defconfig

Regards,
   Nicolas

> ---
>   arch/arm/configs/sama7_defconfig | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
> index c12278174579..d6e27b837f88 100644
> --- a/arch/arm/configs/sama7_defconfig
> +++ b/arch/arm/configs/sama7_defconfig
> @@ -196,7 +196,19 @@ CONFIG_NLS_CODEPAGE_850=y
>   CONFIG_NLS_ISO8859_1=y
>   CONFIG_NLS_UTF8=y
>   CONFIG_LSM="N"
> -# CONFIG_CRYPTO_HW is not set
> +CONFIG_CRYPTO_AUTHENC=y
> +CONFIG_CRYPTO_GCM=y
> +CONFIG_CRYPTO_CBC=y
> +CONFIG_CRYPTO_CFB=y
> +CONFIG_CRYPTO_OFB=y
> +CONFIG_CRYPTO_XTS=y
> +CONFIG_CRYPTO_SHA1=y
> +CONFIG_CRYPTO_DES=y
> +CONFIG_CRYPTO_USER_API_HASH=m
> +CONFIG_CRYPTO_USER_API_SKCIPHER=m
> +CONFIG_CRYPTO_DEV_ATMEL_AES=y
> +CONFIG_CRYPTO_DEV_ATMEL_TDES=y
> +CONFIG_CRYPTO_DEV_ATMEL_SHA=y
>   CONFIG_CRC_CCITT=y
>   CONFIG_CRC_ITU_T=y
>   CONFIG_DMA_CMA=y


-- 
Nicolas Ferre
