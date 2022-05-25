Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40F3533855
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiEYIYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiEYIYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:24:07 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73C6443F8
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:24:06 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id i23so23648224ljb.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DMih3PC0CUqNRPymP7jF28Tc6uD8L1kbcREW7ZOtPzM=;
        b=DXRhYssez6mYWo3RiP2+AvTIdvjhEuQ4cgCcaqri67O0rmNvafyZet7dKjXHq2U/R9
         kIGEoSp4H76gPv0OYfzjlJkvVLqi4Gu9lR5X/Hus5noIlybYVGg62qR1q/dXhPZB2ux4
         VLG97plIRrljuc5e/GYgPBJ4TkWL9TMSJNu8103P9TcVkrawhxKg902EKfDZXJDYl+Pw
         Fyq14hDuVhJk5gZaskd4NiZG8Q7No4LGpgxYFS1vDKM05c7q4ButzqjpdEt1/5Xqjqto
         EQ2HBkrH7SQai4z0mKiNErALyj4UPusOlAXO+Hcdh6zDDcnEkz/uW28IHR00VHxMRexQ
         BCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DMih3PC0CUqNRPymP7jF28Tc6uD8L1kbcREW7ZOtPzM=;
        b=DeBYoFgxhZsp14MZfAUHM+YVNBKKyw8UQ4yOeGeDQHJet5YiKQ+ONr9pOsEc9hJe/u
         VXEzvwcWyU2x+r8KiwP49fB3cjE0NB1Ue5fja5zYktNdUNNv1bnHSjXWc9y9rmd14A/t
         xGsQIgn1PzRUWQkLbgsVf98n4VW0QTHTD+m1K1UnJv6K73036FnIcYGk2DlIzraKqbxl
         JoB0JYrXfO+C5QfYrUyBSwQcjEjNLPgW722J3hHXg5XlSPNCHCMTeMxBRLNXvU5h+2vO
         Kpp5AY0tjKoTqeRx2Qr6IM4+pxgZIYW11FGdrwtTA3H4kcER/hMXAkOfpfFfp9iOLT9H
         K7LQ==
X-Gm-Message-State: AOAM533glKoeKu1LELMAZV04Vbx/h42QKLSi87fgG70Ygde2Tovf3Z5d
        rozdVwJJ/oLo+1hjajgP2bCe/g==
X-Google-Smtp-Source: ABdhPJytZeflucAMgt5ZqAvbLSpaDCd3WARNL/P3DHjs7Xt/BWUXw+If3GtRUCDjo+tWA7WG80CCeQ==
X-Received: by 2002:a2e:9c88:0:b0:253:d542:6a1f with SMTP id x8-20020a2e9c88000000b00253d5426a1fmr17197661lji.499.1653467045028;
        Wed, 25 May 2022 01:24:05 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id x26-20020ac2489a000000b0047255d21111sm2976583lfc.64.2022.05.25.01.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 01:24:04 -0700 (PDT)
Message-ID: <54ea7fb0-69da-1a9d-1dc1-58cea852f41b@openvz.org>
Date:   Wed, 25 May 2022 11:24:02 +0300
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
 <Yo3bxCkCWU+n8/3I@n2.us-central1-a.c.spheric-algebra-350919.internal>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <Yo3bxCkCWU+n8/3I@n2.us-central1-a.c.spheric-algebra-350919.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/22 10:33, Hyeonggon Yoo wrote:
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
>> ---
> 
> 
> Maybe I worried a bit much...
> 
> I failed to apply it on slab/for-next and v5.18. What tree is it based on?

Its context depends on changes in my other patches already included into mm-unstable.

>> v4:
>>  1) replaced in patch descripion: "accounted" instead of "allocated"
>>  2) added "Acked-by" from Shakeel,
>>  3) re-addressed to akpm@
>>
>> v3:
>>  1) rework kmem_cache_alloc* tracepoints once again,
>>     added struct kmem_cache argument into existing templates,
>> 	thanks to Matthew Wilcox
>>  2) updated according trace_* calls
>>  3) added boolean "allocated" entry into trace output,
>> 	thanks to Roman
>>  4) updated patch subject and description
>>
>> v2:
>>  1) handle kmem_cache_alloc_node(), thanks to Shakeel
>>  2) rework kmem_cache_alloc* tracepoints to use cachep instead
>>     of current cachep->*size parameters.
>>     NB: kmem_cache_alloc_node tracepoint in SLOB cannot use cachep,
>>         and therefore it was replaced by kmalloc_node.
>> ---
>>  include/trace/events/kmem.h | 38 +++++++++++++++++++++++--------------
>>  mm/slab.c                   | 10 +++++-----
>>  mm/slab_common.c            |  9 ++++-----
>>  mm/slob.c                   |  8 ++++----
>>  mm/slub.c                   | 20 +++++++++----------
>>  5 files changed, 47 insertions(+), 38 deletions(-)

