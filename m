Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F594E3FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbiCVNkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbiCVNkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:40:03 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C4B21279
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:38:35 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id t5so18189612pfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3hBW2jq9rQv2PGQ7z4Xm8VijqZLc6qsdwGJm+DpeyK0=;
        b=maGu3bj7QiYTNAQFKfvkcYWpIuUPj3nmsTaF8s/efLzEuhnH23mhLP3aEdqHLwKH+x
         FLBm0J3/SkxwmbzBheQ5384GI6bOuybr+W76KaFFUgU5tS7nfWVdPILrU/DU9Y7SZAus
         sTrKuka4J3v19x0k1LI85dd4rMgyzPbEkd6XHdjLhKbh2vdkuEg31Da2A0F3Mc2f0sNR
         3bHEoJjkkU1GNxc6abAyJfzZnvVLjQMVNsL2Cajfl/BQEx0QyxA+aZ+vxmanpyQpxAOD
         kKoIq8YQS0eY6maVmURqrBHIelP1F7iN0eUjnRLgOmtsI2RdnpRzfW4Ey8M0RzzorNJJ
         IuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3hBW2jq9rQv2PGQ7z4Xm8VijqZLc6qsdwGJm+DpeyK0=;
        b=ET5imHaYi8nZdJmDZM6OXz+nsiGbILa9/xBRLCtB6cqsiXyB2UywOXdKZ8yVMB1un8
         dKRRqRARBTTJO7GPyK2DmGYOEicuOKBW61sw1LTCnB0J9QxoZ6hE5JE77ZyzZyqFOO6e
         b1BTjBxnG58Acx++GLYmutr5fjQE5bJqE3CpQyZoKSLk/0h3BnUy/BR4Avf1xBrqEb8u
         M299N8WJAdwt7Mf5ak+ktGkkV8Wjpw5WIP7EqCICyktgTZtg82Xa3VS9EtNV5q/vbBog
         LXfmOQX9vN02llnB8LDVNtE4GsxrahcJb5w4o2HAmlfjo4iwyW4J3OY0qD2dGREAR7Gc
         dqYA==
X-Gm-Message-State: AOAM530qOfNfu41eCabVhqbkwS2tPWSKqHUKpbNOXxCEIBxzxhyZ05N9
        QH3TG04VWDBuWIv9YuKJvWqrDg==
X-Google-Smtp-Source: ABdhPJw9VTBsVAskTxmV8drgozBswhR7Sk3zdW6yWS/yOBcMNJNiPdFLtlSIG+SuFq+NDKsL+Zaktw==
X-Received: by 2002:a05:6a00:23cb:b0:4f7:872d:86eb with SMTP id g11-20020a056a0023cb00b004f7872d86ebmr29441308pfc.37.1647956314616;
        Tue, 22 Mar 2022 06:38:34 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e62:3990:4de5:990f:881e:dd0e? ([2409:8a28:e62:3990:4de5:990f:881e:dd0e])
        by smtp.gmail.com with ESMTPSA id e19-20020a637453000000b003821bdb8103sm13985352pgn.83.2022.03.22.06.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 06:38:34 -0700 (PDT)
Message-ID: <b55676c3-07da-f4f1-e4c8-252cd9d4fac2@bytedance.com>
Date:   Tue, 22 Mar 2022 21:38:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] Re: [PATCH v2 1/6] perf/core: Fix incosistency between
 cgroup sched_out and sched_in
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
 <20220322120834.98637-2-zhouchengming@bytedance.com>
 <YjnIKCIRV+ePJVCN@hirez.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YjnIKCIRV+ePJVCN@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/22 8:59 下午, Peter Zijlstra wrote:
> On Tue, Mar 22, 2022 at 08:08:29PM +0800, Chengming Zhou wrote:
>> There is a race problem that can trigger WARN_ON_ONCE(cpuctx->cgrp)
>> in perf_cgroup_switch().
>>
>> CPU1					CPU2
>> (in context_switch)			(attach running task)
>> perf_cgroup_sched_out(prev, next)
>> 	cgrp1 == cgrp2 is True
>> 					next->cgroups = cgrp3
>> 					perf_cgroup_attach()
>> perf_cgroup_sched_in(prev, next)
>> 	cgrp1 == cgrp3 is False
>>
>> The commit a8d757ef076f ("perf events: Fix slow and broken cgroup
>> context switch code") would save cpuctx switch out/in when the
>> perf_cgroup of "prev" and "next" are the same.
>>
>> But perf_cgroup of task can change in concurrent with context_switch.
> 
> Can you clarify? IIRC then a task changes cgroup it goes throught the
> whole ->attach() dance, and that serializes against the context switch
> code.
> 

task->cgroups changed before perf_cgroup_attach(), and is not serialized
against the context switch, since task->cgroups can be changed without
rq lock held. (cgroup v1 or cgroup v2 with PSI disabled)

So perf_cgroup_from_task() in perf_cgroup_switch() may see the old or
new perf_cgroup when do context switch.

Thanks.
