Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2FC4CD3C3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbiCDLur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCDLuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:50:46 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EEE18022F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 03:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646394598; x=1677930598;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fUXyJLIdFhiyxULhk8zOA6BP1tAoMR/8RP78/EcpwW0=;
  b=wWM65DfJJBlGCxTKE2Y35NoPgP24nebFyaSQQ2FgoDBLItzGCe2fjVuv
   LQAFkRInehUkKlXmXeRjiqRU4+/Tx4mk8eRUW69wuloViMtaaomTflGBp
   RU+x0N21izHasq6Zvl8DkaYbUovs4BlbLX36I+JO6yYXACyWzb+5ElPZ4
   N97YU/surm3h6X6VkItQ5en8tbQvbcUWQQNO1NzCR5lBbrm/7ih78/cmo
   IarpzIEvxJQ6UJe41wl+4vqzyGfGc1DR2DsgS0O9HdfAxcqEij3Kqixg5
   Zn+kSUr6OBOAvdPpykTflSkksMvW8NxfNimTkdJ87eA1ZfRtUqYwvGV2/
   g==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="87826588"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 04:49:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 04:49:57 -0700
Received: from [10.12.72.98] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 4 Mar 2022 04:49:56 -0700
Message-ID: <60224607-230a-8933-bb6e-f907df0630c8@microchip.com>
Date:   Fri, 4 Mar 2022 12:49:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ARM: at91: add support in soc driver for new SAMA5D29
Content-Language: en-US
To:     Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mihai Sain - M19926" <Mihai.Sain@microchip.com>
References: <20220302155329.27668-1-nicolas.ferre@microchip.com>
 <63d5bc08-7681-954a-2106-2653abf76b57@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <63d5bc08-7681-954a-2106-2653abf76b57@microchip.com>
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

On 03/03/2022 at 09:19, Claudiu Beznea - M18063 wrote:
> On 02.03.2022 17:53, nicolas.ferre@microchip.com wrote:
>> From: Mihai Sain <mihai.sain@microchip.com>
>>
>> Add detection of new SAMA5D29 by the SoC driver.
>>
>> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Queued in at91-soc for 5.18.

Best regards,
   Nicolas

> 
>> ---
>>   drivers/soc/atmel/soc.c | 3 +++
>>   drivers/soc/atmel/soc.h | 1 +
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
>> index a490ad7e090f..b2d365ae0282 100644
>> --- a/drivers/soc/atmel/soc.c
>> +++ b/drivers/soc/atmel/soc.c
>> @@ -156,6 +156,9 @@ static const struct at91_soc socs[] __initconst = {
>>   	AT91_SOC(SAMA5D2_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
>>   		 AT91_CIDR_VERSION_MASK, SAMA5D28C_LD2G_EXID_MATCH,
>>   		 "sama5d28c 256MiB LPDDR2 SiP", "sama5d2"),
>> +	AT91_SOC(SAMA5D2_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
>> +		 AT91_CIDR_VERSION_MASK, SAMA5D29CN_EXID_MATCH,
>> +		 "sama5d29", "sama5d2"),
>>   	AT91_SOC(SAMA5D3_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
>>   		 AT91_CIDR_VERSION_MASK, SAMA5D31_EXID_MATCH,
>>   		 "sama5d31", "sama5d3"),
>> diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
>> index c3eb3c8f0834..2ecaa75b00f0 100644
>> --- a/drivers/soc/atmel/soc.h
>> +++ b/drivers/soc/atmel/soc.h
>> @@ -95,6 +95,7 @@ at91_soc_init(const struct at91_soc *socs);
>>   #define SAMA5D28C_LD2G_EXID_MATCH	0x00000072
>>   #define SAMA5D28CU_EXID_MATCH		0x00000010
>>   #define SAMA5D28CN_EXID_MATCH		0x00000020
>> +#define SAMA5D29CN_EXID_MATCH		0x00000023
>>   
>>   #define SAMA5D3_CIDR_MATCH		0x0a5c07c0
>>   #define SAMA5D31_EXID_MATCH		0x00444300
> 


-- 
Nicolas Ferre
