Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACFC4FFF4A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbiDMTag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiDMTae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:30:34 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CB972E24
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:28:12 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id r2so3032846iod.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hGxcoipwWUtIXq1n/IgG8Z+lNTNMbXErzkobqsYlE2I=;
        b=ZL69/ZorDhoyGCgh2Jl2LpYu9wdzJZuKqXtq1AduuuzTrWaviPzsVClwbPvrv7uCTd
         Wy5ca+NuwOlsqg+aYU1IESzQE3G37dKVWlkYY9Ly6sDjrly4XzFrSiyORmXjNmjQ4mI1
         RcSmvLdaR/zIMaP0QB8/RK6BZO1/spPT8pjuIXy6Hbsxim0tIpI11wzgX4bE9Xwa0LXE
         dGo46fLmaWgUM1asirSzWUse+H+7wDLnZUlc47SzwRHakMzOg/CEpIBjjdRdTKsKFNyh
         HWwjeVsqd6UISleKatfeF1L5GL3JbMixLX8TYefO5mUvfOT+ryc9Fzkb+FBjn1UI+4cj
         WEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGxcoipwWUtIXq1n/IgG8Z+lNTNMbXErzkobqsYlE2I=;
        b=4Yf7KtL/3kpDGT/JNoe3ly68cbsv3y1vrvU02ui9cxVo4Ds2/mq44VS+0QFFW+5O9e
         1bCO71JZj3pOxfWeb402qHv+6iY97eyETCvZ467vjw2ZAuHG2/LEkq03Hd7WPndCRXKi
         bAkqxk6NM1s7Ow/TnDneSWyOaAczMq4ZvLdPvtspzoDV/OKr0Ai2VKj7yqG/fC6UJYET
         ApBST1GXURmJgKx7LDt9BUOPUsxKvYy9SeWSKfCC+QeUGQcbrmqCkNmReDrArQ15uL64
         3TAIZ3j1LxSrb+MS0bKjyHHxyznnl2JF6kXVNlkAyqxwQHDqQ4EF8DbIIWS/DBBUq6Ft
         8KzQ==
X-Gm-Message-State: AOAM530lz3G44g/C6amgrHBMkl/Xobpmy6tjAso8KU1e0YXFPslQWVnl
        OFIXyd6GdLlWFV7A+cX04Y8NzpyqDs+f4nBLxbw=
X-Google-Smtp-Source: ABdhPJxDLmrDgN9dtgESqgY2iKUAgV+F+PFUJT9r2kvBTNB7UCTm3ZWMqb2uVl7rs9oHR5y83T6q39jD8xIUTXxNtkk=
X-Received: by 2002:a05:6602:2b8e:b0:5e9:74e7:6b01 with SMTP id
 r14-20020a0566022b8e00b005e974e76b01mr19051650iov.127.1649878091766; Wed, 13
 Apr 2022 12:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648049113.git.andreyknvl@google.com> <YkV6QG+VtO7b0H7g@FVFF77S0Q05N>
 <YkWg5dCulxknhyZn@FVFF77S0Q05N> <CA+fCnZeQ6UnpM9qEQ4q5Y95U3XVwrsD-g7OX=Qxr1U1OR_KCsQ@mail.gmail.com>
 <Yk8wbx7/4+9pMLGE@FVFF77S0Q05N>
In-Reply-To: <Yk8wbx7/4+9pMLGE@FVFF77S0Q05N>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 13 Apr 2022 21:28:00 +0200
Message-ID: <CA+fCnZcv6PtR5eT-hbJ54hkH7Kr+CUM4DU2S5nbU4Lp2OnG8dQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] kasan, arm64, scs, stacktrace: collect stack
 traces from Shadow Call Stack
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
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

