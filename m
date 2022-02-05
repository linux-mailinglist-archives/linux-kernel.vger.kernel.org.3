Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DD64AA736
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 07:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379531AbiBEG6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 01:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiBEG6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 01:58:23 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF9EC061346
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 22:58:17 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id z14-20020a17090ab10e00b001b6175d4040so15176068pjq.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 22:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QqxTnbslfQMYPFUCFBn9bFHBdZqy5C92C2JjoA9HPoc=;
        b=lHyDhB7Xwf21LIhM+qKLRm5DZT5pLF+Ws83gOj9TkI4zQLX3mdkwBqY3OxiOUB3ukk
         hwmrqbjfY/A/oTaMxk8XcCPRQ8XIcTqLUoyxHaZCfOlJ9C6b/yX2B/bgoHPSK1QdtcHY
         +qbrALV5pdXBrEn/FOzbX8fkJGzIDmFCQCFU9a3ILYgYxiT+Kofn6D0LoUlQ6Sa4S2PQ
         PqIuOlgS6Y/eFv8W5RSFe4a6NNb0SjRuD4FA27D/2a3YIkABY+z4MxLJBJJLn6sp2gqr
         /geiJV+SwV0I3rhICTatIrEnkNQgm0BLJAdJb9mARqAqh7pn5hDSnpqZS1nByC1meYky
         odvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QqxTnbslfQMYPFUCFBn9bFHBdZqy5C92C2JjoA9HPoc=;
        b=pHBl6/2T34Vo6piemC3C8griHR1ZnAkevhsitpMTFeWDUqfzcInMFLTA//kaJI/xOl
         4hsRuLCI1oY0WFTyYHJPWxyVYJE+0vXlijAydw6Vm9bW2EdlOQ+2kkEaLq4y3SNG2h2G
         4I3uaT/GJEKam95nqVrsFsBMDtuUD13FMFczvlMGH8JseEIgQeuCQEiT8eCs8U0vUS09
         TGEeDjNR+KU82Xhpd1xAb+SSupt+zhANIMiQtrnCHEfDesnYByyhheZVOPsYyorQAyn0
         FV2jE6k5M3DELQ55msdBksnAIbdetuK+Vyxp3p4bpX7TIfmAhe4aBw1Le0vuoU05eIcu
         Ihgg==
X-Gm-Message-State: AOAM530HYUglC6MHA/Nnu2wcfN1ifpTP8JyrsuaF9qPz2Pp/999PuBux
        YU5+usXzj4owNLq8xgYwDCoVIEDHthEezg==
X-Google-Smtp-Source: ABdhPJwhES99P6msXC4Xhk72/tmpEaCcjze1Q2/hfSAAd4cPyy78/YGJWKTHiQcjKQpObaXA+roINw==
X-Received: by 2002:a17:90b:4a4c:: with SMTP id lb12mr2882058pjb.211.1644044296311;
        Fri, 04 Feb 2022 22:58:16 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id j185sm4444007pfd.85.2022.02.04.22.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 22:58:15 -0800 (PST)
Date:   Sat, 5 Feb 2022 15:58:13 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Jonas Bonn <jonas@southpole.se>,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        openrisc@lists.librecores.org, akpm@linux-foundation.org
Subject: Re: [OpenRISC] [RFC V1 22/31] openrisc/mm: Enable
 ARCH_HAS_VM_GET_PAGE_PROT
Message-ID: <Yf4gBd1nJNeQYSJr@antec>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
 <1643029028-12710-23-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643029028-12710-23-git-send-email-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 06:26:59PM +0530, Anshuman Khandual wrote:
> This defines and exports a platform specific custom vm_get_page_prot() via
> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
> macros can be dropped which are no longer needed.
> 
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: openrisc@lists.librecores.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

