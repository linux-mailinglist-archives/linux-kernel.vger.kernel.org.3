Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428D54F6132
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbiDFONm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbiDFOMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:12:38 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835CB383A1B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:10:46 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2eb43ad7909so20701047b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 03:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eRkgVlPwRfB6HGbCvvtbsmmSY+pNcbuOqr+QTgeKr5M=;
        b=oQOK5AbyKIGpYtM6rH9GCASDeo2rC7di60FNNf3gGw1kd77KDpKlinYUq+Ap/ZRP8b
         nDXrnJIOXZca4kKcG99y2aJ9+VtWVl3RewXhlBvJlcIHmxT+zwTmBPVrkADcf22H6EE7
         lnY5q/QQ8gz/JDDArtk1BVd3eSDZpOW7/yiu896pV6qNWzogxNxxYbjIOOChjS483gAG
         BLhyIBVI3NGuZd4B82bhDGJ+bSKrMvL4nx84O16rTVAVpZEUflazSCIlAB3dXk3A+lfh
         Bus67JMQtVgYidFrkXqaHtiI+9ANqfRB+RbyZgYkwloEfdZm4PijqqEGZXRLuMmF9Je0
         XHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eRkgVlPwRfB6HGbCvvtbsmmSY+pNcbuOqr+QTgeKr5M=;
        b=mkxXW49H5VUsKSmnQDU2Me1C4tSNk8kN69nourMlY362OMwZ9vkDizuJh0MNeZL+1F
         qUmXwVpwxScX7P++tLplU3kVUKFq4j+ka4wUxKE2Yz2yTc3ofijx+bK6B0x5B95LsfD9
         JWSLSiGUA5VmJGa80L4xsnkzWS1aDaM3job0muKH6baAZA8j3w6AH+bq1P+yUziqv4wo
         e5jwKuHphEykZ3K2LUq8B0J5ZLhApSa+3cOuCk/cXmSZaVFY+RErNLcdCGqjmLF1zdCR
         qNMSzmFNn6WiOniXDPXQ5Bkz3S7vm6gYyQGnKojgBB/QzI8hjiseGkFKEFi9ecOs75BQ
         qaJA==
X-Gm-Message-State: AOAM531Dl75HKlwhYMX19gOY9LqDdrWYOKhu5t09i9SOcX7I0utg9pyb
        n+1TewG/DSFVFki45Oz7z+qDGObKdNyjkeNQCdS0Tg==
X-Google-Smtp-Source: ABdhPJzIMTzPYp2Pe8CY7ZvUR3OCSX3Cctu4u8ZPx77YrLPlr2bJG1JGRhn/q1EGKAQYShjLjFwtcuB2Z93flU1LnS0=
X-Received: by 2002:a81:6f85:0:b0:2e5:bad1:cf35 with SMTP id
 k127-20020a816f85000000b002e5bad1cf35mr6360972ywc.199.1649239768721; Wed, 06
 Apr 2022 03:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220405070258.802373272@linuxfoundation.org>
In-Reply-To: <20220405070258.802373272@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 6 Apr 2022 15:39:17 +0530
Message-ID: <CA+G9fYtv6-e06LWuOQF7JQ=1SQG=sxXe0qhE_2ir-Pd1i-p3mw@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/599] 5.10.110-rc1 review
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2022 at 15:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.110 release.
> There are 599 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Apr 2022 07:01:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.110-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.110-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.10.y
* git commit: 45fdcc9dc72a44448666a2bcff4030a659e29e46
* git describe: v5.10.109-600-g45fdcc9dc72a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.109-600-g45fdcc9dc72a

## Test Regressions (compared to v5.10.109-23-g09422778fc8c)
No test regressions found.

## Metric Regressions (compared to v5.10.109-23-g09422778fc8c)
No metric regressions found.

## Test Fixes (compared to v5.10.109-23-g09422778fc8c)
No test fixes found.

## Metric Fixes (compared to v5.10.109-23-g09422778fc8c)
No metric fixes found.

## Test result summary
total: 100719, pass: 84805, fail: 965, skip: 14009, xfail: 940

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
* powerpc: 60 total, 51 passed, 9 failed
* riscv: 27 total, 27 passed, 0 failed
* s390: 21 total, 21 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 41 total, 41 passed, 0 failed

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
