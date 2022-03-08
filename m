Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1D44D0D26
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 01:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344163AbiCHBAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiCHBAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:00:34 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3899E23A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 16:59:39 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id e2so15597955pls.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 16:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xtN9yLTb/VZCQMriln/ieL7U3maXDlCZhw7+/x2Xd10=;
        b=kWJbaJfnC0JDoYimBwsSOto5UcIg5mJnsY6qxfTPBsNjiH2w1G5NxXKodifNnqltja
         sxBnvWB4V4FAWJXxEgFeFhsutPb5156Mq1zlkWBTsBsj/AS2Cu256gmqEEDshX5+KtV6
         +8v5eJ5I3LL8/4rg81rOfunj/sx0fFyqzgOu580RV+GtYWcPGR+H4PSBlXTtsFDt3E57
         SQ3Ga8/3YTi/ufb/1eITkEjw3P1ZWo5dmfG/olKbkS/KFwvKZ96oGcE6rRE0hx2DuKtm
         0lT2pJuTLwNMJM1eM6+JZNadOOfE91LS/favvKQLY3snFxvJV7hgFdTCZcEcSNvwZaRt
         i3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xtN9yLTb/VZCQMriln/ieL7U3maXDlCZhw7+/x2Xd10=;
        b=FSdYafeD3aCjz5jHTrwvpV3RUR1sUE+DV21WC4v3fX/lhMUZIpEZ38YBjRV7SQ0UfS
         sgWoWfoqyDkjk0do6XelHz7ATLcpdfvT17SnYhCWsScz6x7N3RqUV4znnCgQM3dXJQuH
         6uwlWtQuWmVhacZjqjH2O/og8cXTsdIlTXm41xPLkv979n0cPlBnF7aPZKaqowTqWfoy
         xuwba6QvSb3I2xZxgp/FZsqZGvQDU9mgGHbEPTTixks9OxTxbJLyENKxZbklXF1tIPFQ
         lY6YW4N1NRqgNjdQCIIVqL9QtKJAI3xoJ8AgZ52ak8zrDE4jf5ZcM32eQ4kp7JZhMyXA
         EDvg==
X-Gm-Message-State: AOAM531SB5MXof1+5bXOM1r6wqVsGPPTd2jNtek9utlgvDd81MkQiMv8
        4X4jWcQduJU3vxEyl06OIM9/1flYMtpikVlFh7IxkKV+
X-Google-Smtp-Source: ABdhPJy3/4uzjpeSlfbyOXX5UtMgEdRa+7VpX8bfuIbEafQh+pPDwE6yq08SMaeOqwsaSJBeRZvA43BPFw2ucMqqJvA=
X-Received: by 2002:a17:90b:1b0e:b0:1bf:1c4f:2bc4 with SMTP id
 nu14-20020a17090b1b0e00b001bf1c4f2bc4mr1846234pjb.200.1646701178737; Mon, 07
 Mar 2022 16:59:38 -0800 (PST)
MIME-Version: 1.0
References: <20220303222014.517033-1-shy828301@gmail.com> <CADFyXm6W9CVkO4XPYep-tHg55c8m8NES783kcVYrdjSMbzYoDA@mail.gmail.com>
 <CAHbLzkriyBy2HqjssurLSnhoyuUzpJRZjMPNx34MTgxeO0dddg@mail.gmail.com>
 <13ad4ba1-2a88-9459-3995-70af36aba33e@redhat.com> <20220306180718.6d4e6233130b94fdad98df88@linux-foundation.org>
 <84a6c9c1-d18f-6955-2666-0a2d7bce6094@redhat.com> <20220307154326.6494f7fca7def491a23e5df1@linux-foundation.org>
 <CAHbLzkqY69nFniK+ckQaeu117Q+OqZ2hvFEdVbZaW2C_zAzDbg@mail.gmail.com> <20220307165015.77fbcbe9e1fa2fe15f3eb239@linux-foundation.org>
In-Reply-To: <20220307165015.77fbcbe9e1fa2fe15f3eb239@linux-foundation.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 7 Mar 2022 16:59:27 -0800
Message-ID: <CAHbLzkrHWjDk5PHJPep=KVHmHtktJana9FtAWZoT196Rg9utJA@mail.gmail.com>
Subject: Re: [PATCH] mm: thp: don't have to lock page anymore when splitting PMD
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 4:50 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 7 Mar 2022 16:03:12 -0800 Yang Shi <shy828301@gmail.com> wrote:
>
> > On Mon, Mar 7, 2022 at 3:43 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > @@ -2133,8 +2133,6 @@ void __split_huge_pmd(struct vm_area_str
> > >  {
> > >         spinlock_t *ptl;
> > >         struct mmu_notifier_range range;
> > > -       bool do_unlock_folio = false;
> > > -       pmd_t _pmd;
> > >
> > >         mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
> > >                                 address & HPAGE_PMD_MASK,
> > > @@ -2153,42 +2151,14 @@ void __split_huge_pmd(struct vm_area_str
> > >                         goto out;
> > >         }
> > >
> > > -repeat:
> > >         if (pmd_trans_huge(*pmd)) {
> > > -               if (!folio) {
> > > +               if (!folio)
> > >                         folio = page_folio(pmd_page(*pmd));
> >
> > We could remove the "if (pmd_trans_huge(*pmd))" section since folio is
> > actually not used afterward at all.
>
> >
> > ...
> >
> >
> > With the above if removed, this could be changed to:
> >
> > if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
> >             is_pmd_migration_entry(*pmd))
> >                 __split_huge_pmd_locked(vma, pmd, range.start, freeze);
> >
>
> OK, looks sane.  Can someone please test all this?

Build test? I had the exact same change in my tree, it worked for me.


>
> --- a/mm/huge_memory.c~mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd-fix
> +++ a/mm/huge_memory.c
> @@ -2151,12 +2151,10 @@ void __split_huge_pmd(struct vm_area_str
>                         goto out;
>         }
>
> -       if (pmd_trans_huge(*pmd)) {
> -               if (!folio)
> -                       folio = page_folio(pmd_page(*pmd));
> -       } else if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
> -               goto out;
> -       __split_huge_pmd_locked(vma, pmd, range.start, freeze);
> +       if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
> +           is_pmd_migration_entry(*pmd)))
> +               __split_huge_pmd_locked(vma, pmd, range.start, freeze);
> +
>  out:
>         spin_unlock(ptl);
>         /*
> _
>
