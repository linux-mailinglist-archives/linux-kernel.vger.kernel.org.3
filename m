Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852EA47D6BD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344697AbhLVS1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236475AbhLVS1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:27:33 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0EDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 10:27:32 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id x32so9149237ybi.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 10:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QJClJoOTl1ARv5tnKdMN0rMx96zafbI3qCWhIbJDc30=;
        b=w0ugai6Dn8XOEPvRxQYilxGR3zY2XfFm7+jDms/cPqf3izF+PROHQ14QCZ3O7BlD83
         wMjIX0eulhNbDoaezo3ZgHhCMa1XPQRpoAbZHbQYdCkQnqV6NP7mpb1g4vkMDKuzQENL
         mXZk8jJTeU/6ZkhgybkB1BrChMNxQzdiDftU7UuMj/nepmUe9//FO2xhS+Bb7GseViJv
         8uxM65XNXoB9J8kIhPUQYqQffsyRaLs6TnIDoGeskiGJ++fTtaUPqS0MQloANgPgRCxW
         PQASh94wj7TX/Sz5yqZ3TmY9LA2i8MqA4bguI0aFUcjWxdU+sp/TCBFiuITh8U5dksjE
         F3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QJClJoOTl1ARv5tnKdMN0rMx96zafbI3qCWhIbJDc30=;
        b=EfzO4vHPCCLXlPr7298jP5Z+21QuWl5YPHcHCAJE6d+mVCbaYRWz08t+qgoMe+5OJE
         nK7ULG+zkSC8lZGE84IEbYhjLZai5Ms+612vlTwXBENM5AuKXVTQJUNqxW5KCHsr/69k
         xhPb41Y++V+tyftE3A5COB2WBdmydY6/NfSEVLYIg34M1ajvVDr6t4itXaEMgno2xE4Z
         6SXjebtwQtK7L8i/XPVmRN/VPJE37epgySRLH6c43wAKWOSopUwtdMbdwMaCpyrLDkEx
         1jxITzDvdqIgOysWa5kQU2TmnfWk5BZnJfDJYgqbivyIgqjo1JBp15MkSwHmYQDgBzar
         ndYA==
X-Gm-Message-State: AOAM531whTwFeYo1A2PLBybxzAf4wtPzRCOZIZGbfJnPUh/HQczMWJ2x
        ScINrmwPNtWkBBRHekeKmF5lDX6o65nn+SlxLJ9R/w==
X-Google-Smtp-Source: ABdhPJwYGC9HHg23pilOsMA2c3TNq8h63uaodL6Mek/QLEVhBnePq19ow/BNUMK7ibcrZBIpI33mOf9azEORPMhN4zQ=
X-Received: by 2002:a25:d68e:: with SMTP id n136mr6521994ybg.520.1640197651952;
 Wed, 22 Dec 2021 10:27:31 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 22 Dec 2021 23:57:20 +0530
Message-ID: <CA+G9fYuz1Bfkfga7xVPVdTLETBQK3=4UsXq15kZW8C85DhyXJQ@mail.gmail.com>
Subject: [next] arm: current.h:53:6: error: out of range pc-relative fixup value
To:     llvm@lists.linux.dev, open list <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please ignore this email if it is already reported ]

On Linux next 20211220 (and  20211222) tag following arm config builds failed
with clang-11, clang-12, clang-13 and clang-nightly.

Build errors:
-------------
In file included from /builds/linux/kernel/sched/core.c:10:
In file included from /builds/linux/include/trace/events/sched.h:8:
In file included from /builds/linux/include/linux/kthread.h:6:
In file included from /builds/linux/include/linux/sched.h:12:
/builds/linux/arch/arm/include/asm/current.h:53:6: error: out of range
pc-relative fixup value
        asm(LOAD_SYM_ARMV6(%0, __current) : "=r"(cur));
            ^
/builds/linux/arch/arm/include/asm/insn.h:25:2: note: expanded from
macro 'LOAD_SYM_ARMV6'
        "       ldr     " #reg ", =" #sym "                     \n\t"   \
        ^
