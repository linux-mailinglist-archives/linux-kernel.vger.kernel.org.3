Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D12847B468
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 21:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhLTUep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 15:34:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229707AbhLTUeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 15:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640032476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g1ikgkbADWsC3uaAnCq3l4qsb/4Ni8ZiD/z9qypPHBI=;
        b=hHrfINmtiO6DDkPph+hf9rLEohWdRLEulImRNeNkPhXbOSn9KaiuyFOdUU+Hg3NXLi3VKo
        vvK34IOOfBn/gCZR4y/HpKFlQGKPEJJ3ojTY2dmViFlu5gIAMWHeUwzfln7hnMCxWCuWrF
        /3U1X6kjvAi7j4hsKQ/hO0wHLLhJj3g=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-6GXMf5kVPrO5a3e-416luA-1; Mon, 20 Dec 2021 15:34:35 -0500
X-MC-Unique: 6GXMf5kVPrO5a3e-416luA-1
Received: by mail-ed1-f71.google.com with SMTP id o20-20020a056402439400b003f83cf1e472so4359056edc.18
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 12:34:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g1ikgkbADWsC3uaAnCq3l4qsb/4Ni8ZiD/z9qypPHBI=;
        b=JqCsnMkEPqAG6dRiZHObByXcB+RWjji2GE+W0sjf3NvEWNZVcGUmOkfrGh4kYL5PH0
         byFEG+metkk2NYpoaW5kjNsWgV7giN9prBGI/kEMF83b5Lp9D6YcfVluXsLiQH8MMfRh
         Gim7UgJ/YP26g9hP4LFOxjxz2ifwTKT/TSuzsLal/Z9ItW2KBp3NRLAvQTo4pdopmzhw
         IOj2mYHaB/4YpDk9h5r6g3td5xnXZ4L3RsmlBZXvWn71hchxXGHI1rCmq9soXFnRIEUp
         rJ6/GSBw/mRUH3o11wFA5pQAncIW8Lw7dRZi6F43RLzfAWlxYfqxRYtHBmSOeuv/rBoN
         RWSQ==
X-Gm-Message-State: AOAM530gfNq6DzqIfi2VKiO4TAcsOzRTJFPhiK607jnf1nSRi/VlqrhE
        HDkcq1Tc5GSrwd8ehqNJ4n6b5X+fj6mpUPhdDW6MJCKiZmq5DlKMvXj3Tm9p8q9Y1A4SK+/uvUC
        zARZxzQuHtQy96cTMOlnste/zHOJ3ia6MevdUibAh
X-Received: by 2002:a17:906:1d4e:: with SMTP id o14mr6927960ejh.205.1640032473869;
        Mon, 20 Dec 2021 12:34:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwShPGp9UEQCEYIKorpIH/sLf34mUNXhS8WA1FjYTUUyBSp2QdGX9b0i44cFRDpoQcHS41YL45LC3LmrCohl9g=
X-Received: by 2002:a17:906:1d4e:: with SMTP id o14mr6927955ejh.205.1640032473646;
 Mon, 20 Dec 2021 12:34:33 -0800 (PST)
MIME-Version: 1.0
References: <20211220192827.38297-1-wander@redhat.com> <8340efc7-f922-fb8c-772c-de72cefe3470@kernel.dk>
 <CAAq0SUn_Nru1NTyzgjB9ETsaM46bgDRf3DTa+Z9sG-c8yjuQdw@mail.gmail.com> <b07b97b4-dff2-5915-ce56-a039a14a74dd@kernel.dk>
In-Reply-To: <b07b97b4-dff2-5915-ce56-a039a14a74dd@kernel.dk>
From:   Wander Costa <wcosta@redhat.com>
Date:   Mon, 20 Dec 2021 17:34:22 -0300
Message-ID: <CAAq0SUmQ5aXtr-tVYLry7zZwTHG6J=X7QV9q0man7pXn7uZjQQ@mail.gmail.com>
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

On Mon, Dec 20, 2021 at 5:24 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/20/21 12:49 PM, Wander Costa wrote:
> > On Mon, Dec 20, 2021 at 4:38 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 12/20/21 12:28 PM, Wander Lairson Costa wrote:
> >>> The running_trace_lock protects running_trace_list and is acquired
> >>> within the tracepoint which implies disabled preemption. The spinlock_t
> >>> typed lock can not be acquired with disabled preemption on PREEMPT_RT
> >>> because it becomes a sleeping lock.
> >>> The runtime of the tracepoint depends on the number of entries in
> >>> running_trace_list and has no limit. The blk-tracer is considered debug
> >>> code and higher latencies here are okay.
> >>
> >> You didn't put a changelog in here. Was this one actually compiled? Was
> >> it runtime tested?
> >
> > It feels like the changelog reached the inboxes after patch (at least
> > mine was so). Would you like that I send a v6 in the hope things
> > arrive in order?
>
> Not sure how you are sending them, but they don't appear to thread
> properly. But the changelog in the cover letter isn't really a
> changelog, it doesn't say what changed.
>

Sorry, I think I was too brief in my explanation. I am backporting
this patch to the RHEL 9 kernel (which runs kernel 5.14). I mistakenly
generated the v4 patch from that tree, but it lacks this piece

@@ -1608,9 +1608,9 @@ static int blk_trace_remove_queue(struct request_queue *q)

        if (bt->trace_state == Blktrace_running) {
                bt->trace_state = Blktrace_stopped;
-               spin_lock_irq(&running_trace_lock);
+               raw_spin_lock_irq(&running_trace_lock);
                list_del_init(&bt->running_list);
-               spin_unlock_irq(&running_trace_lock);
+               raw_spin_unlock_irq(&running_trace_lock);
                relay_flush(bt->rchan);
        }

Causing the build error. v5 adds that. Sorry again for the confusion.

> --
> Jens Axboe
>

