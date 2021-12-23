Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36E947E464
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 15:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348779AbhLWOMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 09:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbhLWOM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 09:12:28 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF14FC061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 06:12:27 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t18so11676242wrg.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 06:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HGR9dxnQlCMn8eEQiRDOIthPZONlf6Fa5o7hbr1KMfM=;
        b=LedQH98Z0qVLS+yuGyGPQs9YnHV6cLHyhZW9zoXnGTbyPmIZz1yTHsuBoJGpa70/dF
         MjO1NTdwbRENN6YTIrqSNDCgnHFhS6VX2eh25I1QKFZCjc7jV4gE+I2jpTGkLZFVlnnG
         /XQwn7Jn2jxQHABpfXrw+CFVf0VrvfpJCif6xOomefZet8bUKniBl9VBosvr2dDJRbQf
         OWMdqOsNqP2bZ0k3dfZh3Dnc1E0DbnGcbSayMudxCigDechuQIKH4tmP161/Qge6/hlQ
         Zi6+ud+qWuy9maOs5BG6eCQWnp82vuCcMm4CC7xnnHqGtpQxNl2vmTadvgBL+vdPZoAX
         6a2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HGR9dxnQlCMn8eEQiRDOIthPZONlf6Fa5o7hbr1KMfM=;
        b=6fBh02O/cXljbYVGdx8vO8AwTv0cNODnn70+opNjTlQtL7qtwKr2by/D9rj7YDcYdF
         dT2UUvLnZXVBQFRBNfWHmkGKnPNUD6WYcrsT6g4zUelClzwmWFJ3ADoCu3lkuPWhqEwX
         RrU+qctaTpFBHwgcBmVgOiCFu7PcUi/5ZiBE962Rv/qqZBARC54MiS1zRG7HvPfBllTS
         NI8oyckZuhcgjrnCugBPjE6tcWpY5E3iNLOrBOd6PoLKGWYl9c96Z91PmTHppUBhZLE8
         N/uGfGhjyF4yCTVLHasfqNx6mdm8/6b1Ecnz+ByM/SOra4SKGt6Z+zEWpg4+vLggl8ha
         /VGg==
X-Gm-Message-State: AOAM533WxKiaUfbYHNXsGwZPSw+wzrhZuF8o8GyvjEah5NTN6Bsf51gd
        6Z6kiw51P+mR19iqPpQB9SCjCTs+feB4RhtzbPnZxSdlS/0=
X-Google-Smtp-Source: ABdhPJzUiREkTiGOW+f/Fst/7ka8B5pdODHLYpXs8vMll/UYnzVruHdMHBuC7mewdHnywRfYR7r8UNQgfp6iPiQEeCI=
X-Received: by 2002:a5d:4489:: with SMTP id j9mr1885041wrq.544.1640268746428;
 Thu, 23 Dec 2021 06:12:26 -0800 (PST)
MIME-Version: 1.0
References: <20211129164951.220511-1-xiehuan09@gmail.com> <20211129164951.220511-2-xiehuan09@gmail.com>
 <20211217135149.db5ee4b1b110c845739106d4@kernel.org> <CAEr6+EAn3+vWvp46mheO=MTetLyHXy-GDENtN8O6y+5T+Y-N7w@mail.gmail.com>
 <20211221163606.be53698d89ce08a272810ae1@kernel.org> <CAEr6+EBLWZwBx=pCWSL_bqAi0LYGmUyo2iq6Fz4Q6c06Eo26ug@mail.gmail.com>
