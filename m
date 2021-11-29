Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF9646223C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhK2Uca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbhK2U3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:29:06 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEF7C014C5D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 09:03:41 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id n66so35814522oia.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 09:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nX30a4QZWH9pIp+HS7hHqbVoGTedAqpvRWM2pNn6yvk=;
        b=iNpmMG3bcGOwVtvVsLPD7ONahwSadjQ1wV2xPpLaLsVVHEXaVo6C8s/hn3ElXP9LT+
         XzebwxcHZ3VjQLTWndkChZjFw5fL8mPtdNI2n28NqosL9rue5vfv5asqVw0HIMWvmLQD
         sIkOxcQbLiUD8rnI1Pooaiopfh4NfZRRizaKXYvTRvOF7cduXYLZgwgVQrOmunL++kt9
         JgPON/pJgddgG/JuLAo7McATJQGQVwtQTmwK57TCnV65+SxUnosQdDeOUa56RLBowf0p
         zmLP/ICE/Rd0L+b7FSBLmcUvoacpSm29Xuc0m1VtnkxrB3uU0evauEzwUHC4do+ibgTi
         n4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nX30a4QZWH9pIp+HS7hHqbVoGTedAqpvRWM2pNn6yvk=;
        b=TlB9jUek+f/MflDzrGJJfTnjavcrlt+e1rH77R/y0+bPqCVuCFZh28L9gDGePAE7tj
         jXoLO+aCQVHZiunt0S18NEY5qYhdRUlZQb5hOpqm4JRYww/1g1DO1AMuGAVuz2ZbydMk
         G9OqeCFue8m1jTUfDMloFQXT+UiS6ZLhporBhKsTmOm+UhiScApBs6Ktg+zSwbmHqTib
         +Qc8pjG6nGmSF46/gSA7Ro712poRDkcU/9vFl5mzUQeFVF5W7h4ZB19dF3wMkHqpNLCP
         y1/6xfCBP1tLNONbMX9im8gyhG7ctIE+N1VXTUX5WggBJdYy87kCCkV7t3Uu8Vv8GpDp
         7/rA==
X-Gm-Message-State: AOAM533oIGZwYYrafYsH4Jh/Hd3vBrmhYvZMNFWnSCRu9QD7KlKgYS7g
        YNf00M/xoGbwr24I0AjHfa1aq3B6foO1/Dcmycm21g==
X-Google-Smtp-Source: ABdhPJy7py0i9eVc0v4KcfCYbKiNwsBeH38LkSL/flyaa6Yg1UZCcRod0dN/O2JOSYKg2rIQE6biNeJlReEE62NzZLs=
X-Received: by 2002:a05:6808:120b:: with SMTP id a11mr43674376oil.128.1638205421069;
 Mon, 29 Nov 2021 09:03:41 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003544c405c8a3026a@google.com> <20211128030309.1897-1-hdanton@sina.com>
 <CACT4Y+YXg=rRmCsM3i0ES_dXhFGdnS7LLwtX3YmRLjjr0haCOA@mail.gmail.com>
 <20211129131328.1960-1-hdanton@sina.com> <CACT4Y+ZxJUu+UrUpOwvcFOy2LubhP1HuCQybxaq-rrDsdO9bRg@mail.gmail.com>
 <YaTq1I82HEA/e6r6@hirez.programming.kicks-ass.net>
In-Reply-To: <YaTq1I82HEA/e6r6@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 29 Nov 2021 18:03:29 +0100
Message-ID: <CACT4Y+Zqn=Md3OTqNMTGh2r4_22XvkA59fo-VHbMUT5QRXZw8Q@mail.gmail.com>
Subject: Re: [syzbot] INFO: rcu detected stall in newstat
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Hillf Danton <hdanton@sina.com>, Boqun Feng <boqun.feng@gmail.com>,
        syzbot <syzbot+84ef57449019b1be878d@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rajatasthana4@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 at 15:59, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 29, 2021 at 03:15:16PM +0100, Dmitry Vyukov wrote:
>
> > Right, I missed the "preempt leak: 00000100 -> 00000101" warning. And
> > before that there is also "WARNING: inconsistent lock state" warning.
> > This reminds me of the issues we had with RCU/LOCKDEP before when an
> > RCU warning disabled LOCKDEP tracking, as the result LOCKDEP missed
> > part of events (e.g. tracked lock, but missed subsequent unlock) and
> > due to races/ordering issues it mis-reported them as nonsensical
> > reports.
>
> You're talking about how debug_locks_off() is a hot-racy-mess? That only
> matters if you're triggering stuff concurrently which *mostly* doesn't
> happen.
>
> I'm also not quite sure how to fix that without globally serializing
> everything, which would be super unhappy.

Yes, I think it was debug_locks_off().
But it's not about triggering 2 different, but real bugs concurrently.
It's about producing assorted unexplainable false positives
concurrently with debug_locks_off().
If false positives appear after the first real report (based on the
first "WARNING:" line), then it's not a problem for syzkaller (it will
just take the first one, confusing kernel developers aside).
However, in the previous case it happened so that the false positives
appeared _before_ the first real report and that confused syzkaller
and it reported these assorted false positives as new bugs.
In this case the second and third (potentially false) reports appeared
after the real one, so it's not a problem for syzkaller
parsing/reporting. We just need to learn to ignore them. However, if
debug_locks_off() already flipped some global atomic, couldn't the
report printing function check that atomic and just stop producing any
new reports?
But keep in mind that false-ness of these "inconsistent lock state"
and "preempt leak" in the log is just my hypothesis at this point.
