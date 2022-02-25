Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693324C424D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbiBYK3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236331AbiBYK3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:29:19 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492371C46AA;
        Fri, 25 Feb 2022 02:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645784928; x=1677320928;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Sxit2uIg39ogJ/fuDzwyVE9TzutAZmAGpVm4AVaajUY=;
  b=AIA8BkRNA2aRjIBS9fnBxw+8S4ETSisxuCt99pmgfTXgmIDCXr6+/W4W
   pX8BfomiLwi8PoSvrWOD3cK4Te4I2Pf0ZmbI6okf38zDRJ/8LfKPrnTGq
   2XzsgrJq5z6xbamGaX1YP6xY+b5SKW42lQiG2b4gDax/hjRkDJDW9uMLi
   eJGBm4OQD24QSFgTizkqX6WmsweHjiMCveiTCqWINUu97lyDqlfyyUI8b
   3Dvk+KgunmpoKcrGZP8kEv+H22erNTg01WkcVnLa946jKaTf21JRVojbE
   X9SmUwMgI68msV+82z9p7GgXDtEZb2TCoHMjFUKMd988lnvBk/bEveWIF
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,136,1643698800"; 
   d="scan'208";a="154890553"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2022 03:28:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 25 Feb 2022 03:28:47 -0700
Received: from [10.12.72.56] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 25 Feb 2022 03:28:46 -0700
Message-ID: <3cc35822-cbfb-28e5-5fdb-76ceb1eebd27@microchip.com>
Date:   Fri, 25 Feb 2022 11:28:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ARM: dts: at91: sama7g5: Add NAND support
Content-Language: en-US
To:     Tudor Ambarus - M18064 <Tudor.Ambarus@microchip.com>
CC:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "Ludovic Desroches - M43218" <Ludovic.Desroches@microchip.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220111130556.905978-1-tudor.ambarus@microchip.com>
 <2fa34fae-7736-670a-1d31-7928fbcf95bd@microchip.com>
 <c708f761-aad4-a2f2-9255-01bcb6ad73de@microchip.com>
 <3cd1fd6b-d3a4-5ac5-22fa-c854e2f25a65@microchip.com>
 <647e801b-88d3-6169-0354-ba1cdff8d807@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <647e801b-88d3-6169-0354-ba1cdff8d807@microchip.com>
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

On 24/02/2022 at 19:26, Tudor Ambarus - M18064 wrote:
> On 2/24/22 19:44, Nicolas Ferre wrote:
>> Hi Tudor,
> 
> Hi,
> 
>>
>> On 24/02/2022 at 16:49, Tudor Ambarus - M18064 wrote:
>>> On 2/24/22 17:04, Nicolas Ferre wrote:
>>>> On 11/01/2022 at 14:05, Tudor Ambarus wrote:
>>>>> Add NAND support. The sama7g5's SMC IP is the same as sama5d2's with
>>>>> a slightly change: it provides a synchronous clock output (SMC clock)
>>>>> that is dedicated to FPGA usage. Since this doesn't interfere with the SMC
>>>>> NAND configuration, thus code will not be added in the current nand driver
>>>>> to address the FPGA usage, use the sama5d2's compatible and choose not to
>>>>> introduce dedicated compatibles for sama7g5.
>>>>> Tested with Micron MT29F4G08ABAEAWP NAND flash.
>>>>>
>>>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>>>>
>>>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>>>
>>>>> ---
>>>>> The patch depends on the following patch:
>>>>> https://lore.kernel.org/linux-clk/20220111125310.902856-1-tudor.ambarus@microchip.com/T/#u
>>>>
>>>> Patch seems taken, so I add this one to at91-dt branch for 5.18 merge window.
>>>>
>>>
>>> I think it depends on who gets to next first. If at91 gets before clk,
>>> there will be a build error, isn't it?
>>
> 
> Sorry, not linux-next, but whose PR gets first applied by Linus.
> 
>> Clk patch is already in linux-next, so no worries.
>> Moreover, I don't get why there could be a build error as there is no build dependency between DT changes and C changes.
>> Sorry but I'm puzzled... Or I'm not looking at the right patch.
>>
> 
> You would see this kind of error:
> Error: arch/arm/boot/dts/sama7g5.dtsi:102.21-22 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:346: arch/arm/boot/dts/at91-sama7g5ek.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1385: dtbs] Error 2
> make: *** Waiting for unfinished jobs....
> 
> This patch uses "PMC_MCK1" which is defined in:
> https://lore.kernel.org/linux-clk/20220111125310.902856-1-tudor.ambarus@microchip.com/T/#u
> 
> If Linus applies the arm-soc PR before the clk PR, it will see the same error, no?

Yes, absolutely.
So I need to have an immutable branch from Stephen then. I'm removing 
the patch from the at91-dt branch for now.

Thanks for the insight and sorry not having overlooked at that crucial 
piece of header file ;-)

Best regards,
   Nicolas

-- 
Nicolas Ferre
