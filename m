Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A71A4E3EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbiCVMtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbiCVMtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:49:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBC632A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:48:11 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n15so15373978plh.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DpDIKrRxxH2uk4JPff6xIxmueMX+SFTxFN5YBUfx1gk=;
        b=teSMCHM4MFOGwL4r7o4k0jzZn6iFzq3bxIHbT6KSdd7ae6eNBGBYHLyg9DA9+RLypq
         6/xKa6U/qR1w1cYJnqgjDAEw4jUDc1Hk+3z2UyI37JwaLBMvmyHHRTi67RW6RNPP1Sj+
         /OCSIQRMzsz4xLYjW2IlNMV4WKZKnGVE6afY9Dqj59LbJlEqcTAD96M6/NgCD46ja50T
         A9GdFv3jCIwejoGoeFrfVFdkwMYntoWS1Doy/a7AAuUhOCFoT0TzyzZBudNn60+zolh+
         XVrsckmiPwpbakATT910eUPj3kSCOV++rcC41ZLQ/6zR8ycv1s9cAK4SgJlzfOHSL3a1
         jeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DpDIKrRxxH2uk4JPff6xIxmueMX+SFTxFN5YBUfx1gk=;
        b=TJSzOZwvq3pZfi9tRABwgzVQutIh6Q2H1940lnGsoToNwNELyvt0e2qrgOSuYCHl5T
         21Cre4E15dGVC7e3kZzTUs7BO0LE++R4hYPjB5b47pF86EZF6R2YuIyjwpfs2kzgWMAf
         sUnhTmVr7Phy3XFeT7gkbmwbqMYXxFicIXnVO9UD8691Hg4VLhuJEZTUAedK1X+SPCfZ
         E7vhKRwPPQ5njDLdRpqtWf2QBcHU8BQy87Yu3eGx7pw61wd2OZEkgOxF4/xVnn7vX+yk
         khe2hGa0Hk6s9t5pl/ydzitqjWriDIhu13R+6ksJMmCjoDnDShpXaFp7SmGgiX5CuOHO
         yx+Q==
X-Gm-Message-State: AOAM531qN1q0061saUL+4JpjQhRthWT7OE0wE3SoVUgQzztTEo9ePkwB
        vKRjKP6y/DveUgeMO/37n+kY0w==
X-Google-Smtp-Source: ABdhPJzFrAYkcOTj9IlEDLm6FVFNaE9DmJSyjdtzg9Iu0ju/nE6/6Or3iZ867JywlHwjYXFDgTjKgA==
X-Received: by 2002:a17:902:7002:b0:14d:76b9:2303 with SMTP id y2-20020a170902700200b0014d76b92303mr18381725plk.155.1647953290743;
        Tue, 22 Mar 2022 05:48:10 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e62:3990:ac62:e5ec:7f4f:1b38? ([2409:8a28:e62:3990:ac62:e5ec:7f4f:1b38])
        by smtp.gmail.com with ESMTPSA id t10-20020a056a00138a00b004fa9c9fda44sm8560181pfg.89.2022.03.22.05.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 05:48:10 -0700 (PDT)
Message-ID: <c8b7508b-ce2a-c7dc-92c4-ca5f17992844@bytedance.com>
Date:   Tue, 22 Mar 2022 20:48:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v3 3/3] arm64/ftrace: Make function graph use ftrace
 directly
Content-Language: en-US
To:     rostedt@goodmis.org, mark.rutland@arm.com, mingo@redhat.com,
        tglx@linutronix.de, catalin.marinas@arm.com, will@kernel.org,
        dave.hansen@linux.intel.com, broonie@kernel.org
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        qirui.001@bytedance.com
References: <20220224093251.49971-1-zhouchengming@bytedance.com>
 <20220224093251.49971-3-zhouchengming@bytedance.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220224093251.49971-3-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

ping... have any comments?

Thanks.

