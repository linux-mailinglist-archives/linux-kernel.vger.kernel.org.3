Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06A94C8655
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiCAIU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiCAIUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:20:55 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16B86C93E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:20:14 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id f38so13825102ybi.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 00:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l2awJBHW6HyJ4vDzHlRPr73FDADh7U/A5qrCjIA65qA=;
        b=dqkd0mjg8qjjzXR7SL3tvFBWjrUMf2qK+3cwcx7A62QOLN5nifl5FJKYe1ubOejcSv
         JmxhT/reSmVgO9izawvVeqGMSEYThIVH6CsyH8gNntOxkaAdXn8rBkoPmklXg9hbYKmw
         sPNZLf4vAD7hxs7ZZTDuu0MjCgYsBW6HfMj6wmJUe/ZtFk0B6JxzwABp7nwDZgQjrIQh
         5M8ZaNR0n6KfOV47lJ3hJwkH9MpenZk4wbXpoM0xwjLMhk/wDgkQkn31s/lN3LNAcV8F
         1FLRCd99nhK7D0KhOfTApuzdiPUO+xPmWaDILjbTNLreODwBc/VKjjKvZDSXcQPrxzgW
         N9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l2awJBHW6HyJ4vDzHlRPr73FDADh7U/A5qrCjIA65qA=;
        b=CaYw5UseZ+iN421BXlVCMZsYETi079MoNuPwTnJhF3LetEylD/D3f2oxkae9/FShZJ
         k8ETVJr0Vgsk0I1rRENdQWdnnAygmA3aaHBnYMNIa031PHbpL2WV+8nmHIhlnEKIFXN8
         lVNGTTA3f3h82JTokYSoH0fDDLOkj/DT/i2B299Eo5AFQpnUuy7/yBYmwBLP5jWmhni7
         kDgQfEChPcwUtZSXgwu1oySDOlgu6+CY/DBcvhbj35qYaHyyd8jGA/jqJrsz1XsJ6RRb
         NgZpEfz7wF08YKP7uQYwe8+pCNjKPFoIDQEi7Dt+Fu25sx3nFehiP1R2MIolJop6abkr
         wcMg==
X-Gm-Message-State: AOAM530ua2q9gF2flvhbhhdKnWknvRbcjcXI7uQ9W7pZpsH7IAwvbsgD
        YFY0KWjG9zdQTzUNzOf4I6qP/qhVB1aYo8lwfIQ+og==
X-Google-Smtp-Source: ABdhPJwCHXlfYc7ypDIf9MAema56cN/LvwcRiTljRHA/T+EjhzcrKxVx/uZDeYuEwPi3csUJ7+8eIqfBjJEhg2YLpyE=
X-Received: by 2002:a25:338b:0:b0:610:a221:af23 with SMTP id
 z133-20020a25338b000000b00610a221af23mr23528030ybz.474.1646122813959; Tue, 01
 Mar 2022 00:20:13 -0800 (PST)
MIME-Version: 1.0
References: <20220228172359.567256961@linuxfoundation.org>
In-Reply-To: <20220228172359.567256961@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 1 Mar 2022 13:50:02 +0530
Message-ID: <CA+G9fYuJU2KYgZxbWg+NG1B-JzNpmFDnJRBU4P185-cV3EodCw@mail.gmail.com>
Subject: Re: [PATCH 5.16 000/164] 5.16.12-rc1 review
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

On Mon, 28 Feb 2022 at 23:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.16.12 release.
> There are 164 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 02 Mar 2022 17:20:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.16.12-rc1.gz
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

## Build
* kernel: 5.16.12-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.16.y
* git commit: dc69c736a4039f3f7c3d26910013103cdb517bce
* git describe: v5.16.11-165-gdc69c736a403
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.16.y/build/v5.16=
.11-165-gdc69c736a403

## Test Regressions (compared to v5.16.10-228-ga75faa1f1534)
No test regressions found.

## Metric Regressions (compared to v5.16.10-228-ga75faa1f1534)
No metric regressions found.

## Test Fixes (compared to v5.16.10-228-ga75faa1f1534)
No test fixes found.

## Metric Fixes (compared to v5.16.10-228-ga75faa1f1534)
No metric fixes found.

## Test result summary
total: 105073, pass: 89294, fail: 1663, skip: 13057, xfail: 1059

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 141 total, 138 passed, 3 failed
* arm64: 47 total, 44 passed, 3 failed
* dragonboard-410c: 2 total, 2 passed, 0 failed
* hi6220-hikey: 2 total, 2 passed, 0 failed
* i386: 46 total, 42 passed, 4 failed
* juno-r2: 2 total, 2 passed, 0 failed
* mips: 41 total, 38 passed, 3 failed
* parisc: 14 total, 14 passed, 0 failed
* powerpc: 65 total, 50 passed, 15 failed
* riscv: 32 total, 27 passed, 5 failed
* s390: 26 total, 23 passed, 3 failed
* sh: 26 total, 24 passed, 2 failed
* sparc: 14 total, 14 passed, 0 failed
* x15: 2 total, 2 passed, 0 failed
* x86: 2 total, 2 passed, 0 failed
* x86_64: 47 total, 47 passed, 0 failed

## Test suites summary
* fwts
* igt-gpu-tools
* kselftest-
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
* kselftest-lkdtm
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
* rcutorture
* ssuite
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
