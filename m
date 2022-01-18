Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3DF4920CC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 09:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343799AbiARIBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 03:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244429AbiARIBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 03:01:04 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFD2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 00:01:03 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id q186so27282816oih.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 00:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Al3F+2ViLnm9/9qxjHoxeFPrd9kF19aHZnlQsAdIPRg=;
        b=FCysJPty2mrcMf6v3VRjTFbhweCJRR3WyXaxWMp3y2v3HgQYlh1B9roeLBgjjTLRrF
         q0EveM9wLKiqTMkN1DW5Bwx6oBRbVXaR3Yor5+pZHw/GeYeVfg7jaml0nA3ZTYTbDPf8
         /M5uRa5UkC50Ris5+mVE2ymR7zWkKQSwm1M6tEpnSjw+FA+oE8BdNjJc5IU+QJ45WFS1
         1eYPiEg8mweB/z9UP6dqcOFv/DMTLw15D/CbD2dDV5ue9EUg5bCwcw/h3jULi4lZQdms
         qsgFgsm0r2f8iqGy0dIX/Ep+vHUUwgup0pUjPtXrxHk/w8ZNsQE+Ez0HsgQDhj6KnjWf
         h9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Al3F+2ViLnm9/9qxjHoxeFPrd9kF19aHZnlQsAdIPRg=;
        b=aHN27QEB4+4UX3kMuAlRjzz7IkFeo7nPNJeaomv3xz85kZn5wsRO6+ZOhNGKXU5Z/Q
         eNoVYXXrqAnIYSc6vNKO0zti+Q+RGeAGyEurCQtL9doOg1zuVSpIw+sJGNEaTl1+GOem
         4xNtL4fIDrlDFOMqZV6FkENHVgs+j5yoTMwpwABJMP6gZWBaFvYBt7fXiWqt34MNAI/Q
         odq8krMMMQk7ddRY1jvFD4/0LPcqvuGZikF0g4jxnYABA1r7PY3lmLW+xpxWSoehAfZ3
         BzhMsL2TaBsHdfBRkbFzWXMuED5nTc09RKak4CK1LUTajza0FXq15WYTpLWKUkAiJ4SX
         Koiw==
X-Gm-Message-State: AOAM531XhHEa6YDTnIlz9PmpkV1zQ7tPYLuvGoh4pgRvuVsUJbefl9HA
        /IByxpEPmkZdDgug9F8MKWR1ycv/uPA3w+tF+qY=
X-Google-Smtp-Source: ABdhPJzvGwPY3OUJ5cr+YDP3ryIKCL5St1eOUXqyHiBMdGlYGVftPHZ71UYHtXtQprVP0IFc5O3S9yOgkr3fuXzNLkU=
X-Received: by 2002:aca:2802:: with SMTP id 2mr7601418oix.23.1642492863253;
 Tue, 18 Jan 2022 00:01:03 -0800 (PST)
MIME-Version: 1.0
References: <388098b2c03fbf0a732834fc01b2d875c335bc49.1642170196.git.lucien.xin@gmail.com>
 <YeO8pcs866Iu2iJX@ip-172-31-30-232.ap-northeast-1.compute.internal>
 <CADvbK_eY=3Gf79MkvK72Nh86ysN4eoFei0k1jg0frg22GgToGA@mail.gmail.com>
 <YeU4B46F+oFUBRLE@linutronix.de> <39a3470f-06ab-cf41-32e4-80edb249c7d3@suse.cz>
 <20220117131304.pdc3mfdowkzovw6q@localhost.localdomain>
In-Reply-To: <20220117131304.pdc3mfdowkzovw6q@localhost.localdomain>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Tue, 18 Jan 2022 16:00:51 +0800
Message-ID: <CADvbK_eKRNpE7PkdFLQgmfEme5LgEVDK7WakUc-Rj4XTRSpdiQ@mail.gmail.com>
Subject: Re: [PATCH] mm: slub: fix a deadlock warning in kmem_cache_destroy
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Antoine Tenart <atenart@kernel.org>,
        Clark Williams <williams@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 9:13 PM Juri Lelli <juri.lelli@redhat.com> wrote:
>
> Hi,
>
> On 17/01/22 13:40, Vlastimil Babka wrote:
> > +CC Clark
> >
> > On 1/17/22 10:33, Sebastian Andrzej Siewior wrote:
> > > On 2022-01-17 16:32:46 [+0800], Xin Long wrote:
> > >> another issue. From the code analysis, this issue does exist on the
> > >> upstream kernel, though I couldn't build an upstream RT kernel for the
> > >> testing.
> > >
> > > This should also reproduce in v5.16 since the commit in question is
> > > there.
> >
> > Yeah. I remember we had some issues with the commit during development, but
> > I'd hope those were resolved and the commit that's ultimately merged got the
> > fixes, see this subthread:
> >
> > https://lore.kernel.org/all/0b36128c-3e12-77df-85fe-a153a714569b@quicinc.com/
> >
> > >> > >         CPU0                        CPU1
> > >> > >         ----                        ----
> > >> > >   cpus_read_lock()
> > >> > >                                    kn->active++
> > >> > >                                    cpus_read_lock() [a]
> > >> > >   wait until kn->active == 0
> > >> > >
> > >> > > Although cpu_hotplug_lock is a RWSEM, [a] will not block in there. But as
> > >> > > lockdep annotations are added for cpu_hotplug_lock, a deadlock warning
> > >> > > would be detected:
> > >
> > > The cpu_hotplug_lock is a per-CPU RWSEM. The lock in [a] will block if
> > > there is a writer pending.
> > >
> > >> > >   ======================================================
> > >> > >   WARNING: possible circular locking dependency detected
> > >> > >   ------------------------------------------------------
> > >> > >   dmsetup/1832 is trying to acquire lock:
> > >> > >   ffff986f5a0f9f20 (kn->count#144){++++}-{0:0}, at: kernfs_remove+0x1d/0x30
> > >> > >
> > >> > >   but task is already holding lock:
> > >> > >   ffffffffa43817c0 (slab_mutex){+.+.}-{3:3}, at: kmem_cache_destroy+0x2a/0x120
> > >> > >
> > >
> > > I tried to create & destroy a cryptarget which creates/destroy a cache
> > > via bio_put_slab(). Either the callchain is different or something else
> > > is but I didn't see a lockdep warning.
> >
> > RHEL-8 kernel seems to be 4.18, unless RT uses a newer one. Could be some
> > silently relevant backport is missing? How about e.g. 59450bbc12be ("mm,
> > slab, slub: stop taking cpu hotplug lock") ?
>
> Hummm, looks like we have backported commit 59450bbc12be in RHEL-8.
>
> Xin Long, would you be able to check if you still see the lockdep splat
> with latest upstream RT?
>
> git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.16.y-rt
Hi, Juri,

Thanks for sharing the RT kernel repo.

I just tried with this kernel, and I couldn't reproduce it on my env.
But I don't see how the upstream RT kernel can avoid the call trace.

As this warning was triggered when the system was shutting down, it might
not be reproduced on it due to some timing change.

>
> Thanks!
> Juri
>
