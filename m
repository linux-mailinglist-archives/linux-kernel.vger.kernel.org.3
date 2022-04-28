Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA72C5134A3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346880AbiD1NP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346881AbiD1NPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:15:55 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2113B1D0E1;
        Thu, 28 Apr 2022 06:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651151550; x=1682687550;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Vked9xxCpT7BEnneGBx9LX5/jjKxi3vv+2X+ThsLAtU=;
  b=SNH7xCYWbHhCWoHQf7S2npdfCCCjG3ysslAp84UBxduVFSXtZmQgJgvn
   n9SqA8yir+bW0ojuNVgRtEtZ1CKn77yXivoqTzQ0+06OEw/g9bZ+wn/Fw
   /l+R0sLZuamDwIgZERjXqIFZx7qz7vNHyCjyMfFWqwA0DieQApwpKko29
   wtRZOSLZHlwvl4aDgNebV/f2iJaBbyznY6IoiZNHn9ce6z3QIG6GzK3Id
   XV3P9kB2RGO48Dv628iIpoaElgkDpfbEdkgdXkgKaMc7YmmdNn6VoJyVo
   y27zdFWungiV6rjpMAKXTlpXoj81DoWVBcb+RJWvztIIeyJtXqh8hKWuT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="291446708"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="291446708"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 06:12:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="541267358"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 28 Apr 2022 06:12:29 -0700
Received: from [10.209.10.70] (kliang2-MOBL.ccr.corp.intel.com [10.209.10.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id DCE95580689;
        Thu, 28 Apr 2022 06:12:27 -0700 (PDT)
Message-ID: <96b5c9f4-f0a0-0019-8059-3e833c95b011@linux.intel.com>
Date:   Thu, 28 Apr 2022 09:12:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/7] perf vendor events intel: Update CLX events to v1.15
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20220428075730.797727-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220428075730.797727-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/28/2022 3:57 AM, Ian Rogers wrote:
> Events are generated for CascadeLake Server v1.15 with
> events from:
> https://download.01.org/perfmon/CLX/
> 
> Using the scripts at:
> https://github.com/intel/event-converter-for-linux-perf/
> 
> This change updates descriptions, adds INST_DECODED.DECODERS and
> corrects a counter mask in UOPS_RETIRED.TOTAL_CYCLES.
> 
> Signed-off-by: Ian Rogers<irogers@google.com>

Thanks Ian. For the whole series,

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>   .../arch/x86/cascadelakex/cache.json          | 1164 +----------------
>   .../arch/x86/cascadelakex/memory.json         |  702 +---------
>   .../arch/x86/cascadelakex/other.json          |  156 +--
>   .../arch/x86/cascadelakex/pipeline.json       |   14 +-
>   .../arch/x86/cascadelakex/uncore-other.json   |    4 +-
>   5 files changed, 17 insertions(+), 2023 deletions(-)
