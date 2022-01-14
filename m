Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FBF48E774
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbiANJ0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:26:41 -0500
Received: from foss.arm.com ([217.140.110.172]:58742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239692AbiANJ0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:26:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 509D01FB;
        Fri, 14 Jan 2022 01:26:40 -0800 (PST)
Received: from [10.57.34.164] (unknown [10.57.34.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 753183F766;
        Fri, 14 Jan 2022 01:26:38 -0800 (PST)
Subject: Re: [PATCH] perf arm: Fix off-by-one directory path.
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexandre Truong <alexandre.truong@arm.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220114064822.1806019-1-irogers@google.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <42fbdd13-c8a8-404b-a452-1e796c2e5a8b@arm.com>
Date:   Fri, 14 Jan 2022 09:26:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220114064822.1806019-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

I think there's another include in "utils/intel-pt.c" that may need the same treatment.

On 14/01/2022 06:48, Ian Rogers wrote:
> Relative path include works in the regular build due to -I paths but may
> fail in other situations.
>
> Fixes: 83869019c74c ("perf arch: Support register names from all archs")
> Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: German Gomez <german.gomez@arm.com>

Thanks,
German
> ---
>  tools/perf/util/arm64-frame-pointer-unwind-support.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/arm64-frame-pointer-unwind-support.c b/tools/perf/util/arm64-frame-pointer-unwind-support.c
> index 4f5ecf51ed38..2242a885fbd7 100644
> --- a/tools/perf/util/arm64-frame-pointer-unwind-support.c
> +++ b/tools/perf/util/arm64-frame-pointer-unwind-support.c
> @@ -6,7 +6,7 @@
>  #include "unwind.h"
>  
>  #define perf_event_arm_regs perf_event_arm64_regs
> -#include "../arch/arm64/include/uapi/asm/perf_regs.h"
> +#include "../../arch/arm64/include/uapi/asm/perf_regs.h"
>  #undef perf_event_arm_regs
>  
>  struct entries {
