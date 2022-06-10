Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811295460C8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347034AbiFJJEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245306AbiFJJEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:04:48 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B181DFC4D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:04:46 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id h23so2261143ljl.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGZRSNtjYVE5/AFVVZNo9Q/VK/BnWz0MKKsJwglLOK0=;
        b=JB1ke9QQ37tIXtvgm8KNnMmw3d4Y6vdy9bzJXoIBOhgleWP/iGl3OTEbLI6GU/gYpm
         AU/LO4HCsZeHme5w24TDDZ8kr3BC8DMzDuOyyghqIO5/N2wwqc1LLV0+4dRKLvUNLXcf
         QK1VgFwBMG6cRJIYH2YS2XN+2uKoWixg+Cy3CCH/P4EygwtTswMUvkw2vNn3V8zu3Dvc
         GOXyzCqMDpOV08m4qeqrKKU1vYr9pxauMPWEnBkKZqXMVHRU6sPy0ydUFQySkp24Z/sU
         kIMiOU0r16EdThemeIrBV/NtL53OfiFlC0fpo7qNtDhf312cR7uTlleytA1mwOyHV97g
         EGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGZRSNtjYVE5/AFVVZNo9Q/VK/BnWz0MKKsJwglLOK0=;
        b=tfN+jZ1BKjxARteBA7riGhBa1RP9pxcP89hcyuQxQL0JvKDq1v5J3WBhXFncv5fUUm
         CsFFfpZUVSXywHqAHHN1aRzzCMZbGn572SVL1GYhX/3Gm69kY7z+io4xds5W+EYdbRef
         wTVK7HZFRql2KPhqZIhJAxBmvxnRK7nZYq7qqZ+DGBOQrLwRozm3eSRReqF1xADggdhP
         pukbT7Jb22JdCox1bk1v8/gXlSAAzR0Kf9zfNciKYgTsx2zdYAoCwCSwxmfbToJFNYMS
         VouedHvxf7DeKP55zzLCo6UTmnVbLBe4gub9itd1TnCnNTk61pqpm6iQtWjdcpOaqOMI
         SxNQ==
X-Gm-Message-State: AOAM531tNyvR4XVqlJXu47/Z/NicHejm38Ee2gPG84whdPcZ5k3/CJo3
        6rwMtvTkBu8/bWxQEeygeOqKp8JZxH/x2+wFEH1WuA==
X-Google-Smtp-Source: ABdhPJwD2l653RZrx8dohQdBBRtUUY2leiZSGxDuyMkaUkBk2qTZjEaXXYgrM+r7K4JuLnekL19Pl0MSVUaNBqWqWFU=
X-Received: by 2002:a05:651c:1612:b0:253:d535:d7c0 with SMTP id
 f18-20020a05651c161200b00253d535d7c0mr59255207ljq.33.1654851884560; Fri, 10
 Jun 2022 02:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113046.780504-1-elver@google.com> <20220609113046.780504-2-elver@google.com>
 <CACT4Y+bOFmCyqfSgWS0b5xuwnPqP4V9v2ooJRmFCn0YAtOPmhQ@mail.gmail.com>
 <CANpmjNNtV_6kgoLv=VX3z_oM6ZEvWJNAOj9z4ADcymqmhc+crw@mail.gmail.com>
 <CACT4Y+Zq-1nczM2JH7Sr4mZo84gsCRd83RAwwnHwmap-wCOLTQ@mail.gmail.com> <CANpmjNNC7ry59OXsJrPMf56Xi63chexaDfnP4t8_4MG7S5ZgCg@mail.gmail.com>
