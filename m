Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976915703BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiGKNCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiGKNCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:02:17 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEB8381
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:02:16 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so8241185pjn.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sNUrWHrAAnB0j3nTetyvUVqDZQCKpFVkJUaB/PUVIXA=;
        b=WylTLwO3gfPLZe2ibCn+qIlDgM5XZebeAy4gJNRHJO1JPze7u1lxQEkJ1sVhqHycSj
         eJ3r9ude7bH7RcTreuJXL/YDiBXkqb8ANFgWSuZhuuGXwaGitMLdIMjf/MJ4EcMoZm2M
         6Zr07Vo2hOMWfkKcAIVCYLmMfNiB3/AxiV+VnOHbJBC7igw6K7Kda3iZp5ybrCycYOTR
         arB42GG3tCTmlPCLOm9Ydry7MCOWXVZDTmsvDnTcB10np+0Cl+gIrHgYJtSJrsUqmies
         R6r5lFsZ+L2VAcQvMPRGrSEfpFpTRVtnTelGXEjBys5yRdgWYL14uIlKVxUPaaufIB6H
         +VDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sNUrWHrAAnB0j3nTetyvUVqDZQCKpFVkJUaB/PUVIXA=;
        b=0Ge+9NsWMxk03rwWge/T1qtjvF3Dk4mRvQ/XGc8Nz26OdQbzImTxsq/xNRpHmeUP4T
         92GBh1udvFRtsTUIEkC7EtiontkYeMRNLTSEZlAj9SJ9ShnXgD4/A3CMsqpVk/NSJC7N
         FKFgdYNSk2gtHby/TEjJMgzlO8rpbrKcyQxHn3WtsW+FOJ7twVLmEVHOwuQ0zT26aNgS
         OaOz2HvvywRDK+FwTNwDVr9U0fZmtgpJQfxEb9Bxa31WsmXbRdoF3dsFBW0rFjXMax7o
         zBa0U0t51NHg3v7hrGnkG8ULDM14wS4TBysKLw8OjD5CxPN+byNJ6MYgy6ucboBKVWUA
         bmVQ==
X-Gm-Message-State: AJIora8wulduwffkhFuqYZYMOg9WX5EczP6wMcECbBIkAUhGe3Hzed3G
        GUhO4LLEJKWcRKwjZrTf+JdK6Q==
X-Google-Smtp-Source: AGRyM1ttKbjYYaLG+cB+EGTS4bK5wleQtXMFBYZr82E0wWs7DhItvXsrgeykHhvbO679pAXCxIPXsg==
X-Received: by 2002:a17:902:cf4a:b0:16c:1b21:a3ae with SMTP id e10-20020a170902cf4a00b0016c1b21a3aemr19129193plg.38.1657544536274;
        Mon, 11 Jul 2022 06:02:16 -0700 (PDT)
Received: from [10.255.242.206] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090a46cd00b001ef7c7564fdsm6944771pjg.21.2022.07.11.06.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 06:02:15 -0700 (PDT)
Message-ID: <a41b3436-6875-d3aa-a110-6c438c97126e@bytedance.com>
Date:   Mon, 11 Jul 2022 21:02:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
Subject: Re: [External] Re: [PATCH 3/8] sched/fair: remove redundant
 cpu_cgrp_subsys->fork()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20220709151353.32883-1-zhouchengming@bytedance.com>
 <20220709151353.32883-4-zhouchengming@bytedance.com>
 <YsvSpyrJxNv7jsQz@hirez.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YsvSpyrJxNv7jsQz@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/11 15:35, Peter Zijlstra wrote:
> On Sat, Jul 09, 2022 at 11:13:48PM +0800, Chengming Zhou wrote:
>> We use cpu_cgrp_subsys->fork() to set task group for the new fair task
>> in cgroup_post_fork().
>>
>> Since commit b1e8206582f9 ("sched: Fix yet more sched_fork() races")
>> has already set task group for the new fair task in sched_cgroup_fork(),
>> so cpu_cgrp_subsys->fork() can be removed.
>>
>>   cgroup_can_fork()	--> pin parent's sched_task_group
>>   sched_cgroup_fork()
>>     __set_task_cpu	--> set task group
>>   cgroup_post_fork()
>>     ss->fork() := cpu_cgroup_fork()	--> set again
>>
>> After this patch's change, task_change_group_fair() only need to
>> care about task cgroup migration, make the code much simplier.
> 
> This:
> 
>> This patch also move the task se depth setting to set_task_rq(), which
>> will set correct depth for the new task se in sched_cgroup_fork().
>>
>> The se depth setting in attach_entity_cfs_rq() is removed since
>> set_task_rq() is a better place to do this when task moves across
>> CPUs/groups.
> 
> really should have been it's own patch. And this actually scares me. Did
> you test with priority inheritance bumping the task to FIFO while things
> change?
> 
> This has nothing to do with fork().

Ok, will put this in another patch, so this patch still need this line:

  p->se.depth = tg->se[cpu] ? tg->se[cpu]->depth + 1 : 0;

in set_task_rq() to set depth for new forked task.


I didn't test with "priority inheritance bumping the task to FIFO" case,
do you mean the rt_mutex_setprio() bump a fair task to FIFO?

Sorry, I don't get how removing depth setting in attach_entity_cfs_rq()
affect that. Could you explain more so I can test it?

Thanks.

