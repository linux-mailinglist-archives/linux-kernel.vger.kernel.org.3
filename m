Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35ED46E376
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhLIHtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:49:21 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:54925 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhLIHtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:49:21 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MtOT0-1mhPrY3WIA-00utx2; Thu, 09 Dec 2021 08:45:46 +0100
Received: by mail-wr1-f43.google.com with SMTP id v11so8087856wrw.10;
        Wed, 08 Dec 2021 23:45:46 -0800 (PST)
X-Gm-Message-State: AOAM533zVpHpOkrulmlQznt3UpEyJmMVY5ijE7xVElBw+i2yXnjAEltp
        8Laj/yhvu+H/1S796FJ5UFi5dE+0TFlqIO71TWc=
X-Google-Smtp-Source: ABdhPJy97hcdhDzB0ZZuC766TNriU5+YGxr1UxnyqspMCvNb+wDJIZH2WBY4AXOy4gCRePgUFYH4z/KfUsEtf0tj1rE=
X-Received: by 2002:a5d:4107:: with SMTP id l7mr4538439wrp.209.1639035946415;
 Wed, 08 Dec 2021 23:45:46 -0800 (PST)
MIME-Version: 1.0
References: <202112082057.C993DC6881@keescook>
In-Reply-To: <202112082057.C993DC6881@keescook>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 9 Dec 2021 08:45:30 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1wsa1makDonP8xdbMt5Tc4rU2a_4LDfXLpSp9+uFd73w@mail.gmail.com>
Message-ID: <CAK8P3a1wsa1makDonP8xdbMt5Tc4rU2a_4LDfXLpSp9+uFd73w@mail.gmail.com>
Subject: Re: question about all*config and COMPILE_TEST
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:A6s//GqMFrdshu/Cwjo4T6b7QU/Pj8O7UW9TqPIByvUetgUrJ18
 jeA2rUJ5tRTFlN3KIDez86R424tU0SFBFZxQ5uOamuD4dk/EKFVXa13kD81CXprf/4n8ghh
 2XuH+HDYbAgelfsgLS+l9GqsQkoAVAqTJvkUJJK8hg247GJwVo6BZ6Yo8TSuT7eeeYKQKcq
 kJCO/Anct2MWKflXF4FRg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pM4SBZvEWJA=:qY7t0EjGAvi6geaBDFSEl3
 SLaom5nPH1FqIT+yhhjPae1J2OKDYpDM3reXZHZNq1ODzklyphobwhUT2wXIOf/x6JmewyZ/c
 Wlg0mKbU6r7+VUA5G3qzZiVfsFZHZ/AuzFO4vImwn6cqi/l0JSI3o0hgaKWp6QAVJvCjfR3i/
 RHijDB/334nH1g2ioyKZ15eNK4d83cqg6Vg8C3oIZl8g38BGfWDxEpIn4r+jYRTWL4m57sngb
 oxja3OiRpScSkHuz3DQ1ghAznyOv/e1SXxfxegYhG4l1E+RzUcbyVNce1clMtVkLTyxxtLF0C
 12dAtHJpGHq41gmDOOza0YsB+cj/ZXznmO6809gUEtJv8beC+3KUz3ritTtlbRJRelLNsNOi+
 nGZo+3acqg96mCnTe8LRtz5P0JNTcUIDPld9Hs01sWsBUxaR3sKPIZT3CbI71xx/amB3NS32K
 Swl95mWJMxBc9WQrplX3A9V3vNrKHWDhCqGF51cxva0yAw8KarvTZn2GyLMWqZ8yLYMBtJOOz
 dFXBwtoEbv+a8SxQYLQE4LzKTnFVLKBUyaoUYFfFcGU3pd5d89p4X5Bx6xX2ytaewoMXRQw8o
 h5PSsTL+ZXi5uP3Jrx7iAsus3Tx8UdfkXLvGo7gffVbWvXzVPTdOWAqEpnF+wWc/EYB8ZDWrX
 rTngEdhiuePs5IVLNE4qtDFiHkTJ5+VcRG6Z9ni9Pf9AyLYb51LUYd/WnR95tuEIoFRU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 6:07 AM Kees Cook <keescook@chromium.org> wrote:
>
> tl;dr: is there a way to force a config default to "off" under
> all*config builds, but still leave it configurable? (i.e. not "depends
> on !COMPILE_TEST")
>
> I'm trying to understand a Kconfig behavior with regard to
> COMPILE_TEST. I'm able to use an "all*config" target, followed by specific
> additional config changes (e.g. turning off KCOV), but I can't enable
> things like DEBUG_INFO because of their "depends on !COMPILE_TEST".
> Whenever I want to examine debug info from all*config build I need to
> patch lib/Kconfig.debug to remove the depends. I was hoping I could,
> instead do:

This would be a minor hassle for my randconfig testing because I really
want to have DEBUG_INFO disabled when building randconfigs in order
to keep down compile times. I could however just force DEBUG_INFO=n
the same way as forcing COMPILE_TEST=y at the moment.


> I then thought I could use:
>
>         default !COMPILE_TEST
>
> since this works:
>
> config WERROR
>         bool "Compile the kernel with warnings as errors"
>         default COMPILE_TEST
>
> but I think the above is a no-op: it's the same as not having
> "default COMPILE_TEST" when doing an all*config build: it'll be enabled
> not because of COMPILE_TEST but because of the all*config pass.

Correct. One trick that works here is to use a 'choice' statement, as those
still honor the 'default' value even for allmodconfig -- Kconfig has no
idea which one of them is the 'all' version.

> How can I make DEBUG_INFO configurable, but default off under
> all*config?

I'd try generalizing the "DWARF version" choice to offer 'none' as a
default, like

choice
       prompt "Debug information"
       default DEBUG_INFO_NONE  if COMPILE_TEST
       default DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT if DEBUG_KERNEL

config DEBUG_INFO_NONE
       bool "Turn off all debug information"

config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
       bool "Rely on the toolchain's implicit default DWARF version"

config DEBUG_INFO_DWARF4
       bool "Generate DWARF Version 4 debuginfo"

config DEBUG_INFO_DWARF5
        bool "Generate DWARF Version 5 debuginfo"
        depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM ||
(AS_IS_GNU && AS_VERSION >= 23502)))
        depends on !DEBUG_INFO_BTF

endchoice

        Arnd
