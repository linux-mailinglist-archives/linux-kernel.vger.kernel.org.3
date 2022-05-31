Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B3D539523
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 18:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346253AbiEaQ60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 12:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346242AbiEaQ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 12:58:24 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879922E6AC
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:58:22 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s6so6477125lfo.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=y/aNKJXZWqRuqPNJq3hEjocGGUwSzRQP7BmWbTX4fYk=;
        b=4fhxtldUto8lIjf5Vd/ncQaAJRtTe9kfVGUB4asPKmakTApkAdCaPdi7Bfcu0KbGjo
         kD49uDvDW9Xzc41t6h1FLF1KalEudS0DGuprg5CxMTW99WTyFQ9rgeAEWNJSQ314icL2
         uEiI2vAgVsL0gbqL/huVqVMIF1m2OMJQvdptH/2DFrK4SBICbnNytIj/nxHMm1P3Jwaa
         EtldNWqKYWWlp3BKACGbSLZzh42nyIh//5qMl2jzMm3GlLAZAyHfdzVFFc9pl0Clt3ly
         JgGXUV1y2Qz0h3WH1ginmZ2kzSEHRS1SRECRWsgWRGXq5Sy4YeqBiqrNF8ikQmg3Wlqx
         gd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=y/aNKJXZWqRuqPNJq3hEjocGGUwSzRQP7BmWbTX4fYk=;
        b=Ilui+TJeaDMSUTVYIB23IWWx62n3ftidQzEs94hdaTkU9lJLU4gcsf5DSV4RQcH9pC
         161c9UA+hzmavNoc8fUQPdIVBDtMObMix7E6Ar6w0mkQ8J1dLVCt0xH455LzpslYd8yC
         Py7IGbYAxLgIKUzeMXbw1I6mB/rdUyBAS0zFJboQEVB4pFJbnmV+RAGj7xAabKliIx4S
         Uc3Yf6CY8V7aPIXwUEgcO1tGJkCIMiKlt1oj4/bCRlOu6zz/OQOgSVOWP+8TAlldAyec
         T1xktft9mGUkDo9yq0d/xmcShSo4Jn9kIYF7vmke9p2GJV26Bm1/Z5mnpuLVMiG5QLcm
         k5DA==
X-Gm-Message-State: AOAM530EDqErEFVAiIC0P1YjoTH4+EZhToSH8mIKXvQtE0IZrQl3lHlq
        Re5t1rKbartpRLg50IcsDR2ljw==
X-Google-Smtp-Source: ABdhPJz3Fl42XMGA34sRuK/Xk+fdkRg5ifvRHo3oEFZREdnnLYlDX9W+yUOzfRqB00pHmgu/BO3/Bw==
X-Received: by 2002:a05:6512:a95:b0:478:82fb:7783 with SMTP id m21-20020a0565120a9500b0047882fb7783mr28720432lfu.471.1654016300830;
        Tue, 31 May 2022 09:58:20 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id j5-20020a05651231c500b0047255d2115fsm3063876lfe.142.2022.05.31.09.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 09:58:20 -0700 (PDT)
Message-ID: <c1676616-1405-5bcb-af02-c1e9cc83dace@openvz.org>
Date:   Tue, 31 May 2022 19:58:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5] tracing: add 'accounted' entry into output of
 allocation tracepoints
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Matthew Wilcox <willy@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <c7f687a8-637c-b119-6e3a-7dacc885b851@suse.cz>
 <80bcb043-3782-1d81-d8a2-4bdcb213cf30@openvz.org>
 <YpYAL4H/L2ERQ9Fj@n2.us-central1-a.c.spheric-algebra-350919.internal>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <YpYAL4H/L2ERQ9Fj@n2.us-central1-a.c.spheric-algebra-350919.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/22 14:46, Hyeonggon Yoo wrote:
> On Mon, May 30, 2022 at 10:47:26AM +0300, Vasily Averin wrote:
> Looks good to me.
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> a small comment:
>>  
>>  	TP_fast_assign(
>> @@ -33,42 +35,46 @@ DECLARE_EVENT_CLASS(kmem_alloc,
>>  		__entry->bytes_req	= bytes_req;
>>  		__entry->bytes_alloc	= bytes_alloc;
>>  		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
>> +		__entry->accounted	= (gfp_flags & __GFP_ACCOUNT) ||
>> +					  (s && s->flags & SLAB_ACCOUNT);
>>  	),
>>  
> 
> It doesn't make sense for SLOB to print accounted=true because SLOB does
> not support object accounting.

Thank you very much for this comment.
SLAB_ACCOUNT is not defined for SLOB, but __GFP_ACCOUNT really can incorrectly 
set this field to true.
I'll think how to handle this correctly.

Thank you,
	Vasily Averin
