Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C881147B482
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 21:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhLTUna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 15:43:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59930 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229701AbhLTUn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 15:43:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640033007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1hlOwvFKZcsLm0T6LvLqSoyxg9OoaJf+SdilEdQIzhI=;
        b=GBXj5RqXUPXy0hWEKSi1+5IR4UHhqg/XEsl1Z2JsU1HV3pKLyIsbCtRDIoNLuIRw5Bx/wp
        /eZnZC6kpnHwnypyy/HoQwMkjCakdcqcm0xs9ksU8GAc9AHGo+5bqzXahh6HLOU3/5MZCK
        YZDsEBJ5ROHw41FlfavLJQCx+oVUsRQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-3gZ_o7_fOcuYgSUFa0Z_kA-1; Mon, 20 Dec 2021 15:43:26 -0500
X-MC-Unique: 3gZ_o7_fOcuYgSUFa0Z_kA-1
Received: by mail-ed1-f70.google.com with SMTP id w17-20020a056402269100b003f7ed57f96bso8498923edd.16
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 12:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1hlOwvFKZcsLm0T6LvLqSoyxg9OoaJf+SdilEdQIzhI=;
        b=xkfIOhvajc1EsZSy8eNm6gKHhoBWQxqwO4esgdABb2iFLA1+xN/8q9UpMqGd7O0u2x
         QHDYWxyvPaJWXPPkR3JZPYY0Tf8Mik00DaCB4fqoFOYtXP1nveQiaubJ/9QKEEHxHZ2w
         2JFMsHSmw9AsNtRi7eDvkGkK2dmEn8gQVB9UmM6rgplbblLFQ1jYqcPL3AkLAnOCFQ6I
         skKAsDCc0MiLpbRxxhx5cfLY2+0BLKI1HczFOkfgorMDZWN6zNN1Oy5yP13Nf4j4kWg/
         F1LLgbcAb5HMnMoWdQ24Qejii1dnLn9B/RhIYq8n55RimvNO95J/NvdMc4OruZgkP7y/
         rCOQ==
X-Gm-Message-State: AOAM531jAkTpAMwZY1pRfpNQqnQrnwmQXtCps45uS9zsWYD79dCXOfyJ
        3btd/zqwt80wq+lIT/3aPKlfLseV/eWvad2QS9xGnswcag6+mZ1+3yPpDYClpS2WdFuRd5LgVWj
        JDol/Q76ugz+KU7B3VlKdFHzLk7PHLWvgOKXSqLQx
X-Received: by 2002:a17:906:8241:: with SMTP id f1mr13928134ejx.112.1640033005124;
        Mon, 20 Dec 2021 12:43:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwtAkh5EjBWJh8j9SSD5VmJMItWF027VATsGPU3EUp/a/qEqgDeEd8xokA6LZm2KfLDH0I0iy3GTBCJYi6fctU=
X-Received: by 2002:a17:906:8241:: with SMTP id f1mr13928122ejx.112.1640033004887;
 Mon, 20 Dec 2021 12:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20211220192827.38297-1-wander@redhat.com> <8340efc7-f922-fb8c-772c-de72cefe3470@kernel.dk>
 <CAAq0SUn_Nru1NTyzgjB9ETsaM46bgDRf3DTa+Z9sG-c8yjuQdw@mail.gmail.com>
 <b07b97b4-dff2-5915-ce56-a039a14a74dd@kernel.dk> <CAAq0SUmQ5aXtr-tVYLry7zZwTHG6J=X7QV9q0man7pXn7uZjQQ@mail.gmail.com>
 <2f2f5003-e1bf-15ce-32cd-a543634ba880@kernel.dk>
In-Reply-To: <2f2f5003-e1bf-15ce-32cd-a543634ba880@kernel.dk>
From:   Wander Costa <wcosta@redhat.com>
Date:   Mon, 20 Dec 2021 17:43:13 -0300
Message-ID: <CAAq0SUkZ_Zm_KZc-S02xAuR+td0T1nx=cPCs6D2cb_xt6EsUEg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] blktrace: switch trace spinlock to a raw spinlock
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 5:37 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/20/21 1:34 PM, Wander Costa wrote:
> > On Mon, Dec 20, 2021 at 5:24 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 12/20/21 12:49 PM, Wander Costa wrote:
> >>> On Mon, Dec 20, 2021 at 4:38 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>>>
> >>>> On 12/20/21 12:28 PM, Wander Lairson Costa wrote:
> >>>>> The running_trace_lock protects running_trace_list and is acquired
> >>>>> within the tracepoint which implies disabled preemption. The spinlock_t
> >>>>> typed lock can not be acquired with disabled preemption on PREEMPT_RT
> >>>>> because it becomes a sleeping lock.
> >>>>> The runtime of the tracepoint depends on the number of entries in
> >>>>> running_trace_list and has no limit. The blk-tracer is considered debug
> >>>>> code and higher latencies here are okay.
> >>>>
> >>>> You didn't put a changelog in here. Was this one actually compiled? Was
> >>>> it runtime tested?
> >>>
> >>> It feels like the changelog reached the inboxes after patch (at least
> >>> mine was so). Would you like that I send a v6 in the hope things
> >>> arrive in order?
> >>
> >> Not sure how you are sending them, but they don't appear to thread
> >> properly. But the changelog in the cover letter isn't really a
> >> changelog, it doesn't say what changed.
> >>
> >
> > Sorry, I think I was too brief in my explanation. I am backporting
> > this patch to the RHEL 9 kernel (which runs kernel 5.14). I mistakenly
> > generated the v4 patch from that tree, but it lacks this piece
> >
> > @@ -1608,9 +1608,9 @@ static int blk_trace_remove_queue(struct request_queue *q)
> >
> >         if (bt->trace_state == Blktrace_running) {
> >                 bt->trace_state = Blktrace_stopped;
> > -               spin_lock_irq(&running_trace_lock);
> > +               raw_spin_lock_irq(&running_trace_lock);
> >                 list_del_init(&bt->running_list);
> > -               spin_unlock_irq(&running_trace_lock);
> > +               raw_spin_unlock_irq(&running_trace_lock);
> >                 relay_flush(bt->rchan);
> >         }
> >
> > Causing the build error. v5 adds that. Sorry again for the confusion.
>
> Right, that's why I asked if a) you had even built this patch, and b) if
> you had tested it as well.
>

Yes, I had. But I had two versions of it. One for RHEL and one for
torvalds/master. I just picked the wrong branch when generating it.
I apologize for the mess once more.

> --
> Jens Axboe
>

