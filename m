Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CAF58E047
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbiHITh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbiHIThC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:37:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509DF24942;
        Tue,  9 Aug 2022 12:37:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E188D61337;
        Tue,  9 Aug 2022 19:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA59C433C1;
        Tue,  9 Aug 2022 19:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660073820;
        bh=7RU30KM7l0MKvkGXYL/0iZfnQboyY+CyJ42jlnIxKfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aih3hVnI5FTJlnCknNFmJ1FuAG1eAPO6LY0VkAvF4DLbZ0MniUEuh3a/jwRr7gy4t
         kQCT2XzSbqTSt9BxZr08qIIoZAmr1KqMuvDSTDP3M8bQ44aGwyfN5L9PoFhBdUff2T
         TdCi0Ip7WNnr64nlX6qjdiy01AA0fMVdHgnTQEVufIjIXgW3SZuH3AZDAll46iwaXz
         mTGOwGiwxJspYaKmLyrlmu/uJMCQpzeIoAI5oCoD//yAFvNXVHLqzMmWFmr1PHzsbW
         sq5nuBHCden8b+mDMcV0akUHcuUhqCm1m7XJNlHmhRHevC7qcMZ06dOThtKaZbHxtY
         Y7k9btN34vLWg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B2D6E4035A; Tue,  9 Aug 2022 16:36:57 -0300 (-03)
Date:   Tue, 9 Aug 2022 16:36:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v4 01/17] perf jevents: Clean up pytype warnings
Message-ID: <YvK3WZ5UVrlW1mwe@kernel.org>
References: <20220804221816.1802790-1-irogers@google.com>
 <20220804221816.1802790-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804221816.1802790-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 04, 2022 at 03:18:00PM -0700, Ian Rogers escreveu:
> Improve type hints to clean up pytype warnings.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/jevents.py | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 83e0dcbeac9a..5b72048d50da 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -6,8 +6,7 @@ import csv
>  import json
>  import os
>  import sys
> -from typing import Callable
> -from typing import Sequence
> +from typing import (Callable, Optional, Sequence)
>  
>  # Global command line arguments.
>  _args = None
> @@ -57,7 +56,7 @@ class JsonEvent:
>                                         '. '), '.').replace('\n', '\\n').replace(
>                                             '\"', '\\"').replace('\r', '\\r')
>  
> -    def convert_aggr_mode(aggr_mode: str) -> str:
> +    def convert_aggr_mode(aggr_mode: str) -> Optional[str]:
>        """Returns the aggr_mode_class enum value associated with the JSON string."""
>        if not aggr_mode:
>          return None
> @@ -67,7 +66,7 @@ class JsonEvent:
>        }
>        return aggr_mode_to_enum[aggr_mode]
>  
> -    def lookup_msr(num: str) -> str:
> +    def lookup_msr(num: str) -> Optional[str]:
>        """Converts the msr number, or first in a list to the appropriate event field."""
>        if not num:
>          return None
> @@ -79,7 +78,7 @@ class JsonEvent:
>        }
>        return msrmap[int(num.split(',', 1)[0], 0)]
>  
> -    def real_event(name: str, event: str) -> str:
> +    def real_event(name: str, event: str) -> Optional[str]:
>        """Convert well known event names to an event string otherwise use the event argument."""
>        fixed = {
>            'inst_retired.any': 'event=0xc0,period=2000003',
> @@ -95,7 +94,7 @@ class JsonEvent:
>          return fixed[name.lower()]
>        return event
>  
> -    def unit_to_pmu(unit: str) -> str:
> +    def unit_to_pmu(unit: str) -> Optional[str]:
>        """Convert a JSON Unit to Linux PMU name."""
>        if not unit:
>          return None
> @@ -154,7 +153,7 @@ class JsonEvent:
>      if self.metric_expr:
>        self.metric_expr = self.metric_expr.replace('\\', '\\\\')
>      arch_std = jd.get('ArchStdEvent')
> -    if precise and self.desc and not '(Precise Event)' in self.desc:
> +    if precise and self.desc and '(Precise Event)' not in self.desc:
>        extra_desc += ' (Must be precise)' if precise == '2' else (' (Precise '
>                                                                   'event)')
>      event = f'config={llx(configcode)}' if configcode is not None else f'event={llx(eventcode)}'
> -- 
> 2.37.1.559.g78731f0fdb-goog

-- 

- Arnaldo
