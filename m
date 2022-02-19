Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D374BCA9C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 21:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbiBSUhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 15:37:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbiBSUhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 15:37:34 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5B0532F1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 12:37:15 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id e26so13644514vso.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 12:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vm51P2LO4NJ6NzvoomB2MjD9fMCciErum40stRnmssY=;
        b=VWNCVf2JUq8KTUz7fGHgv62SbfCeI1b76AqzJYHnmaRUbSfvPZtAUOpavKPAfIxdEn
         VKPjR5DvW8LjlotY4JOtmb8yem233KG5fNZSAoMHjZLj5vUvi4E3yOQPfO3/asep2FQe
         PXNHKxF8WtW5ipZR0w+3f8AIWE9Np24+QOjCOiXRtcVGGsMqfh3Bf1pJTXCrazzmD5Jo
         6m4RpowMLTh20p5R+tzll/PYqzffqXjXZwe/9cc8tIB2Oyn3JAto6H0Dd2+TnQUcj2mu
         0bsXrICYiGcfO8xD9/dnliG0LTnLogy8cRFGh3W0N+WranXkxfwQivBTII0jrGZdXT+y
         LDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vm51P2LO4NJ6NzvoomB2MjD9fMCciErum40stRnmssY=;
        b=L/dTIvQDEq+OFl7AlBLR25ISTBX6zGr67LfPbaBaEp4lO1OFhhmjY6hLu/lo4HFtiQ
         aaa80LnUUkq+PF0WaAFz9tiCZS488rJxJ+vVu7YTywowdTEOGqYxDlrZdTjly3w+BpHk
         lWQCK82j7HDWNi+cDrAJDKch6G1PdUm9SosI73HJp9z4ySt5J1XxQpzskJZXyhtfCp8J
         Ib67qhO+2nNJ5X1RIVnwUkSUUgogJvyDJwNoJKIQfUWYj1jKb4wiTFmR6L0ndwRdwl7M
         L+Qh5+mEpXmFRioYAlW9C5K3n00oHAdtz/iT4VubL69Z8Rd7PtWV5HJkJoS2BpvHfKYA
         TTJw==
X-Gm-Message-State: AOAM530FiR/wmkoZuQIBJa29Rh5ebDCVmdNOcG366KVnmLFoyazhtNwf
        UYUpRTMhOg3z6OL6lzG7KnUBFLplqSEnpuwEmGT+A8sHSkk=
X-Google-Smtp-Source: ABdhPJz67l72/4r6Gi97prQaRTiRllJqT5eNhtLmtDAa3+QElwqWGqW4KC60YEQInj4r7ezcHLXcOyP3LPINQ4RJi7E=
X-Received: by 2002:a67:d38f:0:b0:31a:808b:7f1 with SMTP id
 b15-20020a67d38f000000b0031a808b07f1mr5439421vsj.56.1645303033914; Sat, 19
 Feb 2022 12:37:13 -0800 (PST)
MIME-Version: 1.0
References: <20220219092533.12596-1-linmiaohe@huawei.com> <20220219092533.12596-10-linmiaohe@huawei.com>
In-Reply-To: <20220219092533.12596-10-linmiaohe@huawei.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sun, 20 Feb 2022 02:07:01 +0530
Message-ID: <CAFqt6zbgABM2nrR_BbMpT72YDXYeejafg9J8qpFbXXnjn=Xsfw@mail.gmail.com>
Subject: Re: [PATCH 9/9] mm/z3fold: remove unneeded return value of z3fold_compact_page()
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        vitaly.wool@konsulko.com, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
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

On Sat, Feb 19, 2022 at 2:56 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Remove the unneeded return value of z3fold_compact_page() as it's
> never checked.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  mm/z3fold.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 83b5a3514427..db41b4227ec7 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -746,18 +746,18 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
>
>  #define BIG_CHUNK_GAP  3
>  /* Has to be called with lock held */
> -static int z3fold_compact_page(struct z3fold_header *zhdr)
> +static void z3fold_compact_page(struct z3fold_header *zhdr)
>  {
>         struct page *page = virt_to_page(zhdr);
>
>         if (test_bit(MIDDLE_CHUNK_MAPPED, &page->private))
> -               return 0; /* can't move middle chunk, it's used */
> +               return; /* can't move middle chunk, it's used */
>
>         if (unlikely(PageIsolated(page)))
> -               return 0;
> +               return;
>
>         if (zhdr->middle_chunks == 0)
> -               return 0; /* nothing to compact */
> +               return; /* nothing to compact */
>
>         if (zhdr->first_chunks == 0 && zhdr->last_chunks == 0) {
>                 /* move to the beginning */
> @@ -766,7 +766,7 @@ static int z3fold_compact_page(struct z3fold_header *zhdr)
>                 zhdr->middle_chunks = 0;
>                 zhdr->start_middle = 0;
>                 zhdr->first_num++;
> -               return 1;
> +               return;
>         }
>
>         /*
> @@ -778,7 +778,6 @@ static int z3fold_compact_page(struct z3fold_header *zhdr)
>                         BIG_CHUNK_GAP) {
>                 mchunk_memmove(zhdr, zhdr->first_chunks + ZHDR_CHUNKS);
>                 zhdr->start_middle = zhdr->first_chunks + ZHDR_CHUNKS;
> -               return 1;
>         } else if (zhdr->last_chunks != 0 && zhdr->first_chunks == 0 &&
>                    TOTAL_CHUNKS - (zhdr->last_chunks + zhdr->start_middle
>                                         + zhdr->middle_chunks) >=
> @@ -787,10 +786,7 @@ static int z3fold_compact_page(struct z3fold_header *zhdr)
>                         zhdr->middle_chunks;
>                 mchunk_memmove(zhdr, new_start);
>                 zhdr->start_middle = new_start;
> -               return 1;
>         }
> -
> -       return 0;
>  }
>
>  static void do_compact_page(struct z3fold_header *zhdr, bool locked)
> --
> 2.23.0
>
>
