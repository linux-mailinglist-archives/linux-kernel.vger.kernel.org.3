Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1411E47BCB0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbhLUJRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbhLUJRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:17:18 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695C8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:17:18 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id q14so12257003qtx.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GsQvaI7A1wdAxmeueWYfyyxE+cFPs78qCZTLJz4uaZA=;
        b=Rc/RWdXiq31wiYWyOfSAe3/XzoJsf6eSWj3UqAgso2+3tudJ+pEqajnSp0MX5Ivnfb
         v7E10N+xuZFfHtjQM2mSDXPtJfFPDEwzTYQ3cAKbGxk7QHB6gC2o3EvLU9VxEEns/tiz
         X1hl9TOtbzs3rrNAPQfZzn1wMayO+xs4+rDfx89HM8IU5iDPOT9NL2pyYQKO4MieUVPv
         tZpDXlsBkQYTVoCKgb4E1a6VElwwvxzHfS+8kWzB4UhdcKmmdDvCJNZjZ+cu8BXn1cTz
         uwuxkPPIh0lj7g3SXk2jTJrWbMZh+Q99aVadlgxINr8y6JYEP+3uBwCpsJdKiymd9vwZ
         VDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GsQvaI7A1wdAxmeueWYfyyxE+cFPs78qCZTLJz4uaZA=;
        b=QVqIF9Wm1wpUJIjHfoZ1/S2CLYiIJujkbR1p4BL0D2nQzxPA4Ja+xsCt+E8v4KrLwh
         2QYR4X8QAQxAA9UDLGINOZvk65zubq/8LFbwzZR1Hajt1uPFiGJn6mE6Cn5NpyxwZaVF
         yJJ5lnlqfgh1dar7Nkd2f8NXRUaB2jg/idOy9s3YulrXEaHeEGL8h2PXX6knkoCMg6ap
         T/g3OyXQLW8+ogBkuCwMtDyA93xlVpANqv9hBgbHKRGo59KaxyhTvwFUJw1s56d0H4py
         0vhgl8SSakS4Jbx77eD+2hhFARhRSQ2IAq2m0hlu38kHqZSiqo74M0+W/8C3l2Vw6lDc
         VkRg==
X-Gm-Message-State: AOAM532qKmjSgMBNls6EzzfRhhrG0xmLAUPMmBAjtaXo6VD9y/EPICsG
        AiKlsNoKXU/58GW0r6Drw1nlqLVKViDZW0fE4wnXQA==
X-Google-Smtp-Source: ABdhPJySaSkdGVLLYk9zgNVN+v/hvI55u4ES66+7QrRplSW+Lq21+NQDiGiG71v2c+6hNI+kO5z5N8ahWN2FEGKAbcM=
X-Received: by 2002:ac8:5712:: with SMTP id 18mr1304135qtw.72.1640078237345;
 Tue, 21 Dec 2021 01:17:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1640036051.git.andreyknvl@google.com> <92f3029f3647ab355450ed5c8252bad8cfae1e09.1640036051.git.andreyknvl@google.com>
In-Reply-To: <92f3029f3647ab355450ed5c8252bad8cfae1e09.1640036051.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 21 Dec 2021 10:16:41 +0100
Message-ID: <CAG_fn=XcPT=e6zmm-B4KQPLujpuC9D+hTbJEsua31onzopDT5g@mail.gmail.com>
Subject: Re: [PATCH mm v4 07/39] mm: clarify __GFP_ZEROTAGS comment
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 10:59 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Alexander Potapenko <glider@google.com>

>
> __GFP_ZEROTAGS is intended as an optimization: if memory is zeroed during
> allocation, it's possible to set memory tags at the same time with little
> performance impact.
Perhaps you could mention this intention explicitly in the comment?
Right now it still doesn't reference performance.

>
> Clarify this intention of __GFP_ZEROTAGS in the comment.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  include/linux/gfp.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 0b2d2a636164..d6a184523ca2 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -228,8 +228,8 @@ struct vm_area_struct;
>   *
>   * %__GFP_ZERO returns a zeroed page on success.
>   *
> - * %__GFP_ZEROTAGS returns a page with zeroed memory tags on success, if
> - * __GFP_ZERO is set.
> + * %__GFP_ZEROTAGS zeroes memory tags at allocation time if the memory i=
tself
> + * is being zeroed (either via __GFP_ZERO or via init_on_alloc).
>   *
>   * %__GFP_SKIP_KASAN_POISON returns a page which does not need to be poi=
soned
>   * on deallocation. Typically used for userspace pages. Currently only h=
as an
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/92f3029f3647ab355450ed5c8252bad8cfae1e09.1640036051.git.andreyk=
nvl%40google.com.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