In-Reply-To: <CANpmjNNC7ry59OXsJrPMf56Xi63chexaDfnP4t8_4MG7S5ZgCg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 10 Jun 2022 11:04:33 +0200
Message-ID: <CACT4Y+ZyrWuZxqpO_fKBjdXbTY-GJu6M7GARVk7YQnyv790mFw@mail.gmail.com>
Subject: Re: [PATCH 1/8] perf/hw_breakpoint: Optimize list of per-task breakpoints
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        linux-sh@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 at 20:37, Marco Elver <elver@google.com> wrote:
> > /On Thu, 9 Jun 2022 at 16:56, Marco Elver <elver@google.com> wrote:
> > > > > On a machine with 256 CPUs, running the recently added perf breakpoint
> > > > > benchmark results in:
> > > > >
> > > > >  | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
> > > > >  | # Running 'breakpoint/thread' benchmark:
> > > > >  | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
> > > > >  |      Total time: 236.418 [sec]
> > > > >  |
> > > > >  |   123134.794271 usecs/op
> > > > >  |  7880626.833333 usecs/op/cpu
> > > > >
> > > > > The benchmark tests inherited breakpoint perf events across many
> > > > > threads.
> > > > >
> > > > > Looking at a perf profile, we can see that the majority of the time is
> > > > > spent in various hw_breakpoint.c functions, which execute within the
> > > > > 'nr_bp_mutex' critical sections which then results in contention on that
> > > > > mutex as well:
> > > > >
> > > > >     37.27%  [kernel]       [k] osq_lock
> > > > >     34.92%  [kernel]       [k] mutex_spin_on_owner
> > > > >     12.15%  [kernel]       [k] toggle_bp_slot
> > > > >     11.90%  [kernel]       [k] __reserve_bp_slot
> > > > >
> > > > > The culprit here is task_bp_pinned(), which has a runtime complexity of
> > > > > O(#tasks) due to storing all task breakpoints in the same list and
> > > > > iterating through that list looking for a matching task. Clearly, this
> > > > > does not scale to thousands of tasks.
> > > > >
> > > > > While one option would be to make task_struct a breakpoint list node,
> > > > > this would only further bloat task_struct for infrequently used data.
> > > >
> > > > task_struct already has:
> > > >
> > > > #ifdef CONFIG_PERF_EVENTS
> > > >   struct perf_event_context *perf_event_ctxp[perf_nr_task_contexts];
> > > >   struct mutex perf_event_mutex;
> > > >   struct list_head perf_event_list;
> > > > #endif
> > > >
> > > > Wonder if it's possible to use perf_event_mutex instead of the task_sharded_mtx?
> > > > And possibly perf_event_list instead of task_bps_ht? It will contain
> > > > other perf_event types, so we will need to test type as well, but on
> > > > the positive side, we don't need any management of the separate
> > > > container.
> > >
> > > Hmm, yes, I looked at that but then decided against messing the
> > > perf/core internals. The main issue I have with using perf_event_mutex
> > > is that we might interfere with perf/core's locking rules as well as
> > > interfere with other concurrent perf event additions. Using
> > > perf_event_list is very likely a no-go because it requires reworking
> > > perf/core as well.
> > >
> > > I can already hear Peter shouting, but maybe I'm wrong. :-)
> >
> > Let's wait for Peter to shout then :)
> > A significant part of this change is having per-task data w/o having
> > per-task data.
> >
> > The current perf-related data in task_struct is already multiple words
> > and it's also not used in lots of production cases.
> > Maybe we could have something like:
> >
> >   struct perf_task_data* lazily_allocated_perf_data;
> >
> > that's lazily allocated on first use instead of the current
> > perf_event_ctxp/perf_event_mutex/perf_event_list.
> > This way we could both reduce task_size when perf is not used and have
> > more perf-related data (incl breakpoints) when it's used.
>
> I don't mind either option, so keeping task_struct bloat in mind, we have:
>
>   1. rhashtable option, no changes to task_struct.
>
>   2. add the breakpoint mutex + list to task_struct.
>
>   3. add something like hw_breakpoint_task_data* and allocate lazily.
>
>   4. (your proposal) move all of perf data into a new struct (+add
> hw_breakpoint things in there) that is lazily allocated.
>
> I don't think perf is that infrequently used, and I can't estimate
> performance impact, so I don't like #4 too much personally. My
> preferred compromise would be #3, but at the same time I'd rather not
> bloat task_struct even with 8 extra infrequently used bytes. Am I too
> paranoid?
>
> Preferences?


There is also this "could eventually get its own" comment:

static struct pmu perf_breakpoint = {
  .task_ctx_nr = perf_sw_context, /* could eventually get its own */
https://elixir.bootlin.com/linux/v5.19-rc1/source/kernel/events/hw_breakpoint.c#L669

If it gets its own, then it also gets a perf_event_context pointer in
task_struct:
https://elixir.bootlin.com/linux/v5.19-rc1/source/include/linux/sched.h#L1229
And perf_event_context has its own mutex and lots of other stuff.
But I don't know what other implications it has.
