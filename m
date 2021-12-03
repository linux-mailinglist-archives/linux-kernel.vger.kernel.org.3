Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0532A467BAE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352792AbhLCQpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:45:06 -0500
Received: from smtpcmd02102.aruba.it ([62.149.158.102]:53425 "EHLO
        smtpcmd02102.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239781AbhLCQo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:44:59 -0500
Received: from [192.168.50.18] ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id tBcmmvO88hA9ytBcmmbQVC; Fri, 03 Dec 2021 17:41:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638549691; bh=0omarPqSCxMZeW4GAMAOhc25owOssWmw/f6Jf99lGjY=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=Gjl/1PQudrOXZ0XvwEd6LtdlfSHU1T3NCaemzLfRQbuPzOMZh8HsVbKioxMhKDGmm
         kZEm9PHMKNcxKU5ShCED7LZJPrDopxyS6ey8qTEnkB02p1WS6oYUlVhFG5x/v9bXxP
         F67EblW2GWAaH/QZ8WWsvllXQq2yf4IFl1pEDCUI9IYMPd0QgcYRy58fyyfDFrRQzh
         vRf4yU3SPS2vvCQdcsXlim0ntiRyhLNMKtSsrffi/J8ItHDowDDFms0dPe+JpCymqq
         sKvt2NJrJlC4AjVgZd/t0T9SKy2yJCtFV1K561xKyKhaRk6DJTpqu7AT0LvFhOLxfO
         Xx6U/yPjIp5Dw==
Subject: Re: [PATCH] ARM: Kconfig: improve ARM_SINGLE_ARMV7M description with
 Cortex M7
To:     Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mike Rapoport <rppt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <20211202222002.33456-1-giulio.benetti@benettiengineering.com>
 <db427a15-231b-957e-3690-73373fec55ea@arm.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Message-ID: <170aea55-44f3-9cf0-fd88-adf8c66efeb4@benettiengineering.com>
Date:   Fri, 3 Dec 2021 17:41:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <db427a15-231b-957e-3690-73373fec55ea@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOuQj5VxvHxHB5ilqz8dUJ7Upx6BugAV0SNXDx3UtiJho+ttH0L818rn0YJAb5pg/i05f8Zj4RUoHjXFdo0DHRQOd+1hXTzUwApdHJRz6lJY2hglQGDZ
 aWN+q/FROxt3qNdBEZIsGUHXdgjhVParHR7kHluqpTv1iBG3bCwA7pCY3QRouQONK4RAT1bCYgGu4dpMyvKQwvEYVyqplJwA6EYQcb4c9m70om/xcoFvv1gB
 M4H+pAnGc1cGDOd/aAAf+Cyf98x8G1FKgDe+9VNkMWOqXrt/179v+MGSQr1rBBgQzw+FKAso6ucTwIm02G5+8uKWknMSvElkBYyVRCq9M+fzxkiusiEC2oMi
 Y4d7xChsXJA35qWRsSsMxXMcasPN0GGbkL5bRsBEomUjJB/xV3K8CvFHhsQuw1Y/3ejehH4F08oQjveIQrA+Vc/UILawsjXn3HA73cSpTMrRUCMxrAc8Brcs
 BSc8q7Z9st2GRYIYTzrlwbspZLOTnOfWTYlllILPaO4FmogqYUeomWoQ09AkbvZk8mADRXHwwNnJhBihoEq+PHrptkWZHXUyLrz5NDMD2oQ8pOYPwnsA2hSf
 qyuXn+QED2Y4X1ddE0doPTsDVG2Uj0j452F3qUv7ugnNCO/UGLb8N0QlO//X4RILvIuSJsrORfOozrqQZ2OT2HJDku56YNQPMebaPW7GOesHMpUenCWN+cHK
 b2XtSFY9/NE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On 03/12/21 10:30, Vladimir Murzin wrote:
> On 12/2/21 10:20 PM, Giulio Benetti wrote:
>> ARM_SINGLE_ARMV7M implies Arm Cortex M7 too, so let's add it to
>> description with M0/M3/M4.
> 
> Well it also implies M33 and M55. I'd suggest drop specific implementations
> from description - so we do not need to update it each time new compatible
> core is released. To account newest cores like M33 and M55 you can rephrase
> to:
> - ARMv7-M/v8-M

This ^^^ is ok for me. Also, I don't see any M0 used at the moment so no 
ARMv6-M makes sense, if any in the future we can update. I see M3,M4,M7 
for the moment, so ARMv7-M. But at the moment no ARMv8-M, or am I wrong?
Maybe it would be better to add ARMv8-M when there will really be the 
support, considering also that ARM_SINGLE_ARMV7M is a bit ambiguous to 
be used with ARMv8-M. So maybe that could be modified too when an 
ARMv8-M is added.

What do you think about this?

Best regards
-- 
Giulio Benetti
Benetti Engineering sas

> - ARMv7-M and above
> 
> Cheers
> Vladimir
> 
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
>> ---
>>   arch/arm/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index c2724d986fa0..67efbde70e34 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -329,7 +329,7 @@ config ARCH_MULTIPLATFORM
>>   	select USE_OF
>>   
>>   config ARM_SINGLE_ARMV7M
>> -	bool "ARMv7-M based platforms (Cortex-M0/M3/M4)"
>> +	bool "ARMv7-M based platforms (Cortex-M0/M3/M4/M7)"
>>   	depends on !MMU
>>   	select ARM_NVIC
>>   	select AUTO_ZRELADDR
>>
> 

