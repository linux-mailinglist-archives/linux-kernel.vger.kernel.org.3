Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7151D473CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 06:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhLNFxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 00:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhLNFxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 00:53:22 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D1EC061748
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 21:53:22 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z5so59960723edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 21:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bx7jcr9/tTa2Dog24Bm+JugLn1wzewObZIPJbLgf7CQ=;
        b=layjcpJfJA4ydY2oT3bJkGTYa0EoCKTOWtyr6oNs4e2PwFOhK5mBzIuM6JiyJak87U
         PwaCtdoZ576G6b90JegNnQBPJeEk6M2kbcmfsExy611HrIq6Wumg1/o7Xxd2ci6vZlNm
         Yau6KAyB5Dz02Dn21ktJDO3aGigVa65w2os6+KligBa6azvG92Obf5xA9KlKrAEaqZxT
         Qxg1s6diMZh3+O79Uamf5FTUKgkj79HNcJYYUCx20v16F3++XVb3NKS94lPFSYghMPZF
         ZXpAigT1QBur3m3pdezGiZ2v+JF89fTH9nARmnEoV+HnUVSQ7xaKN9YCuuXLCoo7S/mI
         63Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bx7jcr9/tTa2Dog24Bm+JugLn1wzewObZIPJbLgf7CQ=;
        b=Cs+KlCViHDcE5iqTvPN7i9yFexSgQwyThemnvPJxSOw/jdvH33LGlWPCdSqmORSHpe
         S3jjXVBAwD0d+XjXRT4lmYbJXtHIr29GJ2PVboPsXdREeURgNWNubuN9Qb/MMlX8Y7yd
         awlEVVt0U4Soe3LmfG6cHlnzbXw+7ojv2Bwusmr+1ZGJL6ylAgcQo3WWKe+DPBkjxjos
         8mE30OA/dy4rtQ8COH3PrB3237/nBF3nNbAilbTgU091RMDNKZ2+J1UFMDNesWDNt+AV
         SSuwkg1aFSwcMaY3YpEgc+bQ4y6alWKz9tiM8Sxix9XjIrATQkgA4w8R8UJCoq0IojqT
         5sYQ==
X-Gm-Message-State: AOAM532OulwKRJyEjZXaD/uX1TkJvgf/M6ZH0U93s/iYrUsVa3px5T6j
        /R+JZZf4epQ+WLHVgtTmp5Yx83blnY6smC+iC9//yg==
X-Google-Smtp-Source: ABdhPJzI9JE60bYPWP/CgQnFsDRTsQnPQ9RC6f73eyFW6RyveGxL/ANlxAoM51kXqIrHnjxKaqsTsj76SG40kwNVdkk=
X-Received: by 2002:a17:906:300e:: with SMTP id 14mr3429234ejz.732.1639461200715;
 Mon, 13 Dec 2021 21:53:20 -0800 (PST)
MIME-Version: 1.0
References: <20211213092926.578829548@linuxfoundation.org>
In-Reply-To: <20211213092926.578829548@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 14 Dec 2021 11:23:09 +0530
Message-ID: <CA+G9fYveBC87SYvsw87_+p40b+dsprN+eNyGbT+jxysXvKLP7w@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/42] 4.9.293-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        f.fainelli@gmail.com, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, pavel@denx.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 at 15:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.293 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 15 Dec 2021 09:29:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.293-rc1.gz
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
* kernel: 4.9.293-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.9.y
* git commit: ad074ba3bae9f56fde437a2ef3ecc555430a6f16
* git describe: v4.9.292-43-gad074ba3bae9
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.y/build/v4.9.2=
92-43-gad074ba3bae9

## No Test Regressions (compared to v4.9.292)

## No Test Fixes (compared to v4.9.292)

## Test result summary
total: 66961, pass: 53001, fail: 521, skip: 11587, xfail: 1852

## Build Summary
* arm: 254 total, 186 passed, 68 failed
* arm64: 32 total, 32 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 19 total, 19 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 21 total, 21 passed, 0 failed
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
