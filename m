Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CABA4C4711
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbiBYOFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiBYOFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:05:04 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61181AA069
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:04:31 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4966F3FCAD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645797870;
        bh=EdlAiChWlSjnHqMEl5+rYYw1D6uhL90FBdNameorEkY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=m1l0dzVf8w1Zu+gnZs/TAnoE1EpMKEsbLzsyJK8jptGTHc6BXyRnAK3BX8Y6qqA0M
         zWwVrfcaMZwOz50+cj056w97z3Bhiahn2+8LGSObf51pf8/V7gJ2FUmZvkNlk1XXDj
         4x1pLEOLEPqVTBO3KlXNGya51fGV9DOFwskJk4eZwqv5nEpyxgcHYJSGawsQ2cQnyP
         jC1olzt8mgPouZ7a03X9qdWnebpLyZ9wvrOB47afKRpBKvxr/SId9+Ak33M5Y4as/6
         rj4+Uv0w7RkEKM7fFOf1k0jyzK+xuAKHLPD+CMSdXov6Z+5pUmpHWRkHC5cPtiC1I8
         WhFnEFzYcKSSw==
Received: by mail-ej1-f69.google.com with SMTP id ga31-20020a1709070c1f00b006cec400422fso2687119ejc.22
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:04:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EdlAiChWlSjnHqMEl5+rYYw1D6uhL90FBdNameorEkY=;
        b=OAgSlOwlXELaW/VdqffdrQj5N0je3eQREQf5Z5Mvh0gZe22erZ4uaE4+NwJoISuMJM
         3+oc/7K6SdsIfsU5jDbHxpsqlmg01hpeOlkRQQpOHxvO8P3xrcUJeLhuwo38hGKHAzjq
         yeJ9ijCazHk0vRByw8UNVu7rdJBWz9rvgB8VEIdekrpFanSoVzK/YwgW0UEKAqgBBhfX
         9SjsC3pmt1j/bxo5jramsuGPyzRGhcbe+7Y1243x+G8SK/ABbs9hxjNq7L537SFptzkC
         0eUxf73YEfM7XD+gocxPwJJY6EXSQXBzuR7tUyruz3tPLM2WNtJW5tBLIHKYEOvU3DqY
         fZWw==
X-Gm-Message-State: AOAM533WeypEfDr/ZJu2NPLqg8iao20Ck65RkDLlFehoNuw2uUiS54TD
        Ye4JNcsQPK47r65tQctrrTbERg6oeazXPxg76bNgKuE/kesfgYmLft5H5/EaxADAMb6ciJG9Khh
        7d9Tbly6+2eP8uQ1kZnxrPKy5j/5Gtp7dB5QECZM1z9qlNlZGwS/++kpLHQ==
X-Received: by 2002:a17:906:80c7:b0:6cf:9c76:1404 with SMTP id a7-20020a17090680c700b006cf9c761404mr6139740ejx.207.1645797869862;
        Fri, 25 Feb 2022 06:04:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy58ysZOvpIViio0ackgH6hqMa45e2gHNM9hRoMYG2+WXwxSh1SWsVVOz2IW4eWXRM5aQLW16HKIdbbE0nHQv0=
X-Received: by 2002:a17:906:80c7:b0:6cf:9c76:1404 with SMTP id
 a7-20020a17090680c700b006cf9c761404mr6139716ejx.207.1645797869620; Fri, 25
 Feb 2022 06:04:29 -0800 (PST)
MIME-Version: 1.0
References: <20220225123953.3251327-1-alexandre.ghiti@canonical.com> <CANpmjNN304EZfFN2zobxKGXbXWXAfr92nP1KvtR7j-YqSFShvQ@mail.gmail.com>
In-Reply-To: <CANpmjNN304EZfFN2zobxKGXbXWXAfr92nP1KvtR7j-YqSFShvQ@mail.gmail.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Fri, 25 Feb 2022 15:04:18 +0100
Message-ID: <CA+zEjCtuwnKdi8EuyGWaYNFa7KsYcH9B1mYke6YALo+C1Nq+Dw@mail.gmail.com>
Subject: Re: [PATCH -fixes v3 0/6] Fixes KASAN and other along the way
To:     Marco Elver <elver@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Nick Hu <nickhu@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 2:06 PM Marco Elver <elver@google.com> wrote:
>
> On Fri, 25 Feb 2022 at 13:40, Alexandre Ghiti
> <alexandre.ghiti@canonical.com> wrote:
> >
> > As reported by Aleksandr, syzbot riscv is broken since commit
> > 54c5639d8f50 ("riscv: Fix asan-stack clang build"). This commit actually
> > breaks KASAN_INLINE which is not fixed in this series, that will come later
> > when found.
> >
> > Nevertheless, this series fixes small things that made the syzbot
> > configuration + KASAN_OUTLINE fail to boot.
> >
> > Note that even though the config at [1] boots fine with this series, I
> > was not able to boot the small config at [2] which fails because
> > kasan_poison receives a really weird address 0x4075706301000000 (maybe a
> > kasan person could provide some hint about what happens below in
> > do_ctors -> __asan_register_globals):
>
> asan_register_globals is responsible for poisoning redzones around
> globals. As hinted by 'do_ctors', it calls constructors, and in this
> case a compiler-generated constructor that calls
> __asan_register_globals with metadata generated by the compiler. That
> metadata contains information about global variables. Note, these
> constructors are called on initial boot, but also every time a kernel
> module (that has globals) is loaded.
>
> It may also be a toolchain issue, but it's hard to say. If you're
> using GCC to test, try Clang (11 or later), and vice-versa.

I tried 3 different gcc toolchains already, but that did not fix the
issue. The only thing that worked was setting asan-globals=0 in
scripts/Makefile.kasan, but ok, that's not a fix.
I tried to bisect this issue but our kasan implementation has been
broken quite a few times, so it failed.

I keep digging!

Thanks for the tips,

Alex
