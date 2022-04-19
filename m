Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745D8506D70
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243706AbiDSNaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243760AbiDSNaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:30:24 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4675F21E1C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:27:41 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id bg9so23692115pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hmfCGb1e35kGyAO9TTpJmeKiniE5eHPR94eC8Q4R0t8=;
        b=BgFB2ZJ7DHRVPR8JTVW/uTen4sTOWqac81bQTgegepdZk6pWiG0CWwfFVUUbLmte0e
         qGcPw7F1I9gY6oUd7gx92/WthgQQqnArl7oOWNxtTve24qJ1SQsoP1yBoHZsaTH9Uru/
         fOV3ehNHe884olw9V7xWrzw1T+mgxoW2oTEtNivFmKqw2NddI/DqHi9xuoY2Ltr4Z6Qn
         Vwf7+FCAxOMFJPhlX6ZriGo55drUq6/7i6P+hGJUbXS7ygVYeMnfRKMMMfSXxlXpl1cO
         n5XsiGyBKXh202W3QrtEtHTJxdBxBTajx8qAkLl5RpT7kt7z7nN9FSJr9I8jhmsYt3B+
         unFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hmfCGb1e35kGyAO9TTpJmeKiniE5eHPR94eC8Q4R0t8=;
        b=ywoyQKbM/IBTDZGl1zmo/mQGGJsgCsUj5X7e6MoYc1LwJRRSN8JNz7l7i71xlTgBEe
         vrV1ErOaK4i8GcMseDCKJI0H5mxBSZnBfIjs24gNuV8eo0Cp+vElm1ot6pUCSQH9tIKo
         O6aaKEojCh7MSXmgFJPA9/CJGlbnHvN9jU7f/coakZbIL3zREdmhgvCwHjIHItzxrlqq
         Maw3CR7xVf34oS0vt3SqQG5Ve88LqZGdrUda4XMi9prntXc15BN+s+0COOYvqFVgyPAV
         LB7FWLAc6Y9jUSnpXmQB0KsLTUxdlIbEpvbbuI/VZl5LiaJ1r2sfKGsOTXhBm/KfWIRe
         7B+A==
X-Gm-Message-State: AOAM531TJU00NXr3FqXBu6fdfiqkPfkGH7A+P3iFVstkvXDIwHlOVOLV
        i3/g9XUWcx5iLIVg29yDZgug0Q==
X-Google-Smtp-Source: ABdhPJzqt9nSGlK6uza94hJJqXcPcpuyKOhUUDyQznA3m247CpyaMMaYIoziUJNDIhmPMBGGrOSZJw==
X-Received: by 2002:a63:4a02:0:b0:39d:b8ac:59a4 with SMTP id x2-20020a634a02000000b0039db8ac59a4mr14716717pga.464.1650374860696;
        Tue, 19 Apr 2022 06:27:40 -0700 (PDT)
Received: from [10.254.139.185] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id b12-20020a17090aa58c00b001ca977b49d5sm16392752pjq.31.2022.04.19.06.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 06:27:40 -0700 (PDT)
Message-ID: <94325f65-109f-1b81-6139-45594a9c2ab2@bytedance.com>
Date:   Tue, 19 Apr 2022 21:27:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [External] Re: [PATCH v4 2/2] arm64/ftrace: Make function graph
 use ftrace directly
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        broonie@kernel.org, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
References: <20220409153554.14470-1-zhouchengming@bytedance.com>
 <20220409153554.14470-2-zhouchengming@bytedance.com>
 <Yl6xN2qf7k5YeEdl@FVFF77S0Q05N>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Yl6xN2qf7k5YeEdl@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/19 20:55, Mark Rutland wrote:
> On Sat, Apr 09, 2022 at 11:35:54PM +0800, Chengming Zhou wrote:
>> As we do in commit 0c0593b45c9b ("x86/ftrace: Make function graph
>> use ftrace directly"), we don't need special hook for graph tracer,
>> but instead we use graph_ops:func function to install return_hooker.
>>
>> Since commit 3b23e4991fb6 ("arm64: implement ftrace with regs") add
>> implementation for FTRACE_WITH_REGS on arm64, we can easily adopt
>> the same cleanup on arm64.
>>
>> And this cleanup only changes the FTRACE_WITH_REGS implementation,
>> so the mcount-based implementation is unaffected.
> 
> Could you please say *why* we only do this for FTRACE_WITH_REGS? IIUC that's
> possible, but would require more invasive refactoring of the core code; have I
> understood correctly?

Yes, I think so. The static mcount-based implementation should also be changed
in this way, but I haven't look too deep into that asm implementation yet.

> 
> If so, could we please make this:
> 
> | While in theory it would be possible to make a similar cleanup for
> | !FTRACE_WITH_REGS, this will require rework of the core code, and so for now
> | we only change the FTRACE_WITH_REGS implementation.
> 
> It'd be quite nice if we could clean up the !FTRACE_WITH_REGS case similarly,
> but as it appeass that would require far more invasive changes, I'm happy to
> leave that for future work.

Ok, will add it in the commit message. And leave this for future work.

> 
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>> v3:
>>  - Add comments in ftrace_graph_func() as suggested by Steve. Thanks.
>>
>> v2:
>>  - Remove FTRACE_WITH_REGS ftrace_graph_caller asm, thanks Mark.
>> ---
>>  arch/arm64/include/asm/ftrace.h  |  7 +++++++
>>  arch/arm64/kernel/entry-ftrace.S | 17 -----------------
>>  arch/arm64/kernel/ftrace.c       | 17 +++++++++++++++++
>>  3 files changed, 24 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
>> index 1494cfa8639b..dbc45a4157fa 100644
>> --- a/arch/arm64/include/asm/ftrace.h
>> +++ b/arch/arm64/include/asm/ftrace.h
>> @@ -80,8 +80,15 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>>  
>>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>>  struct dyn_ftrace;
>> +struct ftrace_ops;
>> +struct ftrace_regs;
>> +
>>  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
>>  #define ftrace_init_nop ftrace_init_nop
>> +
>> +void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>> +		       struct ftrace_ops *op, struct ftrace_regs *fregs);
>> +#define ftrace_graph_func ftrace_graph_func
>>  #endif
>>  
>>  #define ftrace_return_address(n) return_address(n)
>> diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
>> index e535480a4069..d42a205ef625 100644
>> --- a/arch/arm64/kernel/entry-ftrace.S
>> +++ b/arch/arm64/kernel/entry-ftrace.S
>> @@ -97,12 +97,6 @@ SYM_CODE_START(ftrace_common)
>>  SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
>>  	bl	ftrace_stub
>>  
>> -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>> -SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL) // ftrace_graph_caller();
>> -	nop				// If enabled, this will be replaced
>> -					// "b ftrace_graph_caller"
>> -#endif
>> -
>>  /*
>>   * At the callsite x0-x8 and x19-x30 were live. Any C code will have preserved
>>   * x19-x29 per the AAPCS, and we created frame records upon entry, so we need
>> @@ -127,17 +121,6 @@ ftrace_common_return:
>>  	ret	x9
>>  SYM_CODE_END(ftrace_common)
>>  
>> -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>> -SYM_CODE_START(ftrace_graph_caller)
>> -	ldr	x0, [sp, #S_PC]
>> -	sub	x0, x0, #AARCH64_INSN_SIZE	// ip (callsite's BL insn)
>> -	add	x1, sp, #S_LR			// parent_ip (callsite's LR)
>> -	ldr	x2, [sp, #PT_REGS_SIZE]	   	// parent fp (callsite's FP)
>> -	bl	prepare_ftrace_return
>> -	b	ftrace_common_return
>> -SYM_CODE_END(ftrace_graph_caller)
>> -#endif
>> -
>>  #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>>  
>>  /*
>> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
>> index 4506c4a90ac1..35eb7c9b5e53 100644
>> --- a/arch/arm64/kernel/ftrace.c
>> +++ b/arch/arm64/kernel/ftrace.c
>> @@ -268,6 +268,22 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
>>  }
>>  
>>  #ifdef CONFIG_DYNAMIC_FTRACE
>> +
>> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>> +void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>> +		       struct ftrace_ops *op, struct ftrace_regs *fregs)
>> +{
>> +	/*
>> +	 * Athough graph_ops doesn't have FTRACE_OPS_FL_SAVE_REGS set in flags,
>> +	 * regs can't be NULL in DYNAMIC_FTRACE_WITH_REGS. By design, it should
>> +	 * be fixed when DYNAMIC_FTRACE_WITH_ARGS is implemented.
>> +	 */
> 
> This is a bit confusing, since it makes it sound like there's an bug in the
> current implementation, rather than something that would need to change if
> support for DYNAMIC_FTRACE_WITH_ARGS is added.
> 
> Could we please make this:
> 
> 	/*
> 	 * When DYNAMIC_FTRACE_WITH_REGS is selected, `fregs` can never be NULL
> 	 * and arch_ftrace_get_regs(fregs) will always give a non-NULL pt_regs
> 	 * in which we can safely modify the LR.
> 	 */
> 

Ok, will do. This expression is nicer, the previous comment maybe make people
think it's an bug to be fixed.

> Other than that, this looks good to me. I gave it a spin under QEMU atop
> v5.18-rc3. The CONFIG_FTRACE_STARTUP_TEST tests all pass, and I played with the
> graph tracer with:
> 
> | # echo do_el0_svc > /sys/kernel/tracing/set_graph_function 
> | # echo function_graph > /sys/kernel/tracing/current_tracer
> 
> ... for which the resutls looks sane.
> 
> To make sure this didn't adversely affect the return address rewriting, I also
> concurrently ran perf with:
> 
> | # perf record -g -e raw_syscalls:sys_enter:k /bin/true
> | # perf report
> 
> ... for which the results also looked fine.
> 
> I also tested the !DYNAMIC_FTRACE_WITH_REGS modes by building with an older
> compiler and also building with !DYNAMIC_FTRACE, which all looked good.
> 
> So FWIW:
> 
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> 
> ... and if you make the changes I requested above:
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> 
> If you could spin a v5 with that folded in, that would be great.

Of course, will do in v5.

Thanks.

> 
> Thanks,
> Mark.
