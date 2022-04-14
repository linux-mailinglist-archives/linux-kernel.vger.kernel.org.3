Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9435018E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiDNQlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236666AbiDNQkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:40:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951FD48315
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:09:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i20so7555499wrb.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V33pCXKrVlTUkLXfSIexapGNkPRHIENf3OMqs9myXaY=;
        b=Spkm10kCvAJD5+obPAujE+rdxQOYm2qh75gZXZZWUghEv3XEO1v/h81kTsdwuHjkft
         BtqvDW7wMAKZFW9mqIkLtc5pUjPEWnLn7i0JPngSlPO0WxXNNv+RtFJmIamfVj7P2xiY
         rL0Y4so4C0Y+c/RTvgtYwD1BO9DFty3IHX3p+Zy48B8kH5rH/h9QUFyj9kWlZL1iSbSR
         1ZvAN682icJoFceIPfKBYogdF7+cx8Ew5NgYohtcj7hjt2VcG7GWemkbFUU0BVinrIqb
         R+K9KM9IGAC/8nJDfL5mOzkYw32GlYUsTCnWN9IrprkDvTKtzeZcyMmD8v3XzmTatVyt
         H3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V33pCXKrVlTUkLXfSIexapGNkPRHIENf3OMqs9myXaY=;
        b=DPlX0Ahgc1rliKiiy+nyb8mWSywFMOAgMJZqJirl37SbrQis8rpwtN1bUEV+ur+w+i
         gfnA3iof/EZztHYSlAx6FjV48I0XceS9ZABrBSLcHGiJtFOy6x+zvDhzg0jhFtVqDPKS
         AcGUIdr7kmtlN4lmmGjbr26GKX7Z6teySRWTawfX+b0YS/A5T/vnclLtNTxlXpnouU1W
         UIgLS+Cbtgc3lq6dKk/XQbwNkUuXVRDUiuL1DnwxfDVFPDJxPgGoMcZvg1twdA/EQh+I
         +CZ0Wyl8w7qLjMRUW9tc1cYtVxUWqE6qmLoP5O0dbz/9X8lZh4Nj2Us48xXfWrdDamnU
         Ajpw==
X-Gm-Message-State: AOAM532FHuG0XFX+2rkfnhPPq7HY9XfWq0frjT5bctC+TWpPIfCD9rRi
        gzE/ebWNWNRNJyKPK/Qi7ZrKx3xoZd+jhfvVfALjIA==
X-Google-Smtp-Source: ABdhPJw50hibtjmek8w+DcJBpzF5yt3/Nu2B2Rhg7iZgQuPlzymVkVxRsJi3BSylWzx/vXQdpm412KCOSPB7nYeAzYk=
X-Received: by 2002:a5d:6241:0:b0:207:ac0e:3549 with SMTP id
 m1-20020a5d6241000000b00207ac0e3549mr2601165wrv.343.1649952587822; Thu, 14
 Apr 2022 09:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220304083329.GC20556@xsang-OptiPlex-9020> <CAP-5=fVz=arWo19PQR_4UKY_PyywyXoyp+MUnfAJxCFZy5rhWg@mail.gmail.com>
 <20220413070529.GA1320@linux.intel.com> <CAP-5=fXGqODZYGu781qjEEVtGFpCQJ=dCXi5shYOAbBSt5wQkw@mail.gmail.com>
 <85eed89f-e4a8-2887-a0b3-579704304357@linux.intel.com> <CAP-5=fXj+WT3ExNo-fL4d9b_Wm5swnKaCWd67rU85Q=QFg5KUw@mail.gmail.com>
 <74d36e66-5b16-ee10-bcae-171e2b681845@linux.intel.com>
In-Reply-To: <74d36e66-5b16-ee10-bcae-171e2b681845@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 14 Apr 2022 09:09:35 -0700
Message-ID: <CAP-5=fX+Hqf5xYTCqBXNCz5-ZPaZ7ChNUgoRyH1+JhiAqj79nQ@mail.gmail.com>
Subject: Re: [LKP] Re: [perf vendor events] 3f5f0df7bf: perf-sanity-tests.perf_all_metrics_test.fail
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Carel Si <beibei.si@intel.com>, acme@redhat.com,
        alexander.shishkin@linux.intel.com, alexandre.torgue@foss.st.com,
        ak@linux.intel.com, mingo@redhat.com, james.clark@arm.com,
        jolsa@kernel.org, john.garry@huawei.com, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, namhyung@kernel.org,
        peterz@infradead.org, eranian@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, lkp@lists.01.org,
        lkp@intel.com
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

