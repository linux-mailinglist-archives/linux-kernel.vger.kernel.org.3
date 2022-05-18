Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4365E52BC96
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbiERM6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237099AbiERM6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:58:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D26D199485;
        Wed, 18 May 2022 05:58:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 015B523A;
        Wed, 18 May 2022 05:58:34 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BA563F73D;
        Wed, 18 May 2022 05:58:31 -0700 (PDT)
Message-ID: <9c133432-a1de-5896-4ee8-e73079844fa6@arm.com>
Date:   Wed, 18 May 2022 13:58:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 06/20] perf vendors events arm64: Arm Cortex-A17
Content-Language: en-GB
To:     Nick Forrington <nick.forrington@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>
References: <20220510104758.64677-1-nick.forrington@arm.com>
 <20220510104758.64677-7-nick.forrington@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220510104758.64677-7-nick.forrington@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-10 11:47, Nick Forrington wrote:
> Add PMU events for Arm Cortex-A17
> Update mapfile.csv
> 
> Event data based on:
> https://github.com/ARM-software/data/tree/master/pmu/cortex-a17.json
> 
> which is based on PMU event descriptions from the Arm Cortex-A17 Technical
> Reference Manual.
> 
> Mapping data (for mapfile.csv) based on:
> https://github.com/ARM-software/data/blob/master/cpus.json
> 
> which is based on Main ID Register (MIDR) information found in the Arm
> Technical Reference Manuals for individual CPUs.
> 
> Signed-off-by: Nick Forrington <nick.forrington@arm.com>
> ---
[...]
> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> index 536652b8580b..c24291e0d757 100644
> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> @@ -16,6 +16,7 @@
>   0x00000000410fc070,v1,arm/cortex-a7,core
>   0x00000000410fc080,v1,arm/cortex-a8,core
>   0x00000000410fc090,v1,arm/cortex-a9,core
> +0x00000000410fc0e0,v1,arm/cortex-a17,core
>   0x00000000410fc0f0,v1,arm/cortex-a15,core
>   0x00000000410fd030,v1,arm/cortex-a53,core
>   0x00000000420f1000,v1,arm/cortex-a53,core

Note that 0x410fc0d0 is also Cortex-A17. Those are found in at least 
Rockchip's RK3288 SoCs, which are still quite widely used.

Robin.
