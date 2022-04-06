Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F914F60CF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiDFOOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbiDFONd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:13:33 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C575C584C71
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:15:38 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id y38so3173350ybi.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 03:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aGlYozd/u0p+alDYCmgtZVDQtB4EX/1Tk30HxGGPobs=;
        b=pIutILDmfbfBS8Bf8yziDEp5NJ48RV5jCQQ/UovICb6waLboX1s/S/sBT9MinxAFcZ
         szGpV3w1jR2qJuYykkiYAFGMcDmcVuKsQenK0EfzgkNe5mlL5HVEsOaIBd6dizkT+l+z
         ZXnb63dmZNn//Be19R6LliDUpKQ4j7F/DxHwzVSWCPtUIfjKFU+TYHF29Kxhs/HaVY74
         aRC0+AJfXzcA6ZwJZchNWOGwLLoATfV9TqoPOy+ARX+B8nPGdefjjvHTsApw3F2PJsCC
         fjXvFA3nDeAcU4xaMq3+n+yIvvBqP84aTG5lH4QK1DYe8gCgFywnf1k6nWffsz8mS3Rp
         g4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aGlYozd/u0p+alDYCmgtZVDQtB4EX/1Tk30HxGGPobs=;
        b=Q+/czXbYPKLrU68hZMvaI3ioPpMvHLscKqhWorI1N6KvhhurxrtO42BD8i1kJylLBv
         rUO1CJebPwiL8tlzfSbplUU4bOUV2x9rZrLBi92htMaHYYUP4M6xA90tefXRGvxAVFfs
         S5O+B+gY3yC33dJVR5aJWolRqyU2iBZ82RkcsfBdDfv/NtUOK9a23Ftwrp/BeANFnO1a
         SH+XsOGxpVtWG+DfUcC0xsEI7f/x7fRXhv75qgP+LnPaNRHkyTXzVvkZRTaibNh2f2Kp
         /9s4a1Sjdm1TJ56X9DpPJXzRY6LWJJoXvdLjg5+Ey3k89kJlhB9y7pyyYGkn4r1VVYfF
         Gd1A==
X-Gm-Message-State: AOAM5314l9k1BrkS/PtM4tfYdI9kANn11S+JOtaJyuFibblgwPJR1Lsm
        Ug6reXSGPeb/3ARKniwNkL/3j0RtS1cnpJ9smiySsA==
X-Google-Smtp-Source: ABdhPJwWGczytXLXaFe0awziXqKzgrA3L+DnLVRUhBhfQZDOp9WwBMyGYgLlsRpyBuLb44w3Fae5khIPEGtqroP6XpQ=
X-Received: by 2002:a25:6e85:0:b0:63d:b37a:3d3b with SMTP id
 j127-20020a256e85000000b0063db37a3d3bmr5585013ybc.128.1649240117389; Wed, 06
 Apr 2022 03:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220405070339.801210740@linuxfoundation.org>
In-Reply-To: <20220405070339.801210740@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 6 Apr 2022 15:45:05 +0530
Message-ID: <CA+G9fYuSPtAB1xxGepBzmKa7ZFq9QR3Nk6RfhfU5vNhXGpTECg@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/913] 5.15.33-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2022 at 14:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.33 release.
> There are 913 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Apr 2022 07:01:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.33-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
Anders enabled extra kconfigs to reproduce Shuah reported build regression
and proposed two additional two commits for the fix.

## Build
* kernel: 5.15.33-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.15.y
* git commit: 841880eaff92b260de5b0fe749c05c6371bcc78c
* git describe: v5.15.32-914-g841880eaff92
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.32-914-g841880eaff92

## Test Regressions (compared to v5.15.32-902-g1a1c2efda160)
No test regressions found.

## Metric Regressions (compared to v5.15.32-902-g1a1c2efda160)
No metric regressions found.

## Test Fixes (compared to v5.15.32-902-g1a1c2efda160)
No test fixes found.

## Metric Fixes (compared to v5.15.32-902-g1a1c2efda160)
No metric fixes found.

## Test result summary
total: 101817, pass: 85899, fail: 973, skip: 13901, xfail: 1044

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 291 total, 291 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
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
