Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646D449CAA3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbiAZNVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238021AbiAZNVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:21:09 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B7FC06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:21:09 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id v186so71395843ybg.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/DQCsSrclDcPgukdfJmqMYc2FHF+ucTlOk9l5yysxdo=;
        b=s/jNuDnMoMgSiVhZkZ2izZzEkXx+xTvq1CGAgAOdccZ9h1zOsDzPux/wbckvVcYY+O
         7f4AOQFo+YegtmW4+Bo33iAq8KooWngaos9FL3vX2g2OqCRWliwwCK2jd5qtptjL8IJ+
         tjlnPfhzAq7+/FvqmxOzOu0yVfhXsPvwIU+1QU/HIztSSZDdxxF9FMCXzDVfJm0t2lID
         r8Jv2gMtqwZcYZmpv2wM5+KqIOwwxsV4dgxZ4OR+r89dWkJUckqs4NNwGWZ2vycOt/vd
         Sk94qu/U71fMfRRWCECXXURDaF73lu+9stAoLx//Sje56Imxr2z1dtN8galGEPselGs0
         S6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/DQCsSrclDcPgukdfJmqMYc2FHF+ucTlOk9l5yysxdo=;
        b=Rd480jNY2YHw8E+bA3iwZRhASx3EU73SSZhqXK5ZSDaH9ZOsaIx7whUZF8OA3QYJn7
         8+Ln1h0XojXjZWLV3mxLZcRAVVaAgUTgG7gW0oe2TAsHFQVx24WVD/dlKTiQX1cksT0j
         htdwVNToKlVuT3ZLe+mGn6Y2gNORSgwglh00A2cUFWnci8FTGPCMxIj6r+J0mmUAXkiI
         /zOZU8w5Le0ig84f6JRvyID5aSWigHaD6zqvbyxnsKJXvmnClwNF4xsg1l+tDh7squQB
         0FepcqRgj+KfE4Z2+iS2D4p17uCKnzr99khq+o2DG+2UBMguwYgABRZzM4cssGklsiwf
         0mTg==
X-Gm-Message-State: AOAM5332aGzGGToeTwzF5wUUCB9JCH5IZ1IaLGmF1QYsZZuYMHhWKrjc
        XiEnaGsCZt4F++1IIv0C9QTHeNTBcEvEfSbkuxuFfA==
X-Google-Smtp-Source: ABdhPJwMQReQbTv7H6IYr5LH1GhV4zrLlHg3ltxaW2/ufgMc90M52sUEXvLAR6I+OPDn4yP3qDpB16Rwdq+bVCbLDSc=
X-Received: by 2002:a25:4284:: with SMTP id p126mr38031991yba.108.1643203268445;
 Wed, 26 Jan 2022 05:21:08 -0800 (PST)
MIME-Version: 1.0
References: <20220125155253.051565866@linuxfoundation.org>
In-Reply-To: <20220125155253.051565866@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 26 Jan 2022 18:50:57 +0530
Message-ID: <CA+G9fYtuVwJDP00JH7Yk_8FepzAqZCbDsDqfRMya-RFsLLq7-w@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/155] 4.9.298-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 at 22:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.298 release.
> There are 155 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Jan 2022 15:52:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.298-rc2.gz
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
* kernel: 4.9.298-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.9.y
* git commit: e1c2457686e464dfae1bf551bfdd70d6862ce2d6
* git describe: v4.9.297-156-ge1c2457686e4
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.y/build/v4.9.2=
97-156-ge1c2457686e4

## Test Regressions (compared to v4.9.297-158-g12144c253dc9)
No test regressions found.

## Metric Regressions (compared to v4.9.297-158-g12144c253dc9)
No metric regressions found.

## Test Fixes (compared to v4.9.297-158-g12144c253dc9)
No test fixes found.

## Metric Fixes (compared to v4.9.297-158-g12144c253dc9)
No metric fixes found.

## Test result summary
total: 68582, pass: 54953, fail: 476, skip: 11264, xfail: 1889

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