On Wed, Apr 13, 2022 at 11:17 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 4/13/2022 1:09 PM, Ian Rogers wrote:
> > On Wed, Apr 13, 2022 at 9:37 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >>
> >>
> >>
> >> On 4/13/2022 12:03 PM, Ian Rogers wrote:
> >>> 3) Weak group doesn't fall back to no group:
> >>
> >> That's because the group validation code doesn't take pinned events,
> >> such as the NMI watchdog, into account.
> >>
> >> I proposed a kernel patch to fix it, but it's rejected. It should be
> >> hard to find a generic way to fix it from the kernel side.
> >> https://lore.kernel.org/lkml/1565977750-76693-1-git-send-email-kan.liang@linux.intel.com/
> >>
> >> Maybe we can workaround it from the perf tool side?
> >> For example, for each weak group with cycles event and NMI watchdog is
> >> enabled, add an extra cycles event when opening the group. If the open
> >> fails with the extra cycles event, fall back to no group. After the
> >> extra cycles event check, remove the extra cycles.
> >>
> >> What do you think?
> >
> > Thanks Kan, it is a shame the kernel support is lacking here. I'm not
> > sure what you are proposing for the perf tool to do. So:
> >
> >> for each weak group with cycles event and NMI watchdog
> >
> > Okay, let's try Branching_Overhead as mentioned in this report - but
> > the event is CPU_CLK_UNHALTED.THREAD here :-/
> >
> >> add an extra cycles event when opening the group
> >
> > So the perf_event_open doesn't fail here for me:
> > $ perf stat -e '{BR_INST_RETIRED.NEAR_CALL,BR_INST_RETIRED.NEAR_TAKEN,BR_INST_RETIRED.NOT_TAKEN,BR_INST_RETIRED.CONDITIONAL,CPU_CLK_UNHALTED.THREAD},cycles'
> > -a sleep 1
> >
>
> No, I mean modifying the perf tool code and add an extra cycles in the
> weak group.
>
> Here is a very initial POC patch, which should prove the idea.

So I was unaware of this behavior, great find! However, it seems
difficult to exploit. Here is the extra cycles "fixing" a weak group:
```
$ perf stat -e '{BR_INST_RETIRED.NEAR_CALL,BR_INST_RETIRED.NEAR_TAKEN,BR_INST_RETIRED.NOT_TAKEN,BR_INST_RETIRED.CONDITIONAL,cycles,cycles}:W'
-a sleep 1

 Performance counter stats for 'system wide':

        18,782,301      BR_INST_RETIRED.NEAR_CALL
               (66.64%)
       153,325,072      BR_INST_RETIRED.NEAR_TAKEN
                (66.64%)
        75,443,263      BR_INST_RETIRED.NOT_TAKEN
               (66.64%)
       156,568,769      BR_INST_RETIRED.CONDITIONAL
                 (66.66%)
     1,870,812,571      cycles
               (66.72%)
     1,890,508,326      cycles
               (66.70%)

       1.006371081 seconds time elapsed
```

But if the original group has 1 less counter we will fail with the
duplicate cycles:
```
$ perf stat -e '{BR_INST_RETIRED.NEAR_CALL,BR_INST_RETIRED.NEAR_TAKEN,BR_INST_RETIRED.NOT_TAKEN,cycles,cycles}:W'
-a sleep 1
 Performance counter stats for 'system wide':

     <not counted>      BR_INST_RETIRED.NEAR_CALL
               (0.00%)
     <not counted>      BR_INST_RETIRED.NEAR_TAKEN
                (0.00%)
     <not counted>      BR_INST_RETIRED.NOT_TAKEN
               (0.00%)
     <not counted>      cycles
               (0.00%)
     <not counted>      cycles
               (0.00%)

       1.005599088 seconds time elapsed

Some events weren't counted. Try disabling the NMI watchdog:
        echo 0 > /proc/sys/kernel/nmi_watchdog
        perf stat ...
        echo 1 > /proc/sys/kernel/nmi_watchdog
The events in group usually have to be from the same PMU. Try
reorganizing the group.
```