In-Reply-To: <CAEr6+EBLWZwBx=pCWSL_bqAi0LYGmUyo2iq6Fz4Q6c06Eo26ug@mail.gmail.com>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Thu, 23 Dec 2021 22:12:14 +0800
Message-ID: <CAEr6+EAgS5zq_Xne8aAwsQhtt=LPrdOqM2t3_ex4U_qGY8RwXg@mail.gmail.com>
Subject: Re: [RFC][PATCH v6 1/5] trace: Add trace any kernel object
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Tue, Dec 21, 2021 at 6:29 PM Jeff Xie <xiehuan09@gmail.com> wrote:
>
> Hi Masami,
>
> On Tue, Dec 21, 2021 at 3:36 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi Jeff,
> >
> > On Sat, 18 Dec 2021 00:32:57 +0800
> > Jeff Xie <xiehuan09@gmail.com> wrote:
> >
> > > > > +struct object_instance {
> > > > > +     void *object;
> > > > > +     struct freelist_node free_list;
> > > > > +     struct list_head active_list;
> > > > > +};
> > > > > +
> > > > > +struct obj_pool {
> > > > > +     struct freelist_head free_list;
> > > > > +     struct list_head active_list;
> > > > > +};
> > > > > +static struct obj_pool *obj_pool;
> > > > > +
> > > > > +static bool object_exist(void *obj)
> > > > > +{
> > > > > +     struct object_instance *inst;
> > > > > +     bool ret = false;
> > > > > +
> > > > > +     list_for_each_entry_rcu(inst, &obj_pool->active_list, active_list) {
> > > > > +             if (inst->object == obj) {
> > > > > +                     ret = true;
> > > > > +                     goto out;
> > > > > +             }
> > > > > +     }
> > > > > +out:
> > > > > +     return ret;
> > > > > +}
> > > > > +
> > > > > +static bool object_empty(void)
> > > > > +{
> > > > > +     return list_empty(&obj_pool->active_list);
> > > > > +}
> > > > > +
> > > > > +static void set_trace_object(void *obj)
> > > > > +{
> > > > > +     struct freelist_node *fn;
> > > > > +     struct object_instance *ins;
> > > > > +     unsigned long flags;
> > > > > +
> > > > > +     if (in_nmi())
> > > > > +             return;
> > > > > +
> > > > > +     if (!obj)
> > > > > +             return;
> > > > > +
> > > > > +     if (object_exist(obj))
> > > > > +             return;
> > > > > +
> > > > > +     fn = freelist_try_get(&obj_pool->free_list);
> > > > > +     if (!fn) {
> > > > > +             trace_printk("object_pool is full, can't trace object:0x%px\n", obj);
> > > > > +             return;
> > > > > +     }
> > > > > +
> > > > > +     ins = container_of(fn, struct object_instance, free_list);
> > > > > +     ins->object = obj;
> > > > > +
> > > > > +     raw_spin_lock_irqsave(&object_spin_lock, flags);
> > > > > +     list_add_rcu(&ins->active_list, &obj_pool->active_list);
> > > > > +     raw_spin_unlock_irqrestore(&object_spin_lock, flags);
> > > >
> > > > Please add a comment that why this spinlock is needed here and why
> > > > other operation doesn't need it.
> > >
> > > (Only this place has write operations, and it cannot be concurrent)
> > > I agree, I will add it.
> >
> > BTW, I have another better solution for object pool. If the
> > object pool size is fixed (of course to avoid performance overhead,
> > it should be small enough) and it can not avoid using spinlock,
> > it is better to use fixed-size array. That makes the implementation
> > much simpler.
>
> This looks really simpler, I will add it in the next version ;-)
>
> > static struct object_instance {
> >         void *obj;      /* trace object */
> >         // add offset in the next patch
> > } traced_obj[MAX_TRACE_OBJECT];
> >
> > static atomic_t num_traced_obj;
> > static DEFINE_RAW_SPINLOCK(trace_obj_lock);
> >
> > static void set_trace_object(void *obj)
> > {
> >         ...
> >
> >         raw_spin_lock_irqsave(&trace_obj_lock, flags);
> >         if (num_traced_obj == MAX_TRACED_OBJECT)
> >                 goto out;
> >
> >         traced_obj[num_traced_obj].obj = obj;
> >         smp_wmb();      // make sure the num_traced_obj update always appears after trace_obj update.
> >         num_traced_obj++;
>
> I would like to ask whether this place need to add another smp_wmb()
> to match the smp_rmb() in the object_exist().
> I learned that rcu has a publish and subscribe mechanism ;-)

There is no need to add another smp_wmb(). I understood.

Have a nice holiday;-) Thanks.

>
> > out:
> >         raw_spin_unlock_irqrestore(&trace_obj_lock, flags);
> > }
> >
> > static bool object_exist(void *obj)
> > {
> >         ...
> >         max = num_traced_obj;
> >         smp_rmb();      // then the num_traced_obj will cap the max.
> >         for (i = 0; i < max; i++) {
> >                 if (traced_obj[i].obj == obj)
> >                         return true;
> >         }
> >         return false;
> > }
> >
> > static inline void free_object_pool(void)
> > {
> >         num_traced_obj = 0;
> >         memset(traced_obj, 0, sizeof(traced_obj));
> > }
> >
> > Sorry if I confuse you but I think you shouldn't take a time on those unneeded
> > complexity. :)
>
> Thanks, at least I learned a different way to implement it ;-)
>
> >
> >
> > > > > +static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
> > > > > +                              unsigned long object)
> > > > > +{
> > > > > +
> > > > > +     struct trace_buffer *buffer;
> > > > > +     struct ring_buffer_event *event;
> > > > > +     struct trace_object_entry *entry;
> > > > > +     int pc;
> > > > > +
> > > > > +     pc = preempt_count();
> > > > > +     event = trace_event_buffer_lock_reserve(&buffer, &event_trace_file,
> > > > > +                     TRACE_OBJECT, sizeof(*entry), pc);
> > > > > +     if (!event)
> > > > > +             return;
> > > > > +     entry   = ring_buffer_event_data(event);
> > > > > +     entry->ip                       = ip;
> > > > > +     entry->parent_ip                = parent_ip;
> > > > > +     entry->object                   = object;
> > > > > +
> > > > > +     event_trigger_unlock_commit(&event_trace_file, buffer, event,
> > > > > +             entry, pc);
> > > > > +}
> > > > > +
> > > > > +static void
> > > > > +trace_object_events_call(unsigned long ip, unsigned long parent_ip,
> > > > > +             struct ftrace_ops *op, struct ftrace_regs *fregs)
> > > > > +{
> > > > > +     struct pt_regs *pt_regs = ftrace_get_regs(fregs);
> > > > > +     unsigned long obj;
> > > > > +     long disabled;
> > > > > +     int cpu, n;
> > > > > +
> > > > > +     preempt_disable_notrace();
> > > > > +
> > > > > +     cpu = raw_smp_processor_id();
> > > > > +     disabled = atomic_inc_return(&per_cpu(trace_object_event_disable, cpu));
> > > >
> > > > So what is the purpose of this check? (are there any issue if the same
> > > > cpu reenter here?)
> > > >
> > >
> > > There may be an interrupt context that can preempt it. I am not yet
> > > sure whether the cpu reenter  will affect it.
> > > I will debug and test it. (Referred from function_test_events_call())
> >
> > Maybe you can use ftrace_test_recursion_trylock(), as kprobe_ftrace_handler()
> > does.
>
> I will use it ,thanks.
>
> >
> > Thank you,
> >
> > --
> > Masami Hiramatsu <mhiramat@kernel.org>
> ---
> JeffXie
---
JeffXie
