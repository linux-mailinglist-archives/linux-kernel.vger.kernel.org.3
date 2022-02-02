Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ED94A7B88
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348031AbiBBXMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbiBBXMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:12:07 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88720C061714;
        Wed,  2 Feb 2022 15:12:07 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id j38-20020a9d1926000000b0059fa6de6c71so921414ota.10;
        Wed, 02 Feb 2022 15:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=t29/K+CRAzr2C0Y4zdBwQdSLvuEbGx2x0Uo7Ij6d/QU=;
        b=Yhr00QwTQbAUMNWJsy/noa8zs8PvkvEhkcRKUwFOldhEFckHStjC8Umi/SL/UO7KhW
         DapLyXfwOmf/TDHkE1Epqcwubwq446noAyYkpHoYuezANTYykUjGCI/LVwkQWz9NHi9e
         MhDf5gtyXZQIzVfmGvBabmOyQKVz2390HcKVBnwIfrhjhAVppCUj9YxrHUBwITJ9SuKp
         m/WGbSM+2hvciWYwltw+n9lkuXZsV7gVlxn67w5GxWh68cGI+zEYvfUKoFSE39i45nOs
         OY7WWIyVmssrr1jHC1aiZGAcmp8BRBkHr+7PFOy2AVDEYQbYq48EfBj+mYZ2Klf1Ix3H
         pSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=t29/K+CRAzr2C0Y4zdBwQdSLvuEbGx2x0Uo7Ij6d/QU=;
        b=OoMSeMc/GZcgbyfxfel6FayJW2GhiejdZfJZSmv/q0W+9gNcIPGyaSdXU0fkrdkmdQ
         i5TuaIkENU5EtecpGRxoFFjOi0Y8cZxTCJ0gHbhtyHOXU7Twk/3Ek1xMktmTtVQnAveo
         0N3nqrVPf2nW/HVxZksL0yM6mul2ncNzK0+tNghMw0ESBc5J5ZIFwgcd/gIbmVTVn1Gg
         6eoF6MoMwzzc9dgkSMM3GhIIidoxMhznE3m/p2m8gUwQsFk3MCHDpcG4Zz9I/V9TUZTe
         XvyNMccHbYtZzxiJr+zRJmir67coE50KqnX4vdbiXrSflxH6icuq/nsbCuroBp8THdmB
         cEgg==
X-Gm-Message-State: AOAM530tc1MlPPbKkHcnWj+9fIUI4juwsaO0wSKPRowya8xtHRyVzM78
        Fco/QhnO+s9HcH9zZqIcc/TciYVnKjuScw==
X-Google-Smtp-Source: ABdhPJzqeLBvSKmuB4xo8RTR/vfquflC7QfdejlXnWv02QOSZcxpWYEKEU1AN1+LL/9H1JXiGpPRTA==
X-Received: by 2002:a9d:62da:: with SMTP id z26mr17266586otk.26.1643843526905;
        Wed, 02 Feb 2022 15:12:06 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e92sm8413598ote.72.2022.02.02.15.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 15:12:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5ff18cff-6cfd-1f85-da74-1e5660a1a250@roeck-us.net>
Date:   Wed, 2 Feb 2022 15:12:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
References: <20220130183653.491292-1-keescook@chromium.org>
 <20220202160149.GA2322037@roeck-us.net> <202202021237.487D3DE73@keescook>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] lib/test_string.c: Add test for strlen()
In-Reply-To: <202202021237.487D3DE73@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 12:52, Kees Cook wrote:
> On Wed, Feb 02, 2022 at 08:01:49AM -0800, Guenter Roeck wrote:
>> On Sun, Jan 30, 2022 at 10:36:53AM -0800, Kees Cook wrote:
>>> Add a simple test for strlen() functionality, including using it as a
>>> constant expression.
>>>
>>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Cc: Peter Rosin <peda@axentia.se>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>> I'll be taking this as part of my Clang FORTIFY_SOURCE series.
>>> ---
>>>   lib/test_string.c | 37 +++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 37 insertions(+)
>>>
>>> diff --git a/lib/test_string.c b/lib/test_string.c
>>> index 9dfd6f52de92..59994f552c48 100644
>>> --- a/lib/test_string.c
>>> +++ b/lib/test_string.c
>>> @@ -179,6 +179,38 @@ static __init int strnchr_selftest(void)
>>>   	return 0;
>>>   }
>>>   
>>> +/*
>>> + * Unlike many other string functions, strlen() can be used in
>>> + * static initializers when string lengths are known at compile
>>> + * time. (i.e. Under these conditions, strlen() is a constant
>>> + * expression.) Make sure it can be used this way.
>>> + */
>>> +static const int strlen_ce = strlen("tada, a constant expression");
>>> +
>>
>> This results in:
>>
>> lib/test_string.c:188:30: error: initializer element is not constant
>>    188 | static const int strlen_ce = strlen("tada, a constant expression");
>>
>> for several of my tests. I don't think you can mandate that a compiler
>> implements this.
> 
> Which tests?
> 

Some examples:

Build reference: next-20220202
Compiler version: m68k-linux-gcc (GCC) 11.2.0

Building m68k:defconfig ... failed
--------------
Error log:
lib/test_string.c:188:30: error: initializer element is not constant
   188 | static const int strlen_ce = strlen("tada, a constant expression");

Building mips:malta_defconfig:nocd:smp:net,e1000:initrd ... failed
------------
Error log:
lib/test_string.c:188:30: error: initializer element is not constant
  static const int strlen_ce = strlen("tada, a constant expression");

Building i386:q35:Broadwell:defconfig:smp:ata:net,rtl8139:hd ... failed
------------
Error log:
lib/test_string.c:188:30: error: initializer element is not constant
   188 | static const int strlen_ce = strlen("tada, a constant expression");

i386 and is defconfig + CONFIG_STRING_SELFTEST=y; mips is
malta_defconfig + CONFIG_STRING_SELFTEST=y. All use gcc 11.2.

There may be more, but there are so many failures in -next right now
that I may be missing some.

> This property of strlen() is already required by our builds (this is how
> I tripped over it). For example:
> 
> drivers/firmware/xilinx/zynqmp-debug.c:
> 
> #define PM_API(id)               {id, #id, strlen(#id)}
> static struct pm_api_info pm_api_list[] = {
>          PM_API(PM_GET_API_VERSION),
>          PM_API(PM_QUERY_DATA),
> };

I do not think that it is a C standard that strlen() on a constant string
must be compile-time evaluated and result in a constant.

Anyway, key difference, I think, is the presence of an architecture-specific
version of strlen(), or the maybe non-presence of __HAVE_ARCH_STRLEN,
or the definition of strlen() in include/linux/fortify-string.h.

Guenter
