Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F835AF5BD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiIFUVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiIFUVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:21:01 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC3C6EF04
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:20:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r4so16642543edi.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 13:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=xgqtpFYeImQmfiByKGLHHb3o58b4i3/JLUBGIVs0rt8=;
        b=M3cJI7if2XWRe7fxFqlgPPKLqtHhY1f1oE0QPdTzZmwBNdO1ZwRjYHplIKZ9ox4y+k
         6Kv1RJo2ljbEUrBrpIhd6mlAZzoluH2SxBabc48qOp8uF6xz+2/OcNLN3cj7L3BKIKe1
         E/Nwfmo2I4qACE6BCm75BykS5tccVMIEOCJCQ+jTonZ/m/Q75W+94s6Czh7rwvDWnkxt
         BQ8U5ZqrIQCoZBK8lbAM4thKiVpZixD3YsI/HLeLPPrGKAZZ74vvjefdqFuBuziizdJ3
         WqRsRV36sgzLkeFxZB5qy9i/5tHm3oFqGVfNVaPUZv+f6E/fmgtDcc9hPEEd17ivZIZK
         treQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xgqtpFYeImQmfiByKGLHHb3o58b4i3/JLUBGIVs0rt8=;
        b=u03CVO4/n8Yd5hVptOKbxJF580yQVlZJqVuI6Yuk74vIO4X8YkmIiKmlYxSr3impIH
         XM6aqYhRaxuqNdOdx6m9Ag86VuhH42ztRTsWxnTShqnZVtDt6HOz/KG4AD3aM+Ry+M9E
         ZrTOrcVyzspFIsezGwgt2Pzne5ZGXmJqVN5D35tJY3ruBE9mEZ8V+gEhU6P9elt7TnSJ
         UC3Z/EYYP8pcDeO/gqM4f208fl7zRyU6HuAqUjJDGTxvHhK4I/xsyMeh3/XD1zO6aU1F
         L8i24tb91bWXxtzNGxD5X/6TAinhHr4lowhf03ittSacmY8Yk1mvn5wYqPRLVvDrGt0N
         HadQ==
X-Gm-Message-State: ACgBeo1K8+V4vLLmpCN60pdasn9lrT027FW/mxaLyvbHe/VTLAoEgYGE
        bq6MpM+otQi9EOQGPKOFbWuG1SzyYDvvQJWj80fl0Q==
X-Google-Smtp-Source: AA6agR4SDhAUP65TRQjxYheaA176e85sRvVDxNM+sdq7QwudOZHUohQzZKoh4MA7eyv1GG+G2ekjy06D+KNQkqts2Dc=
X-Received: by 2002:a05:6402:27cd:b0:44e:c4aa:5ff with SMTP id
 c13-20020a05640227cd00b0044ec4aa05ffmr272878ede.193.1662495616035; Tue, 06
 Sep 2022 13:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220906132821.713989422@linuxfoundation.org>
In-Reply-To: <20220906132821.713989422@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 7 Sep 2022 01:50:04 +0530
Message-ID: <CA+G9fYv5twyvMr==HQ2tUs1D5thFS1Pr32ydeSsVptihq-FO_g@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/107] 5.15.66-rc1 review
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

On Tue, 6 Sept 2022 at 19:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.66 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 08 Sep 2022 13:27:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.66-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.66-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 78a6337a09dea696f5296f00bf8ae5e5283eef89
* git describe: v5.15.63-319-g78a6337a09de
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.63-319-g78a6337a09de

## No test Regressions (compared to v5.15.63-211-gad2e22e028e7)

## No metric Regressions (compared to v5.15.63-211-gad2e22e028e7)

## No test Fixes (compared to v5.15.63-211-gad2e22e028e7)

## No metric Fixes (compared to v5.15.63-211-gad2e22e028e7)

## Test result summary
total: 74572, pass: 67375, fail: 420, skip: 6561, xfail: 216

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 333 total, 333 passed, 0 failed
* arm64: 65 total, 63 passed, 2 failed
* i386: 55 total, 53 passed, 2 failed
* mips: 56 total, 56 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 63 total, 63 passed, 0 failed
* riscv: 22 total, 22 passed, 0 failed
* s390: 24 total, 24 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 58 total, 56 passed, 2 failed

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
