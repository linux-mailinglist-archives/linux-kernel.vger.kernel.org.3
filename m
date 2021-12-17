Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB08747823B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 02:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhLQBn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 20:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhLQBn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 20:43:27 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA2BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 17:43:27 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q16so1168970wrg.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 17:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H5OrUZjgQ1YXwPs3ZdZyzCT9xYTcrlDxGMN/Lkx3yjY=;
        b=ENS69Ixmc+9rTshBrseGjbavY/beBCYucRDedT5GJlZuWvD3sm+w8lqALUgK5qk9xP
         IsYf4fBr+/E51laHVZAO5tf08XgyZZcoxA8+fGFo9wpn9CptnrJxz+LTcPqNUs/zY3DZ
         aXd/fKemZfmErtcoixOwRBewS98RcjuAQzv63mAutdmTtYYS1sDGyy18BtFqH1sfEIvU
         aEzdoALJUPiFAbJW84tpPtyTCH132TMXXhvwoliy9fR7Kp7mBhoixVjXaCrTz9b0WFUj
         B+Hx9ghk67vEfHTI1/eKIDed3BOuxVDYoZiqMt2wBkShjGMAcx26Pdan67uNITyKDX9r
         m67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H5OrUZjgQ1YXwPs3ZdZyzCT9xYTcrlDxGMN/Lkx3yjY=;
        b=Q+moWT2M5nohV3hV/RncgBF9cLMksu3o0LtlL24irrMjtZjFQ/FQeAZPi1KjXOSF08
         0NicCVQR1toorZlqHdmVKl0X7C60zJEFmAIASFg/fR7pQ15YBGhjnaQPuUrn/G9LNhhI
         TgmIqrzK+dz6FccV3t6pO1v/H9spYk4wxexCe7FpMIsQfyrdgg0ejsKdwsN1VgKw+Qvi
         qP7S4nhqWIbMBe7tJJkJBkM9azqob/jVkcYnF/GS6HR6wepx8U5Skfu3WzPkhDpm+pyM
         8JmltRL0f9EosoQd2E8BiJqbvfaKp0d4Iex97uEZmuCj1/6iFTJfevlDx4obmsB1HpIn
         fHPA==
X-Gm-Message-State: AOAM531RhIzBw9VDoSid+rrQovmRKWva8xvKl9PIZJAIhpaiO0iGQdAK
        YLnpFjiTdE37F5uRwpxRPmxS4YIKVgHumoTL3AMpa1atx+av4Rhy
X-Google-Smtp-Source: ABdhPJyTlUWLnivczkfGrT9CphgkdB2Z9tQ9Xqgib9yoA4ZrAWb8bQ3ZsOF0ieh/tvf071MEYHoazsx1ETNdmJvtWnE=
X-Received: by 2002:a5d:6d4c:: with SMTP id k12mr479403wri.511.1639705405890;
 Thu, 16 Dec 2021 17:43:25 -0800 (PST)
MIME-Version: 1.0
References: <20211129164951.220511-1-xiehuan09@gmail.com> <20211216235017.97f0769a63d2c478562d39a4@kernel.org>
In-Reply-To: <20211216235017.97f0769a63d2c478562d39a4@kernel.org>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Fri, 17 Dec 2021 09:43:13 +0800
Message-ID: <CAEr6+EACoE+7SSMJP10uz2g9DqKPwOK89kxAUC=_R43eMRK43w@mail.gmail.com>
Subject: Re: [RFC][PATCH v6 0/5] trace: Introduce objtrace trigger to trace
 the kernel object
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

Thanks for your review.

