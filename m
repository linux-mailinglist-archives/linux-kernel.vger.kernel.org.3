Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F33C4D0CCB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 01:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243562AbiCHAbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 19:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiCHAbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 19:31:12 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F115B12ADA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 16:30:16 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 132so14961424pga.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 16:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+b6U7xD5NsVIgrOaERyVM/BWmLRQRIumXagXORbvD2A=;
        b=0GKybrjrYL+rRx8xyqPphQy4xU43Hygpubwr9knrRnPa7t6NZ3eLX1DmPVT0sOYtV1
         OVzH/nOyojKgb5kZIPQEg6w6LtAbIHR53PtMTAnSSD7vfkREWtDNLsNdfDSHhRHCB6nR
         ab1iw5YzFfUdxQhm3XcjSJNeIayb8qQwUhJlEbgsNHF/4mpwL67RTrtt5R/CUecDi+Br
         HwOMEtpOfP8ZuTHdwAUmQaClJA/SWfMNyLySb7rKETPvf9TIyVgbzYWdlM3igRolvIMu
         Eem7fku2tG9QnG8ygVE5EpILpoYL3ydFHfPO7YKUSilNoM2PkzGP3S80J/lpgyKIcWnc
         2eKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+b6U7xD5NsVIgrOaERyVM/BWmLRQRIumXagXORbvD2A=;
        b=gdD+/scYoOTp3oeEV/8UiYIGWBlnfrPO9WFwzU0ij323Vgiq5px4Z+5rk3/0e/LwgL
         dZGmFh72uQcpK6xdWtNShbskBji08nQF+v+clTHB5EpB9Uyrdu2JPzPE7G4dBpDht1Tn
         2hc75CGARGYl5OdA7ygB9IA0Ra/KcKFpw/XZsgaa9osa976RCwUYnmK/sgb+xdslRt0k
         kVJkX+MMc9e/4MH5Mc4dMg3NOKxakwGhVKZANGFi/T4tRYvESiJq3bxqHIlaucJVHY81
         ZXFA/CrIe9FbyqQUILhEzWHOkoVHP16VWdTTRsXe9iwRNhvnKx6oZeTuV3/CzE4aQFCP
         XsUw==
X-Gm-Message-State: AOAM53346RaqhRm78stQuk2hdz2YuduPBvbff1DY4tKVwxra4lc2JAlT
        KkHkeXcezO7AaVXtSCOdDFtKag==
X-Google-Smtp-Source: ABdhPJw/7iJsmiq2YwFfj9dsu6bwiW5xWajh+0nrM2ivXA3sK9GoMhbd8KfXGrn9yFgYKnRgnn1qKg==
X-Received: by 2002:a05:6a00:1912:b0:4f6:bf89:e157 with SMTP id y18-20020a056a00191200b004f6bf89e157mr15351575pfi.20.1646699416313;
        Mon, 07 Mar 2022 16:30:16 -0800 (PST)
Received: from [10.255.253.61] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id f15-20020a056a0022cf00b004f3b99a6c43sm17265233pfj.219.2022.03.07.16.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 16:30:15 -0800 (PST)
Message-ID: <496cf920-f3e6-91d4-3dc8-a5d1b510ee5b@bytedance.com>
Date:   Tue, 8 Mar 2022 08:30:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [Phishing Risk] [External] Re: [PATCH] psi: report zeroes for CPU
 full at the system level
Content-Language: en-US
To:     Martin Steigerwald <Martin.Steigerwald@proact.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "surenb@google.com" <surenb@google.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>
References: <20220305021329.54119-1-zhouchengming@bytedance.com>
 <89d939a61f840683101542fe0da823e693ef6cc3.camel@proact.de>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <89d939a61f840683101542fe0da823e693ef6cc3.camel@proact.de>
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

