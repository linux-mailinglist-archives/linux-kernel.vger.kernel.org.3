Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CC04A9DE3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377016AbiBDRmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:42:50 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:5600 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbiBDRmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643996569; x=1675532569;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y9incAF00vuAGK/HlCPZctghBSQU8PWccR9/9YGGkak=;
  b=rzgPwejEvZIPen8Hs9HJtVmuu+4F/u4K5kE15vNJL47CrABIO6R0MVuz
   ZY/e+CueAwNcf7+ZmO8sD7HnrzanVmYIE6yTq6hw001RZYOjoczLVp2x6
   4nLhRY4yxwZjYEV9eb3f6vGK/9V6JMX3zLb7Wf1jOqlwkaP8saPIMxBcJ
   EcmwgWJ5c1eFRzV3tmznTtZZU6zE28fE27tLGLrejI6Xwu9iZSkvs89Jh
   mxJO9EBwgRWFuZFvVoTehk3csOhM3q4ULhdtBX53poaiZu96mAuNvxC0a
   JjcbE842F86bPgguKSApFVf/+f3YKvf6FKHHfQVkWQG8coSEZcsAdt/85
   g==;
IronPort-SDR: grsLo3/A6FHA+lVRAGGvmM9FXmpg9UIodRcxMpiisKHkG61q8dOhZ0E0k0BdSkYAbeDYKnczxj
 04rEue6unwrfsP0hSr1eNOLoy4QUQuZQEazL8Llc8ySf7x5t1xlIZdD77YvVSSawWq/1AitT09
 2RwnVOwMG6CKAOSaw9Mq9GrVVXplZTvH3EtFpq+AwBE1Xop8Q/oMIFhKuT31PNj7LswzEd6YEn
 Yd5bART91mPhZALpEXNgT7M+bDEXuCfn3EI5zMMKaQqmlDBMGuYSr+W7e346Hi220ATfNoPwyw
 uAsgnW1FfY4dkujZ2ZjkH0UY
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="84715717"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Feb 2022 10:42:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Feb 2022 10:42:48 -0700
Received: from [10.12.90.195] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 4 Feb 2022 10:42:46 -0700
Message-ID: <d1933f3a-bd62-0cd3-4e09-ea9c20d356ac@microchip.com>
Date:   Fri, 4 Feb 2022 18:42:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ARM: dts: at91: sama7g5: Add crypto nodes
Content-Language: en-US
To:     Tudor Ambarus - M18064 <Tudor.Ambarus@microchip.com>,
        "Claudiu Beznea - M18063" <Claudiu.Beznea@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <20220204133751.498600-1-tudor.ambarus@microchip.com>
 <baa455c6-cdcb-7db4-1857-c2479fc21953@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <baa455c6-cdcb-7db4-1857-c2479fc21953@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2022 at 18:36, Tudor Ambarus - M18064 wrote:
> On 2/4/22 15:37, Tudor Ambarus wrote:
>> Describe and enable the AES, SHA and TDES crypto IPs.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>>   arch/arm/boot/dts/sama7g5.dtsi | 35 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
>> index 7972cb8c2562..1f2731a64139 100644
>> --- a/arch/arm/boot/dts/sama7g5.dtsi
>> +++ b/arch/arm/boot/dts/sama7g5.dtsi
>> @@ -393,6 +393,29 @@ pit64b1: timer@e1804000 {
>>   			clock-names = "pclk", "gclk";
>>   		};
>>   
>> +		aes: aes@e1810000 {
>> +			compatible = "atmel,at91sam9g46-aes";
>> +			reg = <0xe1810000 0x100>;
>> +			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
>> +			dmas = <&dma0 AT91_XDMAC_DT_PERID(1)>,
>> +			       <&dma0 AT91_XDMAC_DT_PERID(2)>;
>> +			dma-names = "tx", "rx";
>> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 27>;
>> +			clock-names = "aes_clk";
>> +			status = "okay";
>> +		};
>> +
>> +		sha: sha@e1814000 {
>> +			compatible = "atmel,at91sam9g46-sha";
>> +			reg = <0xe1814000 0x100>;
>> +			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
>> +			dmas = <&dma0 AT91_XDMAC_DT_PERID(48)>;
>> +			dma-names = "tx";
>> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 83>;
>> +			clock-names = "sha_clk";
>> +			status = "okay";
>> +		};
>> +
>>   		flx0: flexcom@e1818000 {
>>   			compatible = "atmel,sama5d2-flexcom";
>>   			reg = <0xe1818000 0x200>;
>> @@ -475,6 +498,18 @@ trng: rng@e2010000 {
>>   			status = "disabled";
>>   		};
>>   
>> +		tdes@e2014000 {
> tdes: tdes@e2014000
> 
> I should have added a label here. Nicolas, maybe you can add it when applying,
> if everything else looks ok to you.

Yep, if everything else is okay I can definitively add it when applying.

Regards,
   Nicolas

>> +			compatible = "atmel,at91sam9g46-tdes";
>> +			reg = <0xe2014000 0x100>;
>> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
>> +			dmas = <&dma0 AT91_XDMAC_DT_PERID(54)>,
>> +			       <&dma0 AT91_XDMAC_DT_PERID(53)>;
>> +			dma-names = "tx", "rx";
>> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 96>;
>> +			clock-names = "tdes_clk";
>> +			status = "okay";
>> +		};
>> +
>>   		flx4: flexcom@e2018000 {
>>   			compatible = "atmel,sama5d2-flexcom";
>>   			reg = <0xe2018000 0x200>;
> 


-- 
Nicolas Ferre
