Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95114E3B38
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbiCVIyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiCVIxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:53:51 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B053C7DAB4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:52:23 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id v35so32369628ybi.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5OnjMBLlbvRbvv+3aIDSt0yxuBhGgt3SeL4lCokMVc0=;
        b=HqHS5EFGH9lESEq4hRyF/GGtJKNhYMIih2ulM92YN4ejK4sK472Zh2+gvdHB2pXZR6
         Igc5wlDQs0IyeGFFh0SYJ7RvhhFtcJfGXmxY+EbfMeTJ6Vz71f9spZGXsuPlfCWgxeXT
         FJ4YHDSBXSFPAB7e7/CDnbwjtvT5ISW2wWbohSGTMrgMvQ6oJ5wG2WhZ0cRG5voOAZ4B
         s+GH1zdFe5WrsOSB4KU5pPgdniBzNIC1JZQPdufAamyIUJ8qkwtJs/42swHaJiSR5SRt
         6G1ytDvpaI2cXqxECMGeR6pmIXUmB9OwXJL44XWcHJSI11tYIG+b829q1WnqsX/SdPU6
         JYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5OnjMBLlbvRbvv+3aIDSt0yxuBhGgt3SeL4lCokMVc0=;
        b=SX6s2UJopAaTJEpmGPVmWNhDSu8a6U7efJ8Na9ajmury/vUP1JlQ6ODur3bqvJNMQV
         e5Cb70f+rZXWatAeP2z6FNUxODo9VfDQxabNP7fRbD7I6e9Ik0d29/2UCPne/xPhJA9U
         UQxIq/h8eZ9XAgbJHb4Y2MbPE3Vw+nTR/GWIuHGKkhlad37d0R/RBaK3avtX3/kS92U5
         nRFN0Bk9E/5V+2Nlr88Y3HgDvFDvnXSnvW/Dz3rj1q+7vmjznPLRIsNt22Aue8Gx0op9
         nhhmHjdMO1ze+AU+WcI1/a/0DPDKogSQ0lAmUGzzITB0fKg1srjZSa2WYJsklIpG3+mw
         dTDg==
X-Gm-Message-State: AOAM530Cn9bs5+8djQI2aZy2U1zvmI24EeTKw4FtxvuxK0lc/TgntgJ5
        Alkvf2MYpxbuXuRVyEJNQoVgdAi+4++zOTCV+S9cOw==
X-Google-Smtp-Source: ABdhPJycIzBquJSPZj+acxtzOPTBwFUkvS8nqVaq7upuzG6k5qUJHnzdnzgRtzDMX36M5/yj1bv6Nyw8FuytOWdalLE=
X-Received: by 2002:a25:548:0:b0:633:81bd:e319 with SMTP id
 69-20020a250548000000b0063381bde319mr27177014ybf.603.1647939142760; Tue, 22
 Mar 2022 01:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220321133221.290173884@linuxfoundation.org>
In-Reply-To: <20220321133221.290173884@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 22 Mar 2022 14:22:11 +0530
Message-ID: <CA+G9fYvOdH-pHg=swAZX0+N+Wb-p5yhjmfhoQNdP-LjycsGjuw@mail.gmail.com>
Subject: Re: [PATCH 5.16 00/37] 5.16.17-rc1 review
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

On Mon, 21 Mar 2022 at 19:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.16.17 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 23 Mar 2022 13:32:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.16.17-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.16.17-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.16.y
* git commit: 578d4cc6b1572323d2f71bf43fa891b000a62087
* git describe: v5.16.16-38-g578d4cc6b157
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.16.y/build/v5.16=
.16-38-g578d4cc6b157

## Test Regressions (compared to v5.16.15-29-g3782384411f0)
No test regressions found.

## Metric Regressions (compared to v5.16.15-29-g3782384411f0)
No metric regressions found.

## Test Fixes (compared to v5.16.15-29-g3782384411f0)
No test fixes found.

## Metric Fixes (compared to v5.16.15-29-g3782384411f0)
No metric fixes found.

## Test result summary
total: 106594, pass: 90505, fail: 1196, skip: 13865, xfail: 1028

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 296 total, 293 passed, 3 failed
* arm64: 47 total, 47 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 45 total, 41 passed, 4 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 41 total, 38 passed, 3 failed
* parisc: 14 total, 14 passed, 0 failed
* powerpc: 65 total, 50 passed, 15 failed
* riscv: 32 total, 27 passed, 5 failed
* s390: 26 total, 23 passed, 3 failed
* sh: 26 total, 24 passed, 2 failed
* sparc: 14 total, 14 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 47 total, 47 passed, 0 failed

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
* pre[
* rcutorture
* ssuite
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