On Thu, Dec 16, 2021 at 10:50 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Jeff,
>
> On Tue, 30 Nov 2021 00:49:46 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> > Introduce a method based on function tracer to trace any object and get
> > the value of the object dynamically. the object can be obtained from the
> > dynamic event (kprobe_event/uprobe_event) or the static event(tracepoint).
>
> Now you can remove [RFC] tag from this series, I think.
> And can you also add a changelog (short description of the changes) from
> the previous version, so that reviewers can find the difference
> point easily? Unless that, I need to make a diff from your previous version. :(

Ok, I will remove the [RFC] and add changelog.

> Thank you,
>
> >
> > Usage:
> > When using the kprobe event, only need to set the objtrace(a new trigger),
> > we can get the value of the object. The object is from the setting of the
> > kprobe event.
> >
> > For example:
> > For the function bio_add_page():
> >
> > int bio_add_page(struct bio *bio, struct page *page,
> >       unsigned int len, unsigned int offset)
> >
> > Firstly, we can set the base of the object, thus the first string "arg1"
> > stands for the value of the first parameter of this function bio_add_gage(),
> >
> > # echo 'p bio_add_page arg1=$arg1' >> ./kprobe_events
> >
> > Secondly, we can get the value dynamically base the above object.
> >
> > find the offset of the bi_size in struct bio:
> > $ gdb vmlinux
> > (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
> > $1 = (unsigned int *) 0x28
> >
> > # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
> >       p_bio_add_page_0/trigger
> >
> > The best way to use this is that we can set the entrance event and exit
> > event, for example, the following example is to set the read_papes as
> > the entrance event, and set the __blk_account_io_start as the exit event.
> >
> > # cd /sys/kernel/debug/tracing/
> > # echo 0 > ./tracing_on
> > # echo 'p read_pages' >> ./kprobe_events
> > # echo 'p __blk_account_io_start' >> ./kprobe_events
> > # echo 'traceon if comm == "cat"' > ./events/kprobes/p_read_pages_0/trigger
> > # echo 'traceoff if comm == "cat"' > ./events/kprobes/p___blk_account_io_start_0/trigger
> > # echo 'p bio_add_page arg1=$arg1' >> ./kprobe_events
> > # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
> >
> > # du -sh /test.txt
> > 12.0K   /test.txt
> >
> > # cat  /test.txt > /dev/null
> > # cat ./trace
> >
> > # tracer: nop
> > #
> > # entries-in-buffer/entries-written: 50/50   #P:1
> > #
> > #                                _-----=> irqs-off
> > #                               / _----=> need-resched
> > #                              | / _---=> hardirq/softirq
> > #                              || / _--=> preempt-depth
> > #                              ||| / _-=> migrate-disable
> > #                              |||| /     delay
> > #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > #              | |         |   |||||     |         |
> >              cat-95      [000] .....     1.412065: _raw_spin_unlock_irqrestore <-event_triggers_call object:0xffff888108af6328 value:0x0
> >              cat-95      [000] .....     1.412066: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x0
> >              cat-95      [000] .....     1.412066: __bio_add_page <-bio_add_page object:0xffff888108af6328 value:0x0
> >              cat-95      [000] .....     1.412066: rcu_read_unlock_strict <-xa_load object:0xffff888108af6328 value:0x1000
> >              cat-95      [000] .....     1.412066: bio_add_page <-ext4_mpage_readpages object:0xffff888108af6328 value:0x1000
> >              cat-95      [000] .....     1.412066: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x1000
> >              cat-95      [000] .....     1.412067: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x1000
> >              cat-95      [000] .....     1.412067: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x1000
> >              cat-95      [000] .....     1.412067: __bio_add_page <-bio_add_page object:0xffff888108af6328 value:0x1000
> >              cat-95      [000] .....     1.412067: rcu_read_unlock_strict <-xa_load object:0xffff888108af6328 value:0x2000
> >              cat-95      [000] .....     1.412067: bio_add_page <-ext4_mpage_readpages object:0xffff888108af6328 value:0x2000
> >              cat-95      [000] .....     1.412067: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x2000
> >              cat-95      [000] .....     1.412067: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x2000
> >              cat-95      [000] .....     1.412067: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x2000
> >              cat-95      [000] .....     1.412068: submit_bio <-ext4_mpage_readpages object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412068: submit_bio_noacct <-ext4_mpage_readpages object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412068: __submit_bio <-submit_bio_noacct object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412068: blk_try_enter_queue <-__submit_bio object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412068: rcu_read_unlock_strict <-blk_try_enter_queue object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412068: rcu_read_unlock_strict <-blk_try_enter_queue object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412068: submit_bio_checks <-__submit_bio object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412068: __cond_resched <-submit_bio_checks object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412068: rcu_all_qs <-__cond_resched object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412068: should_fail_bio <-submit_bio_checks object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412069: create_task_io_context <-submit_bio_checks object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412069: kmem_cache_alloc_node <-create_task_io_context object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412069: should_failslab <-kmem_cache_alloc_node object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412069: _raw_spin_lock <-create_task_io_context object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412069: blk_mq_submit_bio <-__submit_bio object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412069: __blk_queue_split <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412069: bvec_split_segs <-__blk_queue_split object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412069: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412070: __blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412070: dd_bio_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412070: _raw_spin_lock <-dd_bio_merge object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412070: blk_mq_sched_try_merge <-dd_bio_merge object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412070: elv_merge <-blk_mq_sched_try_merge object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412070: elv_rqhash_find <-elv_merge object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412070: dd_request_merge <-blk_mq_sched_try_merge object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412070: elv_rb_find <-dd_request_merge object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412070: __blk_mq_alloc_request <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412071: dd_limit_depth <-__blk_mq_alloc_request object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412071: blk_mq_get_tag <-__blk_mq_alloc_request object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412071: __blk_mq_get_tag <-blk_mq_get_tag object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412071: blk_mq_rq_ctx_init.isra.0 <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412071: ktime_get <-blk_mq_rq_ctx_init.isra.0 object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412071: dd_prepare_request <-blk_mq_rq_ctx_init.isra.0 object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412071: __blk_account_io_start <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412071: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412071: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x3000
> >
> > Jeff Xie (5):
> >   trace: Add trace any kernel object
> >   trace/objtrace: get the value of the object
> >   trace/README: Document objtrace trigger syntax
> >   trace/objtrace: Add testcases for objtrace
> >   trace/objtrace: Add documentation for objtrace
> >
> >  Documentation/trace/events.rst                | 114 +++
> >  include/linux/trace_events.h                  |   1 +
> >  kernel/trace/Kconfig                          |  10 +
> >  kernel/trace/Makefile                         |   1 +
> >  kernel/trace/trace.c                          |   3 +
> >  kernel/trace/trace.h                          |   8 +
> >  kernel/trace/trace_entries.h                  |  18 +
> >  kernel/trace/trace_events_trigger.c           |   1 +
> >  kernel/trace/trace_object.c                   | 660 ++++++++++++++++++
> >  kernel/trace/trace_output.c                   |  40 ++
> >  .../ftrace/test.d/trigger/trigger-objtrace.tc |  39 ++
> >  11 files changed, 895 insertions(+)
> >  create mode 100644 kernel/trace/trace_object.c
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
> >
> > --
> > 2.25.1
> >
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>

---
JeffXie
