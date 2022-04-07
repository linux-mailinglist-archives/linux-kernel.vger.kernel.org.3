Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036614F7CEF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244464AbiDGKem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 06:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244385AbiDGKeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:34:17 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FED410A94D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 03:32:09 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id x131so8725139ybe.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 03:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wy0uyCS1qMtmqWkLdDlY+fw3ha4Ox49szf2Z/w5iJz8=;
        b=ULvQ8J0NHwAroiN0gQMyw4doWv/BUOM/jXdoFJmlel/ZOrF3tXg3KunG7ncNoxTynM
         t78PtoZ4jaryotXnIDKfjCoGzfVQumxeDB5O+9fUMbTof2H8lXAo5QzjWA4WNWF8Ewhu
         bKuYJksQgmBmL6iAG1Ogs2ohHaNv6Hu1MAcqqc8ekrIpcw7c+4ksAmkwLrjeozCJLCxO
         jSJKh0v3Iu9bEWAWnrgg6EHpDZM4Qye7CozZvt1vRJGvJMT/TD2avWTXaFyHM0m+I/GB
         2tDvyYd7Wr79/Gn7v2yJtRT3Nnyo4uqANJqSQ5orntNmPTm/H0V9sh8f8TUyEwucebGW
         ghqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wy0uyCS1qMtmqWkLdDlY+fw3ha4Ox49szf2Z/w5iJz8=;
        b=bCVxctrNAe8OO5Kah6FBJXWnFBVBnrzkpm+S7CQ5/ST5Bqk7X8FGtk2iDqNDHfMgmM
         ThGGoQaYvVADBfnBwEciKiIMygBMoa5yxliz62pqevv8+i6Ocfj/+UwmggVVDkFDUKYA
         rldUfBK7Kmh5kti7GrDhRZJ/LCk3pgWNijbs3C5nLZZoItJMHLwpR1nOz8AO3mjwL35c
         Uqo5fCL3f7vBl7QuwWXJw7oznYp32ivGrQfLIdENAM7v+iPqqb5MYpE7psVymoWkTgrY
         82E4oUf1PM7DQJR1cTcpBm8xzSu/sq3znytiiJtVik7ci4eY0eO5q9KeNgv6IsU4P/DF
         KPdg==
X-Gm-Message-State: AOAM533cUbgXUwNtrm4PiXs7iGaMlNI841Pj2hlQr1z4erOXgrinTx7H
        UtgSEV++phK9zRyJdeq2mxy/DV7RQ2uwVwLTNyqz1A==
X-Google-Smtp-Source: ABdhPJzFJYch+rFa/0xnIHJ/PRfuIEQ9WRgmTGn31Ca1e6umhZ7jkyFs92IJDSK1g760k6BUOZ5COhh97rMGMOoM81Y=
X-Received: by 2002:a25:9846:0:b0:61a:3deb:4d39 with SMTP id
 k6-20020a259846000000b0061a3deb4d39mr9500630ybo.537.1649327527925; Thu, 07
 Apr 2022 03:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220406133055.820319940@linuxfoundation.org>
In-Reply-To: <20220406133055.820319940@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 7 Apr 2022 16:01:56 +0530
Message-ID: <CA+G9fYujM5fTQbHMSdMnGMj-=VUfTp5N70agiY82EyANy-g-_A@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/911] 5.15.33-rc2 review
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Apr 2022 at 19:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.33 release.
> There are 911 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 08 Apr 2022 13:27:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.33-rc2.gz
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
* kernel: 5.15.33-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.15.y
* git commit: a476e005a81c4076389bd02ccd88711b777ede1c
* git describe: v5.15.32-912-ga476e005a81c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.32-912-ga476e005a81c

## Test Regressions (compared to v5.15.32-902-g1a1c2efda160)
No test regressions found.

## Metric Regressions (compared to v5.15.32-902-g1a1c2efda160)
No metric regressions found.

## Test Fixes (compared to v5.15.32-902-g1a1c2efda160)
No metric fixes found.

## Metric Fixes (compared to v5.15.32-902-g1a1c2efda160)
No metric fixes found.

## Test result summary
total: 104758, pass: 88256, fail: 1001, skip: 14337, xfail: 1164

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 291 total, 291 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 40 total, 40 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 37 total, 37 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 60 total, 54 passed, 6 failed
* riscv: 27 total, 22 passed, 5 failed
* s390: 21 total, 21 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 41 total, 41 passed, 0 failed

## Test suites summary
* fwts
* igt-gpu-tools
* kselft[
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
* rcutorture
* ssuite
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
