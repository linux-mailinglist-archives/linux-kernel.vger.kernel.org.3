Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0104932F4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 03:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351006AbiASCdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 21:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238636AbiASCdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 21:33:03 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB5AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 18:33:03 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id w26so2182146wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 18:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jo4m/kDU7bD6uVH76qeZbDQVg9E+WokGX2yPLC7fnuI=;
        b=mZN4HjK9D8RGQ9dMfefNiLHAsgX63jHV16sVV4mv+NnT6jt/YXE2tuBCp3FMBLOwx9
         hV4sDnP0e/RjZlf+872l5e7JF+WAacRERVKWhgkBMTe7NqKTbL3Qq6a7TUx38rGhKRId
         BmNBuits9kDtfdTXOsSnitg6dUQkOeAu51ke/e01GTSwJzx9y1xyWXtpWqUDgQow2VWI
         MZAOu/nhOgwvvGRbPuZ3z0MJoGVIIuC+JyS1AoDyZVxAclHiuoB/NTARQ3RrhRrtug55
         HtAdB/230UNjr2Jz7KHX+cq+b3JGUYte2co14nYvofQW84GWuCXrccVMrh6ag5G1VhlM
         n2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jo4m/kDU7bD6uVH76qeZbDQVg9E+WokGX2yPLC7fnuI=;
        b=Wkngjjfopp/E+D11vkynJ2tY1E5Bgnm6g2RItcaJ8IQfUUpn70QOdjauiqMP1eziP9
         /MLJgp7NbmmjbKXhIFQ2nsACkgyxQgvmNj+17BzpvAnB0nNX5zmYWjxkTw7Iqyjs2Q77
         KmokE3tosHasCh3MkJJQf5LvXpS7EzTLG7i1OIbqhixtWFnSceoYrGYeXj6slrQ89d3o
         WP1veZSA0/HnO6YZgyq3y/zaga3Uy3uLr6bw1pzK7EFAPwzCYWpdKG71LdWA32lrP9Uf
         uaStsV2s6ZxQpx+9ZQq5dXU8HiDv0uQvUS9qiNt5anCQ4LOjCEFtZbrMlNb1v4+3cRXA
         TksA==
X-Gm-Message-State: AOAM531Klc16OtQwMKMYYhAu61souO+zYAuFstf5GsYkSpFjQCOnjZQq
        +qbG6N7wqMVBk4nSfuUMMm1Jzufb5xym7Vd/LrQ=
X-Google-Smtp-Source: ABdhPJxu5bGdeTKhiTpmGmpJZySyY+3ujcx8kwWBwevnmiup2H1193ralS5z7EGmi5rLChdPTTq90rMFhEiAZXseX7U=
X-Received: by 2002:adf:eb87:: with SMTP id t7mr27008717wrn.147.1642559581193;
 Tue, 18 Jan 2022 18:33:01 -0800 (PST)
