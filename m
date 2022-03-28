Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80604E98AE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243484AbiC1Nv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243479AbiC1Nv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:51:57 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E749851E40
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:50:15 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so10648147pjk.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fYLS3FUqU6ElSyyxJvju10Ed/M1yqpvYoJBkWCWwU+Y=;
        b=ZWFK5+xwGXw7oPM/iGfRRRCNaF2jI3AzpFlQtaV6DU+HkIy6Jf9sFeftvS/3gSabeG
         Z90f9L8K4jXmhZ3sNoNXya0wqmFmH6o8HAvRLix+pjySIYr5Lp/OBY7NxjjsiTFzCFe1
         E3yuaSqnw0y2xw9oY5KM9qIPAPn3rCVsiTQWfSwN4nO/fzeISvih74bWczQckDwm7fjU
         ZMOrrBMt+v5LAGstZm+z/6ldoo61Vdi7znyMfei7tdxFViLYpJgDFRSiG7IrTU4r9bEH
         kyuNkqh9B/f3JeE6kS761ACcZqiQFYvwW+qk6ObiG9fTQg5wgAv+kTzSx4y3VQ1RcJEY
         m6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fYLS3FUqU6ElSyyxJvju10Ed/M1yqpvYoJBkWCWwU+Y=;
        b=fKMsOaeQWfXJp6TetIjgDQRaNdsovK0suUX64BrL3kBkRmgb1synSNVmZmIrH1ruXb
         DfXmOxKNf6E4TcV7WkvfBWHFjawSYGjuWpd2HGeRbVE4wfBw9jc9cNJqSQL+1ObNI1Xu
         +65QYIjRZXUugv6paIwbQW2h4hQMcfxPZZ7HyDs/db5tf/11qgTGtXVky6+f9GZa4wHM
         ilb95I1A3EJlEGHe/iSj+927G7nGmYegeSyI6TD39/NJSgpkykfGT2B4h4HMx2Up0hvj
         8G6+zxG1liASzWFJmIQKjfsDjSZJzVJFuadBItKB4okN2o9AaiYTk0Ng3qTgcUhk1JcS
         lNYA==
X-Gm-Message-State: AOAM5336meA0MOI9zahKsa96yk5lh51G62hkQZ1k/rav+EuCWtwsXDLV
        kcLH1SKOmfOQ2Z/H5VbjM2i7Bg==
X-Google-Smtp-Source: ABdhPJyWR7UUgXnqyeNQTWo5J4/+xW5sMz6Rk/7vNAQSxhZG8Uz1PRs+zmE6Y7ocgIGh8R9G+b1FEQ==
X-Received: by 2002:a17:90a:5291:b0:1bb:ef4d:947d with SMTP id w17-20020a17090a529100b001bbef4d947dmr41339439pjh.243.1648475415426;
        Mon, 28 Mar 2022 06:50:15 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e6c:aaa0:b49b:a46e:8f1f:6bcd? ([2409:8a28:e6c:aaa0:b49b:a46e:8f1f:6bcd])
        by smtp.gmail.com with ESMTPSA id l2-20020a056a0016c200b004f7e3181a41sm17091631pfc.98.2022.03.28.06.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 06:50:15 -0700 (PDT)
Message-ID: <c0465b27-328a-1288-fb50-d4c6321c8b4d@bytedance.com>
Date:   Mon, 28 Mar 2022 21:50:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] Re: [PATCH] sched/fair: fix broken bandwidth control
 with nohz_full
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
References: <20220328110751.39987-1-zhouchengming@bytedance.com>
 <20220328132047.GD8939@worktop.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220328132047.GD8939@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/28 21:20, Peter Zijlstra wrote:
> On Mon, Mar 28, 2022 at 07:07:51PM +0800, Chengming Zhou wrote:
>> With nohz_full enabled on cpu, the scheduler_tick() will be stopped
>> when only one CFS task left on rq.
>>
>> scheduler_tick()
>>   task_tick_fair()
>>     entity_tick()
>>       update_curr()
>>         account_cfs_rq_runtime(cfs_rq, delta_exec) --> stopped
>>
>> So that running task can't account its runtime periodically, but
>> the cfs_bandwidth hrtimer still __refill_cfs_bandwidth_runtime()
>> periodically. Later in one period, the task would account very
>> big delta_exec, which cause the cfs_rq to be throttled for a
>> long time.
>>
>> There are two solutions for the problem, the first is that we
>> can check in sched_can_stop_tick() if current task's cfs_rq
>> have runtime_enabled, in which case we don't stop tick. But
>> it will make nohz_full almost useless in cloud environment
>> that every container has the cpu bandwidth control setting.
> 
> How is NOHZ_FULL useful in that environment to begin with? If you set
> bandwidth crap, the expectation is that there is overcommit, which more
> or less assumes lots of scheduling, presumably VMs or somesuch crud.
> 
> So how does NOHZ_FULL make sense?

Yes, we have scheduled some VMs in cgroups on the host, which
enabled NOHZ_FULL to reduce the interference of tick to vcpu task
if it's the only task running on cpu.

This problem will however throttle it wrongly, even if it hasn't
used up its quota.

Do you suggest that we shouldn't stop tick when the current task's
cfs_rq has runtime_enabled ?

Thanks.

