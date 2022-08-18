Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55DC598826
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344211AbiHRP4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344663AbiHRPzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:55:53 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69672D1D0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:53:54 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id j1so1473267qvv.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=LqvAclootoU2W0/pp2IxA3VkdIzT+EcMbsWeHXyjoIk=;
        b=ULeWbHzUKqnKUycrBXTKB4oAjs889mEalvJN3O9tVYw+wgybCTBYl9Ce4PM8A9k9DM
         ZZdqyYhIz1PwIKfJm06PvioihPScZIVK0Pofh4vto/HrZzH9utD3RYcBSBeMUhYbfjV9
         nuUy0wjkKQj7IjwflbfkrPs4EshJy5WYEmn+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=LqvAclootoU2W0/pp2IxA3VkdIzT+EcMbsWeHXyjoIk=;
        b=PDtt6sq23NWQqLW680tovdGVqCPLsWByFIGq53ntmnVqFEwZ5CUbKM8gySm5KV5Mou
         YtrshejmpVYSjqyEtDklxAz4bs+cBY18LVZFMCd7ZqhGEWtdffRN0BbdYFEq5xkPmkTu
         uD4fCuIm6iJSMmOr9syHn4CTupyVdDEvcR/Afx8jTa50Q7sjtyhIuNMICldcXzlUVBQ/
         gSn91W5cc9GCVzdCNyejYcg23ZGC2bJ1+V4ETR/g7r2WEC6s7s3y5L0tUmwqcOal4iSJ
         eQZwK1F2edZQTjzEKyoxbla+tCy2XFWFR9jem38q5Wixq5FTDAL+g8TS4tJ8urbekXlr
         9o9w==
X-Gm-Message-State: ACgBeo3SGVRZEBrO09waIAuD+oAVuTSK/HVvc/UWVMs90a1NV7gSKB5y
        OIRN23sB9nwFvPTAF7gSb146CA==
X-Google-Smtp-Source: AA6agR4SBoQ02Gaq+iBnWu5sufgXL7wS2GOYI0RbT+sfE2jQru2DQwU62u4gEv0qd+72BdP382DhuQ==
X-Received: by 2002:a0c:a9d6:0:b0:496:a9fd:8595 with SMTP id c22-20020a0ca9d6000000b00496a9fd8595mr3002642qvb.108.1660838033981;
        Thu, 18 Aug 2022 08:53:53 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id bs43-20020a05620a472b00b006b9b7879964sm1785413qkb.28.2022.08.18.08.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 08:53:53 -0700 (PDT)
Date:   Thu, 18 Aug 2022 15:53:52 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, mhiramat@kernel.org,
        zanussi@kernel.org, linux-kernel@vger.kernel.org,
        chensong_2000@189.cn, Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v14 4/4] Documentation: trace/objtrace: Add documentation
 for objtrace
Message-ID: <Yv5gkKnufS7CUq9A@google.com>
References: <20220628145552.349839-1-xiehuan09@gmail.com>
 <20220628145552.349839-5-xiehuan09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628145552.349839-5-xiehuan09@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:55:52PM +0800, Jeff Xie wrote:
> Add documentation explaining how to use objtrace trigger to get the value
> of the object.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
> Changelog:
> v14:
> - make documentation more readable and fix literal code block by Bagas Sanjaya
> 
>  Documentation/trace/events.rst | 87 ++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
> index c47f381d0c00..c15f1d25d4a0 100644
> --- a/Documentation/trace/events.rst
> +++ b/Documentation/trace/events.rst
> @@ -546,6 +546,93 @@ The following commands are supported:
>  
>    See Documentation/trace/histogram.rst for details and examples.
>  
> +- objtrace
> +
> +  This command provides a way to get the value of any object, The object
> +  can be obtained from the dynamic event (kprobe_event/uprobe_event) or the
> +  static event (tracepoint).
> +
> +  Usage:
> +  When using the kprobe event, by only need to set the objtrace (a new
> +  trigger), we can get the value of object that is set by kprobe event.
> +
> +  For example, for the function bio_add_page():
> +
> +  .. code-block:: c
> +
> +     int bio_add_page(struct bio *bio, struct page *page,
> +	              unsigned int len, unsigned int offset)
> +
> +  Firstly, we can set the base of the object as first parameter (arg1) to
> +  to the function:
> +
> +  .. code-block::
> +
> +     # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> +
> +  Secondly, we can get the value dynamically based on the object:
> +
> +  .. code-block::
> +
> +     find the offset of the bi_size in struct bio:
> +     $ gdb vmlinux
> +     (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
> +     $1 = (unsigned int *) 0x28
> +
> +     # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
> +       p_bio_add_page_0/trigger
> +
> +     # cd /sys/kernel/debug/tracing/
> +     # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> +     # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger

No offense but this documentation is not well written and hard to read.

Admittedly though I am just casually browsing through, so apologies.

So basically, 0x28 is the offset of the u32 within the bio, that you want to
track down, as it passes through functions?

The example is good, but I suggest breakdown each of the commands separated
by ':' and document those as well.

Cool feature though, I can see myself using it for something (dunno what yet) :)

thanks,

 - Joel



> +
> +     # du -sh /test.txt
> +     12.0K   /test.txt
> +
> +     # cat  /test.txt > /dev/null
> +     # cat ./trace
> +     # tracer: nop
> +     #
> +     # entries-in-buffer/entries-written: 128/128   #P:4
> +     #
> +     #                                _-----=> irqs-off/BH-disabled
> +     #                               / _----=> need-resched
> +     #                              | / _---=> hardirq/softirq
> +     #                              || / _--=> preempt-depth
> +     #                              ||| / _-=> migrate-disable
> +     #                              |||| /     delay
> +     #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> +     #              | |         |   |||||     |         |
> +                  cat-117     [002] ...1.     1.602243: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x0
> +                  cat-117     [002] ...1.     1.602244: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x0
> +                  cat-117     [002] ...2.     1.602244: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x1000
> +                  cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
> +                  cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
> +                  cat-117     [002] ...2.     1.602245: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x2000
> +                  cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
> +                  cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
> +                  cat-117     [002] ...1.     1.602245: submit_bio <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
> +                  cat-117     [002] ...1.     1.602245: submit_bio_noacct <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
> +                  cat-117     [002] ...1.     1.602246: __submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
> +                  cat-117     [002] ...1.     1.602246: submit_bio_checks <-__submit_bio object:0xffff88811bee4000 value:0x3000
> +                  cat-117     [002] ...1.     1.602246: __cond_resched <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
> +                  cat-117     [002] ...1.     1.602246: should_fail_bio <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
> +                  cat-117     [002] ...1.     1.602246: blk_mq_submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
> +                  cat-117     [002] ...1.     1.602246: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> +                  cat-117     [002] ...1.     1.602246: blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> +                  cat-117     [002] ...1.     1.602247: __rcu_read_lock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> +                  cat-117     [002] ...1.     1.602247: __rcu_read_unlock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> +                  cat-117     [002] ...1.     1.602247: __blk_mq_alloc_requests <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> +               <idle>-0       [002] d..3.     1.602298: bio_endio <-blk_update_request object:0xffff88811bee4000 value:0x0
> +               <idle>-0       [002] d..3.     1.602298: mpage_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
> +               <idle>-0       [002] d..3.     1.602298: __read_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
> +               <idle>-0       [002] d..3.     1.602300: bio_put <-blk_update_request object:0xffff88811bee4000 value:0x0
> +               <idle>-0       [002] d..3.     1.602300: bio_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> +               <idle>-0       [002] d..3.     1.602300: mempool_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> +               <idle>-0       [002] d..3.     1.602300: mempool_free_slab <-blk_update_request object:0xffff88811bee4000 value:0x0
> +               <idle>-0       [002] d..3.     1.602300: kmem_cache_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> +                ...
> +
>  7. In-kernel trace event API
>  ============================
>  
> -- 
> 2.25.1
>
