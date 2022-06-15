Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91BA54CB93
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344927AbiFOOmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiFOOlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:41:13 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F6531DC3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:41:12 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id h1so10565056plf.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a4yfni6tfaGxDNJuT8wNnXJnIkwyH2XJ1tMzfYT6PkQ=;
        b=SMC/jBMStIMP9El9YtSDWWKqKLx28/QNjdZcug/2DVK+A6xRXKskVJ6afSkSL3pizG
         rCjyXzE4CTGzM2ioyWANK7sINxaueTueOP3tfDVsKUx7WNZ/lL2iyExYVt/wE94EX7/M
         3s9yFtZQyXyinZL9bwcUno22IyzSFz/E4HHbhTvg/+G2IUuA6STLGdMeb0emaUsjGkQ8
         49KiZ0LU/GGzkYZOWTi8GH0g8YJZHvzivd+wyxSvK15pqKvii9Q4eXbav9NpcwhL0wHl
         LLzhYgYQcKo54Uw3wEhJC+0Iwf8MhB4/2l545lEh3fuYO5lo7vEKYj8IY8ftCzK20TC8
         1M2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a4yfni6tfaGxDNJuT8wNnXJnIkwyH2XJ1tMzfYT6PkQ=;
        b=k1tn8T7DJ7btg6tUdOwOy0rt87bIDYf1+wq4F6qdDrIcInpqQFLpz4ut19U0Xv6VsY
         Sall2l6ORWSahSD5d6YBcItoCLQfPa5mx9zoK0cV+Vxk/g9xY6lBMLJnE6ZrmGUHAnto
         SmEodvTwhnckOostuy+Cyy4rDolsFn4QC+hFdcDRGClvXYFybUljjNJ3i1QwDTcZdioz
         5ixDwyP7a76crHngrHLoW9iWPwV9nzNrb+ayWKR9p0l5X80g0+jOu1QRYtVnwOl2hOW6
         fA9sdHPXjSNwavomDQLywUv5NPv3wYsuk7HICtUzMmgejiLza9GGqekH0hK6YLvDvqhz
         GeTw==
X-Gm-Message-State: AJIora9UyMdGeG+pVo11SzDTgsvLa/6FsrCGqNzxe4fKXwLfOcwQ0d+p
        R89IfWOgyWS1XId4lvXSoQ+7ly9NayLrsA==
X-Google-Smtp-Source: AGRyM1twpOIQCygRBV32eWMk9AINb+nSzwHJiamQLsGeuW9NG8xXa+LLie7OCdTCN4L9CRF+4ykKBw==
X-Received: by 2002:a17:902:ce92:b0:167:585b:af40 with SMTP id f18-20020a170902ce9200b00167585baf40mr10251988plg.153.1655304072108;
        Wed, 15 Jun 2022 07:41:12 -0700 (PDT)
Received: from [10.4.220.81] ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902680b00b00163dc73e252sm9407994plk.151.2022.06.15.07.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 07:41:10 -0700 (PDT)
Message-ID: <afaeed75-cb46-0551-74c5-ebe29a26ba16@bytedance.com>
Date:   Wed, 15 Jun 2022 22:41:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [External] Re: [PATCH] sched/fair: update comments in
 enqueue/dequeue_entity()
Content-Language: en-US
To:     peterz@infradead.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
References: <20220601035545.82187-1-zhouchengming@bytedance.com>
 <CAKfTPtAa9efmNq29KJgV46c-ncN866UViHuhJMdUrQYyhiNtzw@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKfTPtAa9efmNq29KJgV46c-ncN866UViHuhJMdUrQYyhiNtzw@mail.gmail.com>
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

On 2022/6/3 20:08, Vincent Guittot wrote:
> On Wed, 1 Jun 2022 at 05:55, Chengming Zhou <zhouchengming@bytedance.com> wrote:
>>
>> When reading the sched_avg related code, I found the comments in
>> enqueue/dequeue_entity() are not updated with the current code.
>>
>> We don't add/subtract entity's runnable_avg from cfs_rq->runnable_avg
>> during enqueue/dequeue_entity(), those are done only for attach/detach.
>>
>> This patch updates the comments to reflect the current code working.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

Hello Peter, would you mind picking up this little patch too?

Thanks.

> 
>> ---
>>  kernel/sched/fair.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index b3371fa40548..e0cd4052e32f 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4348,7 +4348,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>>         /*
>>          * When enqueuing a sched_entity, we must:
>>          *   - Update loads to have both entity and cfs_rq synced with now.
>> -        *   - Add its load to cfs_rq->runnable_avg
>> +        *   - For group_entity, update its runnable_weight to reflect the new
>> +        *     h_nr_running of its group cfs_rq.
>>          *   - For group_entity, update its weight to reflect the new share of
>>          *     its group cfs_rq
>>          *   - Add its new weight to cfs_rq->load.weight
>> @@ -4433,7 +4434,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>>         /*
>>          * When dequeuing a sched_entity, we must:
>>          *   - Update loads to have both entity and cfs_rq synced with now.
>> -        *   - Subtract its load from the cfs_rq->runnable_avg.
>> +        *   - For group_entity, update its runnable_weight to reflect the new
>> +        *     h_nr_running of its group cfs_rq.
>>          *   - Subtract its previous weight from cfs_rq->load.weight.
>>          *   - For group entity, update its weight to reflect the new share
>>          *     of its group cfs_rq.
>> --
>> 2.36.1
>>
