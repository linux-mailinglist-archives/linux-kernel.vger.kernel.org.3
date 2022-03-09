Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379234D3A77
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbiCITgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237228AbiCITgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:36:36 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26A72C4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 11:35:36 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KDMqW0FPmz9sSh;
        Wed,  9 Mar 2022 20:35:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o6gIBJ2CcNqp; Wed,  9 Mar 2022 20:35:34 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KDMqV5xT4z9sSd;
        Wed,  9 Mar 2022 20:35:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A8F638B780;
        Wed,  9 Mar 2022 20:35:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id SxGIuyvOycF8; Wed,  9 Mar 2022 20:35:34 +0100 (CET)
Received: from [192.168.202.27] (unknown [192.168.202.27])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BF4118B763;
        Wed,  9 Mar 2022 20:35:33 +0100 (CET)
Message-ID: <d83ff309-faf4-499c-7e97-4b3258ed5723@csgroup.eu>
Date:   Wed, 9 Mar 2022 20:35:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] powerpc/32: Stop printing the virtual memory layout
Content-Language: fr-FR
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, "Tobin C . Harding" <me@tobin.cc>
References: <202003021038.8F0369D907@keescook>
 <20200305150837.835083-1-nivedita@alum.mit.edu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20200305150837.835083-1-nivedita@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 05/03/2020 à 16:08, Arvind Sankar a écrit :
> For security, don't display the kernel's virtual memory layout.
> 
> Kees Cook points out:
> "These have been entirely removed on other architectures, so let's
> just do the same for ia32 and remove it unconditionally."
> 
> 071929dbdd86 ("arm64: Stop printing the virtual memory layout")
> 1c31d4e96b8c ("ARM: 8820/1: mm: Stop printing the virtual memory layout")
> 31833332f798 ("m68k/mm: Stop printing the virtual memory layout")
> fd8d0ca25631 ("parisc: Hide virtual kernel memory layout")
> adb1fe9ae2ee ("mm/page_alloc: Remove kernel address exposure in free_reserved_area()")
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

This patch doesn't apply anymore.

This patch is referenced in https://github.com/linuxppc/issues/issues/390

> ---
>   arch/powerpc/mm/mem.c | 17 -----------------
>   1 file changed, 17 deletions(-)
> 
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index ef7b1119b2e2..df2c143b6bf7 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -331,23 +331,6 @@ void __init mem_init(void)
>   #endif
>   
>   	mem_init_print_info(NULL);
> -#ifdef CONFIG_PPC32
> -	pr_info("Kernel virtual memory layout:\n");
> -#ifdef CONFIG_KASAN
> -	pr_info("  * 0x%08lx..0x%08lx  : kasan shadow mem\n",
> -		KASAN_SHADOW_START, KASAN_SHADOW_END);
> -#endif
> -	pr_info("  * 0x%08lx..0x%08lx  : fixmap\n", FIXADDR_START, FIXADDR_TOP);
> -#ifdef CONFIG_HIGHMEM
> -	pr_info("  * 0x%08lx..0x%08lx  : highmem PTEs\n",
> -		PKMAP_BASE, PKMAP_ADDR(LAST_PKMAP));
> -#endif /* CONFIG_HIGHMEM */
> -	if (ioremap_bot != IOREMAP_TOP)
> -		pr_info("  * 0x%08lx..0x%08lx  : early ioremap\n",
> -			ioremap_bot, IOREMAP_TOP);
> -	pr_info("  * 0x%08lx..0x%08lx  : vmalloc & ioremap\n",
> -		VMALLOC_START, VMALLOC_END);
> -#endif /* CONFIG_PPC32 */
>   }
>   
>   void free_initmem(void)
