Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2727157C49D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiGUGpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiGUGpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:45:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62375E06;
        Wed, 20 Jul 2022 23:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658385907; x=1689921907;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=HhxImctwfYIb9DUOTTgHXwOx+Lua9JqCY8lR+0LM5Gk=;
  b=LL8sjbL0LmAKX8cQ0B4ZObj/ZI8vyL4Hk3j2uW1dewdErTNpVDGhDfhO
   MsznwfyaCmnNW8ArTTbJDUNi34W7b7ewVN7QcKV3UsJe79qm2rFkuRGUb
   WM0S5oKWTlFUT9J3Dmz7VAbSTQ6DXiL3gU1RJFOV5qxZoMVWJb2Sij8gl
   kXX19ZKMZ/WHzV5TeMEsoyuBUq0L6B5ThnJt7tbzkbom4U6/sLD+zzY0B
   IYw5CHlpi6QhhfpjZ4ddr2iS7XgPHoVbZIXuuts4qoHuS/0piPOEZOm4Z
   Gqte4YDEC+aygXlx78mNjHHBl6DBfS1yRxsYr74dg8hsLJE4uB4nyLzMF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="373268353"
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="373268353"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 23:45:06 -0700
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="656607244"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.255.31.95]) ([10.255.31.95])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 23:44:58 -0700
Message-ID: <33cc6a12-ccd7-c2ef-5dfc-0434105c50a8@linux.intel.com>
Date:   Thu, 21 Jul 2022 14:44:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/5] Add perf stat default events for hybrid machines
Content-Language: en-US
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, alexander.shishkin@intel.com,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <20220610025449.2089232-1-zhengjun.xing@linux.intel.com>
 <CAM9d7cjSynKt+CfoPqHQHNJt=to3LmdQqh_x6rKJSUcx6qFbsA@mail.gmail.com>
 <1d0e29b9-aa14-4cf5-9692-21244f7ddef5@linux.intel.com>
In-Reply-To: <1d0e29b9-aa14-4cf5-9692-21244f7ddef5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 7/4/2022 5:05 PM, Xing Zhengjun wrote:
> Hi,
> 
> On 6/15/2022 1:59 AM, Namhyung Kim wrote:
>> Hello,
>>
>> On Thu, Jun 9, 2022 at 7:55 PM <zhengjun.xing@linux.intel.com> wrote:
>>>
>>> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>>>
>>> The patch series is to clean up the existing perf stat default and 
>>> support
>>> the perf metrics Topdown for the p-core PMU in the perf stat default. 
>>> The
>>> first 4 patches are the clean-up patch and fixing the "--detailed" 
>>> issue.
>>> The last patch adds support for the perf metrics Topdown, the perf 
>>> metrics
>>> Topdown support for e-core PMU will be implemented later separately.
>>>
>>> Kan Liang (4):
>>>    perf stat: Revert "perf stat: Add default hybrid events"
>>>    perf evsel: Add arch_evsel__hw_name()
>>>    perf evlist: Always use arch_evlist__add_default_attrs()
>>>    perf x86 evlist: Add default hybrid events for perf stat
>>>
>>> Zhengjun Xing (1):
>>>    perf stat: Add topdown metrics in the default perf stat on the hybrid
>>>      machine
>>
>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>>
> 
> Thanks Namhyung.
> 
> Hi Arnaldo,
> 
> Can this patch series go in?
> Thanks.

This patch series has been a long time, patch2(perf evsel: Add 
arch_evsel__hw_name() ) need rebase to the latest perf/core branch,
I will send a v4 version for it.
> 
>> Thanks,
>> Namhyung
>>
>>
>>>
>>>   tools/perf/arch/x86/util/evlist.c  | 64 +++++++++++++++++++++++++-----
>>>   tools/perf/arch/x86/util/evsel.c   | 20 ++++++++++
>>>   tools/perf/arch/x86/util/topdown.c | 51 ++++++++++++++++++++++++
>>>   tools/perf/arch/x86/util/topdown.h |  1 +
>>>   tools/perf/builtin-stat.c          | 50 ++++-------------------
>>>   tools/perf/util/evlist.c           | 11 +++--
>>>   tools/perf/util/evlist.h           |  9 ++++-
>>>   tools/perf/util/evsel.c            |  7 +++-
>>>   tools/perf/util/evsel.h            |  1 +
>>>   tools/perf/util/stat-display.c     |  2 +-
>>>   tools/perf/util/topdown.c          |  7 ++++
>>>   tools/perf/util/topdown.h          |  3 +-
>>>   12 files changed, 166 insertions(+), 60 deletions(-)
>>>
>>> -- 
>>> 2.25.1
>>>
> 

-- 
Zhengjun Xing
