Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21494C8EDB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbiCAPXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbiCAPW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:22:58 -0500
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DD2A8ECB;
        Tue,  1 Mar 2022 07:22:17 -0800 (PST)
Received: by mail-io1-f46.google.com with SMTP id c23so18816992ioi.4;
        Tue, 01 Mar 2022 07:22:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17fHYdPQFVzWsknAFNwdkyV3QN+tMAp7sQTqvIqbS7s=;
        b=IaZFvg964ul2FFm04dJ4aVilVwSkq3tNtuRZzNQIZ1qy34DAa2M2mcIOTH9Efz8oma
         ltfQcTLuTQOBdmykSXRgNgPxwNeMUVN7W1k1AtWuiI8KBYAdQksdDam/auDc93EXE5SX
         Yz958K2iZ/NUq57qDWpcgrHt01um+1f3boVVUMRSq7bB7QDFd0qIt28q23RbNW4rqZMR
         h7NsDZu0IG5aJxEEAFPugIjsh4mMtAjYE4ATwKCchQvMSn0K4TtvT1flUwVHog/UhgMj
         sGP1i/KusXbgRP9EtxV7FcwgH8b2Q8bKxsFJ2D/mom3Yy/v7so44ZVQS3CIQ+hV5rV3u
         IqIw==
X-Gm-Message-State: AOAM53343AW0gBC1O8bnJwAH1+WuH4eh0LrzI8ODfzGO0nejT3732Qtw
        xLhJeQTFCeCC6/jBnq7pgPwEVHYdRyujO/NsrXn1jF+a
X-Google-Smtp-Source: ABdhPJwwt2otdbvGNqCJmsFuIaGpQ01LI6O8Nu7sQwI+o09PhY45pwqGbpMVXhO5pdjizwKGVRPETvFiyJ73sQfZXAQ=
X-Received: by 2002:a02:9f86:0:b0:311:b694:ef5c with SMTP id
 a6-20020a029f86000000b00311b694ef5cmr21638604jam.96.1646148136942; Tue, 01
 Mar 2022 07:22:16 -0800 (PST)
MIME-Version: 1.0
References: <20220215033750.104952-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20220215033750.104952-1-jiapeng.chong@linux.alibaba.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 16:22:05 +0100
Message-ID: <CAJZ5v0gU7WDQyPWefydeg6=40ugdo7FenJyKMd18m=HodMQvMA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: hibernate: Fix non-kernel-doc comment
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 4:38 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fixes the following W=1 kernel build warning:
>
> kernel/power/swap.c:120: warning: This comment starts with '/**', but
> isn't a kernel-doc comment. Refer
> Documentation/doc-guide/kernel-doc.rst.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
> Changes in v2:
>   -Modify subject 'block' to 'PM: hibernate'.
>
>  kernel/power/swap.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 6c4f983cbacc..91fffdd2c7fb 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -88,7 +88,7 @@ struct swap_map_page_list {
>         struct swap_map_page_list *next;
>  };
>
> -/**
> +/*
>   *     The swap_map_handle structure is used for handling swap in
>   *     a file-alike way
>   */
> @@ -116,7 +116,7 @@ struct swsusp_header {
>
>  static struct swsusp_header *swsusp_header;
>
> -/**
> +/*
>   *     The following functions are used for tracing the allocated
>   *     swap pages, so that they can be freed in case of an error.
>   */
> @@ -170,7 +170,7 @@ static int swsusp_extents_insert(unsigned long swap_offset)
>         return 0;
>  }
>
> -/**
> +/*
>   *     alloc_swapdev_block - allocate a swap page and register that it has
>   *     been allocated, so that it can be freed in case of an error.
>   */
> @@ -189,7 +189,7 @@ sector_t alloc_swapdev_block(int swap)
>         return 0;
>  }
>
> -/**
> +/*
>   *     free_all_swap_pages - free swap pages allocated for saving image data.
>   *     It also frees the extents used to register which swap entries had been
>   *     allocated.
> --

Applied as 5.18 material with adjustments in the subject and changelog.

Thanks!
