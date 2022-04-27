Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE9F5113B9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359533AbiD0Irm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359540AbiD0Ird (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:47:33 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B638BE11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:44:23 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso10714717b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SQMJ26wvEtu2F5A/vGPAguDra0srFC0q4EMLa7aGHwg=;
        b=bKgJJn+FA5BVmMsZTxGvWVZmDV/yvPtRvvBNIceQqF4QDapA9FXmoUxDM9B0/u+WEE
         F+NuiuUTceFGofcDdU6+2NLuw4Y6UJh/zgJ2hH/uvDEJE3f55oFPKTZh9DXJEoeCt61Y
         UiLhIIgSYfgqVlUawWDCrraAY9oiMQ2ZurOcLAzddGfESuSwG/YIGxdJ7OMLX2TujR4G
         NIt7LwDGgf+Z2d5u6mMW2k6+dpDjTsgoHkL+KImvrT2/H5fGTndwAl7G4EdnB48ZcgTw
         pnZy2Fwza1p0RfL/AQM9Q97gKtJdgrUICN7RosNfc5qmiFBRBM2veIjVBybYYhewYE99
         KZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SQMJ26wvEtu2F5A/vGPAguDra0srFC0q4EMLa7aGHwg=;
        b=rZ+qdzrCvwlwxutqWyaDyHk2McG6VyRX6hBfHHSNRctoS04Y9s7dZtFd6R0kpnfiED
         AKnhRNkAsevXWf+zkK0nOMhq7XCJKnol92mycI9+/IJqkkQQhMa3D84QK3KyoujKe4AW
         xA1he6zM94CHFzF7fP5Ba2eAIPcRAZ3ypjoBXA70unBOJbacV0IyE5vhN2EBkTTK7GXi
         x4D2nnN6JLMlv6keOb+YQLx+fWgLxpObXcYdAlKGUoyp1dIEKzlJ2YOxfi/L9pTxMth8
         efLzuQlPvKRJCpzk0yZYxENKHoW0tURdTgAm8CSecPvYmMwRI3I4smLQB/GA90FjZQGg
         boZw==
X-Gm-Message-State: AOAM5326BaFkXnyEEs4Xt9etiMzm0YVPwAkRDGDVntPlUZQWf5xctlJt
        gz8P32Y+LOPjNswM8LhCDys6B5D9uaTAki2PzEXtcw==
X-Google-Smtp-Source: ABdhPJwRgLSodI+YPGUhEASrFK+9Kv7aJytVR7QJiuvg5oz2TZA5Q/ICUd3ZqlNpu478Z74YDNL2noyFyyseibHKFTI=
X-Received: by 2002:a0d:d88c:0:b0:2f7:bb41:1bd0 with SMTP id
 a134-20020a0dd88c000000b002f7bb411bd0mr22224797ywe.199.1651049062630; Wed, 27
 Apr 2022 01:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220426081731.370823950@linuxfoundation.org>
In-Reply-To: <20220426081731.370823950@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 27 Apr 2022 14:14:11 +0530
Message-ID: <CA+G9fYszuWCQRMHgpJdvN2oBGfgvGbew4XMYDgodUU8gf6EiTQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/24] 4.9.312-rc1 review
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 at 13:53, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.312 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Apr 2022 08:17:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.312-rc1.gz
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
* kernel: 4.9.312-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.9.y
* git commit: 73ad06e1327e6e3dfd8ae7c18bcf71b07fbe4683
* git describe: v4.9.311-25-g73ad06e1327e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.y/build/v4.9.3=
11-25-g73ad06e1327e

## Test Regressions (compared to v4.9.311)
No test regressions found.

## Metric Regressions (compared to v4.9.311)
No metric regressions found.

## Test Fixes (compared to v4.9.311)
No test fixes found.

## Metric Fixes (compared to v4.9.311)
No metric fixes found.

## Test result summary
total: 69281, pass: 54230, fail: 779, skip: 12094, xfail: 2178

## Build Summary
* arm: 254 total, 238 passed, 16 failed
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
* vdso

--
Linaro LKFT
https://lkft.linaro.org
