Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835EC53054F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 20:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350187AbiEVSxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 14:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiEVSxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 14:53:46 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FA5289B5
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 11:53:45 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u7so14184493ljd.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 11:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qiTcRO7nL7Dq/EQDHaCSaoJhy3aBMGNT4Ao5jaLqsYQ=;
        b=PtG/lD+eaGYLmB0i71DS3iRW6thye6f7x1e3TTLbvqjp3hvxDrGJZkJsG4NIHUrWGw
         D1xWD8JMqbPo9I7y+KhizGV0+adl4jRtkjgwn/gHSMgo/+fWVOae9dKo9i18VWTrXcJI
         f3EacFrezNUDNmhlKbjhczD6DgUBPbS4azY5urxjjS3+hCTlapVzjQB+myJCRHIvPxLb
         FSK0VwrbcrFMqe+wEneOhYR6nQGeYjR2PYmiT5hRRHdgHAgYM6ubekpWFZFzZnw8qKOO
         p917vbhC0VxxXCOF4k8XJiNSinYCWDcxOGrP18ScX2xa8Hip+5kXs/XPBEeh2Bj+5/xW
         b/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qiTcRO7nL7Dq/EQDHaCSaoJhy3aBMGNT4Ao5jaLqsYQ=;
        b=T1XvVsUFtsfH2UEalNUm0SKoVL6IamBYmp+2CxwJqonaQglT4X/4eQEJPfCY5uZFlU
         jV6Zze330YmwdMhxW6jiP6GB8188bmwtPrPZeOMGul8iWMUsDp6gwl7NJNF3GQtPknRL
         mcRSQY1lLiIjbAtef12vymGLPNUVvTIkAO2D7j1ToaXWmo/cIeAOHvNYofLBPlqXN2ZH
         Z9q+1GRVF5BaLLECEa9pJ4Hnk2KTKSDVNVXPT0R0kyM+vky6x99MV3TTVH2ZUrA5a6lD
         Um+9UIseXndzSA0XoxjB8hklbmqtEx6IGaN4wxUkcsD474CbPVLKPLg71y1g2y+jhUdc
         t92w==
X-Gm-Message-State: AOAM532Z6PGdRbq4KRjTxZLJzlWWHma9DeC//CZ1u3s/Phz+ckeWl910
        cMAXatzLzsREQyVjFvNjNDsHbA==
X-Google-Smtp-Source: ABdhPJwxNOtPqTI6Fas2NJ1+4Ly7ZHUkToVXGs0hWUDUDh2obA9o5Rd81KGiJjFtsLj+BFtkKU6jNw==
X-Received: by 2002:a2e:954f:0:b0:24f:4457:950d with SMTP id t15-20020a2e954f000000b0024f4457950dmr11236715ljh.35.1653245623523;
        Sun, 22 May 2022 11:53:43 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id j9-20020ac25509000000b00477a7c8a0f0sm1550135lfk.295.2022.05.22.11.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 11:53:43 -0700 (PDT)
Message-ID: <be8d4fec-9719-10ec-1299-691e498c2f7c@openvz.org>
Date:   Sun, 22 May 2022 21:53:41 +0300
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
 <1621d82a-439d-0657-2b7e-5e90c42c2087@openvz.org>
 <YonH2AqfEFYKrUV2@n2.us-central1-a.c.spheric-algebra-350919.internal>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <YonH2AqfEFYKrUV2@n2.us-central1-a.c.spheric-algebra-350919.internal>
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

On 5/22/22 08:19, Hyeonggon Yoo wrote:
> On Sun, May 22, 2022 at 07:33:08AM +0300, Vasily Averin wrote:
>> On 5/22/22 06:51, Hyeonggon Yoo wrote:
>>> If we decide to do that, it would be better to print
>>> something like:
>>> slab_flags=SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT|SLAB_STORE_USER
>>> instead of just printing 'accounted=true/false'. This patch is too
>>> specific to SLAB_ACCOUNT.
>>
>> Any extra output degrades performance.
> 
> No strong opinion but just a concern that maybe later someone want add
> something similar like 'reclaimable=true/false', 'dma=true/false', ...
> and I would prefer more general solution. (especially if we'll not
> change tracepoints after release because of backward compatibility)

I would like to quote Steven Rostedt:
https://lore.kernel.org/all/20220515180640.0ae2ead5@gandalf.local.home/
"
> Trace events are not ABI, but if we don't have a strong reason to break it,
> I'd preserve the old order.

Ideally everyone should be using libtraceevent which will parse the format
file for the needed entries.

Nothing (important) should be parsing the raw ascii from the trace files.
It's slow and unreliable. The raw format (trace_pipe_raw) files, along with
libtraceevent will handle fining the fields you are looking for, even if
the fields move around (internally or externally).

Then there's trace-cruncher (a python script that uses libtracefs and
libtraceevent) that will work too.

  https://github.com/vmware/trace-cruncher
"

Thank you,
	Vasily Averin
