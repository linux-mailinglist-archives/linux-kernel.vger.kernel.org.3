Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575CC49FCBB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348753AbiA1PWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347367AbiA1PWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:22:06 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4717C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 07:22:05 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id g14so19391230ybs.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 07:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=c0bMUQoFH3ZTxFaTaemDlxzYbHvdAzHC2nzZEJKopYc=;
        b=vOtjAj3afwTNgPbxyhcR3Hfa+GiQ6QAsRxL8xr40RJ9lRbkH/grIlYw1SelsmfpJ/b
         vgkR2VWtRWHZZ6a2Y6Bw1Qc7Q8Aj8FvQerJai8zazSoDMWrYkCVlgnh/xESHKdmbV603
         gtV3LTBuUGk5k+n14VWKg+sm/piMtA6rXQTdEYbcZ/cIAwb9EJ/+e/hrGxxvHiCc7dRx
         C9jQsgLwi90iBnAvP81FuVXUTsYKv5cHk1sHLThjG4goI8z77BFIpdxakkSfoFDz8Gv5
         wbkiW2nGzCJ5q/yCHz6/OSuuPS2VF+hCwgsN5PrmhlfCzljhhppEPOQ+WST7M+J2+aAj
         or/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=c0bMUQoFH3ZTxFaTaemDlxzYbHvdAzHC2nzZEJKopYc=;
        b=5Asv/I0Pu9M+yAPRB89a+NJKLc1CVWgduLkiTgp4lqCtWAjkJqFIYcdX2/YR8eoNMM
         p9sqcaildT7lKAAiSQdFrtN0EJka0A4vAxv5zrt/lCvUyJSu6eE4do40T6px2KnWvAcP
         PaFNMYwXrwhL4pcejBv7UzRHglG/WWGvI0IWmNvTD10GOZZVmV52eG0BzugWZefL/ebN
         w44pYJtstZ2FKT4cdeBu6bMakq2dA1b4HKjc0MDL6vJqSyBGFuP4XCLdRuolAkxR5DZ3
         I+S9bO/mUV9opX1htWP0jjd69Cqk6RRX+JrgeuYmzXdqUN7ACN0SaE2I1xlnGOjmfDDG
         CrrQ==
X-Gm-Message-State: AOAM532MKlW8NuNXgDpt7GXxoc/xvz+1gI0X3WjLM/XP5ukVdG/RrPji
        zHtz6i2ZFbnFWD8XYBb2VlVTmK+gltZIcH/bmY1URkvWA7NQ7A==
X-Google-Smtp-Source: ABdhPJyphE2C6kSYX+SJNpMHAuwxAeeAyukV8u13NW0rzBM5OZMDKVkzogZfLgT1QJ8jq3/Djm6d7uzMgiDcMawR6YU=
X-Received: by 2002:a25:5143:: with SMTP id f64mr14250846ybb.520.1643383324177;
 Fri, 28 Jan 2022 07:22:04 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 28 Jan 2022 20:51:53 +0530
Message-ID: <CA+G9fYvxxc4o5UjRfHVgmcaTN1ijxXX8e=OTP4t7PbRENmVBsQ@mail.gmail.com>
Subject: [next] arch/arm/kernel/setup.c:1028:63: error: 'SECTION_SIZE' undeclared
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        rmk+kernel@armlinux.org.uk, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build errors noticed on Linux next 20220128 arm with tinyconfig.

make --silent --keep-going --jobs=8 \
   ARCH=arm \
   CROSS_COMPILE=arm-linux-gnueabihf- \
   'CC=sccache arm-linux-gnueabihf-gcc' \
   'HOSTCC=sccache gcc'

arch/arm/kernel/setup.c: In function 'reserve_crashkernel':
arch/arm/kernel/setup.c:1028:63: error: 'SECTION_SIZE' undeclared
(first use in this function); did you mean 'SECTIONS_SHIFT'?
 1028 |                 start = memblock_phys_alloc_range(crash_size,
SECTION_SIZE,
      |
^~~~~~~~~~~~
      |
SECTIONS_SHIFT
arch/arm/kernel/setup.c:1028:63: note: each undeclared identifier is
reported only once for each function it appears in
make[3]: *** [scripts/Makefile.build:289: arch/arm/kernel/setup.o] Error 1


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

meta data:
-----------
    git describe: next-20220128
    git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
    git_sha: b605fdc54c2b28c30ef06d9db99282d8a32ae4be
    target_arch: arm
    kconfig: tinyconfig
    toolchain: gcc-11

Build log:
-------------
https://builds.tuxbuild.com/24JPvTrXx7HvkQtxoIXqZtZoZkA/

Steps to reproduce:
--------------------
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.
# Original tuxmake command with fragments listed below.

tuxmake --runtime podman --target-arch arm --toolchain gcc-11
--kconfig tinyconfig

--
Linaro LKFT
https://lkft.linaro.org
