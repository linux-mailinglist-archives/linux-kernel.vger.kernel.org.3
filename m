Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646C25710C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 05:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiGLDWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 23:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiGLDWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 23:22:23 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477E52FFF6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:22:22 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id y3so6730880iof.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7NkiEh03bHogD/KZRt7KOPqO31qAFas80Jvno7PZgJw=;
        b=wNTdwxoF4QQvrebu3Ri2G9fyDaxXqGJWyLih36QJcgYBszxl/mgN08ItkCX70De0dA
         1ndSrgSF3LwK33M5Os16DcGt/jPG64jkZeBan6csBswk/y1695UhHtXZa3SfR1GsZfW6
         lSlUs4WYitv+a+8Yl5SJ+3xXiU9O4tGsxRTTmhehgufXdvO+ntuBLfWkjSzNCLLXcM3f
         nOz0mEFPecLWD+a7t9kYtZwMG8XZmF2KTa8djgskkyXkLbt4TVfgKPoyVqWxSvY0p+VB
         SpKKQg4m+ETQOU5xK8knwCE04VuM7KLgLUa6bccKbZcqKt+uBpxZm3l2wIdIJ/63eDma
         AJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7NkiEh03bHogD/KZRt7KOPqO31qAFas80Jvno7PZgJw=;
        b=fIxDQKpi1Yo8u3opODFy1RRNvqvItEpST+T7k5rOhYoAsIO95fYhNUlnGPTQN6yGYm
         +CMdCMKXp+ZJNyi4KQ7FFEtw8HMfjMCVIidNjXR0qVjXYRxwHPC0FAU+SHPEl1kar44m
         VCjyOhehliLaaFW7WApWGCDp3Oi0XDKvh5MSHEwdFaMuDhR3oUhRsCpfPBEH2STtIL54
         v1nTiWZrVZBn7RMyxljc2TKVdmPSnlrdMaRMtJ8uetc/pLu4zu5jDsAM0L9ivDdSJNGD
         sJl1K1KmpJp7O0S8sy7+YQ2irOLbTW59Lr7fFUbTE7mGhZlEtjcDRQbdMy6s07QKzqJ3
         5nxA==
X-Gm-Message-State: AJIora8gzUyd4ILXdKNC8nhRS26s+xyEh/6f36UKaKqsbQYbdWe5K0ql
        ykpUYgn/BPH8Aleso7/WkQNzzWoSU65MEn6Rc3BCshWlE5M4kQ==
X-Google-Smtp-Source: AGRyM1seyi6In4iiJ4EVLXqTyyx+qJFVj4q1+HBObv7k6A6O4041ttnjkr4nQBHFqHDXFV0d6+cD2DSFobhHMfw5GN8=
X-Received: by 2002:a05:6638:14d1:b0:339:e8ea:a7c4 with SMTP id
 l17-20020a05663814d100b00339e8eaa7c4mr12262536jak.309.1657596141571; Mon, 11
 Jul 2022 20:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220711090549.543317027@linuxfoundation.org>
In-Reply-To: <20220711090549.543317027@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Jul 2022 08:52:10 +0530
Message-ID: <CA+G9fYvBv3oi+mFDN2oy0+deNdawq9EHCdW61K9irYpWhCM4Rg@mail.gmail.com>
Subject: Re: [PATCH 5.18 000/112] 5.18.11-rc1 review
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

On Mon, 11 Jul 2022 at 14:45, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.18.11 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 13 Jul 2022 09:05:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.18.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.18.11-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.18.y
* git commit: 3c032a4d5696ca200b763ef36a7e3f8821f830ba
* git describe: v5.18.10-113-g3c032a4d5696
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.18.y/build/v5.18=
.10-113-g3c032a4d5696

## Test Regressions (compared to v5.18.10)
No test regressions found.

## Metric Regressions (compared to v5.18.10)
No metric regressions found.

## Test Fixes (compared to v5.18.10)
No test fixes found.

## Metric Fixes (compared to v5.18.10)
No metric fixes found.

## Test result summary
total: 134124, pass: 122462, fail: 854, skip: 10112, xfail: 696

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 313 total, 310 passed, 3 failed
* arm64: 68 total, 68 passed, 0 failed
* i386: 57 total, 50 passed, 7 failed
* mips: 53 total, 50 passed, 3 failed
* parisc: 14 total, 14 passed, 0 failed
* powerpc: 65 total, 54 passed, 11 failed
* riscv: 32 total, 27 passed, 5 failed
* s390: 23 total, 20 passed, 3 failed
* sh: 26 total, 24 passed, 2 failed
* sparc: 14 total, 14 passed, 0 failed
* x86_64: 62 total, 60 passed, 2 failed

## Test suites summary
* fwts
* igt-gpu-tools
* kselftest-android
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
* kselftest-efivarfs
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-firmware
* kselftest-fpu
* kselftest-gpio
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-lib
* kselftest-membarrier
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
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
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-fsx
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-open-posix-tests
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-syscalls
* ltp-tracing
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
