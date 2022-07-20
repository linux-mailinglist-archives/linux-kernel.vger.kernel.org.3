Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544C157B7AB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbiGTNoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbiGTNoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:44:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4A754064
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:44:06 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id n4-20020a17090a73c400b001f1e87432c2so2228229pjk.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=orSFD61kCSqrKX+ne2eEEd+QMSiGdPtiJq0hhV2qIQM=;
        b=PR9bGri+dqR7nIgVm4Bo5fi40C7WJ5qsV/WYePf6lmpHXhKPdx1PCadPOUOX2P64J/
         TlE/jZyFJizffx1MES6V6oYVKrBR2C7T8i4n493ld254G9BI73zImCEY7aRRoMzQnB5g
         uhY2L8lL4fP4Lu4XUNxGynA5LFK3kJjl8LIc+jXSkj2/LYL3Fhy13VEluwmmMsREjY5E
         57KpxJTPPVW7qcU0JJ+JxFg6cLCGAUHdGFL3zOgiG2Ksd5eYXvUobOickjPUyrBR3H4o
         TankRICj74IRGlwllN2kb1lEk0fMJWPG/z8OlNP926Yd7uQg4CO7xrYi7xBoCWHxOkR0
         2akw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=orSFD61kCSqrKX+ne2eEEd+QMSiGdPtiJq0hhV2qIQM=;
        b=DHz+kcscgGzmnxCZLkFQAKXMZT0wy6yZfno27ThNVFRccCY6JPHn81sXixBnDhxkGZ
         BHkduImvs1G1Hsv/wS3Fhl7yeAkCZj64AxH6n4q3PpEWBkQBOLP4nSpcF13u90SiwPPJ
         LSb9WrYekktK/TMPN26iEAlo8+4deGZDN+IIAHH3GaRQXzNEeYTE25pLaCONE4+CJZ8Q
         tA7bU3vYIffkh03/hl60RM4copeUq/IYIqen0PIG9L0pQj8EvT1xSVVm2F2BZquaVXLL
         X6L0qMBsiOye9MfsyJsLJLWX/B6gIo4dqQ6uLUxpkWbdqUce4/DLclSOSJ3AIcksH9c6
         dglQ==
X-Gm-Message-State: AJIora+zdHdpgJYiwnulcC1F0+qPAt4uCMSzrOI1sxHbXvDLacls8rEB
        xUQ1tfws5ydxMztlj9Z0Yda23A==
X-Google-Smtp-Source: AGRyM1vpTrxNaUjas034B+wlq+kHydW7weSjsi7LRMDPNlFRzF75m0jS1AAxomT1GiEZt1T7pAsB5w==
X-Received: by 2002:a17:90b:1917:b0:1f2:1e2e:83fb with SMTP id mp23-20020a17090b191700b001f21e2e83fbmr3405788pjb.227.1658324646087;
        Wed, 20 Jul 2022 06:44:06 -0700 (PDT)
Received: from [10.4.100.137] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903244500b0016bef6f6903sm13986043pls.72.2022.07.20.06.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 06:44:05 -0700 (PDT)
Message-ID: <952fc252-30e1-3629-42c4-98a55ada12f9@bytedance.com>
Date:   Wed, 20 Jul 2022 21:43:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
Subject: Re: [External] Re: [PATCH v2 07/10] sched/fair: use update_load_avg()
 to attach/detach entity load_avg
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
 <20220713040430.25778-8-zhouchengming@bytedance.com>
 <e838ac28-f68e-2282-94d5-616ea3bdf8d0@arm.com>
 <88062fb6-e2fe-cf4e-10b5-7694c4d30941@bytedance.com>
 <17c9af40-bf53-be3c-c678-159a8ab8964a@arm.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <17c9af40-bf53-be3c-c678-159a8ab8964a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/19 23:02, Dietmar Eggemann wrote:
> On 15/07/2022 18:21, Chengming Zhou wrote:
>> On 2022/7/15 19:18, Dietmar Eggemann wrote:
>>> On 13/07/2022 06:04, Chengming Zhou wrote:
>>>> Since update_load_avg() support DO_ATTACH and DO_DETACH now, we can
>>>> use update_load_avg() to implement attach/detach entity load_avg.
>>>>
>>>> Another advantage of using update_load_avg() is that it will check
>>>> last_update_time before attach or detach, instead of unconditional
>>>> attach/detach in the current code.
>>>>
>>>> This way can avoid some corner problematic cases of load tracking,
>>>> like twice attach problem, detach unattached NEW task problem.
>>>
>>> This explanation is somewhat hard to follow for me. Since both issues
>>> have been fixed already (you mention this further below) you're saying
>>> that with you change you don't reintroduce them?
>>
>> Sorry for this not very clear explanation.
>>
>> Yes, both issues have been fixed already, what I want to say is that bugfix
>> brings its own problem and limitation mentioned below.
>>
>> So I want to use another way to solve these problems better.
> 
> [...]
> 
>>>> These problems have been fixed in commit 7dc603c9028e
>>>> ("sched/fair: Fix PELT integrity for new tasks"), which also
>>>> bring its own problems.
>>>>
>>>> First, it add a new task state TASK_NEW and an unnessary limitation
>>>> that we would fail when change the cgroup of TASK_NEW tasks.
>>
>> This is the limitation that bugfix has brought.
>>
>> We can't change cgroup or switch to fair for task with last_update_time=0
>> if we don't have conditional detach/attach.
>>
>> So we have to:
>>
>> 1. !fair task also need to set last_update_time.
>> 2. cpu_cgroup_can_attach() have to wait for TASK_NEW to fully attached.
> 
> I see.
> 
> `cgroup_migrate_execute() -> cpu_cgroup_[can|]_attach()` has to wait for
> `wake_up_new_task() -> WRITE_ONCE(p->__state, TASK_RUNNING)`.
> 
> Just to understand this change better: IMHO, this is still the case for
> fair tasks, right?

Yes, I think so. We could delete this limitation when we have conditional
detach/attach, since nothing will be detached when last_update_time==0.

Thanks!

> 
> `wake_up_new_task() -> post_init_entity_util_avg() ->
> attach_entity_cfs_rq()` has to happen before the fair task can move
> between taskgroups in `cgroup_migrate_execute() -> cpu_cgroup_attach()
> -> sched_move_task() -> sched_change_group() -> task_change_group_fair()`.
> 
> [...]
