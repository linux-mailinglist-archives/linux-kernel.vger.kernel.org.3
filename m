Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB4C4D6273
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 14:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348809AbiCKNgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 08:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbiCKNgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 08:36:32 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E00A19BE5A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 05:35:26 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id u3so17132056ybh.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 05:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b8Tl4+MXrc0vuYGiinc9MCoQ2yL9HNQEJa9pctwRXuE=;
        b=cBZt4ojv1e+l7+D3LYcgkm82aZTGvTUvo+kr/KkuxcCukS44eqfn+h/855G7AzwplF
         KqR91IvgkKDuCeokb/EiZrSzQsx5zH/OLstzGT/u6gZNp6g+9qf17I9luj2JebRR8siR
         b06uD3U75FwqhnzRTPNbas7SY8ARLNL3t8eG/n8oDe/s9EWIIfdezUaPSLfMylnHlJAS
         XxGvn6lHjGSg0y60pmPtGOZ56IBDTUaTOj/0PiIM+hzs73Pb8Va15skqddJ1vrqUOrmf
         GBs0P9drlts/zmaS+k0kXj695ndOeWgKuT2cC80A76PkeyT4bclEJDVkvRbLAGZ5zCcI
         Vw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b8Tl4+MXrc0vuYGiinc9MCoQ2yL9HNQEJa9pctwRXuE=;
        b=PGt6lXPHEbtne3gRETVbzp8HHodC6vtDIvFQElonh2OJiKlR8CA0cocMEjaZmrY7Vd
         SE7W9sDphkhuQwJTGfkuIZXt02g39nZ1pPc/fgbykCr/mNkII6mqrWrKAQB/UDNGJhs3
         b/RfddGfqtLnzv8z2zI+EMiuDNJw9QpPfTWHK7oVOLheZ3WvTt2njhHWqk6EV2S5ppYi
         HpD0pJJ4dUKYVAsIteN7rtbedI0A4/x3++h7iQuz46lIRfBmKsFwMJ0hPy0VJUhNW6IE
         XEfHIRPmeVeXiImqATc8FtCFwBNjPYLuhTVqU/zNCBL3ctgTt1ssa2I4V3Kpk0ZcQW6y
         6gxA==
X-Gm-Message-State: AOAM531ZeyaVMspEvwUN1Fge8c3rs8uSkghNwc06ljwFPJ0UNNclSeiq
        nI8MnOXBunleIW/X6zVOJvOA4tiATpUePouiePK7nA==
X-Google-Smtp-Source: ABdhPJznH42A8GcPEVRl4cnAJAktefmDA444z8iGteAkAShHQ8sLJjb+6k1JP5qL/J8Pa2lccVX2r5ZdDN6/cdyHxQc=
X-Received: by 2002:a25:be05:0:b0:629:1f49:b782 with SMTP id
 h5-20020a25be05000000b006291f49b782mr7720207ybk.88.1647005725421; Fri, 11 Mar
 2022 05:35:25 -0800 (PST)
MIME-Version: 1.0
References: <20220310140808.136149678@linuxfoundation.org>
In-Reply-To: <20220310140808.136149678@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 11 Mar 2022 19:05:14 +0530
Message-ID: <CA+G9fYtic5bjvmtqyncrESz1bEOEcPmK+dWr3ZBAQAF8wO4bMA@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/38] 4.9.306-rc2 review
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

On Thu, 10 Mar 2022 at 19:45, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.306 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 12 Mar 2022 14:07:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.306-rc2.gz
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
* kernel: 4.9.306-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.9.y
* git commit: 274dadc1cdeb33ce11f6d23f6b89e75249d8f8c4
* git describe: v4.9.305-39-g274dadc1cdeb
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.y/build/v4.9.3=
05-39-g274dadc1cdeb

## Test Regressions (compared to v4.9.304-34-gd3c7ac3bc772)
No test regressions found.

## Metric Regressions (compared to v4.9.304-34-gd3c7ac3bc772)
No metric regressions found.

## Test Fixes (compared to v4.9.304-34-gd3c7ac3bc772)
No test fixes found.

## Metric Fixes (compared to v4.9.304-34-gd3c7ac3bc772)
No metric fixes found.

## Test result summary
total: 70888, pass: 56046, fail: 861, skip: 11856, xfail: 2125

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
