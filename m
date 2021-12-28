Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E823F480BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 18:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbhL1RMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 12:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbhL1RMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:12:18 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98C3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 09:12:17 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id i3so41261917ybh.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 09:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WgqjyI/J3ILOaJ13M0HGU79CiTkoeJiqtgDqGj4/gPU=;
        b=GfCRjEqSLDxyPzWFddn1Qd6Rq9Lry7K3RD+x2HKInpPEpBhXTMedfmUK44iY0jXoQy
         SBJNyksPMhdv0MAmI2MZKgLuP9hehAmybpVnY5tZfs+6vyOMW/C0cC37Z7gIMWM2QopS
         TZGM4lkGXFQwBm+bVwfO7OBvCQ/BOr1FCj8takjqes7EUn+T2Xrm6L8paGamuR8/B6X7
         lnCSIo79ZDTFkjWnOsQ7srKSFNYQKM/peJefypE6wu+fwmIJIagYa/Eww+wnICQAY3IX
         JK3KAF36bWEyqO9pspwbCyjpI9gITAT4kLYfd8YGPX7v8AuBBi9iMnkiQpNgm+VOhroN
         YSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WgqjyI/J3ILOaJ13M0HGU79CiTkoeJiqtgDqGj4/gPU=;
        b=nGhEW/uegUD11xqaiGno2G2AW/APG4zjF6iTXk0bogKHCzRazrFX01Oex8qQgta+GB
         wjmW5SNWYoVXSp2iKIQ6/vdEjykQsuwmA11Go20XjlCIbmrTFmAvQ1tfucdmanJAg45W
         Ap8qOnDPEUUU+zgsQ2KemnTX4XyPFjSGFtr03ChewyE9O89jCcbWRfib1dKURcZmQtKR
         OpazGcA57Ti1gq9ypbT7RMeG/9nOWj1zHoDbBZzj6MIMW1730VCmmOEB3z11ESQoUmeg
         4DcnK6+LtHGY5vMw7INtvq4R0EtqcFXAMANqqqR/Yzlev5F3Dtss8qSNseNNjoSofn9t
         XKQw==
X-Gm-Message-State: AOAM532R/YVJ+AlFtVu3UOcOu9k0+T5qWrdF/wCHp4nLjiiAgTfPwom0
        WTOvqwOI8GswoX9zbLtPw3cLb9q13Lbn5FibzyyBTA==
X-Google-Smtp-Source: ABdhPJy8SX4rDSjRpIn6DXWb2AU6MuZPMtJvT3tcZ+ypTeDwhOvbrPOa27qNaw9DjQBGTM5GQkDrMNMUlBdMCpStXaI=
X-Received: by 2002:a25:d57:: with SMTP id 84mr11909368ybn.684.1640711535629;
 Tue, 28 Dec 2021 09:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20211227151316.558965545@linuxfoundation.org>
In-Reply-To: <20211227151316.558965545@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 28 Dec 2021 22:42:04 +0530
Message-ID: <CA+G9fYtSFOqCT00Or6mPr0fuxu8yAiWgpJfn4hJ4iqbcrZ5Btw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/19] 4.9.295-rc1 review
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

On Mon, 27 Dec 2021 at 20:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.295 release.
> There are 19 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Dec 2021 15:13:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.295-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.9.295-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.9.y
* git commit: 73c20036320022109af2aa90d0f199c06f5cabee
* git describe: v4.9.294-20-g73c200363200
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.y/build/v4.9.2=
94-20-g73c200363200

## No Test Regressions (compared to v4.9.294)

## No Test Fixes (compared to v4.9.294)

## Test result summary
total: 75882, pass: 60437, fail: 509, skip: 12713, xfail: 2223

## Build Summary
* arm: 254 total, 226 passed, 28 failed
* arm64: 32 total, 32 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 19 total, 19 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
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
* ssuite
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
