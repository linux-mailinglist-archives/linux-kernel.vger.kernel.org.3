Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0184B620A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 05:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiBOEYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 23:24:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiBOEYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 23:24:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D25A88B8;
        Mon, 14 Feb 2022 20:24:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0CCD61227;
        Tue, 15 Feb 2022 04:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F899C340EC;
        Tue, 15 Feb 2022 04:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644899071;
        bh=1GtgnRvuFA3j5DLrWfRmac2d+JF5/ykPvuln8f4qXg8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KH6NTdmd9+oocrKP6r/Hgc6lI+Cguq4EXWec7vhW4AZX83Xsl8en5bCImwLhf3uT9
         FusC7nBEozxw9rT1ewN2v/saJ7bkfN0psUM9vRK/4bLRrbSFXO9PHX8DBoN6u0ieX4
         RjC9EYpysJ97+l+t10EfLxiUbNMIEGLHfqQ248yqgk2P5pPKpk9UmgqMMWq0AEplw2
         sEiVJ8nv2it4YnZhvc6+7ivTeG5z7wGCQstCILGCedP+jy3TXUsqq4fp4pLSmaK4hm
         4ydWeT2YEJgSq0lKi+clJKctfrYTP2C4A56NF3JSY3C0tseGDI3VPwVLlYylHJE/1X
         0nAmJqep/LheA==
Received: by mail-vs1-f51.google.com with SMTP id g20so9090439vsb.9;
        Mon, 14 Feb 2022 20:24:31 -0800 (PST)
X-Gm-Message-State: AOAM5320D89GnvGiW1817TNEFhERndODFzr7G+Vce2z00KMZRxrMcUBp
        Rkcdvwpmjq4KhpPcZ1ZASJBha5U4URaOXQ9fWcc=
X-Google-Smtp-Source: ABdhPJzrYCExwBPj9lvIUEPXbkNhN3Rq3Cfgb2cKYfXljgYVrtwWmUdCX3U0U4NGGhf98fgtkqgw+fyHPL/IuQqtnrI=
X-Received: by 2002:a67:c802:: with SMTP id u2mr806278vsk.59.1644899070100;
 Mon, 14 Feb 2022 20:24:30 -0800 (PST)
MIME-Version: 1.0
References: <98208fa3-4b28-cdeb-7699-dbd9d66bfa60@infradead.org> <20220214120250.10256-1-wonder_rock@126.com>
In-Reply-To: <20220214120250.10256-1-wonder_rock@126.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 15 Feb 2022 12:24:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS8+8LME3oNgVyB4schf=Q8XictRXVCtpVTfoPL8D2NFA@mail.gmail.com>
Message-ID: <CAJF2gTS8+8LME3oNgVyB4schf=Q8XictRXVCtpVTfoPL8D2NFA@mail.gmail.com>
Subject: Re: [PATCH 1/1] csky: Fix versioncheck warnings
To:     wonder_rock@126.com
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 8:35 PM <wonder_rock@126.com> wrote:
>
> From: Deyan Wang <wonder_rock@126.com>
>
> arch/csky/include/asm/io.h: 8 linux/version.h not needed.
> arch/csky/kernel/process.c: 5 linux/version.h not needed.
> arch/csky/mm/dma-mapping.c: 12 linux/version.h not needed.
Could you put the command in the comment log? thx

>
> Signed-off-by: Deyan Wang <wonder_rock@126.com>
> ---
>  arch/csky/include/asm/io.h | 1 -
>  arch/csky/kernel/process.c | 1 -
>  arch/csky/mm/dma-mapping.c | 1 -
>  3 files changed, 3 deletions(-)
>
> diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
> index f82654053dc0..ed53f0b47388 100644
> --- a/arch/csky/include/asm/io.h
> +++ b/arch/csky/include/asm/io.h
> @@ -5,7 +5,6 @@
>
>  #include <linux/pgtable.h>
>  #include <linux/types.h>
> -#include <linux/version.h>
>
>  /*
>   * I/O memory access primitives. Reads are ordered relative to any
> diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
> index 3d0ca22cd0e2..5de04707aa07 100644
> --- a/arch/csky/kernel/process.c
> +++ b/arch/csky/kernel/process.c
> @@ -2,7 +2,6 @@
>  // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
>
>  #include <linux/module.h>
> -#include <linux/version.h>
>  #include <linux/sched.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/sched/debug.h>
> diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
> index c3a775a7e8f9..82447029feb4 100644
> --- a/arch/csky/mm/dma-mapping.c
> +++ b/arch/csky/mm/dma-mapping.c
> @@ -9,7 +9,6 @@
>  #include <linux/mm.h>
>  #include <linux/scatterlist.h>
>  #include <linux/types.h>
> -#include <linux/version.h>
>  #include <asm/cache.h>
>
>  static inline void cache_op(phys_addr_t paddr, size_t size,
> --
> 2.25.1
>


--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
