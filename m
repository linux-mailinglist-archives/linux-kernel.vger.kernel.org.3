Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067544FFB71
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbiDMQjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbiDMQjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:39:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7178E65153
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649867849; x=1681403849;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AYwbAQA51GI7OS3SDP9g0rw3x5qDpayrqhQKsx+i7bU=;
  b=gezAZ8nOpTT431q5EScNe7/sz0p7JTw4X7RmcCvRPeaDQXMG0fvlLbUn
   i/LwHg2Ph3pYgIEU+1AG5oC6Tm+pTW85KsmszVr6yR1bi/FNToU8udLn1
   QR54h1X7p+Pm4kx/2gE4SPnqxDZpmJkvaHJwvosMzdhnPLyuLzuDk3Ygm
   CabujCWEdbAd94jnDvovpXcCAwhp2DPSF/cN1E3h5z4ce8JMDtIcADkkg
   3f4LH12rLhoWNaP2R2mBEfC5Ja436jNkBoT3rwCjKWqgmXOQwwcHCSYpQ
   RKWBryluhx72prhoQC9JvBFFigG5y9OXMr6z1Lr/TwwrbRNzcwSxYE02c
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262155818"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="262155818"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 09:37:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="854854774"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 13 Apr 2022 09:37:28 -0700
Received: from [10.212.225.84] (kliang2-MOBL.ccr.corp.intel.com [10.212.225.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1DA765805BD;
        Wed, 13 Apr 2022 09:37:26 -0700 (PDT)
Message-ID: <85eed89f-e4a8-2887-a0b3-579704304357@linux.intel.com>
Date:   Wed, 13 Apr 2022 12:37:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [LKP] Re: [perf vendor events] 3f5f0df7bf:
 perf-sanity-tests.perf_all_metrics_test.fail
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>, Carel Si <beibei.si@intel.com>
Cc:     acme@redhat.com, alexander.shishkin@linux.intel.com,
        alexandre.torgue@foss.st.com, ak@linux.intel.com, mingo@redhat.com,
        james.clark@arm.com, jolsa@kernel.org, john.garry@huawei.com,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        namhyung@kernel.org, peterz@infradead.org, eranian@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, lkp@lists.01.org,
        lkp@intel.com
References: <20220304083329.GC20556@xsang-OptiPlex-9020>
 <CAP-5=fVz=arWo19PQR_4UKY_PyywyXoyp+MUnfAJxCFZy5rhWg@mail.gmail.com>
 <20220413070529.GA1320@linux.intel.com>
 <CAP-5=fXGqODZYGu781qjEEVtGFpCQJ=dCXi5shYOAbBSt5wQkw@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fXGqODZYGu781qjEEVtGFpCQJ=dCXi5shYOAbBSt5wQkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/2022 12:03 PM, Ian Rogers wrote:
> 3) Weak group doesn't fall back to no group:

That's because the group validation code doesn't take pinned events, 
such as the NMI watchdog, into account.

I proposed a kernel patch to fix it, but it's rejected. It should be 
hard to find a generic way to fix it from the kernel side.
https://lore.kernel.org/lkml/1565977750-76693-1-git-send-email-kan.liang@linux.intel.com/

Maybe we can workaround it from the perf tool side?
For example, for each weak group with cycles event and NMI watchdog is 
enabled, add an extra cycles event when opening the group. If the open 
fails with the extra cycles event, fall back to no group. After the 
extra cycles event check, remove the extra cycles.

What do you think?

Thanks,
Kan
> $ perf stat -e '{BR_INST_RETIRED.NEAR_CALL,BR_INST_RETIRED.NEAR_TAKEN,BR_INST_RETIRED.NOT_TAKEN,BR_INST_RETIRED.CONDITIONAL,CPU_CLK_UNHALTED.THREAD}:W'
> -a sleep 1
> 
>   Performance counter stats for 'system wide':
> 
>       <not counted>      BR_INST_RETIRED.NEAR_CALL
>                 (0.00%)
>       <not counted>      BR_INST_RETIRED.NEAR_TAKEN
>                  (0.00%)
>       <not counted>      BR_INST_RETIRED.NOT_TAKEN
>                 (0.00%)
>       <not counted>      BR_INST_RETIRED.CONDITIONAL
>                   (0.00%)
>       <not counted>      CPU_CLK_UNHALTED.THREAD
>                 (0.00%)
> 
>         1.001690318 seconds time elapsed
> 
> Some events weren't counted. Try disabling the NMI watchdog:
> echo 0 > /proc/sys/kernel/nmi_watchdog
> perf stat ...
> echo 1 > /proc/sys/kernel/nmi_watchdog
