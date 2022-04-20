Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8D4507F44
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348767AbiDTDB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbiDTDB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:01:57 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FCF38BE5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:59:13 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s25so523859edi.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fCO4DZsrcFJvW/h/KDtAy5sw4iMAoyjRegeBhEbbGME=;
        b=VLMO61q8IHewHYHM+ceMtC79fS4nbOR09SzueO2v0renQPlbKB+sYErCZmDWQISUxq
         dAy7rjD9ePHa73NGG3vI5tQxYMoyk0NHHFIBrJOgJS0+kcKKkJ+4XVuyxi/wB57xyzf6
         xfn/dmEBSgJe+n0h0MNuHjf3TY6P2Wzeyoqhf9Lb01rS9b7Z2f2mMCzQj3+i8U0qCoLL
         JvzcfmEvWj7l8ounT9+YIjpwE2Kt3g3yLS3U5yt1vXMkge1MAgpy0gQna4RtMc68qf3p
         OfBIy1d/14iISwBl7a1z1hEkRL21Y/FnU140T4UWkdYzTPOvgLtTdK8TtMq9FpC7uHFA
         NVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fCO4DZsrcFJvW/h/KDtAy5sw4iMAoyjRegeBhEbbGME=;
        b=BQh+crVHZ5BEjGeEVt0QJOMF+bgIwu7fxKtLJiW+AFZrn7MFzcqdLIFKqCqaOt16bz
         aNGZDpJOsgG+hrLor+8AXpKGTBVfPs0D7NvzKHJgHuCCaGwFUBPLi/fP5uRCn7/SLMC1
         q+IZFxR51FfUPhg9hulcWxW6ho2R2QxhyXoszYsrcyRWiKplWDBG7GOgkui/w6QgT00d
         wpS44jaAOOPY8dpqXHSmPukLII8JVvRPgKS6hl7h5YHyFiEQ7cGGW/2By0Y37XHlxd8/
         ezegMfIGM+G9ZI2S16eIt3F+b8FcffwO5W3BCRnMzcwFT2GsjWy0iqbY8rrbgldFtGOB
         S6vg==
X-Gm-Message-State: AOAM531MrK9MGNGBorfsaFKz4G0/ezM9ViFkryUk2d/e9AcAFW3/4dts
        1ck0noZb82nq8VlZhMazuUe2IlE9sExvafxedhh/Of77Rp1mfg==
X-Google-Smtp-Source: ABdhPJzR30WrOjJGK0N9yWaNaxGZPKkcmI8ZbZ3Wm+OCJRl0d/iiOBFvtsZCDx9vwKq0k6AJXbyPWUDxshgOKWRGfHo=
X-Received: by 2002:a05:6402:350a:b0:423:e41e:75cb with SMTP id
 b10-20020a056402350a00b00423e41e75cbmr14422528edd.178.1650423551851; Tue, 19
 Apr 2022 19:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220416081355.2155050-1-jcmvbkbc@gmail.com> <CANpmjNNW0kLf2Ou6i_dNeRLO=Qrru4bOEfJ=be=Dfig4wnQ67g@mail.gmail.com>
In-Reply-To: <CANpmjNNW0kLf2Ou6i_dNeRLO=Qrru4bOEfJ=be=Dfig4wnQ67g@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 19 Apr 2022 19:59:00 -0700
Message-ID: <CAMo8BfJM0JHqh8Nz3LuK7Ccu7WB1Cup0mX+RYvO1yft_K4hyLQ@mail.gmail.com>
Subject: Re: [PATCH] xtensa: enable KCSAN
To:     Marco Elver <elver@google.com>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Tue, Apr 19, 2022 at 3:16 AM Marco Elver <elver@google.com> wrote:
>
> Nice to see this happen!
>
> On Sat, 16 Apr 2022 at 10:14, Max Filippov <jcmvbkbc@gmail.com> wrote:
> > Provide stubs for 64-bit atomics when building with KCSAN.
>
> The stubs are the only thing I don't understand. More elaboration on
> why this is required would be useful (maybe there's another way to
> solve?).

It doesn't build without it, because the compiler left function calls
in the code:

