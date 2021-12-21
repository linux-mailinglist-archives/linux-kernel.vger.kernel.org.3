Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E12F47BF21
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbhLULvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbhLULvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:51:03 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D5BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 03:51:02 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id j2so37869444ybg.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 03:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a06awDKQSOEG98bHBVWG7YUUV5YondbUAt9sRJqmTTk=;
        b=IN1Im2oH0vGdpenrB3PVjokdLWTDf4Wk/uLz7CaU2hddBSoKxNt5/mtsvFlpvriurX
         21DKwaqYammkhzZ2SzTtIsbT/xrllEp+2aRfT9YS0Dx5Nvh1dRKPZK1fAvK9GAMP+B5B
         CBrhO5h7fEdvCKUdfm/ndnD2hxt542YIy4vFcfBgV2BWix8kJe8rim5u1jwAijxyKBDn
         Rgp43NkdGguvMdxn8CG2Oapn5TxnB71Aw0P0aRyOQEwzqeIdplCrZWIjK5zYHZQrd18p
         GEM/lcqeyLrkB2bHqeWdG2XjnkFgyCyRjCWO/hydJQxGibmuS7qSuF0SZNtIwhNdXMbP
         WfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a06awDKQSOEG98bHBVWG7YUUV5YondbUAt9sRJqmTTk=;
        b=P1uhHi2oWcelFA2zz41DJA5h7UNvgC6cfYYQZbh1YPdA3EBrFbVHF6tErowbq13QvI
         C1ALolJCX+1q29STC99+gYOgIN1tE9J0BsP+00V1NhPrElcmLvZchm7Za0HEMfVmxQUv
         zos6uaHW5S1KkHYEPtT1pfcNY5E03E0DgD1zEQ56S5eFf0H89p4R4DzGzPB9QoE13tpR
         8IzKhhGjDhN4tUUYWB4GckTkVGk7dWu0QlPQ35eMjSF5grUB06q+82PWz8iydJzWAPEz
         elnI9+GkywhcO4ojSxqwOjg/Y03pr1dn4ENaEX/AC+afWGF2V0FlLPtjAnbCrvQq6Za/
         Uq3g==
X-Gm-Message-State: AOAM530ZEAVeRLT8pTA1TpuXxcM7P5SjKa2fEJi43UD6YAzpF6krOS3x
        EUKEoMugv0D4rSnb69SlI9M+OCEq3mnN703VgzmadQ==
X-Google-Smtp-Source: ABdhPJw46OnfNLGquUzfBxXdbVd9s8BwjLMcvg/737/HNeGzj2nkNlRkYu8K7e2ou+SBKCHegTJ80OKFXFH5wXM+/C8=
X-Received: by 2002:a5b:18c:: with SMTP id r12mr3964066ybl.553.1640087461933;
 Tue, 21 Dec 2021 03:51:01 -0800 (PST)
MIME-Version: 1.0
References: <20211220143025.683747691@linuxfoundation.org>
In-Reply-To: <20211220143025.683747691@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 21 Dec 2021 17:20:50 +0530
Message-ID: <CA+G9fYt3k9Jofs6Mc+8S5uGFisiPDYz0H1PuyUhBs0YkcSRBNA@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/71] 5.4.168-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        f.fainelli@gmail.com, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, pavel@denx.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2021 at 20:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.168 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 22 Dec 2021 14:30:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.168-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.168-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 13335f539c375b976ffe3a79116239de6a54645e
* git describe: v5.4.167-72-g13335f539c37
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.1=
67-72-g13335f539c37

## No Test Regressions (compared to v5.4.165-19-g542c7817d093)

## No Test Fixes (compared to v5.4.165-19-g542c7817d093)


## Test result summary
total: 87950, pass: 73810, fail: 632, skip: 12412, xfail: 1096

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 258 total, 254 passed, 4 failed
* arm64: 36 total, 31 passed, 5 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 20 total, 20 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 34 total, 34 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 52 total, 48 passed, 4 failed
* riscv: 24 total, 24 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 36 total, 36 passed, 0 failed

## Test suites summary
* fwts
* kselftest-android
* kselftest-arm64
* kselftest-arm64/arm64.btitest.bti_c_func
* kselftest-arm64/arm64.btitest.bti_j_func
* kselftest-arm64/arm64.btitest.bti_jc_func
* kselftest-arm64/arm64.btitest.bti_none_func
* kselftest-arm64/arm64.btitest.nohint_func
* kselftest-arm64/arm64.btitest.paciasp_func
* kselftest-arm64/arm64.nobtitest.bti_c_func
* kselftest-arm64/arm64.nobtitest.bti_j_func
* kselftest-arm64/arm64.nobtitest.bti_jc_func
* kselftest-arm64/arm64.nobtitest.bti_none_func
* kselftest-arm64/arm64.nobtitest.nohint_func
* kselftest-arm64/arm64.nobtitest.paciasp_func
* kselftest-bpf
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers
* kselftest-efivarfs
* kselftest-filesystems
* kselftest-firmware
* kselftest-fpu
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-vm
* kselftest-x86
* kselftest-zram
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* network-basic-tests
* packetdrill
* perf
* perf/Zstd-perf.data-compression
* rcutorture
* ssuite
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
