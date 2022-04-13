Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35E74FF9C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiDMPNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiDMPNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:13:10 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAEE3703D;
        Wed, 13 Apr 2022 08:10:49 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2ec42eae76bso25664277b3.10;
        Wed, 13 Apr 2022 08:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OM0A/zhk4eZOfp6idkUfQPzZxfIIhWLVD8InF0v8XWU=;
        b=dta5XXS38bwMkGjSwltpbO3K+p5WhA8wBEdybwubkokDddP5k2r/E51G5X43MjrRnN
         Tz751vcwKuWw0xHpFNBMkvL9qPksgp0F7L7QhucjtcJfCW28teYLsUJRpckZhAOtl0dz
         L26nS5wOSN5mRce/HHuFNL1tGy8vHsYsFv0Sm9lbyzMXind+pByfgHtSTH2LTl/Sb2q8
         8wClDgE3+q5R4nd24qIzRHvpi9pCs712vVHRKup12aYLo2qJ3+q1fcmiH5XnLeejACTj
         YjDsUiTrPMQt7HMHHjojTpcpeWiXxbhpvegBOBNFvA6NZb9MBKEVDiCFUQ8h1NNM4n3S
         1XdQ==
X-Gm-Message-State: AOAM530+j9VzxyBrb2mafT8VlhvWmJjZOESfSBbyN2bWK2+SjTWb56Fk
        vc6bZgYsFpKMQ1frg4SGYBVfwEl6lrvcKPzB2Hc=
X-Google-Smtp-Source: ABdhPJwGPR/D1mtWRPhZfR2DlyIP6TE1LD1mgdSSG/bGQKHso98+NkXb7AxOehIlCJTNvUHG9mX/yVboeKpjK/7AqYY=
X-Received: by 2002:a81:b89:0:b0:2eb:e9e6:470a with SMTP id
 131-20020a810b89000000b002ebe9e6470amr21087158ywl.7.1649862648292; Wed, 13
 Apr 2022 08:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <1648807295-31682-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1648807295-31682-1-git-send-email-baihaowen@meizu.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Apr 2022 17:10:36 +0200
Message-ID: <CAJZ5v0j3DSh7xrWhThmDNR-Rpevk04Q=vdSbqbiy-pVo2YFfBA@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: don't mark comment as kernel-doc
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Apr 1, 2022 at 12:01 PM Haowen Bai <baihaowen@meizu.com> wrote:
>
> Change the comment to a normal (non-kernel-doc) comment to avoid
> these kernel-doc warnings:
>
> kernel/power/snapshot.c:335: warning: This comment starts with '/**', but
>  isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Data types related to memory bitmaps.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  kernel/power/snapshot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 330d49937692..2a4d7d40161d 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -326,7 +326,7 @@ static void *chain_alloc(struct chain_allocator *ca, unsigned int size)
>         return ret;
>  }
>
> -/**
> +/*
>   * Data types related to memory bitmaps.
>   *
>   * Memory bitmap is a structure consisting of many linked lists of
> --

Applied as 5.19 material, thanks!
