Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FBB5224FE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiEJTq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiEJTqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:46:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84A8560AA4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652212012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SAo4nYGOY7DhH/NDZO1OnJtNtfF20Aj8AoviaxpQJeQ=;
        b=I60Kfy4+clL1bFgn73ZKNaukn9i8RNt5+iofxmHS7S/kr0e1P1PtMbvjXioegvIQGt905G
        1sLyYhTyui178JLJaC6nmkxUvA4Xq87oUUO053T/LURoJlp58ZkLKxUIdlpwCEITDuv9f1
        Dkx4dT8FaAVPceaJ01L0QfnTEq8RDIE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-ybvsyEvGPM-V8lckqZTFig-1; Tue, 10 May 2022 15:46:48 -0400
X-MC-Unique: ybvsyEvGPM-V8lckqZTFig-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56C853C19033;
        Tue, 10 May 2022 19:46:47 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C870416367;
        Tue, 10 May 2022 19:46:46 +0000 (UTC)
Message-ID: <149d85f2-8561-cfac-3447-425d6a4b8014@redhat.com>
Date:   Tue, 10 May 2022 15:46:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [mm/page_alloc] f26b3fa046: netperf.Throughput_Mbps -18.0%
 regression
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Aaron Lu <aaron.lu@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        kernel test robot <oliver.sang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        fengwei.yin@intel.com
References: <20220420013526.GB14333@xsang-OptiPlex-9020>
 <YmvMDyx05UoPFtQy@ziqianlu-desk1>
 <bd3db4de223a010d1e06013e93b09879fc9b36a8.camel@intel.com>
 <YnURx04+hE0sQ3v3@ziqianlu-desk1>
 <7d20a9543f69523cfda280e3f5ab17d68db037ab.camel@intel.com>
 <YnXnLuYjmEWdVyBP@ziqianlu-desk1>
 <ae763d63e50d14650c5762103d113934412bef57.camel@intel.com>
 <ba83270a-4f37-7d5a-b37a-0b7a6df5f5b4@intel.com>
 <d13688d1483e9d87ec477292893f2916832b3bdc.camel@intel.com>
 <c11ae803-cea7-8b7f-9992-2f640c90f104@intel.com>
 <37dac785a08e3a341bf05d9ee35f19718ce83d26.camel@intel.com>
 <CAHk-=wjguW5nxjagV99GHvc_-E_7mSg+LMvGtFjJ9LUSx4Skig@mail.gmail.com>
 <56474c28-e62a-36b1-257b-9e5ffb11b0e2@redhat.com>
 <CAHk-=wiEtdHOeBti66NpSZDQw0KxcU45UNHaO-+Zwbiq3JEu+g@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAHk-=wiEtdHOeBti66NpSZDQw0KxcU45UNHaO-+Zwbiq3JEu+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 15:03, Linus Torvalds wrote:
> On Tue, May 10, 2022 at 11:47 AM Waiman Long <longman@redhat.com> wrote:>
>> Qspinlock still has one head waiter spinning on the lock. This is much
>> better than the original ticket spinlock where there will be n waiters
>> spinning on the lock.
> Oh, absolutely. I'm not saying we should look at going back. I'm more
> asking whether maybe we could go even further..

We can probably go a bit further, but there will be cost associated with it.

>> That is the cost of a cheap unlock. There is no way to eliminate all
>> lock spinning unless we use MCS lock directly which will require a
>> change in locking API as well as more expensive unlock.
> So there's no question that unlock would be more expensive for the
> contention case, since it would have to always not only clear the lock
> itself, as well as update the noce it points to.
>
> But does it actually require a change in the locking API?

Of course, it is not always necessary to change the locking API.


>
> The qspinlock slowpath already always allocates that mcs node (for
> some definition of "always" - I am obviously ignoring all the trylock
> cases both before and in the slowpath)
>
> But yes, clearly the simply store-release of the current
> queued_spin_unlock() wouldn't work as-is, and maybe the cost of
> replacing it with something else is much more expensive than any
> possible win.
At the minimum, we need to do a read to determine if the lock is 
contended and also a write to clear the lock bit. An atomic write after 
read is expensive. There is also a possibility of race with non-atomic 
read-write. Moreover, the tail stored in the lock can tell you the queue 
tail, not its current head. So there is no easy way to notify the 
current head waiter to acquire the lock. The only thing I can think of 
is to do some kind of proportional backoff for the head waiter by slowly 
increasing the time gap with successive spinning attempts on the lock 
over time with the cost of an increased lock acquisition latency.
> I think the PV case already basically does that - replacing the the
> "store release" with a much more complex sequence. No?

That is true for pvqspinlock as the unlock is an atomic operation with 
increased cost. The original pv ticket spinlock that is now replaced by 
pvqspinlock has similar expensive unlock due to the nature of reading 
the lock to find out if the head waiter vCPU may have been preempted.

Cheers,
Longman

