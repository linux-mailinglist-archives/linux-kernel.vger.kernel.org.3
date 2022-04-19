Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4AB5064A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348915AbiDSGk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239584AbiDSGk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:40:26 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72B42F3BB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:37:44 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id s33so1907890ybi.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zRibhjTEex1v2Fhtb9E0ILRVral8i1DdlDaWcrDovnQ=;
        b=nmGLSfeHFNicDyqy3/9Blb7YCJcnobWDoKSg721MhXUsuSn4Ju/aKEr1VMcNilrsSx
         j6n0bcCUn90u9O2R+WjXBxkWv1/t0T9Q1ikQ3+gHsQZ6vklFdzXIOiqZFuBjIpeQcFcj
         P05jVF8Gep11IPlvlMA1ORYaZuh99a9adTST347QWnCHk1qyCe8zafVgqkkFSk/1UPAD
         bkbk6LPppR56qgfRolcPzOCo5TMBhbV1P8BK3XMdSr9O6JWYuktgmrdfKGXQmKoGLCYI
         mjm5TaoK+gFEQlTVJqKElsswepEPfMxXrEPf5LUfmvflCFcgkSJo9x/+7UDiTFgDhhqv
         Dtzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zRibhjTEex1v2Fhtb9E0ILRVral8i1DdlDaWcrDovnQ=;
        b=6dNK7ErFme5p6K2xVhzX3y28rUlg+37Qo3U05HcgwfEHXvpuMLBuQ5ZambbQkQhtMo
         jyT+CePRBub/mtyUYrK7qaQQEs/gEpsYUpBpeJsKVrJuvE3lqUlnTZ66i9u5Y/aN+xTL
         qPNWRAKUgTz0LTAHA3seuwuWVSEP9fQppnxc+/ldP7ox6pDFaR+fqF+bJxbVjQ4aDzJ0
         mxl4tSgwjqaEB9uX+K/nauEvmiG6qq7PpXqS/eNzs6i2HH4vN3aSzHluaHDL1MuEH+QV
         AAhtJLzswFP9EbfxcYEIr540jwoFngI6/AdwPwHpyLQ4C1t+84pEPpzDziZOanEXKOVj
         hQ8w==
X-Gm-Message-State: AOAM531b0uEmkAlADGLrJ36sBbXqj2eEAHgmlCG3okLJ4dHQeQW8o2k0
        JaMgZcXQsIG6G4Icc9Q+Kazlm0yUnmN8Vkmx9qDQww==
X-Google-Smtp-Source: ABdhPJwJ0eU1W8ZHfBjyXP7H3BsHYcCslhOzHEKRIhh7/DRt+rhiQqzNNAgNsDcXCbbyTYTovM6tgL6mKbnshD+U4+k=
X-Received: by 2002:a25:7316:0:b0:645:3fae:a830 with SMTP id
 o22-20020a257316000000b006453faea830mr822091ybc.412.1650350263976; Mon, 18
 Apr 2022 23:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220418121134.149115109@linuxfoundation.org>
In-Reply-To: <20220418121134.149115109@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 19 Apr 2022 12:07:32 +0530
Message-ID: <CA+G9fYtUDa=Ba_nABdRG08MVfpt2gnyNdnQ=6qhVN_K-y5ZOcg@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/63] 5.4.190-rc1 review
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

On Mon, 18 Apr 2022 at 18:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.190 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 20 Apr 2022 12:11:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.190-rc1.gz
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
* kernel: 5.4.190-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: ab55553793398bae2b33694dbbf1b3529c5ac2db
* git describe: v5.4.189-64-gab5555379339
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.1=
89-64-gab5555379339

## Test Regressions (compared to v5.4.188-468-g60d6fdc40ea0)
No test regressions found.

## Metric Regressions (compared to v5.4.188-468-g60d6fdc40ea0)
No metric regressions found.

## Test Fixes (compared to v5.4.188-468-g60d6fdc40ea0)
No test fixes found.

## Metric Fixes (compared to v5.4.188-468-g60d6fdc40ea0)
No metric fixes found.

## Test result summary
total: 88726, pass: 73874, fail: 888, skip: 12818, xfail: 1146

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 290 total, 290 passed, 0 failed
* arm64: 40 total, 34 passed, 6 failed
* i386: 19 total, 19 passed, 0 failed
* mips: 37 total, 37 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 60 total, 54 passed, 6 failed
* riscv: 27 total, 27 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 40 total, 40 passed, 0 failed

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
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
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
