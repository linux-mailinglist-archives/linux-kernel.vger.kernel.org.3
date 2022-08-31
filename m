Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CF75A808A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiHaOq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiHaOqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:46:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558A1CCD71;
        Wed, 31 Aug 2022 07:46:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6D0961BD5;
        Wed, 31 Aug 2022 14:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE63C433C1;
        Wed, 31 Aug 2022 14:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661957180;
        bh=lqpPcXkImr6A1YIuQW3MpU4TfTVgyOEdM5tqW3vP7fM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=okE+VyqBN6b0faor/MkoS+6L4lA7CPYrcPyuU+rFJC1ZOVTkbbnQAGeql0YdlZd8L
         c53w0Sf1AYzVB/DgXZk7YeVCDJiukBhmR99lUNHG8rB5iKTEsITKFoEhA0H8sw4aOX
         Nk7o46hRSWu+w8U04maS8JtfM608TOuh/ekXH73NdIE4pvdJmmslj1K1241C4pVdqa
         3pIpiPW32jXfvp/QFTcz+NOa+polP/+BNZMSFDCfWp9UbyzKWikU/mFvZjgtuv6+X7
         Rou3PSpMvzEDwKQ7oLMK/drj/IuBHaRfGPxHD6zTucVTz1BzEJf7cV2JmH30CeqNNL
         h9KPpYknKxLHQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 035BC404A1; Wed, 31 Aug 2022 11:46:17 -0300 (-03)
Date:   Wed, 31 Aug 2022 11:46:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 1/8] perf smt: Tidy header guard add SPDX
Message-ID: <Yw90OVKX0WV31REs@kernel.org>
References: <20220830164846.401143-1-irogers@google.com>
 <20220830164846.401143-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830164846.401143-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 30, 2022 at 09:48:39AM -0700, Ian Rogers escreveu:
> Make the header guard consistent with others.

Thanks, applied to perf/core, pushing it out now.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/smt.c | 1 +
>  tools/perf/util/smt.h | 7 ++++---
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
> index 2b0a36ebf27a..8fed03283c85 100644
> --- a/tools/perf/util/smt.c
> +++ b/tools/perf/util/smt.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> diff --git a/tools/perf/util/smt.h b/tools/perf/util/smt.h
> index b8414b7bcbc8..a98d65808f6a 100644
> --- a/tools/perf/util/smt.h
> +++ b/tools/perf/util/smt.h
> @@ -1,6 +1,7 @@
> -#ifndef SMT_H
> -#define SMT_H 1
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __SMT_H
> +#define __SMT_H 1
>  
>  int smt_on(void);
>  
> -#endif
> +#endif /* __SMT_H */
> -- 
> 2.37.2.672.g94769d06f0-goog

-- 

- Arnaldo
