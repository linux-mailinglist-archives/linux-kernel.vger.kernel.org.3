Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E52480854
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 11:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhL1KV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 05:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhL1KVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 05:21:25 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14CDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:21:24 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id d201so28583661ybc.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nO8DvPRUSFx1m/HV/v44ZF8S9TbwvoVt7MBxOPc0dG4=;
        b=BP4ET90SPvbViXA1OR0M2eb17MEXLTVh+ZyKQOrShJ+IU+ZsuVcASPUEOaOLHRbaoD
         Jniyi1s8vLFUT1smrmtzo7f4VgcRwvEgeEBp++kwLYqzFFZEeC7v4OLanRdV39QYa/fq
         gjkUW4UUBgk8j8bSJwwLbBwMhe7Hg/kvZsDV2Nk1d494RA6czQYHGPkk8DVkFYsD0OmW
         3aFlOsDBc2hclIv/otFyB7SosKGeP2tNpXDdBBs0kvvffqhuuYelrEnbgd/Efoq5YduT
         gvFyGJ0T79KGm4aIJeE5/uVD6FX5P+cqgShYN2PvqbZWW+C/Xk7KkWkOsodspmi9JMzL
         Hl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nO8DvPRUSFx1m/HV/v44ZF8S9TbwvoVt7MBxOPc0dG4=;
        b=pxjImIdoRY1imn99ERc8Mo33ThFxqitCo6ne1ezKd6YPpa7NAZLEvwLayPFmPjy+EU
         +wK09FeVOkfjctK2lzvDzg2xVlQN44gPI7Q/ury84htItLWFOM0AoW+qLD2KwtE8JjTN
         cuI5K02D1OqoSjfHJ4e/7FazKItDGiEw6qb7FImVXfacoZOr8wNMGznTmleK4V0lji1c
         0MB1/7kdAbKuuH7+AEsYBK/ELqS0EX5V2qTKP+J/5FpO8RyqhdgRT/WHtIirk2YlUErx
         3pe2Q7NfqJs7e38r8gzSpKHvlxy3wx8V9S0BARc6obkhaOxnxiwYVAlWObyXbbX7Rb6D
         Zrrw==
X-Gm-Message-State: AOAM532OjjW3y5n9F7wYZY9rcLu/zMADeFv/nDR/KGV2b5PpfurbFb9R
        4xuc9jIlvmstKBRUVQ0b/eowjDljH/qsQtvPLQww8A==
X-Google-Smtp-Source: ABdhPJxZB7IX/wo2a6TfZplSn1ukvQc7FiPK9eu0WoJaX1LXH+oEKYD42KL8ttHXwPf9qbMgAWeQQsOBYaAdi36e7I8=
X-Received: by 2002:a25:4b85:: with SMTP id y127mr25287073yba.181.1640686883366;
 Tue, 28 Dec 2021 02:21:23 -0800 (PST)
MIME-Version: 1.0
References: <20211227151320.801714429@linuxfoundation.org>
In-Reply-To: <20211227151320.801714429@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 28 Dec 2021 15:51:12 +0530
Message-ID: <CA+G9fYvDGsVM87BUR34v4pCTL2a7yFd4Ftzbkmrf+mRGtFWwnA@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/47] 5.4.169-rc1 review
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

On Mon, 27 Dec 2021 at 21:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.169 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Dec 2021 15:13:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.169-rc1.gz
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
* kernel: 5.4.169-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.4.y
* git commit: 55d919268b6e0816a2eaa3a74303fb57102ab4a9
* git describe: v5.4.168-48-g55d919268b6e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.1=
68-48-g55d919268b6e

## No Test Regressions (compared to v5.4.168-40-g28a051401761)

## No Test Fixes (compared to v5.4.168-40-g28a051401761)

## Test result summary
total: 90970, pass: 75722, fail: 752, skip: 13081, xfail: 1415

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 258 total, 254 passed, 4 failed
* arm64: 36 total, 31 passed, 5 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 20 total, 20 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 34 total, 34 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 52 total, 48 passed, 4 failed
* riscv: 24 total, 24 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 36 total, 36 passed, 0 failed

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
* rcutorture
* ssuite
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
