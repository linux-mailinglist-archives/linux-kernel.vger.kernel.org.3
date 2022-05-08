Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CD951F1B2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 22:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiEHUxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 16:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbiEHUxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 16:53:43 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADAD38BB
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 13:49:51 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id y3so23298351ejo.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 13:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N3u3DsBrtjhbjGZ+KXEeJGBa+J91FAgZg94Zd6yuT7w=;
        b=OPoNglGfV+5DXE9pvz+l899QCwZCacAMYMjszaSnokeNn9cpoHhArp1/EgpxTZSiWy
         jaRcPWN0DMQisyXj+106l4gkQ1ZrcFmVOxw0mtVimIi5xpXuHFB7LGEVlmMx994fDvI5
         /r0IrtbFT2kVsB8VGK88bsn8pVTjqig8kgFGBdGtVVOPs4nWVOU7tdpxTPICY7e/ccDh
         dDfIUs5j22ZPPYJr5GA2uPb2JzQCDh1AVrAgN3H00m/FqXZLkFvIOmUQz2yeM9rRnIYO
         ZhrrFdU+puj7qhNM4Y7S2+ENxKTa0YfQwol0jhq83PaGNrlGGherXGj0yuyaTnGIYzny
         8W2Q==
X-Gm-Message-State: AOAM533sVDelkbjN/7arnfL/rWiqsyYABM+wlcYnpcEsFKbahybKijRs
        mu8S6tkg2jPJV1eBIqTf5/E=
X-Google-Smtp-Source: ABdhPJw5eG+Ips+GenyVP3VdatI+SK51I5pSEukIkiR9R8KOj/eQOSo8c103NESr6ebBqGkOdOxH3w==
X-Received: by 2002:a17:907:a088:b0:6f4:f661:f77a with SMTP id hu8-20020a170907a08800b006f4f661f77amr12070854ejc.77.1652042989945;
        Sun, 08 May 2022 13:49:49 -0700 (PDT)
Received: from [10.9.0.34] ([46.166.128.205])
        by smtp.gmail.com with ESMTPSA id b18-20020aa7dc12000000b0042617ba63acsm5276498edu.54.2022.05.08.13.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 May 2022 13:49:49 -0700 (PDT)
Message-ID: <e1cf0177-40a0-ffca-6be4-57fd97860c4a@linux.com>
Date:   Sun, 8 May 2022 23:49:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH v2 05/13] stackleak: clarify variable names
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, will@kernel.org
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-6-mark.rutland@arm.com>
From:   Alexander Popov <alex.popov@linux.com>
In-Reply-To: <20220427173128.2603085-6-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.04.2022 20:31, Mark Rutland wrote:
> The logic within __stackleak_erase() can be a little hard to follow, as
> `boundary` switches from being the low bound to the high bound mid way
> through the function, and `kstack_ptr` is used to represent the start of
> the region to erase while `boundary` represents the end of the region to
> erase.
> 
> Make this a little clearer by consistently using clearer variable names.
> The `boundary` variable is removed, the bounds of the region to erase
> are described by `erase_low` and `erase_high`, and bounds of the task
> stack are described by `task_stack_low` and `task_stck_high`.

A typo here in `task_stck_high`.

> As the same time, remove the comment above the variables, since it is
> unclear whether it's intended as rationale, a complaint, or a TODO, and
> is more confusing than helpful.

Yes, this comment is a bit confusing :) I can elaborate.

In the original grsecurity patch, the stackleak erasing was written in asm.
When I adopted it and proposed for the upstream, Linus strongly opposed this.
So I developed stackleak erasing in C.

And I wrote this comment to remember that having 'kstack_ptr' and 'boundary' 
variables on the stack (which we are clearing) would not be good.

That was also the main reason why I reused the 'boundary' variable: I wanted the 
compiler to allocate it in the register and I avoided creating many local variables.

Mark, did your refactoring make the compiler allocate local variables on the 
stack instead of the registers?

> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Popov <alex.popov@linux.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>   kernel/stackleak.c | 30 ++++++++++++++----------------
>   1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> index 24b7cf01b2972..d5f684dc0a2d9 100644
> --- a/kernel/stackleak.c
> +++ b/kernel/stackleak.c
> @@ -73,40 +73,38 @@ late_initcall(stackleak_sysctls_init);
>   static __always_inline void __stackleak_erase(void)
>   {
>   	const unsigned long task_stack_low = stackleak_task_low_bound(current);
> -
> -	/* It would be nice not to have 'kstack_ptr' and 'boundary' on stack */
> -	unsigned long kstack_ptr = current->lowest_stack;
> -	unsigned long boundary = task_stack_low;
> +	unsigned long erase_low = current->lowest_stack;
> +	unsigned long erase_high;
>   	unsigned int poison_count = 0;
>   	const unsigned int depth = STACKLEAK_SEARCH_DEPTH / sizeof(unsigned long);
>   
>   	/* Search for the poison value in the kernel stack */
> -	while (kstack_ptr > boundary && poison_count <= depth) {
> -		if (*(unsigned long *)kstack_ptr == STACKLEAK_POISON)
> +	while (erase_low > task_stack_low && poison_count <= depth) {
> +		if (*(unsigned long *)erase_low == STACKLEAK_POISON)
>   			poison_count++;
>   		else
>   			poison_count = 0;
>   
> -		kstack_ptr -= sizeof(unsigned long);
> +		erase_low -= sizeof(unsigned long);
>   	}
>   
>   #ifdef CONFIG_STACKLEAK_METRICS
> -	current->prev_lowest_stack = kstack_ptr;
> +	current->prev_lowest_stack = erase_low;
>   #endif
>   
>   	/*
> -	 * Now write the poison value to the kernel stack. Start from
> -	 * 'kstack_ptr' and move up till the new 'boundary'. We assume that
> -	 * the stack pointer doesn't change when we write poison.
> +	 * Now write the poison value to the kernel stack between 'erase_low'
> +	 * and 'erase_high'. We assume that the stack pointer doesn't change
> +	 * when we write poison.
>   	 */
>   	if (on_thread_stack())
> -		boundary = current_stack_pointer;
> +		erase_high = current_stack_pointer;
>   	else
> -		boundary = current_top_of_stack();
> +		erase_high = current_top_of_stack();
>   
> -	while (kstack_ptr < boundary) {
> -		*(unsigned long *)kstack_ptr = STACKLEAK_POISON;
> -		kstack_ptr += sizeof(unsigned long);
> +	while (erase_low < erase_high) {
> +		*(unsigned long *)erase_low = STACKLEAK_POISON;
> +		erase_low += sizeof(unsigned long);
>   	}
>   
>   	/* Reset the 'lowest_stack' value for the next syscall */