For one thing this is easier to read than the __P000 codes.

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/openrisc/Kconfig               |  1 +
>  arch/openrisc/include/asm/pgtable.h | 18 -------------
>  arch/openrisc/mm/init.c             | 41 +++++++++++++++++++++++++++++
>  3 files changed, 42 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index f724b3f1aeed..842a61426816 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -10,6 +10,7 @@ config OPENRISC
>  	select ARCH_HAS_DMA_SET_UNCACHED
>  	select ARCH_HAS_DMA_CLEAR_UNCACHED
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> +	select ARCH_HAS_VM_GET_PAGE_PROT
>  	select COMMON_CLK
>  	select OF
>  	select OF_EARLY_FLATTREE
> diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
> index cdd657f80bfa..fe686c4b7065 100644
> --- a/arch/openrisc/include/asm/pgtable.h
> +++ b/arch/openrisc/include/asm/pgtable.h
> @@ -176,24 +176,6 @@ extern void paging_init(void);
>  	__pgprot(_PAGE_ALL | _PAGE_SRE | _PAGE_SWE \
>  		 | _PAGE_SHARED | _PAGE_DIRTY | _PAGE_EXEC | _PAGE_CI)
>  
> -#define __P000	PAGE_NONE
> -#define __P001	PAGE_READONLY_X
> -#define __P010	PAGE_COPY
> -#define __P011	PAGE_COPY_X
> -#define __P100	PAGE_READONLY
> -#define __P101	PAGE_READONLY_X
> -#define __P110	PAGE_COPY
> -#define __P111	PAGE_COPY_X
> -
> -#define __S000	PAGE_NONE
> -#define __S001	PAGE_READONLY_X
> -#define __S010	PAGE_SHARED
> -#define __S011	PAGE_SHARED_X
> -#define __S100	PAGE_READONLY
> -#define __S101	PAGE_READONLY_X
> -#define __S110	PAGE_SHARED
> -#define __S111	PAGE_SHARED_X
> -
>  /* zero page used for uninitialized stuff */
>  extern unsigned long empty_zero_page[2048];
>  #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
> diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
> index 97305bde1b16..c9f5e7d6bb59 100644
> --- a/arch/openrisc/mm/init.c
> +++ b/arch/openrisc/mm/init.c
> @@ -210,3 +210,44 @@ void __init mem_init(void)
>  	mem_init_done = 1;
>  	return;
>  }
> +
> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
> +{
> +	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
> +	case VM_NONE:
> +		return PAGE_NONE;
> +	case VM_READ:
> +		return PAGE_READONLY_X;
> +	case VM_WRITE:
> +		return PAGE_COPY;
> +	case VM_READ | VM_WRITE:
> +		return PAGE_COPY_X;
> +	case VM_EXEC:
> +		return PAGE_READONLY;
> +	case VM_EXEC | VM_READ:
> +		return PAGE_READONLY_X;
> +	case VM_EXEC | VM_WRITE:
> +		return PAGE_COPY;
> +	case VM_EXEC | VM_READ | VM_WRITE:
> +		return PAGE_COPY_X;
> +	case VM_SHARED:
> +		return PAGE_NONE;
> +	case VM_SHARED | VM_READ:
> +		return PAGE_READONLY_X;
> +	case VM_SHARED | VM_WRITE:
> +		return PAGE_SHARED;
> +	case VM_SHARED | VM_READ | VM_WRITE:
> +		return PAGE_SHARED_X;
> +	case VM_SHARED | VM_EXEC:
> +		return PAGE_READONLY;
> +	case VM_SHARED | VM_EXEC | VM_READ:
> +		return PAGE_READONLY_X;
> +	case VM_SHARED | VM_EXEC | VM_WRITE:
> +		return PAGE_SHARED;
> +	case VM_SHARED | VM_EXEC | VM_READ | VM_WRITE:
> +		return PAGE_SHARED_X;
> +	default:
> +		BUILD_BUG();
> +	}
> +}
> +EXPORT_SYMBOL(vm_get_page_prot);
> -- 
> 2.25.1
> 
> _______________________________________________
> OpenRISC mailing list
> OpenRISC@lists.librecores.org
> https://lists.librecores.org/listinfo/openrisc
