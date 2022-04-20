Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977FA508C20
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355044AbiDTPdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbiDTPdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:33:01 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482FC101D2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:30:15 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so5269164pjn.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r4v6+4yKaA3vLKtpzxPE5V66sX8ChIPo+IWH+cRqWOU=;
        b=TvgdpDxNuQUSckfkeGjOMKYDMxRZd9S6wMyne8ZwUni7ZFidV9VX2xjZlsK+q79DAl
         S8I9jksjwKYuk0sLoY8GEae2guuwTFb+ZfwrH6TilZ68upNfq3igoagvSpZPn27UJf9n
         VhmyMqxx1uynilCxU9iMzbdUI1CX7r4ao5qRHCJwbDlEN8yGavrDTwCHTcdqZvT7dcQ2
         Gi41Zlfn2N1XIEkoiP5zy1qQvXGkBK3z7hHX3vKAxU7eZLVSv/E9RfeHwJOIFWlgWgrt
         E7Au/KLPYtkaNor5sTpEx2OB/Td64KYaLi9nW/WNDoXhaVHxbUt9CwPdg/ltWXWlUboo
         tOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r4v6+4yKaA3vLKtpzxPE5V66sX8ChIPo+IWH+cRqWOU=;
        b=D+irv5gPxo/T6sLcN5727iSzcLjH86BJ/YxWKmVc8GFEnpopmNZE7QWz+ds7ECsSfg
         cTW/PWf7TPFzrHLpSR6b4/q3rG/RAA1U+378FtSZAlK4e2gjyAc34L8GEkSdZCw172aj
         0KqFrQTeU3uiGJMT1foe0fek83KpNuyVGC950zmEvJfCYRXeuDT/pz+v2wZ44u0U3YlG
         YsM86AqnG6AZ1r/8uWkz9oka2gGK5AB7Bg4l5XrdocAbMTMPHO16hWNTgiTc/NguAkQV
         Ma/yD9KrcjDpZBMM5VGpTxskRpARIHhUZbcM7cdHIQ+q4BRX6h3u+nnEKP09zK7Lb0LA
         UXbg==
X-Gm-Message-State: AOAM530/BCxD/zHbAqxhdt5vgUc9lpOXRwedDRRNil0kVfLv88m7eW3m
        jktImvvhrM0jp9w4m8bpZHcwDQ==
X-Google-Smtp-Source: ABdhPJz5IBNSApxKctprIxswAH01MWDFRUuF4fgrvBFEa0Xwjf3+NXxDW42WuMLbb3XH+gRkgeSpQw==
X-Received: by 2002:a17:902:b70c:b0:156:16f0:cbfe with SMTP id d12-20020a170902b70c00b0015616f0cbfemr20911392pls.152.1650468614694;
        Wed, 20 Apr 2022 08:30:14 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e66:6380:7568:1633:647:d3a2? ([2409:8a28:e66:6380:7568:1633:647:d3a2])
        by smtp.gmail.com with ESMTPSA id t17-20020a17090a449100b001d2f09e64b4sm155519pjg.24.2022.04.20.08.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 08:30:14 -0700 (PDT)
Message-ID: <5cf976c4-c555-c546-e82c-7482b50fa14a@bytedance.com>
Date:   Wed, 20 Apr 2022 23:30:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [External] Re: [PATCH v4 1/2] ftrace: cleanup ftrace_graph_caller
 enable and disable
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>, rostedt@goodmis.org
Cc:     mingo@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, broonie@kernel.org, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
References: <20220409153554.14470-1-zhouchengming@bytedance.com>
 <Yl6f0XKoRxNhgGPv@FVFF77S0Q05N>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Yl6f0XKoRxNhgGPv@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/4/19 19:41, Mark Rutland wrote:
