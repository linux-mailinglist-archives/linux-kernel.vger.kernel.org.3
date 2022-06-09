Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856AD544D17
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242037AbiFINHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbiFINHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:07:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D049243ADB;
        Thu,  9 Jun 2022 06:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654780040; x=1686316040;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Fl/DeaRiuO25zldEFBbUHA7BW4qeWpTsDW533TsAWhc=;
  b=gz4hz1I1QlrwXlGZ5h/01fUkE/DB2QWA6qRiYEBMAE0jplD5Cd+/cJSB
   FEa5qQvjIUWWslkAX/70Ma84II32ktpHykPSgG0fQAS62LovwHNel+SB2
   ORFzIRWBUqLWJNGub6BO9YW2hamF5s/QKMi+o2xw5rwLUNTgIeAruWDnC
   HMr+q/5JJYh2/QDZYvGpbCGeH98Dw9UmiTI+5pvGsRxeBgI5U6btH4Zc8
   R/KtojAWIgCcTRNgL4s4ObYvlfOcZXCvrSP3ikAnkqepHaX2FkJB+dD3G
   C2SvZkxkkjLPPbWwltm9QitISAEDtsUooWhv7VEkEc1uRfvaxT60pI4LZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="302642056"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="302642056"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 06:07:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="580577218"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 09 Jun 2022 06:07:20 -0700
Received: from [10.252.211.126] (kliang2-MOBL.ccr.corp.intel.com [10.252.211.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 9885B5808F0;
        Thu,  9 Jun 2022 06:07:18 -0700 (PDT)
Message-ID: <501e5a2f-4e5a-1d32-b933-5b74e9775aa5@linux.intel.com>
Date:   Thu, 9 Jun 2022 09:07:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] perf vendor events intel: Rename tremontx to
 snowridgex
Content-Language: en-US
To:     zhengjun.xing@linux.intel.com, acme@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com
References: <20220609094222.2030167-1-zhengjun.xing@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220609094222.2030167-1-zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/2022 5:42 AM, zhengjun.xing@linux.intel.com wrote:
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> 
> Tremontx was an old name for Snowridgex, so rename Tremontx to Snowridgex.
> 
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>

The patch series look good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
> Change log:
>    v2:
>      * no change since v1.
> 
>   tools/perf/pmu-events/arch/x86/mapfile.csv                      | 2 +-
>   .../pmu-events/arch/x86/{tremontx => snowridgex}/cache.json     | 0
>   .../arch/x86/{tremontx => snowridgex}/floating-point.json       | 0
>   .../pmu-events/arch/x86/{tremontx => snowridgex}/frontend.json  | 0
>   .../pmu-events/arch/x86/{tremontx => snowridgex}/memory.json    | 0
>   .../pmu-events/arch/x86/{tremontx => snowridgex}/other.json     | 0
>   .../pmu-events/arch/x86/{tremontx => snowridgex}/pipeline.json  | 0
>   .../arch/x86/{tremontx => snowridgex}/uncore-memory.json        | 0
>   .../arch/x86/{tremontx => snowridgex}/uncore-other.json         | 0
>   .../arch/x86/{tremontx => snowridgex}/uncore-power.json         | 0
>   .../arch/x86/{tremontx => snowridgex}/virtual-memory.json       | 0
>   11 files changed, 1 insertion(+), 1 deletion(-)
>   rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/cache.json (100%)
>   rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/floating-point.json (100%)
>   rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/frontend.json (100%)
>   rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/memory.json (100%)
>   rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/other.json (100%)
>   rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/pipeline.json (100%)
>   rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/uncore-memory.json (100%)
>   rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/uncore-other.json (100%)
>   rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/uncore-power.json (100%)
>   rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/virtual-memory.json (100%)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
> index f5a382421a60..9852bca98d59 100644
> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> @@ -40,7 +40,7 @@ GenuineIntel-6-8[CD],v1,tigerlake,core
>   GenuineIntel-6-A7,v1,icelake,core
>   GenuineIntel-6-6A,v1,icelakex,core
>   GenuineIntel-6-6C,v1,icelakex,core
> -GenuineIntel-6-86,v1,tremontx,core
> +GenuineIntel-6-86,v1,snowridgex,core
>   GenuineIntel-6-96,v1,elkhartlake,core
>   GenuineIntel-6-97,v1,alderlake,core
>   GenuineIntel-6-9A,v1,alderlake,core
> diff --git a/tools/perf/pmu-events/arch/x86/tremontx/cache.json b/tools/perf/pmu-events/arch/x86/snowridgex/cache.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/x86/tremontx/cache.json
> rename to tools/perf/pmu-events/arch/x86/snowridgex/cache.json
> diff --git a/tools/perf/pmu-events/arch/x86/tremontx/floating-point.json b/tools/perf/pmu-events/arch/x86/snowridgex/floating-point.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/x86/tremontx/floating-point.json
> rename to tools/perf/pmu-events/arch/x86/snowridgex/floating-point.json
> diff --git a/tools/perf/pmu-events/arch/x86/tremontx/frontend.json b/tools/perf/pmu-events/arch/x86/snowridgex/frontend.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/x86/tremontx/frontend.json
> rename to tools/perf/pmu-events/arch/x86/snowridgex/frontend.json
> diff --git a/tools/perf/pmu-events/arch/x86/tremontx/memory.json b/tools/perf/pmu-events/arch/x86/snowridgex/memory.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/x86/tremontx/memory.json
> rename to tools/perf/pmu-events/arch/x86/snowridgex/memory.json
> diff --git a/tools/perf/pmu-events/arch/x86/tremontx/other.json b/tools/perf/pmu-events/arch/x86/snowridgex/other.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/x86/tremontx/other.json
> rename to tools/perf/pmu-events/arch/x86/snowridgex/other.json
> diff --git a/tools/perf/pmu-events/arch/x86/tremontx/pipeline.json b/tools/perf/pmu-events/arch/x86/snowridgex/pipeline.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/x86/tremontx/pipeline.json
> rename to tools/perf/pmu-events/arch/x86/snowridgex/pipeline.json
> diff --git a/tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json
> rename to tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json
> diff --git a/tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-other.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json
> rename to tools/perf/pmu-events/arch/x86/snowridgex/uncore-other.json
> diff --git a/tools/perf/pmu-events/arch/x86/tremontx/uncore-power.json b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/x86/tremontx/uncore-power.json
> rename to tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
> diff --git a/tools/perf/pmu-events/arch/x86/tremontx/virtual-memory.json b/tools/perf/pmu-events/arch/x86/snowridgex/virtual-memory.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/x86/tremontx/virtual-memory.json
> rename to tools/perf/pmu-events/arch/x86/snowridgex/virtual-memory.json
