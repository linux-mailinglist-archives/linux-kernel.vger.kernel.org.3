Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E86D58F38A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 22:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiHJU10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 16:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiHJU1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 16:27:23 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C52E27176
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 13:27:22 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id c185so19049413oia.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 13:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc;
        bh=4322khwaC/pzWPqvcZwsNsFu97u8Q1+hjk+YFwWEDbE=;
        b=Gsip4Q5Pztucsw8+1VUWjFa2tgNUsfsXA9GXhWzh0z73XlAeElXI8HwWYLcJNR/go2
         JxxuF01cLNcq3AZySdyRXS0CZ5KzDf8IhIsPO8Epxg8jdmCmWtRvQ7eoDCRMFNCbnpV8
         Jbwx8gIoRtQBAudMnMwXhP92CyOmvfK9o3rLkkf3qLq4k7jnjwx3fsE2JLbAh/77T+07
         ubwnvQVZ6PUvnKbEUW1Pjx8bYHavXJh3YM3Sj7IBZAVT4nYX3DbCbYQJpkeXTI6kTPBQ
         CtUV1tYONpDc5XdDonzfBQJkvW1JyoKK/C6KartUutE0iakGIhtDx0zFenPz/L+ubGLH
         k6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc;
        bh=4322khwaC/pzWPqvcZwsNsFu97u8Q1+hjk+YFwWEDbE=;
        b=pWPwi//J1bYnwddi34CGCIksjjcN+JnSR87VGMAjHVlSV8S0wFYgymhWMx42eaJ/nY
         v3EKAhi0IyE+/MRarGAqm+JHN9gh7MuGPQX+6usUj7REMXk289QuhRNJ6dDoQygLze8m
         fQRHt9+Ui8BDMEz0tkQ+D8AqNboFu3GlPgswtLpTyiKvIwIjAnREb00HDI8mK2ewPi7Z
         rZHJq5SNnSiUpYnMAJ47eVAlZIMGRMTl1Mn/Zs5/WSIg6TG23HaMmEoBT9fjxKb2FQJE
         TAJjHNnwRtyK65975IPxkVFYGFCjwu+ENUiyXRzOJfKqQqqoeGlMoa2xRgR4K2doiv3d
         uUYQ==
X-Gm-Message-State: ACgBeo0hUuamnzfWAqnH+K02YUktmxqkGWAltuPxus7M4oealvxEsgUU
        oWz43DM2CjUgcq7fRLtzwOLOpQ0wZZIt4zR8pLQICYqKpmQ=
X-Google-Smtp-Source: AA6agR52xrLfAobPRZiSyh7msBNeurnRrvLHLpzbYq0Q3ZQTJeQPUcxcVifBILrrqwToC5rYruRwtlp7+F0SXwV/dbI=
X-Received: by 2002:a05:6808:1a11:b0:343:1ae:87d2 with SMTP id
 bk17-20020a0568081a1100b0034301ae87d2mr2073811oib.281.1660163241746; Wed, 10
 Aug 2022 13:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QbAV6YEN1h=T1H3-+1vg+DpSe8Uxzz2wH9u00GXe6L6TB-Uw@mail.gmail.com>
In-Reply-To: <CA+QbAV6YEN1h=T1H3-+1vg+DpSe8Uxzz2wH9u00GXe6L6TB-Uw@mail.gmail.com>
From:   Kallol Biswas <nucleodyne@gmail.com>
Date:   Wed, 10 Aug 2022 13:27:12 -0700
Message-ID: <CA+QbAV5fwjW6p4HmOy4wtryR-0e_=FB8jVxDf1wT52SsSpDFQw@mail.gmail.com>
Subject: Re: mm/memory-failure: __get_any_page: unknown zero refcount
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probably we are hitting a race condition. Upstream code has changed.

On Tue, Aug 9, 2022 at 2:28 PM Kallol Biswas <nucleodyne@gmail.com> wrote:
>
> While running a memory RAS test on a new platform I encountered the
> following on the 5.10.117 kernel.
>
> __get_any_page: 0x77df: unknown zero refcount page type 7fffe000000000
>
> The address 0x77df000 is in a system ram area:
> 00100000-5c9c0017 : System RAM
>
> The page is not a huge page, not on the free buddy list and not in use.
>
> __get_any_page()
> ..................
>  if (!get_hwpoison_page(p)) {
>     if (PageHuge(p)) {
>       pr_info("%s: %#lx free huge page\n", __func__, pfn);
>       ret = 0;
>     } else if (is_free_buddy_page(p)) {
>       pr_info("%s: %#lx free buddy page\n", __func__, pfn);
>       ret = 0;
>     } else if (page_count(p)) {
>       /* raced with allocation */
>       ret = -EBUSY;
>     } else {
>       pr_info("%s: %#lx: unknown zero refcount page type %lx\n",
>         __func__, pfn, p->flags);
>
>
> Sparse mem configs are set:
> cat /boot/config-5.10.117-2.el7.nutanix.20220304.1002776.x86_64 | grep -i sparse
> CONFIG_SPARSE_IRQ=y
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_DEFAULT=y
> CONFIG_SPARSEMEM_MANUAL=y
> CONFIG_SPARSEMEM=y
> CONFIG_SPARSEMEM_EXTREME=y
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> CONFIG_SPARSEMEM_VMEMMAP=y
> CONFIG_MEMORY_HOTPLUG_SPARSE=y
>
> Can someone help understand why we have such a page in the system?
> What the purpose is.
>
> Thank you,
> Kallol
