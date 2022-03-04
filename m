Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2694CD6A1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239922AbiCDOoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239904AbiCDOoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:44:01 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818511BD072
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 06:43:12 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso10771600pjj.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 06:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ze2fqoG8Uv2ivOdemEby3h5mEqMYX8ZelC0Z+W02JsY=;
        b=MByDOnLKlFXdAZczHK4WVBzn4RAn6PAHsHIoSaVTs0Hd0A9DZT3CFOy2QmicB40p5j
         DyQT2LZiwFafH9eamIKEoh0PuIFAkMzhGsEHPz3VgijVEDjImTUWNn3mozIJp4QgnY27
         276pkjtyHVm1SQY0FstynGu5/6sB0ML6eFEtcWccIgrlTJHhr8TTnrm4LfEwgtOXealL
         tD1WrPbWEc8eDFGMgCY2rjJHVFUyEXMnHWQuv9H1xvDQ4rCi08c2njHZ26qCI5CR6mCM
         +zHqtbNTXi6AzslQtMfQr4syff73Alj+suX1drdIzowGvnnE7J1T6oyNxdn0W2Uqs2O6
         vPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ze2fqoG8Uv2ivOdemEby3h5mEqMYX8ZelC0Z+W02JsY=;
        b=IFHsmeOBUql+LyEAy60bEJX0J+vdxp6RUwQKYfaScvqsvPc1coNpMNrSp2cy0PDf0W
         HokcRuN+lpYU7vm1iJC2mz6Ki+0BlM+uZ4N+OMql111w3u475mCUkqZakRSaVQWswJDy
         /DaxTT1iaE2S+UYTBnSDgSGTb4ughVtbMF8M8YK0Am2CJ9ldCat5UEqvq6163WPqIqo4
         muFvQz+77Y/s3JQz6LMdJmIhmanom7L3S2r7SJd8cfgQkd6iTfRM71EfHr9q+88I1Iwb
         KPWlxEXol6L9Hyi5g7taqaqQekbdws3R79Rs8+o8FS4hTFjeHFpQGCIIrAueJm7LTDZe
         TSHA==
X-Gm-Message-State: AOAM5318Y4TdQMH7e7FmgIVHBKiIH65HoSEN/63E+kmyIHQyScFRJtuV
        nBDecBctClgEVbJBYypCRU49cw==
X-Google-Smtp-Source: ABdhPJx2Krb3aVoml7oYDj/wYF2zHt9MFApRDg9L25cSW2GzVlZ0CxIxRFV7Ju0TLpp/Uo/PKUNvRg==
X-Received: by 2002:a17:90a:a887:b0:1bc:388a:329f with SMTP id h7-20020a17090aa88700b001bc388a329fmr11106568pjq.17.1646404991696;
        Fri, 04 Mar 2022 06:43:11 -0800 (PST)
Received: from ?IPV6:2409:8a28:e6d:cc00:d089:89fd:5c33:f12? ([2409:8a28:e6d:cc00:d089:89fd:5c33:f12])
        by smtp.gmail.com with ESMTPSA id s21-20020a056a00195500b004f65b15b3a0sm6169814pfk.8.2022.03.04.06.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 06:43:11 -0800 (PST)
Message-ID: <f649a2f1-1029-dd69-47c6-f61f0fcc4313@bytedance.com>
Date:   Fri, 4 Mar 2022 22:43:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [External] Re: [PATCH] psi: remove CPU full metric at system
 level
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     corbet@lwn.net, mingo@redhat.com, peterz@infradead.org,
        surenb@google.com, ebiggers@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Martin Steigerwald <Martin.Steigerwald@proact.de>
References: <20220303055814.93057-1-zhouchengming@bytedance.com>
 <YiDB8pjzthSk0X7Q@cmpxchg.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YiDB8pjzthSk0X7Q@cmpxchg.org>
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

On 2022/3/3 9:26 下午, Johannes Weiner wrote:
> On Thu, Mar 03, 2022 at 01:58:14PM +0800, Chengming Zhou wrote:
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
>> system level. So this patch removed CPU full metric at the
>> system level, and removed it's monitor function too. The psi
>> Documentation has also been updated accordingly.
>>
>> Fixes: e7fcd7622823 ("psi: Add PSI_CPU_FULL state")
>> Reported-by: Martin Steigerwald <Martin.Steigerwald@proact.de>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  Documentation/accounting/psi.rst | 18 +++++++++++++++---
>>  kernel/sched/psi.c               | 10 +++++++++-
>>  2 files changed, 24 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/accounting/psi.rst b/Documentation/accounting/psi.rst
>> index 860fe651d645..519652c06d7d 100644
>> --- a/Documentation/accounting/psi.rst
>> +++ b/Documentation/accounting/psi.rst
>> @@ -178,8 +178,20 @@ Cgroup2 interface
>>  In a system with a CONFIG_CGROUP=y kernel and the cgroup2 filesystem
>>  mounted, pressure stall information is also tracked for tasks grouped
>>  into cgroups. Each subdirectory in the cgroupfs mountpoint contains
>> -cpu.pressure, memory.pressure, and io.pressure files; the format is
>> -the same as the /proc/pressure/ files.
>> +cpu.pressure, memory.pressure, and io.pressure files; the format of
>> +memory.pressure and io.pressure is the same as the /proc/pressure/ files.
>> +
>> +But the format of cpu.pressure is as such::
>> +	some avg10=0.00 avg60=0.00 avg300=0.00 total=0
>> +	full avg10=0.00 avg60=0.00 avg300=0.00 total=0
> 
> It's the format of cpu.pressure, except when it's
> /sys/fs/cgroup/cpu.pressure... I think this is getting maybe a tad too
> difficult to write parsers for. Plus, we added the line over a year
> ago so we might break somebody by removing it again.
> 
> How about reporting zeroes at the system level?

Ok, it's really better for userspace parsers, will change to this way
and send later.

Thanks.

> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index e14358178849..86824de404bc 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1062,14 +1062,17 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
>  	mutex_unlock(&group->avgs_lock);
>  
>  	for (full = 0; full < 2; full++) {
> -		unsigned long avg[3];
> -		u64 total;
> +		unsigned long avg[3] = { 0, };
> +		u64 total = 0;
>  		int w;
>  
> -		for (w = 0; w < 3; w++)
> -			avg[w] = group->avg[res * 2 + full][w];
> -		total = div_u64(group->total[PSI_AVGS][res * 2 + full],
> -				NSEC_PER_USEC);
> +		/* CPU FULL is undefined at the system level */
> +		if (!(group == &psi_system && res == PSI_CPU && full)) {
> +			for (w = 0; w < 3; w++)
> +				avg[w] = group->avg[res * 2 + full][w];
> +			total = div_u64(group->total[PSI_AVGS][res * 2 + full],
> +					NSEC_PER_USEC);
> +		}
>  
>  		seq_printf(m, "%s avg10=%lu.%02lu avg60=%lu.%02lu avg300=%lu.%02lu total=%llu\n",
>  			   full ? "full" : "some",
