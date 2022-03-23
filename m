Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5A84E4A18
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 01:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiCWAgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 20:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiCWAf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:35:59 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9B03AA5E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 17:34:30 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id t123so2861667vst.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 17:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tA0C2APjUPvxOGUAlEU8GKwotzyFo+z45yPKoKfaa6s=;
        b=UIfE2szw5aFGRoxdGdKE3qdtZTi2+u5iPxxQjMMmCXkTbWP9F9bS2qGnERpXXLziPK
         1EWr+DZb6FZ13CMYpQnNPp4JKmpJ3dLI01g0r/6LJD9nelX37RczDQbcLY05lS4IaXKF
         LWtztqIuurveXB2MF9ZoqK9exAeKxKg49K/vj9UUZ/kFNra7vFHpdGR4Z/XzfSlfqHPs
         e8sEN3urYQl4Q/T5nDW9solGeNgNKb/Pf/7eccQQx6v/IW4hIybJszkF5C4BYH+REEdt
         UhYkU+3XP3D+TT4ECPVJAftyRi0R62VQLZGh+t7KeRVjVRTA/WR5MATXPVZirokf8J5Z
         qmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tA0C2APjUPvxOGUAlEU8GKwotzyFo+z45yPKoKfaa6s=;
        b=TbYXWYIrJWT9hvHvfFJa3TdqacmfDPLfZlNaNVdsD7LmYTbf5WAEkM8+mGVbfkjr3s
         OAzyvUUkqi2WefJOysza1ajWrFcGH/M3tPBXqIn96OCgryh2gZwsCcM8iDICmoG0wnz5
         Up6l2nnlD9oxX+VRlVpItoZ+ZNFqj/sT7vHzH4j1l8Znykq0D1MzE605dsYsQAPEOLks
         1apgXVrz6zNSjTYAvgOcOxPUSNxJ/3q4sjngNZYWrqUdemlG9VbyA/XUg3WBy/+0ruEj
         QXpBtoy/wShh8BdaR24Xd27Zm+cShQ7sNWiTWD6OSGxsz4D+TQFjLc6cdwM75gHxHAVC
         S1Zw==
X-Gm-Message-State: AOAM530MovPJuA1xL2JVmeYUHeXiWd5wsiqIsZooHoOIubSHtADTy+92
        fnYhF/vH/fRbrGiINyl/mXoM8EW/qOkLmZdfM7603Q==
X-Google-Smtp-Source: ABdhPJyLub9dB4R+fTlvR/EuxqZBTpRYAlQxAPGC3ICdYzW6yU0PKlpe2iYHRKc8ZjLENRyagkWkRieQ+5Z4BKCX/V8=
X-Received: by 2002:a67:ee95:0:b0:324:d2e8:9b5e with SMTP id
 n21-20020a67ee95000000b00324d2e89b5emr9463036vsp.58.1647995669348; Tue, 22
 Mar 2022 17:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <YjjihIZuvZpUjaSs@google.com> <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
 <51cded74-3135-eed8-06d3-0b2165e3b379@redhat.com> <CAHk-=wi=Xsekgj7zfw_vpOM673CG24vznmz-yx9G05rWSAAYXg@mail.gmail.com>
In-Reply-To: <CAHk-=wi=Xsekgj7zfw_vpOM673CG24vznmz-yx9G05rWSAAYXg@mail.gmail.com>
From:   Tim Murray <timmurray@google.com>
Date:   Tue, 22 Mar 2022 17:34:17 -0700
Message-ID: <CAEe=Sxmcn5+YUXBQhxDpzZVJu_T6S6+EURDqrP9uUS-PHGyuSg@mail.gmail.com>
Subject: Re: [GIT PULL] f2fs for 5.18
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Mar 22, 2022 at 10:50 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Even when people get the semantics and memory ordering right (which is
> not always the case, but at least the f2fs code uses real lock
> primitives - just oddly - and should thus be ok), it invariably tends
> to be a sign of something else being very wrong.
>
> And I can easily believe that in this case it's due to a rmsem issue
> that was already fixed long long ago as per Waiman.
>
> Can people please test with the actual modern rwsem code and with the
> odd reader-unfair locks disabled?

