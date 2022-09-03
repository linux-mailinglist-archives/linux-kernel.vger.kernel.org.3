Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793375ABF10
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 15:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiICNMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 09:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiICNMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 09:12:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E04B642E2
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 06:12:00 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id og21so8750488ejc.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 06:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5pK8XIRSSltGgDWR58jM3/KvU8/t6p0BHV06v8LQlaw=;
        b=F1Pefqc6SQ7Mca6NjcUOUzpM9YmufSEnd4yJYOY+aHKROx4J9EXAB1I+QxOLFHlqA9
         wZ1tlDU8Hn/yPMOTVTO0M476KSDzeOzPN1ngeKELJTmYTxPMKYnuYyqvmN30fquqXWKb
         0S8h1rdo1Lx0pFL9lrfnqRs5sDqbOW9A9pZ+Kmb+QkegvuIrImSxC9eGfJwhS/7gUtvx
         vuAU0FySeD+Xvx72twhmyZF4X8+P+5mybloGMr53hK6/LCxbhQY3hahwiYvtfaVYrdG7
         j/8k8ngKlqdgdknuli25BXiijBjqPRn7TC2DAboIA9mj8A/do0rubAmXjD+P540++klu
         c21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5pK8XIRSSltGgDWR58jM3/KvU8/t6p0BHV06v8LQlaw=;
        b=M5yQ76/ayXdDFhf++LxuXnfpddECcPvBJG4hgnFxsJbowYSQVnyCQ9iUik9Pe3+mVI
         FKfCW1SMdhmer4gzHk4UwkJIs+QVjhe2nJe+3JaD+muxgcwdmt3YI5MeF/XFnFU+Pjur
         ZsybzXE/fHWwBCDRBNekeqOeLZa76mihpLphvz4ApvSRu06UwgbdBf2kSlv8lPUREWsm
         QPKea+OnvsINQsMMP49mPAlEqCva3JyLSlknDiC4fR6s1G7inJUkoH+WuMEiNlEdreVo
         wOMdnSEWQ/cCKCFANc8XT6+ezYc5KUuEecfB7QRdszz1aaJmdiywdQB5rvY+p/qEG/jl
         sedg==
X-Gm-Message-State: ACgBeo1ql4UYoSw7nn0z8QXqzm0eVS4tnQ5rcbKlxFujbDKLukY0efb+
        3ulu8+pgHTGpk0yulVG2Es/8lPuPRPFYv7NmteVNIQ==
X-Google-Smtp-Source: AA6agR5fnISiBWO8Y8BGDhJnzmn7JX1r3NApCDYtgslm2Zi5p4pL8K0MjiwEqDMgPlBn1RVFycdpI7nBDvC1cebLT0I=
X-Received: by 2002:a17:906:9bd9:b0:73d:da74:120c with SMTP id
 de25-20020a1709069bd900b0073dda74120cmr27530354ejc.412.1662210718515; Sat, 03
 Sep 2022 06:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220902121403.569927325@linuxfoundation.org>
In-Reply-To: <20220902121403.569927325@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 3 Sep 2022 18:41:47 +0530
Message-ID: <CA+G9fYszX+g+gg46MCvRDkweKbjpuUR3EdutwLm3fuHtaDJ=3Q@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/77] 5.4.212-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sept 2022 at 17:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.212 release.
> There are 77 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 04 Sep 2022 12:13:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.212-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.212-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 35d9f706c6df9df6ca8205b796f74081c0d93326
* git describe: v5.4.211-78-g35d9f706c6df
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.211-78-g35d9f706c6df

## No test Regressions (compared to v5.4.211)

## No metric Regressions (compared to v5.4.211)

## No test Fixes (compared to v5.4.211)

## No metric Fixes (compared to v5.4.211)

## Test result summary
total: 95512, pass: 83135, fail: 739, skip: 11232, xfail: 406

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 302 total, 302 passed, 0 failed
* arm64: 61 total, 57 passed, 4 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 45 total, 45 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 54 total, 54 passed, 0 failed
* riscv: 27 total, 26 passed, 1 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 54 total, 52 passed, 2 failed

## Test suites summary
* fwts
* igt-gpu-tools
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
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* packetdrill
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
