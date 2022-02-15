Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEDA4B675D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbiBOJT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:19:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiBOJT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:19:27 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64582CCA7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:19:17 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id bt13so54175909ybb.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CYqFexpjDv9yT4nzLrQdxYmfh0odEShNXQitHQn7fDA=;
        b=QhgZieLBfral8VRa4vrmZWWhB7NmweVEJqM3JzliYtBnnlygZC3jsRH+Wig7qvzlSQ
         QaSPMPi1KNxQDQx7AblL+w+XP65yzLVG1OrMl3dJhC6ZdzHkGvniX2SeO6yE5jllFypz
         u6kzsHgi+nnxUlqqKwjnshJtp1fzQ+0iRoj3gxStQDuplT2hebLQijurfi/WTasdIrwH
         U/w4lV9oWYB9E5DbsSbL+/EKPbZ7Y+v+UaH4K0703yxTtzmW2zI3zo3iMUqj7ym2Ssxa
         LEHVzCtffQ0ZB3o9qM6n489X+Y2YYMVbKjTAJ34QTUZt67Fhke6cw2J1lgnCPRUPR4DA
         7dJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CYqFexpjDv9yT4nzLrQdxYmfh0odEShNXQitHQn7fDA=;
        b=y5X91NJLtrunBDmYyuRFdaBxVmw18XkWqpmUteCiuCdgj4epjeGQocs8IB0AGCsl+u
         RPL6VeNMBaPS94L9bdLFCS1lI/c78zroZ0CjgTKrCCHLxvQC8Fmm4Oy9WyZlUwL/xvjF
         PAWJ2BeZGsxz2t8DEuEFNOfvM+RVeSy9vhe6kbmZPCsmjAnkxQIGkSuG+ywpGp9ZYyG4
         WVI6sykVLQjYho3LV8WGxTZJOZMwjNDe5APmkfmBLFwf5xN+d74ghcZk2zbPsUmJWEGY
         v2dWrIDDn1I1kaIzfC42cSVTiFouCCLWmtyFchd5IqgftxJFrFr4aHsNy+zEe/qIr6Mc
         8CzQ==
X-Gm-Message-State: AOAM533mlaC4ZkpCq3sla7PDXOwkzRW8mA1/RKpnRCFP7fGlw5uJDSNb
        pBAGnrGssVjo9zMYlKLbqK6H9w55fhWWVq2r0CnHFQ==
X-Google-Smtp-Source: ABdhPJw3lm36wFBvVHZstEo0lqQZvmDd1KE/a8lc90xFgtXeAHUfZ2FMO07WBUwCc06s9vOxda8EDAb7G+QnxBoOEy8=
X-Received: by 2002:a25:97c4:: with SMTP id j4mr3145244ybo.108.1644916756924;
 Tue, 15 Feb 2022 01:19:16 -0800 (PST)
MIME-Version: 1.0
References: <20220214092448.285381753@linuxfoundation.org>
In-Reply-To: <20220214092448.285381753@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 15 Feb 2022 14:49:05 +0530
Message-ID: <CA+G9fYuO552avg2T9jrRo0L+Vg0=uvusQVY9WxaQT2cC-Ly7_A@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/49] 4.19.230-rc1 review
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

On Mon, 14 Feb 2022 at 15:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.230 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 16 Feb 2022 09:24:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.230-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.230-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.19.y
* git commit: 6343a97197f02ff1cb19d26d57a20a79340d681d
* git describe: v4.19.229-50-g6343a97197f0
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.229-50-g6343a97197f0

## Test Regressions (compared to v4.19.228-3-g020dc380ec76)
No test regressions found.

## Metric Regressions (compared to v4.19.228-3-g020dc380ec76)
No metric regressions found.

## Test Fixes (compared to v4.19.228-3-g020dc380ec76)
No test fixes found.

## Metric Fixes (compared to v4.19.228-3-g020dc380ec76)
No metric fixes found.

## Test result summary
total: 78458, pass: 65509, fail: 548, skip: 11348, xfail: 1053

## Build Summary
* arm: 250 total, 246 passed, 4 failed
* arm64: 35 total, 33 passed, 2 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 19 total, 19 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 26 total, 26 passed, 0 failed
* powerpc: 52 total, 39 passed, 13 failed
* s390: 12 total, 12 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 34 total, 34 passed, 0 failed

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
