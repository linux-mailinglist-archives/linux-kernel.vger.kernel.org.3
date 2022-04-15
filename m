Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D15502477
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 07:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349584AbiDOFot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 01:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349800AbiDOFol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:44:41 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17267120AF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 22:42:14 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 32so6579143pgl.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 22:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+r7Pxwn1lhshesrSBdEuBnKl7sA/M9V24IMSo+lqyuw=;
        b=MGww/gDb9s7W1umnuBWKqB4V4+glupxSJF3gVc0k7X8TV27YbVbV2gBsdhnZuv5Q/C
         DFoI0+qSxWL+ynW2xux9HdWSWH6/Uk82O7dGtVYzRnpeCa972JYm7lXZc+fSwPW7/HfK
         td9dqaRHiePOv8x9cXCOmEoN2PC4EeqofwQ/XS9BtyFIh2pKXJgsYk7R6OyTUWi3SQsl
         4Nw9Ut2Q/yHt2eWTt6Ow+KYb9f5M+PfQ/qPrfHcmG9DaxHPmB1QcK72SzposPcL61QB9
         rthss5Y86HpQjxp36kK1SlZyrUA6iJTztFJtH8kF5X0ACabKfwCwjuIUo5nflGudcLUO
         Vx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+r7Pxwn1lhshesrSBdEuBnKl7sA/M9V24IMSo+lqyuw=;
        b=s3gDiX2c9r8L5Nuue8jKpwd+mPfIobLggLe53V5JZeteZZZraBEH7ItTVJS5oDHBFV
         f2N3b1+fzA9NlsW9TXgXzc/6i7FkbMK0Lj7VngbpnQVgpbOy6GRSQ3nY9Zij+h+6OMMe
         i3TFUEiSnHN0WDGYmU4+X7vTDVu8JC/ZJTLfEkVXHF/qIvjZJGthETgPsgICSm1ubUnZ
         GdWePfNBIRHSA4XVfSLoWWuo5EkPOWwGj7T259e5f2eXvGkMeXAr8U54W820UXkqGWn7
         CJRh3YypaOUL9Zd7n+u6k+S/hGtLd6vNeq9eeYJE3wCAmWBZH1FYgL6x3lynaqF6SaA3
         SUdw==
X-Gm-Message-State: AOAM532BKfhb8ncMod74kXmxDYNygBgKaqMw/xp5ywLFPetDDel5XFnC
        CdMzxU6ZwVLcCcxbBldRERqBUA==
X-Google-Smtp-Source: ABdhPJxg8+7988rVMUp2mXrWPHUbJPNRp9N7+lgMagFFgcE9xzT7YhfrXC6OJql9+MdJnPBGs1oBew==
X-Received: by 2002:a63:535c:0:b0:39d:353e:64d5 with SMTP id t28-20020a63535c000000b0039d353e64d5mr4973972pgl.355.1650001333459;
        Thu, 14 Apr 2022 22:42:13 -0700 (PDT)
Received: from [10.254.148.45] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id hk16-20020a17090b225000b001ca00b81a95sm7797071pjb.22.2022.04.14.22.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 22:42:12 -0700 (PDT)
Message-ID: <14737e0f-3d33-125b-57cc-966de00430be@bytedance.com>
Date:   Fri, 15 Apr 2022 13:42:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [External] Re: [PATCH] sched/fair: update tg->load_avg and
 se->load in throttle_cfs_rq()
Content-Language: en-US
To:     Benjamin Segall <bsegall@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com, zhengqi.arch@bytedance.com
References: <20220413041627.41521-1-zhouchengming@bytedance.com>
 <xm26h76wvql9.fsf@bsegall-linux.svl.corp.google.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <xm26h76wvql9.fsf@bsegall-linux.svl.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/14 01:30, Benjamin Segall wrote:
> Chengming Zhou <zhouchengming@bytedance.com> writes:
> 
>> We use update_load_avg(cfs_rq, se, 0) in throttle_cfs_rq(), so the
>> cfs_rq->tg_load_avg_contrib and task_group->load_avg won't be updated
>> even when the cfs_rq's load_avg has changed.
>>
>> And we also don't call update_cfs_group(se), so the se->load won't
>> be updated too.
>>
>> Change to use update_load_avg(cfs_rq, se, UPDATE_TG) and add
>> update_cfs_group(se) in throttle_cfs_rq(), like we do in
>> dequeue_task_fair().
> 
> Hmm, this does look more correct; Vincent, was having this not do
> UPDATE_TG deliberate, or an accident that we all missed when checking?
> 
> It looks like the unthrottle_cfs_rq side got UPDATE_TG added later in
> the two-loops pass, but not the throttle_cfs_rq side.

Yes, UPDATE_TG was added in unthrottle_cfs_rq() in commit 39f23ce07b93
("sched/fair: Fix unthrottle_cfs_rq() for leaf_cfs_rq list").

> 
> Also unthrottle_cfs_rq I'm guessing could still use update_cfs_group(se)

It looks like we should also add update_cfs_group(se) in unthrottle_cfs_rq().

Thanks.

> 
> 
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  kernel/sched/fair.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d4bd299d67ab..b37dc1db7be7 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4936,8 +4936,9 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
>>  		if (!se->on_rq)
>>  			goto done;
>>  
>> -		update_load_avg(qcfs_rq, se, 0);
>> +		update_load_avg(qcfs_rq, se, UPDATE_TG);
>>  		se_update_runnable(se);
>> +		update_cfs_group(se);
>>  
>>  		if (cfs_rq_is_idle(group_cfs_rq(se)))
>>  			idle_task_delta = cfs_rq->h_nr_running;
