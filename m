Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3226E5AF5A6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiIFUR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiIFURF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:17:05 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9252CA2ABC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:13:48 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id g1so4149220iob.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=tSQJvyoK1ZBBJye0Ax7+7hUQkw5NfAovX9JEyzVfbrE=;
        b=BmZuTIGnTuwT2wOwFsmjKhoZzaUFY/ddFJi0v6nI+NCEtSh3JbL6TsjdLoBPUeAtKg
         1MvcyJ8WujKBbwZGcxe/IJUn7hFOYwBXglI/jSx+BE9y2MQSZIf+sESRvZGqAL+AASYr
         vsmfzWal4g+eoM94S4TN6iDKwnTqwc4QmMuXLTy6e559r8dokJQy/1ReoK34RxQ0pkpQ
         MWjMVxwJ7mCLVK7Rji7q5k3uuWLUWKAKqpyI0F+ZvpDfLSqrHuZHLP2xUZu//VIT6Uyn
         vUhdzVJZita1oG83TuSr2lAj5hWe8HGCigKJZ2MznfuN/kCox1LHXWWIhcgeOQZWlNzX
         Cx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tSQJvyoK1ZBBJye0Ax7+7hUQkw5NfAovX9JEyzVfbrE=;
        b=RBESLq4Nc2spqt83VjdEnCoH++aISGpvMzF4fSA/qzi1sObBebrBwP0O8q7kq43LNG
         y/FZK/zl5HOqc4da3DKhPP4prFPEdie3TZksTnRbWGqTprQF7Sh51Imtg0135bxesULU
         UwF4sYyWoUQlMqjq5D+8DscfCvYJ0MWQf3n9mh5XnSz2XbvhiKhtyXtOWXYMkOeTukvb
         TlNILLnqckL5J67NdbYNNjb1jX+NHZSYfj5wlIHXuywgqLxf3pP/iX3GznlWeto/axJx
         9Z2jsd3IgJS9S6Swq++U62DnN/4/k1I/l+LvKnFTvK6msNd6bHNhm9qBROp5ex/KgVnH
         4oNA==
X-Gm-Message-State: ACgBeo0Al/20Jfskp2J6qJp5TwO9JGGYYKoqtmtJkzlDDYbJoYIJNv4D
        TLRIqJl/k1dLBwAkgag1Zz93qHiSibzYpHow2JqKTA==
X-Google-Smtp-Source: AA6agR5JRgfVPp6sXbXbtq7o0GKDtk0mN/iM21q3LuG4EnVUPgR3bkNWsuRmfTsnX33iHmNB1k4OktAWx5hvLaAIG6g=
X-Received: by 2002:a6b:2a88:0:b0:68a:e898:2822 with SMTP id
 q130-20020a6b2a88000000b0068ae8982822mr74435ioq.75.1662495196659; Tue, 06 Sep
 2022 13:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <20220901173516.702122-7-surenb@google.com>
 <1624be86-4c17-46e5-fafc-eb8afb7b9b4a@linux.ibm.com> <CAJuCfpFi07ZpAuSLwADGO0mfu2Hon9jWb0hsCytorchQ=cgK3Q@mail.gmail.com>
 <20220906195949.7nln7y6urs6rfyyd@revolver>
In-Reply-To: <20220906195949.7nln7y6urs6rfyyd@revolver>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 6 Sep 2022 13:13:05 -0700
Message-ID: <CAJuCfpH5kR2BxEq_bzkAPHwW5dvzTxikCKDD75YK+JaMaHqaJQ@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 06/28] mm: mark VMA as locked whenever
 vma->vm_flags are modified
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <michel@lespinasse.org>,
        Jerome Glisse <jglisse@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Song Liu <songliubraving@fb.com>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Minchan Kim <minchan@google.com>,
        kernel-team <kernel-team@android.com>,
        linux-mm <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Sep 6, 2022 at 1:00 PM Liam Howlett <liam.howlett@oracle.com> wrote=
