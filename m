Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1B1531254
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbiEWODm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbiEWOD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:03:29 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9F92FFD0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:03:28 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D85FF3F20A
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653314603;
        bh=aOj42UXk0Ccs38iFr56+sEgB8yBY01wKBE08wxks5M0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ItgSZuvr43XhlL7ZCB+buCWUpn+UiC7TUJPohsUU5I5Vdld2xUH4X6wXcSPUO3OG9
         bIT0PF2wYA6SiNjQSu6/Pyb/RWaHwDttD1wZDAYXoWoa4fKX4HVKryrXp3aZUcarV2
         REG8j6ECU2AsBILec5xz0eNhRFvDts9o5XDXdusY54h0On5MXMCgcHfJ/pc80BWLJF
         TAPDw3/x++4OTf9OKaeC6wABxdoXo051pM5icVvWpKTr3DOU0EfaJgmBw6icdVGsyb
         UyjQUniqDjnastmIX4eqKGn/1DZjLHmmdKBkqTitX2TKHcCg9yClZ27oyYhcydp7/o
         GAEKEH4snTipA==
Received: by mail-ej1-f71.google.com with SMTP id r13-20020a170906c28d00b006fec5bcd396so1314690ejz.22
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOj42UXk0Ccs38iFr56+sEgB8yBY01wKBE08wxks5M0=;
        b=kNvdn8z/JipOBrPCW5yn8ipJD6FoC7ds8YX40tAPN380r6GDSYkI1KgLUrX7p+jPYY
         JGTMFY3XrGKmjLKIgPzNINqPFukAn3iOH2m/1mAoOH2JTsfY7+FbGZJuT9wrjK62bXio
         xsKGVkgST5scOzCEbQmQ3y2L5oXPlA/bb9GwwElzbd+E1+Id2sjNs9yR0jy2roJ1/zb5
         8y4i++UdhGK8IINjeFOll6hZdNTpViNqzLjgc/pi3/RA9RuQTlUgJYJU4VnqNOXCQ6WX
         ahNCyl7kKHZy58RXxAUHsDtcSq3XrzMrDYnc4Bl+cv/7Y07Dc8oREg4OkzEgBp8P8Yp6
         eJVg==
X-Gm-Message-State: AOAM531Z9Tujf/nGT9HQ8EeFApTPa2X+Il0bUhifavZ96hXUCo7kLemP
        hb8/V1mt3gckw27PJzv9jmL0Fl28BveekWboYrG0HL6OxirEO51jgL1J856DO4/kQhr8CE97+T0
        Jg6gNsWM/JA+PvbmObLRAsOhStp33jFx2uAWxlsr9cLE2XCOsDZMZCmCf0A==
X-Received: by 2002:a17:907:1c92:b0:6fa:51d2:4005 with SMTP id nb18-20020a1709071c9200b006fa51d24005mr19963051ejc.307.1653314602937;
        Mon, 23 May 2022 07:03:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMUulBF+KUWazrL3APRAArBepILptP1NGvpb+ZHVwY9pwmFhOGMhnKWNYfpURzv+5M15VeBDVoqJWSq72IkZc=
X-Received: by 2002:a17:907:1c92:b0:6fa:51d2:4005 with SMTP id
 nb18-20020a1709071c9200b006fa51d24005mr19963013ejc.307.1653314602632; Mon, 23
 May 2022 07:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220511192921.2223629-1-heiko@sntech.de> <20220511192921.2223629-9-heiko@sntech.de>
