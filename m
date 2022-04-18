Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C5A505A24
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 16:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241271AbiDROlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 10:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345993AbiDROjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 10:39:32 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD61426C0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 06:24:45 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t12so12324212pll.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 06:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=I3Okq40SlFfO9yXRZG5Ce7bYgQKjZc2Ftg4cYgYx4m8=;
        b=6PO6V6vFnFgC58QWshF35FjkEk9Z7u+n4zuiRR3KmuUZpt5fZEAfLbphuF1/nf7f2/
         HXwngU80rWrVWSpTH2vYWztb1pm40kGAZ17W/ncsZxlM6ATosxJNNXoPG3TEK/gngKse
         rN6ya9uF/YE13/CJVQl+n+sveLUb0w4PGL2mETeEkkCRHpAh8vWhlg904J6jZ7SVcKdK
         nTU/9M1W5zhVdV8toTXMIzv9HOYU1+6V5OUOUpYH9S8F+ba+b6TTm7hAHWIHTyeFcqnC
         FPbE40/XOnFgiFdT8VYkuuMnwPRg+GWjQBbRszbZJFtgYgoT0KK7zrSdPn3IghUTpt8L
         InGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I3Okq40SlFfO9yXRZG5Ce7bYgQKjZc2Ftg4cYgYx4m8=;
        b=CUN3ZWAeQXDGHTXWma1NWeRTUv7OqxKZPSnGfOCzfYR1Jt1awn1IYj0bX8OfPMqu82
         XKv1Jl9QM80vc1qhScC9ISym6r74y2XCKYHruOBwmEM5KNYnk4wU7Hm9+5i/nB0eLElN
         Kg0pM07Unggd2v9nTG/nr9jhVn/xAM/B+54kYRdQEGVmKxcowHzAa3uFWjl/adYLFwOo
         DPAqZekd5AnUXvSVmdt4LZmGElz8FcFURAaYsjvUmOb6nrMRsUHuMuZMvxm6yP632wgt
         YybDKHr7mxVF/KUugIyHBJDFUCdi4vETVenRtSKVoqcVkEzU9AGS+uV6nQeIz5Sd+h6i
         mqgA==
X-Gm-Message-State: AOAM53038v9Tyu/MfzNH+pm7yHN675sudAWWPux2T2Y83x6jlgq84XWq
        gsdCvnM7hK1WnJ/+f9pkxSjOvA==
X-Google-Smtp-Source: ABdhPJwW7DdXoMh6QPVdDXx+iurahKR62ysJSxnGzbplHlB7A1OGIOBp+Svbhry8OD53s/ru47JIsQ==
X-Received: by 2002:a17:90b:3a90:b0:1d2:80bf:d968 with SMTP id om16-20020a17090b3a9000b001d280bfd968mr8382241pjb.16.1650288284557;
        Mon, 18 Apr 2022 06:24:44 -0700 (PDT)
Received: from [10.254.152.226] ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id d139-20020a621d91000000b00505aa0d10desm12768842pfd.0.2022.04.18.06.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 06:24:44 -0700 (PDT)
Message-ID: <a5c66655-7e05-7bec-dcf4-0c9fe8a63061@bytedance.com>
Date:   Mon, 18 Apr 2022 21:24:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v4 1/2] ftrace: cleanup ftrace_graph_caller enable and
 disable
Content-Language: en-US
To:     rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        broonie@kernel.org, mark.rutland@arm.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com
References: <20220409153554.14470-1-zhouchengming@bytedance.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220409153554.14470-1-zhouchengming@bytedance.com>
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

Hello, friendly ping :-)


On 2022/4/9 23:35, Chengming Zhou wrote:
> The ftrace_[enable,disable]_ftrace_graph_caller() are used to do
> special hooks for graph tracer, which are not needed on some ARCHs
> that use graph_ops:func function to install return_hooker.
> 
> So introduce the weak version in ftrace core code to cleanup
> in x86.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
> v4:
>  - put weak ftrace_enable,disable_ftrace_graph_caller() in
>    fgraph.c instead of ftrace.c as suggested by Steve.
> 
> v3:
>  - consolidate two #if into a single #if, suggested by Steve. Thanks.
> ---
>  arch/x86/kernel/ftrace.c | 17 ++---------------
>  kernel/trace/fgraph.c    | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 1e31c7d21597..b09d73c2ba89 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -579,9 +579,7 @@ void arch_ftrace_trampoline_free(struct ftrace_ops *ops)
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  
> -#ifdef CONFIG_DYNAMIC_FTRACE
> -
> -#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> +#if defined(CONFIG_DYNAMIC_FTRACE) && !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS)
>  extern void ftrace_graph_call(void);
>  static const char *ftrace_jmp_replace(unsigned long ip, unsigned long addr)
>  {
> @@ -610,18 +608,7 @@ int ftrace_disable_ftrace_graph_caller(void)
>  
>  	return ftrace_mod_jmp(ip, &ftrace_stub);
>  }
> -#else /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
> -int ftrace_enable_ftrace_graph_caller(void)
> -{
> -	return 0;
> -}
> -
> -int ftrace_disable_ftrace_graph_caller(void)
> -{
> -	return 0;
> -}
> -#endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
> -#endif /* !CONFIG_DYNAMIC_FTRACE */
> +#endif /* CONFIG_DYNAMIC_FTRACE && !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
>  
>  /*
>   * Hook the return address and push it in the stack of return addrs
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 8f4fb328133a..289311680c29 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -30,6 +30,24 @@ int ftrace_graph_active;
>  /* Both enabled by default (can be cleared by function_graph tracer flags */
>  static bool fgraph_sleep_time = true;
>  
> +/*
> + * archs can override this function if they must do something
> + * to enable hook for graph tracer.
> + */
> +int __weak ftrace_enable_ftrace_graph_caller(void)
> +{
> +	return 0;
> +}
> +
> +/*
> + * archs can override this function if they must do something
> + * to disable hook for graph tracer.
> + */
> +int __weak ftrace_disable_ftrace_graph_caller(void)
> +{
> +	return 0;
> +}
> +
>  /**
>   * ftrace_graph_stop - set to permanently disable function graph tracing
>   *
