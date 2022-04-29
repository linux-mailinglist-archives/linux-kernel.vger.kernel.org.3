Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755AB515685
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbiD2VRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbiD2VRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:17:34 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FE9D3AF2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:14:14 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2f7d621d1caso97558207b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HHiNWR4Gj+7WX0sCAUa6tn2uhhIucy+5z2qpTD06QQI=;
        b=JSHLmibei0jgkcWbPj9HXgdd+MhHC+OyPSKhuI2XV6AHUd3y3m296Nxh89oFkAvEVr
         gAOcLc8V+8EnUVsL20yuw8mVQN59JVIbjbWtowpSKuGn459PWbiqv0aOHp0eMpmS7/C9
         GIIUZdg+2wcbmV+RcHfAfaQjYxe3tIUZ1dkRZZXo2X12l9WF1hVT3HiSaXby6h/Wyv8T
         gWT+OXFy1d+ABcoA7M4M0UuVVzHoEeLgoryOnJ2ABJFPvGNg2GShgdXy0P148AVAwSxE
         osCh6JkPgoWtaMxXbuwuVmehGTQ4QFQyx+xal3y46aLeldq4DRLtclvp4LO4MWPXV1/b
         w7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HHiNWR4Gj+7WX0sCAUa6tn2uhhIucy+5z2qpTD06QQI=;
        b=4UXS1/QnoeZ4OvLImmTUov4ConQJGE6fVfoGP7Kds0iHtGK9R5kIXlAS69gPtMRQLi
         RuIx1qqAgVuzBuV0x4obt3Mtpb0lvkcIXOAOlzqmQ08g+VZ6JVRtFRWeTS/Xf6fhPktr
         PxoxtvRdzm8wIxr0r+9lC5DqXbwEASSPrke5a01GQ1bU2oqFtKvj2B++iiLoG4Dh5H5W
         fuLpXlynLd64Mi5RfhZhnRl+icRwS/lqa73Ico95hbuquIaCUTCNK113MIH9phBxWAU0
         6U7tAbNEv3zpQHphxYkvT0YKQbSKSxMAOgEeq7oJw4Q4oCHEfsj34cT2JxSHA70wrzpk
         zGaw==
X-Gm-Message-State: AOAM533KEUslzADSiMY8P8bIxkU5b3mwvEwZtnN+Mdd6vrq6+6wVlTFG
        91JNeO9B+QU3NF+FwBvNkBAeX/4inst+9CT/+UFjgA==
X-Google-Smtp-Source: ABdhPJxMEXOOz7/3ZcLI/C+SyN5tKSdtu6eoAlmQKG5g155dtcRnngUP4k9RCkDxyuI/1C3yeScBL5Tbp72EbYKfZWk=
X-Received: by 2002:a81:3ac2:0:b0:2f7:f777:a43 with SMTP id
 h185-20020a813ac2000000b002f7f7770a43mr1356235ywa.60.1651266853771; Fri, 29
 Apr 2022 14:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220429104052.345760505@linuxfoundation.org>
In-Reply-To: <20220429104052.345760505@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 30 Apr 2022 02:44:02 +0530
Message-ID: <CA+G9fYs4hjCbTE-OQjgXiGFVQ2dD4FW4-iSQV8aqHR57Fv06uw@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/33] 5.15.37-rc1 review
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022 at 16:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.37 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 01 May 2022 10:40:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.37-rc1.gz
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
* kernel: 5.15.37-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: ff3177a2b8b333ce1007cb22d7e2adafdcda9720
* git describe: v5.15.36-34-gff3177a2b8b3
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.36-34-gff3177a2b8b3

## Test Regressions (compared to v5.15.35)
No test regressions found.

## Metric Regressions (compared to v5.15.35)
No metric regressions found.

## Test Fixes (compared to v5.15.35)
No test fixes found.

## Metric Fixes (compared to v5.15.35)
No metric fixes found.

## Test result summary
total: 102673, pass: 87138, fail: 713, skip: 13898, xfail: 924

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 291 total, 291 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 39 total, 39 passed, 0 failed
* mips: 37 total, 37 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 60 total, 54 passed, 6 failed
* riscv: 27 total, 22 passed, 5 failed
* s390: 21 total, 21 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 41 total, 41 passed, 0 failed

## Test suites summary
* fwts
* igt-gpu-tools
* kselftest-android
* kselftest-arm64
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
