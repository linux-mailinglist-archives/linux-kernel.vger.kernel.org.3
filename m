Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13BA4AA7C9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 10:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbiBEJK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 04:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiBEJK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 04:10:57 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2EAC061346
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 01:10:57 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id l13so7153397plg.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 01:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uDUysG+hrYM9KEdA8gvKMMwTu6YruBml8uJ+UsxA+zc=;
        b=b2crhZl2KlqLlWKJ/ehdP5SK91QlaCvp+zeRyxjvOH2UToDMghwpnHhzR214f8tvfs
         EgmYEXVT6C54fDNFY+MNjQDcCjpZ2uFxDnW34y0uzMxYIfYYy8hQvAvfElzOCGXGaBkz
         AUVTeFTKOvuSf7CkrZ+Myxl1zwUHZKty8dChW5iT7eCUoV3LpTCn1OefNe7MhrDfZAaB
         DXjHi2zOzpkTjAyN3aNGleI7IeQx9At0HZ6BgRTd7zoc0AYCXIbabe2LjCphy3Zc73a2
         PZWVr8Fq4H0PqR8LlfZpHnlxF8PsqMqC8DulHrJK/JJEZSEfLmWU124neU2JC/1aYCP0
         8xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uDUysG+hrYM9KEdA8gvKMMwTu6YruBml8uJ+UsxA+zc=;
        b=yyFcMKS0tpkGoMot28luUDVnrhhwEzBD06/z0Zog2ZKWqj3U/xJyLIqBrw1jxNsZHa
         CVTOdlC1K/HwLc4SymfzX6+MmlvgUHvqSJeFy0HA3SXPV9jOatmTR9Y+jCl4dPzi45aB
         GKDxfit7uOMlZ6Ursr9UburhOSITMSw4NxXsLDQr30Guz97p7estH0AzmB7iFRp6LU+j
         wkX8iZZlatMdBNkWE/SYbwP9BipAEz5RaVVhuudWI/S7uJX6pWFpgFAJQvE9ta85JxCC
         2YcY1djxPmHwD3cEslBEnHEW/aySta2lOw1EG/ryNaw2Utb07LUxuAX/T+Ir+QYHEXrs
         U6Gg==
X-Gm-Message-State: AOAM533eDC63OpA0CynSExq11vQn4doxJ7wciYGZQeHjDkAEezUAwbyF
        LFVowf9OF74dCb/oniAfqjs=
X-Google-Smtp-Source: ABdhPJwaWzaISdXIkYONHKGKmScaahVawpZj9MLgjQrf0o3R2gE+w8HZqsRFP/E2yqWGkGQ9u1PV8g==
X-Received: by 2002:a17:90a:de01:: with SMTP id m1mr7654234pjv.215.1644052256815;
        Sat, 05 Feb 2022 01:10:56 -0800 (PST)
Received: from gmail.com ([103.121.208.52])
        by smtp.gmail.com with ESMTPSA id x12sm3349069pgp.25.2022.02.05.01.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 01:10:56 -0800 (PST)
Date:   Sat, 5 Feb 2022 17:10:48 +0800
From:   Firo Yang <firogm@gmail.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, akpm@linux-foundation.org
Subject: Re: [RFC V1 02/31] mm/mmap: Clarify protection_map[] indices
Message-ID: <20220205091048.g3fk4eaw7p7itgil@gmail.com>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
 <1643029028-12710-3-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1643029028-12710-3-git-send-email-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 01/24/2022 18:26, Anshuman Khandual wrote:
> protection_map[] maps vm_flags access combinations into page protection
> value as defined by the platform via __PXXX and __SXXX macros. The array
> indices in protection_map[], represents vm_flags access combinations but
> it's not very intuitive to derive. This makes it clear and explicit.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  mm/mmap.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 1e8fdb0b51ed..254d716220df 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -102,8 +102,22 @@ static void unmap_region(struct mm_struct *mm,
>   *								x: (yes) yes
>   */
>  pgprot_t protection_map[16] __ro_after_init = {
> -	__P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
> -	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
> +	[VM_NONE]				= __P000,
> +	[VM_READ]				= __P001,
> +	[VM_WRITE]				= __P010,
> +	[VM_READ|VM_WRITE]			= __P011,
> +	[VM_EXEC]				= __P100,
> +	[VM_EXEC|VM_READ]			= __P101,
> +	[VM_EXEC|VM_WRITE]			= __P110,
> +	[VM_EXEC|VM_READ|VM_WRITE]		= __P111,
> +	[VM_SHARED]				= __S000,
> +	[VM_SHARED|VM_READ]			= __S001,
> +	[VM_SHARED|VM_WRITE]			= __S010,
> +	[VM_SHARED|VM_READ|VM_WRITE]		= __S011,
> +	[VM_SHARED|VM_EXEC]			= __S100,
> +	[VM_SHARED|VM_READ|VM_EXEC]		= __S101,
> +	[VM_SHARED|VM_WRITE|VM_EXEC]		= __S110,
> +	[VM_SHARED|VM_READ|VM_WRITE|VM_EXEC]	= __S111

Just a little bit picky:)
Would you mind rearranging vm_flags access commbination in the order as
the access bits appear in __SXXX or __PXXX? For example, change the following:

	[VM_SHARED|VM_READ|VM_WRITE|VM_EXEC]    = __S111
to
	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= __S111

I think it's would be more clear for looking.

Best,
// Firo
