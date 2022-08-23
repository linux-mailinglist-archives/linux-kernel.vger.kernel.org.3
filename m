Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D795F59D7EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 12:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351145AbiHWJej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 05:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350666AbiHWJd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 05:33:57 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E72B9413C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:39:05 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-33387bf0c4aso359963137b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=y2+gfSM2pVPpDUIFDptSeizvM7Y4XC7yjqvLtiCZN3I=;
        b=IHlPVquiuZ906a77Ewu9nBq5xEoT22M9O+IkdFA/5OREtwtoXe/FJVKv9yNBqjKrcF
         06DqztKqt0GY1oqa0NmpJpf13Lk36/LWlK3kt5OSrEfhUp7z1povhqQmlbr4fEvNhXwS
         QeJO/bNa4TCrVQy4VbzMMOtLVOXpsJz25LfzBe5V6JG0oY/mTEzkD1qcykJCtjcVtBP3
         wyxgVQLDl/BhPn2UA0Hu3t+eP/pSWHouLIm4kfJxOHLysWKgrqpK1oZ8cCOq3U04czCN
         pVV0H8KvkALznMgqxvqab5t9uDV+wWBUnn+q+JLkKMTC7EaII35I4PdaTBKIFkdaTxqV
         7OHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=y2+gfSM2pVPpDUIFDptSeizvM7Y4XC7yjqvLtiCZN3I=;
        b=Auu1w7m8DPTqxDjBcC2y3GNZ42Iw1MwNUNgj1j3QMCNUV+LFK4KXEcbV+ggPMsHVDs
         qxCZONoiFsOQzKobeqgA5au4Q7RsgjH9tU4NZSKKFD79DGgqhvGI2FjQ/CDoKnPLadmW
         /kst51TyuG1bxmpyHIRxiKKLeg44DMxfUhqWFKCPL4jt4Tr1Y2U5sZIQ0N+MuaP98jmB
         aycl8x1IfggzYdCyWwtz2/gRwvxSO/syj/goVHZLY2daTBBnsXB9B5vM+LM02ae1AVhM
         Rq0NyRjPxRiy2cwgiUhMf2D9I+1n9PQre7Yc1eIWVa1JP0ju3xw9LzJYKQJKl4ey9o/P
         p3JA==
X-Gm-Message-State: ACgBeo3dRJWjpEYwykbfs7soc8E6tFBu0qwtqWbd8vclDm34xIe1HGoc
        Xy0keux6IlMOSL4Tm5AoQkeS6LUoY/C3VIClCGRkTuD6
X-Google-Smtp-Source: AA6agR5kGbjVmGG2C7E8Qj7w6pmadVoVwDHdD9GogfriKvIyHwsz0ilIgqyAykJHqtKT30QMomIeQCvN01/XrXc1ipk=
X-Received: by 2002:a81:7c2:0:b0:335:90cb:1962 with SMTP id
 185-20020a8107c2000000b0033590cb1962mr24531628ywh.173.1661243882670; Tue, 23
 Aug 2022 01:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220823075241.209009-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220823075241.209009-1-ye.xingchen@zte.com.cn>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Tue, 23 Aug 2022 17:37:50 +0900
Message-ID: <CAB=+i9RQ_x8JO2s=3mOK3T75k0DNm1ShUZsctsXgLP0v=X4gFQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] mm/slab_common: Remove the unneeded result variable
To:     cgel.zte@gmail.com
Cc:     cl@linux.com, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 4:52 PM <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value from __kmem_cache_shrink() directly instead of storing it
>  in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  mm/slab_common.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 17996649cfe3..0dfa3cfb6be5 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -495,13 +495,9 @@ EXPORT_SYMBOL(kmem_cache_destroy);
>   */
>  int kmem_cache_shrink(struct kmem_cache *cachep)
>  {
> -       int ret;
> -
> -
>         kasan_cache_shrink(cachep);
> -       ret = __kmem_cache_shrink(cachep);
>
> -       return ret;
> +       return __kmem_cache_shrink(cachep);
>  }
>  EXPORT_SYMBOL(kmem_cache_shrink);
>

Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> --
> 2.25.1
