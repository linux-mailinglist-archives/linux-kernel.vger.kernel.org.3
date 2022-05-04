Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E416351987C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345558AbiEDHqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbiEDHqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:46:34 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F7312AC6
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 00:42:57 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e24so795861wrc.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 00:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZzvXyDruETKTfUfzfcPFCbCgHSUdq+lMOde9LnrCmwM=;
        b=Rewf+pK/9cREX55B7hQnL9TZJ+4RpDKQumX7eT8VNdrthUHtN2fQZbiW0Qm1vUjCDW
         SfrfQAEYliHDimmSZnOILLGQHG53GnSJc7ER3zfZnItvfvdn9q8SD6HpJwPIaRsofNBb
         OxJ3OuqyU12mq86a0a/No1hs4WpqMOUIWdZa6BYvBfdxSwlKKBQ8SbzX0+A5WYkQvG0W
         03rNSm2KHDXFziWj4skGxOi6T3xxIoByB4VHZ3d3zacAXOHaEXoByfR+49hEtjRU2ng7
         ncx1eBimxwc4iBxQpaf/Hl+ZtTdlFMJIRe7B4rVpnEKWNcc1SQLdiMCN44/SQdmshcVM
         v5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZzvXyDruETKTfUfzfcPFCbCgHSUdq+lMOde9LnrCmwM=;
        b=V1VCcOJWOAvmRHY3Ly7UyPL/J0hdp9iyVQd0c65X870tWloQhdUoVCL8CF7U4PwTg0
         TlFZ7K5eRQJMRNKSkk7UCrx69Yc+S5GoKyDbiOqeSZjlr62XInAr2HqYOeRUhIQq+aci
         gM6WyovgHhLa+GELSl0rAzUMhJFsHYOcRQ7q/2m1KAmBMtTdcXyG5Rjf6GszF7iKFJT0
         BiIG1S+Zz7lHz8bV0XQkvOHVy/S2Yzv1X/QR1B6SrWmuGyRpx22tfVhf/BtjfcCs0aTc
         YLFb+GWNNwuCqmXFRcCWnyaaSied97NWCFCuZEgHwOelo1gtnp/KDlA0lmU0IIUwqKtX
         5fSA==
X-Gm-Message-State: AOAM531fRCgKrOzPDRkLZl4E8UWDoZaLbcsSpnnEMTGOO7aqmigr6awA
        CtzU/PqMetrU9wFCK1sBcjYsdgrT7jmL9VTVTZqzAJYOISk=
X-Google-Smtp-Source: ABdhPJzNONFHoR7ymTkX10eOkVTwo+G/zXEyhf5a2jJZCCRj54wzr2l5QbPm9Cqo4lOj0tJvKa9pzyIA0c17NBN+rPA=
X-Received: by 2002:a5d:4e42:0:b0:20a:d87f:84ee with SMTP id
 r2-20020a5d4e42000000b0020ad87f84eemr15724895wrt.593.1651650176024; Wed, 04
 May 2022 00:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220204035644.734878-1-xiehuan09@gmail.com> <20220204035644.734878-2-xiehuan09@gmail.com>
 <CAEr6+ECsKNdbkqWH1qpLN=O0+jjZD4F788Oy6fSa1r5U7L-YSA@mail.gmail.com> <798e3648b5afcb4a8df8e63c6fd4cf3fbbf754b8.camel@kernel.org>
In-Reply-To: <798e3648b5afcb4a8df8e63c6fd4cf3fbbf754b8.camel@kernel.org>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Wed, 4 May 2022 15:42:43 +0800
Message-ID: <CAEr6+EBV2RJ=W0TajF4MyxLDJ17-o91Azh-VXsjrs2VWsh5XTA@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] trace: Add trace any kernel object
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

Thanks for the detailed explanation.

