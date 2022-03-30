Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2916E4ED05F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 01:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351882AbiC3Xt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 19:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351873AbiC3Xtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 19:49:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9620F65D08
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648684086; x=1680220086;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=obIfx9k5hx5Z4k2JmchPyAooDjeyIKkUcVb3LuSn/hA=;
  b=gCEeTUx9CcOsAWwQmNz2CN0jYaIHmq9D9TesvocyYT1kG6ja3hma8gYU
   9Ma22aJFonGvfJdJkwlGlP40Ls95mGshnuZhIPD9ouTa3SdALRJqwIT2m
   T4iwmISJBC0YidkO1zxMPYr9TE2BsKOAnYmy0BNISBx9UknFh+aWqq291
   qAUyLI9hLUhg6G38YXqrcd/M6ECIvxN7CyPtH+ie4FGGS+F0Lb5D7cAXM
   kCXopYXokOiybZvg1bG/i2ZzmpgfftGq6Kit69OmJ2h6+6Wy6Xqmx29gJ
   Jn2TkRlHhhhy0aLRwVBbJDavRl5CPKAWVZjihquHvDLT0mmLy40CqSsB9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259385026"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="259385026"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 16:48:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="565921010"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.125.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 16:48:06 -0700
Message-ID: <7aa67fedb4b6dc9126bc59ee993fa18d0e472475.camel@linux.intel.com>
Subject: Re: [sched/fair]  ddb3b1126f:  hackbench.throughput -25.9%
 regression
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Walter Mack <walter.mack@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@elte.hu>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, aubrey.li@linux.intel.com
Date:   Wed, 30 Mar 2022 16:48:05 -0700
In-Reply-To: <20220330094632.GB6999@xsang-OptiPlex-9020>
References: <20220330094632.GB6999@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-03-30 at 17:46 +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed a -25.9% regression of hackbench.throughput due to commit:
> 

Will try to check the regression seen.

Thanks.

Tim

> 
> 
> commit: 
>   d9ad181b93 ("sched/fair: Don't rely on ->exec_start for migration")
>   ddb3b1126f ("sched/fair: Simple runqueue order on migrate")
> 
> d9ad181b93f83b36 ddb3b1126fe93e8d6e059600488 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>      92566           -25.9%      68598 ±  2%  hackbench.throughput
>      85.50           +40.8%     120.35 ±  2%  hackbench.time.elapsed_time
>      85.50           +40.8%     120.35 ±  2%  hackbench.time.elapsed_time.max
>    9674391 ±  2%    +466.2%   54780205 ±  2%  hackbench.time.involuntary_context_switches
>       1240           +42.6%       1768 ±  3%  hackbench.time.system_time
>      89.58           +20.4%     107.85        hackbench.time.user_time
>   36626407          +270.2%  1.356e+08 ±  2%  hackbench.time.voluntary_context_switches
>    2500490 ±  3%     +78.2%    4456808 ±  3%  cpuidle..usage
>     118.45 ±  2%     +29.2%     153.02 ±  2%  uptime.boot
> 

