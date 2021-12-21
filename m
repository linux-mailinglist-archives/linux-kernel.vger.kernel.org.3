Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEA747BDDD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhLUKFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhLUKFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:05:39 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783F4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 02:05:39 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id q74so37073749ybq.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 02:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zr2LbzYCrnUoXuyIDVQwepsxk5PD2yejg/uyiGeNKl0=;
        b=ZTuP0a29kR3/xc1Ti2zajpO+IX62ETuegpcrPnPEE98mmBiLLMD1ZgkJ/+ncDq2s5B
         ocqM4xhCaKNmFUScgriydLQifo8t7fTHO+G+vHQQs4ymfc1izWDovSSDkSxhuvIl71qQ
         mawkR90X6rCkIefhcAEJAqTEfyZ2Ewev66+vL2Vq6vRL36swF7dGPWgwwYI0vnWMjTiA
         giH+71b4qmEY/UNDuQiWGzznbvqdElWLq3dUBEvbueOgDut+Ymi/UJJux4h4muVfvQdC
         G+HEq+AodlaUVUcDzilh7ZYyHShHcL9u2YvHGIGXMD50J+8TSUKPwCrwnBpqqOK6uGzJ
         fEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zr2LbzYCrnUoXuyIDVQwepsxk5PD2yejg/uyiGeNKl0=;
        b=30PZj9mpyfNwXnitQfZntCtWMm7wd+00t+La4BOFE0/Mydr8q6QUAt0WELDowg4yVQ
         eK6G6E3z0jFaw02T369nCxfs1XMngZoughSZwyE7qsuEINzktn5PTx5xbS28iQuLaCc8
         mvWdgGm4iGyw6wGRi5zkzmC71oqLRzEILogdP0PZTaUzTTnacb4DgDew4vsB0fZ8coxt
         5B5wzU+1PHm/iZ1D+BgwnvcpDD6h0GynrfUbG8PvKlguIKlrUYxalRa1TnwNYcfZeC6q
         mDIEvg9LKJ125N8lqOB865x+T5RRtdZ6iRpj3FFDtSLZ5++n7ZyDFN641ofiRvT5OpPw
         JxIw==
X-Gm-Message-State: AOAM531SKvf6WIaH41aEcOoFXcNL+GFQ2tu7uR20dOD8+eEqDxYUduOt
        5SldQr90Bi70fq6Zw8IJ/rCFCBczszEcdDscgJ50CA==
X-Google-Smtp-Source: ABdhPJzTIu7QAqeRWEpdvfqc1ft7n+V3kZl4AEsQJEzAVsOqO8ftZ35A8K7EeSDBvN6UG37+qnRMo348MsHgGyG9PdE=
X-Received: by 2002:a25:d68e:: with SMTP id n136mr3722113ybg.520.1640081137286;
 Tue, 21 Dec 2021 02:05:37 -0800 (PST)
MIME-Version: 1.0
References: <20211220143040.058287525@linuxfoundation.org>
In-Reply-To: <20211220143040.058287525@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 21 Dec 2021 15:35:25 +0530
Message-ID: <CA+G9fYvuCZEcjMMXOdbDpGjKpiEZkWkMozzYUqkJ_YmNbJOzgA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/177] 5.15.11-rc1 review
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

On Mon, 20 Dec 2021 at 20:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.11 release.
> There are 177 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 22 Dec 2021 14:30:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.11-rc1.gz
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

## Build
* kernel: 5.15.11-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 6c3eb74f1432213bade7ca82a6a7638d1ad826a5
* git describe: v5.15.10-178-g6c3eb74f1432
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.10-178-g6c3eb74f1432

## No Test Regressions (compared to v5.15.7-171-ge18bff95c819)

## No Test Fixes (compared to v5.15.7-171-ge18bff95c819)

## Test result summary
total: 99084, pass: 84368, fail: 937, skip: 12857, xfail: 922

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 263 total, 257 passed, 6 failed
* arm64: 42 total, 40 passed, 2 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 40 total, 37 passed, 3 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 37 total, 31 passed, 6 failed
* parisc: 14 total, 14 passed, 0 failed
* powerpc: 56 total, 50 passed, 6 failed
* riscv: 28 total, 19 passed, 9 failed
* s390: 22 total, 20 passed, 2 failed
* sh: 26 total, 24 passed, 2 failed
* sparc: 14 total, 14 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 42 total, 40 passed, 2 failed

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
* kselftest-lkdtm
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
* rcutorture
* ssuite
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