I did try the patch from Waiman (backported to a local Android device
running 5.10 without the unfair-rwsem patch) when we were first
discussing this, and as far as I could tell, his patch did not make a
difference for this problem. I think I can explain why it solves a
different problem, and it is related to how f2fs uses locking
primitives and worker threads. In this case, it's important to know
that f2fs's checkpoint thread coalesces checkpoints on behalf of all
userspace threads calling fsync(), userspace threads calling many f2fs
functions take the read lock on the rwsem, and the checkpoint thread
takes the write lock. The userspace threads can be any CFS priority
and may be throttled for various reasons (constrained cpuset or cpuctl
runtime limits).

Here's one example from a trace associated with a very slow app start
from a 5.10 device before the unfair-rwsem patch:

1. pid 6711, a random userspace thread, is running on a CPU at time 0ms.
2. After 2.6ms of running, pid 6711 enters state D, deschedules, and
is blocked in f2fs_new_inode according to sched_blocked_reason (a
tracepoint we added in the Android kernel that emits the function
where a thread is blocked in uninterruptible sleep).
3. The f2fs_checkpoint thread runs 5ms after pid 6711 deschedules.
f2fs_ckpt runs for 63us, makes pid 6711 runnable, and then deschedules
in state D blocked at rwsem_down_write_slowpath.
4. pid 6711 remains runnable for 341ms--it's a low priority thread in
a throttled process and the system is busy. Meanwhile, f2fs_ckpt
remains in D for 341ms.
5. pid 6711 finally runs and makes f2fs_ckpt runnable after 11us.

If the problem were related to optimistic spinning that would be
addressed by Waiman's patch, I'd expect to see pid 6711 running
concurrently with f2fs_ckpt. However, that's not what happens; there's
a 5ms gap in between pid 6711 blocking on the read lock and f2fs_ckpt
running. AFAICT, what's happening is that rwsem_down_read_slowpath
modifies sem->count to indicate that there's a pending reader while
f2fs_ckpt holds the write lock, and when f2fs_ckpt releases the write
lock, it wakes pending readers and hands the lock over to readers.
This means that any subsequent attempt to grab the write lock from
f2fs_ckpt will stall until the newly-awakened reader releases the read
lock, which depends on the readers' arbitrarily long scheduling
delays.

AFAICT, any solution for this problem that doesn't require an overhaul
of f2fs locking requires that the newly-awakened readers can't block
f2fs_ckpt until they are scheduled and grab the read lock. Either we
could do something trylock-related like this patch implemented, or we
could move f2fs to percpu_rwsem. However, moving to percpu_rwsem means
no optimistic spinning, which also seems bad given how short the
read-locked critical sections are. We have seen similar problems with
contention on the cgroup percpu_rwsem that spin-on-owner could have
alleviated, so I'm hesitant to get rid of optimistic spinning for f2fs
by switching to percpu_rwsem.

The most obvious objection to the patch is that f2fs_ckpt will still
stall if a reader deschedules while holding the lock. That is
absolutely true! However, in practice, we were hitting the worst case
every time because any attempt to grab the read lock while f2fs_ckpt
holds the write lock exposes f2fs_ckpt to arbitrary scheduling delay
from the reader. The reader-unfair rwsem patch prevents this problem.
We have evidence this is true in practice, too. I just ran a quick
comparison on 150 slow app start traces from our internal population
comparing kernels pre- and post-unfair-rwsem patch, and the percentage
of time the thread responsible for UI was stalled on f2fs locks went
from ~50% of all uninterruptible sleep time on that thread to less
than 5%.

I think this is a special case where fairness to readers is explicitly
harmful because any thread at any priority can block on the only
writer (f2fs_ckpt) but any low priority thread could be a reader
blocking the only writer. I don't know if it's worth explicit support
in rw_semaphore for this kind of use case, but I don't think an
existing rwsem patch addresses this issue because it is so unusual.
