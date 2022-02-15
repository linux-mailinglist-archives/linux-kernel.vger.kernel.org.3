Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE1C4B6BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbiBOMX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:23:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiBOMX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:23:28 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757C965797
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:23:18 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c4so13264984pfl.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/vGpsroO/5ynMmmPCxpzvU3BbrtrxMXLbcoJ2oxfZUw=;
        b=jvDpzCyNE1qA7kCpxOuQgmJ8nXakFWB+xDTaQ5qLriuUqdBIt2FlHGSYZGPR+09kpj
         CbRwtmlK7/zrJgiQsBe9kGTUHBptLDFkmLdU87MSmoguriPt9Q4MkUwTuHJhI8LhrRdY
         h1uqPe0AogX7f5/xorm+U+/y1rjHpmDW0RZf3h8oYTmZO4MILPdMZ1ofvZXg4QqNYMLx
         m75GlFiQK6SeoHcvbxIniXlZ5VWGvFcy7VGvyIRXkm5le/JLwY2TvImsLGFfIKex6E5j
         9TsSnkN7sMT9wqIkNi/0OIpkA04yOXhbfrHw88YnwXKnFfUG7gPcW13Jli1orQvey3BL
         kL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/vGpsroO/5ynMmmPCxpzvU3BbrtrxMXLbcoJ2oxfZUw=;
        b=wtsPshysvQ79iWC8/nsDyetzVzmaayEqd2QWWQ9ol9S6fNEyCxXFgNeC1c3vM4kfQR
         Ya8zi4ANEwcIygTqd5bxT01K23m/6c2MgWuz97VVxnZIX3qZPvzFQ+mGDSI74znI2/Yg
         B7aCM7eMKGFK82zEPnVq+i6R/A5WNvxJBJTU+1CO7T03gu8XdAGufxbn/b6syeDDG7bt
         ieSecS9adY+NufBRhW36AwAIUzxH4I4yBqOprH/qBTMQQ5rkNaVD9fAU8HRg+kFarcn0
         1/XQu5S7Jwhm04WnCUZL1rIUX0pKqyn7HihBqZK99+KC/JlQGFHTM74c49V162UWM+RM
         hgKQ==
X-Gm-Message-State: AOAM530ROa1H7tH/IEHWtQ8VyEbJTqPmynUWYdAC/m9kKJ+IX2xSlXqF
        eH7OYEhH9B1L2nryAvvBCzJQng==
X-Google-Smtp-Source: ABdhPJzzNNNv3vukYQ33azaYf4qWPQyjIeFOE7w8XiLVxQT74HFsjInNJoyr/SE9wfwwtLgyDzl/lg==
X-Received: by 2002:a63:87c3:: with SMTP id i186mr3310832pge.545.1644927797995;
        Tue, 15 Feb 2022 04:23:17 -0800 (PST)
Received: from [10.255.13.118] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id c3sm9459607pfd.129.2022.02.15.04.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 04:23:17 -0800 (PST)
Message-ID: <86bbb33e-1e9b-70f9-237c-d0c02537380c@bytedance.com>
Date:   Tue, 15 Feb 2022 20:23:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [Phishing Risk] [External] Re: [PATCH] sched/cpuacct: fix charge
 percpu cpuusage
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc:     arbn@yandex-team.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, Minye Zhu <zhuminye@bytedance.com>
References: <20220213120118.93471-1-zhouchengming@bytedance.com>
 <YgoqPT67g2NcV/eH@hirez.programming.kicks-ass.net>
 <YgqmE9Id35av9NZk@slm.duckdns.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YgqmE9Id35av9NZk@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/15 2:57 上午, Tejun Heo wrote:
> On Mon, Feb 14, 2022 at 11:09:01AM +0100, Peter Zijlstra wrote:
>> --- a/kernel/sched/cpuacct.c
>> +++ b/kernel/sched/cpuacct.c
>> @@ -334,15 +334,13 @@ static struct cftype files[] = {
>>   */
>>  void cpuacct_charge(struct task_struct *tsk, u64 cputime)
>>  {
>> -	struct cpuacct *ca;
>>  	unsigned int cpu = task_cpu(tsk);
>> +	struct cpuacct *ca;
>>  
>> -	rcu_read_lock();
>> +	lockdep_assert_rq_held(cpu_rq(cpu));
>>  
>>  	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
>>  		*per_cpu_ptr(ca->cpuusage, cpu) += cputime;
>> -
>> -	rcu_read_unlock();
> 
> And probably expand the same to cgroup_account_cputime[_field]() too.
> 
> Thanks.
> 

Good suggestion, will do.

Thanks.