On 2022/2/24 5:32 下午, Chengming Zhou wrote:
> As we do in commit 0c0593b45c9b ("x86/ftrace: Make function graph
> use ftrace directly"), we don't need special hook for graph tracer,
> but instead we use graph_ops:func function to install return_hooker.
> 
> Since commit 3b23e4991fb6 ("arm64: implement ftrace with regs") add
> implementation for FTRACE_WITH_REGS on arm64, we can easily adopt
> the same cleanup on arm64. And this cleanup only changes the
> FTRACE_WITH_REGS implementation, so the mcount-based implementation
> is unaffected.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
> Changes in v3:
>  - Add comments in ftrace_graph_func() as suggested by Steve.
> 
> Changes in v2:
>  - Remove FTRACE_WITH_REGS ftrace_graph_caller asm as suggested by Mark.
> ---
>  arch/arm64/include/asm/ftrace.h  |  7 +++++++
>  arch/arm64/kernel/entry-ftrace.S | 17 -----------------
>  arch/arm64/kernel/ftrace.c       | 17 +++++++++++++++++
>  3 files changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index 1494cfa8639b..dbc45a4157fa 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -80,8 +80,15 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>  struct dyn_ftrace;
> +struct ftrace_ops;
> +struct ftrace_regs;
> +
>  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
>  #define ftrace_init_nop ftrace_init_nop
> +
> +void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> +		       struct ftrace_ops *op, struct ftrace_regs *fregs);
> +#define ftrace_graph_func ftrace_graph_func
>  #endif
>  
>  #define ftrace_return_address(n) return_address(n)
> diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
> index e535480a4069..d42a205ef625 100644
> --- a/arch/arm64/kernel/entry-ftrace.S
> +++ b/arch/arm64/kernel/entry-ftrace.S
> @@ -97,12 +97,6 @@ SYM_CODE_START(ftrace_common)
>  SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
>  	bl	ftrace_stub
>  
> -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> -SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL) // ftrace_graph_caller();
> -	nop				// If enabled, this will be replaced
> -					// "b ftrace_graph_caller"
> -#endif
> -
>  /*
>   * At the callsite x0-x8 and x19-x30 were live. Any C code will have preserved
>   * x19-x29 per the AAPCS, and we created frame records upon entry, so we need
> @@ -127,17 +121,6 @@ ftrace_common_return:
>  	ret	x9
>  SYM_CODE_END(ftrace_common)
>  
> -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> -SYM_CODE_START(ftrace_graph_caller)
> -	ldr	x0, [sp, #S_PC]
> -	sub	x0, x0, #AARCH64_INSN_SIZE	// ip (callsite's BL insn)
> -	add	x1, sp, #S_LR			// parent_ip (callsite's LR)
> -	ldr	x2, [sp, #PT_REGS_SIZE]	   	// parent fp (callsite's FP)
> -	bl	prepare_ftrace_return
> -	b	ftrace_common_return
> -SYM_CODE_END(ftrace_graph_caller)
> -#endif
> -
>  #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>  
>  /*
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index 4506c4a90ac1..35eb7c9b5e53 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -268,6 +268,22 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
>  }
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
> +
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> +		       struct ftrace_ops *op, struct ftrace_regs *fregs)
> +{
> +	/*
> +	 * Athough graph_ops doesn't have FTRACE_OPS_FL_SAVE_REGS set in flags,
> +	 * regs can't be NULL in DYNAMIC_FTRACE_WITH_REGS. By design, it should
> +	 * be fixed when DYNAMIC_FTRACE_WITH_ARGS is implemented.
> +	 */
> +	struct pt_regs *regs = arch_ftrace_get_regs(fregs);
> +	unsigned long *parent = (unsigned long *)&procedure_link_pointer(regs);
> +
> +	prepare_ftrace_return(ip, parent, frame_pointer(regs));
> +}
> +#else
>  /*
>   * Turn on/off the call to ftrace_graph_caller() in ftrace_caller()
>   * depending on @enable.
> @@ -297,5 +313,6 @@ int ftrace_disable_ftrace_graph_caller(void)
>  {
>  	return ftrace_modify_graph_caller(false);
>  }
> +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>  #endif /* CONFIG_DYNAMIC_FTRACE */
>  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
