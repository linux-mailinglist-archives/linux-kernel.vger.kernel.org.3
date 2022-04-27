Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AE65123FA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 22:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbiD0Ugf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 16:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbiD0UgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 16:36:20 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD73CB6E52
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:32:50 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id r9so2412214pjo.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3OL9ul8Yg8Redeb4T6jkTbRtoSJFxX/GYGyKkQVbE/s=;
        b=Sc9Mqqp7U91ixMYKlRW2GFHAAoKHtUpb2ELoPXq/6K6Lyp0/daUWfX56ADa4AUYjS3
         ffzFGh16WqRg9jbjIb8nNaajV8LBsEOIo4kFMinKwXI6NINYlOsRmVZDwsPzjxsrI7Q/
         2X8zuANDNU4/nTOv7orxkMcwVREp3WqhJvlwdbIqAOaGZ/az2p1F8aCU/07QzMoCSb8t
         TWBnTf6/vnR/2RfZ5a/DhVi2IHhdHLoQIf42u1NQtp59Pn1AhRTbXRdcW1mqDKI5NmEC
         +8jXb6LDI572a6znJt+4kSE+HAIf1dwMo4Gpc5KnI4Xco/5fMjv6BM9nKQy74xBSGAAu
         5QvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OL9ul8Yg8Redeb4T6jkTbRtoSJFxX/GYGyKkQVbE/s=;
        b=UVivG7tucHOUB9EBcgd2YOah4mwcdqxUv3FkFi/8XlnWAUuqSNXqy8bfcRGlEaV+32
         iFNm3Sejn/nYbvZRf7QWPVsCWn5K9oNKOVTm2txAZkDCSwHnEOlJPoWVJKfu3Lrcck+B
         zVcc5nfTmsuA4q5DThq30lIIlftKm1+Hjf3Kobp8GbdJQOVzJgkdQSG6JhFimQ865TG1
         blRB2bcWIadZOOVmRZ29cVeO+/303T3mdELSCzFe2qjSvsbGJt3DM+6HdzkfD8v2Ksse
         I9uPVm92n7vZaRuefo93nP1MaeGM5pBCE0NS4wLIYbpOfTIJ+l1Cdn7ie3qP0dfmNtVH
         WaKA==
X-Gm-Message-State: AOAM532qSvz63q7S9tHsajddLZjsa6G31wgbRsgS8vMjcgY2yFre96pB
        0vAATx6EWociGlXDTk23D7sFcSWTYdmAz9PelEY=
X-Google-Smtp-Source: ABdhPJwKsQS4pNmam/0bTxFBV6fnvnelQL4ndi+bZ/3vnh6HXitL7WyPlq0W7gxb1XEgI5Comn/71tr8AmAuvaLu338=
X-Received: by 2002:a17:902:d58a:b0:15d:1cf6:644c with SMTP id
 k10-20020a170902d58a00b0015d1cf6644cmr15806406plh.67.1651091570272; Wed, 27
 Apr 2022 13:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220120162520.570782-1-valentin.schneider@arm.com>
 <93a20759600c05b6d9e4359a1517c88e06b44834.camel@fb.com> <20220422110903.GW2731@worktop.programming.kicks-ass.net>
 <056e9bb0d0e3fc20572d42db7386face1d0665d6.camel@fb.com> <CAADnVQKsah4aka-LJ+X+5XHHESKbbw36D8fXTLqcYp2io3PN_w@mail.gmail.com>
 <YmflVPQlwpiBuxRc@hirez.programming.kicks-ass.net> <20220426140959.op6u5m7id57aq7yc@wubuntu>
 <CAEf4BzaoL5HVc8U16kz7m--RiPhBwuLt8ZGZppwfxV85AXXrcw@mail.gmail.com>
 <20220427103458.ecnqtaj3af63625h@wubuntu> <CAEf4BzYc3f2-9hvuGL_mTO8qNxZjdQn8AabEb-N6Q7XjmEQQ1A@mail.gmail.com>
In-Reply-To: <CAEf4BzYc3f2-9hvuGL_mTO8qNxZjdQn8AabEb-N6Q7XjmEQQ1A@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 27 Apr 2022 13:32:39 -0700
Message-ID: <CAADnVQJTZ=QK+G6KU9GW2M7busBQEFbHUYRQsxi_a=ZpATBsyw@mail.gmail.com>
Subject: Re: [PATCH] sched/tracing: append prev_state to tp args instead
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Delyan Kratunov <delyank@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "legion@kernel.org" <legion@kernel.org>,
        "adharmap@quicinc.com" <adharmap@quicinc.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "ed.tsai@mediatek.com" <ed.tsai@mediatek.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 11:17 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> > >
> > > See my reply to Peter. libbpf can't know user's intent to fail this
> > > automatically, in general. In some cases when it can it does
> > > accommodate this automatically. In other cases it provides instruments
> > > for user to handle this (bpf_core_field_size(),
> > > BPF_CORE_READ_BITFIELD(), etc).
> >
> > My naiive thinking is that the function signature has changed (there's 1 extra
> > arg not just a subtle swap of args of the same type) - so I thought that can be
> > detected. But maybe it is harder said than done.
>
> It is. We don't have number of arguments either:
>
> struct bpf_raw_tracepoint_args {
>         __u64 args[0];
> };
>
> What BPF program is getting is just an array of u64s.

Well, that's a true and false statement at the same time
that might confuse folks reading this thread.
To clarify:
raw_tp and tp_btf programs receive an array of u64-s.
raw_tp checks the number of arguments only.
The prog that accesses non-existing arg will be rejected.
tp_btf prog in addition to the number of args knows
the exact type of the arguments.
So in this case accessing arg0 in bpf prog
as 'struct task_struct *' while it's 'unsigned int prev_state'
in the kernel will cause the verifier to reject it.
If prog does bpf_probe_read_kernel() then all bets are off, of course.
There is no type checking mechanism for bpf_probe_read_kernel.
Only BTF powered pointer dereferences are type checked.
The 'tp_btf' prog type is the recommended way to access tracepoints.
The 'raw_tp' was implemented before BTF was introduced.
