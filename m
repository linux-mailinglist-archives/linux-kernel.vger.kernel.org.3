Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31DA46CC47
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 05:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239987AbhLHETZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 23:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbhLHETY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:19:24 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C667FC061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 20:15:52 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id e3so3981250edu.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 20:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KXCq01Yn53pJW1hOYABliYqveWIOjkRebuRptC/P/+c=;
        b=WI+kU0eYteVhFCRJQg6ItU1OROG2v1ZCghjsuyX05GWlgZO7XebX0W2Jz69Gsy5Mi2
         o/DQ3M4cif1a/wM3qWecmyXvJiXDayliqCSwADZzqNkqIzUD1fcwVNXoY0/Iq1bUeCXr
         S90LiYVCFhrHopcdlqFFMISEMr0huNfyK8zlFdDnmPbSZ1lduUrrAb4ijWzABoogxBMh
         Do3Dp+701atYpycC8jaN83VHNPK+SytjD7j+zwu2pW0qSFbxeMnm9rrhpLLCXqhp5Uk2
         NL0bLMa4fOXVEybusuT1iO4eYOSk/XROk6bLZccT2xyMo31rpijqfkF6GXtCPF+nKd+6
         dPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KXCq01Yn53pJW1hOYABliYqveWIOjkRebuRptC/P/+c=;
        b=Kq8kjpCz4m6nMlf4RpHtdepkqs5qqBNihONyAz4FAb/NePqj5A9KXEVbD7U+NDC5tY
         xXrUI6G8Um9KqwQAiabPscE7C/zwd9FLeDwVehQEnYu7GKxOX6j7zciVlXblMGruRB28
         qPXqBMCChjnyAYy3XEoXiqEA6b55Qfi22A4eEcLI8G4OLBz+9MjPcSRowdqy7eg3FXU/
         SKxs3D/KnjO2xRlWbcsZFPLN80sDJ1w0JCvPchXZa0bjuUmtV4i6PWL5ZjHXw8tzfq9s
         Q//ucs4WwWGPAbYyO2gJzsRw8Upm7X3QTsGaQweOQET0/wnSGp/XnRfb6ubuKiPjSf2q
         eJNA==
X-Gm-Message-State: AOAM532W/dAEn9EhYHM7BPyjp+UlUpkmzIj7WSnrSAM5RcP/hKgjlzRt
        Bh38vquFc70RI3X88t4ThjnVsIVYXrIu2itPk8aJMA==
X-Google-Smtp-Source: ABdhPJxMdonJDulWT5QLKCR6wBpKlOqxPVBiG3G3uOyW5TMfW2Wtsey2Rky++z45hBXwLkNgjLFR3HH5nMbVFGVPD7g=
X-Received: by 2002:a17:906:7955:: with SMTP id l21mr4695919ejo.6.1638936951258;
 Tue, 07 Dec 2021 20:15:51 -0800 (PST)
MIME-Version: 1.0
References: <20211206145547.892668902@linuxfoundation.org>
In-Reply-To: <20211206145547.892668902@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 8 Dec 2021 09:45:40 +0530
Message-ID: <CA+G9fYuvAA469sMYTi7+OF01=aqNp6Vx4f2VwNeFt552CDNj_Q@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/52] 4.4.294-rc1 review
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

On Mon, 6 Dec 2021 at 20:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.294 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Dec 2021 14:55:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.294-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.4.294-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.4.y
* git commit: f5b0b7aefd9d2ea9170ed69c7ab2dfd751fba7d1
* git describe: v4.4.293-53-gf5b0b7aefd9d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.4.y/build/v4.4.2=
93-53-gf5b0b7aefd9d

## No Test Regressions (compared to v4.4.293-22-gd0a6005afb1e)

## No Test Fixes (compared to v4.4.293-22-gd0a6005afb1e)

## Test result summary
total: 56876, pass: 45655, fail: 214, skip: 9659, xfail: 1348

## Build Summary
* arm: 129 total, 129 passed, 0 failed
* arm64: 31 total, 31 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 18 total, 18 passed, 0 failed

## Test suites summary
* fwts
* kselftest-android
* kselftest-bpf
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
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
