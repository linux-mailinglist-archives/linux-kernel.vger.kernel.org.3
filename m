Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7658E511393
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359453AbiD0Ikg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiD0Ike (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:40:34 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A916D473A7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:37:23 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso10552697b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UrXQoI2zo0SYjggyNW2EGwCc8K66iJE5MbP/QPhJW7w=;
        b=G1jI562Bjvr81ZXzcuROTIO4Flu1024c6KDe/GD42Y88oWjbFfxr9ahx69LpbnVOtX
         YSSXadTthfQvLtutjKa7td+cmI8Swko3UpVNkOMKAeyDfvL1rRlYvGa5W7RhWb+YI61F
         16UsDQ3MBEJB6ph3n/lZ18AvYblfUS3vMVYQuFF3+aBEdBKAqNIcInuuc7tNUMF+WJbt
         CzFgXc4wwlIwLeqqX0Wy4kfCJsYKdId9nLFFC0JX3QFF+cOwxY03jgyeXP5N1AxpuDG/
         GLhAcIDAMU2GuHVhuDrrLivSLCmZIfiQX6+3davxAomzACy/u4n1ACZFM3N+ZOrLf6L1
         fR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UrXQoI2zo0SYjggyNW2EGwCc8K66iJE5MbP/QPhJW7w=;
        b=DAJIAq4UYu9j//DKF8Mm+UgAHvhfPwT+eLj3Kwbhrs8o8u0naH9BseB9hjRwzFedx+
         6HKroUUkCS2F0UfAMyDDUg2i2SrW0KcrANbAwUP/G29JwqCPSMQJuxfhQs6n5CGrGi1z
         W/Yxcqn1MgnQwecKUyOH3giIi9e4enKLG6mcqcPvEcIZ57/Ssi6cbXyQFv5LmAf/KG5Z
         NokS1tADVC42w8LqST362tCov1CuzwilginvpFy4rv6AHs4opFZJNWUfrIUEzxY5uXUx
         Mz+O44epKxnJljYKLQLIQM6cSky/YMfqEzYaqYMEhwLQyuFXgQs80fhnBQjjRt0Q2S7e
         gMqQ==
X-Gm-Message-State: AOAM531X15xBZK1aYkXJBcSk14/ftDEZu0FVq1O46n67JgaA7LtL91GX
        4JOZJlo4M2bfMhT0otzmAJfGa6Y7uP3y2PzFZE71Qw==
X-Google-Smtp-Source: ABdhPJwk8sb8GwNJfy5j6VKoXx2IuUOdf9q39FKgXHcE470e1bIEQm/ecxidQAohMJ4funrIEaP5tm3BwhaX49HZD/A=
X-Received: by 2002:a81:1b55:0:b0:2f7:cefd:9b51 with SMTP id
 b82-20020a811b55000000b002f7cefd9b51mr17567321ywb.120.1651048642784; Wed, 27
 Apr 2022 01:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220426081737.209637816@linuxfoundation.org>
In-Reply-To: <20220426081737.209637816@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 27 Apr 2022 14:07:10 +0530
Message-ID: <CA+G9fYt7p042sNDZpH7RYH08z_n10bPUWvCmPDPUmqhfcfqAug@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/62] 5.4.191-rc1 review
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 at 13:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.191 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Apr 2022 08:17:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.191-rc1.gz
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
* kernel: 5.4.191-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.4.y
* git commit: a511897e8ed5a4eb640531b81d53504b5412a7ed
* git describe: v5.4.190-63-ga511897e8ed5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.1=
90-63-ga511897e8ed5

## Test Regressions (compared to v5.4.190)
No test regressions found.

## Metric Regressions (compared to v5.4.190)
No metric regressions found.

## Test Fixes (compared to v5.4.190)
No test fixes found.

## Metric Fixes (compared to v5.4.190)
No metric fixes found.

## Test result summary
total: 92275, pass: 75883, fail: 1186, skip: 13728, xfail: 1478

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
