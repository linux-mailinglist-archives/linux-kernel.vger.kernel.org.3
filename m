Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F6C4781E3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 02:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhLQBFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 20:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhLQBFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 20:05:02 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4E5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 17:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=oysHTDnlWx6nElriq9VJ13OfQP9b9K3cTCX8fCPsguE=; b=T07NlHD5byLuj9YkCEXTZDfDim
        JiiDLtxV+kEvi3uthjSKb5SKDYIOC95GObtCuoggY1XDSKYfd5HeeDO/zveI+pfVbTvPAzwKGUEH7
        Oq011GFw5ubhdemghYOlGWk9Xbkk0KOdevxpI1SOjghNmkj6RD7EvaUOKAHzVT+1H83bJRLJHQwc0
        Gr5WnGqpAn9w35OKS2eWG8JIrcXiJWZPdXcV0TVQb8gRmo6VloaJYeUSWYadDAtXWEG00U+RAYgsP
        S0YJcwBPmmF16iELOcbzvom1b4LCqzYSrYrhtFB1FsJEobLBUNWimk/A1W552GZxpKvm18Qj4HjiX
        XRRolAEg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1my1g9-001n4K-8G; Fri, 17 Dec 2021 01:04:58 +0000
Message-ID: <15d1b3e8-9bab-6d09-8310-114264e7b324@infradead.org>
Date:   Thu, 16 Dec 2021 17:04:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] sched/fair: fix all kernel-doc warnings
Content-Language: en-US
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20211214000859.24427-1-rdunlap@infradead.org>
 <20211217010041.GA13109@ranerica-svr.sc.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20211217010041.GA13109@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/21 17:00, Ricardo Neri wrote:
> On Mon, Dec 13, 2021 at 04:08:59PM -0800, Randy Dunlap wrote:
>> Quieten all kernel-doc warnings in kernel/sched/fair.c:
>>
>> kernel/sched/fair.c:3663: warning: No description found for return value of 'update_cfs_rq_load_avg'
>> kernel/sched/fair.c:8601: warning: No description found for return value of 'asym_smt_can_pull_tasks'
>> kernel/sched/fair.c:8673: warning: Function parameter or member 'sds' not described in 'update_sg_lb_stats'
>> kernel/sched/fair.c:9483: warning: contents before sections
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> ---
>>  kernel/sched/fair.c |    8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> --- next-2021-1210.orig/kernel/sched/fair.c
>> +++ next-2021-1210/kernel/sched/fair.c
>> @@ -3653,7 +3653,7 @@ static inline void add_tg_cfs_propagate(
>>   *
>>   * cfs_rq->avg is used for task_h_load() and update_cfs_share() for example.
>>   *
>> - * Returns true if the load decayed or we removed load.
>> + * Return: true if the load decayed or we removed load.
>>   *
>>   * Since both these conditions indicate a changed cfs_rq->avg.load we should
>>   * call update_tg_load_avg() when this function returns true.
>> @@ -8594,6 +8594,8 @@ group_type group_classify(unsigned int i
>>   *
>>   * If @sg does not have SMT siblings, only pull tasks if all of the SMT siblings
>>   * of @dst_cpu are idle and @sg has lower priority.
>> + *
>> + * Return: true if the load-balancing CPU can pull tasks, false otherwise.
> 
> Can we say "Return: true if @dst_cpu can pull tasks, false otherwise"?
> The load-balancing CPU is not always the same as dst_cpu.

Sure, and thanks for the feedback/correction.

I'll send a v2.

-- 
~Randy
