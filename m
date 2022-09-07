Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0E85AFB46
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 06:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiIGE1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 00:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiIGE06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 00:26:58 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A307B85FBD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 21:26:57 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id s14so3715494plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 21:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date;
        bh=cXhJSf26Omj6YqBwlBrLWqb5IEe+4uyjC0Z2+GyF+JE=;
        b=LLqdZRNbbogTpY6xrQfnv26Iz09EGQs73f3oyKkfhUcxP5tVJ0Ns9FUvx0TZWQFPke
         SAXnlkgS+7VsfZQM1MLx5/8R0y9UCAHXz5u2xtnuIy3Cmdh6zPP5dPdix4VlcxRqxNFJ
         6ALpUIGnsQkMEdcSARHODdxEU9JfaEA9BUA8yPZ2JSqtXQc/8FuWPFOOunw12YeT2uoS
         IijwAmDtnkr8WIjb4Iok3HSMnrXdGZSReDMbGYj5DUaH/8z5MlQG0ANHuWXONxo9Z05e
         swHr+y1xnmjon2pe4b4E7ybFy15dyRcaAJZamXQE7LaHt+gUTLI77TqvRCP0obyeZ2GO
         KLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date;
        bh=cXhJSf26Omj6YqBwlBrLWqb5IEe+4uyjC0Z2+GyF+JE=;
        b=5ThGznxN0R5TN2f+MdCQCHEfKlAFX6yzB+oYN4UJkw3GQaOzab7G9I2zT1Hcm8g4TS
         14OX3co80gCrv6oNAMSLNfQAyP1eLfmp/IVfeMsgwtOEgSNKWefHbqiZIqsrL3JMo7xy
         q8sS16NY2e3lGq1W9DHmrDn1Y9nEB/r2QOuShqIOOpnsT9oyh1tJz7bgKc1VR9yXAGoM
         DLni4UMQI94KInHYIbLQPYU7yxF1NXxAtqbyQSEtfwKS7zpWY+WM0iMhcGFl1qZm6cLw
         TiJeATpq1QqzhmfLv2Qh3UfI0kDAb2kUdoI2qKffbyAogqseuzNfeOha1WNFIkfr4082
         Z9Gg==
X-Gm-Message-State: ACgBeo36zMyO9vUKIwaj2puG6JlKzC/TJXWV/qwIeIl7zFSmRTg0xBU5
        YE/mqdAQHdFPpSZ7NOJpwBBjG7dLi0U=
X-Google-Smtp-Source: AA6agR4q3Jmz0AxKC8O9M45aptmE9bGoIs1sVgJyRLxr/baXjm3Are+b1Kr9GjvhX22yAjUyfue3aA==
X-Received: by 2002:a17:902:e549:b0:174:d234:6116 with SMTP id n9-20020a170902e54900b00174d2346116mr1875013plf.131.1662524817156;
        Tue, 06 Sep 2022 21:26:57 -0700 (PDT)
Received: from localhost ([124.170.18.239])
        by smtp.gmail.com with ESMTPSA id a2-20020a17090a6d8200b001f5513f6fb9sm9922063pjk.14.2022.09.06.21.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 21:26:56 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 07 Sep 2022 14:26:52 +1000
Message-Id: <CMPVUZ3AI9Z5.3QHIUCJE5KOF@bobo>
Cc:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/book3s: Inline first level of
 update_mmu_cache()
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Michael Ellerman" <mpe@ellerman.id.au>
X-Mailer: aerc 0.11.0
References: <bea5ad0de7f83eff256116816d46c84fa0a444de.1662370698.git.christophe.leroy@csgroup.eu>
In-Reply-To: <bea5ad0de7f83eff256116816d46c84fa0a444de.1662370698.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Sep 5, 2022 at 7:38 PM AEST, Christophe Leroy wrote:
> update_mmu_cache() voids when hash page tables are not used.
> On PPC32 that means when MMU_FTR_HPTE_TABLE is not defined.
> On PPC64 that means when RADIX is enabled.
>
> Rename core part of update_mmu_cache() as __update_mmu_cache()
> and include the initial verification in an inlined caller.

Reivewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/book3s/pgtable.h | 15 ++++++++++-----
>  arch/powerpc/mm/book3s32/mmu.c            |  4 +---
>  arch/powerpc/mm/book3s64/hash_utils.c     |  5 +----
>  3 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/pgtable.h b/arch/powerpc/inc=
lude/asm/book3s/pgtable.h
> index e8269434ecbe..d18b748ea3ae 100644
> --- a/arch/powerpc/include/asm/book3s/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/pgtable.h
> @@ -25,7 +25,8 @@ extern pgprot_t phys_mem_access_prot(struct file *file,=
 unsigned long pfn,
>  				     unsigned long size, pgprot_t vma_prot);
>  #define __HAVE_PHYS_MEM_ACCESS_PROT
> =20
> -#if defined(CONFIG_PPC32) || defined(CONFIG_PPC_64S_HASH_MMU)
> +void __update_mmu_cache(struct vm_area_struct *vma, unsigned long addres=
s, pte_t *ptep);
> +
>  /*
>   * This gets called at the end of handling a page fault, when
>   * the kernel has put a new PTE into the page table for the process.
> @@ -35,10 +36,14 @@ extern pgprot_t phys_mem_access_prot(struct file *fil=
e, unsigned long pfn,
>   * corresponding HPTE into the hash table ahead of time, instead of
>   * waiting for the inevitable extra hash-table miss exception.
>   */
> -void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,=
 pte_t *ptep);
> -#else
> -static inline void update_mmu_cache(struct vm_area_struct *vma, unsigned=
 long address, pte_t *ptep) {}
> -#endif
> +static inline void update_mmu_cache(struct vm_area_struct *vma, unsigned=
 long address, pte_t *ptep)
> +{
> +	if (IS_ENABLED(CONFIG_PPC32) && !mmu_has_feature(MMU_FTR_HPTE_TABLE))
> +		return;
> +	if (radix_enabled())
> +		return;
> +	__update_mmu_cache(vma, address, ptep);
> +}
> =20
>  #endif /* __ASSEMBLY__ */
>  #endif
> diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mm=
u.c
> index a96b73006dfb..7053eb229b4f 100644
> --- a/arch/powerpc/mm/book3s32/mmu.c
> +++ b/arch/powerpc/mm/book3s32/mmu.c
> @@ -314,11 +314,9 @@ static void hash_preload(struct mm_struct *mm, unsig=
ned long ea)
>   *
>   * This must always be called with the pte lock held.
>   */
> -void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
> +void __update_mmu_cache(struct vm_area_struct *vma, unsigned long addres=
s,
>  		      pte_t *ptep)
>  {
> -	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE))
> -		return;
>  	/*
>  	 * We don't need to worry about _PAGE_PRESENT here because we are
>  	 * called with either mm->page_table_lock held or ptl lock held
> diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book=
3s64/hash_utils.c
> index 363a9447d63d..ced1107b1677 100644
> --- a/arch/powerpc/mm/book3s64/hash_utils.c
> +++ b/arch/powerpc/mm/book3s64/hash_utils.c
> @@ -1781,7 +1781,7 @@ static void hash_preload(struct mm_struct *mm, pte_=
t *ptep, unsigned long ea,
>   *
>   * This must always be called with the pte lock held.
>   */
> -void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
> +void __update_mmu_cache(struct vm_area_struct *vma, unsigned long addres=
s,
>  		      pte_t *ptep)
>  {
>  	/*
> @@ -1791,9 +1791,6 @@ void update_mmu_cache(struct vm_area_struct *vma, u=
nsigned long address,
>  	unsigned long trap;
>  	bool is_exec;
> =20
> -	if (radix_enabled())
> -		return;
> -
>  	/* We only want HPTEs for linux PTEs that have _PAGE_ACCESSED set */
>  	if (!pte_young(*ptep) || address >=3D TASK_SIZE)
>  		return;
> --=20
> 2.37.1

