Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB874D615C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 13:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348487AbiCKMPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 07:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbiCKMPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:15:32 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1561B184B7C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 04:14:29 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id u3so16749985ybh.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 04:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UnVkBPV1SX1nVDc6ltU2unfW33kklQXn4ioC7ZkVSBo=;
        b=v516Y2J7e6UCITrjVszgQinoqUDDo8GIvdaidFK4kw1SEaP5b5Z0WOwt9Wg/Wh2Tmj
         15xY0ymh3qBIWIjshmympikhBgGCVAek0l12TxkJxRKtRqndHfSakKz7Rr9nqZUy/BQo
         NBntemtf4AeEC05WJq9oBlZYoE03N/jzE4q5GioKj6I2d/OhcQdo6wHjkULtcWsbnmSn
         HoRBtiNBCVGJKfAJ5QXrbExxNEaSOdo8hjZKfTbYZAUXWiuRBfNvSTQJorUCetEeMKCX
         eWKjmF1dI46qEReuAHLy8A62a8mG27XadXl8FQoEv+kHdW7Ge/Lb/RMT0cpjLHxcyn05
         iSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UnVkBPV1SX1nVDc6ltU2unfW33kklQXn4ioC7ZkVSBo=;
        b=HDE0WvvkVB0bsdnFfD73SIPlrwbGCr/fsGAPsbSGouBX9ZF3rwxbzH8RdiHX/AiCEL
         YuPlzdZPbiF0mv87AyAU3XQYFtWbGmn73GATIjI/YzaACYQgg9Pfu+lTGXWWRuXC7aqc
         l+BkOXM7IU1SIz7eU8fWHQjEWRa5PEeiSS4tJCxorR10Pobh7Qo8VLx4xtQWx8LTZ5wL
         ggzRFl1vjFKbbCB9AkUYB+JjwBI0ZpbFeIG5yJg5rPGQikX6BHqWSZ3DydQT78XT3XgM
         GZoBeQmPg5Gg7WGmguF+WRL4+LuVmrMRw+Bafoztwvl60j4OL6fbuH+ynKdV0TUpOP2m
         TsxA==
X-Gm-Message-State: AOAM533/IPupf8azMfATwzWgOxM/tTWg2YH0icltgcYREbMrSO1b2sFu
        6G0dyMghEmJ0a5G3zfCeLD8RrqXxqK/nSm5z1CHdrQ==
X-Google-Smtp-Source: ABdhPJzAvkNm89SWSRX51l/dfsvL4nRPlJqSoWvXWO0Gfx3jmrcY0YV4aWBR51/eWrNealZ4mzM2dj15D2Yc7FNhO6Q=
X-Received: by 2002:a25:da91:0:b0:628:aa84:f69e with SMTP id
 n139-20020a25da91000000b00628aa84f69emr8323298ybf.603.1647000868103; Fri, 11
 Mar 2022 04:14:28 -0800 (PST)
MIME-Version: 1.0
References: <20220310140808.741682643@linuxfoundation.org>
In-Reply-To: <20220310140808.741682643@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 11 Mar 2022 17:44:16 +0530
Message-ID: <CA+G9fYtmeDK4zQz=+0SVtZhgH6h5Vw3bUkCAa94p2TGj6euWew@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/33] 5.4.184-rc2 review
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 at 19:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.184 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 12 Mar 2022 14:07:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.184-rc2.gz
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
* kernel: 5.4.184-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.4.y
* git commit: 10576140d9ea54d852c159b209bcaae2c80203e7
* git describe: v5.4.183-34-g10576140d9ea
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.1=
83-34-g10576140d9ea

## Test Regressions (compared to v5.4.183-18-g706b33173b11)
No test regressions found.

## Metric Regressions (compared to v5.4.183-18-g706b33173b11)
No metric regressions found.

## Test Fixes (compared to v5.4.183-18-g706b33173b11)
No test fixes found.

## Metric Fixes (compared to v5.4.183-18-g706b33173b11)
No metric fixes found.

## Test result summary
total: 93554, pass: 77446, fail: 1136, skip: 13510, xfail: 1462

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 295 total, 295 passed, 0 failed
* arm64: 46 total, 38 passed, 8 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 22 total, 22 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 41 total, 38 passed, 3 failed
* parisc: 14 total, 14 passed, 0 failed
* powerpc: 65 total, 50 passed, 15 failed
* riscv: 32 total, 27 passed, 5 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 26 total, 24 passed, 2 failed
* sparc: 14 total, 14 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 46 total, 46 passed, 0 failed

## Test suites summary
* fwts
* igt-gpu-tools
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
