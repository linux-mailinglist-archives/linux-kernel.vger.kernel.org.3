Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB56B5300C3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 06:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbiEVEdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 00:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiEVEdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 00:33:14 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B6E3A5E0
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 21:33:12 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id r3so6789225ljd.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 21:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yCD06XVtIkpJKoi9CQKW+gdhYqTSRbN4wl/ZDZ8BgNE=;
        b=H4dSE3eNOXcrAi0YFzxEGRbDqkQwiBUSDobhm/nnz5/BYQ9GaUceHMkXCr04+Aujmd
         MS7GKoOz/s6c4ZIXh2kptGnQq/3o28njqYqsUdgQBtBpIDGbdx40nOBovSiuTHmpf1ry
         IJELEEo9HcIWdegkF7jEGGeIWooZLtkkXKUxsglmYM2whoj0mP+RnbD9mPE0Lg7uemfc
         FY7Nql9+XP1ZZcdStJi8W+bHMYG8+d1fI8+B0epVIlex77FyeQcj7aEuNcaoGgLGbwy4
         yLUPEYTDNwnASi7tXZBAW6iGzs4AJ9oWLbkB4hc35mFOOwhAg8LX8xu9PMWyUeIndE/+
         ar9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yCD06XVtIkpJKoi9CQKW+gdhYqTSRbN4wl/ZDZ8BgNE=;
        b=6Q/Kyk6rzTDX439xErmA7z7XLvJoULNHzMuxI+V8/h4QX13meXLxTqNFzNZP5GaRro
         phEZ8OH8f9Hk3ImELc16gCF722RBntZBuOclX8KVfT/bMKe0FN9YtEdJRQVc3yyejZl+
         zuYT8f7PFFElxRwzsLRc7/3/mu1s5wJxNtQHrpEh8WL8Uu7uudxaOMZvAa3ScHzZHx0A
         fIGODrZPn82Sj7V4vdSGh8MdA+y7awoikKYSrAP0KKISNQNn6sA1de9Jn1EH/u3DBXZW
         oyXLhnusEaP8YXghcnIV3wRAzMZ5D69AUldwhaaQM+X+8R8EebLWUSi0n52iGnA5BrAM
         lyjA==
X-Gm-Message-State: AOAM5300TNBusMQUW4rLlHKz69v5msw1f6cVQ3anAJGFEj/s6IqKCSzY
        9F0hTYJBdP3qnpuIFLZPIt5a5A==
X-Google-Smtp-Source: ABdhPJwhUWVVKZhh9D4AI5iySEbCseAEfI/eBYhvDo8aVT15ST8pKT/3uNA30wOs5jwQ2C/NSSUMLQ==
X-Received: by 2002:a2e:9d09:0:b0:253:e189:5a44 with SMTP id t9-20020a2e9d09000000b00253e1895a44mr3587978lji.225.1653193990759;
        Sat, 21 May 2022 21:33:10 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id y3-20020a2e9d43000000b00253dde4720esm963470ljj.90.2022.05.21.21.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 21:33:10 -0700 (PDT)
Message-ID: <1621d82a-439d-0657-2b7e-5e90c42c2087@openvz.org>
Date:   Sun, 22 May 2022 07:33:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4] tracing: add 'accounted' entry into output of
 allocation tracepoints
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <0c73ce5c-3625-6187-820e-1277e168b3bc@openvz.org>
 <a1e54672-d824-3ee1-cb68-9ceaa46fc70f@openvz.org>
 <YomzXwN9rvCGAZJ0@n2.us-central1-a.c.spheric-algebra-350919.internal>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <YomzXwN9rvCGAZJ0@n2.us-central1-a.c.spheric-algebra-350919.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/22 06:51, Hyeonggon Yoo wrote:
> On Sat, May 21, 2022 at 09:36:54PM +0300, Vasily Averin wrote:
>> Slab caches marked with SLAB_ACCOUNT force accounting for every
>> allocation from this cache even if __GFP_ACCOUNT flag is not passed.
>> Unfortunately, at the moment this flag is not visible in ftrace output,
>> and this makes it difficult to analyze the accounted allocations.
>>
>> This patch adds boolean "accounted" entry into trace output,
>> and set it to 'true' for calls used __GFP_ACCOUNT flag and
>> for allocations from caches marked with SLAB_ACCOUNT.
>>
>> Signed-off-by: Vasily Averin <vvs@openvz.org>
>> Acked-by: Shakeel Butt <shakeelb@google.com>
> 
> May I ask what information do you want to collect
> using this patch?

I analyze ftrace output to understand which allocations are accounted.
When some userspace operation consume memory, it's important to account
most part of memory (>2/3 of all) to avoid misuse inside memcg-limited
contianers. Otherwise memcg-limited container can consume significant 
portion of host memory, trigger global OOM, wake up OOM-killer and kill
random processes on host.
If memory consumers are accounted, it leads to memcg-OOM only. 

Now kmem tracing output looks like this:

kmem_cache_alloc:     (getname_flags.part.0+0x2c) call_site=getname_flags.part.0+0x2c ptr=0xffff8fff022e9000 bytes_req=4096 bytes_alloc=4096 gfp_flags=GFP_KERNEL accounted=false
kmalloc:              (alloc_bprm+0x32) call_site=alloc_bprm+0x32 ptr=0xffff8fff2b408a00 bytes_req=416 bytes_alloc=512 gfp_flags=GFP_KERNEL|__GFP_ZERO accounted=false
kmem_cache_alloc:     (mm_alloc+0x16) call_site=mm_alloc+0x16 ptr=0xffff8fff0894d500 bytes_req=1048 bytes_alloc=1088 gfp_flags=GFP_KERNEL accounted=true
mm_page_alloc:        page=0xffffffffa4ab8d42 pfn=0x12ad72 order=1 migratetype=0 gfp_flags=GFP_USER|__GFP_ZERO|__GFP_ACCOUNT
kmem_cache_alloc:     (vm_area_alloc+0x1a) call_site=vm_area_alloc+0x1a ptr=0xffff8fff2af27000 bytes_req=200 bytes_alloc=200 gfp_flags=GFP_KERNEL accounted=true

As you can see, without new field it is quite hard to understand, 
is last allocation accounted.

This analyze helps me to identify most important allocations for given scenario
and enable accounting for selected allocations.

An example of this analyze you can found here:
https://lore.kernel.org/all/d28233ee-bccb-7bc3-c2ec-461fd7f95e6a@openvz.org/

> I pointed it in another thread but I'm not sure
> printing SLAB_* flags in these tracepoint is good :(

I'm not sure I understand your arguments correctly. Could you please
explain your position in more details?

> If we decide to do that, it would be better to print
> something like:
> slab_flags=SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT|SLAB_STORE_USER
> instead of just printing 'accounted=true/false'. This patch is too
> specific to SLAB_ACCOUNT.

Any extra output degrades performance.
For my task it's not important to know SLAB flags, I just need to understand,
is current allocation accounted or not.

> And if what you want to know is just total slab memory that is accounted,
> what about adding something like  SlabAccounted in /proc/meminfo?

It is not enough for me. I need to have per-process allocation information.

Thank you,
	Vasily Averin
