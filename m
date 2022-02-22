Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3620E4BFF2A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbiBVQsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiBVQs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:48:29 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E276D15F098;
        Tue, 22 Feb 2022 08:48:03 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id f21so234329qke.13;
        Tue, 22 Feb 2022 08:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=mZ8x83D1ocyoxkrCmMkUwrxYfXaMj8C9FsUlcWBy2W8=;
        b=VDVC9sxUBcYZLqrMdBjJLsWdP5JxxBKTCgV6zo5U9lbkjS3fo+s/7EYrU63QrK2LB0
         EOCk5+hQOp7N5Be++gWSM/Sqg8SFGbev9cFLJYsnwwnqSIJdq4ESj8hRvNberhoB6Uls
         tsW0xjIa2zmNiOkABbmu9NFwAduE4AaD2HC0+ZAhsyFAjxYp7aLqqg/uEpZViwKh9feL
         3hlFBD5rqVQjTnmF1ob0UXuIrRUSDPSYiRfeM7cUqKHDP/D6YpWMvyzhN7wnSC91UFT0
         O9etpLEb9Yc/SjiRAGkMrObxtcECqwmsnt2T4IUhlyEPQ2sNv9Ejgis8pSd9h+GzxGOf
         cyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=mZ8x83D1ocyoxkrCmMkUwrxYfXaMj8C9FsUlcWBy2W8=;
        b=U4OYv1DxQVmBWLQ1xC3SlvIfOEs8HETAUqZEEJxxUpmJ9OPJReWhJW0CWt1aHmFdNV
         QoSQxVp8zFtJiiCgngMNrYjR2FOy3pLGD0pPYOPonzDiJ0/SyWIgQFBVkb6HexcQsgoi
         OKZMoSlLaF9Af0qdGkQ4JynCKJoQL+RzGi/My3DzDOvT7e62adJe6wJuuQm5i5rD47pQ
         zaFPIlnb9bPMkBLSA0/QyvxdMYgzpPrw9eZmEvybK4UYRdaF9FmemNMpi27ISp+J9sWG
         IQ58PfLbpWcSTVSyfIH6S6NnV9+7dvmgIHTHz59AoK1h9ablZ70ELQTw+pcLuqXXd3eW
         fAsA==
X-Gm-Message-State: AOAM531rRyqEclb11u0acqfPwBiUct9+Jk0YQzXgOrBvW3RT/F9TklXG
        P6HuVvcFvdZrVuM9brSY86g=
X-Google-Smtp-Source: ABdhPJwBDpx8mQ/XnFPNT7k7Xor/w5dNTKJ5YOZEM2E1r+eFuO+ybc1z/qAY9awgntPcyr5RUTHoyg==
X-Received: by 2002:a37:750:0:b0:62c:ecdd:8087 with SMTP id 77-20020a370750000000b0062cecdd8087mr12125245qkh.208.1645548482579;
        Tue, 22 Feb 2022 08:48:02 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y15sm91048qkp.22.2022.02.22.08.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 08:48:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f44612ce-5bb1-da45-d6cb-39464898c4ff@roeck-us.net>
Date:   Tue, 22 Feb 2022 08:47:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Dan Li <ashimida@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, masahiroy@kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, mark.rutland@arm.com,
        samitolvanen@google.com, npiggin@gmail.com, mhiramat@kernel.org,
        ojeda@kernel.org, luc.vanoostenryck@gmail.com, elver@google.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20220222095736.24898-1-ashimida@linux.alibaba.com>
 <YhUMRoLDan7tJRiL@dev-arch.archlinux-ax161>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] [PATCH] AARCH64: Add gcc Shadow Call Stack support
In-Reply-To: <YhUMRoLDan7tJRiL@dev-arch.archlinux-ax161>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/22 08:16, Nathan Chancellor wrote:
> On Tue, Feb 22, 2022 at 01:57:36AM -0800, Dan Li wrote:
>> Shadow call stack is available in GCC > 11.2.0, this patch makes

The above suggests that the option will be available with gcc 11.3.0.
Information available in public suggests that it will be introduced
with gcc 12.0.

