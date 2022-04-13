Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3434FF22E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiDMIm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbiDMIlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:41:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F3451E4E;
        Wed, 13 Apr 2022 01:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649839128; x=1681375128;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3jpw++PisIykZNdamU26KW5ExhnwU6YvVfJwxILHeGY=;
  b=FQzWivbvpE90ZISCdAmBlXxkoA5KWL67yNp2cDh4a1ZabqsOv2pDCqdY
   Bh5dW8GfWt5L2SrYP+WJ15WXdVIAPNIx6pPXRfiE3sXqGpUKwo0AQFE5a
   nEh5W1wDd3qQ0SjjVyiq2Vxt5G852NKT1JerHPZDoLuEIFaAxAb7OZBKD
   q9z8qwrGHlSuQsgTB9OFC2vtz+JDu27bBKeTnzZYMe3A2URt72T+Wwuq1
   a56PCOpmYifHc64eN1IUr8U2l/WxxgKUITtkUY5CHYA+2hhN9k6WGP1CW
   bP9qWKZUr663V03VIJmXrprtSM0N03JtI4I4NVtr2jFyyq16T/u/QURGC
   w==;
X-IronPort-AV: E=Sophos;i="5.90,256,1643698800"; 
   d="scan'208";a="152490618"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Apr 2022 01:38:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Apr 2022 01:38:45 -0700
Received: from [10.12.72.146] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 13 Apr 2022 01:38:43 -0700
Message-ID: <ff06fc40-d77e-29e1-a944-5c67401c9000@microchip.com>
Date:   Wed, 13 Apr 2022 10:38:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ARM: dts: at91: sama7g5ek: enable pull-up on flexcom3
 console lines
Content-Language: en-US
To:     Tudor Ambarus - M18064 <Tudor.Ambarus@microchip.com>,
        "Eugen Hristev - M18282" <Eugen.Hristev@microchip.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <20220307113827.2419331-1-eugen.hristev@microchip.com>
 <d16673c8-3a19-fcbf-63d0-2d2090fc7318@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <d16673c8-3a19-fcbf-63d0-2d2090fc7318@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2022 at 09:21, Tudor Ambarus - M18064 wrote:
> On 3/7/22 13:38, Eugen Hristev wrote:
>> Flexcom3 is used as board console serial. There are no pull-ups on these
>> lines on the board. This means that if a cable is not connected (that has
>> pull-ups included), stray characters could appear on the console as the
>> floating pins voltage levels are interpreted as incoming characters.
>> To avoid this problem, enable the internal pull-ups on these lines.
>>
>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> 
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
and queued for "fixes". Thanks!
Best regards,
   Nicolas

> 
>> ---
>>   arch/arm/boot/dts/at91-sama7g5ek.dts | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
>> index 08685a10eda1d..dd047a8523907 100644
>> --- a/arch/arm/boot/dts/at91-sama7g5ek.dts
>> +++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
>> @@ -495,7 +495,7 @@ pinctrl_flx0_default: flx0_default {
>>   	pinctrl_flx3_default: flx3_default {
>>   		pinmux = <PIN_PD16__FLEXCOM3_IO0>,
>>   			 <PIN_PD17__FLEXCOM3_IO1>;
>> -		bias-disable;
>> +		bias-pull-up;
>>   	};
>>   
>>   	pinctrl_flx4_default: flx4_default {
> 


-- 
Nicolas Ferre
