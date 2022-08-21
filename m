Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEA459B209
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 07:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiHUFPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 01:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiHUFPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 01:15:43 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8523B24BE5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 22:15:42 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-335624d1e26so215993927b3.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 22:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=LdNSrA/UwC8d9WVId873VHJD2GFt5pC4YthPYYq3GQo=;
        b=Caw8jriSOv6uuTtk7ioMJRlJdgEW+ZwBGSfpVWzzOSqtibBWVdG6Bf0ZafOqu1wQ9k
         wrdSWiZIaJPMLncvg5cff3DIzauItIaQ1kYbWRdGe+bvJegk7QH4OSMnUEyFV9gICDQ3
         yPILvj8ygPMnYDOxzcf/IJ1JakstsBsIm/2aEOCcLsfMsGDfYZU1VLY7Fbz8grIkbWaU
         3q+Hk3eTKej0yDTnMniMp2+i+C+Sd2dB6yYkosNCXzmgXaS398DgY+LnJDlZUASFdlcK
         esnw+5kK9pb8TFX4nJbwTqXFimEZFcai2iKZM6EwjU1XY0KrPfDaLWU5YYt8bHwJ7SJc
         9fPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=LdNSrA/UwC8d9WVId873VHJD2GFt5pC4YthPYYq3GQo=;
        b=xBnF+NVxLPiKdyB9JFxsClF4/B7jLGcwrLLlq95IP2ouuWrU3p0L1leGqIJnvTZViL
         awg7pYRp3XSc1tlGRVW4/gAcRH5B6eQIrIWA5Gsprhgj9l55GOSTB8lI95t9BkD6H3WC
         2zd+CNpfyKPajZyrJnVvtPh7m3v2yEFlGyyweqK8G3ru1vF1cIYGAo+7N24T4CdpsD3J
         rWNNKCkLISTgI6SO7Eh3Z66RI30+2SrN9lt6BRnZP0jrEWaL/iqfx0ypxVcbTdP3yrTy
         W6mC8szPCCgTAAreTxnzl5GyUxxRfNyL2JaukbyPiKBI3l9fRLVY4THlMTkh3fbAHPjW
         lDkQ==
X-Gm-Message-State: ACgBeo3Jaj/7AoLXJPGfut/pbJne2cGmd9bCr6IIHmyatgmwPizEk44P
        7yk8nS5CcaTxpqLb5dIYfHrhVo0kR7YN0pNV7+04QQ==
X-Google-Smtp-Source: AA6agR6JTk+rrrarN9oWlddYU//XLxmZdRA1AcOQG5vqKSMYEdCQYX4aivygkyln9plJJeXamStDdjzEnr8JDiE5LuE=
X-Received: by 2002:a0d:d496:0:b0:335:4877:7dc5 with SMTP id
 w144-20020a0dd496000000b0033548777dc5mr14393770ywd.405.1661058941587; Sat, 20
 Aug 2022 22:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220821013926.8968-1-tjytimi@163.com> <CAAhSdy1Qxwn=Eax6ECEkdRe=mQeL+J0TPCpOc1LMbN1y8-p4UQ@mail.gmail.com>
In-Reply-To: <CAAhSdy1Qxwn=Eax6ECEkdRe=mQeL+J0TPCpOc1LMbN1y8-p4UQ@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 21 Aug 2022 10:45:30 +0530
Message-ID: <CAAhSdy0idoR87xnTG-F84xwMTTri+pLgrL_dTvqnsQDmkZXPmA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] riscv: make update_mmu_cache to support asid
To:     Jinyu Tang <tjytimi@163.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alexandre.ghiti@canonical.com,
        guoren@kernel.org, akpm@linux-foundation.org, heiko@sntech.de,
        panqinglin2020@iscas.ac.cn, unnanyong@huawei.com,
        tongtiangen@huawei.com, anshuman.khandual@arm.com,
        atishp@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, falcon@tinylab.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2022 at 10:35 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Sun, Aug 21, 2022 at 7:09 AM Jinyu Tang <tjytimi@163.com> wrote:
> >
> > The `update_mmu_cache` function in riscv flush tlb cache without asid
> > information now, which will flush tlbs in other tasks' address space
> > even if processor support asid. So add a new function
> > `flush_tlb_local_one_page` to flush local one page whether processor
> > supports asid or not. If asid is supported, this function will use it.
> >
> > Signed-off-by: Jinyu Tang <tjytimi@163.com>
>
> This is already covered by PATCH6 of the IPI improvement series.
> https://www.spinics.net/lists/kernel/msg4481428.html

My bad. This patch does not overlap with PATCH6 of the
IPI improvement series but does conflict with that series.

Maybe you can rebase this patch upon the IPI improvement
series ?

Regards,
Anup

>
> Regards,
> Anup
>
> > ---
> >  arch/riscv/include/asm/pgtable.h  |  2 +-
> >  arch/riscv/include/asm/tlbflush.h |  2 ++
> >  arch/riscv/mm/tlbflush.c          | 11 +++++++++++
> >  3 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index 7ec936910a96..09ccefa6b6c7 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -415,7 +415,7 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
> >          * Relying on flush_tlb_fix_spurious_fault would suffice, but
> >          * the extra traps reduce performance.  So, eagerly SFENCE.VMA.
> >          */
> > -       local_flush_tlb_page(address);
> > +       flush_tlb_local_one_page(vma, address);
> >  }
> >
> >  static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
> > diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> > index 801019381dea..120aeb1c6ecf 100644
> > --- a/arch/riscv/include/asm/tlbflush.h
> > +++ b/arch/riscv/include/asm/tlbflush.h
> > @@ -30,6 +30,7 @@ static inline void local_flush_tlb_page(unsigned long addr)
> >  #if defined(CONFIG_SMP) && defined(CONFIG_MMU)
> >  void flush_tlb_all(void);
> >  void flush_tlb_mm(struct mm_struct *mm);
> > +void flush_tlb_local_one_page(struct vm_area_struct *vma, unsigned long addr);
> >  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
> >  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
> >                      unsigned long end);
> > @@ -42,6 +43,7 @@ void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
> >
> >  #define flush_tlb_all() local_flush_tlb_all()
> >  #define flush_tlb_page(vma, addr) local_flush_tlb_page(addr)
> > +#define flush_tlb_local_one_page(vma, addr) local_flush_tlb_page(addr)
> >
> >  static inline void flush_tlb_range(struct vm_area_struct *vma,
> >                 unsigned long start, unsigned long end)
> > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > index 37ed760d007c..a2634ce55626 100644
> > --- a/arch/riscv/mm/tlbflush.c
> > +++ b/arch/riscv/mm/tlbflush.c
> > @@ -64,6 +64,17 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
> >         put_cpu();
> >  }
> >
> > +void flush_tlb_local_one_page(struct vm_area_struct *vma, unsigned long addr)
> > +{
> > +       if (static_branch_unlikely(&use_asid_allocator)) {
> > +               unsigned long asid = atomic_long_read(&vma->vm_mm->context.id);
> > +
> > +               local_flush_tlb_page_asid(addr, asid);
> > +       } else {
> > +               local_flush_tlb_page(addr);
> > +       }
> > +}
> > +
> >  void flush_tlb_mm(struct mm_struct *mm)
> >  {
> >         __sbi_tlb_flush_range(mm, 0, -1, PAGE_SIZE);
> > --
> > 2.30.2
> >