:
>
> * Suren Baghdasaryan <surenb@google.com> [220906 15:01]:
> > On Tue, Sep 6, 2022 at 7:27 AM Laurent Dufour <ldufour@linux.ibm.com> w=
rote:
> > >
> > > Le 01/09/2022 =C3=A0 19:34, Suren Baghdasaryan a =C3=A9crit :
> > > > VMA flag modifications should be done under VMA lock to prevent con=
current
> > > > page fault handling in that area.
> > > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > ---
> > > >  fs/proc/task_mmu.c | 1 +
> > > >  fs/userfaultfd.c   | 6 ++++++
> > > >  mm/madvise.c       | 1 +
> > > >  mm/mlock.c         | 2 ++
> > > >  mm/mmap.c          | 1 +
> > > >  mm/mprotect.c      | 1 +
> > > >  6 files changed, 12 insertions(+)
> > >
> > > There are few changes also done in the driver's space, for instance:
> > >
> > > *** arch/x86/kernel/cpu/sgx/driver.c:
> > > sgx_mmap[98]                   vma->vm_flags |=3D VM_PFNMAP | VM_DONT=
EXPAND |
> > > VM_DONTDUMP | VM_IO;
> > > *** arch/x86/kernel/cpu/sgx/virt.c:
> > > sgx_vepc_mmap[108]             vma->vm_flags |=3D VM_PFNMAP | VM_IO |
> > > VM_DONTDUMP | VM_DONTCOPY;
> > > *** drivers/dax/device.c:
> > > dax_mmap[311]                  vma->vm_flags |=3D VM_HUGEPAGE;
> > >
> > > I guess these changes to vm_flags should be protected as well, or to =
be
> > > checked one by one.
> >
> > Thanks for noting these! I'll add necessary locking here and will look
> > for other places I might have missed.
>
> Would an inline set/clear bit function be worth while for vm_flags?  If
> it is then a name change to vm_flags may get the compiler to catch any
> missed cases.  There doesn't seem to be many cases (12 inserts) so maybe
> not.

That would probably simplify the maintenance for flags in the future
and we can add vma_mark_locked directly in the set/clear functions.

