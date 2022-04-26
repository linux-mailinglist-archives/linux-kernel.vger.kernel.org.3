Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B9750F34B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344442AbiDZIEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344439AbiDZIE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:04:28 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1A62B276
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:01:22 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bg9so15435681pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=CpbYiZTHnwewn5sjBjCJlKHhBG8O2Ahjo4oP3supZQY=;
        b=z+Ln5SsHrTF76ON2n9YTuZV7Cm0HZEgui1C8BpK898e7rRAKZSTOlA3nEq1/czEvpp
         iyMaLNrtV/uX1dW6tz5WhKIltKLWirG52x2m/a5YIuP+0HBFDoMkjCXPJtLoFGYg9XBT
         wCttC6k/FqspReFX6gwagI817Zoudedv/TlOfSpjRpzqORjafBNUz4zd9+9NWsoqirZ5
         rZdh/5XWf0u98mtLQZwE9UN0MH2qGB0jwsonuGnFzKGk/nuEn3DaX2AHasLcj2NtiRXV
         CUbVTDhxLuUwQW94rCjIG8/EvHKum1L6U5etKL84d+7meHR9MMGfk6MUXwVJ+AuNP+sV
         g7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CpbYiZTHnwewn5sjBjCJlKHhBG8O2Ahjo4oP3supZQY=;
        b=ZNLGESwFeAiVpT6WcF3a1dRqOgtuzse8Grn5ystGbw87O9calIyTYPeResWjP0cWzp
         2szbcMMl5+X0wLkFDIOhUvVZdsxRwsuBSVEOFnvsrQFsNXJo6onKr7C7/2ebxliWDT/k
         6qlEbjIUFxi8MDTdFHfyQJo+Iq+ctIQ4QdjgmayBRigwAF2IQ955u75QuSlvsa+EOgR6
         AM0tDpAmIC5RSFrMNzh3hMnCIS4GKlp5UmghtaeqP5s70BFSKo5pMxrw8coWwiOTGDoi
         wMYkBYxlC9QfMc2rqXfRhbVyDEqi1bNjgRh7HaFoXlXdh2Id/1yA86s8rjGb7juYqghP
         TJxA==
X-Gm-Message-State: AOAM530GRi3+GNxvDzHNgGt0yFyu0VnhQVaipsHvfbzfL8FM8bQO1yZN
        YiXPkekjC1MNScMajteZwQ/QRk6eVwmRgA==
X-Google-Smtp-Source: ABdhPJzwiD0aEmzQ0IkwdSSQ727/jdobhPiu04xMHVi1cox3sOSOu60togsoamWf4Fa/rm2vPckKog==
X-Received: by 2002:a63:8ac1:0:b0:3ab:199:cbdf with SMTP id y184-20020a638ac1000000b003ab0199cbdfmr11802830pgd.466.1650960081685;
        Tue, 26 Apr 2022 01:01:21 -0700 (PDT)
Received: from ?IPV6:240e:390:e6b:6b80:8cf7:55d1:6061:4a81? ([240e:390:e6b:6b80:8cf7:55d1:6061:4a81])
        by smtp.gmail.com with ESMTPSA id b17-20020a056a000a9100b004e1b7cdb8fdsm15496440pfl.70.2022.04.26.01.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 01:01:21 -0700 (PDT)
Message-ID: <10afde23-7ef9-1733-f2ce-a697fcab24f2@bytedance.com>
Date:   Tue, 26 Apr 2022 16:01:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [External] Re: [PATCH v2 2/2] sched/dl: Remove some comments and
 adjust code in push_dl_task
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220422090944.52618-1-jiahao.os@bytedance.com>
 <20220422090944.52618-3-jiahao.os@bytedance.com>
 <cfab5ffc-af96-8368-0aae-927a6be65472@arm.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <cfab5ffc-af96-8368-0aae-927a6be65472@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/26 Dietmar Eggemann wrote:
> On 22/04/2022 11:09, Hao Jia wrote:
> 
> Nitpick: I would change the message slightly into something like:
> 
> sched/deadline: Remove superfluous rq clock update in push_dl_task()
> 

I will do it in patch v3.
Thanks.


>> The change to call update_rq_clock() before activate_task()
>> commit 840d719604b0 ("sched/deadline: Update rq_clock of later_rq
>> when pushing a task") is no longer needed since commit f4904815f97a
>> ("sched/deadline: Fix double accounting of rq/running bw in push & pull")
>> removed the add_running_bw() before the activate_task().
>>
>> So we remove some comments that are no longer needed and update
>> rq clock in activate_task().
>>
>> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
>> ---
>>   kernel/sched/deadline.c | 8 +-------
>>   1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index fb4255ae0b2c..8eb694ed7ac1 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -2319,13 +2319,7 @@ static int push_dl_task(struct rq *rq)
>>   
>>   	deactivate_task(rq, next_task, 0);
>>   	set_task_cpu(next_task, later_rq->cpu);
>> -
>> -	/*
>> -	 * Update the later_rq clock here, because the clock is used
>> -	 * by the cpufreq_update_util() inside __add_running_bw().
>> -	 */
>> -	update_rq_clock(later_rq);
>> -	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
>> +	activate_task(later_rq, next_task, 0);
>>   	ret = 1;
>>   
>>   	resched_curr(later_rq);
> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
