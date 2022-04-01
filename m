Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7EB4EF9D6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351030AbiDAS3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351007AbiDAS3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:29:00 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DF11AC72F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:27:10 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2eb2fc29caeso11527837b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 11:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZV9rsxEnffKvJLrUfknIPgqRTZeaZ2Mani7T3aqxQOg=;
        b=zZ3lHizX1dGjBLic23sqZsrp92dODR5mQ8PExWBhvYpHdnsTZlkw6OI/+1wpybWSTi
         MfsBpvpaLwSZDl5Il5lox/nsBZSOalBADZff1bxKju4rwmmot08b74D4e20Vc3nT9b+I
         iA6/z/8meOHMrjatr/e9fwImsh5tHT3acTUoC/C3oXp8vMz79TQCwpOtOTCX3wqFJl4o
         GmyomWgWaX4vzncMUJndi/XIEFfW0jJYJOoLdI+RXGEtFO1gS9KLINHaeO9wB0iQAEgj
         CLQvrjRyJxdzdcB8ikMu7MzPJJGtejNoVR16iJ5oCFpJQe3m/8VygoFwQ6lvJ9X4Satq
         tCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZV9rsxEnffKvJLrUfknIPgqRTZeaZ2Mani7T3aqxQOg=;
        b=uEmTYZhUeo5PutMLDFz6edv/knvsbJxh+eDp7KlTpJ47ZaZ3YCE62Fpr8sYbVYhfTT
         6V7J+h7hPApAaJcsdKxP8n/TxfM6Knea5gbrZpQXo0V5nGJhNCkMhjTY8u/duwiMD8yK
         /nQAlfsX5811SPSq7I2VQ1d1iqMs0d5l/u2wDnrEd1alUD/bu/tTiR3LgYODumAs7rHG
         I8vVbBXGcaFEAcVB30D65Ox5G6PpMneieqimb60UadX+J5KxFcI8mBzfSuwu8/CvOAVp
         5tNcAO0CiNucBlUbzJyX63n+YIdXw1fQQqJiTzjAXfvaLPBeuptwQLliEo7SxXtYLG3I
         YO2A==
X-Gm-Message-State: AOAM531e4HsBhoQ2oJFex1ifGikqRWB+3fU1Ox92BH6+6bGM7DJU2fGu
        l7dvtR4PPP3JfzR1NiKl4e5gQ8tPGFmNDrd501K2SA==
X-Google-Smtp-Source: ABdhPJz5MrYsY1eOLklaommI5OEru/VDbsq4cZZoYZxY0Q1ixlcCWi4YF/u8xe/FRz3LTNDtvKKvfst95gp8noCj45M=
X-Received: by 2002:a81:478b:0:b0:2ea:da8c:5c21 with SMTP id
 u133-20020a81478b000000b002eada8c5c21mr11863401ywa.189.1648837629418; Fri, 01
 Apr 2022 11:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220401063624.232282121@linuxfoundation.org>
In-Reply-To: <20220401063624.232282121@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 1 Apr 2022 23:56:57 +0530
Message-ID: <CA+G9fYs2pU5PtkFhPQ2pJfz9vqWRNuG1aGLAvHZovVAD7=Knrw@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/27] 4.14.275-rc1 review
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

On Fri, 1 Apr 2022 at 12:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.275 release.
> There are 27 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 03 Apr 2022 06:36:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.275-rc1.gz
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
* kernel: 4.14.275-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.14.y
* git commit: c9d20a4cf85d73eed2f609ed877cd8b2a249aaa6
* git describe: v4.14.274-28-gc9d20a4cf85d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.274-28-gc9d20a4cf85d

## Test Regressions (compared to v4.14.274)
No test regressions found.

## Metric Regressions (compared to v4.14.274)
No metric regressions found.

## Test Fixes (compared to v4.14.274)
No test fixes found.

## Metric Fixes (compared to v4.14.274)
No metric fixes found.

## Test result summary
total: 84274, pass: 66776, fail: 1073, skip: 13891, xfail: 2534

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
