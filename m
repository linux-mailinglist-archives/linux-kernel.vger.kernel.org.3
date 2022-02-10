Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187D24B1408
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245137AbiBJRUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:20:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240987AbiBJRUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:20:50 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7ABE72
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:20:50 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id j2so17658327ybu.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uGPhzBguK/5/cfeFYerjCM2EsCWTLNreTG0aManfefs=;
        b=mJmnkOw50LKYU304qUoanAU2ejFM89eMtfePrkimCdow5gNbJAa6MFqtheLGqT2fWb
         Htgzgl1sfBM9XDJEaFe7CCsxvl0Vy/HeSvKHgW2Z0S2ElZ0HdEHRlX2BAW66t/Hc3PUn
         9Dc/AwhVF80UzlszCyH/mf3q6DzP2fdLu9/1AYWshZRLOmYl1Hj8hkvDqiuxlnMi61Kc
         yGOGlaMQVXQ0otWft8o5KYYffb6WBLZl/qqZCFsZp5gd/CbinxXJkjLLLi1MfuDFyttv
         TlZklQV1QLVxZJf75aAl0AsHkRWxyO7zna2qHwcHgSCTPzeVaqQh4pOYvbByCak4+YbN
         +FLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uGPhzBguK/5/cfeFYerjCM2EsCWTLNreTG0aManfefs=;
        b=2Vni084ZKEP99dDnNXZEAHPTQsQMJyalJSubM/emjNID9KlNMSZbZIzm0dCJc8lo0R
         Io3zT86gjUct8RLJ7e3kHhvMDEC5LDk2dhOhIDMkyjti7evjo8SA9DdZfZ92d3BBNA5F
         RNsZXXgcMezGxodEVRuDYTuvHzhE5GvB/xIPc8c7DnaPELwNkCA4/lymRsCKXyA5qu7p
         npPMlqTzeIT8WyHfZczLmFOblVYX8YDzEpCRoYGvDL7bmMkbvIMwyBQrCVcGG2OaYZLH
         n8hKqFbgJ+jeknYHTaiilHgawVkN9mf6wN+Jvkr0EzI6zB3nOeTG3QCqW9jAttQ/3C7u
         8Wtw==
X-Gm-Message-State: AOAM533KWoz5Tdr8zMPT6tjPSio8oEexzPx9o6z+EkNPdsnu2GkQwgKe
        Ng5dZHaFolUnZdsMM0nIq2o8hTe4foUgdD+VZCV4wGgHPEg4mw==
X-Google-Smtp-Source: ABdhPJw9NpLvJD8mjqNP/buS9r1P2MU/8G6NTcvj2v9amb5l/1yVfGRZK8LtRA7ESaxjR5NlL+utbJSSVr2WWnk2XvE=
X-Received: by 2002:a25:5143:: with SMTP id f64mr8306603ybb.520.1644513649615;
 Thu, 10 Feb 2022 09:20:49 -0800 (PST)
MIME-Version: 1.0
References: <20220209191248.659458918@linuxfoundation.org>
In-Reply-To: <20220209191248.659458918@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 10 Feb 2022 22:50:38 +0530
Message-ID: <CA+G9fYvU03C2ik=s8+g5D+caizsN1=fk8FVTSW6FxQyZw7S26A@mail.gmail.com>
Subject: Re: [PATCH 4.14 0/3] 4.14.266-rc1 review
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

On Thu, 10 Feb 2022 at 00:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.266 release.
> There are 3 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 11 Feb 2022 19:12:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.266-rc1.gz
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
* kernel: 4.14.266-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: 11dfe0b418492a0075056a9db72fd2a34628c1cd
* git describe: v4.14.264-74-g11dfe0b41849
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.264-74-g11dfe0b41849

## Test Regressions (compared to v4.14.264-70-g1d3edcc1650d)
No test regressions found.

## Metric Regressions (compared to v4.14.264-70-g1d3edcc1650d)
No metric regressions found.

## Test Fixes (compared to v4.14.264-70-g1d3edcc1650d)
No test fixes found.

## Metric Fixes (compared to v4.14.264-70-g1d3edcc1650d)
No metric fixes found.

## Test result summary
total: 52019, pass: 43671, fail: 273, skip: 7413, xfail: 662

## Build Summary
* arm: 126 total, 118 passed, 8 failed
* arm64: 32 total, 32 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* powerpc: 52 total, 0 passed, 52 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

## Test suites summary
* fwts
* kselftest-android
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
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
