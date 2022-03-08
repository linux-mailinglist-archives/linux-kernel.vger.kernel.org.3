Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7384D1E5A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348726AbiCHRSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348721AbiCHRSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:18:30 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AAA10B2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:17:30 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2d07ae0b1c0so209465327b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 09:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hh6AaBiVTRgfkr5a5o3e19bf/1tJeN6ZNyRK5PzJXAQ=;
        b=hOPx34+OAtf/UYtXpRM5485F6TSKHLfrql5Q/b3CbA231R/2Bm0KxFfyME6IR43zYm
         A2A4RNddyVN5UsRqkguTcsxAeGQM3Raewmw/HjvyckfPiZqosSSlBqaueXAe9AZivLtQ
         21oG8haA37BnVQvvUgwNXPQcU4Av4g6d0C6IvTVjNil1dUt9SIZGyH484yefXOmaTxvh
         xN4RmVZDv+7ZpaSn2kldtORiWjzVp/estmfhLUB6pxbY7eOPHI/mou85VLyXS/+myk8F
         48rIM7gkhEd7kjS7wf/uTlPurXa9SeJSnH1sZ6GoVueuDagmwmKjEHO7s8vnzLt2CZTW
         gzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hh6AaBiVTRgfkr5a5o3e19bf/1tJeN6ZNyRK5PzJXAQ=;
        b=fbj1MQgUojPYj/1BH9fof71c36bgYaCV3efZ6aySooGH3khgQYZfcsUBfZ/0RgZfbu
         PFFWqqPXq2IV0FXxRQCIBVAW3Q6+N8eZhnz4JEmf2D1+Ddb+Xe0D4z3q2m4jRa8s0iB2
         uoigKOjPZREE2p2cakEhoeZzDIMpiKwkOYFLEe6lGHRAv3AXG/SY42hXluLE2ajOImVb
         LZ8Y3UvblGhtW+l539Hcse7Ims4CVpdNt7RP2vrZ1qNEsjeTn/2BgFRuU8PoVs3qJfI9
         5xKhqxvIbuUpw1opfUHdbK7a/TVnS1CxUJH9EKVwIlu+HrIusuHggrY4n0kO6RkMwkPR
         W9ZA==
X-Gm-Message-State: AOAM532PDIeYwqoC/JuJ/4asBUw+JS8ojk9m6p6pGhzyG8A/xIq4NcK4
        1f1KssQpaZ6vtv4r86eWLxM5aVrEynwjcvQx4iF0mg==
X-Google-Smtp-Source: ABdhPJxiUIoU7Lx/l5zt1tw4jRmbNc5dYO+GULFWeQs2eA0DFeCA3IJlyTY988bm8xJJioCxrCk5qKbCd+joZ/7de6w=
X-Received: by 2002:a0d:d187:0:b0:2dc:5d83:217d with SMTP id
 t129-20020a0dd187000000b002dc5d83217dmr13775475ywd.189.1646759849838; Tue, 08
 Mar 2022 09:17:29 -0800 (PST)
MIME-Version: 1.0
References: <20220307091636.146155347@linuxfoundation.org>
In-Reply-To: <20220307091636.146155347@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 8 Mar 2022 22:47:18 +0530
Message-ID: <CA+G9fYuh6r0+92=0caTC_Ji0wN0MgkVVCPinc0V55hcsJ4kQOw@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/42] 4.14.270-rc1 review
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

On Mon, 7 Mar 2022 at 14:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.270 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 09 Mar 2022 09:16:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.270-rc1.gz
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
* kernel: 4.14.270-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: [None, 'linux-4.14.y']
* git commit: 5ffa96cabf3ed80e6ade1e0670b39b5803501cf3
* git describe: v4.14.269-44-g5ffa96cabf3e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.269-44-g5ffa96cabf3e

## Test Regressions (compared to v4.14.269-38-g748cb9eabcfb)
No test regressions found.

## Metric Regressions (compared to v4.14.269-38-g748cb9eabcfb)
No metric regressions found.

## Test Fixes (compared to v4.14.269-38-g748cb9eabcfb)
No test fixes found.

## Metric Fixes (compared to v4.14.269-38-g748cb9eabcfb)
No metric fixes found.

## Test result summary
total: 83353, pass: 66534, fail: 1002, skip: 13185, xfail: 2632

## Build Summary
* arm: 280 total, 270 passed, 10 failed
* arm64: 35 total, 35 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 19 total, 19 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* powerpc: 60 total, 12 passed, 48 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 34 total, 34 passed, 0 failed

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
