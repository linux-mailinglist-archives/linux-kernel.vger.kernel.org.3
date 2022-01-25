Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E8449BA94
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380018AbiAYRpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356541AbiAYRpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:45:18 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5247C06173D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:45:14 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id a18so64567926edj.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wLbqBjI2QnhR5W9uEc5kkHoAs2Fwdz+cZ7biUUiwy8I=;
        b=XI+wODe5OVLQqTQfMtV40bTEaKsreLM3EPk019QiGLOikHZQw2tz4GUN/nEsn3qY9g
         VS/GjD06yJHcWVGcUTR5DLpphOlZEUhQkrray2nW8tEqDuaXHmKm2w9G9lXgmF56nJlL
         y4Xmc8N2EFRfMfiEr+4IwSVxKKw0ZD6zgcQusWP3L0bOjw3fEY1DdDtm4y4iQ4oYzZZD
         ZMLdPdbJ59kN143+7jOdGXVCDaT/G0MQB+Y7gpLmnjnffCAvEswRbc8rijNM+w3YzriD
         nAxYRZxTlW1iMkMPRluiEcO7ZW3UQphCfeIcBJ26vr3mRojCFk6VqLyhyyt9SaMn5S6e
         tu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wLbqBjI2QnhR5W9uEc5kkHoAs2Fwdz+cZ7biUUiwy8I=;
        b=22Y3LFV0H4i2qVQhsWYdK+9pWOG2M21DhveTvSQWGluvnIqnkADQbPAbWdluhoE0jE
         T2fCbSazTQ889bjWXLqV1oVap1td22+LFZGxlzUwDJ9UxqwWSi7hU4ItGQnZ7cXXHiYe
         giGGx3W28Wf3MuR41VqOC1MW+2XWUYfh6G8fEsBNDrdZEVlWfnoD8bMzzjR6X9assz1I
         btrt0Pyst8hodfhcZTNhv0cXph1VL+M+Imt60znEKjuqOHtUJaAmmwYX0PpWVbMNG9Au
         vvs3Hp5aXSC4KW7R1Iv6VuusUi3OdbWKJyU/xfjCq9Hq82UGN0eP8eqSEOJaDcUytR1/
         DiLA==
X-Gm-Message-State: AOAM533VP6ptdwg0DyFHXC9+6pXgh7eGqKT72qx5WG5U47hPTnGL9gkx
        vVfwiSjUr+XxTklpXMarfRmUjyR5dMrMynXaL+E=
X-Google-Smtp-Source: ABdhPJy7sDNAtxM6nI6YrtNMouAdltvqi5H3GTLWL14Ws7Rtx1o1qgjY/BjnpCqfjcgQpU+bXrah2e6sBPMvn/ALJhs=
X-Received: by 2002:a50:cf86:: with SMTP id h6mr21975916edk.82.1643132713452;
 Tue, 25 Jan 2022 09:45:13 -0800 (PST)
MIME-Version: 1.0
References: <20220125025601.3054511-1-naoya.horiguchi@linux.dev>
In-Reply-To: <20220125025601.3054511-1-naoya.horiguchi@linux.dev>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 25 Jan 2022 09:45:01 -0800
Message-ID: <CAHbLzkr_w+E7AWoiAwjmjZhGMAt=donXV6SUSep0fkp=ZtOnkg@mail.gmail.com>
Subject: Re: [PATCH v1] mm, hwpoison: remove obsolete comment
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 6:56 PM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>
> With the introduction of mf_mutex, most of memory error handling
> process is mutually exclusive, so the in-line comment about
> subtlety about double-checking PageHWPoison is no more correct.
> So remove it.
>
> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/memory-failure.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 4c9bd1d37301..a6a1e02759e7 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2146,12 +2146,6 @@ static int __soft_offline_page(struct page *page)
>                 .gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
>         };
>
> -       /*
> -        * Check PageHWPoison again inside page lock because PageHWPoison
> -        * is set by memory_failure() outside page lock. Note that
> -        * memory_failure() also double-checks PageHWPoison inside page lock,
> -        * so there's no race between soft_offline_page() and memory_failure().
> -        */
>         lock_page(page);
>         if (!PageHuge(page))
>                 wait_on_page_writeback(page);
> --
> 2.25.1
>
>
