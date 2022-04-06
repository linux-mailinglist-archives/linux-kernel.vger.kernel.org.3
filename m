Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232C84F5FFA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiDFNXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiDFNWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:22:40 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0207A36BCC1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:13:44 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2eafabbc80aso20230187b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 03:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sNpLtjT8N1zIIINaELQa0JweQ+VPyM3S6k6MC6+RPps=;
        b=DRkueuiaLLSvBw00To6buMVvkhuqahQLDZtud4rlCh5K4UtGSCGZKizmLbQh4qi+hd
         Xwf3HS314TZT5b58wrt6IMEQZOXsFZda8SAYUrNeetZNHoxwbwxhNt/OUwT3lKyuus2k
         H+ZJuecIQIethU62VZzi+uQw+KqqgovPZEJxNaKEReImPtBbDa+e1BEXoCBE69/XA82s
         WzGwafJCe6j26oj/LZSe05SdS9r2UJz67vUSUMSAOzpy7syyIrptevyQpilHOh392Iqn
         kn7vAQ/L/VMi4KeLxA7O3LzQtc+Zv9xrXAUhblf8asS0POPYoTIf7GcxgGwxu+NBV4h3
         irAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sNpLtjT8N1zIIINaELQa0JweQ+VPyM3S6k6MC6+RPps=;
        b=eekvpHqSM9hnYMMd/ehVQrstmzikecNdgz9ZyhfD/zHpPXsSBsjE686DSX08zjxvzN
         eDyOQEJ6BGcMwUTPEvh+/fIkThxGiCGY4f9y1i8Io7oL5c6LjBknmtiEj8xhix75zk2y
         kM86WM3hV70GE2S2aPGZWiIXbtembcQUFt11eg/wgrglLJvqnVilE8ZhsiMi3X+Huhi1
         TSW3E0oObDvc53Y6+FgWKruKLpOITOWhdf8JUUULRJk07+EZa2OsgqakZG+9/TcGaqqX
         EFg1VZqTM4tcSQWbv271HLpR66XARhjvO+TIh+rwpR7t2VbexJGOnjYk3TzA54u+gBv7
         1MYA==
X-Gm-Message-State: AOAM532jFKonVxvXpMExDpSHV0wTuMHYIreYaaz4wFQM8KPST9AGw/6u
        dft8V9kdisFNi863fkyhuKKCsc10tihiSuaERJNatg==
X-Google-Smtp-Source: ABdhPJyxys7fbyhnwwlqIy9+Bx5S1uCSqejI5clAZAJcwNZucI5Le124MTq3mVCMh0/ChpejLPeAyub1ePEYUwfh4uo=
X-Received: by 2002:a0d:ffc3:0:b0:2eb:2327:3361 with SMTP id
 p186-20020a0dffc3000000b002eb23273361mr6287962ywf.36.1649240019674; Wed, 06
 Apr 2022 03:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220405070354.155796697@linuxfoundation.org>
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 6 Apr 2022 15:43:27 +0530
Message-ID: <CA+G9fYtyterUZ6KhC1+4MOo7y92Z8MTy6NtR1SeVrstWimYy7w@mail.gmail.com>
Subject: Re: [PATCH 5.16 0000/1017] 5.16.19-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com, Anders Roxell <anders.roxell@linaro.org>
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

On Tue, 5 Apr 2022 at 14:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.16.19 release.
> There are 1017 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Apr 2022 07:01:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.16.19-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
Anders enabled extra kconfigs to reproduce Shuah reported build regression
and proposed two additional two commits for the fix.

## Build
* kernel: 5.16.19-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.16.y
* git commit: 5d3da1624789df6fa741a30aa6cd98c541f25528
* git describe: v5.16.18-1018-g5d3da1624789
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.16.y/build/v5.16=
.18-1018-g5d3da1624789

## Test Regressions (compared to v5.16.18-959-gef4d007f65de)
No test regressions found.

## Metric Regressions (compared to v5.16.18-959-gef4d007f65de)
No metric regressions found.

## Test Fixes (compared to v5.16.18-959-gef4d007f65de)
No test fixes found.

## Metric Fixes (compared to v5.16.18-959-gef4d007f65de)
No metric fixes found.

## Test result summary
total: 105413, pass: 88695, fail: 1159, skip: 14378, xfail: 1181

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
* powerpc: 60 total, 54 passed, 6 failed
* riscv: 27 total, 22 passed, 5 failed
* s390: 21 total, 21 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 41 total, 41 passed, 0 failed

## Test suites summary
* fwts
* igt-gpu-tools
* kselftest-
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
* ltp-tracin[
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