In-Reply-To: <20220511192921.2223629-9-heiko@sntech.de>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Mon, 23 May 2022 16:03:10 +0200
Message-ID: <CA+zEjCuckDpweE9YEep26ZcX3xqh8QszXNq8BY-hPpQkQnRdjQ@mail.gmail.com>
Subject: Re: [PATCH 08/12] riscv: Fix accessing pfn bits in PTEs for non-32bit variants
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Wed, May 11, 2022 at 9:31 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> On rv32 the PFN part of PTEs is defined to use bits [xlen-1:10]
> while on rv64 it is defined to use bits [53:10], leaving [63:54]
> as reserved.
>
> With upcoming optional extensions like svpbmt these previously
> reserved bits will get used so simply right-shifting the PTE
> to get the PFN won't be enough.
>
> So introduce a _PAGE_PFN_MASK constant to mask the correct bits
> for both rv32 and rv64 before shifting.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
> ---
>  arch/riscv/include/asm/pgtable-32.h   |  8 ++++++++
>  arch/riscv/include/asm/pgtable-64.h   | 14 +++++++++++---
>  arch/riscv/include/asm/pgtable-bits.h |  6 ------
>  arch/riscv/include/asm/pgtable.h      |  8 +++++---
>  4 files changed, 24 insertions(+), 12 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
> index 5b2e79e5bfa5..e266a4fe7f43 100644
> --- a/arch/riscv/include/asm/pgtable-32.h
> +++ b/arch/riscv/include/asm/pgtable-32.h
> @@ -7,6 +7,7 @@
>  #define _ASM_RISCV_PGTABLE_32_H
>
>  #include <asm-generic/pgtable-nopmd.h>
> +#include <linux/bits.h>
>  #include <linux/const.h>
>
>  /* Size of region mapped by a page global directory */
> @@ -16,4 +17,11 @@
>
>  #define MAX_POSSIBLE_PHYSMEM_BITS 34
>
> +/*
> + * rv32 PTE format:
> + * | XLEN-1  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
> + *       PFN      reserved for SW   D   A   G   U   X   W   R   V
> + */
> +#define _PAGE_PFN_MASK  GENMASK(31, 10)
> +
>  #endif /* _ASM_RISCV_PGTABLE_32_H */
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index 7e246e9f8d70..15f3ad5aee4f 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -6,6 +6,7 @@
>  #ifndef _ASM_RISCV_PGTABLE_64_H
>  #define _ASM_RISCV_PGTABLE_64_H
>
> +#include <linux/bits.h>
>  #include <linux/const.h>
>
>  extern bool pgtable_l4_enabled;
> @@ -65,6 +66,13 @@ typedef struct {
>
>  #define PTRS_PER_PMD    (PAGE_SIZE / sizeof(pmd_t))
>
> +/*
> + * rv64 PTE format:
> + * | 63 | 62 61 | 60 54 | 53  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
> + *   N      MT     RSV    PFN      reserved for SW   D   A   G   U   X   W   R   V
> + */
> +#define _PAGE_PFN_MASK  GENMASK(53, 10)
> +
>  static inline int pud_present(pud_t pud)
>  {
>         return (pud_val(pud) & _PAGE_PRESENT);
> @@ -108,12 +116,12 @@ static inline unsigned long _pud_pfn(pud_t pud)
>
>  static inline pmd_t *pud_pgtable(pud_t pud)
>  {
> -       return (pmd_t *)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
> +       return (pmd_t *)pfn_to_virt(__page_val_to_pfn(pud_val(pud)));
>  }
>
>  static inline struct page *pud_page(pud_t pud)
>  {
> -       return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
> +       return pfn_to_page(__page_val_to_pfn(pud_val(pud)));
>  }
>
>  #define mm_p4d_folded  mm_p4d_folded
> @@ -143,7 +151,7 @@ static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
>
>  static inline unsigned long _pmd_pfn(pmd_t pmd)
>  {
> -       return pmd_val(pmd) >> _PAGE_PFN_SHIFT;
> +       return __page_val_to_pfn(pmd_val(pmd));
>  }
>
>  #define mk_pmd(page, prot)    pfn_pmd(page_to_pfn(page), prot)
> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
> index a6b0c89824c2..e571fa954afc 100644
> --- a/arch/riscv/include/asm/pgtable-bits.h
> +++ b/arch/riscv/include/asm/pgtable-bits.h
> @@ -6,12 +6,6 @@
>  #ifndef _ASM_RISCV_PGTABLE_BITS_H
>  #define _ASM_RISCV_PGTABLE_BITS_H
>
> -/*
> - * PTE format:
> - * | XLEN-1  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
> - *       PFN      reserved for SW   D   A   G   U   X   W   R   V
> - */
> -
>  #define _PAGE_ACCESSED_OFFSET 6
>
>  #define _PAGE_PRESENT   (1 << 0)
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 046b44225623..faba543e2b08 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -108,6 +108,8 @@
>  #include <asm/tlbflush.h>
>  #include <linux/mm_types.h>
>
> +#define __page_val_to_pfn(_val)  (((_val) & _PAGE_PFN_MASK) >> _PAGE_PFN_SHIFT)
> +
>  #ifdef CONFIG_64BIT
>  #include <asm/pgtable-64.h>
>  #else
> @@ -261,12 +263,12 @@ static inline unsigned long _pgd_pfn(pgd_t pgd)
>
>  static inline struct page *pmd_page(pmd_t pmd)
>  {
> -       return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
> +       return pfn_to_page(__page_val_to_pfn(pmd_val(pmd)));
>  }
>
>  static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>  {
> -       return (unsigned long)pfn_to_virt(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
> +       return (unsigned long)pfn_to_virt(__page_val_to_pfn(pmd_val(pmd)));
>  }
>
>  static inline pte_t pmd_pte(pmd_t pmd)
> @@ -282,7 +284,7 @@ static inline pte_t pud_pte(pud_t pud)
>  /* Yields the page frame number (PFN) of a page table entry */
>  static inline unsigned long pte_pfn(pte_t pte)
>  {
> -       return (pte_val(pte) >> _PAGE_PFN_SHIFT);
> +       return __page_val_to_pfn(pte_val(pte));
>  }
>
>  #define pte_page(x)     pfn_to_page(pte_pfn(x))
> --
> 2.35.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

I had this weird bug and it took some time to figure out that _pgd_pfn
is missing the "& _PAGE_PFN_MASK" here.

And then I grepped _PAGE_PFN_SHIFT and saw that _pud_pfn, p4d_pgtable,
__pmd_to_phys and stage2_pte_page_vaddr are also missing this mask. I
agree that we need something similar to your helper __page_val_to_pfn
(even if __page prefix is a bit weird to me) but I think we should go
further: forbid the use of _PAGE_PFN_SHIFT and contain this in a
single function that should be used to access the pfn minus the upper
bits, that would avoid future oversights.

I can come up with something if needs be, up to you!

Thanks,

Alex
