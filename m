Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E678476F5E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbhLPLAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbhLPLAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:00:15 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D77C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 03:00:15 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id m25so24964097qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 03:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KnBQJR/TMzh78I8yqUIjs7VdtqfCQRZRo/Chv253Z68=;
        b=GezK35ONVgcuhJJR9plrCRkI9pOw0Cz7eqzaOyGvWHp2KW/HeY8FI+58hNZJdGmiVi
         uzKqtD7F7sqrVEgZMi43OW6jV0Fj9RM+U+DKg9M5Peq0VTr4Z/X5SKfUgLOHOm8EW7MD
         3aFfiV+PrYPhedbM60AhoGMbEOTGcEInQBdFToAUkh4HTWe+i0Asn6HI7LZEzLxfZdLX
         k3+n2HGRq8+XcluqX9Zw1i3LIIVb/Z7N2CuybxnhpO4UkyHZAIki8aLBv9hiK5ny9wm0
         yOvL40sCuQRP4gPVu/QOgCMHIHx3SAB63AORfTMtqrbTVKGTJQcoGOKBUSgEojKM/nbc
         Qlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnBQJR/TMzh78I8yqUIjs7VdtqfCQRZRo/Chv253Z68=;
        b=6iSqZZ48XoG4nCedNE7g91L3FDC8VJtKYhSAdpDI9IJqRjZzDniF1pO856TLU5XFVV
         kTpVbXNIuaaxq4WH2qPe2nf8kn6Z80o03HyPPJYdgN+feP7lx3KD5WCaO33PZABg3UUH
         z5rbfmQFH5NGVVeN5Qrx0MkctjWz4A4OjDRCLD9LkZiyhooCNOFDsYV8Ks/YiSQIFvtS
         uRtV7XRKOvVaV6rTZZebu/bzuRp4PDL+0ENwEwFe1TMkA6PzuZKqweRUdPU+BQRRhGA3
         yPBn7vAqHuSTNsjlPtdeaFRZBlGDvnrqb/avZqHkbF6ko+mk4/5HaJbXtIiQvCbS0A2O
         VBHw==
X-Gm-Message-State: AOAM531ataHFYIVKko/3vk60KHkXgeDQP7wy2cu6jTSEtPCPXK6zFKM4
        R5Ylt4tfqmhEDhnKxqBJ39CeA6gcAVlOhkY9OmP25A==
X-Google-Smtp-Source: ABdhPJwfGfQGB0BT1ZzJnkSVVFHCTAY13k5P2iioommCl//Y954NEMtEyBrfWxsiHxd16//ozpaMeZDMNAqUuXtQyJU=
X-Received: by 2002:ac8:4e56:: with SMTP id e22mr16609220qtw.72.1639652414512;
 Thu, 16 Dec 2021 03:00:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638308023.git.andreyknvl@google.com> <984104c118a451fc4afa2eadb7206065f13b7af2.1638308023.git.andreyknvl@google.com>
 <CAG_fn=U71Yn-qCGMBR=_uOt0QCEu9skGzhgRBJjpkQCjZ=dKiA@mail.gmail.com> <CA+fCnZfto82vg3vGkZGNxJKOOqsOp_bpmHEd0Z350PfPJ7Y=1w@mail.gmail.com>
In-Reply-To: <CA+fCnZfto82vg3vGkZGNxJKOOqsOp_bpmHEd0Z350PfPJ7Y=1w@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Dec 2021 11:59:38 +0100
Message-ID: <CAG_fn=UHVhTSj9=eA8XikF2JhRM3WHitjedinek1wUayStP_pQ@mail.gmail.com>
Subject: Re: [PATCH 08/31] kasan, page_alloc: refactor init checks in post_alloc_hook
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 10:09 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Thu, Dec 2, 2021 at 5:14 PM Alexander Potapenko <glider@google.com> wrote:
> >
> > On Tue, Nov 30, 2021 at 10:41 PM <andrey.konovalov@linux.dev> wrote:
> > >
> > > From: Andrey Konovalov <andreyknvl@google.com>
> > >
> > > This patch separates code for zeroing memory from the code clearing tags
> > > in post_alloc_hook().
> > >
> > > This patch is not useful by itself but makes the simplifications in
> > > the following patches easier to follow.
> > >
> > > This patch does no functional changes.
> > >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > ---
> > >  mm/page_alloc.c | 18 ++++++++++--------
> > >  1 file changed, 10 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 2ada09a58e4b..0561cdafce36 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -2406,19 +2406,21 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
> > >                 kasan_alloc_pages(page, order, gfp_flags);
> > >         } else {
> > >                 bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags);
> > > +               bool init_tags = init && (gfp_flags & __GFP_ZEROTAGS);
> > >
> > >                 kasan_unpoison_pages(page, order, init);
> > >
> > > -               if (init) {
> > > -                       if (gfp_flags & __GFP_ZEROTAGS) {
> > > -                               int i;
> > > +               if (init_tags) {
> > > +                       int i;
> > >
> > > -                               for (i = 0; i < 1 << order; i++)
> > > -                                       tag_clear_highpage(page + i);
> > > -                       } else {
> > > -                               kernel_init_free_pages(page, 1 << order);
> > > -                       }
> > > +                       for (i = 0; i < 1 << order; i++)
> > > +                               tag_clear_highpage(page + i);
> > > +
> > > +                       init = false;
> >
> > I find this a bit twisted and prone to breakages.
> > Maybe just check for (init && !init_tags) below?
>
> I did it this way deliberately. Check out the code after all the changes:
>
> https://github.com/xairy/linux/blob/up-kasan-vmalloc-tags-v1/mm/page_alloc.c#L2447
>
> It's possible to remove resetting the init variable by expanding the
> if (init) check listing all conditions under which init is currently
> reset, but that would essentially be duplicating the checks. I think
> resetting init is more clear.
>
> Please let me know what you think.

Ah, I see, so there are more cases in which you set init = false.
Fine then.
