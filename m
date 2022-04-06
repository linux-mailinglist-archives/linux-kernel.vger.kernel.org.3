Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA5E4F5ADD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240036AbiDFKAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 06:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345042AbiDFJ6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:58:41 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A831D2517
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 23:26:18 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2eb543fe73eso15432177b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 23:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J+VJq0Ch2RV8datEtKffrP2BGCGcGG2IKlEbXzz13QE=;
        b=G4Pi8B7NI0TpkYGeXGhejMJYTsRrpAwlQvVGiOmrDW0hAg3qKpoQUfic/+C7u3CQ4V
         mnlQffgjQ8dSs3k45hB2pS659VsmuDWPQwF3w5cdLVKTG4gCdLHoO65cgcoTpoD8A7F3
         1M2UKKxtBdZkB0I2zSCwecAyS++7G15CzFtO8Xut7wWK31aBmoHLRNOgC5oNpUB720Hz
         YUgyMnxS2yX+z/rPNG/vqjMC93TJnVHd7tWstsXwJ5v38XVANySWoztzpINwhUhZ36R3
         Wd1axtsf+RXsptrMLM2g1ioMZi+4NCLFUMyiMcb/wSNDrbqX2BSnc9z3LRFCqjk+qK1K
         RIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J+VJq0Ch2RV8datEtKffrP2BGCGcGG2IKlEbXzz13QE=;
        b=HW3eYM/neF5ArhaVckMj698wr6f7h/U44uG9zVgJvkf7Rmbwgm675nf96sHTH54Tbs
         Yd9iYBK+BPgu4629gTcIBificgFfo4i66YN/EP20wiT6DtZhhRWw56u/EU1MXPI49evN
         pU9lcilloLiQyztW+1lmHj/Yzxyf9WIJdrmUQ6lzqldQoBRNV3pEhfxMgrc7fqPVnJFP
         cxVMGWBrn/Kwr6A++LUDBVP63pxfk2IneKDvh8K12nIftmWwCTj/9jK8I/rZpwHs4fGI
         UDfaDoOovXp8FNTW2D4newVW45gLHG1akRiq0WYxo32ig3E7NoQ+CyhjcLJL8TQ7HUY8
         fybQ==
X-Gm-Message-State: AOAM5328FzQWxO/ARo3rLkYCtbXsuEJrEMaa/xTTsB2oDxUsFDuxHfO2
        iZpOrPbUwafnqGDMfrPiLZuTf3UcfCaLMVnwFK4Bcg==
X-Google-Smtp-Source: ABdhPJw6Sqq3nwKvWfdkQgSA0iDvRDR0bPlF2GaPiNdgVATlhYliSRHllsXkrppjla6irlf7iNavcKQa7v8tlcWxnF4=
X-Received: by 2002:a81:e90c:0:b0:2db:d63e:56ff with SMTP id
 d12-20020a81e90c000000b002dbd63e56ffmr6136242ywm.60.1649226377788; Tue, 05
 Apr 2022 23:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220405070407.513532867@linuxfoundation.org>
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 6 Apr 2022 11:56:06 +0530
Message-ID: <CA+G9fYtJK7aaT6uyvZ3LEaCUDprSPPBVS87nTStAitCkg-UJOQ@mail.gmail.com>
Subject: Re: [PATCH 5.17 0000/1126] 5.17.2-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2022 at 13:09, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.17.2 release.
> There are 1126 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Apr 2022 07:01:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.17.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.17.2-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.17.y
* git commit: 9ffb4937f7d30ba53f0992a8ba66689cf60f967a
* git describe: v5.17.1-1127-g9ffb4937f7d3
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.17.y/build/v5.17=
.1-1127-g9ffb4937f7d3

## Test Regressions (compared to v5.17.1-1123-g290ba5383d2c)
No test regressions found.

## Metric Regressions (compared to v5.17.1-1123-g290ba5383d2c)
No metric regressions found.

## Test Fixes (compared to v5.17.1-1123-g290ba5383d2c)
No test fixes found.

## Metric Fixes (compared to v5.17.1-1123-g290ba5383d2c)
No metric fixes found.

## Test result summary
total: 97365, pass: 81969, fail: 2175, skip: 13221, xfail: 0

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 291 total, 291 passed, 0 failed
* arm64: 40 total, 40 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 40 total, 40 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 37 total, 37 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 60 total, 54 passed, 6 failed
* riscv: 27 total, 22 passed, 5 failed
* s390: 21 total, 21 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 41 total, 41 passed, 0 failed

## Test suites summary
* fwts
* igt-gpu-tools
* kselftest-
* kselftest-android
* kselftest-arm64
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
* kunit
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
* ltp-cve-test[
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
* vdso

--
Linaro LKFT
https://lkft.linaro.org