MIME-Version: 1.0
References: <20220113013835.503285-1-xiehuan09@gmail.com> <20220118232448.891fbf550b50193e0155b59c@kernel.org>
In-Reply-To: <20220118232448.891fbf550b50193e0155b59c@kernel.org>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Wed, 19 Jan 2022 10:32:49 +0800
Message-ID: <CAEr6+EB+ENLJM1vU1pPgQ4ZcYe6FDSRWwdSpY_dLq0tGqr+tnQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] trace: Introduce objtrace trigger to trace the
 kernel object
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Tue, Jan 18, 2022 at 10:24 PM Masami Hiramatsu <mhiramat@kernel.org> wro=
te:
>
> On Thu, 13 Jan 2022 09:38:31 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> > Introduce a method based on function tracer to trace any object and get
> > the value of the object dynamically. the object can be obtained from th=
e
> > dynamic event (kprobe_event/uprobe_event) or the static event(tracepoin=
t).
> >
> > Usage:
> > When using the kprobe event, only need to set the objtrace(a new trigge=
r),
> > we can get the value of the object. The object is from the setting of t=
he
> > kprobe event.
> >
> > For example:
> > For the function bio_add_page():
> >
> > int bio_add_page(struct bio *bio, struct page *page,
> >       unsigned int len, unsigned int offset)
> >
> > Firstly, we can set the base of the object, thus the first string "arg1=
"
> > stands for the value of the first parameter of this function bio_add_ga=
ge(),
> >
> > # echo 'p bio_add_page arg1=3D$arg1' >> ./kprobe_events
> >
> > Secondly, we can get the value dynamically base the above object.
> >
> > find the offset of the bi_size in struct bio:
> > $ gdb vmlinux
> > (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
> > $1 =3D (unsigned int *) 0x28
> >
> > # echo 'objtrace:add:arg1,0x28:u32:1 if comm =3D=3D "cat"' > ./events/k=
probes/ \
> >       p_bio_add_page_0/trigger
> >
> > The best way to use this is that we can set the entrance event and exit
> > event, for example, the following example is to set the read_papes as
> > the entrance event, and set the __blk_account_io_start as the exit even=
t.
> >
> > # cd /sys/kernel/debug/tracing/
> > # echo 0 > ./tracing_on
> > # echo 'p read_pages' >> ./kprobe_events
> > # echo 'p __blk_account_io_start' >> ./kprobe_events
> > # echo 'traceon if comm =3D=3D "cat"' > ./events/kprobes/p_read_pages_0=
/trigger
> > # echo 'traceoff if comm =3D=3D "cat"' > ./events/kprobes/p___blk_accou=
nt_io_start_0/trigger
> > # echo 'p bio_add_page arg1=3D$arg1' >> ./kprobe_events
> > # echo 'objtrace:add:arg1,0x28:u32:1 if comm =3D=3D "cat"' > ./events/k=
probes/p_bio_add_page_0/trigger
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
> > #                                _-----=3D> irqs-off
> > #                               / _----=3D> need-resched
> > #                              | / _---=3D> hardirq/softirq
> > #                              || / _--=3D> preempt-depth
> > #                              ||| / _-=3D> migrate-disable
> > #                              |||| /     delay
> > #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > #              | |         |   |||||     |         |
> >              cat-95      [000] .....     1.412065: _raw_spin_unlock_irq=
restore <-event_triggers_call object:0xffff888108af6328 value:0x0
> >              cat-95      [000] .....     1.412066: __bio_try_merge_page=
 <-bio_add_page object:0xffff888108af6328 value:0x0
> >              cat-95      [000] .....     1.412066: __bio_add_page <-bio=
_add_page object:0xffff888108af6328 value:0x0
> >              cat-95      [000] .....     1.412066: rcu_read_unlock_stri=
ct <-xa_load object:0xffff888108af6328 value:0x1000
> >              cat-95      [000] .....     1.412066: bio_add_page <-ext4_=
mpage_readpages object:0xffff888108af6328 value:0x1000
> >              cat-95      [000] .....     1.412066: kprobe_ftrace_handle=
r <-ftrace_ops_list_func object:0xffff888108af6328 value:0x1000
> >              cat-95      [000] .....     1.412067: get_kprobe <-kprobe_=
ftrace_handler object:0xffff888108af6328 value:0x1000
> >              cat-95      [000] .....     1.412067: __bio_try_merge_page=
 <-bio_add_page object:0xffff888108af6328 value:0x1000
> >              cat-95      [000] .....     1.412067: __bio_add_page <-bio=
_add_page object:0xffff888108af6328 value:0x1000
> >              cat-95      [000] .....     1.412067: rcu_read_unlock_stri=
ct <-xa_load object:0xffff888108af6328 value:0x2000
> >              cat-95      [000] .....     1.412067: bio_add_page <-ext4_=
mpage_readpages object:0xffff888108af6328 value:0x2000
> >              cat-95      [000] .....     1.412067: kprobe_ftrace_handle=
r <-ftrace_ops_list_func object:0xffff888108af6328 value:0x2000
> >              cat-95      [000] .....     1.412067: get_kprobe <-kprobe_=
ftrace_handler object:0xffff888108af6328 value:0x2000
> >              cat-95      [000] .....     1.412067: __bio_try_merge_page=
 <-bio_add_page object:0xffff888108af6328 value:0x2000
> >              cat-95      [000] .....     1.412068: submit_bio <-ext4_mp=
age_readpages object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412068: submit_bio_noacct <-=
ext4_mpage_readpages object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412068: __submit_bio <-submi=
t_bio_noacct object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412068: blk_try_enter_queue =
<-__submit_bio object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412068: rcu_read_unlock_stri=
ct <-blk_try_enter_queue object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412068: rcu_read_unlock_stri=
ct <-blk_try_enter_queue object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412068: submit_bio_checks <-=
__submit_bio object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412068: __cond_resched <-sub=
mit_bio_checks object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412068: rcu_all_qs <-__cond_=
resched object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412068: should_fail_bio <-su=
bmit_bio_checks object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412069: create_task_io_conte=
xt <-submit_bio_checks object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412069: kmem_cache_alloc_nod=
e <-create_task_io_context object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412069: should_failslab <-km=
em_cache_alloc_node object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412069: _raw_spin_lock <-cre=
ate_task_io_context object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412069: blk_mq_submit_bio <-=
__submit_bio object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412069: __blk_queue_split <-=
blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412069: bvec_split_segs <-__=
blk_queue_split object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412069: blk_attempt_plug_mer=
ge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412070: __blk_mq_sched_bio_m=
erge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412070: dd_bio_merge <-blk_m=
q_submit_bio object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412070: _raw_spin_lock <-dd_=
bio_merge object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412070: blk_mq_sched_try_mer=
ge <-dd_bio_merge object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412070: elv_merge <-blk_mq_s=
ched_try_merge object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412070: elv_rqhash_find <-el=
v_merge object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412070: dd_request_merge <-b=
lk_mq_sched_try_merge object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412070: elv_rb_find <-dd_req=
uest_merge object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412070: __blk_mq_alloc_reque=
st <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412071: dd_limit_depth <-__b=
lk_mq_alloc_request object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412071: blk_mq_get_tag <-__b=
lk_mq_alloc_request object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412071: __blk_mq_get_tag <-b=
lk_mq_get_tag object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412071: blk_mq_rq_ctx_init.i=
sra.0 <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412071: ktime_get <-blk_mq_r=
q_ctx_init.isra.0 object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412071: dd_prepare_request <=
-blk_mq_rq_ctx_init.isra.0 object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412071: __blk_account_io_sta=
rt <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412071: kprobe_ftrace_handle=
r <-ftrace_ops_list_func object:0xffff888108af6328 value:0x3000
> >              cat-95      [000] .....     1.412071: get_kprobe <-kprobe_=
ftrace_handler object:0xffff888108af6328 value:0x3000
> >
> > Almost all changelogs were suggested by Masami(mhiramat@kernel.org)
> > and steve(rostedt@goodmis.org), thank you all so much.
> >
> > v7:
> > - use fixed-size array for object pool instead of list structure
> > - use ftrace_test_recursion_trylock for function trace hook function
> > - fix trace_object_ref reference count in the init_trace_object
> > - invoke exit_trace_object no matter whether data->ops->free is null
> >   in the unregister_object_trigger
> > - release private_data of event_trigger_data in the trace_object_trigge=
r_free
> > - remove [RFC] tag
> >
> > Note: when change to use the ftrace_test_recursion_trylock, all the fun=
ctions
> > will call the copy_from_kernel_nofault, I don't know where this is the =
problem now,
> > maybe should fall back to the usage in v6.
> >
> > for example:
> >
> > cat-118     [000] ...1.     1.458998: __bio_add_page <-bio_add_page obj=
ect:0xffff88811a12e9e8 value:0x0
> > cat-118     [000] ...2.     1.458998: copy_from_kernel_nofault <-trace_=
object_events_call object:0xffff88811a12e9e8 value:0x1000
> > cat-118     [000] ...2.     1.458998: copy_from_kernel_nofault_allowed =
<-copy_from_kernel_nofault object:0xffff88811a12e9e8 value:0x1000
> > cat-118     [000] ...1.     1.458998: __rcu_read_lock <-xa_load object:=
0xffff88811a12e9e8 value:0x1000
> > cat-118     [000] ...2.     1.458998: copy_from_kernel_nofault <-trace_=
object_events_call object:0xffff88811a12e9e8 value:0x1000
> > cat-118     [000] ...2.     1.458998: copy_from_kernel_nofault_allowed =
<-copy_from_kernel_nofault object:0xffff88811a12e9e8 value:0x1000
> > cat-118     [000] ...1.     1.458998: __rcu_read_unlock <-xa_load objec=
t:0xffff88811a12e9e8 value:0x1000
> > cat-118     [000] ...3.     1.458998: copy_from_kernel_nofault <-trace_=
object_events_call object:0xffff88811a12e9e8 value:0x1000
> > cat-118     [000] ...3.     1.458998: copy_from_kernel_nofault_allowed =
<-copy_from_kernel_nofault object:0xffff88811a12e9e8 value:0x1000
> > ....
>
> Hmm, this is strange, but I got it is the expected behavior, since the
> ftrace_test_recursion_trylock() accepts one stage recursion for the
> first event in the interrupt as transition event.
> Steve, any good way to limit probing this transition events?
>
>
> BTW, I tried your series on the
> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git ftr=
ace/core
> and got below build errors.
>
> linux/kernel/trace/trace_object.c:266:3: error: =E2=80=98struct event_tri=
gger_ops=E2=80=99 has no member named =E2=80=98func=E2=80=99
>   266 |  .func   =3D trace_object_trigger,
>       |   ^~~~
> linux/kernel/trace/trace_object.c:273:3: error: =E2=80=98struct event_tri=
gger_ops=E2=80=99 has no member named =E2=80=98func=E2=80=99
>   273 |  .func   =3D trace_object_count_trigger,
>       |   ^~~~
> linux/kernel/trace/trace_object.c:535:3: error: =E2=80=98struct event_com=
mand=E2=80=99 has no member named =E2=80=98func=E2=80=99
>   535 |  .func   =3D event_object_trigger_callback,
>       |   ^~~~
>   CC      net/ipv6/sysctl_net_ipv6.o
>
> This is because commit 7d28e1e7d4fa ("tracing: Change event_trigger_ops f=
unc() to trigger()")
> and commit 4dfe5dff80a4 ("tracing: Change event_command func() to parse()=
") changed the field
> names. Please update it.
>
Thanks, I will update it.
>
> Thank you,
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
---
JeffXie
