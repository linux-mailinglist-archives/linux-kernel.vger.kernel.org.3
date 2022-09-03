Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412165ABC46
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 04:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiICCOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 22:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiICCO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 22:14:28 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C9C5FDA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 19:14:25 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r4so4823606edi.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 19:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=XpicBhKE9R0wmCCrq+nZA5/8XAH5F4B7A8JgQJdtO+Y=;
        b=FXIIPRDcE9wU09Pvzf2eiBkMathTzetzd88llzLeQcZAnlUP5c/xv6ydB4kNyba898
         bWt4fhMO4xn1AAnvezK1XGLk9grKPpMtkp7u1OfDZrxPuXY9qo0nLLLt3snSbNuMNcHq
         LZnf7TlczdHSiTlPpLDaVrAh6iFQvbzVEEQPhy3hcq13nGZV/AXxlpl9tfq/Ww1fcbsX
         rksgB9qYmTLYAW2uBUtCYzcx5D6ATCQhUIOBNrP/JyAB7jtnuW2wVIfS24Lzsy+ikexp
         qDxjlR12lQkbs4xJPlbO5V7TTM1Ic3cO2UR48Q4fPxMYdFRlzgjf6/zjYOq1ohvzhKab
         hMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XpicBhKE9R0wmCCrq+nZA5/8XAH5F4B7A8JgQJdtO+Y=;
        b=ifG1rbP55ez+htv/4vf6lhGwt9bO/Rir5V4zZt04ZgFRW3cG5b90iRvibg+5GNotqA
         OxKN7j5q7m0cizBUB3AqqWlINtqQ9nyr9oWf5hWWekWnPMNBa9C5+5FEjPmk+l0X7bvm
         ytuTp8ndu8MdtfblHYCrigKwq3GTJHibpBp/FJGeQeasmWDW3dw2gY03HUr8jBcuHQ9w
         pzDz94A3C9stoZj7n5uCTD1RZ35Fnbk4XoI/8BTH8/bdIuGxebSR8h3qA32ZFv/e5nsS
         RObYYNEsfrRH/4jumEwXsbtmtJQZjDdUL9rIg3gJM9l//XYxuHc+pn1+oHO4YCrX1hiO
         0wFQ==
X-Gm-Message-State: ACgBeo33HLz743JOngJ+nXraXZCxrZQOX2yo1lMztydy+ekeTDbDgRXF
        LqxLLbqeRiggiL8vKEu8p2wuvedCVMfZQ0JuCjXNjQ==
X-Google-Smtp-Source: AA6agR6dLf/tNvsLsh8D1n+VY+51U5Y5sh8KGWJuKeF0IAEbh1JRaCvnBIgs96yIHohkhSHThPkMSexq8wHciIck3Mw=
X-Received: by 2002:a05:6402:447:b0:440:d482:495f with SMTP id
 p7-20020a056402044700b00440d482495fmr36553770edw.264.1662171263851; Fri, 02
 Sep 2022 19:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220902121404.772492078@linuxfoundation.org>
In-Reply-To: <20220902121404.772492078@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 3 Sep 2022 07:44:12 +0530
Message-ID: <CA+G9fYsa+Q+a_OyeqfDAg63srS=yeWrTSG59KVKAuAd3bzrM+Q@mail.gmail.com>
Subject: Re: [PATCH 5.19 00/72] 5.19.7-rc1 review
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

On Fri, 2 Sept 2022 at 18:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.19.7 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 04 Sep 2022 12:13:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.19.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.19.7-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.19.y
* git commit: dd6b2254d7a728898c6d445789248f8a57f7bd97
* git describe: v5.19.4-234-gdd6b2254d7a7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.19.y/build/v5.19.4-234-gdd6b2254d7a7

## No test Regressions (compared to v5.19.4)

## No metric Regressions (compared to v5.19.4)

## No test Fixes (compared to v5.19.4)

## No metric Fixes (compared to v5.19.4)

## Test result summary
total: 115414, pass: 103359, fail: 845, skip: 10906, xfail: 304

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 306 total, 303 passed, 3 failed
* arm64: 68 total, 65 passed, 3 failed
* i386: 57 total, 51 passed, 6 failed
* mips: 50 total, 47 passed, 3 failed
* parisc: 14 total, 14 passed, 0 failed
* powerpc: 65 total, 56 passed, 9 failed
* riscv: 32 total, 26 passed, 6 failed
* s390: 22 total, 20 passed, 2 failed
* sh: 26 total, 24 passed, 2 failed
* sparc: 14 total, 14 passed, 0 failed
* x86_64: 61 total, 58 passed, 3 failed

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
* ltp-smoke
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
