Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0433F52B087
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 04:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbiERCp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 22:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiERCpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 22:45:20 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA7254688;
        Tue, 17 May 2022 19:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652841918; x=1684377918;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HkJveV1SObdCl0X5UzbD536bvT+Ssfn5TL+iMP961Dw=;
  b=fUuqloN3j8tRp/6ynaOqdVJbKjB8u8cI/WNW4IOTmJMObp0lB+Rdsd30
   A0WDNFhqAKniRfKrMczHTnYS8+O4o8kLtvm7KAfQIAJ+gZgwdLiel/5jm
   ma9Qv2PM4YQNruQViLycqarRIOKGxYSGJYSkMpCwd3YOTR/J9EYExNgXo
   FaKpyQzlpTkbN9fb4BM4Ef4vrFFpGDx8xXERMvBu3AKTdmMfn8dRWn1DE
   vQdX/+w2J9c3EFDJJc3yLZRpZakRC2dJQTqKp1xLDTlw2rW+YwvFtjFgs
   6vEDwQfVfqPCGH66U/l0P62/QV9R8OcCn2lbYKMThlaYLGLXtD6MzkN0N
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="296729043"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="296729043"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 19:45:18 -0700
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="597479183"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.255.31.182]) ([10.255.31.182])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 19:45:13 -0700
Message-ID: <8f846bfe-af5d-d895-0ee4-a5bbbae1fd06@linux.intel.com>
Date:   Wed, 18 May 2022 10:45:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/5] Revert "perf stat: Support metrics with hybrid
 events"
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
References: <20220507053410.3798748-1-irogers@google.com>
 <20220507053410.3798748-2-irogers@google.com> <YnkTIwiVBEGUJRKn@kernel.org>
 <b01a66c4-ec4d-ccb7-8ca7-130d93855177@linux.intel.com>
 <708fab8f-b5c5-8f34-4322-3e337c56b869@linux.intel.com>
 <CAM9d7cgEc9o9y-fH==avzucigmMVw0AwooGw0eufb2+D568-_g@mail.gmail.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <CAM9d7cgEc9o9y-fH==avzucigmMVw0AwooGw0eufb2+D568-_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/2022 6:58 AM, Namhyung Kim wrote:
> Hello,
> 
> On Tue, May 10, 2022 at 2:31 AM Xing Zhengjun
> <zhengjun.xing@linux.intel.com> wrote:
>>
>>
>>
>> On 5/10/2022 5:55 AM, Liang, Kan wrote:
>>>
>>>
>>> On 5/9/2022 9:12 AM, Arnaldo Carvalho de Melo wrote:
>>>> Em Fri, May 06, 2022 at 10:34:06PM -0700, Ian Rogers escreveu:
>>>>> This reverts commit 60344f1a9a597f2e0efcd57df5dad0b42da15e21.
>>>>
>>>> I picked this from the cover letter and added to this revert, to justify
>>>> it:
>>>>
>>>> "Hybrid metrics place a PMU at the end of the parse string. This is
>>>> also where tool events are placed. The behavior of the parse string
>>>> isn't clear and so revert the change for now."
>>>>
>>>
>>> I think the original patch used a "#" to indicate the PMU name, which
>>> can be used to distinguish between the tool events and the PMU name.
>>> To be honest, I'm not sure what's unclear here. Could you please clarify?
>>>
>>> With this revert, the issue mentioned in the original patch must be
>>> broken on ADL. I don't see a replacement fix in this patch series.
>>> Could you please propose a solution for the issue to replace the #PMU
>>> name solution?
>>>
>>> Thanks,
>>> Kan
>>
>> I am surprised the origin patch is reverted during discussion and though
>> the discussion still has no conclusion.
>> Let me introduce the purpose of the origin patch.
>> For a hybrid system such as ADL, if both the metrics and the formula are
>> different for the different PMUs, without this patch, the metric and
>> event parser should work ok, nothing should be special for the hybrid.
>> In fact, both "cpu_core" and "cpu_atom" may have the same metrics--the
>> same metric name, even the same formula for the metrics. For example,
>> both "cpu_core" and "cpu_atom" have metrics "IpBranch" and "IPC", For
>> "IpBranch", both "cpu_core" and "cpu_atom" has the same metric name and
>> their formula also is the same, the event name is the same though they
>> belong to different PMUs. The old metric and event parser can not handle
>> this kind of metric, that's why we need this patch.
>>
>>       "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
>>       "MetricName": "IpBranch",
>>       "Unit": "cpu_core"
>>
>>       "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
>>       "MetricName": "IpBranch",
>>       "Unit": "cpu_atom"
>>
>>
>>      "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
>>      "MetricName": "IPC",
>>      "Unit": "cpu_core"
>>
>>      "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.CORE",
>>      "MetricName": "IPC",
>>      "Unit": "cpu_atom"
>>
>> Except for the above two metrics, there are still a lot of similar
>> metrics, "CPU_Utilization"...
>>
>> The original patch expanded the metric group string by adding
>> "#PMU_name" to indicate the PMU name, which can be used to distinguish
>> between the tool events and the PMU name, then the metric and event
>> parser can parse the right PMU for the events.
>>
>> With the patch all the ADL metrics can pass, without the patch, a lot of
>> metrics will fail. I don't think it's a good idea to revert it before
>> the new solution is proposed.
> 
> Just an idea.  Can we add a pmu prefix when it resolves the event
> for a metric if it has the "Unit"?  It seems we can support something
> like "cpu_core@INST_RETIRED.ANY@" already..
> 
> Or could it be done when creating JSON files?
> 
> Thanks,
> Namhyung

Yes, we have ever tested it, and it can work. we are changing the 
converter tools to implement it, but it still has some issues that need 
to fix.

-- 
Zhengjun Xing
