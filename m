Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F47A522CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242683AbiEKHEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242697AbiEKHEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:04:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72B4D80AB
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652252599; x=1683788599;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xi/15l1LiqrJgA5M1iCCDv5sekSxWpMDbpt/iT0Z6As=;
  b=EwGbHfFnV5Zh01U9SPkGzrHCZvYAq8MzqgnHKD/VYZ4eaowCwgppnrxn
   qgO5BY/scvh0xw8EEXJWyToAI4iht6dpXoJsqJBd5+eIQSwNB33ptlifV
   ncKWW4nWasjDVUzTtS2bUZyUPl3f2vGeMhGobJz+6T5T0ID7Mcff0AIri
   nBkt4CgAjJaaRlm6UJD/8wggmZW77Uq8tkbZRi2MzzO2WhCukwn66iWeK
   DeC1CAT3NSMh7ISxXIgytWz8VR2lD7VFC0NJip+MIb4TbgHpjky+Q+r7B
   RjvjUGg5Hr/F3V4htBP/PIIC1Mut/feqJE7qqwpuTgPLqbFLIzFZ1ejz5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269546484"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="269546484"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 00:03:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="593968337"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.107])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 00:03:16 -0700
Message-ID: <ec62edc2-f4fc-82db-c001-23d43137557c@intel.com>
Date:   Wed, 11 May 2022 10:03:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH V2 21/23] libperf evsel: Add comments for booleans
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-22-adrian.hunter@intel.com>
 <CAP-5=fWjpP8hhzPuS7tvGaPh9UFJ7Fdyg0B41B4100XbsqFUBA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fWjpP8hhzPuS7tvGaPh9UFJ7Fdyg0B41B4100XbsqFUBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/05/22 23:51, Ian Rogers wrote:
> On Fri, May 6, 2022 at 5:26 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> Add comments for 'system_wide' and 'requires_cpu' booleans
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  tools/lib/perf/include/internal/evsel.h | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
>> index 77fbb8b97e5c..cc8f1ba790bd 100644
>> --- a/tools/lib/perf/include/internal/evsel.h
>> +++ b/tools/lib/perf/include/internal/evsel.h
>> @@ -49,7 +49,16 @@ struct perf_evsel {
>>
>>         /* parse modifier helper */
>>         int                      nr_members;
>> +       /*
>> +        * system_wide is for events that need to be on every CPU, irrespective
>> +        * of user requested CPUs or threads. Map propagation will not override
>> +        * this events own_cpus, which will contribute to evlist all_cpus.
> 
> So this muddies my understanding of cpus and own_cpus (sigh, again
> undocumented). I believe cpus to be the set of CPUs (or any CPU, aka
> dummy) that perf_event_open happens on. all_cpus in evlist is the
> union of all the evsels cpus (ie not related to own_cpus as described
> here). Own_cpus I believe to be what's computed at parse-event time
> from sysfs. Is this a typo in the comment or quite likely my error?

A 'system_wide' event is not created by the parser, so own_cpus is set
by the code adding the event.

> 
> Thanks,
> Ian
> 
>> +        */
>>         bool                     system_wide;
>> +       /*
>> +        * Some events, for example uncore events, require a CPU.
>> +        * i.e. it cannot be the 'any CPU' value of -1.
>> +        */
>>         bool                     requires_cpu;
>>         int                      idx;
>>  };
>> --
>> 2.25.1
>>