If we add two extra cycles or the original group is smaller then it is "fixed":
```
$ perf stat -e '{BR_INST_RETIRED.NEAR_CALL,BR_INST_RETIRED.NEAR_TAKEN,BR_INST_RETIRED.NOT_TAKEN,cycles}:W'
-a sleep 1

 Performance counter stats for 'system wide':

        20,378,789      BR_INST_RETIRED.NEAR_CALL
       168,420,963      BR_INST_RETIRED.NEAR_TAKEN
        96,330,608      BR_INST_RETIRED.NOT_TAKEN
     1,652,230,042      cycles

       1.008757590 seconds time elapsed

$ perf stat -e '{BR_INST_RETIRED.NEAR_CALL,BR_INST_RETIRED.NEAR_TAKEN,BR_INST_RETIRED.NOT_TAKEN,cycles,cycles,cycles}:W'
-a sleep 1

 Performance counter stats for 'system wide':

        37,696,638      BR_INST_RETIRED.NEAR_CALL
               (66.62%)
       298,535,151      BR_INST_RETIRED.NEAR_TAKEN
                (66.63%)
       297,011,663      BR_INST_RETIRED.NOT_TAKEN
               (66.63%)
     3,155,711,474      cycles
               (66.65%)
     3,194,919,959      cycles
               (66.74%)
     3,126,664,102      cycles
               (66.72%)

       1.006237962 seconds time elapsed
```

So the extra cycles is needed to fix weak groups when the nmi watchdog
is enabled and the group is an architecture dependent size.

Thanks,
Ian

> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index b7fe88beb584..782c3d7f1b32 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -71,7 +71,9 @@
>   #include "util/bpf_counter.h"
>   #include "util/iostat.h"
>   #include "util/pmu-hybrid.h"
> +#include "util/util.h"
>   #include "asm/bug.h"
> +#include "perf-sys.h"
>
>   #include <linux/time64.h>
>   #include <linux/zalloc.h>
> @@ -777,6 +779,8 @@ static enum counter_recovery
> stat_handle_error(struct evsel *counter)
>         return COUNTER_FATAL;
>   }
>
> +#define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
> +
>   static int __run_perf_stat(int argc, const char **argv, int run_idx)
>   {
>         int interval = stat_config.interval;
> @@ -793,6 +797,7 @@ static int __run_perf_stat(int argc, const char
> **argv, int run_idx)
>         struct affinity saved_affinity, *affinity = NULL;
>         int err;
>         bool second_pass = false;
> +       bool has_cycles = false;
>
>         if (forks) {
>                 if (evlist__prepare_workload(evsel_list, &target, argv, is_pipe,
> workload_exec_failed_signal) < 0) {
> @@ -821,6 +826,8 @@ static int __run_perf_stat(int argc, const char
> **argv, int run_idx)
>         evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity) {
>                 counter = evlist_cpu_itr.evsel;
>
> +               if (counter->core.attr.config == 0x3c)
> +                       has_cycles = true;
>                 /*
>                  * bperf calls evsel__open_per_cpu() in bperf__load(), so
>                  * no need to call it again here.
> @@ -867,6 +874,24 @@ static int __run_perf_stat(int argc, const char
> **argv, int run_idx)
>                 counter->supported = true;
>         }
>
> +       //make it model specific. need to move to a better place
> +       if (counter->supported && !second_pass && has_cycles &&
> counter->weak_group && sysctl__nmi_watchdog_enabled()) {
> +               struct evsel *leader = evsel__leader(counter);
> +               int group_fd = FD(leader, 0, 0);
> +               struct evsel *evsel;
> +               int fd;
> +
> +               evsel = evsel__new_cycles(0, PERF_TYPE_HARDWARE,
> PERF_COUNT_HW_CPU_CYCLES);
> +               fd = sys_perf_event_open(&evsel->core.attr, -1, 0, group_fd, 0x8);
> +
> +               if (fd < 0) {
> +                       evlist__reset_weak_group(evsel_list, counter, false);
> +                       second_pass = true;
> +               } else {
> +                       evsel__close(evsel);
> +               }
> +       }
> +
>         if (second_pass) {
>                 /*
>                  * Now redo all the weak group after closing them,
>
> With the above patch,
>
> $ sudo ./perf stat -e
> '{BR_INST_RETIRED.NEAR_CALL,BR_INST_RETIRED.NEAR_TAKEN,BR_INST_RETIRED.NOT_TAKEN,BR_INST_RETIRED.CONDITIONAL,CPU_CLK_UNHALTED.THREAD}:W'
> -C0 sleep 1
>
>   Performance counter stats for 'CPU(s) 0':
>
>             913,369      BR_INST_RETIRED.NEAR_CALL
>                        (79.95%)
>           3,648,433      BR_INST_RETIRED.NEAR_TAKEN
>                        (80.00%)
>           2,481,976      BR_INST_RETIRED.NOT_TAKEN
>                        (80.05%)
>           3,696,298      BR_INST_RETIRED.CONDITIONAL
>                        (80.04%)
>          27,792,053      CPU_CLK_UNHALTED.THREAD
>                        (79.96%)
>
>         1.002224709 seconds time elapsed
>
>
> Thanks,
> Kan
