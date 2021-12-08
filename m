Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03E046C98D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbhLHAuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:50:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234092AbhLHAue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638924422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/bkte5kbEv7yRhaepNDkMXzUr2MX0jMtq9+W5g/aFV4=;
        b=N6TF3+fcFuYY2l5R3XvMnCr78/BYho+bCZLtxwYkVbZvjzIjDJG0wATUutFqDBH+5kBA7I
        SqSwXF51dAhCG8fG68xA7zyCh4QOx09sptA6NwP49fwWu5ZY38BMQ3gu2XeiOK96p797mS
        R6MMM1AIbYnaBINsvHpriLlS0bZWmS0=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-174-5M0p4wsTPEaZwbRQTi6cew-1; Tue, 07 Dec 2021 19:46:59 -0500
X-MC-Unique: 5M0p4wsTPEaZwbRQTi6cew-1
Received: by mail-io1-f70.google.com with SMTP id g23-20020a6be617000000b005e245747fb4so1137856ioh.15
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 16:46:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/bkte5kbEv7yRhaepNDkMXzUr2MX0jMtq9+W5g/aFV4=;
        b=YosZdC3yiF8AWsN3YGct3lKPdnc8emUE1zNfC93XhIMZMx0/saLfPvSeeLcBKJpm/R
         1Y/gmN9rd4biDV9W455aQKE1fp1g8HkuoBPFHhXTLTT/q6zKMhQmnwJgrjc86Gbg8P20
         TMf0t5MzfDfVWndNHafOBa+BtJMEKUBy99nO6hHnQm+DJB607Nz2U9wIW5eOPiYDjonL
         000rBYC9GNt1JJkJCdBy6Q7R8He19XNnMEZngnsNsuaLKIe+kSO6TzVK17UXwDi/ljk9
         LgHwntomFq//kB0N0Io9/IRliJG3V9pTNLFM8/xkR2JtYKLWDCBcbi2lEtJ++ZjswIEL
         45dw==
X-Gm-Message-State: AOAM530U3BeaVJfQ2V0wG/PCIpbMjSpwDJ8MVsu9Kl1D2RzsBDltb77z
        /7c2pkl9vRtLfWswvrfq3VcfT18P6AglBKhgjW/Z1KMbl4wny3lUAqJ73oU8zMyw/xj9ZQ7duWa
        nk9Vmxnm1g4mu6z+SKqJi2c8V
X-Received: by 2002:a05:6638:2727:: with SMTP id m39mr54630576jav.75.1638924419028;
        Tue, 07 Dec 2021 16:46:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRE5ima0X05DHObOH9ga3HGoSmZ+ZDUI+nVxZ+m9e+zZhJByt0pZmjxkyOa6fkhzywL7PG8w==
X-Received: by 2002:a05:6638:2727:: with SMTP id m39mr54630561jav.75.1638924418847;
        Tue, 07 Dec 2021 16:46:58 -0800 (PST)
Received: from ?IPV6:2601:280:4400:a2e0:7336:512c:930d:4f0e? ([2601:280:4400:a2e0:7336:512c:930d:4f0e])
        by smtp.gmail.com with ESMTPSA id r12sm823873iln.72.2021.12.07.16.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 16:46:58 -0800 (PST)
Message-ID: <ce63e509-dedf-ce00-cd12-2c67a3e650ba@redhat.com>
Date:   Tue, 7 Dec 2021 19:46:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mm/oom_kill: wake futex waiters before annihilating
 victim shared mutex
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>
References: <20211207214902.772614-1-jsavitz@redhat.com>
 <20211207154759.3f3fe272349c77e0c4aca36f@linux-foundation.org>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <20211207154759.3f3fe272349c77e0c4aca36f@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/21 18:47, Andrew Morton wrote:
> (cc's added)
> 
> On Tue,  7 Dec 2021 16:49:02 -0500 Joel Savitz <jsavitz@redhat.com> wrote:
> 
>> In the case that two or more processes share a futex located within
>> a shared mmaped region, such as a process that shares a lock between
>> itself and a number of child processes, we have observed that when
>> a process holding the lock is oom killed, at least one waiter is never
>> alerted to this new development and simply continues to wait.
> 
> Well dang.  Is there any way of killing off that waiting process, or do
> we have a resource leak here?

If I understood your question correctly, there is a way to recover the system by
killing the process that is utilizing the futex; however, the purpose of robust
futexes is to avoid having to do this.

From my work with Joel on this it seems like a race is occurring between the
oom_reaper and the exit signal sent to the OMM'd process. By setting the
futex_exit_release before these signals are sent we avoid this.

> 
>> This is visible via pthreads by checking the __owner field of the
>> pthread_mutex_t structure within a waiting process, perhaps with gdb.
>>
>> We identify reproduction of this issue by checking a waiting process of
>> a test program and viewing the contents of the pthread_mutex_t, taking note
>> of the value in the owner field, and then checking dmesg to see if the
>> owner has already been killed.
>>
>> This issue can be tricky to reproduce, but with the modifications of
>> this small patch, I have found it to be impossible to reproduce. There
>> may be additional considerations that I have not taken into account in
>> this patch and I welcome any comments and criticism.
> 
>> Co-developed-by: Nico Pache <npache@redhat.com>
>> Signed-off-by: Nico Pache <npache@redhat.com>
>> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
>> ---
>>  mm/oom_kill.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> index 1ddabefcfb5a..fa58bd10a0df 100644
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -44,6 +44,7 @@
>>  #include <linux/kthread.h>
>>  #include <linux/init.h>
>>  #include <linux/mmu_notifier.h>
>> +#include <linux/futex.h>
>>  
>>  #include <asm/tlb.h>
>>  #include "internal.h"
>> @@ -890,6 +891,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>>  	 * in order to prevent the OOM victim from depleting the memory
>>  	 * reserves from the user space under its control.
>>  	 */
>> +	futex_exit_release(victim);
>>  	do_send_sig_info(SIGKILL, SEND_SIG_PRIV, victim, PIDTYPE_TGID);
>>  	mark_oom_victim(victim);
>>  	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n",
>> @@ -930,6 +932,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>>  		 */
>>  		if (unlikely(p->flags & PF_KTHREAD))
>>  			continue;
>> +		futex_exit_release(p);
>>  		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_TGID);
>>  	}
>>  	rcu_read_unlock();
>> -- 
>> 2.33.1
> 

