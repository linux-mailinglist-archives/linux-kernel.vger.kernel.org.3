Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E624C3041
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiBXPrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiBXPri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:47:38 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAE633890;
        Thu, 24 Feb 2022 07:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645717628; x=1677253628;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ll3MqrDoeIh8KqQDetcgoJwBbe/DS1Rty18ugHPoHU8=;
  b=dtP4m30T8XpsZQQCgxbbzWixID4SoKRSPLk3R2FkCrxKsRmcc0idrGkB
   mAHamC/Du+Cba3lgCs7O1Tikb8sHiNg9RMnAhqFFlXyE7lRsy+c22ZbZx
   j2hGRASKnycfUQfszPUGHqyu9SjxGXKQNPiVYTuNEUiMqSUYENNBeOmW9
   gurehmbYblI4BE695NAf9N3lonQ+E18AEMBGc7ISpetnDLUKrn/9Whm7u
   ZEpaGR0ICIcOvBnqzEVyITd28DJKwF8oUyl7jYLdCy5wKhxSRpRqWeglp
   E89Dd9Y9qolztYYrxfAbCyKi6+1H3NFMKR34cTgFVXDfkcibJ7R4aHgC+
   w==;
X-IronPort-AV: E=Sophos;i="5.90,134,1643698800"; 
   d="scan'208";a="154774578"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2022 08:47:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 24 Feb 2022 08:47:06 -0700
Received: from [10.12.73.51] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 24 Feb 2022 08:47:04 -0700
Message-ID: <9858f8e2-619c-2c3b-f771-114bb5379876@microchip.com>
Date:   Thu, 24 Feb 2022 16:47:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] 1/3] ARM: dts: at91: sama7g5: Restrict ns_sram
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Hari Prasath <Hari.PrasathGE@microchip.com>
CC:     <claudiu.beznea@microchip.com>, <davem@davemloft.net>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@armlinux.org.uk>
References: <20220222113924.25799-1-Hari.PrasathGE@microchip.com>
 <YhVLpnQ5fKs5x1Hq@piout.net>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <YhVLpnQ5fKs5x1Hq@piout.net>
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

On 22/02/2022 at 21:46, Alexandre Belloni wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 22/02/2022 17:09:22+0530, Hari Prasath wrote:
>> Limit the size of SRAM available for the rest of kernel via genalloc API's to
>> 13k. The rest of the SRAM is used by CAN controllers and hence this restriction.
>>
> 
> Certainly not, if the can controller need the SRAM, they have to
> allocate it properly.

I'm not sure that bosh mcan driver can be used with dynamic allocation 
of SRAM. Is it what you're thinking about?

In the meantime, I'm taking the CAN patches of this series as they match 
what we currently do for other users of mcan driver on other SoCs.

Regards,
   Nicolas

>> Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>
>> ---
>>   arch/arm/boot/dts/sama7g5.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
>> index eddcfbf4d223..6c7012f74b10 100644
>> --- a/arch/arm/boot/dts/sama7g5.dtsi
>> +++ b/arch/arm/boot/dts/sama7g5.dtsi
>> @@ -65,7 +65,7 @@
>>                compatible = "mmio-sram";
>>                #address-cells = <1>;
>>                #size-cells = <1>;
>> -             reg = <0x100000 0x20000>;
>> +             reg = <0x100000 0x3400>;
>>                ranges;
>>        };
>>
>> --
>> 2.17.1
>>
> 
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


-- 
Nicolas Ferre
