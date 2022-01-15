Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472C348F560
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 07:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbiAOGFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 01:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiAOGFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 01:05:34 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868E5C06161C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 22:05:34 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id h14so29709604ybe.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 22:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MFKd1NMeRhJdc2PqUmcHN8SqvdFHWYCDyu0YQ8/dEjw=;
        b=mCHBeW1CwQTUo2/6VUM+8FjEK1eN7XXaBIfoCGhPzVW3rbrrtstBFMP1nBEMP8MILI
         Yu87oiohZlLIiRxIR2evP/ltkDjMs5R6k7RHMNJzZUB5hVwHi/NzNiP84WCjj/eHEFoY
         Zh/QBGhKuV+fpF+P7sv7z4WJK+YSBTuBWVAFFuOeROOcxhSIWruxIkdoY0VgrzlN9uls
         O3m8iVdShGvHWiKLdKufdkH3X+D10bus8hPh3bco9v7/fActPYz26SeaoOqYAWQch90s
         3fCj4zsSNrpMlGUTTXtCyoLnZDGMENAyNFF/6JyI0WPW0SwNFlAUhMBf6A5+LUsWbHvl
         +EjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MFKd1NMeRhJdc2PqUmcHN8SqvdFHWYCDyu0YQ8/dEjw=;
        b=oBQ22wGYXZ5YijZ8Q40+bSfLBi2eqtZBh92BnBB05EdFDsFUY4PSqUV9F4Si/5eeMx
         lHuhrJ1sXV57dK5HPyKEckTOxADcsfEELfr1knzr1l+RtfLaGw4K1lCwNwGgHzaEQoSU
         5PnQenyySs+1aud1mzEt96/1hsXS2+GE9j1eX8yz4qCRX9sWGL8EoHf+9c/J5qZSFle2
         Rz2ZNvR46zU7WFMW0q+JFKAXvPDgGbqL55jyiphtsrLQJj/N40v00SgaXCeZU9Hh8Kly
         xPEytdHHiGFXAGYq0Jnqd06uJG6b8iM4KryFEwkic0Zcxoq8XocnjQAC4VTwCa2JfOQB
         szdQ==
X-Gm-Message-State: AOAM532aBjWbQAZIH2rrvNiKg9poGVViIsUbkfiH9ssOMuWkNpgXoRK7
        6KZdjV+Tc9SVMX0pYIhmRuP/iz9QJBWRfkJHx0viJw==
X-Google-Smtp-Source: ABdhPJw++Voqovz5F2UgwjIoWum4oSPfFjT+Rna6cpbVjw/FsCvq8WehmVOmJlyGeoGYGh4IcOpJGB4sQt8jdbn5Q2Q=
X-Received: by 2002:a25:61d8:: with SMTP id v207mr13837804ybb.108.1642226733436;
 Fri, 14 Jan 2022 22:05:33 -0800 (PST)
MIME-Version: 1.0
References: <20220114081541.465841464@linuxfoundation.org>
In-Reply-To: <20220114081541.465841464@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 15 Jan 2022 11:35:22 +0530
Message-ID: <CA+G9fYttCE75au6-RePzyX5S_uTVNU7AX5r1RXu_v8cEAA8tMA@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/18] 5.4.172-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2022 at 13:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.172 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 16 Jan 2022 08:15:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.172-rc1.gz
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
* kernel: 5.4.172-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.4.y
* git commit: 8821fbf93a8fcee78fd7c2bde7674bf0e34adbf7
* git describe: v5.4.171-19-g8821fbf93a8f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.1=
71-19-g8821fbf93a8f

## Test Regressions (compared to v5.4.171)
No test regressions found.

## Metric Regressions (compared to v5.4.171)
No metric regressions found.

## Test Fixes (compared to v5.4.171)
No test fixes found.

## Metric Fixes (compared to v5.4.171)
No metric fixes found.

## Test result summary
total: 89637, pass: 74557, fail: 803, skip: 12819, xfail: 1458

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
* rcutorture
* ssuite
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
