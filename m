Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEBE5A30A9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 22:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344539AbiHZUy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 16:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiHZUyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 16:54:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4CFD419C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 13:54:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n17so3121607wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 13:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dvxno4X8i6Habr4MW9y4dL3pbii1oz+8XCqowt3Ghik=;
        b=lIkVRggySk4QpXUZQ/Sw1+9Fw2/Kd+29Yy/kgdXnM6oEAYgW9O5w3XYYnQ0C817H4z
         bZS5LJEdFF9LFJPUCArbmo2Y8phPoC0TSzOIY/viAzXhjx5HVwRUTD34zmUOTzBRHHuK
         hP+iHWmy7Bo1vU1o2YxFB4QfenZnpGq10qXZu14llyg4g/PynWta8chdviJAoJewC5Fm
         X3pagtWM9fHD+Fk8ALzzFa0uA0xM2a+nZnvRVSNVRupFC3WfyYytQKOs0ZSG8lpoXsAS
         5jLMTHUxYPlb17ljnrxtOKKTPS/hz8FyAjqtMRvOftu3Q942nG8xCQEYzO4KTQv1v1bN
         lGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dvxno4X8i6Habr4MW9y4dL3pbii1oz+8XCqowt3Ghik=;
        b=l/PGhTP1kpoP468mgaEGQ9JxM6dvfqRXYXd5HCzUCcZPoYpsb9EUPe6mGG5oW4Yba3
         z4hRRo7T+bX+vQmbeFXmRM1QJ6l0suf0lBSpRwmpYy/+OmI82uzKW0byQ8PSAK3ZsM/P
         2SvDUm1JahOMzTsAW3QppQTZ1agVE+d0j3ErqxyBypsjMgAahCt3xcLi/gFoMJ4ZX5GD
         hyXzdtwR1X21hYqYtu1w0HzKza89kkLXGJxGwAmmQw1YkSP+arSg0GCB4iBnxnKe852d
         me0roWrViWGsgSjoAdriG12VU3VfJKlGEI60YQRfrx6MIcTcyBOZylUfZnuJAjvo7jQv
         Jo4w==
X-Gm-Message-State: ACgBeo2aEphxN/n/NqkOxnN4x1hoIXZP3TO67HFLhjtV+/PldqNuYBUg
        PRRS8XmDc0RngEm1LYrkbkPLQoEdB2Z+oQ3yZ7OWLA==
X-Google-Smtp-Source: AA6agR4Qip1upUGXtZ5/LeJql1hF7uMbTBRROkqVpnszU22FEydmAskC/xOgyfaqn6fxZQqceLH+O08+KDduFdRe1uU=
X-Received: by 2002:a05:6000:1a87:b0:222:2c85:2f5b with SMTP id
 f7-20020a0560001a8700b002222c852f5bmr742347wry.654.1661547261033; Fri, 26 Aug
 2022 13:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220825015458.3252239-1-zhengjun.xing@linux.intel.com>
