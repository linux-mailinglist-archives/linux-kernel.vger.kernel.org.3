Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CB359BDAD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 12:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiHVKiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 06:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiHVKh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 06:37:59 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9642FFC0;
        Mon, 22 Aug 2022 03:37:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bj12so3208168ejb.13;
        Mon, 22 Aug 2022 03:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=Fic3qiVWuOXlTHP1LZdbaPSid2L5A3dsT7KZevdChfs=;
        b=IHCuOUhy56vMwdwjLTG9NYX3fgcJdjJPjKhyta6Qno0VyVYmrtpv9plgj6qwWD/X2s
         HwucGO9KuL0+fghF4vJmR4n6VrUCKt9Z1rHhlw2k27NTRRAGdLmbtW4v6PfYv0ohFFge
         +XizqygcAKRGewcldYjjgWNN5F1sii+PSyPdOcaGhBabVrUjtVUM1abOU8eeWfl3fgEX
         lUWYUW0pzYBASu2+AuJdgXCGAJVQfzFcGfJiTsq+RXzRk1ILQyG1WUAKMKKmp7/64veg
         7LGqhggBuNU9M9ktMRIynqbAQVfL3FdjdzZuktCWyNiSuug2eGT+XuMWFl+4q31DvBvO
         zrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=Fic3qiVWuOXlTHP1LZdbaPSid2L5A3dsT7KZevdChfs=;
        b=4ZO3/CTlBcDlHALq/lCRCMj9ybT+M4X8HKm6VWCCIQ1oNmgIWl+K5JmRPs1IEcg4ix
         Q72avHcWaNqEiXGQkQVIOk9ectRn+uOaqPcDq1aawzK4upWTSovDw382ELgDg+p1fzPq
         4kcZqFsDlUjEdJFebS5Ovg5ba18uis+0tl0Aiw5Dz7tk6dDMzQ1je2Gv9y7Dj1aTB4O9
         P0rad6VWgDaY6zrH7NyA1aOHr9I7Xur0cgiP2RuUjzUIAmY/qo0nPexlUPZRVvxdhSvi
         Y/ltOORlbPo4ndKQY8NHvLUp5OqUZO8UAKZdB7Q7FhAZ3ZPxSzmhB5MtBUpKOMEPGP3w
         v+IA==
X-Gm-Message-State: ACgBeo3iHPvsna1iKBnc157r8oX/taEiKX9zwEpiWgvz0wo59mlLLRDv
        +s7x5Eyx9Zrj6hKBskhPqYA=
X-Google-Smtp-Source: AA6agR61ZJH1BrR2M4z9iHGxFWbQH+3OJQa8rlccLSppDIjyOOz9ZmPu5f2e5WGvyZY474HoWqaSiw==
X-Received: by 2002:a17:907:a408:b0:73d:6696:50af with SMTP id sg8-20020a170907a40800b0073d669650afmr6162308ejc.369.1661164676572;
        Mon, 22 Aug 2022 03:37:56 -0700 (PDT)
Received: from gmail.com (195-38-113-151.pool.digikabel.hu. [195.38.113.151])
        by smtp.gmail.com with ESMTPSA id l17-20020a1709063d3100b00711edab7622sm5941550ejf.40.2022.08.22.03.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 03:37:55 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 22 Aug 2022 12:37:53 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     bp@suse.de, ndesaulniers@google.com, nathan@kernel.org,
        alexandre.belloni@bootlin.com, acme@kernel.org,
        namhyung@kernel.org, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix compile error for x86
Message-ID: <YwNcgdk/p18Cr+uv@gmail.com>
References: <20220822092557.210209-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220822092557.210209-1-yangjihong1@huawei.com>
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yang Jihong <yangjihong1@huawei.com> wrote:

> Commit a0a12c3ed057 ("asm goto: eradicate CC_HAS_ASM_GOTO") eradicates
> CC_HAS_ASM_GOTO, perf on x86 call asm_volatile_goto when compiling __GEN_RMWcc.
> However, asm_volatile_goto is not declared, which causes compilation error:
> 
> In file included from /home/linux/tools/include/asm/../../arch/x86/include/asm/atomic.h:7,
>                  from /home/linux/tools/include/asm/atomic.h:6,
>                  from /home/linux/tools/include/linux/atomic.h:5,
>                  from /home/linux/tools/include/linux/refcount.h:41,
>                  from /home/linux/tools/lib/perf/include/internal/cpumap.h:5,
>                  from /home/linux/tools/perf/util/cpumap.h:7,
>                  from /home/linux/tools/perf/util/env.h:7,
>                  from /home/linux/tools/perf/util/header.h:12,
>                  from pmu-events/pmu-events.c:9:
> /home/linux/tools/include/asm/../../arch/x86/include/asm/atomic.h: In function ‘atomic_dec_and_test’:
> /home/linux/tools/include/asm/../../arch/x86/include/asm/rmwcc.h:7:2: error: implicit declaration of function ‘asm_volatile_goto’ [-Werror=implicit-function-declaration]
>   asm_volatile_goto (fullop "; j" cc " %l[cc_label]"  \
>   ^~~~~~~~~~~~~~~~~
> 
> Solution:
> Define asm_volatile_goto in compiler_types.h if not declared.
> 
> Currently, only x86 architecture uses asm_volatile_goto.
> Theoretically, this patch affects only the x86 architecture.
> 
> Fixes: a0a12c3ed057 ("asm goto: eradicate CC_HAS_ASM_GOTO")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/include/linux/compiler_types.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/include/linux/compiler_types.h b/tools/include/linux/compiler_types.h
> index 24ae3054f304..1bdd834bdd57 100644
> --- a/tools/include/linux/compiler_types.h
> +++ b/tools/include/linux/compiler_types.h
> @@ -36,4 +36,8 @@
>  #include <linux/compiler-gcc.h>
>  #endif
>  
> +#ifndef asm_volatile_goto
> +#define asm_volatile_goto(x...) asm goto(x)
> +#endif

Tested-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
