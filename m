Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED0F513A18
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350233AbiD1QqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349973AbiD1QqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:46:08 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42013B1AB0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:42:53 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id f38so10077143ybi.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r56JqmyEKwLfjjTuw56FZ5cxoCmhZkz1FIGkAdMEzhg=;
        b=gmEWLK/G4g326vlQfUkD0s/whD9rJnz2/equnQIJF2nnqQbb7pM3Ed+1fibophD2N7
         CIa1/jAvm7oxqS3hLTUpPUD84dJivbYpULK+unSOmhJB0bFDTKwLDO0h8/WXg9AnVau6
         /eZZhSk1wL0rTdkQQdONX8rlY2390cpw5zfJe1m+vvD4CErK/cim9uNN2ixWR5kCXw98
         sKyiLO6SNAeFdazNmNIccaHuwNOpcCDd1uDbTbIyuRtBb6eesZm85F1l8qARnu7FPXZ6
         kyIRcsOWWwVkvKcKgb8XkWMuGKki4vACrXFntBmRLJ4xOvBarkPtDxwDSGM+RbyM+45n
         YxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r56JqmyEKwLfjjTuw56FZ5cxoCmhZkz1FIGkAdMEzhg=;
        b=oEBq0qKBMS/qWWcJGtYXjXMJmKu7CeWf4bWZSsNTEbQ46YQw6wNDfRec4/3oBH2dGn
         jUtIOibvhxBlmASbhgjqwa0rkgmYtUH7CsCItyFfisGXvjM+WuRee17GrdqN9rnC/bmg
         8Q+Z5/C3czxj4NHCH5EhrjT+kE/Y7s3Zi/WbmTZHqcgRsfxJSY9uHjHi7y1mQNEKLaSj
         vhZdVUIY5xFWD7CDdPRlX4nLUECQCpAI1TMLCvsNofsdt1CAzMVV15bxPS07InVLw0LF
         X5TaAtLPkY7LpQfkcLMzfV471v1wgCxVHRXJbWCwNM6jmGNQ6Fmz1JD3kgXA1HVU75K9
         5K9w==
X-Gm-Message-State: AOAM533TpbiwS6nr3H0hRGO7kHDF5g5EKoO7Q3URVa5BwLP4EIJafmtK
        vSbD1rIZRQEoYIjl02OkGA5G0CC+HqCKOVv2Wtu6bw==
X-Google-Smtp-Source: ABdhPJwULhotWKO+NXz+dcEVz2aj7n4dvaBRBZ72IUvS4DL/hWhIkaotQI0g/VvhyXUYmLNxVAYiXldqMl9RMubQXGY=
X-Received: by 2002:a25:9bc5:0:b0:644:c1bc:1f12 with SMTP id
 w5-20020a259bc5000000b00644c1bc1f12mr30361921ybo.138.1651164172335; Thu, 28
 Apr 2022 09:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <3167cbec7a82704c1ed2c6bfe85b77534a836fdc.1651162840.git.andreyknvl@google.com>
In-Reply-To: <3167cbec7a82704c1ed2c6bfe85b77534a836fdc.1651162840.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 28 Apr 2022 18:42:16 +0200
Message-ID: <CAG_fn=XFOA-qsvPwjwJ0iZH1Wy54aS7QtD4ETVdp9L-yvOkiWg@mail.gmail.com>
Subject: Re: [PATCH 1/3] kasan: clean up comments in internal kasan.h
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 6:21 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Clean up comments in mm/kasan/kasan.h: clarify, unify styles, fix
> punctuation, etc.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Alexander Potapenko <glider@google.com>

>
> +/* alloca redzone size. Compiler's ABI, do not change. */
s/Compiler's/Compiler ?

>  #define KASAN_ALLOCA_REDZONE_SIZE      32
>
> -/*
> - * Stack frame marker (compiler ABI).
> - */
> +/* Stack frame marker. Compiler's ABI, do not change. */
Ditto

>
> -/* The layout of struct dictated by compiler */
> +/* Do not change the struct layout: compiler's ABI. */
Ditto

> -/* The layout of struct dictated by compiler */
> +/* Do not change the struct layout: compiler's ABI. */
Ditto

> -       unsigned long has_dynamic_init; /* This needed for C++ */
> +       unsigned long has_dynamic_init; /* This needed for C++. */
"is needed"?


> -        * is accepted since SLAB redzones aren't enabled in production builds.
> +        * is accepted since slab redzones aren't enabled in production builds.
s/accepted/acceptable ?
