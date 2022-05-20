Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F39A52E9B5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347983AbiETKOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbiETKOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:14:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EFE6CA89
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 03:14:43 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay35so2687302wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 03:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YI47hgicQMxxxQU8hmpn8OChFvZfMABxIXxG9XMziXU=;
        b=B6xXaCz/9Z8jPhpJ6mtVdO7hkOOPdVdMi4Br/t/hDUB+YC8X9ZDwbJcR3ju1QawwHc
         EswtRNZ1IyK730pTuQhP3uAIu9sl/aCUWNw1WVi85nReMaIiw4D2JWW86ZUw0V5wYXOx
         4Z0Y3Mt+ahHo87vwo5C0i9ZVJWisUBEfAa2QnaLah4lDH0c7EIGC7ZqysxMUe2qP6j3x
         Uqsrvwd3l1d2x9uUZtKQDfyQeHKP/UxjXk1ZRU6ajJpnqm85U2GZVHLR0RXsa0KzS2ku
         zH0OtdW1ZZHLanRQNX1zPCrWEeu5wIBsvVdYCinOA0tWAHV1et6tTYklCa9GNKvYdxCJ
         ohjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YI47hgicQMxxxQU8hmpn8OChFvZfMABxIXxG9XMziXU=;
        b=S71s2DA3EE06VySVZnwyYIlqUyWCE4cza1kPDujx7lluok/dnbIMf6sGoIJ92j7urM
         D9wdw905gnKFfkr0DrJZukPGeH/vTx3hnEmlsxxKU1+kRQjMRhXJkvbhyZ/ON2zhhIAq
         pm6bVgM9e/dNpR5ZsoSyObrLkwFv8QYhHZQATY7uQS2CeOBvzKc6dydLG7i/64r4gSIG
         J8eo0nC8El/rDREI8SdQZnvdXtib9Fw8YJbIeaccgDSgK0ArDcjH43JJAugWgpAt+xDE
         7AUi71Iqg+ala8B8IywgR17b9ba653wrCtyjgkF39Fbr9ZF8jAUuqUBrGdc4DCAg9S+H
         ZhxA==
X-Gm-Message-State: AOAM531Rw50QA+n13dij6do/3LpMn4hjdeajj/9ELuuJS0JcktNsuWTh
        PSB4lPZ41+kAOwehmhGeEQ561A==
X-Google-Smtp-Source: ABdhPJw/Nl2hbEXYtjhjRz+i2/tfpFrVP4oUqSoMpKliGp2zwr3AlxitGZj40hxVFsRnsfmruCJAeQ==
X-Received: by 2002:a05:600c:a53:b0:394:7a51:cb71 with SMTP id c19-20020a05600c0a5300b003947a51cb71mr8314724wmq.148.1653041681893;
        Fri, 20 May 2022 03:14:41 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:bae2:f132:a26:fae2])
        by smtp.gmail.com with ESMTPSA id c11-20020adfa30b000000b0020d0b2de858sm2167642wrb.33.2022.05.20.03.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 03:14:41 -0700 (PDT)
Date:   Fri, 20 May 2022 12:14:35 +0200
From:   Marco Elver <elver@google.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, paulmck@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/2] arm64: kcsan: Support detecting more missing
 memory barriers
Message-ID: <YodqC/HKVJLAjpQY@elver.google.com>
References: <20220520031548.175582-1-wangkefeng.wang@huawei.com>
 <20220520031548.175582-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520031548.175582-3-wangkefeng.wang@huawei.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 11:15AM +0800, Kefeng Wang wrote:
> As "kcsan: Support detecting a subset of missing memory barriers"[1]
> introduced KCSAN_STRICT/KCSAN_WEAK_MEMORY which make kcsan detects
> more missing memory barrier, but arm64 don't have KCSAN instrumentation
> for barriers, so the new selftest test_barrier() and test cases for
> memory barrier instrumentation in kcsan_test module will fail, even
> panic on selftest.
> 
> Let's prefix all barriers with __ on arm64, as asm-generic/barriers.h
> defined the final instrumented version of these barriers, which will
> fix the above issues.
> 
> Note, barrier instrumentation that can be disabled via __no_kcsan with
> appropriate compiler-support (and not just with objtool help), see
> commit bd3d5bd1a0ad ("kcsan: Support WEAK_MEMORY with Clang where no
> objtool support exists"), it adds disable_sanitizer_instrumentation to
> __no_kcsan attribute which will remove all sanitizer instrumentation fully
> (with Clang 14.0). Meanwhile, GCC does the same thing with no_sanitize.
> 
> [1] https://lore.kernel.org/linux-mm/20211130114433.2580590-1-elver@google.com/
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm64/include/asm/barrier.h | 12 ++++++------
>  include/asm-generic/barrier.h    |  4 ++++
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index 9f3e2c3d2ca0..2cfc4245d2e2 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -50,13 +50,13 @@
>  #define pmr_sync()	do {} while (0)
>  #endif
>  
> -#define mb()		dsb(sy)
> -#define rmb()		dsb(ld)
> -#define wmb()		dsb(st)
> +#define __mb()		dsb(sy)
> +#define __rmb()		dsb(ld)
> +#define __wmb()		dsb(st)
>  
> -#define dma_mb()	dmb(osh)
> -#define dma_rmb()	dmb(oshld)
> -#define dma_wmb()	dmb(oshst)
> +#define __dma_mb()	dmb(osh)
> +#define __dma_rmb()	dmb(oshld)
> +#define __dma_wmb()	dmb(oshst)
>  
>  #define io_stop_wc()	dgh()
>  
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index fd7e8fbaeef1..18863c50e9ce 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -38,6 +38,10 @@
>  #define wmb()	do { kcsan_wmb(); __wmb(); } while (0)
>  #endif
>  
> +#ifdef __dma_mb
> +#define dma_mb()	do { kcsan_mb(); __dma_mb(); } while (0)
> +#endif

The asm-generic changes might want to go into a separate patch, along
with the generic definition of dma_mb() if there's no __dma_mb, as
mentioned in the other email.

Thanks,
-- Marco