On Tue, May 3, 2022 at 1:42 AM Tom Zanussi <zanussi@kernel.org> wrote:
>
> Hi Jeff,
>
> On Wed, 2022-04-27 at 23:50 +0800, Jeff Xie wrote:
> > Hi Tom,
> >
> > I have checked your patches:
> >
> > https://lore.kernel.org/all/cover.1644010575.git.zanussi@kernel.org/
> >
> > But I found that I can't use the generic function you implemented,
> > I don't know if I understand correctly, when you are free, hope you
> > can help to check it ;-) , thanks.
> >
> > On Fri, Feb 4, 2022 at 11:57 AM Jeff Xie <xiehuan09@gmail.com> wrote:
> > >
> > > Introduce objtrace trigger to get the call flow by tracing any
> > > kernel
> > > object in the function parameter.
> > >
> > > The objtrace trigger makes a list of the target object address from
> > > the given event parameter, and records all kernel function calls
> > > which has the object address in its parameter.
> > >
> > > Syntax:
> > >         objtrace:add:obj[:count][if <filter>]
> > >
> > > Usage:
> > >         # echo 'p bio_add_page arg1=$arg1' > kprobe_events
> > >         # cd events/kprobes/p_bio_add_page_0
> > >         # echo 'objtrace:add:arg1:1 if comm == "cat"' > ./trigger
> > >         # cat /test.txt
> > >
> > > Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> > > ---
> > >  include/linux/trace_events.h        |   1 +
> > >  kernel/trace/Kconfig                |  10 +
> > >  kernel/trace/Makefile               |   1 +
> > >  kernel/trace/trace.c                |   3 +
> > >  kernel/trace/trace.h                |   8 +
> > >  kernel/trace/trace_entries.h        |  17 +
> > >  kernel/trace/trace_events_trigger.c |   1 +
> > >  kernel/trace/trace_object.c         | 515
> > > ++++++++++++++++++++++++++++
> > >  kernel/trace/trace_output.c         |  40 +++
> > >  9 files changed, 596 insertions(+)
> > >  create mode 100644 kernel/trace/trace_object.c
> > >
> > > diff --git a/include/linux/trace_events.h
> > > b/include/linux/trace_events.h
> > > index 70c069aef02c..3ccdbc1d25dd 100644
> > > --- a/include/linux/trace_events.h
> > > +++ b/include/linux/trace_events.h
> > > @@ -685,6 +685,7 @@ enum event_trigger_type {
> > >         ETT_EVENT_HIST          = (1 << 4),
> > >         ETT_HIST_ENABLE         = (1 << 5),
> > >         ETT_EVENT_EPROBE        = (1 << 6),
> > > +       ETT_TRACE_OBJECT        = (1 << 7),
> > >  };
> > >
> > >  extern int filter_match_preds(struct event_filter *filter, void
> > > *rec);
> > > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > > index a5eb5e7fd624..c51b7eb1508d 100644
> > > --- a/kernel/trace/Kconfig
> > > +++ b/kernel/trace/Kconfig
> > > @@ -250,6 +250,16 @@ config FUNCTION_PROFILER
> > >
> > >           If in doubt, say N.
> > >
> > > +config TRACE_OBJECT
> > > +       bool "Trace kernel object in function parameter"
> > > +       depends on FUNCTION_TRACER
> > > +       depends on HAVE_FUNCTION_ARG_ACCESS_API
> > > +       select TRACING
> > > +       default y
> > > +       help
> > > +        You can trace the kernel object in the kernel function
> > > parameter.
> > > +        The kernel object is dynamically specified via event
> > > trigger.
> > > +
> > >  config STACK_TRACER
> > >         bool "Trace max stack"
> > >         depends on HAVE_FUNCTION_TRACER
> > > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > > index bedc5caceec7..b924b8e55922 100644
> > > --- a/kernel/trace/Makefile
> > > +++ b/kernel/trace/Makefile
> > > @@ -67,6 +67,7 @@ obj-$(CONFIG_FUNCTION_GRAPH_TRACER) +=
> > > trace_functions_graph.o
> > >  obj-$(CONFIG_TRACE_BRANCH_PROFILING) += trace_branch.o
> > >  obj-$(CONFIG_BLK_DEV_IO_TRACE) += blktrace.o
> > >  obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += fgraph.o
> > > +obj-$(CONFIG_TRACE_OBJECT) += trace_object.o
> > >  ifeq ($(CONFIG_BLOCK),y)
> > >  obj-$(CONFIG_EVENT_TRACING) += blktrace.o
> > >  endif
> > > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > > index a734d5ae34c8..b4513c2bbd52 100644
> > > --- a/kernel/trace/trace.c
> > > +++ b/kernel/trace/trace.c
> > > @@ -5605,6 +5605,9 @@ static const char readme_msg[] =
> > >         "\t            enable_hist:<system>:<event>\n"
> > >         "\t            disable_hist:<system>:<event>\n"
> > >  #endif
> > > +#ifdef CONFIG_TRACE_OBJECT
> > > +       "\t            objtrace:add:obj[:count][if <filter>]\n"
> > > +#endif
> > >  #ifdef CONFIG_STACKTRACE
> > >         "\t\t    stacktrace\n"
> > >  #endif
> > > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > > index 0f5e22238cd2..8b66515a36d5 100644
> > > --- a/kernel/trace/trace.h
> > > +++ b/kernel/trace/trace.h
> > > @@ -54,6 +54,7 @@ enum trace_type {
> > >         TRACE_TIMERLAT,
> > >         TRACE_RAW_DATA,
> > >         TRACE_FUNC_REPEATS,
> > > +       TRACE_OBJECT,
> > >
> > >         __TRACE_LAST_TYPE,
> > >  };
> > > @@ -472,6 +473,7 @@ extern void __ftrace_bad_type(void);
> > >                           TRACE_GRAPH_RET);             \
> > >                 IF_ASSIGN(var, ent, struct
> > > func_repeats_entry,          \
> > >                           TRACE_FUNC_REPEATS);
> > >      \
> > > +               IF_ASSIGN(var, ent, struct trace_object_entry,
> > > TRACE_OBJECT);\
> > >                 __ftrace_bad_type();
> > >      \
> > >         } while (0)
> > >
> > > @@ -1537,6 +1539,12 @@ static inline int
> > > register_trigger_hist_cmd(void) { return 0; }
> > >  static inline int register_trigger_hist_enable_disable_cmds(void)
> > > { return 0; }
> > >  #endif
> > >
> > > +#ifdef CONFIG_TRACE_OBJECT
> > > +extern int register_trigger_object_cmd(void);
> > > +#else
> > > +static inline int register_trigger_object_cmd(void) { return 0; }
> > > +#endif
> > > +
> > >  extern int register_trigger_cmds(void);
> > >  extern void clear_event_triggers(struct trace_array *tr);
> > >
> > > diff --git a/kernel/trace/trace_entries.h
> > > b/kernel/trace/trace_entries.h
> > > index cd41e863b51c..bb120d9498a9 100644
> > > --- a/kernel/trace/trace_entries.h
> > > +++ b/kernel/trace/trace_entries.h
> > > @@ -401,3 +401,20 @@ FTRACE_ENTRY(timerlat, timerlat_entry,
> > >                  __entry->context,
> > >                  __entry->timer_latency)
> > >  );
> > > +
> > > +/*
> > > + * trace object entry:
> > > + */
> > > +FTRACE_ENTRY(object, trace_object_entry,
> > > +
> > > +       TRACE_OBJECT,
> > > +
> > > +       F_STRUCT(
> > > +               __field(        unsigned
> > > long,          ip              )
> > > +               __field(        unsigned
> > > long,          parent_ip       )
> > > +               __field(        unsigned
> > > long,          object          )
> > > +       ),
> > > +
> > > +       F_printk(" %ps <-- %ps object:%lx\n",
> > > +                (void *)__entry->ip, (void *)__entry->parent_ip,
> > > __entry->object)
> > > +);
> > > diff --git a/kernel/trace/trace_events_trigger.c
> > > b/kernel/trace/trace_events_trigger.c
> > > index d00fee705f9c..c3371a6902af 100644
> > > --- a/kernel/trace/trace_events_trigger.c
> > > +++ b/kernel/trace/trace_events_trigger.c
> > > @@ -2025,6 +2025,7 @@ __init int register_trigger_cmds(void)
> > >         register_trigger_enable_disable_cmds();
> > >         register_trigger_hist_enable_disable_cmds();
> > >         register_trigger_hist_cmd();
> > > +       register_trigger_object_cmd();
> > >
> > >         return 0;
> > >  }
> > > diff --git a/kernel/trace/trace_object.c
> > > b/kernel/trace/trace_object.c
> > > new file mode 100644
> > > index 000000000000..540e387c613a
> > > --- /dev/null
> > > +++ b/kernel/trace/trace_object.c
> > > @@ -0,0 +1,515 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * trace the kernel object in the kernel function parameter
> > > + * Copyright (C) 2021 Jeff Xie <xiehuan09@gmail.com>
> > > + */
> > > +
> > > +#define pr_fmt(fmt) "trace_object: " fmt
> > > +
> > > +#include "trace_output.h"
> > > +
> > > +#define MAX_TRACED_OBJECT 5
> > > +#define OBJTRACE_CMD_LEN  10
> > > +static DEFINE_PER_CPU(unsigned int, trace_object_event_disable);
> > > +static DEFINE_RAW_SPINLOCK(trace_obj_lock);
> > > +static struct trace_event_file event_trace_file;
> > > +static const int max_args_num = 6;
> > > +static atomic_t trace_object_ref;
> > > +static atomic_t num_traced_obj;
> > > +static int exit_trace_object(void);
> > > +static int init_trace_object(void);
> > > +
> > > +static struct object_instance {
> > > +       void *obj;
> > > +} traced_obj[MAX_TRACED_OBJECT];
> > > +
> > > +/* objtrace private data */
> > > +struct objtrace_trigger_data {
> > > +       struct ftrace_event_field *field;
> > > +       char objtrace_cmd[OBJTRACE_CMD_LEN];
> > > +};
> > > +
> > > +static bool object_exist(void *obj)
> > > +{
> > > +       int i, max;
> > > +
> > > +       max = atomic_read(&num_traced_obj);
> > > +       smp_rmb();
> > > +       for (i = 0; i < max; i++) {
> > > +               if (traced_obj[i].obj == obj)
> > > +                       return true;
> > > +       }
> > > +       return false;
> > > +}
> > > +
> > > +static bool object_empty(void)
> > > +{
> > > +       return !atomic_read(&num_traced_obj);
> > > +}
> > > +
> > > +static void set_trace_object(void *obj)
> > > +{
> > > +       unsigned long flags;
> > > +
> > > +       if (in_nmi())
> > > +               return;
> > > +
> > > +       if (!obj)
> > > +               return;
> > > +
> > > +       if (object_exist(obj))
> > > +               return;
> > > +
> > > +       /* only this place has write operations */
> > > +       raw_spin_lock_irqsave(&trace_obj_lock, flags);
> > > +       if (atomic_read(&num_traced_obj) == MAX_TRACED_OBJECT) {
> > > +               trace_printk("object_pool is full, can't trace
> > > object:0x%px\n", obj);
> > > +               goto out;
> > > +       }
> > > +       traced_obj[atomic_read(&num_traced_obj)].obj = obj;
> > > +       /* make sure the num_traced_obj update always appears after
> > > traced_obj update */
> > > +       smp_wmb();
> > > +       atomic_inc(&num_traced_obj);
> > > +out:
> > > +       raw_spin_unlock_irqrestore(&trace_obj_lock, flags);
> > > +}
> > > +
> > > +static void submit_trace_object(unsigned long ip, unsigned long
> > > parent_ip,
> > > +                                unsigned long object)
> > > +{
> > > +
> > > +       struct trace_buffer *buffer;
> > > +       struct ring_buffer_event *event;
> > > +       struct trace_object_entry *entry;
> > > +       int pc;
> > > +
> > > +       pc = preempt_count();
> > > +       event = trace_event_buffer_lock_reserve(&buffer,
> > > &event_trace_file,
> > > +                       TRACE_OBJECT, sizeof(*entry), pc);
> > > +       if (!event)
> > > +               return;
> > > +       entry   = ring_buffer_event_data(event);
> > > +       entry->ip                       = ip;
> > > +       entry->parent_ip                = parent_ip;
> > > +       entry->object                   = object;
> > > +
> > > +       event_trigger_unlock_commit(&event_trace_file, buffer,
> > > event,
> > > +               entry, pc);
> > > +}
> > > +
> > > +static void
> > > +trace_object_events_call(unsigned long ip, unsigned long
> > > parent_ip,
> > > +               struct ftrace_ops *op, struct ftrace_regs *fregs)
> > > +{
> > > +       struct pt_regs *pt_regs = ftrace_get_regs(fregs);
> > > +       unsigned long obj;
> > > +       unsigned int disabled;
> > > +       int n;
> > > +
> > > +       preempt_disable_notrace();
> > > +
> > > +       disabled = this_cpu_inc_return(trace_object_event_disable);
> > > +       if (disabled != 1)
> > > +               goto out;
> > > +
> > > +       if (object_empty())
> > > +               goto out;
> > > +
> > > +       for (n = 0; n < max_args_num; n++) {
> > > +               obj = regs_get_kernel_argument(pt_regs, n);
> > > +               if (object_exist((void *)obj))
> > > +                       submit_trace_object(ip, parent_ip, obj);
> > > +       /* The parameters of a function may match multiple objects
> > > */
> > > +       }
> > > +out:
> > > +       this_cpu_dec(trace_object_event_disable);
> > > +       preempt_enable_notrace();
> > > +}
> > > +
> > > +static struct ftrace_ops trace_ops = {
> > > +       .func  = trace_object_events_call,
> > > +       .flags = FTRACE_OPS_FL_SAVE_REGS,
> > > +};
> > > +
> > > +static void
> > > +trace_object_trigger(struct event_trigger_data *data,
> > > +                  struct trace_buffer *buffer,  void *rec,
> > > +                  struct ring_buffer_event *event)
> > > +{
> > > +       struct objtrace_trigger_data *obj_data = data-
> > > >private_data;
> > > +       struct ftrace_event_field *field;
> > > +       void *obj = NULL;
> > > +
> > > +       field = obj_data->field;
> > > +       memcpy(&obj, rec + field->offset, sizeof(obj));
> > > +       set_trace_object(obj);
> > > +}
> > > +
> > > +static void
> > > +trace_object_trigger_free(struct event_trigger_ops *ops,
> > > +                  struct event_trigger_data *data)
> > > +{
> > > +       if (WARN_ON_ONCE(data->ref <= 0))
> > > +               return;
> > > +
> > > +       data->ref--;
> > > +       if (!data->ref) {
> > > +               kfree(data->private_data);
> > > +               trigger_data_free(data);
> > > +       }
> > > +}
> > > +
> > > +static void
> > > +trace_object_count_trigger(struct event_trigger_data *data,
> > > +                        struct trace_buffer *buffer, void *rec,
> > > +                        struct ring_buffer_event *event)
> > > +{
> > > +       if (!data->count)
> > > +               return;
> > > +
> > > +       if (data->count != -1)
> > > +               (data->count)--;
> > > +
> > > +       trace_object_trigger(data, buffer, rec, event);
> > > +}
> > > +
> > > +static int event_object_trigger_init(struct event_trigger_ops
> > > *ops,
> > > +                      struct event_trigger_data *data)
> > > +{
> > > +       data->ref++;
> > > +       return 0;
> > > +}
> > > +
> > > +static int
> > > +event_trigger_print(const char *name, struct seq_file *m,
> > > +               void *data, char *filter_str, void *objtrace_data)
> > > +{
> > > +       long count = (long)data;
> > > +       struct objtrace_trigger_data *obj_data = objtrace_data;
> > > +
> > > +       seq_puts(m, name);
> > > +
> > > +       seq_printf(m, ":%s", obj_data->objtrace_cmd);
> > > +       seq_printf(m, ":%s", obj_data->field->name);
> > > +
> > > +       if (count == -1)
> > > +               seq_puts(m, ":unlimited");
> > > +       else
> > > +               seq_printf(m, ":count=%ld", count);
> > > +
> > > +       if (filter_str)
> > > +               seq_printf(m, " if %s\n", filter_str);
> > > +       else
> > > +               seq_putc(m, '\n');
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int
> > > +trace_object_trigger_print(struct seq_file *m, struct
> > > event_trigger_ops *ops,
> > > +                        struct event_trigger_data *data)
> > > +{
> > > +       return event_trigger_print("objtrace", m, (void *)data-
> > > >count,
> > > +                                  data->filter_str, data-
> > > >private_data);
> > > +}
> > > +
> > > +static struct event_trigger_ops objecttrace_trigger_ops = {
> > > +       .trigger                = trace_object_trigger,
> > > +       .print                  = trace_object_trigger_print,
> > > +       .init                   = event_object_trigger_init,
> > > +       .free                   = trace_object_trigger_free,
> > > +};
> > > +
> > > +static struct event_trigger_ops objecttrace_count_trigger_ops = {
> > > +       .trigger                = trace_object_count_trigger,
> > > +       .print                  = trace_object_trigger_print,
> > > +       .init                   = event_object_trigger_init,
> > > +       .free                   = trace_object_trigger_free,
> > > +};
> > > +
> > > +static struct event_trigger_ops *
> > > +objecttrace_get_trigger_ops(char *cmd, char *param)
> > > +{
> > > +       return param ? &objecttrace_count_trigger_ops :
> > > &objecttrace_trigger_ops;
> > > +}
> > > +
> > > +static int register_object_trigger(char *glob,
> > > +                           struct event_trigger_data *data,
> > > +                           struct trace_event_file *file)
> > > +{
> > > +       struct event_trigger_data *test;
> > > +       int ret = 0;
> > > +
> > > +       lockdep_assert_held(&event_mutex);
> > > +
> > > +       list_for_each_entry(test, &file->triggers, list) {
> > > +               if (test->cmd_ops->trigger_type == data->cmd_ops-
> > > >trigger_type) {
> > > +                       ret = -EEXIST;
> > > +                       goto out;
> > > +               }
> > > +       }
> > > +
> > > +       if (data->ops->init) {
> > > +               ret = data->ops->init(data->ops, data);
> > > +               if (ret < 0)
> > > +                       goto out;
> > > +       }
> > > +
> > > +       list_add_rcu(&data->list, &file->triggers);
> > > +       ret++;
> > > +
> > > +       update_cond_flag(file);
> > > +       if (trace_event_trigger_enable_disable(file, 1) < 0) {
> > > +               list_del_rcu(&data->list);
> > > +               update_cond_flag(file);
> > > +               ret--;
> > > +       }
> > > +       init_trace_object();
> > > +out:
> > > +       return ret;
> > > +}
> >
> > Can't replace the register_object_trigger() with register_trigger(),
> > as there will be no place to invoke the init_trace_object(), maybe It
> > will be better to add a callback in struct event_command,
> > for example, cmd_ops->init()
>
> register_trigger() calls event_trigger->ops->init(), can you call
> init_trace_object() from there?

Thanks, I can call init_trace_object() using event_trigger->ops->init()  now,
when I refereed  the  new code in event_trigger_parse().

> >
> > > +static void unregister_object_trigger(char *glob,
> > > +                              struct event_trigger_data *test,
> > > +                              struct trace_event_file *file)
> > > +{
> > > +       struct event_trigger_data *data;
> > > +       bool unregistered = false;
> > > +
> > > +       lockdep_assert_held(&event_mutex);
> > > +
> > > +       list_for_each_entry(data, &file->triggers, list) {
> > > +               if (data->cmd_ops->trigger_type == test->cmd_ops-
> > > >trigger_type) {
> > > +                       unregistered = true;
> > > +                       list_del_rcu(&data->list);
> > > +                       trace_event_trigger_enable_disable(file,
> > > 0);
> > > +                       update_cond_flag(file);
> > > +                       break;
> > > +               }
> > > +       }
> > > +
> > > +       if (unregistered) {
> > > +               if (data->ops->free)
> > > +                       data->ops->free(data->ops, data);
> > > +               exit_trace_object();
> > > +       }
> > > +}
> > > +
> >
> > Can't replace the unregister_object_trigger() with
> > unregister_trigger(),
> > as there will be no place to invoke the exit_trace_object().Maybe
> > need
> > to add a callback, for example cmd_ops->free().
>
> Similarly, unregister_trigger() calls event_trigger->ops->free().

Similarly, I can also use this interface.

> >
> > > +static bool field_exist(struct trace_event_file *file,
> > > +                       struct event_command *cmd_ops,
> > > +                       const char *field_name)
> > > +{
> > > +       struct event_trigger_data *data;
> > > +       struct objtrace_trigger_data *obj_data;
> > > +
> > > +       lockdep_assert_held(&event_mutex);
> > > +
> > > +       list_for_each_entry(data, &file->triggers, list) {
> > > +               if (data->cmd_ops->trigger_type == cmd_ops-
> > > >trigger_type) {
> > > +                       obj_data = data->private_data;
> > > +                       if (!strcmp(obj_data->field->name,
> > > field_name))
> > > +                               return true;
> > > +               }
> > > +       }
> > > +
> > > +       return false;
> > > +}
> > > +
> > > +static int
> > > +event_object_trigger_parse(struct event_command *cmd_ops,
> > > +                      struct trace_event_file *file,
> > > +                      char *glob, char *cmd, char *param)
> > > +{
> > > +       struct event_trigger_data *trigger_data;
> > > +       struct event_trigger_ops *trigger_ops;
> > > +       struct objtrace_trigger_data *obj_data;
> > > +       struct trace_event_call *call;
> > > +       struct ftrace_event_field *field;
> > > +       char *objtrace_cmd;
> > > +       char *trigger = NULL;
> > > +       char *arg;
> > > +       char *number;
> > > +       int ret;
> > > +       bool remove = false;
> > > +
> > > +       ret = -EINVAL;
> > > +       if (!param)
> > > +               goto out;
> > > +
> > > +       /* separate the trigger from the filter (c:a:n [if filter])
> > > */
> > > +       trigger = strsep(&param, " \t");
> > > +       if (!trigger)
> > > +               goto out;
> > > +       if (param) {
> > > +               param = skip_spaces(param);
> > > +               if (!*param)
> > > +                       param = NULL;
> > > +       }
> > > +
> > > +       objtrace_cmd = strsep(&trigger, ":");
> > > +       if (!objtrace_cmd || strcmp(objtrace_cmd, "add"))
> > > +               goto out;
> > > +
> > > +       arg = strsep(&trigger, ":");
> > > +       if (!arg)
> > > +               goto out;
> > > +       call = file->event_call;
> > > +       field = trace_find_event_field(call, arg);
> > > +       if (!field)
> > > +               goto out;
> > > +
> > > +       if (field->size != sizeof(void *))
> > > +               goto out;
> > > +
> > > +       if (glob[0] == '!')
> > > +               remove = true;
> > > +
> > > +       if (remove && !field_exist(file, cmd_ops, field->name))
> > > +       goto out;
> > > +       trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
> > > +       ret = -ENOMEM;
> > > +       obj_data = kzalloc(sizeof(*obj_data), GFP_KERNEL);
> > > +       if (!obj_data)
> > > +               goto out;
> > > +       obj_data->field = field;
> > > +       snprintf(obj_data->objtrace_cmd, OBJTRACE_CMD_LEN,
> > > objtrace_cmd);
> > > +
> > > +       trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
> > > +       if (!trigger_data) {
> > > +               kfree(obj_data);
> > > +               goto out;
> > > +       }
> > > +
> > > +       trigger_data->count = -1;
> > > +       trigger_data->ops = trigger_ops;
> > > +       trigger_data->cmd_ops = cmd_ops;
> > > +       trigger_data->private_data = obj_data;
> > > +       INIT_LIST_HEAD(&trigger_data->list);
> > > +       INIT_LIST_HEAD(&trigger_data->named_list);
>
> In the new code, the above can now be done by event_trigger_alloc().

Thanks for the reminder.

> > > +
> > > +       if (remove) {
> > > +               cmd_ops->unreg(glob+1, trigger_data, file);
> > > +               kfree(obj_data);
> > > +               kfree(trigger_data);
> > > +               ret = 0;
> > > +               goto out;
> > > +       }
> > > +
> > > +       if (trigger) {
> > > +               number = strsep(&trigger, ":");
> > > +
> > > +               ret = -EINVAL;
> > > +               if (!strlen(number))
> > > +                       goto out_free;
> > > +
> > > +               /*
> > > +                * We use the callback data field (which is a
> > > pointer)
> > > +                * as our counter.
> > > +                */
> > > +               ret = kstrtoul(number, 0, &trigger_data->count);
> > > +               if (ret)
> > > +                       goto out_free;
> > > +       }
>
> Similarly, event_trigger_parse_num() should cover this.

Yes, thanks for the reminder.

> > > +
> > > +       if (!param) /* if param is non-empty, it's supposed to be a
> > > filter */
> > > +               goto out_reg;
> > > +
> > > +       if (!cmd_ops->set_filter)
> > > +               goto out_reg;
> > > +
> > > +       ret = cmd_ops->set_filter(param, trigger_data, file);
> > > +       if (ret < 0)
> > > +               goto out_free;
>
> Similarly, event_trigger_set_filter()...
>
> > > +
> > > + out_reg:
> > > +       /* Up the trigger_data count to make sure reg doesn't free
> > > it on failure */
> > > +       event_object_trigger_init(trigger_ops, trigger_data);
> > > +       ret = cmd_ops->reg(glob, trigger_data, file);
> > > +       /*
> > > +        * The above returns on success the # of functions enabled,
> > > +        * but if it didn't find any functions it returns zero.
> > > +        * Consider no functions a failure too.
> > > +        */
> > > +       if (!ret) {
> > > +               cmd_ops->unreg(glob, trigger_data, file);
> > > +               ret = -ENOENT;
> > > +       } else if (ret > 0)
> > > +               ret = 0;
> > > +
> > > +       /* Down the counter of trigger_data or free it if not used
> > > anymore */
> > > +       trace_object_trigger_free(trigger_ops, trigger_data);
> > > + out:
> > > +       return ret;
> > > +
> > > + out_free:
> > > +       if (cmd_ops->set_filter)
> > > +               cmd_ops->set_filter(NULL, trigger_data, NULL);
> > > +       kfree(obj_data);
> > > +       kfree(trigger_data);
> > > +       goto out;
> > > +}
> >
> > Can't replace the event_object_trigger_parse() with
> > event_trigger_parse().
> > Because the event_object_trigger_parse() needs to parse more fields,
> > for example need to parse objtrace_cmd("add" etc.,)
> > and need to use other special private_data. Maybe It will have to use
> > the event_object_trigger_parse().
>
> Yeah, for this one, you'll need to customize, since new commands like
> this need their own parsing.  The functions I noted above (and others)
> attempt to simplify the overall parsing by putting the boilerplate in
> separate functions, but you still need to do whatever extras your
> parsing function needs.
>
> You'll probably end up with some kind of combination of
> event_hist_trigger_parse() and event_trigger_parse() - I'd take a look
> at those or other event_command parse() functions for other commands.

The event_hist_trigger_parse() and event_trigger_parse() really
simplify a lot of repetitive logic with new code.
and I will refer to them.

> hth,
>
> Tom
>
> >
> > > +static struct event_command trigger_object_cmd = {
> > > +       .name                   = "objtrace",
> > > +       .trigger_type           = ETT_TRACE_OBJECT,
> > > +       .flags                  = EVENT_CMD_FL_NEEDS_REC,
> > > +       .parse                  = event_object_trigger_parse,
> > > +       .reg                    = register_object_trigger,
> > > +       .unreg                  = unregister_object_trigger,
> > > +       .get_trigger_ops        = objecttrace_get_trigger_ops,
> > > +       .set_filter             = set_trigger_filter,
> > > +};
> > > +
> > > +__init int register_trigger_object_cmd(void)
> > > +{
> > > +       int ret;
> > > +
> > > +       ret = register_event_command(&trigger_object_cmd);
> > > +       WARN_ON(ret < 0);
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +static int init_trace_object(void)
> > > +{
> > > +       int ret;
> > > +
> > > +       if (atomic_inc_return(&trace_object_ref) != 1) {
> > > +               ret = 0;
> > > +               goto out;
> > > +       }
> > > +
> > > +       event_trace_file.tr = top_trace_array();
> > > +       if (WARN_ON(!event_trace_file.tr)) {
> > > +               ret = -1;
> > > +               atomic_dec(&trace_object_ref);
> > > +               goto out;
> > > +       }
> > > +       ret = register_ftrace_function(&trace_ops);
> > > +out:
> > > +       return ret;
> > > +}
> > > +
> > > +static int exit_trace_object(void)
> > > +{
> > > +       int ret;
> > > +
> > > +       if (WARN_ON_ONCE(atomic_read(&trace_object_ref) <= 0)) {
> > > +               ret = -1;
> > > +               goto out;
> > > +       }
> > > +
> > > +       if (atomic_dec_return(&trace_object_ref) != 0) {
> > > +               ret = 0;
> > > +               goto out;
> > > +       }
> > > +
> > > +       ret = unregister_ftrace_function(&trace_ops);
> > > +       if (ret) {
> > > +               pr_err("can't unregister ftrace for trace
> > > object\n");
> > > +               goto out;
> > > +       }
> > > +       atomic_set(&num_traced_obj, 0);
> > > +out:
> > > +       return ret;
> > > +}
> > > diff --git a/kernel/trace/trace_output.c
> > > b/kernel/trace/trace_output.c
> > > index 8aa493d25c73..265428154638 100644
> > > --- a/kernel/trace/trace_output.c
> > > +++ b/kernel/trace/trace_output.c
> > > @@ -1547,6 +1547,45 @@ static struct trace_event
> > > trace_func_repeats_event = {
> > >         .funcs          = &trace_func_repeats_funcs,
> > >  };
> > >
> > > +/* TRACE_OBJECT */
> > > +static enum print_line_t trace_object_print(struct trace_iterator
> > > *iter, int flags,
> > > +                                       struct trace_event *event)
> > > +{
> > > +       struct trace_object_entry *field;
> > > +       struct trace_seq *s = &iter->seq;
> > > +
> > > +       trace_assign_type(field, iter->ent);
> > > +       print_fn_trace(s, field->ip, field->parent_ip, flags);
> > > +       trace_seq_printf(s, " object:0x%lx", field->object);
> > > +       trace_seq_putc(s, '\n');
> > > +
> > > +       return trace_handle_return(s);
> > > +}
> > > +
> > > +static enum print_line_t trace_object_raw(struct trace_iterator
> > > *iter, int flags,
> > > +                                     struct trace_event *event)
> > > +{
> > > +       struct trace_object_entry *field;
> > > +
> > > +       trace_assign_type(field, iter->ent);
> > > +
> > > +       trace_seq_printf(&iter->seq, "%lx %lx\n",
> > > +                        field->ip,
> > > +                        field->parent_ip);
> > > +
> > > +       return trace_handle_return(&iter->seq);
> > > +}
> > > +
> > > +static struct trace_event_functions trace_object_funcs = {
> > > +       .trace          = trace_object_print,
> > > +       .raw            = trace_object_raw,
> > > +};
> > > +
> > > +static struct trace_event trace_object_event = {
> > > +       .type           = TRACE_OBJECT,
> > > +       .funcs          = &trace_object_funcs,
> > > +};
> > > +
> > >  static struct trace_event *events[] __initdata = {
> > >         &trace_fn_event,
> > >         &trace_ctx_event,
> > > @@ -1561,6 +1600,7 @@ static struct trace_event *events[]
> > > __initdata = {
> > >         &trace_timerlat_event,
> > >         &trace_raw_data_event,
> > >         &trace_func_repeats_event,
> > > +       &trace_object_event,
> > >         NULL
> > >  };
> > >
> > > --
> > > 2.25.1
> > >
> >
> > Thanks,
> > JeffXie
>

Thanks,
JeffXie
