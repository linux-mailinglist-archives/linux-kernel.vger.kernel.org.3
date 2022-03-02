Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D614C9F0A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbiCBITo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbiCBITm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:19:42 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455B637BF2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:19:00 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2db2add4516so8403817b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=atOhUCKt1iNHeGULDxxyHd5Ye93aTurT561sTor+wwk=;
        b=UfpqrlNeV8QfcsKl+6EUXinBdkP8H6zxJRyw+c9ua2pryonEjbDZZqNXIyYcCPkdpL
         lu0/qLKih9YBlC3e4V4WvNw3i9uuZLx/vMPFdaXewq9kiQzhV/R40LpFbnV6RUZcYN25
         L2rM/kU7c3YUFgI6hiKKRWKTuQ1CriE843acY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=atOhUCKt1iNHeGULDxxyHd5Ye93aTurT561sTor+wwk=;
        b=YHLh0rVOA9mi/aiDvOtWoaJB1NhYG3Gy0KwRyE9RxkmYq2a9owvLoR0rrHSbOaiW27
         Kpcg+at3zWRcroSnYeQpfv7dVF1068BViWtY87JZI/23WHcK7dR2/eBh5RrQBZZC92fi
         U18Q1LyOpiis8ERJSKzq8Zp1r1Bnlw+mkS2qPgb1YfbVf/7z4F2Y7o9NcLB9OuOrr9W7
         G/GGUZ7L+uOr1kV95IfRwfEid08c2Dm05ymMf9mR0bPcWfUZ6oUASPQ+hhXfbiKpy81P
         63y0gpj12/2vzuMPPGk265I/hKx7gCCke2R5DIwz+lfN/AtYD3FQMUBZQWOVBOeEmWUc
         ZauA==
X-Gm-Message-State: AOAM533USD9N9XWhZRQIKitgNCDTLwP7xYAj+p6UhO9fV1abUepfvW2q
        uT6ej7EPC4GxVb8kkbTyaOqALUmdf8vuEPJQSTkRbycs19o=
X-Google-Smtp-Source: ABdhPJzvda6h0GVBzSzY9PX/SwfJGHPvt6tyXw3+GbJKops158/VF3L6GKAtZE93eje4ejQpI5LRumtLevq8N4uK7Lk=
X-Received: by 2002:a81:6e44:0:b0:2d0:b675:a0 with SMTP id j65-20020a816e44000000b002d0b67500a0mr28364295ywc.352.1646209139543;
 Wed, 02 Mar 2022 00:18:59 -0800 (PST)
MIME-Version: 1.0
References: <20220219092533.12596-1-linmiaohe@huawei.com> <20220219092533.12596-3-linmiaohe@huawei.com>
In-Reply-To: <20220219092533.12596-3-linmiaohe@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Wed, 2 Mar 2022 09:18:48 +0100
Message-ID: <CAM4kBB+PGgRqmkXOVCv+Cvv8CAE_apK5n9asL6JSfuxeS5-RcQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] mm/z3fold: remove obsolete comment in z3fold_alloc
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2022 at 10:26 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> The highmem pages are supported since commit f1549cb5ab2b ("mm/z3fold.c:
> allow __GFP_HIGHMEM in z3fold_alloc"). Remove the residual comment.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Vitaly Wool <vitaly.wool@konsulko.com>

> ---
>  mm/z3fold.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index e86aafea6599..87689f50f709 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -1064,9 +1064,6 @@ static void z3fold_destroy_pool(struct z3fold_pool *pool)
>   * performed first. If no suitable free region is found, then a new page is
>   * allocated and added to the pool to satisfy the request.
>   *
> - * gfp should not set __GFP_HIGHMEM as highmem pages cannot be used
> - * as z3fold pool pages.
> - *
>   * Return: 0 if success and handle is set, otherwise -EINVAL if the size or
>   * gfp arguments are invalid or -ENOMEM if the pool was unable to allocate
>   * a new page.
> --
> 2.23.0
>
