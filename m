Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8C45A8A8B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiIABWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiIABWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:22:06 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA69E190C
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:22:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j9-20020a17090a3e0900b001fd9568b117so1014350pjc.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=nGbSPl6vfUxnpVaxdq8qn8cGXULdrRBFaoDPHGxfyrQ=;
        b=EI5j0lvZBm62JicpfiQSBi7BYb4g1q1L64BDiYbBF+l1fAE5ZYWpsfKSXW2Yfo1KDB
         ByFErbxVMNQRgeoxwV2ojR5jQQbHvGR2AOhyOGE86qEgyAFQsCZkJxPe6zyOJ5SR/E0H
         R2VDSdiJbBfwVtNA7yxUvypvmlAghteEHxRDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=nGbSPl6vfUxnpVaxdq8qn8cGXULdrRBFaoDPHGxfyrQ=;
        b=0HrW3hNThwbHaVTr5iF2+HeIX2QnYfppldAGypzk5dylsEd9iTQ+aG12/IUgmgdHsB
         RitCNMf6bSWm25N6VzxqC3yYidbLxySglVPxShk+h+yFx0VIiJjrLKAqzS+WSt8Ep38d
         l5YmmFEyx1Kv/2G0WXd6Ehj9rAprq2dc6RNxsI6yV1y/yB976s/CMjwz732wMfuL5CWD
         H4iT+OlWFF7b8T9fnKFnqEe2DrTiSlnDyIGsfZFY2JS9ilZOzB4kryKviH7cfU306S2G
         eyAMeN62mzgFz7N3CQ+IJ9CluIjSu+t9OkrL7cW6iTA1f15QbuIgwqC7li/XElArjzSv
         9ZoQ==
X-Gm-Message-State: ACgBeo2deuSDFa6ICcYKnjsHdOYzB/7zK7B+NGrzXEKtmS7oV9+X3ru0
        5aarJATAZKDKThS+V5GBUYaqhw==
X-Google-Smtp-Source: AA6agR6taB/DtW1RsVuwX04HNOdPTnYauju6iD2tOkpmyqZmHPFGW+xFSLlmBl3YkGfdTCeQPF0scw==
X-Received: by 2002:a17:903:25c4:b0:174:4311:bf17 with SMTP id jc4-20020a17090325c400b001744311bf17mr26602118plb.103.1661995324965;
        Wed, 31 Aug 2022 18:22:04 -0700 (PDT)
Received: from google.com ([110.11.159.72])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902f39100b0016b81679c1fsm390242ple.216.2022.08.31.18.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 18:22:04 -0700 (PDT)
Date:   Thu, 1 Sep 2022 10:21:58 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Alexey Romanov <avromanov@sberdevices.ru>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     senozhatsky@chromium.org, ngupta@vflare.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [PATCH v1] zsmalloc: zs_object_copy: replace email link to doc
Message-ID: <YxAJNhMcLxjlxVy0@google.com>
References: <20220815144825.39001-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815144825.39001-1-avromanov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/08/15 17:48), Alexey Romanov wrote:
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 99d93a48cbe0..17641bde5432 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1559,8 +1559,8 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
>           * Calling kunmap_atomic(d_addr) is necessary. kunmap_atomic()
>           * calls must occurs in reverse order of calls to kmap_atomic().
>           * So, to call kunmap_atomic(s_addr) we should first call
> -         * kunmap_atomic(d_addr).  For more details see
> -         * https://lore.kernel.org/linux-mm/5512421D.4000603@samsung.com/
> +         * kunmap_atomic(d_addr). For more details see
> +         * Documentation/mm/highmem
>           */
>          if (s_off >= PAGE_SIZE) {
>              kunmap_atomic(d_addr);

So I'm not against this patch, but in general I don't think we document
kmap_atomic/kunmap_atomic in the kernel. That's type of API that people
get BUG() on and then figure out that it's a stack and pop-s should
mirror push-es. We have lots of undocumented src/dst kmap-s:

                src = kmap_atomic(s_page);
                dst = kmap_atomic(d_page);
                do_copy_page(dst, src);
                kunmap_atomic(dst);
                kunmap_atomic(src);

Like I said, I'm not against this patch, so FWIW
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

I'll let Minchan to have the final word.
