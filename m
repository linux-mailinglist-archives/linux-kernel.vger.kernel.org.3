Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9652250685E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350510AbiDSKMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350509AbiDSKL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:11:59 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC86A25587
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 03:09:16 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id t67so30133985ybi.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 03:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D+RktBPT4A9m01pJjZeJqMDKXo/hYkYf9d+s29uC2XU=;
        b=i3/mv1Zl77BhXOzp6eF6P+Th6afu7gpWxAF9Rqtstwbvk5ssRdVBRuoSmEQmV1NlFH
         bHbugtoUs07tFilyT3ddITKacJu/xCAezxG0d1Ndiv8Mkr35DcnupIqhKi/4McFGV0hp
         sB+4PW/RUyTLzqto5DF7KztV9/Tck3N28F1nHj8yLKWvmKg4iTQQo/hUia/juoKCpRkP
         9f83JFCPcrbiBGg5LMbKiYhdX64O4/gwLlr4D8X3g6KEFO1mb+bC6c2hmUJ29FCM2IWQ
         WhpKxBqbTo5sOqANwbxqDz8aa4PNdxG0/coJ3D2OJaNckSa0JviI1OtruOWshCrm2RcV
         c7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D+RktBPT4A9m01pJjZeJqMDKXo/hYkYf9d+s29uC2XU=;
        b=EWtUJoEZZFGzm4uNH+8DFogxxVeyK887Xws5T2KyUBSGCZiFDPHEJWfWU3UDG8IjQ4
         PdIhpKl7MObIpOT7fkUOJlwU7gzgagFC73pUQHTqH/T57/MRBub7qJwb0gvE8XujEVuG
         udkFzzEsnoElEoDdfaftUAN0CYoV/CL8zO7u1cQD5q1K7diEWEP7HcsRE14nqeAKElhV
         WEsbGOO3RgWmc+Rkkgg4uH/+cMOKzw8/wRUL5VBL1Kg2JRrMIkybDd00dpw2zEHEP0FQ
         Iu9TtWspg6y61AV+pPd9dXy5VrS5wZ3Py5uMhYJ/Fa77nDhVgeW8/2Hn9D8JRAaDW5FG
         Wang==
X-Gm-Message-State: AOAM5322qILa/l+q7vT9r2QCL+bZl3xRZEsngXYfe/ta6kQWyEQ9DWL3
        4XSzO6m997oZXKiWFrhDywSqDM4S3BqmcpjZVluQQg==
X-Google-Smtp-Source: ABdhPJz5cWCSdNn9/5rF/x21RWNGbr4aGvkJ89xdGtWZbOVZLIcsqQ52EAuOxUTwSrzi6jbtHkbvJHZ631GaSRku6xk=
X-Received: by 2002:a25:ae45:0:b0:641:ba5c:7745 with SMTP id
 g5-20020a25ae45000000b00641ba5c7745mr13848206ybe.537.1650362955853; Tue, 19
 Apr 2022 03:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220418121158.636999985@linuxfoundation.org>
In-Reply-To: <20220418121158.636999985@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 19 Apr 2022 15:39:04 +0530
Message-ID: <CA+G9fYs+gPNQvRSMT2dTq6OLmO4g63HwxtZ=hXj8M-6eS9isJg@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/218] 4.9.311-rc1 review
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

On Mon, 18 Apr 2022 at 18:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.311 release.
> There are 218 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 20 Apr 2022 12:11:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.311-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.9.311-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.9.y
* git commit: 6c5f018242b95dfc19fc76393fd4a89a2be197eb
* git describe: v4.9.310-219-g6c5f018242b9
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.y/build/v4.9.3=
10-219-g6c5f018242b9

## Test Regressions (compared to v4.9.310-202-g346293027e29)
No test regressions found.

## Metric Regressions (compared to v4.9.310-202-g346293027e29)
No metric regressions found.

## Test Fixes (compared to v4.9.310-202-g346293027e29)
No test fixes found.

## Metric Fixes (compared to v4.9.310-202-g346293027e29)
No metric fixes found.

## Test result summary
total: 80521, pass: 64354, fail: 658, skip: 13434, xfail: 2075

## Build Summary
* arm: 254 total, 238 passed, 16 failed
* arm64: 32 total, 32 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

## Test suites summary
* fwts
* igt-gpu-tools
* kselftest-android
* kselftest-arm64
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
* ssuite
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