On 2022/3/7 7:01 下午, Martin Steigerwald wrote:
> Am Samstag, dem 05.03.2022 um 10:13 +0800 schrieb Chengming Zhou:
>> Martin find it confusing when look at the /proc/pressure/cpu output,
>> and found no hint about that CPU "full" line in psi Documentation.
>>
>> % cat /proc/pressure/cpu
>> some avg10=0.92 avg60=0.91 avg300=0.73 total=933490489
>> full avg10=0.22 avg60=0.23 avg300=0.16 total=358783277
>>
>> The PSI_CPU_FULL state is introduced by commit e7fcd7622823
>> ("psi: Add PSI_CPU_FULL state"), which mainly for cgroup level,
>> but also counted at the system level as a side effect.
>>
>> Naturally, the FULL state doesn't exist for the CPU resource at
>> the system level. These "full" numbers can come from CPU idle
>> schedule latency. For example, t1 is the time when task wakeup
>> on an idle CPU, t2 is the time when CPU pick and switch to it.
>> The delta of (t2 - t1) will be in CPU_FULL state.
>>
>> Another case all processes can be stalled is when all cgroups
>> have been throttled at the same time, which unlikely to happen.
>>
>> Anyway, CPU_FULL metric is meaningless and confusing at the
>> system level. So this patch will report zeroes for CPU full
>> at the system level, and update psi Documentation accordingly.
>>
>> Fixes: e7fcd7622823 ("psi: Add PSI_CPU_FULL state")
>> Reported-by: Martin Steigerwald <Martin.Steigerwald@proact.de>
>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  Documentation/accounting/psi.rst |  6 +-----
>>  kernel/sched/psi.c               | 15 +++++++++------
>>  2 files changed, 10 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/accounting/psi.rst
>> b/Documentation/accounting/psi.rst
>> index 860fe651d645..7e15e37d3179 100644
>> --- a/Documentation/accounting/psi.rst
>> +++ b/Documentation/accounting/psi.rst
>> @@ -37,11 +37,7 @@ Pressure interface
>>  Pressure information for each resource is exported through the
>>  respective file in /proc/pressure/ -- cpu, memory, and io.
>>  
>> -The format for CPU is as such::
>> -
>> -       some avg10=0.00 avg60=0.00 avg300=0.00 total=0
>> -
>> -and for memory and IO::
>> +The format is as such::
>>  
>>         some avg10=0.00 avg60=0.00 avg300=0.00 total=0
>>         full avg10=0.00 avg60=0.00 avg300=0.00 total=0
> 
> This leaves unexplained why there is a CPU full line in the
> documentation. And I bet someone – not me this time – could wonder why
> it is always zero.
> 
> I recommend to either remove the CPU full line completely and hope to
> get away with it just having been there for one, maybe two kernel
> versions (5.17 and maybe 5.18) or to put a note in documentation:
> 
> "CPU full on the system level is undefined, but has been reported in
> 5.17, so it is set to zero for backwards compatibility."

Ok, it's better to leave a note there, if someone is curious about the
zeros in CPU full line. Previous patch v1 does remove the CPU full line
completely, but it may break some userspace parsers.

Thanks.

> 
>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>> index e14358178849..97fd85c5143c 100644
>> --- a/kernel/sched/psi.c
>> +++ b/kernel/sched/psi.c
>> @@ -1062,14 +1062,17 @@ int psi_show(struct seq_file *m, struct
>> psi_group *group, enum psi_res res)
>>         mutex_unlock(&group->avgs_lock);
>>  
>>         for (full = 0; full < 2; full++) {
>> -               unsigned long avg[3];
>> -               u64 total;
>> +               unsigned long avg[3] = { 0, };
>> +               u64 total = 0;
>>                 int w;
>>  
>> -               for (w = 0; w < 3; w++)
>> -                       avg[w] = group->avg[res * 2 + full][w];
>> -               total = div_u64(group->total[PSI_AVGS][res * 2 +
>> full],
>> -                               NSEC_PER_USEC);
>> +               /* CPU FULL is undefined at the system level */
>> +               if (!(group == &psi_system && res == PSI_CPU && full))
>> {
>> +                       for (w = 0; w < 3; w++)
>> +                               avg[w] = group->avg[res * 2 +
>> full][w];
>> +                       total = div_u64(group->total[PSI_AVGS][res * 2
>> + full],
>> +                                       NSEC_PER_USEC);
>> +               }
>>  
>>                 seq_printf(m, "%s avg10=%lu.%02lu avg60=%lu.%02lu
>> avg300=%lu.%02lu total=%llu\n",
>>                            full ? "full" : "some",
> 
> 
> Martin Steigerwald • 
> Proact Deutschland GmbH
> Trainer
> Telefon: +49 911 30999 0 • 
> www.proact.de
> Südwestpark 43 • 
> 90449 Nürnberg • 
> Germany
> Amtsgericht Nürnberg
>  • 
> HRB 18320
> Geschäftsführer: 
> René Schülein
>  • 
> Jonas Hasselberg
>  • 
> Linda Höljö
> #ThePowerOfData  |  
> #ThePowerOfTogether
> 
> This email and its attachments may be confidential and are intended solely for the use of the individual to whom it is addressed. Please read more in Proacts’ privacy notice,
>  
>  
> 