>> the corresponding kernel configuration available when compiling
>> the kernel with gcc.
>>
>> Note that the implementation in GCC is slightly different from Clang.
>> With SCS enabled, functions will only pop x30 once in the epilogue,
>> like:
>>
>>     str     x30, [x18], #8
>>     stp     x29, x30, [sp, #-16]!
>>     ......
>> -  ldp     x29, x30, [sp], #16	  //clang
>> +  ldr     x29, [sp], #16	  //GCC
>>     ldr     x30, [x18, #-8]!
>>
>> Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=ce09ab17ddd21f73ff2caf6eec3b0ee9b0e1a11e
>>
>> Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
> A few open-ended comments below.
> 
>> ---
>> FYI:
>> This function can be used to test if the shadow call stack works:
>> //noinline void __noscs scs_test(void)
>> noinline void scs_test(void)
>> {
>>      register unsigned long *sp asm("sp");
>>      unsigned long * lr = sp + 1;
>>
>>      asm volatile("":::"x30");
>>      *lr = 0;
>> }
>>
>> ffff800008012704:       d503233f        paciasp
>> ffff800008012708:       f800865e        str     x30, [x18], #8
>> ffff80000801270c:       a9bf7bfd        stp     x29, x30, [sp, #-16]!
>> ffff800008012710:       910003fd        mov     x29, sp
>> ffff800008012714:       910003e0        mov     x0, sp
>> ffff800008012718:       f900041f        str     xzr, [x0, #8]
>> ffff80000801271c:       f85f8e5e        ldr     x30, [x18, #-8]!
>> ffff800008012720:       f84107fd        ldr     x29, [sp], #16
>> ffff800008012724:       d50323bf        autiasp
>> ffff800008012728:       d65f03c0        ret
>>
>> If SCS protection is enabled, this function will return normally.
>> If the function has __noscs attribute (scs disabled), it will crash due to 0
>> address access.
>>
>>   arch/Kconfig                 | 6 +++---
>>   arch/arm64/Kconfig           | 2 +-
>>   include/linux/compiler-gcc.h | 4 ++++
>>   3 files changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 678a80713b21..35db7b72bdb0 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -604,11 +604,11 @@ config ARCH_SUPPORTS_SHADOW_CALL_STACK
>>   	  switching.
>>   
>>   config SHADOW_CALL_STACK
>> -	bool "Clang Shadow Call Stack"
>> -	depends on CC_IS_CLANG && ARCH_SUPPORTS_SHADOW_CALL_STACK
>> +	bool "Shadow Call Stack"
>> +	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
>>   	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
>>   	help
>> -	  This option enables Clang's Shadow Call Stack, which uses a
>> +	  This option enables Clang/GCC's Shadow Call Stack, which uses a
> 
> I wonder if we want to just ditch the mention of the compiler if both
> support it?
> 
>>   	  shadow stack to protect function return addresses from being
>>   	  overwritten by an attacker. More information can be found in
>>   	  Clang's documentation:
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 09b885cc4db5..a48a604301aa 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1255,7 +1255,7 @@ config HW_PERF_EVENTS
>>   config ARCH_HAS_FILTER_PGPROT
>>   	def_bool y
>>   
>> -# Supported by clang >= 7.0
>> +# Supported by clang >= 7.0 or GCC > 11.2.0
> 
> Same thing here, although eventually there may be a minimum GCC version

The point here, I think, is to list the minimum gcc version.
It is going to be a long time until gcc 12.0 is the minimum version,
so I think it makes sense to list the minimum version number for
each compiler here.

However, it may make sense to add some reference indicating that
support will indeed be added with gcc 11.3.0, and not only starting
with gcc 12.0 (and maybe wait with applying this patch until it is
actually available in gcc and can be confirmed to work as intended).

Thanks,
Guenter

> bump to something newer than 11.2.0, which would allow us to just drop
> CONFIG_CC_HAVE_SHADOW_CALL_STACK altogether. No strong opinion.
> 
>>   config CC_HAVE_SHADOW_CALL_STACK
>>   	def_bool $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18)
>>   
>> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
>> index ccbbd31b3aae..deff5b308470 100644
>> --- a/include/linux/compiler-gcc.h
>> +++ b/include/linux/compiler-gcc.h
>> @@ -97,6 +97,10 @@
>>   #define KASAN_ABI_VERSION 4
>>   #endif
>>   
>> +#ifdef CONFIG_SHADOW_CALL_STACK
>> +#define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
>> +#endif
>> +
>>   #if __has_attribute(__no_sanitize_address__)
>>   #define __no_sanitize_address __attribute__((no_sanitize_address))
>>   #else
>> -- 
>> 2.17.1
>>

