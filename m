Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8E849366D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352557AbiASIiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbiASIiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:38:50 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2060C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:38:49 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id e81so3059446oia.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+HNSzwe2ZTaOtHiiQO8OytOOz442JrIOxdrAt7aFUU=;
        b=IEByE+CQ6rkZeRGMp+8fC4oRZ4PWmLOqOQOxIVEdAwR5YdNCu9EL5XNWjmMopmOzLL
         pKnP9DGMLENmdx2wCYu6s3TkKun8XKimWjYORLRxSTQmkLXNgIHOTUY0J0A5y24+11OO
         b21PpKZMW4V2fvuB0prSs9zDJvsiD4F/tT/5e42IKHwVIHcvKzIA5FwZI+rSCVWvdM3T
         DIATtslDWLJglvB9o4MZMD7KUsNE+8+NcutOTApLedIzJ8+9WZuCCblTQ7eijq35sDRQ
         cfe86Y9ozCaH9lS9Mn0YVg5wmb5u8Jng173Zlh2M0Fb7+I/H9Y0l8HN1DMrI07crGwaB
         P8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+HNSzwe2ZTaOtHiiQO8OytOOz442JrIOxdrAt7aFUU=;
        b=K6iyViU3FKrAUg5Z8FCQzvfVTGtUaZG/AWi0ypdx4DVMGchB7HmZpzsdiK0ChVN7pV
         noTXdyUy4Dd4gzBC1Iu649OrSCbcPfyYgJwIST+DMQrylJ8Ihk2tuLo6R4RlmLpJntff
         22GUuBCsnZ2Zr1p9paMEYe7PrPPvkjouB53vORJwUo00wDN3QxbjsZfSZvmGS4leYAAq
         G+lPnKCYmqm9lL41IaGNmNWQszMGzpe9gAf3UNWZSbSHFsrw04Wslmy755M8kOCgf2ez
         QM6BJcCEvD5zsRwVkQXu2Mj2Wqn69Jdk5MbWjSw+lGrUiF0KGDpNOssgyZBnUO/OlBvm
         guKg==
X-Gm-Message-State: AOAM533kqigEvR3qngciYaufjr1xoDMMY8xYX1NYG8317CYI3BUQrCtz
        vbAm/IByZ6IZsvXJd40VxbVGNn3oECYkTq0WeFkv6dOAU3s=
X-Google-Smtp-Source: ABdhPJygAzNUIEnYu5vx/R0jHToSuA+t9ebw7txi3MfmeQ48MQHurD5GRcSO63Xd2wYiHqMG8lV0bUjQtEzzfzMPUcI=
X-Received: by 2002:aca:2802:: with SMTP id 2mr1970691oix.23.1642581529167;
 Wed, 19 Jan 2022 00:38:49 -0800 (PST)
MIME-Version: 1.0
References: <388098b2c03fbf0a732834fc01b2d875c335bc49.1642170196.git.lucien.xin@gmail.com>
 <YeO8pcs866Iu2iJX@ip-172-31-30-232.ap-northeast-1.compute.internal>
 <CADvbK_eY=3Gf79MkvK72Nh86ysN4eoFei0k1jg0frg22GgToGA@mail.gmail.com>
 <YeU4B46F+oFUBRLE@linutronix.de> <39a3470f-06ab-cf41-32e4-80edb249c7d3@suse.cz>
 <20220117131304.pdc3mfdowkzovw6q@localhost.localdomain> <CADvbK_eKRNpE7PkdFLQgmfEme5LgEVDK7WakUc-Rj4XTRSpdiQ@mail.gmail.com>
 <f8fa28d4-bf89-39f7-92f9-4d7957e57c2c@suse.cz>
In-Reply-To: <f8fa28d4-bf89-39f7-92f9-4d7957e57c2c@suse.cz>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Wed, 19 Jan 2022 16:38:37 +0800
Message-ID: <CADvbK_e-ZcX1Y59dC5ms1gy6y=zbpGggrYyLapvsotnJNN815g@mail.gmail.com>
Subject: Re: [PATCH] mm: slub: fix a deadlock warning in kmem_cache_destroy
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
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

On Tue, Jan 18, 2022 at 7:07 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
>
> On 1/18/22 09:00, Xin Long wrote:
> > On Mon, Jan 17, 2022 at 9:13 PM Juri Lelli <juri.lelli@redhat.com> wrote:
> >> >
> >> > RHEL-8 kernel seems to be 4.18, unless RT uses a newer one. Could be some
> >> > silently relevant backport is missing? How about e.g. 59450bbc12be ("mm,
> >> > slab, slub: stop taking cpu hotplug lock") ?
> >>
> >> Hummm, looks like we have backported commit 59450bbc12be in RHEL-8.
> >>
> >> Xin Long, would you be able to check if you still see the lockdep splat
> >> with latest upstream RT?
> >>
> >> git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.16.y-rt
> > Hi, Juri,
> >
> > Thanks for sharing the RT kernel repo.
> >
> > I just tried with this kernel, and I couldn't reproduce it on my env.
> > But I don't see how the upstream RT kernel can avoid the call trace.
> >
> > As this warning was triggered when the system was shutting down, it might
> > not be reproduced on it due to some timing change.
>
> As it was caught by lockdep and not as a real deadlock, I think it should be
> indepenedent of a timing change. Lockdep will correlate potentially deadlock
> scenarios even if they don't really occur in the same time, AFAIK.
>
> But let's go back to:
>
> > Although cpu_hotplug_lock is a RWSEM, [a] will not block in there. But as
> > lockdep annotations are added for cpu_hotplug_lock, a deadlock warning
> > would be detected:
>
> Is it possible that upstream lockdep handles this RWSEM scenario properly
> and doesn't report it, but the RHEL kernel is missing some relevant lockdep fix?
That's a good point.

I actually think:
  cpus_read_lock()
  cpus_read_lock()
shouldn't be considered as a deadlock.

I will check the lockdep changes, and it may take some time.

Thanks.

>
> >>
> >> Thanks!
> >> Juri
> >>
>
