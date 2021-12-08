Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3079D46D409
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbhLHNKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:10:02 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:5375 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbhLHNKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638968790; x=1670504790;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=jh6mxBNO75eKiLroV3CDybmYfkuTrxUZbbJ62ggZfZo=;
  b=KXmwA5G7+2It47KYP+ii1czSbQdfKsjbo9m/892z3WBM1nF+NkUkV/RN
   fFsfWr4qtPvm757cUCNRLAZSWooneYJzt67UuWYHi50csxlT5JLCdsK6M
   xAs/ea/bSwfknPjegrUxN25AcSRtFZ5aS2BhPnoaSK3AJkXfHq0YwgF8M
   GBHkecueGXjC84BipIUtuYhLF3KZoDieCG5/XZUbmzPEmoRKK+ZaCB97W
   TA3nBGuzRgDpkQvl1IzfCIojxtJZ31GvPpeRemBNW9MUlwL02kH5ECqnK
   zieHnevQCX5xWT4dPAZlZ2WX2A+JkYjQi902myhd51rMbzjZQ93QgQgfx
   g==;
IronPort-SDR: 95x4FUykj2nnJ0x2vtVb+J2cFCtZF1gxDQlLBLRgidQzXtkdDGK1RveRW0TWheTcDrm6XQiIiv
 peLlmjAohSm4cmiqgnEZs1R5nXL+yCaHRK69EisG55IdolxwgqN8dC3aIDMamc1gK6/0kvZCEJ
 VLC1lVJW9vo0hQHG35fI1OC4V2Aigta9vDqWdjrbuTMvJsEQCmAcQnciGyv5RDGfnyOKZswavZ
 9avFY1Y3ZYgl1rArb2yJIYE/wTVebo0y+ea3MixU2KsC4YHpiOy13Xs/tNsrU1ofegbcr3ZVuP
 CO5wHWbtvcShsLnuYyx/09k1
X-IronPort-AV: E=Sophos;i="5.88,189,1635231600"; 
   d="scan'208";a="145936577"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Dec 2021 06:06:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 8 Dec 2021 06:06:29 -0700
Received: from [10.12.73.2] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Wed, 8 Dec 2021 06:06:27 -0700
Subject: Re: [PATCH] ARM: dts: at91: sama5d2_xplained: remove
 PA11__SDMMC0_VDDSEL from pinctrl
To:     Eugen Hristev - M18282 <Eugen.Hristev@microchip.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "Ludovic Desroches - M43218" <Ludovic.Desroches@microchip.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mihai Sain - M19926 <Mihai.Sain@microchip.com>
References: <20211026132034.678655-1-eugen.hristev@microchip.com>
 <28f0898c-0d6c-a77e-4068-b49c6dd0aa64@microchip.com>
 <f943539b-bc95-35c9-a634-ad75f9df54b0@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <ff254ab5-1d57-3aea-1232-4f26766eeb62@microchip.com>
Date:   Wed, 8 Dec 2021 14:06:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f943539b-bc95-35c9-a634-ad75f9df54b0@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2021 at 12:27, Eugen Hristev - M18282 wrote:
> On 12/8/21 1:22 PM, Nicolas Ferre wrote:
>> On 26/10/2021 at 15:20, Eugen Hristev wrote:
>>> From: Mihai Sain <mihai.sain@microchip.com>
>>>
>>> I/O voltage for eMMC is always 3.3V because PA11__SDMMC0_VDDSEL is
>>> tied with 10K resistor to GND. U13 switch S1 is always selected as
>>> voltage rail of 3.3V for VCCQ power pin from MPU controller and eMMC
>>> flash.
>>> Removing PA11 from pinctrl because it remains unused.
>>>
>>> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
>>
>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> You can also add my
> Reviewed-by: Eugen Hristev <eugen.hristev@microchip.com>
> 
> and also
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> because I sent the patch.

Sure Eugen: Done. Best regards,
   Nicolas

>>> ---
>>>    arch/arm/boot/dts/at91-sama5d2_xplained.dts | 5 ++---
>>>    1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
>>> b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
>>> index b1e854f658de..9bf2ec0ba3e2 100644
>>> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
>>> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
>>> @@ -66,7 +66,7 @@ sdmmc0: sdio-host@a0000000 {
>>>                pinctrl-names = "default";
>>>                pinctrl-0 = <&pinctrl_sdmmc0_default>;
>>>                non-removable;
>>> -            mmc-ddr-1_8v;
>>> +            mmc-ddr-3_3v;
>>>                status = "okay";
>>>            };
>>> @@ -619,10 +619,9 @@ cmd_data {
>>>                            bias-disable;
>>>                        };
>>> -                    ck_cd_rstn_vddsel {
>>> +                    ck_cd_rstn {
>>>                            pinmux = <PIN_PA0__SDMMC0_CK>,
>>>                                 <PIN_PA10__SDMMC0_RSTN>,
>>> -                             <PIN_PA11__SDMMC0_VDDSEL>,
>>>                                 <PIN_PA13__SDMMC0_CD>;
>>>                            bias-disable;
>>>                        };
>>>
>>
>>
> 


-- 
Nicolas Ferre
