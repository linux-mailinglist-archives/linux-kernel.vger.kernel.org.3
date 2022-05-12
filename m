Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7C9524BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353346AbiELLkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239947AbiELLkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:40:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0501B6D4C8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652355608; x=1683891608;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=334QfPsBhgD128XgXQmRYLsAEiLeQWJ3MXNBRTVpIsw=;
  b=PDVUJz2h/Hlih36WLWOJqDG6cyrmk94I3IExIqWj4Y91CcDDVFFYN7FM
   ZkBr2h/MxmL/yyYTPspKUEFgbU0LXHYrkCmbr4EnPRPZnESl3rGeVGMEQ
   wPZPTpmQmUty5lTYPIV2pGbqZ0DBmBZ1jkb3c/zqteRvrW5annkxAhrxO
   LOiA5rmV1B4zPPtwQI2Ep6hMbEmfrZttTTP2FlTJ5C5FYN1TDgkxeGNeD
   Zq2/6VfGs22Y0Y2ddDr3NbELSxySjOVk3Ms+Xgd8VbP6DLz3Labysowc9
   D5xHw8c7PihmV5c4T1GAP83PR0OhvwFXU0BPOGAxTjaTrItOrzeFpV6ju
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="257521551"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="257521551"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 04:40:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="594628454"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.215])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 04:40:04 -0700
Message-ID: <df9ead42-42d8-1547-6621-3e59f773266b@intel.com>
Date:   Thu, 12 May 2022 14:40:00 +0300
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
 <ec62edc2-f4fc-82db-c001-23d43137557c@intel.com>
 <CAP-5=fW4k0A_iYPYq5pS59GmvUa8uUkzS2c2C5ruyKd40wjU8A@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fW4k0A_iYPYq5pS59GmvUa8uUkzS2c2C5ruyKd40wjU8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/22 08:34, Ian Rogers wrote:
> On Wed, May 11, 2022 at 12:03 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 6/05/22 23:51, Ian Rogers wrote:
>>> On Fri, May 6, 2022 at 5:26 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> Add comments for 'system_wide' and 'requires_cpu' booleans
>>>>
>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>> ---
>>>>  tools/lib/perf/include/internal/evsel.h | 9 +++++++++
>>>>  1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
>>>> index 77fbb8b97e5c..cc8f1ba790bd 100644
>>>> --- a/tools/lib/perf/include/internal/evsel.h
>>>> +++ b/tools/lib/perf/include/internal/evsel.h
>>>> @@ -49,7 +49,16 @@ struct perf_evsel {
>>>>
>>>>         /* parse modifier helper */
>>>>         int                      nr_members;
>>>> +       /*
>>>> +        * system_wide is for events that need to be on every CPU, irrespective
>>>> +        * of user requested CPUs or threads. Map propagation will not override
>>>> +        * this events own_cpus, which will contribute to evlist all_cpus.
>>>
>>> So this muddies my understanding of cpus and own_cpus (sigh, again
>>> undocumented). I believe cpus to be the set of CPUs (or any CPU, aka
>>> dummy) that perf_event_open happens on. all_cpus in evlist is the
>>> union of all the evsels cpus (ie not related to own_cpus as described
>>> here). Own_cpus I believe to be what's computed at parse-event time
>>> from sysfs. Is this a typo in the comment or quite likely my error?
>>
>> A 'system_wide' event is not created by the parser, so own_cpus is set
>> by the code adding the event.
> 
> I think I may be misreading the comment. Perhaps it should read:
> 
> system_wide is for events that need to be on every CPU, irrespective
> of user requested CPUs or threads. Map propagation will not override
> this event's own_cpus and own_cpus don't contribute to the evlist
> all_cpus.

For a system_wide evsel, evsel->cpus are set to own_cpus and the
evsel->cpus contribute to all_cpus.

> 
> It would be nice if there were a comment on own_cpus to explain its
> relationship to cpus and more broadly when it is used. Fwiw, the parse
> time copy is made here:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/parse-events.c?h=perf/core#n367
> 
> I worry that if own_cpus should be used in place of cpus then
> iterators like evlist__for_each_cpu may need to handle this, and so
> they'd be broken currently.

No, evsel->own_cpus may be used to determine evsel->cpus, but that
is where their influence stops.

> 
> Thanks,
> Ian
> 
>>>
>>> Thanks,
>>> Ian
>>>
>>>> +        */
>>>>         bool                     system_wide;
>>>> +       /*
>>>> +        * Some events, for example uncore events, require a CPU.
>>>> +        * i.e. it cannot be the 'any CPU' value of -1.
>>>> +        */
>>>>         bool                     requires_cpu;
>>>>         int                      idx;
>>>>  };
>>>> --
>>>> 2.25.1
>>>>
>>