On Thu, Apr 7, 2022 at 8:42 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> I'm afraid from local testing (atop v5.18-rc1), with your config, I still can't
> get anywhere near your figures. I've tried to match toolchain versions with
> what was in your .config file, so I'm using clang 12.0.0 from the llvm.org
> binary releases, and binutils from the kernel.org crosstool 11.1.0 release.
>
> I took baselines with defconfig and defconfig + SHADOW_CALL_STACK, with console
> output completely suppressed with 'quiet loglevel=0':
>
> | [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -s -k ~/kernel-images/andrey-unwind-v5.18-rc1-defconfig/Image
> |
> |  Performance counter stats for
> |  '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
> |  -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
> |  /home/mark/kernel-images/andrey-unwind-v5.18-rc1-defconfig/Image -append
> |  loglevel=9 earlycon panic=-1 quiet loglevel=0' (50 runs):
> |
> |        0.512626031 seconds time elapsed                                          ( +-  0.26% )
> |
> | [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -s -k ~/kernel-images/andrey-unwind-v5.18-rc1-defconfig+scs/Image
> |
> |  Performance counter stats for
> |  '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
> |  -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
> |  /home/mark/kernel-images/andrey-unwind-v5.18-rc1-defconfig+scs/Image -append
> |  loglevel=9 earlycon panic=-1 quiet loglevel=0' (50 runs):
> |
> |        0.523245952 seconds time elapsed                                          ( +-  0.18% )
>
> Then I tried the same with your config, without your patches:
>
> | [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -s -k ~/kernel-images/andrey-unwind-v5.18-rc1-andrey.config/Image
> |
> |  Performance counter stats for
> |  '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
> |  -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
> |  /home/mark/kernel-images/andrey-unwind-v5.18-rc1-andrey.config/Image -append
> |  loglevel=9 earlycon panic=-1 quiet loglevel=0' (50 runs):
> |
> |        1.994692366 seconds time elapsed                                          ( +-  0.05% )
>
> Then with your config, without your patches, with the stacktrace hacked out:
>
> | [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -s -k ~/kernel-images/andrey-unwind-v5.18-rc1-andrey.config-nostacktrace/Image
> |
> |  Performance counter stats for
> | '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
> | -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
> | /home/mark/kernel-images/andrey-unwind-v5.18-rc1-andrey.config-nostacktrace/Image
> | -append loglevel=9 earlycon panic=-1 quiet loglevel=0' (50 runs):
> |
> |        1.861823869 seconds time elapsed                                          ( +-  0.05% )
>
> If I use those number to estimate the proportion of time spent stacktracing,
> with the baseline SCS number discounted to remove the hypervisor+VMM overheads,
> I get:
>
>         (1.994692366 - 0.523245952) - (1.861823869 - 0.523245952)
>         ---------------------------------------------------------  = 0.09029788358
>         (1.994692366 - 0.523245952)
>
> So roughly 9% when I try to maximize that figure. When actually poking hardware
> and doing real work, that figure goes down. For example, if just using "quiet":
>
> | [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -q -k ~/kernel-images/andrey-unwind-v5.18-rc1-andrey.config/Image > /dev/null
> |
> |  Performance counter stats for
> | '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
> | -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
> | /home/mark/kernel-images/andrey-unwind-v5.18-rc1-andrey.config/Image -append
> | loglevel=9 earlycon panic=-1 quiet' (50 runs):
> |
> |        4.653286475 seconds time elapsed                                          ( +-  0.06% )
>
> | [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -q -k ~/kernel-images/andrey-unwind-v5.18-rc1-andrey.config-nostacktrace/Image > /dev/null
> |
> |  Performance counter stats for
> |  '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
> |  -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
> |  /home/mark/kernel-images/andrey-unwind-v5.18-rc1-andrey.config-nostacktrace/Image
> |  -append loglevel=9 earlycon panic=-1 quiet' (50 runs):
> |
> |        4.585750154 seconds time elapsed                                          ( +-  0.05% )
>
> Which gives an estimate of:
>
>         (4.653286475 - 0.523245952) - (4.585750154 - 0.523245952)
>         ---------------------------------------------------------  = 0.01635245964
>         (4.653286475 - 0.523245952)
>
> ... or ~1.6% time spent backtracing:
>
> FWIW, applying your patches do show some benefit, but not as drastic as I was
> expecting:
>
> With console output suprressed:
>
> | [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -s -k ~/kernel-images/andrey-unwind-v5.18-rc1+scs-unwind-andrey.config/Image
> |
> |  Performance counter stats for
> | '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
> | -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
> | /home/mark/kernel-images/andrey-unwind-v5.18-rc1+scs-unwind-andrey.config/Image
> | -append loglevel=9 earlycon panic=-1 quiet loglevel=0' (50 runs):
> |
> |        1.920300410 seconds time elapsed                                          ( +-  0.05% )
>
> ... down from ~9% to ~4%
>
> With console output merely reduced:
>
> | [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -q -k ~/kernel-images/andrey-unwind-v5.18-rc1+scs-unwind-andrey.config/Image > /dev/null
> |
> |  Performance counter stats for
> | '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
> | -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
> | /home/mark/kernel-images/andrey-unwind-v5.18-rc1+scs-unwind-andrey.config/Image
> | -append loglevel=9 earlycon panic=-1 quiet' (50 runs):
> |
> |        4.611277833 seconds time elapsed                                          ( +-  0.04% )
>
> ... down from 1.6% to 0.6%
>
> Given the above I still think we need to understand this a bit better before we
> consider pursuing the SCS unwinder, given the issues I laid out in my prior mails.
>
> My hope is that we can improve the regular unwinder or other code such that
> this becomes moot. I'm aware of a few things we could try, but given it's very
> easy to sink a lot of time and effort into this, I'd like to first get some
> more details, as above.

Hi Mark,

I'm about to publish v3, where I'll include a detailed description of
how I measured the performance.

Perhaps we see different performance numbers because you're using
KVM-enabled VM on an Arm host and I'm using QEMU on x86-64 host.
Although, it's suspicious that the difference is so drastic. I'll try
to get my hands on some Arm hardware in the next few days and do the
measurements there.

This new version also will not be making any changes to the entry
code, as these changes add unwanted additional slowdown. That would be
great, if you could check the performance impact of v3 with your
setup.

Thanks!
