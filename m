Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E806D570E80
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiGLAC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiGLACy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:02:54 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A2B2CE09;
        Mon, 11 Jul 2022 17:02:53 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so9821984pjo.3;
        Mon, 11 Jul 2022 17:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DgmP4Gx8hcoKZA+Mx1FoQVlr8NTCtKvVvBmR+CQMW/k=;
        b=m5VheN7kXhra5ExrDEv+y+R+/2CootBRx1nhckaNvUadrLLglfB1uFMiZMNa7U4kB2
         QpWjmMuW0fzTQG2xgiwbL5Z5Vtpqz8Gga1Vu+v2Gjsdk03IRMuz874Ov+SRRNJ5itnIs
         P5UWJqpBJA62/DNgu0Bd+bBlc/tPIQ4H1U3XNR/uIFNZJOBa84owrusVkA4XXyz9okR7
         Mn47x537pR6mOvcAs9z5hBY+iCiea9T2y3q0lpG3vN77y7AMBOKVYlGkwAuX+2qPYi3H
         z5BjHmZQC8KF1obJmD73TOyj/XHqpvgymozxyHfQ5vBNrUFtl+ItxoZYU32PdG/wH9WX
         x9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DgmP4Gx8hcoKZA+Mx1FoQVlr8NTCtKvVvBmR+CQMW/k=;
        b=NpT1J8WLewMdNI3p7JQVxEXttoCL0F91vLax+HddMFe8tG19FBFjQoe0fFio7V8kxD
         VrRhrg6lJ7eglQyyodHFZVv6sKKKEnBGHbe7RxxxOruVZeTqFA3Pu/O4+XzD6jBgvIhq
         JQ5IOOXcnzzxDTZ40kcOX2enLSkYo+srcFSv+q5fA/f+ghmwFMi6HLl47JgBcffiP7D9
         VxxKBRm8mhYXZJ2py0wFDUls89CAkXKLDWpOiX7Qa/TiG9Z1koD3Jxbtf/Rcvf+3ynul
         fPpaYL978RD73rNtGIv8ImFKMNZghWGOIZaA7L2vU0vi6OvPZN4RTLljCzUxEcwe0WoG
         0/7Q==
X-Gm-Message-State: AJIora/73nyTzatknI1sE14NhsRl/APV9Phhjx5ROufQmXQLkrfcopx/
        wBgfhyJ9BpddHXxqEGoVjQ6ORHPSMMw=
X-Google-Smtp-Source: AGRyM1tiBrohUYOcCJPjjgZocgDKSlw7SmZPLGm1VAUYYkkkq5L4pZ0vjgagbApJocTqGFUKsh5OUw==
X-Received: by 2002:a17:90b:17d1:b0:1f0:6f1:90d1 with SMTP id me17-20020a17090b17d100b001f006f190d1mr971165pjb.221.1657584172826;
        Mon, 11 Jul 2022 17:02:52 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id m12-20020a63710c000000b0040d287f1378sm4771255pgc.7.2022.07.11.17.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 17:02:52 -0700 (PDT)
Message-ID: <7fb06e9c-6405-9bee-5eda-7dbd56511e2c@gmail.com>
Date:   Mon, 11 Jul 2022 17:02:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [PATCH] MIPS: Fixed __debug_virt_addr_valid()
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, gerg@kernel.org,
        open list <linux-kernel@vger.kernel.org>
References: <20220707215237.1730283-1-f.fainelli@gmail.com>
 <20220711083848.GE6084@alpha.franken.de>
 <20220711104052.ddefbgd34xbbjykg@mobilestation>
 <20220711112740.GA12918@alpha.franken.de>
 <20220711112953.j4dwany3i77df4xe@mobilestation>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220711112953.j4dwany3i77df4xe@mobilestation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/2022 4:29 AM, Serge Semin wrote:
> On Mon, Jul 11, 2022 at 01:27:40PM +0200, Thomas Bogendoerfer wrote:
>> On Mon, Jul 11, 2022 at 01:40:52PM +0300, Serge Semin wrote:
>>> On Mon, Jul 11, 2022 at 10:38:48AM +0200, Thomas Bogendoerfer wrote:
>>>> On Thu, Jul 07, 2022 at 02:52:36PM -0700, Florian Fainelli wrote:
>>>>> It is permissible for kernel code to call virt_to_phys() against virtual
>>>>> addresses that are in KSEG0 or KSEG1 and we need to be dealing with both
>>>>> types. Add a final condition that ensures that the virtual address is
>>>>> below KSEG2.
>>>>>
>>>>> Fixes: dfad83cb7193 ("MIPS: Add support for CONFIG_DEBUG_VIRTUAL")
>>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>>> ---
>>>>>   arch/mips/mm/physaddr.c | 3 ++-
>>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/mips/mm/physaddr.c b/arch/mips/mm/physaddr.c
>>>>> index a1ced5e44951..a82f8f57a652 100644
>>>>> --- a/arch/mips/mm/physaddr.c
>>>>> +++ b/arch/mips/mm/physaddr.c
>>>>> @@ -5,6 +5,7 @@
>>>>>   #include <linux/mmdebug.h>
>>>>>   #include <linux/mm.h>
>>>>>   
>>>>> +#include <asm/addrspace.h>
>>>>>   #include <asm/sections.h>
>>>>>   #include <asm/io.h>
>>>>>   #include <asm/page.h>
>>>>> @@ -30,7 +31,7 @@ static inline bool __debug_virt_addr_valid(unsigned long x)
>>>>>   	if (x == MAX_DMA_ADDRESS)
>>>>>   		return true;
>>>>>   
>>>>> -	return false;
>>>>> +	return KSEGX(x) < KSEG2;
>>>>>   }
>>>>>   
>>>>>   phys_addr_t __virt_to_phys(volatile const void *x)
>>>>> -- 
>>>>> 2.25.1
>>>>
>>>
>>>> applied to mips-next.
>>>
>>> Are you sure it was ready to be applied?
>>> Link: https://lore.kernel.org/linux-mips/20220708115851.ejsooiilxcopkoei@mobilestation/
>>
> 
>> your comment sounded like optimizing, which can be done later on, so
>> I assumed it ready.
> 
> What about Malta and EVA?

Sergey's comment definitively need to be addressed, and I would not see 
the point in making an incremental change to a wrong fix. Can you drop 
that patch for now? Thanks!
-- 
Florian
