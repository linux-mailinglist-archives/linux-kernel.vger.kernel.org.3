Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA83508DD3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380809AbiDTQ6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380811AbiDTQ5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:57:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2EC3E5C4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:54:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i27so4759303ejd.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gfb0eyjgolqCkEqXLQdbBxhQjEK6tSD6hROI1ouv4Mo=;
        b=ed1XJUWXEKCWmhD+JR9f0O+9SweJMH0appcTJ14UiBN3RxWsSivFSQ5KGAEJ98Fi+N
         590F5tX5gBVe4QuMuax+YzgCe46XJvMNUmzp9K3TXiSeuhLe32FFfPBSwvpIDY6RYdx7
         8wikqUKk5L4OG2HOz6Gcu2FUq8oGqxnrGelMVn9IJW1ZY/upwlLSPioTSbpsffBzEwm9
         h7oJnIfun3x5iRxcufGQ5EZFnh4WeXQMzZ9RuVT+xyQELlmG/pZGYwmMkGzvs+qAz0Sv
         z7rJrkNxx/cXzTJRTAuQXrIQtJbMwzthYpGWuregJRWrgDBAUIexHK9LgfiROdBwG2+p
         Qsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gfb0eyjgolqCkEqXLQdbBxhQjEK6tSD6hROI1ouv4Mo=;
        b=lYR2H4zgc82NvZfHA+HxbMzytARCbNnKKqh/bpyJjfdDBPufT8escNDHCJn7MwMaD/
         ezkyXC+arqxwQDVWkUzdcRwh86dVqshDgt6ksquPEg4RmlOEeOesKuXoX+CKyWQgpZQd
         eaDwsya6rGNj5FzixYpXLzNcuDAr46UXzQf4GXZHVHox6hHoYw7FD4xIcMqStju+asJG
         N7XWKyp3ldm5kH8nsZ2cLX1Av0JqLteZlVP3xs4qQGlLQS/jgoD+TdaZm1PAXgmj/M4y
         pSJExNhKJqYVQ/5mEYir1C+I3VDcmvkSXlFythOuNF0jhuniqFijO/tkbwijEWYTd2e8
         LUKQ==
X-Gm-Message-State: AOAM533YD7VisYR2W1hn3xtjx/f+yaDhafZjY3PRi7w5z0iJTtp9Crjg
        LTGfQg1ReL5hQPbasAZrMKiZgdjn86KzPfCcyB6ne5MBoqOZAQ==
X-Google-Smtp-Source: ABdhPJx0Ve/WR/hieYcsMF1iBeBubzUupE0rJDQPdKddB2ET3tedAmCKBRlepVLhSDPltABkTqw0QgHvvAD3Y0wW/ZI=
X-Received: by 2002:a17:906:1841:b0:6e8:872d:8999 with SMTP id
 w1-20020a170906184100b006e8872d8999mr19046949eje.492.1650473684276; Wed, 20
 Apr 2022 09:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220420060221.1107736-1-anshuman.khandual@arm.com>
In-Reply-To: <20220420060221.1107736-1-anshuman.khandual@arm.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 20 Apr 2022 12:54:08 -0400
Message-ID: <CA+CK2bARgsgBAgawfAD8-xzDN6+_sg4zrPQnoTFy4b=ZMx_u1g@mail.gmail.com>
Subject: Re: [PATCH] mm/page_table_check: Drop all redundant EXPORT_SYMBOL()
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 2:01 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> Function definitions need not be exported via EXPORT_SYMBOL() mechanism. In
> this case these functions just get called only inside their wrappers. Even
> __page_table_check_zero() gets called without such an export. Just drop all
> these redundant EXPORT_SYMBOL().
>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v5.18-rc3
>
>  mm/page_table_check.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index 2458281bff89..5c2a96159832 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -167,7 +167,6 @@ void __page_table_check_pte_clear(struct mm_struct *mm, unsigned long addr,
>                                        PAGE_SIZE >> PAGE_SHIFT);
>         }
>  }
> -EXPORT_SYMBOL(__page_table_check_pte_clear);
>
>  void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
>                                   pmd_t pmd)
> @@ -180,7 +179,6 @@ void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
>                                        PMD_PAGE_SIZE >> PAGE_SHIFT);
>         }
>  }
> -EXPORT_SYMBOL(__page_table_check_pmd_clear);
>
>  void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
>                                   pud_t pud)
> @@ -193,7 +191,6 @@ void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
>                                        PUD_PAGE_SIZE >> PAGE_SHIFT);
>         }
>  }
> -EXPORT_SYMBOL(__page_table_check_pud_clear);
>
>  void __page_table_check_pte_set(struct mm_struct *mm, unsigned long addr,
>                                 pte_t *ptep, pte_t pte)
> @@ -208,7 +205,6 @@ void __page_table_check_pte_set(struct mm_struct *mm, unsigned long addr,
>                                      pte_write(pte));
>         }
>  }
> -EXPORT_SYMBOL(__page_table_check_pte_set);

Hi Anshuman,

See this:
https://lore.kernel.org/all/20211124234754.l5co34dUK%25akpm@linux-foundation.org/

The rest of EXPORTs were added to be symmetric, and allow other
drivers to use set_*p**()/clear_p** calls.

Pasha
