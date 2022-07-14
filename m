Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FF6574E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239623AbiGNNDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238865AbiGNND1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:03:27 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32965B7A1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:03:26 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id r1so345060plo.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BaF8VoXVmChgmMT7zGBurZmaZgWy/jh668WwPwroZXs=;
        b=fqI3p2GSF3hGG+S/8JDx+BkFUsdIs2AzfPLyHUhJWiL1EWrWbBiRV95n10HTD9yE/6
         YcqJ897hOLuR6nEF/iQDBdmFX90oFCj0tWfpb8c9EQ5IRdHkGjqB7gKE7WznIIvqGSVJ
         K+FuPZkhm9Ezv1sTRgMVdiHlduA+vOWndSTZE8fdIf3ZnmffuJGusESvSqMcgDHM7TAf
         XYZoz675xhOh+KmCkv+l+4wC2ea197F9XHJuCieWplBPCx4Kp9zlflnfGTKhjEk4p2lS
         XA7hiY2l7PeRNKFgMxwZfdavWNOTeGR0tza/fQNyLXfpoQBydIO0Kq4l7+5zdKGbr6qR
         xgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BaF8VoXVmChgmMT7zGBurZmaZgWy/jh668WwPwroZXs=;
        b=BmlsFGmehKVZ6jYUnGb0Ei2toNwHBXqDJuTNIihat98UX8dYz3QHa7+bWfKf/+3qB2
         QCgWFOxU2SGMAGOusBV1rj0WxxixoM/Jhwqvjufrqs//3pQJpTslsuMD2XlbKf79mP8T
         MiE0PF9l0LC3VV26Qpn7sGqtWsj93TaAcsBiwE7XIu+I+oFFvdMhyMUGtBqL9wJusR2K
         ifU7LH1Pcj2xXMD6IuhiLgaIpCTgpQxyNHkDN09Bo32Mh5MAFUQc6lTIzCe2OmvSJGLp
         pQkacKkWYBKOjlGhc3v0pzek8BWDMTA9QT20nJFoxEJb+Ax1UzYNAl/vl7ON/tlcHir3
         QLxA==
X-Gm-Message-State: AJIora8m+qekFuI/uUBaZGShYAMlDzrpAU+eMlAsLxhxAOdd5jzJmFv2
        qg/bIABvmEqhQ9+uuI/L/Ruqvw==
X-Google-Smtp-Source: AGRyM1t2x8nf4ZkXYMJf2RHMcdrthOmsJWoCVfy92ehzX48IJ5E2l4igFKtTFzT7jbunIlodqGkXnA==
X-Received: by 2002:a17:902:b7c9:b0:16c:354:a029 with SMTP id v9-20020a170902b7c900b0016c0354a029mr8486049plz.58.1657803806078;
        Thu, 14 Jul 2022 06:03:26 -0700 (PDT)
Received: from [10.255.242.206] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id c7-20020a17090a020700b001ef59378951sm3599063pjc.13.2022.07.14.06.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 06:03:25 -0700 (PDT)
Message-ID: <d020fb8d-ed73-56c7-bf10-d13b3617bfd0@bytedance.com>
Date:   Thu, 14 Jul 2022 21:03:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
Subject: Re: [External] Re: [PATCH v2 03/10] sched/fair: maintain task se
 depth in set_task_rq()
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
 <20220713040430.25778-4-zhouchengming@bytedance.com>
 <8025988d-7d1d-0b4a-6eed-8b3698bc9bad@arm.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <8025988d-7d1d-0b4a-6eed-8b3698bc9bad@arm.com>
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

On 2022/7/14 20:30, Dietmar Eggemann wrote:
> On 13/07/2022 06:04, Chengming Zhou wrote:
>> Previously we only maintain task se depth in task_move_group_fair(),
>> if a !fair task change task group, its se depth will not be updated,
>> so commit eb7a59b2c888 ("sched/fair: Reset se-depth when task switched to FAIR")
>> fix the problem by updating se depth in switched_to_fair() too.
> 
> Maybe it's worth mentioning how the se.depth setting from
> task_move_group_fair() and switched_to_fair() went into
> attach_task_cfs_rq() with commit daa59407b558 ("sched/fair: Unify
> switched_{from,to}_fair() and task_move_group_fair()"}  and further into
> attach_entity_cfs_rq() with commit df217913e72e ("sched/fair: Factorize
> attach/detach entity").
>

Good point, I will add this part in the next version.

Thanks for your review!

>> This patch move task se depth maintainence to set_task_rq(), which will be
>> called when CPU/cgroup change, so its depth will always be correct.
>>
>> This patch is preparation for the next patch.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
>> ---
>>  kernel/sched/fair.c  | 8 --------
>>  kernel/sched/sched.h | 1 +
>>  2 files changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 2a3e12ead144..bf595b622656 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -11539,14 +11539,6 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
>>  {
>>  	struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>  
>> -#ifdef CONFIG_FAIR_GROUP_SCHED
>> -	/*
>> -	 * Since the real-depth could have been changed (only FAIR
>> -	 * class maintain depth value), reset depth properly.
>> -	 */
>> -	se->depth = se->parent ? se->parent->depth + 1 : 0;
>> -#endif
>> -
>>  	/* Synchronize entity with its cfs_rq */
>>  	update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
>>  	attach_entity_load_avg(cfs_rq, se);
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index aad7f5ee9666..8cc3eb7b86cd 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -1940,6 +1940,7 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
>>  	set_task_rq_fair(&p->se, p->se.cfs_rq, tg->cfs_rq[cpu]);
>>  	p->se.cfs_rq = tg->cfs_rq[cpu];
>>  	p->se.parent = tg->se[cpu];
>> +	p->se.depth = tg->se[cpu] ? tg->se[cpu]->depth + 1 : 0;
>>  #endif
>>  
>>  #ifdef CONFIG_RT_GROUP_SCHED
> 
