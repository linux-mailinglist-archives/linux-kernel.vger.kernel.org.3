Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119BE473C64
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 06:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhLNFXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 00:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhLNFXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 00:23:32 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5115FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 21:23:32 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z5so59807401edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 21:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TV0uUbmxxDHZYjoS8P/dMM3E90EuJKs5tADXJuoy4Ts=;
        b=xwb/NEcfWpwo4WyiAVK0HXZX3nEdVjJszIYYEw1V2sA3JSabLA4fPB8JJ3e2OjVzQW
         ZWxU4YQov9BmH1vRSXnYFZoYWfIHhl7BwUoGTMpRID60oo7+WfJwVUQf86DtTgqGwyZB
         KOYR9IkMFNMNBNjCVVln0qq9bivsClrunUrcSE+p80ggmJEdjJIbBwcEwSMA6i99BY11
         vngaYud3CycloGQeG9gSm+YwM2AXv7Y5RzucjsI96Zd1M/k3vfC01YBTxkBGwN4i0sGt
         +57h6rZjeotTRTuwOWxr46NhQeFgWYTPiGDoVTeJxI0ulsDEXCJJk25ozb8i6/e7Gv0s
         IEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TV0uUbmxxDHZYjoS8P/dMM3E90EuJKs5tADXJuoy4Ts=;
        b=Ixtm/SQ9qBHutvr0/mj3Ru/yml9h3hBu4k1iW1aKhMBDeQc2TUOhK+GkpFlDDSi+xQ
         iFTXM2MdGFlwCWW1PuI8FpV4tZ5RzAeUnbeqgu63dt6i95069yyma/rYyotghRs3KyC5
         xqGkV1u7qRrUJwjKBvcWYVL7WD/eyeZBIeeRnOPXmf4CVAGa0H0Idkk2IfztoJZkKxVN
         yl10TuOPRd4KwvvtWWTUfAA4waYHN1QKKTtxEv08Lkj0jh5sKKwosjwVHjYXu7Q5iSbi
         GHwUU3QW487IBhXn3p0aOI3no3/9tJW7KooDKaQHlX9v8GqVcK9n2T41uz5RoLmKp/Tv
         0IxQ==
X-Gm-Message-State: AOAM532TjU5o9Pj7w14TKUruwrLg1v+NfVYvFfpu5f15Sj+lqq+ayV/T
        5H+/WuEac8kccQdxtMPF+5ShM4n4RvzgxrDWzALw/AUOr63ULw==
X-Google-Smtp-Source: ABdhPJz/ycIbxOVPzEvsVhxVzLn6EXeUMUBVZJqt6Z9Ddjme8Jj4YX1nLkNlamg5CtQDaidbu4u4X33ZYNgDGPb9RU0=
X-Received: by 2002:a05:6402:4b:: with SMTP id f11mr4703456edu.267.1639459410651;
 Mon, 13 Dec 2021 21:23:30 -0800 (PST)
MIME-Version: 1.0
References: <20211213092928.349556070@linuxfoundation.org>
In-Reply-To: <20211213092928.349556070@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 14 Dec 2021 10:53:19 +0530
Message-ID: <CA+G9fYsEQCjOi_58WcMb4i-2t1Gv=KjPuWa6L792YAZF=zzinw@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/53] 4.14.258-rc1 review
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

On Mon, 13 Dec 2021 at 15:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.258 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 15 Dec 2021 09:29:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.258-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
Following warnings noticed on x86_64 and i386 with defconfig
building with gcc-8/9/10/11 and clang-11/12/13 and nightly.

make --silent --keep-going --jobs=3D8
O=3D/home/tuxbuild/.cache/tuxmake/builds/current ARCH=3Dx86_64
CROSS_COMPILE=3Dx86_64-linux-gnu- 'CC=3Dsccache x86_64-linux-gnu-gcc'
'HOSTCC=3Dsccache gcc' defconfig
warning: (EFI) selects ARCH_USE_MEMREMAP_PROT which has unmet direct
dependencies (AMD_MEM_ENCRYPT)
warning: (EFI) selects ARCH_USE_MEMREMAP_PROT which has unmet direct
dependencies (AMD_MEM_ENCRYPT)


build link,
https://builds.tuxbuild.com/22E1lTwjlXKmMoDPpESc96Cszdo/

## Build
* kernel: 4.14.258-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.14.y
* git commit: 5aef54c7f9c79b66de0fc4ee21754c4336cb927e
* git describe: v4.14.257-54-g5aef54c7f9c7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.257-54-g5aef54c7f9c7

## No Test Regressions (compared to v4.14.257)

## No Test Fixes (compared to v4.14.257)

## Test result summary
total: 76832, pass: 61693, fail: 668, skip: 12387, xfail: 2084

## Build Summary
* arm: 254 total, 186 passed, 68 failed
* arm64: 32 total, 32 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 19 total, 19 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* powerpc: 52 total, 0 passed, 52 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

## Test suites summary
* fwts
* igt-gpu-tools
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
* rcutorture
* ssuite
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
