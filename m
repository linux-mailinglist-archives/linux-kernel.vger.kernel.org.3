Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE28F550E74
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 03:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbiFTB4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 21:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiFTB4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 21:56:46 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB37B499
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 18:56:45 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-101b4f9e825so8113025fac.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 18:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ShQXyOSAkGVdNl9hgR0SL6zUjDlwyRW5Zc7GkdpEg0Q=;
        b=WgHTmNv0bTh+yjJYcsP7x+9KUUEGz7jXU+RdnCwpwFTGxQ1vZBPEigZMk3cz4Ey3yW
         VsvMvQiaAwlX64cbN2P0MPeN4woOgvtP6W4kw0S9Mg6fJHWwJOsyV4tfo8fZgoIQteRz
         hb8t1s2MyimEdexcwDiRt+jLdLS46k31CiZzhFPjx5uZDg7oNlADZzPlr+DFWQLaBaVK
         ISM9bvijAPwvlKE7qAsVx+6Vhx68xmaTpQbswCeG/pP6mRIaRPkrCmM6qI3aZlHNZZLH
         FMw4vF3Cgje9hZnYBFAkimJAv1Yu69u40z80i0gdfD12Ow0EvPDfN+lg6bb9jknOIJh5
         PGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShQXyOSAkGVdNl9hgR0SL6zUjDlwyRW5Zc7GkdpEg0Q=;
        b=lc7WWv+NSwotSUqUHBTUQJiZfSqiKSP5iG1As3DjIldpXGjg/spIVjRwd90z5GXiMM
         AcTavVL1Y2AfaWzKNQ9xwf68X81ErQ00d+wB8QxZYv/B86wvOfpevNloa9IhudcPn9gq
         H/2eXBpyZCOJ45PSrvyZW1H0qefIc3vLldepFpQcZWak4huLW3TerIdanhkW0GvRUu7S
         Bx3MM/uCS9J3wGsGyvkWDu/MoBnT1jIGyG938PpbLyv/rN6n2E5xKIfF+BnYytCwBXQ6
         BW8ezsi5cQ+z6+15c/bXr72xhcDULeZybyzpDaPOvCNqQVbQGqm271rEip0yGsP6HNgG
         z4+g==
X-Gm-Message-State: AJIora+HB0YzQRaEgYn6lw8M1Nq5TeHRAyf//5FPTRdYriJEitGnF1FQ
        Nc7S3g+nejTPU2ZxRL3hC9lUKC4geZD/Tep7yvPhJB9TEEaBnQ==
X-Google-Smtp-Source: AGRyM1tZ2SylSiiSfg3SA4yDfy4OID8z1nBg1YgKwrKbynmoPdknqOkUXo79BwO8C3BL1wyj4tnA7dfCCS2Kpd5qAds=
X-Received: by 2002:a05:6870:d582:b0:fe:4131:6dbb with SMTP id
 u2-20020a056870d58200b000fe41316dbbmr17457867oao.76.1655690205040; Sun, 19
 Jun 2022 18:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220619183617.1018438-1-p76091292@gs.ncku.edu.tw>
In-Reply-To: <20220619183617.1018438-1-p76091292@gs.ncku.edu.tw>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 20 Jun 2022 07:26:34 +0530
Message-ID: <CAFqt6zYF3wRRpmhGzK_r9436JbWfVyjnKKp0oWpSZ+3zad=bxw@mail.gmail.com>
Subject: Re: [PATCH] mm, docs: fix comments that mention mem_hotplug_end()
To:     Yun-Ze Li <p76091292@gs.ncku.edu.tw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
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

On Mon, Jun 20, 2022 at 12:06 AM Yun-Ze Li <p76091292@gs.ncku.edu.tw> wrote:
>
> Comments that mention mem_hotplug_end() are confusing as there is no
> function called mem_hotplug_end(). Fix them by replacing all the
> occurences of mem_hotplug_end() in the comments with mem_hotplug_done().
>
> Signed-off-by: Yun-Ze Li <p76091292@gs.ncku.edu.tw>
> ---
>  include/linux/mmzone.h | 4 ++--
>  mm/compaction.c        | 2 +-
>  mm/vmscan.c            | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index aab70355d64f..7c7947109986 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -591,7 +591,7 @@ struct zone {
>          * give them a chance of being in the same cacheline.
>          *
>          * Write access to present_pages at runtime should be protected by
> -        * mem_hotplug_begin/end(). Any reader who can't tolerant drift of
> +        * mem_hotplug_begin/done(). Any reader who can't tolerant drift of
>          * present_pages should get_online_mems() to get a stable value.
>          */
>         atomic_long_t           managed_pages;
> @@ -870,7 +870,7 @@ typedef struct pglist_data {
>         unsigned long nr_reclaim_start; /* nr pages written while throttled
>                                          * when throttling started. */
>         struct task_struct *kswapd;     /* Protected by
> -                                          mem_hotplug_begin/end() */
> +                                          mem_hotplug_begin/done() */
>         int kswapd_order;
>         enum zone_type kswapd_highest_zoneidx;
>
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 65970107b789..b8c1f60c84b9 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -3009,7 +3009,7 @@ void kcompactd_run(int nid)
>
>  /*
>   * Called by memory hotplug when all memory in a node is offlined. Caller must
> - * hold mem_hotplug_begin/end().
> + * hold mem_hotplug_begin/done().

Caller must be hold mem_hotplug_begin/done().

>   */
>  void kcompactd_stop(int nid)
>  {
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c6918fff06e1..bd6aaf85ee7f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4586,7 +4586,7 @@ void kswapd_run(int nid)
>
>  /*
>   * Called by memory hotplug when all memory in a node is offlined.  Caller must
> - * hold mem_hotplug_begin/end().
> + * hold mem_hotplug_begin/done().

Same here.

>   */
>  void kswapd_stop(int nid)
>  {
> --
> 2.25.1
>
>
