Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0CE4E3C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiCVKim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiCVKil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:38:41 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F6B80201
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:37:14 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id l2so32824091ybe.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x6/91/zzXNBZAn/HehU3V1JqNB9kBJi7VDCHYFDiOOE=;
        b=wQbsWc+v0qUthPe8+sryBGJe0IoTmMm1K5pH2BQwDJFag3LPivxR5BNsRM9bDJ7T59
         5dTedS0yPFd0Qw3vucuO137pLOBL+3D/oL4Ruz8QYsS8H3RHiDb2RTCrUdwa2tPj0Ey3
         tCn725WpVsdHzkBNlicm481RsNfhDsKmpQcm4fkqtIMavwwUl3w3fU0HtTVZPSJtTkDu
         XEYe7PP+ywx8oeTY4sAVfg2RBeRCTfcCPkVAIBc6VpN1Uc2NbYsqGz/jfJ9uNrQpqZ8E
         cRR0r/A5H16UkkPRjokS7pkEg06PAP2MW5NEA7JyHDfi5olk34WgaUA+l+jlAErNvQ5o
         m5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x6/91/zzXNBZAn/HehU3V1JqNB9kBJi7VDCHYFDiOOE=;
        b=HfoW/bd74M/B+lNMNzJmoMBc1T/ZF7icOd9rpcK22bNNkwB3rsubOEwu3N1k95bPzZ
         eqhbnCj3JCVBmoB0lPn26a19IjiEMzefeSrlUHBLX86cB9GEffVeNUKn2gQhIkO23hOa
         +aZVDspy4rCxTqkYoBxf9plpYJRfgLrZPMOnz866F0Try6o1kiG/hAZzi4MoDbDqEEIa
         IcPa3jFEOqd7NF3r0bcmBonxU20dyBwO1hy/bFh0evoBJ4Js1LcV06rMQuUCydBD3sHs
         7GrlupTXFioY83p2iNJ9PPkBMQ6d/Amw2cHOxUBtSksHIpZ4WeKKQAowzLE0aO9sJtf/
         LiOg==
X-Gm-Message-State: AOAM533YHkoVmVBSQ0B1bjcQ4FdyUCuVySoo+y5iH3gpOq7qZDAkp+zF
        mFpKcVutZpu09ZAaOs7BchtNj8mVGNrV+LATPXYxvg==
X-Google-Smtp-Source: ABdhPJxwCQmhIbn5P9G/jzsHrcF6HXN4peb6aVWIWJD+ycwF8cvwZuLc/hGPa5KfIJLt4Y7aR0PANnTMb8HNceRJPzg=
X-Received: by 2002:a25:a0c5:0:b0:633:63da:5ead with SMTP id
 i5-20020a25a0c5000000b0063363da5eadmr26916591ybm.412.1647945433160; Tue, 22
 Mar 2022 03:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220321133220.559554263@linuxfoundation.org>
In-Reply-To: <20220321133220.559554263@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 22 Mar 2022 16:07:02 +0530
Message-ID: <CA+G9fYsU5W=N6vd4rgWbEdr0WYewDfAAcwuCSgL44uZ+ZqqTZQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/32] 5.15.31-rc1 review
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
> This is the start of the stable review cycle for the 5.15.31 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 23 Mar 2022 13:32:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.31-rc1.gz
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
* kernel: 5.15.31-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.15.y
* git commit: ca23d8a1f1ca986793db05e0398452d325571a3a
* git describe: v5.15.30-33-gca23d8a1f1ca
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.30-33-gca23d8a1f1ca

## Test Regressions (compared to v5.15.29-26-gbce139da2f8a)
No test regressions found.

## Metric Regressions (compared to v5.15.29-26-gbce139da2f8a)
No metric regressions found.

## Test Fixes (compared to v5.15.29-26-gbce139da2f8a)
No test fixes found.

## Metric Fixes (compared to v5.15.29-26-gbce139da2f8a)
No metric fixes found.

## Test result summary
total: 104518, pass: 88956, fail: 870, skip: 13586, xfail: 1106

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
* kselft[
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
* rcutorture
* ssuite
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
