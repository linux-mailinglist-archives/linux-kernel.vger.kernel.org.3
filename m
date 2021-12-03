Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18678467C2D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 18:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343634AbhLCRHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 12:07:01 -0500
Received: from smtpcmd02102.aruba.it ([62.149.158.102]:50081 "EHLO
        smtpcmd02102.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239612AbhLCRHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:07:00 -0500
Received: from [192.168.50.18] ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id tByBmvhSXhA9ytByBmbeeo; Fri, 03 Dec 2021 18:03:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638551015; bh=ZVqunKlhbpVtNIi/cymjPndW03M8+Br6+h6UyINC7RU=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=DadQJ8sFyTynaRg6FKuyEY6mTUImdYyybP9VL9pz4KwqKRBul4bkHWITb8VSsnLKj
         lQOBXhtA70RGIdpJURLar32WTB6fhwzNXDtP9+oCfl5H8ydSCNpPziyV9qvlZGDKHg
         ydvEzte672DiMbSYHGstYzm9sAgMvHhGjlPGoiCAAEVYQM3AD7V9eaJ1y7KQMELSiM
         TpzMujzpfeKiItPegOoYBey0d0pAVT3GdytTebFeftLgGiaGtq/BguuUN0OeYNbxjo
         yLZYbD2CpneP+JBmGyTXo6HqzpHQ6YjSxP2GmeGACtqihQnieWq5wh7Q6psqWRtzWH
         uaEcTEYkqNUhA==
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
 <170aea55-44f3-9cf0-fd88-adf8c66efeb4@benettiengineering.com>
 <ea2679ec-9bfd-6a78-a82d-7b160350ddfb@arm.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Message-ID: <252614ac-04cc-8ac8-c226-4245088d8952@benettiengineering.com>
Date:   Fri, 3 Dec 2021 18:03:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ea2679ec-9bfd-6a78-a82d-7b160350ddfb@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAHbAiY5bBtBnJqukNGjER85FjLffIaFqMfT337Ad7odk2A8nEGRNxk5KCrvJfq9dTrpPgWONRN8BjAFvfVvPwiH+MsWaXIJJAXKu0I6AIprcjJqcEbN
 hmAPCxjMPOUZLgkl/uLUNkTPbZX/GyN8bNSYU8C49AvuoEf7ZfDwM4U5zKxSHBHDTSldo3NFA9kADwB2jtVuKBUewQl72LhKl9Q3cgxOypAoC2sPOw2cEGgl
 XFFA7Whh+wfzx3PaW7jYFmjPBWGS3ytQVUR4tJMkGlc/YCihcn5hgRnL2zqowbFWnB6q7OPuXKYliNZbAi06mv/SPsnbhCXF43vZJ+yNDvoClCq36liBaEIZ
 LYKgJMRQI/R7w+WfkUss6LvubxngMucRWmQG5kZMf9feKPKsJQ+NP3/HWB1yAB4d9R9xPPNTQpX2EeIfI0aQbXdWnr0yIkErPTieARQrZQh4gHFhL5+3lKng
 jP81d73dzYytGypwfDLsjpHHEQaBZCVmPUyFrZBvXajDH31bg50oyhg9xvFIj6aF9JkTH2oF15Z9vxkeIcU5bxlvZJeUbDloj+FVsMIQUED6oQcVOCFCsqM0
 ZKTfnsA7qd6Z1IixEotqaF4VqJqmV6PXJcE2dpST4cirbsuZfFiKDu5A6r8p90wDCeG8c2t6u85HC+TDtjx3C9ORPy5/0LAe0ziBvScGzPbap2WN0xERrp3n
 1ZaCW3S3Yzk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/21 18:01, Vladimir Murzin wrote:
> On 12/3/21 4:41 PM, Giulio Benetti wrote:
>> Hi Vladimir,
>>
>> On 03/12/21 10:30, Vladimir Murzin wrote:
>>> On 12/2/21 10:20 PM, Giulio Benetti wrote:
>>>> ARM_SINGLE_ARMV7M implies Arm Cortex M7 too, so let's add it to
>>>> description with M0/M3/M4.
>>>
>>> Well it also implies M33 and M55. I'd suggest drop specific implementations
>>> from description - so we do not need to update it each time new compatible
>>> core is released. To account newest cores like M33 and M55 you can rephrase
>>> to:
>>> - ARMv7-M/v8-M
>>
>> This ^^^ is ok for me. Also, I don't see any M0 used at the moment so no ARMv6-M makes sense, if any in the future we can update. I see M3,M4,M7 for the moment, so ARMv7-M. But at the moment no ARMv8-M, or am I wrong?
> 
> We already support PMSAv8 which is ARMv8-M, M33/M55 is in flight [1].

Ah, I've missed that. And great for M33!

>> Maybe it would be better to add ARMv8-M when there will really be the support, considering also that ARM_SINGLE_ARMV7M is a bit ambiguous to be used with ARMv8-M. So maybe that could be modified too when an ARMv8-M is added.
>>
>> What do you think about this?
> 
> Well, I prefer to touch this as rare as possible, and if we touch
> it then ensure we do not need to touch it for a long time ;)
> 
> Look at A-class cores,
> 
> config ARCH_MULTI_V7
>          bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"
> 
> it doesn't mention ARMv8, yet it is pretty much possible to run it
> on some cores either bare-metal or as a guest (just look under
> arch/arm/include/asm/cputype.h)

Ah yeah, thanks for pointing, then I'm going with ARMv7-M/v8-M

> These are just config options, not a legal deeds...

+1

Thank you
Best regards
-- 
Giulio Benetti
Benetti Engineering sas

> [1] https://lore.kernel.org/linux-arm-kernel/20211201132908.106711-1-vladimir.murzin@arm.com/T/
> 
> Cheers
> Vladimir
> 
>>
>> Best regards
> 

