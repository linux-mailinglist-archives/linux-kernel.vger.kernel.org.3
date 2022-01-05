Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C966484D06
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 05:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbiAEEEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 23:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbiAEEEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 23:04:08 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB17C06179C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 20:04:07 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id p15so63774375ybk.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 20:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oiaN3sFcuNyQdW3zfyuwpWWfN5HDP1MtXt5q1o38Ozs=;
        b=FpfliBY5lv1Fghoqw5T8ZV3e4qLr9mDVP3vR2d0GNAg3BbK0rlSsfZLyV7gCqYCQ6t
         bY3/ReAEy3+/8nbZlnIRqY/E9svRfko3JzOv6DKhBW+heWN7wqIctqvV4KjP341QJ+ao
         3Q8X168elQao5MOsbcB9siRH4WGUXNTzknY/I055Oix37ueqYECI3bJrpNsc2h/3jmbM
         ci23R1sSGnSkiX0QW4gryaof9qyCXrYwrJY48cYg3bm4YDd0VTGL8JJGXIBcvot1WFQs
         KyPXX4S9KItMkCvDkGn1nn/lKkenHX/x84/XF1VWEaNf2ueR1x/TuNArxdFMTlSV6G9y
         qXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oiaN3sFcuNyQdW3zfyuwpWWfN5HDP1MtXt5q1o38Ozs=;
        b=ORYT29Sr1twHYLBRrqXlJ+5schm9VyyP3wFJyJzi3VUTC/XKdcav/Ch6y4GhpSnvY1
         S2A0pJYGD5cDLL/iE5Qb0M30+06YwjPkZIavfFNE4JP22RapsrGMHSTp4+4qbXbvaNAk
         r6Fu4dYbktKGjC9M5ITMHwvKJrIhyNlYSDB2LprXOubGD4GisOfXZFQHuxUGX7Ig/tyx
         Z1l9B/QX/Tn96brrox6FyEk4H/w0uSLTcJRPFgLcnGkG5I0jUU3Z/2pxmM9n5ctvt6pS
         1bv70WZE1t6A0IU7b9qonVnGTwz6xLJl6vCJjBDNN5koXoLb+JCSH4+JAfOiWzC/BCvD
         BANw==
X-Gm-Message-State: AOAM530YYmuBfqdTosPP9ZCB5weVgJn5i0SBC4Z1lEeqRJcZZf3Xttjx
        uJOagrpfdJoJYSXiwoxew05MNgOtQxYC+ULvNdudsQ==
X-Google-Smtp-Source: ABdhPJyRDzmDW+1OlWUfGgkVweY4O0t/u7Viz50i+R2HlpzHqXF8a8trXi0YKu8T/osFJtFjhQFO9IJY695Iiebs+1I=
X-Received: by 2002:a25:b981:: with SMTP id r1mr59322189ybg.520.1641355446478;
 Tue, 04 Jan 2022 20:04:06 -0800 (PST)
MIME-Version: 1.0
References: <20220104073841.681360658@linuxfoundation.org>
In-Reply-To: <20220104073841.681360658@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 5 Jan 2022 09:33:55 +0530
Message-ID: <CA+G9fYuc88=cOeWCFH=L7viUfMnbOtZes8QZhUGYt2vTe+z4=A@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/47] 5.10.90-rc2 review
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
> This is the start of the stable review cycle for the 5.10.90 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 06 Jan 2022 07:38:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.90-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.90-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.10.y
* git commit: c129f56d557cf846b92dce951459e64c1374a0c6
* git describe: v5.10.89-48-gc129f56d557c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.89-48-gc129f56d557c

## Test Regressions (compared to v5.10.88-77-g44b3abecd41b)
No test regressions found.

## Metric Regressions (compared to v5.10.88-77-g44b3abecd41b)
No metric regressions found.

## Test Fixes (compared to v5.10.88-77-g44b3abecd41b)
No test fixes found.

## Metric Fixes (compared to v5.10.88-77-g44b3abecd41b)
No metric fixes found.

## Test result summary
total: 91050, pass: 78088, fail: 544, skip: 11639, xfail: 779

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
* powerpc: 52 total, 46 passed, 6 failed
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