>
> >
> > >
> > > >
> > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > index 4e0023643f8b..ceffa5c2c650 100644
> > > > --- a/fs/proc/task_mmu.c
> > > > +++ b/fs/proc/task_mmu.c
> > > > @@ -1285,6 +1285,7 @@ static ssize_t clear_refs_write(struct file *=
file, const char __user *buf,
> > > >                       for (vma =3D mm->mmap; vma; vma =3D vma->vm_n=
ext) {
> > > >                               if (!(vma->vm_flags & VM_SOFTDIRTY))
> > > >                                       continue;
> > > > +                             vma_mark_locked(vma);
> > > >                               vma->vm_flags &=3D ~VM_SOFTDIRTY;
> > > >                               vma_set_page_prot(vma);
> > > >                       }
> > > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > > index 175de70e3adf..fe557b3d1c07 100644
> > > > --- a/fs/userfaultfd.c
> > > > +++ b/fs/userfaultfd.c
> > > > @@ -620,6 +620,7 @@ static void userfaultfd_event_wait_completion(s=
truct userfaultfd_ctx *ctx,
> > > >               mmap_write_lock(mm);
> > > >               for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
> > > >                       if (vma->vm_userfaultfd_ctx.ctx =3D=3D releas=
e_new_ctx) {
> > > > +                             vma_mark_locked(vma);
> > > >                               vma->vm_userfaultfd_ctx =3D NULL_VM_U=
FFD_CTX;
> > > >                               vma->vm_flags &=3D ~__VM_UFFD_FLAGS;
> > > >                       }
> > > > @@ -653,6 +654,7 @@ int dup_userfaultfd(struct vm_area_struct *vma,=
 struct list_head *fcs)
> > > >
> > > >       octx =3D vma->vm_userfaultfd_ctx.ctx;
> > > >       if (!octx || !(octx->features & UFFD_FEATURE_EVENT_FORK)) {
> > > > +             vma_mark_locked(vma);
> > > >               vma->vm_userfaultfd_ctx =3D NULL_VM_UFFD_CTX;
> > > >               vma->vm_flags &=3D ~__VM_UFFD_FLAGS;
> > > >               return 0;
> > > > @@ -734,6 +736,7 @@ void mremap_userfaultfd_prep(struct vm_area_str=
uct *vma,
> > > >               atomic_inc(&ctx->mmap_changing);
> > > >       } else {
> > > >               /* Drop uffd context if remap feature not enabled */
> > > > +             vma_mark_locked(vma);
> > > >               vma->vm_userfaultfd_ctx =3D NULL_VM_UFFD_CTX;
> > > >               vma->vm_flags &=3D ~__VM_UFFD_FLAGS;
> > > >       }
> > > > @@ -891,6 +894,7 @@ static int userfaultfd_release(struct inode *in=
ode, struct file *file)
> > > >                       vma =3D prev;
> > > >               else
> > > >                       prev =3D vma;
> > > > +             vma_mark_locked(vma);
> > > >               vma->vm_flags =3D new_flags;
> > > >               vma->vm_userfaultfd_ctx =3D NULL_VM_UFFD_CTX;
> > > >       }
> > > > @@ -1449,6 +1453,7 @@ static int userfaultfd_register(struct userfa=
ultfd_ctx *ctx,
> > > >                * the next vma was merged into the current one and
> > > >                * the current one has not been updated yet.
> > > >                */
> > > > +             vma_mark_locked(vma);
> > > >               vma->vm_flags =3D new_flags;
> > > >               vma->vm_userfaultfd_ctx.ctx =3D ctx;
> > > >
> > > > @@ -1630,6 +1635,7 @@ static int userfaultfd_unregister(struct user=
faultfd_ctx *ctx,
> > > >                * the next vma was merged into the current one and
> > > >                * the current one has not been updated yet.
> > > >                */
> > > > +             vma_mark_locked(vma);
> > > >               vma->vm_flags =3D new_flags;
> > > >               vma->vm_userfaultfd_ctx =3D NULL_VM_UFFD_CTX;
> > > >
> > > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > > index 5f0f0948a50e..a173f0025abd 100644
> > > > --- a/mm/madvise.c
> > > > +++ b/mm/madvise.c
> > > > @@ -181,6 +181,7 @@ static int madvise_update_vma(struct vm_area_st=
ruct *vma,
> > > >       /*
> > > >        * vm_flags is protected by the mmap_lock held in write mode.
> > > >        */
> > > > +     vma_mark_locked(vma);
> > > >       vma->vm_flags =3D new_flags;
> > > >       if (!vma->vm_file) {
> > > >               error =3D replace_anon_vma_name(vma, anon_name);
> > > > diff --git a/mm/mlock.c b/mm/mlock.c
> > > > index b14e929084cc..f62e1a4d05f2 100644
> > > > --- a/mm/mlock.c
> > > > +++ b/mm/mlock.c
> > > > @@ -380,6 +380,7 @@ static void mlock_vma_pages_range(struct vm_are=
a_struct *vma,
> > > >        */
> > > >       if (newflags & VM_LOCKED)
> > > >               newflags |=3D VM_IO;
> > > > +     vma_mark_locked(vma);
> > > >       WRITE_ONCE(vma->vm_flags, newflags);
> > > >
> > > >       lru_add_drain();
> > > > @@ -456,6 +457,7 @@ static int mlock_fixup(struct vm_area_struct *v=
ma, struct vm_area_struct **prev,
> > > >
> > > >       if ((newflags & VM_LOCKED) && (oldflags & VM_LOCKED)) {
> > > >               /* No work to do, and mlocking twice would be wrong *=
/
> > > > +             vma_mark_locked(vma);
> > > >               vma->vm_flags =3D newflags;
> > > >       } else {
> > > >               mlock_vma_pages_range(vma, start, end, newflags);
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index 693e6776be39..f89c9b058105 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -1818,6 +1818,7 @@ unsigned long mmap_region(struct file *file, =
unsigned long addr,
> > > >  out:
> > > >       perf_event_mmap(vma);
> > > >
> > > > +     vma_mark_locked(vma);
> > > >       vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
> > > >       if (vm_flags & VM_LOCKED) {
> > > >               if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
> > >
> > > I guess, this doesn't really impact, but the call to vma_mark_locked(=
vma)
> > > may be done only in the case the vm_flags field is touched.
> > > Something like this:
> > >
> > >         vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
> > >         if (vm_flags & VM_LOCKED) {
> > >                 if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
> > >                                         is_vm_hugetlb_page(vma) ||
> > > -                                       vma =3D=3D get_gate_vma(curre=
nt->mm))
> > > +                                       vma =3D=3D get_gate_vma(curre=
nt->mm)) {
> > > +                       vma_mark_locked(vma);
> > >                         vma->vm_flags &=3D VM_LOCKED_CLEAR_MASK;
> > > -               else
> > > +               } else
> > >                         mm->locked_vm +=3D (len >> PAGE_SHIFT);
> > >         }
> > >
> > >
> > > > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > > > index bc6bddd156ca..df47fc21b0e4 100644
> > > > --- a/mm/mprotect.c
> > > > +++ b/mm/mprotect.c
> > > > @@ -621,6 +621,7 @@ mprotect_fixup(struct mmu_gather *tlb, struct v=
m_area_struct *vma,
> > > >        * vm_flags and vm_page_prot are protected by the mmap_lock
> > > >        * held in write mode.
> > > >        */
> > > > +     vma_mark_locked(vma);
> > > >       vma->vm_flags =3D newflags;
> > > >       /*
> > > >        * We want to check manually if we can change individual PTEs=
 writable
> > >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
