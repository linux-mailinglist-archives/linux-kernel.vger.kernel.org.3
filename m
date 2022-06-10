Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01985462A2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346910AbiFJJiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348886AbiFJJhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:37:35 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1460D31DE4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:37:34 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id l204so46061857ybf.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0yCkjQP9dSep6/xo5aErRNWl4SfOJuW2ssFAWrT83k=;
        b=nO+Vc9QpBfc97wxN0P0lNFwcZL8aq9S/jnpkw/FMf/H5jOMnqHxk7Pxqa0OPOB+YxX
         orKbp+piyGbRJ9DzvoPkcrnLe3FJ5pMN4A54d6NJNkq4SsjcuIMkfcMEkTLShmgaKO09
         C1VOHm5FnGZTrIk5CTI7Qxk9WhseeoEabnDuHyTjjtBRHuX8SmAMl8GdggcIrbNJhErH
         7iU0sgiVHKY6oXJ0rJzG8cWqSwU077q8b6kjGGGOLbdR7clgpI55hA2gHNF1lgvOldJk
         sv22J1ecsaJTSlbE/mO6SI8N1nRFAjMZcbt/uKEhJ9LPvsNsyhfUHn7yeUFANZYuskbS
         OaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0yCkjQP9dSep6/xo5aErRNWl4SfOJuW2ssFAWrT83k=;
        b=fL3xVgOxBtde8WZVXAYEjGvOHyWvAU23Ozh/kqnRXdhyoK5cXThXyHbqsPHHEiX8T0
         M/tr43B0xDCUk3QJ8mHOk/SQwEr0StaDkjfy3UE9Q0bPMuSO91Q7qdaiPdNipEDetmYx
         lMFQTG2e61AYu3qpNjhBNzPQf/WQqHaeW2Ne63oSBEmdp+AL+eajjcKRI8a7Kb1tr9sY
         S5qwJUwx3YwI4uSOyihkRG3YpW+bIYsUgYMiWtZf9bCYqgNCvsw3AXzOkif9STGD/H7K
         cXyzcwaVr1gSA1Ltc/Mgao1iBAoNl4TuzYbLplsUP2Koekv76Y08bw0qLRff2PzTkzo4
         mjwA==
X-Gm-Message-State: AOAM533WQ4BXUkio89r0teqC72jMJjKG044fY8eLd3IsyjHQmEoZ7koz
        deSDvWf7auxzGtThWlh3LWIhNVk2qA2SST9bX/dTuw==
X-Google-Smtp-Source: ABdhPJxXiFwQaTBLPTkph/AjipRc+juKKt3pA4IouwLvjmm28vvVXPhLBSYwPN05TUhyiz+qjJjeNxYxfrBawaR5ZjA=
X-Received: by 2002:a5b:49:0:b0:656:151d:a1e3 with SMTP id e9-20020a5b0049000000b00656151da1e3mr12972356ybp.425.1654853853082;
 Fri, 10 Jun 2022 02:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113046.780504-1-elver@google.com> <20220609113046.780504-2-elver@google.com>
 <CACT4Y+bOFmCyqfSgWS0b5xuwnPqP4V9v2ooJRmFCn0YAtOPmhQ@mail.gmail.com>
 <CANpmjNNtV_6kgoLv=VX3z_oM6ZEvWJNAOj9z4ADcymqmhc+crw@mail.gmail.com>
 <CACT4Y+Zq-1nczM2JH7Sr4mZo84gsCRd83RAwwnHwmap-wCOLTQ@mail.gmail.com>
 <CANpmjNNC7ry59OXsJrPMf56Xi63chexaDfnP4t8_4MG7S5ZgCg@mail.gmail.com> <CACT4Y+ZyrWuZxqpO_fKBjdXbTY-GJu6M7GARVk7YQnyv790mFw@mail.gmail.com>