xtensa-de233_fpu-elf-ld: kernel/kcsan/core.o: in function
`__tsan_atomic32_compare_exchange_val':
kernel/kcsan/core.c:1262: undefined reference to `__atomic_load_8'
xtensa-de233_fpu-elf-ld: kernel/kcsan/core.o: in function
`__tsan_atomic64_load':
kernel/kcsan/core.c:1262: undefined reference to `__atomic_load_8'
xtensa-de233_fpu-elf-ld: kernel/kcsan/core.c:1262: undefined reference
to `__atomic_store_8'
xtensa-de233_fpu-elf-ld: kernel/kcsan/core.o: in function
`__tsan_atomic64_store':
kernel/kcsan/core.c:1262: undefined reference to `__atomic_store_8'
xtensa-de233_fpu-elf-ld: kernel/kcsan/core.c:1262: undefined reference
to `__atomic_exchange_8'
xtensa-de233_fpu-elf-ld: kernel/kcsan/core.o: in function
`__tsan_atomic64_exchange':
kernel/kcsan/core.c:1262: undefined reference to `__atomic_exchange_8'
xtensa-de233_fpu-elf-ld: kernel/kcsan/core.c:1262: undefined reference
to `__atomic_fetch_add_8'
xtensa-de233_fpu-elf-ld: kernel/kcsan/core.o: in function
`__tsan_atomic64_fetch_add':
kernel/kcsan/core.c:1262: undefined reference to `__atomic_fetch_add_8'
xtensa-de233_fpu-elf-ld: kernel/kcsan/core.c:1262: undefined reference
to `__atomic_fetch_sub_8'
xtensa-de233_fpu-elf-ld: kernel/kcsan/core.o: in function
`__tsan_atomic64_fetch_sub':
kernel/kcsan/core.c:1262: undefined reference to `__atomic_fetch_sub_8'
xtensa-de233_fpu-elf-ld: kernel/kcsan/core.c:1262: undefined reference
to `__atomic_fetch_and_8'
xtensa-de233_fpu-elf-ld: kernel/kcsan/core.o: in function
`__tsan_atomic64_fetch_and':
kernel/kcsan/core.c:1262: undefined reference to `__atomic_fetch_and_8'
xtensa-de233_fpu-elf-ld: kernel/kcsan/core.c:1262: undefined reference
to `__atomic_fetch_or_8'
xtensa-de233_fpu-elf-ld: kernel/kcsan/core.o: in function
`__tsan_atomic64_fetch_or':
kernel/kcsan/core.c:1262: undefined reference to `__atomic_fetch_or_8'
xtensa-de233_fpu-elf-ld: kernel/kcsan/core.c:1262: undefined reference
to `__atomic_fetch_xor_8'
xtensa-de233_fpu-elf-ld: kernel/kcsan/core.o: in function
`__tsan_atomic64_fetch_xor':
kernel/kcsan/core.c:1262: undefined reference to `__atomic_fetch_xor_8'
xtensa-de233_fpu-elf-ld: kernel/kcsan/core.c:1262: undefined reference
to `__atomic_fetch_nand_8'
xtensa-de233_fpu-elf-ld: kernel/kcsan/core.o: in function
`__tsan_atomic64_fetch_nand':
kernel/kcsan/core.c:1262: undefined reference to `__atomic_fetch_nand_8'
xtensa-de233_fpu-elf-ld: kernel/kcsan/core.c:1262: undefined reference
to `__atomic_compare_exchange_8'
xtensa-de233_fpu-elf-ld: kernel/kcsan/core.o: in function
`__tsan_atomic64_compare_exchange_strong':
kernel/kcsan/core.c:1262: undefined reference to `__atomic_compare_exchange_8'
xtensa-de233_fpu-elf-ld: kernel/kcsan/core.c:1262: undefined reference
to `__atomic_compare_exchange_8'
xtensa-de233_fpu-elf-ld: kernel/kcsan/core.o: in function
`__tsan_atomic64_compare_exchange_weak':
kernel/kcsan/core.c:1262: undefined reference to `__atomic_compare_exchange_8'
xtensa-de233_fpu-elf-ld: kernel/kcsan/core.c:1262: undefined reference
to `__atomic_compare_exchange_8'

None of these functions are called because xtensa doesn't have
64-bit atomic ops.

I guess that another way to fix it would be making
DEFINE_TSAN_ATOMIC_OPS(64);
conditional and not enabling it when building for xtensa.

> > Disable KCSAN instrumentation in arch/xtensa/boot.
>
> Given you went for barrier instrumentation, I assume you tested with a
> CONFIG_KCSAN_STRICT=y config?

Yes.

> Did the kcsan_test pass?

current results are the following on QEMU:

     # test_missing_barrier: EXPECTATION FAILED at
kernel/kcsan/kcsan_test.c:1313
     Expected match_expect to be true, but is false
     # test_atomic_builtins_missing_barrier: EXPECTATION FAILED at
kernel/kcsan/kcsan_test.c:1356
     Expected match_expect to be true, but is false
 # kcsan: pass:27 fail:2 skip:0 total:29
 # Totals: pass:193 fail:4 skip:0 total:197

and the following on the real hardware:

    # test_concurrent_races: EXPECTATION FAILED at kernel/kcsan/kcsan_test.c:762
    Expected match_expect to be true, but is false
    # test_write_write_struct_part: EXPECTATION FAILED at
kernel/kcsan/kcsan_test.c:910
    Expected match_expect to be true, but is false
    # test_assert_exclusive_access_writer: EXPECTATION FAILED at
kernel/kcsan/kcsan_test.c:1077
    Expected match_expect_access_writer to be true, but is false
    # test_assert_exclusive_bits_change: EXPECTATION FAILED at
kernel/kcsan/kcsan_test.c:1098
    Expected match_expect to be true, but is false
    # test_assert_exclusive_writer_scoped: EXPECTATION FAILED at
kernel/kcsan/kcsan_test.c:1136
    Expected match_expect_start to be true, but is false
    # test_missing_barrier: EXPECTATION FAILED at kernel/kcsan/kcsan_test.c:1313
    Expected match_expect to be true, but is false
    # test_atomic_builtins_missing_barrier: EXPECTATION FAILED at
kernel/kcsan/kcsan_test.c:1356
    Expected match_expect to be true, but is false
# kcsan: pass:22 fail:7 skip:0 total:29
# Totals: pass:177 fail:20 skip:0 total:197

-- 
Thanks.
-- Max
