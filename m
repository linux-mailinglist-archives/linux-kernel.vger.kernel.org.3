Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F065270DF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 13:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiENLrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 07:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiENLrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 07:47:10 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C97B2B
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 04:47:09 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id d137so359203ybc.13
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 04:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aqBsIG9q44CGOPIrCGsZLGhcoB7OspJK+sVDyGPOJNk=;
        b=RB3Qw/cEE2s0GU1mWtZrXvv54I+/htkv8NPEGpiHBQjPBlavrjQndC1duJHWQbWi5D
         bzTr4oqC8YHbNo08zBvELEfe4FjhOikX5qQXs9j5b1GLuKGFe4Lwns3QNBoqEgZTXmaA
         Oh+2HQcMIj1fnRYrHchnr3MPWK+r8YMvzRUSBieqZXGkh5XQtDdoS9OR28WB9pizfxUh
         TbGJXX9twuJpgrbmHaB9K4a02NK2kYBToXW4coGpDhqHE32vGe+pTusSBWVheHabejZK
         PUQKlAdQX4d2guBc78NHWD3CUSgwi34Qefuor4l6FudcqNmQtPEmb1MtJEJ8tnNC6aze
         CJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aqBsIG9q44CGOPIrCGsZLGhcoB7OspJK+sVDyGPOJNk=;
        b=UjzL2VQJ1x+pLNknVi+GocLngWv3ZpTkrubr0bmFDoPugG1pCsxVdVAYxOTqc4Er5M
         JjIuRpgp2fzi5QKYKK5ohrJrMEnbILdm3cggnaxeiGUHLKJ1awz+X/u1IH8AXGr753cb
         E9YuS+/BxTnVwZPren1RszZkr1PNWWgRdpqmCTIoum8QbZg2NSV50EvRU0ODv2lxrW3L
         MeDm15ODuCh5Iy2xOSDIt4GliK7b+0n9PZX0G8UvfJFNJtAgJJGW/0P2UiEXZp1RFOdU
         O3jfzFh6o6wTwzluPz6xituSmvGaSyGGq0A/+5ngEAIGnkhlD7lrv/urY8nXZdU3d0tf
         O2hw==
X-Gm-Message-State: AOAM53389XnHXTZs1+Na+9G36W/yyPol5jCbJYGfgt51TEMQCdkwwzuv
        jPybBAMyJ4+Y5yEEnW2wnEym58NKAbZjrtzCTFvcSHnZHkU6wQ==
X-Google-Smtp-Source: ABdhPJzHyLzwwT8YN4G/FLgEQoNguY8vET8sMFeqn0210EiktSCHejAdUglAxaMwQoXv9DMn7xMfsDIPNW5sJeTnILE=
X-Received: by 2002:a25:da12:0:b0:64b:aca4:f5b3 with SMTP id
 n18-20020a25da12000000b0064baca4f5b3mr5493173ybf.494.1652528828525; Sat, 14
 May 2022 04:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220513142229.153291230@linuxfoundation.org>
In-Reply-To: <20220513142229.153291230@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 14 May 2022 17:16:57 +0530
Message-ID: <CA+G9fYuxbsZbW2ZU_tHY1YsxKTitGGt4KtBn5owGnoNdSBicOg@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/18] 5.4.194-rc1 review
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

On Fri, 13 May 2022 at 19:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.194 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 May 2022 14:22:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.194-rc1.gz
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
* kernel: 5.4.194-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.4.y
* git commit: 15301ad6000946aa71e6c14b3f701b34e5e694eb
* git describe: v5.4.193-19-g15301ad60009
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.1=
93-19-g15301ad60009

## Test Regressions (compared to v5.4.192-53-g52d5d4c85d2d)
No test regressions found.

## Metric Regressions (compared to v5.4.192-53-g52d5d4c85d2d)
No metric regressions found.

## Test Fixes (compared to v5.4.192-53-g52d5d4c85d2d)
No test fixes found.

## Metric Fixes (compared to v5.4.192-53-g52d5d4c85d2d)
No metric fixes found.

## Test result summary
total: 92313, pass: 76255, fail: 1154, skip: 13641, xfail: 1263

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 290 total, 290 passed, 0 failed
* arm64: 40 total, 34 passed, 6 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 20 total, 20 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 37 total, 37 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 60 total, 54 passed, 6 failed
* riscv: 27 total, 27 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 40 total, 40 passed, 0 failed

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
