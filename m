Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7369B4E5D18
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 03:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348275AbiCXCOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 22:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348211AbiCXCOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 22:14:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7052F91372
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:12:44 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r22so6355164ejs.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BCOovJyPh0b4zYvl+nTG0Ejb+isbohuepHr7Xg5SeZ8=;
        b=aqT0DmxhPMdzHQ6ds1qvDm0Gqk/I2X8ppXoBJCVmqFF7EOyhFa8PFPf7PnmiiZl85G
         bJmb0HIn27+yvh7bbJJJ5m2qrODaPlNDCdEZZMHkevjqNOvrYDCvPYK2vQ5lgoIu2BRv
         7w5sy6kQG5FQm0AnuSecon0cZcbw9iz3HZisUfPKhux/Ks5SG8pJY+kyFM0rbMp18EJw
         oFYgTvLim1rFKqLN5nA6585PcRceunwoXs5Yr7ALwFOp5R8fCo8qm2oQjI07xKruS/vb
         DUgzpNAI6sEacBHrhiemU5rWKI4pPNRB/Wv2bB13IOkB20UplQrsrEPgrOZU/cmOoXXm
         0W2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BCOovJyPh0b4zYvl+nTG0Ejb+isbohuepHr7Xg5SeZ8=;
        b=VBPeUxta8weE8aOBnHUMxCHtkDj3cee4l0sM1Z2oKtwCQTJA8gELGLftI8BjRgLv5j
         gD+2ylqKNPWUQ4Xi/xcs6omL+vGnA4/zKC0cqccWu5pIMd1o2FoOb4Abfo8mMRXkSLlc
         z71Bv7Osw/4rAK1Q720Z6Ibaco1/6e3VWzN7Nxinm2siDqItwuP6d1wMxkIhBbnM5cHm
         oNUY7YIYgQnQLBowv8E5uzZQSoWAcVFsBqVITUSAmPfSs/jDF19f1gTFJldjbHzyZCvE
         Z6Imq708hpgHzz3q/0o0ScxnQMK/E6ZRny/Q+2vqDF8VqGpqud5rKzf3PizR2PtQ7a+P
         TrXg==
X-Gm-Message-State: AOAM533Lh54fF6vKORuQcIa7R8gFrXTuccU3dqZq8yEkPX5DD76fj4yz
        Uuge/exHDBBwGGhRJyf5ZIXNBc4FiVt+Uh2eP1ZQhQ==
X-Google-Smtp-Source: ABdhPJzpZ1gIybuFI4pn4eTHzXP1tUx/TNO22fj/wIoPss7PW3L5NtzpTcrmPLJdonNgbkRnQvB642mK2quWLD0+UCk=
X-Received: by 2002:a17:907:9602:b0:6df:e82c:f84 with SMTP id
 gb2-20020a170907960200b006dfe82c0f84mr3302273ejc.590.1648087962953; Wed, 23
 Mar 2022 19:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220322144447.3563146-1-tongtiangen@huawei.com>
 <20220322144447.3563146-3-tongtiangen@huawei.com> <CA+CK2bAa96oE0FbtJUjAJ=vpuzQsW3R60K9SUhca6mZ3BL1f8w@mail.gmail.com>
 <0c95c24d-b980-a8b3-9c68-e10d16e05e10@huawei.com>
