Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1B74FF6FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbiDMMn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbiDMMn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:43:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949801D0D3;
        Wed, 13 Apr 2022 05:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649853661; x=1681389661;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ebMpJGGb5gMCwHAMeqEodjyAC5Xzs4wopUvYXPdNTQ8=;
  b=MKO+u/3gFr+i33VGC23EJTDZVDMQ2kur4tNdtkLi/tdh0oUj0oIHLBVQ
   HBipATd3v1EobsnDRNYDzXKC8hwGyXqjpVAcp23Dj3bgoLWor614zw3j8
   QrpiGVm543PE+d3nYM3zvCzHBlApyQI8DK+hTtWkiPZyk/R+c6nIAJCTf
   s3k6m9VRCNnTgOB72BAwG45xIL447O0ewk7Nc7OM2QBCfebzZFRfTUUwL
   I0NN+Y3rNA0l6f1AIDiBsLf3Bow2wmrjqYoZJozLCN+BIdbjPLW3DzSBU
   IueTDe8AcZ6uJ9/1fkXgQL3YRzeWW6Wa6Xk/fseIqpA7D0coRiav7QsW6
   g==;
X-IronPort-AV: E=Sophos;i="5.90,256,1643698800"; 
   d="scan'208";a="160393691"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Apr 2022 05:40:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Apr 2022 05:40:51 -0700
Received: from [10.12.72.146] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 13 Apr 2022 05:40:50 -0700
Message-ID: <732474b0-12e4-8dc2-d957-d71aeb40e966@microchip.com>
Date:   Wed, 13 Apr 2022 14:40:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ARM: dts: at91: sama7g5ek: Align the impedance of the
 QSPI0's HSIO and PCB lines
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <claudiu.beznea@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Mihai Sain" <mihai.sain@microchip.com>
References: <20220406130505.422042-1-tudor.ambarus@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220406130505.422042-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2022 at 15:05, Tudor Ambarus wrote:
> The impedance of the QSPI PCB lines on the sama7g5ek is 50 Ohms.
> Align the output impedance of the QSPI0 HSIOs by setting a medium drive
> strength which corresponds to an impedance of 56 Ohms when VDD is in the
> 3.0V - 3.6V range. The high drive strength setting corresponds to an
> output impedance of 42 Ohms on the QSPI0 HSIOs.
> 
> Suggested-by: Mihai Sain <mihai.sain@microchip.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
And queued in "fixes" branch for 5.18.

Thanks, best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/at91-sama7g5ek.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
> index 08685a10eda1..8f9643170ba3 100644
> --- a/arch/arm/boot/dts/at91-sama7g5ek.dts
> +++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
> @@ -655,7 +655,7 @@ pinctrl_qspi: qspi {
>   			 <PIN_PB21__QSPI0_INT>;
>   		bias-disable;
>   		slew-rate = <0>;
> -		atmel,drive-strength = <ATMEL_PIO_DRVSTR_HI>;
> +		atmel,drive-strength = <ATMEL_PIO_DRVSTR_ME>;
>   	};
>   
>   	pinctrl_sdmmc0_default: sdmmc0_default {


-- 
Nicolas Ferre
