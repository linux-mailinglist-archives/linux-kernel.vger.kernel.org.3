Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B72E4E816A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 15:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiCZOa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 10:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiCZOaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 10:30:55 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213F533E2B
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 07:29:19 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id y38so16075149ybi.8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PZO5k4b3iAg7dSwvTOe/zKIDAPMugArOIyYYeIpfEjs=;
        b=vs+9p5MbrYunL1NdA2z9rHLYbjZwZT6lyGs8PMj1MXf2euTGnyZJN919GQF/POxC7c
         4UG5aaCkwwJIEOp+QtVpZAp8QQJFKOpo3OmRMmFrQAODYk6recGAkTg5JmZWbz02G1dR
         KHZziLDR7ci4Zx8JZtaKsFJApTAFCS3RfBPHH8n3yD29YNlNtC3joaxhDaDEEZt3TC/A
         Srrk77YBJzlFIgwHyWjCcto6z/ybzkqxq9/Nv7Jfs6iauUaBDi9Y4SZLIFhY3Gw/24lK
         pNrxAIjPAm3OJmaehoFreomK9hvDbu/tDMZ0spw91gD0AVSXc1+4ltutfTECge+iUlmf
         O9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PZO5k4b3iAg7dSwvTOe/zKIDAPMugArOIyYYeIpfEjs=;
        b=FAWDOpwPbmKn3wZBlKECm+sfnm1UlJ+3ilQWdLr/8WCFXNiCHIvJuCIai1IUdiHoJI
         OkV8y26yoYjOucO+h5wmouLnbnOHVXXDDtk2e7qmEIZrr6Fz2zIvI31tO7VqTWxlaQhS
         3+okKdxDatZB1KaRhvyq7UvZOqj3tsDQX9q1rh+qLB6xMoWc8hiq+imbHnPmYLPtxNSy
         BTzvBKDK3KfbDkH5h7hUZ3P24iQkDuxlwVeWS7dpAPScMh5yZhH3NDrQ3Vq0l9PSgR4y
         ibgc+Ae9QqfRRII12fc9VMv0D4uVBYv56SJZkK8gXuX9smSbLj/jSmgq/8SVt5mfQUMP
         +AsA==
X-Gm-Message-State: AOAM533nOvLjyq+amyMOsyxjjXfgVTXteuXrn6iavPlNZPfKRwFpSOXL
        2cEBrAbczsU2JI1twwbuIyh3VCtRyWIiEl3XYWx8RQ==
X-Google-Smtp-Source: ABdhPJx9+tCMbyG/zZlmJz//iHM/DDoF2l/wEVtEJiWodr5joCJmmRHpTEDWqOYwZa9ndbNyJ3w7TraX/QYZX8hz8/A=
X-Received: by 2002:a25:9909:0:b0:624:57e:d919 with SMTP id
 z9-20020a259909000000b00624057ed919mr15454071ybn.494.1648304958239; Sat, 26
 Mar 2022 07:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220325150416.756136126@linuxfoundation.org>
In-Reply-To: <20220325150416.756136126@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 26 Mar 2022 19:59:07 +0530
Message-ID: <CA+G9fYumOmdTw=8pck4jt+r1VGej180d4xBjwT4jSm7E+0YrDw@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/17] 4.14.274-rc1 review
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

On Fri, 25 Mar 2022 at 20:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.274 release.
> There are 17 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 27 Mar 2022 15:04:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.274-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.14.274-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.14.y
* git commit: 9907232a90d4b20f873c515dce363941cc1a43b0
* git describe: v4.14.273-18-g9907232a90d4
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.273-18-g9907232a90d4

## Test Regressions (compared to v4.14.273)
No test regressions found.

## Metric Regressions (compared to v4.14.273)
No metric regressions found.

## Test Fixes (compared to v4.14.273)
No test fixes found.

## Metric Fixes (compared to v4.14.273)
No metric fixes found.

## Test result summary
total: 76720, pass: 60907, fail: 917, skip: 12527, xfail: 2369

## Build Summary
* arm: 280 total, 270 passed, 10 failed
* arm64: 35 total, 35 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 19 total, 19 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* powerpc: 60 total, 16 passed, 44 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 34 total, 34 passed, 0 failed

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
* vdso

--
Linaro LKFT
https://lkft.linaro.org
