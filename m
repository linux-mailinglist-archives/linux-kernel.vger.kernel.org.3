Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F0F4A5864
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbiBAISI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbiBAISG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:18:06 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFD0C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 00:18:06 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 23so48387871ybf.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 00:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wt8jiZyIXTJbpOxSu6w4uaEC9Ik5r4n/TDKnlHuv+jk=;
        b=NxNQLnagXFaBwNNxLCcb99CO57GG6ah69ujpeprpHDec4gT9Y/8ZiML0XkRjsUHGt4
         nF7XbJp8jk/sk9Tz+uIXrKt4r23ml4TfSkQtB/U410Gl9wjicQDl4zDeDa33l7HHMbVJ
         tUY5K3ep8nbtpcD2QeajcVxb1WFU9v0Gcmg74PeU3A297oH7j7SB08bBaoDWjO5CKFVA
         GnEOaO3FjfR8Rxo3RG3OQw93FgMxZDnSDEM+r6oUyTB8D16ZnmGXunblFU5AM8FOzB38
         ap0IGjUbyxTPs7EayadDDYgViXhZ6lfkH3IQ6yiGurPwYYYk2SRdFc4eiccSo24B/9mA
         GUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wt8jiZyIXTJbpOxSu6w4uaEC9Ik5r4n/TDKnlHuv+jk=;
        b=t+LVURJasPuyexlHptPjVeg0OUU2M5TyIEAQX3sUsrr5BmFqiRom0t7Cs1ED0XXVzD
         PV/YM76zE+NgUE1YcyOkuOygkiVIbyFy9MaPEaKJG1GfG8fjhiKqCd3+VBSJ2tVygYc8
         WUpPnaeqruKNgJ8bo4LLVjZoU2/o0Ono4DKDAogv2naKWKGRhRisPM3QIcO8cG5gYEJI
         Cx4rSGi1Ax6jz1mBN3jRNSuo6qEmsuWxupPAA8vbftw6H8Dwh9OjB/P/Rja/B6pq5lNQ
         1RmobFBnUJrcfIIM9eAKcWdiAhUbrT0poINXUwt8CGVx9GXUPM5F5ClRkuwU87h9rIx2
         VVxw==
X-Gm-Message-State: AOAM5333SLozogDS+i17SOPUPfxNGG9XqNB3NTzxaHVB7YNLrcI7rupm
        ZiTO2A+10MWmGySPMv/0v4TuoESrwtqm3GBaSrBXoA==
X-Google-Smtp-Source: ABdhPJx7bd8dx/WXe4rl7f4P0ubRYmxQthZHe5kLvw1tydiVONW43HcQ96sFs3AMYfD0hY7QMeWVdtQKwZKn9Jksh1M=
X-Received: by 2002:a25:97c4:: with SMTP id j4mr36098404ybo.108.1643703484663;
 Tue, 01 Feb 2022 00:18:04 -0800 (PST)
MIME-Version: 1.0
References: <20220131105215.644174521@linuxfoundation.org>
In-Reply-To: <20220131105215.644174521@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 1 Feb 2022 13:47:53 +0530
Message-ID: <CA+G9fYsKNUkX8Jc3cyj5VXh9VTrunLSovKwvDJ6gaxSTdWkT+Q@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/64] 5.4.176-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 at 16:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.176 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 02 Feb 2022 10:51:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.176-rc1.gz
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
* kernel: 5.4.176-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 67819ded87b7d993487007bb528aa90c522a5671
* git describe: v5.4.175-65-g67819ded87b7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.1=
75-65-g67819ded87b7

## Test Regressions (compared to v5.4.175)
No test regressions found.

## Metric Regressions (compared to v5.4.175)
No metric regressions found.

## Test Fixes (compared to v5.4.175)
No test fixes found.

## Metric Fixes (compared to v5.4.175)
No metric fixes found.

## Test result summary
total: 93844, pass: 78468, fail: 772, skip: 13562, xfail: 1042

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 258 total, 258 passed, 0 failed
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