<inline asm>:1:3: note: instantiated into assembly here
                ldr     r2, =__current
                ^

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


meta data:
-----------
    git describe: next-20211220 to next-20211222
    git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
    git_sha: 2bd48302750c652889a2604b3df8b591c1d3af08
    git_short_log: 2bd48302750c (\"Add linux-next specific files for 20211222\")
    target_arch: arm
    toolchain: clang-11, clang-12, clang-13 and clang-nightly

Build log:
https://builds.tuxbuild.com/22doqqkr5uM1RUG67iJevPNL9nQ/

Regressions found on arm:

  -  clang-11-vexpress_defconfig
  -  clang-11-shmobile_defconfig
  -  clang-13-at91_dt_defconfig
  -  clang-13-lpc32xx_defconfig
  -  clang-11-omap2plus_defconfig
  -  clang-12-allnoconfig
  -  clang-13-imx_v6_v7_defconfig
  -  clang-11-mini2440_defconfig
  -  clang-13-imx_v4_v5_defconfig
  -  clang-12-multi_v5_defconfig
  -  clang-13-mxs_defconfig
  -  clang-13-ixp4xx_defconfig
  -  clang-11-lpc32xx_defconfig
  -  clang-nightly-s3c6400_defconfig
  -  clang-13-nhk8815_defconfig
  -  clang-12-imx_v6_v7_defconfig
  -  clang-11-nhk8815_defconfig
  -  clang-12-ixp4xx_defconfig
  -  clang-13-footbridge_defconfig
  -  clang-11-tinyconfig
  -  clang-11-axm55xx_defconfig
  -  clang-12-bcm2835_defconfig
  -  clang-12-davinci_all_defconfig
  -  clang-12-omap2plus_defconfig
  -  clang-11-at91_dt_defconfig
  -  clang-11-multi_v5_defconfig
  -  clang-11-s3c2410_defconfig
  -  clang-11-footbridge_defconfig
  -  clang-12-s3c2410_defconfig
  -  clang-12-mxs_defconfig
  -  clang-12-omap1_defconfig
  -  clang-11-defconfig
  -  clang-11-omap1_defconfig
  -  clang-13-orion5x_defconfig
  -  clang-12-orion5x_defconfig
  -  clang-11-davinci_all_defconfig
  -  clang-12-lpc32xx_defconfig
  -  clang-11-ixp4xx_defconfig
  -  clang-12-mini2440_defconfig
  -  clang-11-u8500_defconfig
  -  clang-11-integrator_defconfig
  -  clang-13-davinci_all_defconfig
  -  clang-11-mxs_defconfig
  -  clang-11-orion5x_defconfig
  -  clang-12-tinyconfig
  -  clang-12-footbridge_defconfig
  -  clang-11-imx_v4_v5_defconfig
  -  clang-13-s3c2410_defconfig
  -  clang-nightly-bcm2835_defconfig
  -  clang-11-allnoconfig
  -  clang-11-exynos_defconfig
  -  clang-11-keystone_defconfig
  -  clang-13-mini2440_defconfig
  -  clang-13-integrator_defconfig
  -  clang-12-imx_v4_v5_defconfig
  -  clang-13-multi_v5_defconfig
  -  clang-13-omap1_defconfig
  -  clang-11-bcm2835_defconfig
  -  clang-11-imx_v6_v7_defconfig
  -  clang-12-at91_dt_defconfig
  -  clang-12-integrator_defconfig
  -  clang-12-nhk8815_defconfig

steps to reproduce:
-------------------
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.
# Original tuxmake command with fragments listed below.
# tuxmake --runtime podman --target-arch arm --toolchain clang-11
--kconfig at91_dt_defconfig LLVM=1 LLVM_IAS=1


tuxmake --runtime podman --target-arch arm --toolchain clang-11
--kconfig https://builds.tuxbuild.com/22doqqkr5uM1RUG67iJevPNL9nQ/config
LLVM=1 LLVM_IAS=1

--
Linaro LKFT
https://lkft.linaro.org
