Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5F45720D1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbiGLQ2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbiGLQ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:28:08 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92C3CB458;
        Tue, 12 Jul 2022 09:28:05 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p9so8171567pjd.3;
        Tue, 12 Jul 2022 09:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=crFxvZBUeNdiMcKsNl1tCyBaKxqrHCwq98wDUXGAXHQ=;
        b=n/Lu8ESbMmF1p4SAf0ZpXbdAg5QeJld8BqIuFkEveqkWvIBhbSjGtpUToCacuWMSJO
         ir+p19zBiY1LCaqkTHPlINgm41iDtIkPYXekdhf7d4iLGZNv/spNiz0teQ9NaXwDoO1/
         ib09iREDJScvy0z0kNzcrVC4AE+8ofhWAsRtyIGyLXLKWDjRagEqrYhan0JHrkOYmrx1
         a9G2fpapPeHbafDFrIBSfU6JRysxr09uXay07dVqUBIBwSCe4rYCOIoSbKabxntm/JyY
         k1w86Aww4TIUscOrUfuZEa6JUQUtwHYBqYdKOj+K+FafGE4D33nHrI4rJBeLedHXc5AE
         9SZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=crFxvZBUeNdiMcKsNl1tCyBaKxqrHCwq98wDUXGAXHQ=;
        b=VaEav7M1+yulL/jG6fCDYHFqONUT5dfPl0P2SWNWIdLbZbcJRi+NFqFj+jUwstpq7h
         KzfTqQl4d1ri4bGSM6GR8yBeix0KY+wbuzzKqEmbNNz1ngLixiBzitObSwdBq0J6lQg0
         aTJdSSE3bzRlavoBXG49H6zgsu4iUUGPmb98omA1WN/t9lrlSHC7eNCZ35X6vKhWE9fZ
         VCbi1dykagRjWPA/wTK6j9sLwqrfbcdrsjgq1AXg2lNXdXgSyynapftSdEaMV2l3XwsT
         vi06jBGz45EhgvBeIQ7p6EAfRsw9LK4B+hsoMaqWS3Tsnh+MBi0KMbv9/bJ0vHJORCeU
         H3iA==
X-Gm-Message-State: AJIora9iQb/TBC3+2CMtEqGJSmAnmixeGz1qlBfwAH4s72W1uqRfhibV
        gNGPUEjGm4deXYa1PmBzn5BlPwj6Vlc=
X-Google-Smtp-Source: AGRyM1v1RP/gA8qxjpoMj4J4scGE56YoViiod55ezbdPizAI1jMFBuUbLNAIMwGUECe/3U98NU0kMQ==
X-Received: by 2002:a17:902:7e8f:b0:16c:eb4:a52a with SMTP id z15-20020a1709027e8f00b0016c0eb4a52amr24837698pla.19.1657643285396;
        Tue, 12 Jul 2022 09:28:05 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d21-20020a63fd15000000b0040ca587fe0fsm6289487pgh.63.2022.07.12.09.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 09:28:04 -0700 (PDT)
Message-ID: <a6d8fc0f-38bd-6afe-ef45-42ce3ee6c136@gmail.com>
Date:   Tue, 12 Jul 2022 09:28:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] MIPS: Fixed __debug_virt_addr_valid()
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     linux-mips@vger.kernel.org, gerg@kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        open list <linux-kernel@vger.kernel.org>
References: <20220707215237.1730283-1-f.fainelli@gmail.com>
 <20220708115851.ejsooiilxcopkoei@mobilestation>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220708115851.ejsooiilxcopkoei@mobilestation>
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

On 7/8/22 04:58, Serge Semin wrote:
> On Thu, Jul 07, 2022 at 02:52:36PM -0700, Florian Fainelli wrote:
>> It is permissible for kernel code to call virt_to_phys() against virtual
>> addresses that are in KSEG0 or KSEG1 and we need to be dealing with both
>> types. Add a final condition that ensures that the virtual address is
>> below KSEG2.
>>
>> Fixes: dfad83cb7193 ("MIPS: Add support for CONFIG_DEBUG_VIRTUAL")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>   arch/mips/mm/physaddr.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/mm/physaddr.c b/arch/mips/mm/physaddr.c
>> index a1ced5e44951..a82f8f57a652 100644
>> --- a/arch/mips/mm/physaddr.c
>> +++ b/arch/mips/mm/physaddr.c
>> @@ -5,6 +5,7 @@
>>   #include <linux/mmdebug.h>
>>   #include <linux/mm.h>
>>   
>> +#include <asm/addrspace.h>
>>   #include <asm/sections.h>
>>   #include <asm/io.h>
>>   #include <asm/page.h>
>> @@ -30,7 +31,7 @@ static inline bool __debug_virt_addr_valid(unsigned long x)
>>   	if (x == MAX_DMA_ADDRESS)
>>   		return true;
>>   
> 
>> -	return false;
>> +	return KSEGX(x) < KSEG2;
> 
> With this do we really need the high_memory-based conditionals in this
> method?
> 
> If the line above is the only way to take the uncached segment into
> account then can we reduce the whole method to:
> static inline bool __debug_virt_addr_valid {
> 	return x >= PAGE_OFFSET && KSEGX(x) < KSEG2;
> }
> ?
> 
> Though this still may be invalid for EVA systems, like malta (see
> arch/mips/include/asm/mach-malta/spaces.h).
> 
> Note AFAICS if EVA is enabled, highmem is implied to be disabled (see
> the CPU_MIPS32_3_5_EVA config utilization and HIGHMEM config
> dependencies). Thus all the memory is supposed to be linearly mapped
> in that case.

OK, so if all of the memory is linearly mapped, then I am not too sure 
what we will be able to check, which is in essence pretty similar to 
what happens on MIPS64, right?

Maybe DEBUG_VIRTUAL should depend on !EVA as well?
-- 
Florian
