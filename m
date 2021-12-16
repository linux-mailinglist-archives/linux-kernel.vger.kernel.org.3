Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A4C476CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhLPJA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhLPJA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:00:26 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96CDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 01:00:25 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id f9so62802556ybq.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 01:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WiAKB8+SjEHwCrofH7QRr3IXwaMMb0ZhTdJq3Ay5yG0=;
        b=NOK4SKjLlQLEeCk+fjGPvW/EKp6l2LGZZ3es7Ku/x7nQVk8j/Y6ponIjNqpgkJ5RiI
         9Avrdtg5IuI4x0vdDe77jFGybfTF2qTdWBkYNwKMVYKZAYySNnJAPMUq4cXfEFFBPwAv
         NPzcxfq4ei/ZL2rUnmcXlsEqZjdKq6q1nDBDjZLtY/Zgaks+zbTTGF/DIwFJaTp1phZU
         JmxF9zeIFA4yssejMVRMSPu/NADDgDX4RpcBxb1ub/KTPNO3p5s84t23yXVF3hCznJ3F
         zjQvJMH7edvHu97/bnom12TvQaYM6I1lFWK5Hd018gH207zKCsJDdRKO87GO0kuwIw9K
         aN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WiAKB8+SjEHwCrofH7QRr3IXwaMMb0ZhTdJq3Ay5yG0=;
        b=m7yxAX/Kt71vV2m+zohOf7Ifl4t8sSvBPWYBNkSMoBPZzTwgXU+Hbsqh9Cw41iIJue
         658iTTzuyb0lXT0VATDoteuyhm31li0jssaZ5xPzo/Io+uuvve0nr+1p3iGLDYdmTL7e
         S7pnL8imsoncrVwcxR/7OnW4B/bVCySLzL6ju4iqxwvD8Jecgcv+r23nx5zPyEXjpOM/
         BG+oGaC1408ydVgZrNJ2f0cGRQpXs2yYEKMxY9Tbs1GY/0VmAnVAaQyGOlxKM9ZJ1xiE
         6234BJudK2dURWedu8tbDQ0AKaS4psE8eLLzfDcidRnQZXdts7T0ouwW4JTRRK35/TL5
         6XCQ==
X-Gm-Message-State: AOAM5308d0DZFYGyTgmrvH1kTZ2XdtLrL25aHA1iTbFV1UwPgtts6WGF
        sV4hf4qhoExMCU/9QyBq0ula7sx/dcmiSUkvlLkBMw==
X-Google-Smtp-Source: ABdhPJxw6AO9QBub5R04urReUdcbGz/oXgL83sbrzvgDIJ85pqGGIndK8KFdfAhQro1W6X3q3jHmfpNGVDVfEsASicA=
X-Received: by 2002:a25:d685:: with SMTP id n127mr11527577ybg.523.1639645225147;
 Thu, 16 Dec 2021 01:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20211215052651.89544-1-liuting.0x7c00@bytedance.com>
In-Reply-To: <20211215052651.89544-1-liuting.0x7c00@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 16 Dec 2021 16:59:44 +0800
Message-ID: <CAMZfGtXHodu_uKKE8fmd5mFYvPBTk6ShouQd=e4VHHQ0h=Ubzw@mail.gmail.com>
Subject: Re: [PATCH] mm: make some vars and functions static or __init
To:     Ting Liu <liuting.0x7c00@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>, sjpark@amazon.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 1:27 PM Ting Liu <liuting.0x7c00@bytedance.com> wrote:
>
> From: "liuting.0x7c00" <liuting.0x7c00@bytedance.com>
>
> "page_idle_ops" as a global var, but its scope of use within this
> document. So it should be static.
> "page_ext_ops" is a var used in the kernel initial phase. And other
> functions are aslo used in the kernel initial phase. So they should be
> __init or __initdata to reclaim memory.
>
> Signed-off-by: liuting.0x7c00 <liuting.0x7c00@bytedance.com>
> ---
>  include/linux/page_idle.h | 1 -
>  mm/page_ext.c             | 4 ++--
>  mm/page_owner.c           | 4 ++--
>  3 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/page_idle.h b/include/linux/page_idle.h
> index 83abf95e9fa7..4663dfed1293 100644
> --- a/include/linux/page_idle.h
> +++ b/include/linux/page_idle.h
> @@ -13,7 +13,6 @@
>   * If there is not enough space to store Idle and Young bits in page flags, use
>   * page ext flags instead.
>   */
> -extern struct page_ext_operations page_idle_ops;
>
>  static inline bool folio_test_young(struct folio *folio)
>  {
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 6242afb24d84..2193e3f10e56 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -63,12 +63,12 @@ static bool need_page_idle(void)

Should need_page_idle be marked as __init?
It is used in the initialization stage.

>  {
>         return true;
>  }
> -struct page_ext_operations page_idle_ops = {
> +static struct page_ext_operations page_idle_ops = {
>         .need = need_page_idle,
>  };

page_idle_ops is also used in the initialization stage.
It also can be marked as __initdata.


>  #endif
>
> -static struct page_ext_operations *page_ext_ops[] = {
> +static struct page_ext_operations *page_ext_ops[] __initdata = {
>  #ifdef CONFIG_PAGE_OWNER
>         &page_owner_ops,
>  #endif
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 4f924957ce7a..5eea061bb1e5 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -46,7 +46,7 @@ static int __init early_page_owner_param(char *buf)
>  }
>  early_param("page_owner", early_page_owner_param);
>
> -static bool need_page_owner(void)
> +static __init bool need_page_owner(void)
>  {
>         return page_owner_enabled;
>  }
> @@ -75,7 +75,7 @@ static noinline void register_early_stack(void)
>         early_handle = create_dummy_stack();
>  }
>
> -static void init_page_owner(void)
> +static __init void init_page_owner(void)
>  {
>         if (!page_owner_enabled)
>                 return;
> --
> 2.20.1
>
