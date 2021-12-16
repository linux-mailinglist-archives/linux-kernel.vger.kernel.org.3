Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E755D4767E9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhLPC0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 21:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhLPC0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 21:26:23 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FBAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 18:26:23 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id d10so60635754ybn.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 18:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tB3x6NAjs5//RJkL9LMXnECDkkVJovad/BmtOHFhMgE=;
        b=fPk6aeZcvhGgQMP5Y03xNjGjJYJABGhLOrJVnFi9+ZvcXhIcWKvVkEfKBl7jDpc6di
         ff+uoIGdSTKZLedzJTuoM4I7SC7XEuuRhEs93ePqu2pkv8+q4cT1Gb5bsI3++G+P0HNN
         LUD5Jp+hEu6t8yoMZjv0zAKmhbudXDM3QQnnFliEej81XBXHZThAXL482gvmbmHuQKQ0
         uhM0EUChCHju/cRcILqqDz0CHjvKxP2oPBn9AiIr2wf0gCdS4O6adX+dDtFiPoOw9J40
         CrkwSvaJeGbdRaj+PsOd2AtHzCGd+5Pngc9N3CzZ6vn8dLJ7kjHH/+1sOAI5VLEodzzr
         dzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tB3x6NAjs5//RJkL9LMXnECDkkVJovad/BmtOHFhMgE=;
        b=QfWFCuq3UiDSFvRhMY3pl7urPu2cEwuUgHAFWvtng+jDoITJR28iH5v/tLcjfk6LEr
         H2o5uEMiLdg2RAJI9praQmbLBATirZnc4N+XzYwL+fKKrCXoiUWETXZVkDRplB0w0URm
         4slxaPnt0FCfy7zGYZWex2LsN3rive3Y+Ol73n+9R0zHs9UusvkG3/AqCIzJtX2/hwGy
         L7lE9GI/6It2UaPXUq6E6MMLzI0fkdSHDQ2xrHuaoEssUKbLX5xZL7qVGqVTkTiswWI9
         dkqKOkc5wH5YvWaxvRN3tR4ZdO/UbpkyQ4F3/+zQDa9C2NctU+hJE6gStF1375JGFssy
         SPNw==
X-Gm-Message-State: AOAM531ZdY2Y4q+0IX8fa2kYFFMt6ZwSLoBfFK5zmS/bEsN0/KVBWQ2E
        9XYFvt1jmOPuKWQJCO9WqbdGsOspHqFtIoEfzaQSew==
X-Google-Smtp-Source: ABdhPJwxIGY4qVilnFG1zpsGyTqW5GuliNGeCUyhjN2AlwBqSAYaCnd/YG4ATFeHWCMVH3TuYpiGU0f+oiUNlNnoNpE=
X-Received: by 2002:a5b:c0b:: with SMTP id f11mr10660172ybq.488.1639621582596;
 Wed, 15 Dec 2021 18:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20211208212211.2860249-1-surenb@google.com> <YbHIaq9a0CtqRulE@dhcp22.suse.cz>
 <CAJuCfpHwNS8RFPF9nzaSB8Br8Jah5_dcnQeatRZp60vmX5n6Vg@mail.gmail.com>
 <YbIzOR13uPOI5EMB@dhcp22.suse.cz> <CAJuCfpHs_25TQ7pHDhPXghA46jmXa5N2OOeBByE-sn+dQ-aM2w@mail.gmail.com>
In-Reply-To: <CAJuCfpHs_25TQ7pHDhPXghA46jmXa5N2OOeBByE-sn+dQ-aM2w@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 15 Dec 2021 18:26:11 -0800
Message-ID: <CAJuCfpHZOojVXCDXPOA7kgrZqNWw_BzRmbKQXz3FOCHwa-LopQ@mail.gmail.com>
Subject: Re: [PATCH 4/3] mm: drop MMF_OOM_SKIP from exit_mmap
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 9:06 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Thu, Dec 9, 2021 at 8:47 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 09-12-21 08:24:04, Suren Baghdasaryan wrote:
> > > On Thu, Dec 9, 2021 at 1:12 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > Do we want this on top?
> > >
> > > As we discussed in this thread
> > > https://lore.kernel.org/all/YY4snVzZZZYhbigV@dhcp22.suse.cz,
> > > __oom_reap_task_mm in exit_mmap allows oom-reaper/process_mrelease to
> > > unmap pages in parallel with exit_mmap without blocking each other.
> > > Removal of __oom_reap_task_mm from exit_mmap prevents this parallelism
> > > and has a negative impact on performance. So the conclusion of that
> > > thread I thought was to keep that part. My understanding is that we
> > > also wanted to remove MMF_OOM_SKIP as a follow-up patch but
> > > __oom_reap_task_mm would stay.
> >
> > OK, then we were talking past each other, I am afraid. I really wanted
> > to get rid of this oom specific stuff from exit_mmap. It was there out
> > of necessity. With a proper locking we can finally get rid of the crud.
> > As I've said previously oom reaping has never been a hot path.
> >
> > If we really want to optimize this path then I would much rather see a
> > generic solution which would allow to move the write lock down after
> > unmap_vmas. That would require oom reaper to be able to handle mlocked
> > memory.
>
> Ok, let's work on that and when that's done we can get rid of the oom
> stuff in exit_mmap. I'll look into this over the weekend and will
> likely be back with questions.

As promised, I have a question:
Any particular reason why munlock_vma_pages_range clears VM_LOCKED
before unlocking pages and not after (see:
https://elixir.bootlin.com/linux/latest/source/mm/mlock.c#L424)? Seems
to me if VM_LOCKED was reset at the end (with proper ordering) then
__oom_reap_task_mm would correctly skip VM_LOCKED vmas.
https://lore.kernel.org/lkml/20180514064824.534798031@linuxfoundation.org/
has this explanation:

"Since munlock_vma_pages_range() depends on clearing VM_LOCKED from
vm_flags before actually doing the munlock to determine if any other
vmas are locking the same memory, the check for VM_LOCKED in the oom
reaper is racy."

but "to determine if any other vmas are locking the same memory"
explanation eludes me... Any insights?
Thanks,
Suren.

> Thanks!
>
> > --
> > Michal Hocko
> > SUSE Labs