In-Reply-To: <20220825015458.3252239-1-zhengjun.xing@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 Aug 2022 13:54:09 -0700
Message-ID: <CAP-5=fXzeqd3kS15_+9fEFERJtxkJLvP5sEj597D-BMmAwSheA@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Capitalize topdown metrics' names
To:     zhengjun.xing@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 6:53 PM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>
> Capitalize topdown metrics' names to follow the intel SDM.
>
> Before:
>
>  # ./perf stat -a  sleep 1
>
>  Performance counter stats for 'system wide':
>
>         228,094.05 msec cpu-clock                        #  225.026 CPUs utilized
>                842      context-switches                 #    3.691 /sec
>                224      cpu-migrations                   #    0.982 /sec
>                 70      page-faults                      #    0.307 /sec
>         23,164,105      cycles                           #    0.000 GHz
>         29,403,446      instructions                     #    1.27  insn per cycle
>          5,268,185      branches                         #   23.097 K/sec
>             33,239      branch-misses                    #    0.63% of all branches
>        136,248,990      slots                            #  597.337 K/sec
>         32,976,450      topdown-retiring                 #     24.2% retiring
>          4,651,918      topdown-bad-spec                 #      3.4% bad speculation
>         26,148,695      topdown-fe-bound                 #     19.2% frontend bound
>         72,515,776      topdown-be-bound                 #     53.2% backend bound
>          6,008,540      topdown-heavy-ops                #      4.4% heavy operations       #     19.8% light operations
>          3,934,049      topdown-br-mispredict            #      2.9% branch mispredict      #      0.5% machine clears
>         16,655,439      topdown-fetch-lat                #     12.2% fetch latency          #      7.0% fetch bandwidth
>         41,635,972      topdown-mem-bound                #     30.5% memory bound           #     22.7% Core bound
>
>        1.013634593 seconds time elapsed
>
> After:
>
>  # ./perf stat -a  sleep 1
>
>  Performance counter stats for 'system wide':
>
>         228,081.94 msec cpu-clock                        #  225.003 CPUs utilized
>                824      context-switches                 #    3.613 /sec
>                224      cpu-migrations                   #    0.982 /sec
>                 67      page-faults                      #    0.294 /sec
>         22,647,423      cycles                           #    0.000 GHz
>         28,870,551      instructions                     #    1.27  insn per cycle
>          5,167,099      branches                         #   22.655 K/sec
>             32,383      branch-misses                    #    0.63% of all branches
>        133,411,074      slots                            #  584.926 K/sec
>         32,352,607      topdown-retiring                 #     24.3% Retiring
>          4,456,977      topdown-bad-spec                 #      3.3% Bad Speculation
>         25,626,487      topdown-fe-bound                 #     19.2% Frontend Bound
>         70,955,316      topdown-be-bound                 #     53.2% Backend Bound
>          5,834,844      topdown-heavy-ops                #      4.4% Heavy Operations       #     19.9% Light Operations
>          3,738,781      topdown-br-mispredict            #      2.8% Branch Mispredict      #      0.5% Machine Clears
>         16,286,803      topdown-fetch-lat                #     12.2% Fetch Latency          #      7.0% Fetch Bandwidth
>         40,802,069      topdown-mem-bound                #     30.6% Memory Bound           #     22.6% Core Bound
>
>        1.013683125 seconds time elapsed
>
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-shadow.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 979c8cb918f7..788ce5e46470 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -1193,7 +1193,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>                                                   &rsd);
>                 if (retiring > 0.7)
>                         color = PERF_COLOR_GREEN;
> -               print_metric(config, ctxp, color, "%8.1f%%", "retiring",
> +               print_metric(config, ctxp, color, "%8.1f%%", "Retiring",
>                                 retiring * 100.);
>         } else if (perf_stat_evsel__is(evsel, TOPDOWN_FE_BOUND) &&
>                    full_td(cpu_map_idx, st, &rsd)) {
> @@ -1202,7 +1202,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>                                                   &rsd);
>                 if (fe_bound > 0.2)
>                         color = PERF_COLOR_RED;
> -               print_metric(config, ctxp, color, "%8.1f%%", "frontend bound",
> +               print_metric(config, ctxp, color, "%8.1f%%", "Frontend Bound",
>                                 fe_bound * 100.);
>         } else if (perf_stat_evsel__is(evsel, TOPDOWN_BE_BOUND) &&
>                    full_td(cpu_map_idx, st, &rsd)) {
> @@ -1211,7 +1211,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>                                                   &rsd);
>                 if (be_bound > 0.2)
>                         color = PERF_COLOR_RED;
> -               print_metric(config, ctxp, color, "%8.1f%%", "backend bound",
> +               print_metric(config, ctxp, color, "%8.1f%%", "Backend Bound",
>                                 be_bound * 100.);
>         } else if (perf_stat_evsel__is(evsel, TOPDOWN_BAD_SPEC) &&
>                    full_td(cpu_map_idx, st, &rsd)) {
> @@ -1220,7 +1220,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>                                                   &rsd);
>                 if (bad_spec > 0.1)
>                         color = PERF_COLOR_RED;
> -               print_metric(config, ctxp, color, "%8.1f%%", "bad speculation",
> +               print_metric(config, ctxp, color, "%8.1f%%", "Bad Speculation",
>                                 bad_spec * 100.);
>         } else if (perf_stat_evsel__is(evsel, TOPDOWN_HEAVY_OPS) &&
>                         full_td(cpu_map_idx, st, &rsd) && (config->topdown_level > 1)) {
> @@ -1234,13 +1234,13 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>
>                 if (retiring > 0.7 && heavy_ops > 0.1)
>                         color = PERF_COLOR_GREEN;
> -               print_metric(config, ctxp, color, "%8.1f%%", "heavy operations",
> +               print_metric(config, ctxp, color, "%8.1f%%", "Heavy Operations",
>                                 heavy_ops * 100.);
>                 if (retiring > 0.7 && light_ops > 0.6)
>                         color = PERF_COLOR_GREEN;
>                 else
>                         color = NULL;
> -               print_metric(config, ctxp, color, "%8.1f%%", "light operations",
> +               print_metric(config, ctxp, color, "%8.1f%%", "Light Operations",
>                                 light_ops * 100.);
>         } else if (perf_stat_evsel__is(evsel, TOPDOWN_BR_MISPREDICT) &&
>                         full_td(cpu_map_idx, st, &rsd) && (config->topdown_level > 1)) {
> @@ -1254,13 +1254,13 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>
>                 if (bad_spec > 0.1 && br_mis > 0.05)
>                         color = PERF_COLOR_RED;
> -               print_metric(config, ctxp, color, "%8.1f%%", "branch mispredict",
> +               print_metric(config, ctxp, color, "%8.1f%%", "Branch Mispredict",
>                                 br_mis * 100.);
>                 if (bad_spec > 0.1 && m_clears > 0.05)
>                         color = PERF_COLOR_RED;
>                 else
>                         color = NULL;
> -               print_metric(config, ctxp, color, "%8.1f%%", "machine clears",
> +               print_metric(config, ctxp, color, "%8.1f%%", "Machine Clears",
>                                 m_clears * 100.);
>         } else if (perf_stat_evsel__is(evsel, TOPDOWN_FETCH_LAT) &&
>                         full_td(cpu_map_idx, st, &rsd) && (config->topdown_level > 1)) {
> @@ -1274,13 +1274,13 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>
>                 if (fe_bound > 0.2 && fetch_lat > 0.15)
>                         color = PERF_COLOR_RED;
> -               print_metric(config, ctxp, color, "%8.1f%%", "fetch latency",
> +               print_metric(config, ctxp, color, "%8.1f%%", "Fetch Latency",
>                                 fetch_lat * 100.);
>                 if (fe_bound > 0.2 && fetch_bw > 0.1)
>                         color = PERF_COLOR_RED;
>                 else
>                         color = NULL;
> -               print_metric(config, ctxp, color, "%8.1f%%", "fetch bandwidth",
> +               print_metric(config, ctxp, color, "%8.1f%%", "Fetch Bandwidth",
>                                 fetch_bw * 100.);
>         } else if (perf_stat_evsel__is(evsel, TOPDOWN_MEM_BOUND) &&
>                         full_td(cpu_map_idx, st, &rsd) && (config->topdown_level > 1)) {
> @@ -1294,13 +1294,13 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>
>                 if (be_bound > 0.2 && mem_bound > 0.2)
>                         color = PERF_COLOR_RED;
> -               print_metric(config, ctxp, color, "%8.1f%%", "memory bound",
> +               print_metric(config, ctxp, color, "%8.1f%%", "Memory Bound",
>                                 mem_bound * 100.);
>                 if (be_bound > 0.2 && core_bound > 0.1)
>                         color = PERF_COLOR_RED;
>                 else
>                         color = NULL;
> -               print_metric(config, ctxp, color, "%8.1f%%", "Core bound",
> +               print_metric(config, ctxp, color, "%8.1f%%", "Core Bound",
>                                 core_bound * 100.);
>         } else if (evsel->metric_expr) {
>                 generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
> --
> 2.25.1
>
