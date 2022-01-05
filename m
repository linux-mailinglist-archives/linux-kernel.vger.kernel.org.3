Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E8B484CF4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 04:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbiAEDwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 22:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiAEDwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 22:52:54 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA78C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 19:52:54 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id w184so94239016ybg.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 19:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VwMkxyFB+wxbntKQbtMzpTU3b0qwadl5dP+G+kE3EOI=;
        b=LmM/vDcFAPfeMBplp2rvL0nVkTR62rVAMXWLT+Qxjbq6hcss0QMOuMrHpTbmA3O+n/
         2dIPTn84Nbh0JQg7b/yGGqYV2pohwHIuoxhI5iqXDOwhOAzvG2Osq4eAYjUpbMzqL1Ee
         y2T+v6zaYextzxMLbdZVqbV1B1dMVU/H+VbfOoOpWhLJhAb3guPUEOnn2AftctAari9l
         gF5yM4QSiy4vV/GygU5EEgCV190eKHAoKs83AZvMNaetLFnyrEpNNw+scls29MfID/Lc
         to9uu8bRrtZ3tnuka6FUOGsZ/9PavIL8vHFHcZ206d9lGA26JqJhOXZ6V+XIrzk94lYz
         pzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VwMkxyFB+wxbntKQbtMzpTU3b0qwadl5dP+G+kE3EOI=;
        b=dnS1SJuduNqLDa/x9UMSYsFOIDaIx2BbpqkwYjxeCcPu/2UpHAXQxzH7GE04BURrcd
         EHhKe9b7UogIywrMYs2nKzRl38dJxWJe+JLoC/1ReRMjX6vF5lxNrpd0vWgoKiVLUccC
         5f5d1XUiLAJN57TslPzK8reu/kfcUU6FIb+eVqkARNdmgDurUG4QS8DVJVuLpn4oyYG3
         +5Wr4Bb24Ql5QSK7FmUl+8NB4c0IV0a7X1VGNXftIL4sBsOH31CG/2EamUcQkwS4gOTn
         q1H/pLZhePmWRcy+de22BORY1vuuVwHLeZZYWpfRIHm649Fvt1p4AdsT+RbnawzxklYs
         RfYA==
X-Gm-Message-State: AOAM531mkwM5s9qYjyfBV1cSor1eqXLdyANrQKTkpGTKwVyCWxBEuNtp
        CoCdwQ/CbxOlDosiurBdwDrOLgMXQuW9vZYmmZ6rBg==
X-Google-Smtp-Source: ABdhPJy9Mcgx7MF6AcIF2bXlpelt7WYskLr28sI5FEQmIvBa3SdMrDgBoZhU+KuX7hVSmaIWFQ/NFv70oDKEP8Z6b/s=
X-Received: by 2002:a25:8008:: with SMTP id m8mr12358309ybk.704.1641354773645;
 Tue, 04 Jan 2022 19:52:53 -0800 (PST)
MIME-Version: 1.0
References: <20220104073845.629257314@linuxfoundation.org>
In-Reply-To: <20220104073845.629257314@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 5 Jan 2022 09:22:42 +0530
Message-ID: <CA+G9fYso7RZ-Z=7Q4UjXCuYfdxijvP76JT7Yfsoqc7wVjTvw8A@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/72] 5.15.13-rc2 review
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

On Tue, 4 Jan 2022 at 13:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.13 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 06 Jan 2022 07:38:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.13-rc2.gz
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
* kernel: 5.15.13-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.15.y
* git commit: 2e05ea9d1c9a321bc00be4d8bd8ebbd58e5421e4
* git describe: v5.15.12-73-g2e05ea9d1c9a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.12-73-g2e05ea9d1c9a

## No Test Regressions (compared to v5.15.11-129-g47b0c2878802)
No test regressions found.

## Metric Regressions (compared to v5.15.11-129-g47b0c2878802)
No metric regressions found.

## Test Fixes (compared to v5.15.11-129-g47b0c2878802)
No test fixes found.

## Metric Fixes (compared to v5.15.11-129-g47b0c2878802)
No metric fixes found.

## Test result summary
total: 98217, pass: 84033, fail: 724, skip: 12624, xfail: 836

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 259 total, 255 passed, 4 failed
* arm64: 37 total, 37 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 36 total, 36 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 34 total, 30 passed, 4 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 52 total, 48 passed, 4 failed
* riscv: 24 total, 16 passed, 8 failed
* s390: 18 total, 18 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 37 total, 37 passed, 0 failed

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