> On Sat, Apr 09, 2022 at 11:35:53PM +0800, Chengming Zhou wrote:
>> The ftrace_[enable,disable]_ftrace_graph_caller() are used to do
>> special hooks for graph tracer, which are not needed on some ARCHs
>> that use graph_ops:func function to install return_hooker.
>>
>> So introduce the weak version in ftrace core code to cleanup
>> in x86.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>> v4:
>>  - put weak ftrace_enable,disable_ftrace_graph_caller() in
>>    fgraph.c instead of ftrace.c as suggested by Steve.
>>
>> v3:
>>  - consolidate two #if into a single #if, suggested by Steve. Thanks.
>> ---
>>  arch/x86/kernel/ftrace.c | 17 ++---------------
>>  kernel/trace/fgraph.c    | 18 ++++++++++++++++++
>>  2 files changed, 20 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
>> index 1e31c7d21597..b09d73c2ba89 100644
>> --- a/arch/x86/kernel/ftrace.c
>> +++ b/arch/x86/kernel/ftrace.c
>> @@ -579,9 +579,7 @@ void arch_ftrace_trampoline_free(struct ftrace_ops *ops)
>>  
>>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>>  
>> -#ifdef CONFIG_DYNAMIC_FTRACE
>> -
>> -#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
>> +#if defined(CONFIG_DYNAMIC_FTRACE) && !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS)
>>  extern void ftrace_graph_call(void);
>>  static const char *ftrace_jmp_replace(unsigned long ip, unsigned long addr)
>>  {
>> @@ -610,18 +608,7 @@ int ftrace_disable_ftrace_graph_caller(void)
>>  
>>  	return ftrace_mod_jmp(ip, &ftrace_stub);
>>  }
>> -#else /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
>> -int ftrace_enable_ftrace_graph_caller(void)
>> -{
>> -	return 0;
>> -}
>> -
>> -int ftrace_disable_ftrace_graph_caller(void)
>> -{
>> -	return 0;
>> -}
>> -#endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
>> -#endif /* !CONFIG_DYNAMIC_FTRACE */
>> +#endif /* CONFIG_DYNAMIC_FTRACE && !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
>>  
>>  /*
>>   * Hook the return address and push it in the stack of return addrs
>> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
>> index 8f4fb328133a..289311680c29 100644
>> --- a/kernel/trace/fgraph.c
>> +++ b/kernel/trace/fgraph.c
>> @@ -30,6 +30,24 @@ int ftrace_graph_active;
>>  /* Both enabled by default (can be cleared by function_graph tracer flags */
>>  static bool fgraph_sleep_time = true;
>>  
>> +/*
>> + * archs can override this function if they must do something
>> + * to enable hook for graph tracer.
>> + */
>> +int __weak ftrace_enable_ftrace_graph_caller(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +/*
>> + * archs can override this function if they must do something
>> + * to disable hook for graph tracer.
>> + */
>> +int __weak ftrace_disable_ftrace_graph_caller(void)
>> +{
>> +	return 0;
>> +}
> 
> IIUC an arch should either:
> 
> * Have ftrace_graph_call()
> 
> * Have both ftrace_enable_ftrace_graph_caller() and
>   ftrace_disable_ftrace_graph_caller()
> 
> ... and I can't think of a reason an arch would need both ftrace_graph_call()
> *and* the enable/disable functions.

This way is more precise, but we have to add "#define ftrace_graph_call ftrace_graph_call"
in all ARCH's asm/ftrace.h correctly.

Previously we only need to define override ftrace_[enable,disable]_ftrace_graph_caller()
in ARCH's ftrace.c, looks like a little more complexity?

> 
> Given that, could we drop the `__weak` and place these within ifdeffery, i.e.
> make the above:
> 
> | #ifndef ftrace_graph_call
> | int ftrace_enable_ftrace_graph_caller(void) { return 0; }
> | int ftrace_disable_ftrace_graph_caller(void) { return 0; }
> | #endif /* ftrace_graph_call *. 
> 
> That way we'd catch cases when:
> 
> * An architecture meant to provide one of these functions, but forgot (e.g. the
>   name got typo'd)
> 
> * An architecture provides an unnecessary implementation of either of these
>   functions.

I tried this way today, and it works too. I'm ok with both way. Maybe I should
send v5 with this patch unchanged first. Looking forward to Steve's opinion.

Thanks.

> 
> Regardless, this looks ok to me. Steve, are you happy with this? I suspect we'd
> need to take this via the arm64 tree with the next patch, so we'd need your Ack.
> 
> Thanks,
> Mark.
> 
>> +
>>  /**
>>   * ftrace_graph_stop - set to permanently disable function graph tracing
>>   *
>> -- 
>> 2.35.1
>>