In-Reply-To: <CACT4Y+ZyrWuZxqpO_fKBjdXbTY-GJu6M7GARVk7YQnyv790mFw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 10 Jun 2022 11:36:56 +0200
Message-ID: <CANpmjNNyyFuozLmqyuQ3u1LLjc4-1STq5EyV9=WHhyc2Z9OUEQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] perf/hw_breakpoint: Optimize list of per-task breakpoints
To:     Dmitry Vyukov <dvyukov@google.com>
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
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2022 at 11:04, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, 9 Jun 2022 at 20:37, Marco Elver <elver@google.com> wrote:
> > > /On Thu, 9 Jun 2022 at 16:56, Marco Elver <elver@google.com> wrote:
> > > > > > On a machine with 256 CPUs, running the recently added perf breakpoint
> > > > > > benchmark results in:
> > > > > >
> > > > > >  | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
> > > > > >  | # Running 'breakpoint/thread' benchmark:
> > > > > >  | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
> > > > > >  |      Total time: 236.418 [sec]
> > > > > >  |
> > > > > >  |   123134.794271 usecs/op
> > > > > >  |  7880626.833333 usecs/op/cpu
> > > > > >
> > > > > > The benchmark tests inherited breakpoint perf events across many
> > > > > > threads.
> > > > > >
> > > > > > Looking at a perf profile, we can see that the majority of the time is
> > > > > > spent in various hw_breakpoint.c functions, which execute within the
> > > > > > 'nr_bp_mutex' critical sections which then results in contention on that
> > > > > > mutex as well:
> > > > > >
> > > > > >     37.27%  [kernel]       [k] osq_lock
> > > > > >     34.92%  [kernel]       [k] mutex_spin_on_owner
> > > > > >     12.15%  [kernel]       [k] toggle_bp_slot
> > > > > >     11.90%  [kernel]       [k] __reserve_bp_slot
> > > > > >
> > > > > > The culprit here is task_bp_pinned(), which has a runtime complexity of
> > > > > > O(#tasks) due to storing all task breakpoints in the same list and
> > > > > > iterating through that list looking for a matching task. Clearly, this
> > > > > > does not scale to thousands of tasks.
> > > > > >
> > > > > > While one option would be to make task_struct a breakpoint list node,
> > > > > > this would only further bloat task_struct for infrequently used data.
> > > > >
> > > > > task_struct already has:
> > > > >
> > > > > #ifdef CONFIG_PERF_EVENTS
> > > > >   struct perf_event_context *perf_event_ctxp[perf_nr_task_contexts];
> > > > >   struct mutex perf_event_mutex;
> > > > >   struct list_head perf_event_list;
> > > > > #endif
> > > > >
> > > > > Wonder if it's possible to use perf_event_mutex instead of the task_sharded_mtx?
> > > > > And possibly perf_event_list instead of task_bps_ht? It will contain
> > > > > other perf_event types, so we will need to test type as well, but on
> > > > > the positive side, we don't need any management of the separate
> > > > > container.
> > > >
> > > > Hmm, yes, I looked at that but then decided against messing the
> > > > perf/core internals. The main issue I have with using perf_event_mutex
> > > > is that we might interfere with perf/core's locking rules as well as
> > > > interfere with other concurrent perf event additions. Using
> > > > perf_event_list is very likely a no-go because it requires reworking
> > > > perf/core as well.
> > > >
> > > > I can already hear Peter shouting, but maybe I'm wrong. :-)
> > >
> > > Let's wait for Peter to shout then :)
> > > A significant part of this change is having per-task data w/o having
> > > per-task data.
> > >
> > > The current perf-related data in task_struct is already multiple words
> > > and it's also not used in lots of production cases.
> > > Maybe we could have something like:
> > >
> > >   struct perf_task_data* lazily_allocated_perf_data;
> > >
> > > that's lazily allocated on first use instead of the current
> > > perf_event_ctxp/perf_event_mutex/perf_event_list.
> > > This way we could both reduce task_size when perf is not used and have
> > > more perf-related data (incl breakpoints) when it's used.
> >
> > I don't mind either option, so keeping task_struct bloat in mind, we have:
> >
> >   1. rhashtable option, no changes to task_struct.
> >
> >   2. add the breakpoint mutex + list to task_struct.
> >
> >   3. add something like hw_breakpoint_task_data* and allocate lazily.
> >
> >   4. (your proposal) move all of perf data into a new struct (+add
> > hw_breakpoint things in there) that is lazily allocated.
> >
> > I don't think perf is that infrequently used, and I can't estimate
> > performance impact, so I don't like #4 too much personally. My
> > preferred compromise would be #3, but at the same time I'd rather not
> > bloat task_struct even with 8 extra infrequently used bytes. Am I too
> > paranoid?
> >
> > Preferences?
>
>
> There is also this "could eventually get its own" comment:
>
> static struct pmu perf_breakpoint = {
>   .task_ctx_nr = perf_sw_context, /* could eventually get its own */
> https://elixir.bootlin.com/linux/v5.19-rc1/source/kernel/events/hw_breakpoint.c#L669
>
> If it gets its own, then it also gets a perf_event_context pointer in
> task_struct:
> https://elixir.bootlin.com/linux/v5.19-rc1/source/include/linux/sched.h#L1229
> And perf_event_context has its own mutex and lots of other stuff.
> But I don't know what other implications it has.

Relying on perf events to be the only way that instantiates
breakpoints does not work, because hw_breakpoint is also used by
ptrace independently.

On a whole, adding lazily allocated data to task_struct is not as
simple as the rhashtable option (need to take care of  fork and exit
and make sure the lazily allocated data lives long enough etc.). I
question the added complexity vs. the benefit, when using the
rhashtable avoids all that. If I get rid of the O(#cpu) loops it also
doesn't show up in profiles anymore and any efforts to optimize here
are not buying us much in terms of performance.

If the main issue is the mutex, I suppose we can find a hole in
task_struct and stick it there (there's a massive 32-byte hole above
task_struct::stats).

Was the mutex the only benefit?