In-Reply-To: <0c95c24d-b980-a8b3-9c68-e10d16e05e10@huawei.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 23 Mar 2022 22:12:02 -0400
Message-ID: <CA+CK2bAhxZEyirFHjwEB6aRDqH8ZzbJu_NELaT+vBAuDtDh9PQ@mail.gmail.com>
Subject: Re: [PATCH -next v2 2/4] mm: page_table_check: add hooks to public helpers
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 10:07 PM Tong Tiangen <tongtiangen@huawei.com> wrot=
e:
>
>
>
> =E5=9C=A8 2022/3/24 1:42, Pasha Tatashin =E5=86=99=E9=81=93:
> > On Tue, Mar 22, 2022 at 10:25 AM Tong Tiangen <tongtiangen@huawei.com> =
wrote:
> >>
> >> Move ptep_clear() to the include/linux/pgtable.h and add page table ch=
eck
> >> relate hooks to some helpers, it's prepare for support page table chec=
k
> >> feature on new architecture.
> >>
> >> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> >> ---
> >>   arch/x86/include/asm/pgtable.h | 10 ----------
> >>   include/linux/pgtable.h        | 27 +++++++++++++++++++--------
> >>   2 files changed, 19 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgt=
able.h
> >> index 8cd6514e3052..8c85f2eabbaa 100644
> >> --- a/arch/x86/include/asm/pgtable.h
> >> +++ b/arch/x86/include/asm/pgtable.h
> >> @@ -1077,16 +1077,6 @@ static inline pte_t ptep_get_and_clear_full(str=
uct mm_struct *mm,
> >>          return pte;
> >>   }
> >>
> >> -#define __HAVE_ARCH_PTEP_CLEAR
> >> -static inline void ptep_clear(struct mm_struct *mm, unsigned long add=
r,
> >> -                             pte_t *ptep)
> >> -{
> >> -       if (IS_ENABLED(CONFIG_PAGE_TABLE_CHECK))
> >> -               ptep_get_and_clear(mm, addr, ptep);
> >> -       else
> >> -               pte_clear(mm, addr, ptep);
> >> -}
> >> -
> >>   #define __HAVE_ARCH_PTEP_SET_WRPROTECT
> >>   static inline void ptep_set_wrprotect(struct mm_struct *mm,
> >>                                        unsigned long addr, pte_t *ptep=
)
> >> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >> index f4f4077b97aa..d27fd0ed84a9 100644
> >> --- a/include/linux/pgtable.h
> >> +++ b/include/linux/pgtable.h
> >> @@ -12,6 +12,7 @@
> >>   #include <linux/bug.h>
> >>   #include <linux/errno.h>
> >>   #include <asm-generic/pgtable_uffd.h>
> >> +#include <linux/page_table_check.h>
> >>
> >>   #if 5 - defined(__PAGETABLE_P4D_FOLDED) - defined(__PAGETABLE_PUD_FO=
LDED) - \
> >>          defined(__PAGETABLE_PMD_FOLDED) !=3D CONFIG_PGTABLE_LEVELS
> >> @@ -259,14 +260,6 @@ static inline int pmdp_clear_flush_young(struct v=
m_area_struct *vma,
> >>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >>   #endif
> >>
> >> -#ifndef __HAVE_ARCH_PTEP_CLEAR
> >> -static inline void ptep_clear(struct mm_struct *mm, unsigned long add=
r,
> >> -                             pte_t *ptep)
> >> -{
> >> -       pte_clear(mm, addr, ptep);
> >> -}
> >> -#endif
> >> -
> >>   #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
> >>   static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> >>                                         unsigned long address,
> >> @@ -274,10 +267,23 @@ static inline pte_t ptep_get_and_clear(struct mm=
_struct *mm,
> >>   {
> >>          pte_t pte =3D *ptep;
> >>          pte_clear(mm, address, ptep);
> >> +       page_table_check_pte_clear(mm, address, pte);
> >>          return pte;
> >>   }
> >>   #endif
> >>
> >> +#ifndef __HAVE_ARCH_PTEP_CLEAR
> >> +static inline void ptep_clear(struct mm_struct *mm, unsigned long add=
r,
> >> +                             pte_t *ptep)
> >> +{
> >> +#ifdef CONFIG_PAGE_TABLE_CHECK
> >> +       ptep_get_and_clear(mm, addr, ptep);
> >> +#else
> >> +       pte_clear(mm, addr, ptep);
> >> +#endif
> >
> > I have a preference to use if (IS_ENABLED(CONFIG_PAGE_TABLE_CHECK))
> > instead of #ifdef. The end result is the same. Otherwise it looks
> > good.
> >
> > Thanks,
> > Pasha
> > .
>
> I have a little hesitation when making this change , in theory, add if
> here may affect the performance a little in some scenarios. However, the
> impact on the whole call path should be small.

I do not think so, the compiler should optimize out IS_ENABLED() when
not enabled, no?

>
> I will send v3 using if (IS_ENABLED(CONFIG_PAGE_TABLE_CHECK)).
>
> Thanks.
> Tong
> .
