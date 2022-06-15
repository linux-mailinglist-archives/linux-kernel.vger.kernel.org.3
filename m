Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14EB54D087
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358220AbiFOR7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351546AbiFOR7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:59:07 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3451229379
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:59:06 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id r82so21786701ybc.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Kq0b6mU5KjZXujIi/NoS9bD6ei6a4n3KRsk6IuQrJk=;
        b=A4BBHubXCjgVVY76OOJQjIUL2g3oN+jqc+oxXgusEJWgUpCzvUtvfl/zmIAusHqyia
         mVzTEI/2K6V0NPjtK6jOK8peqDCqhVgpRwhp8jXXkiJJZYZqE2asXlj2keNr/tu5p+E+
         CNkeZkrYPs/ckCofULDeymHBbh3rBaAYfGgK+PSxU0UgYg9Xsb7P+bM2pq8Zgk/e+FgE
         p/v6nU0Mgx7M/h4F9esG9LRuJq8Ota0Jd/BpQ7gx3PGi+/wez7tVJpBlOYTj/NodQ8OJ
         UFC5qlSdhnRn/acDlaVAPvP/+/E8AGyIOZXoipetFREXnHUOgi811aX4f0qRSSDKrUzM
         eymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Kq0b6mU5KjZXujIi/NoS9bD6ei6a4n3KRsk6IuQrJk=;
        b=Q8Ox8YP+IXzeX/j1oV7yejQmgdMYYRliB7UBo1GWjTUKRmYTjuIHmTZs2Y5lBxKfkr
         0UcGoueqs7UEtxyHrAM5Bu9iAfBa8BHI1kmeYs0dN0DVCdZkKb69imLBNUtbUXS5nM/w
         6y7Ee22I7vJhAbLu7buXJBg+tlReNCJwzR+FnxRxvUy/rY32zJj16Q4opWdE/l+Zo+sQ
         eUA5F6S35W78/kEVK9hm/X/9+IE5TB3zaopxV318zvSc2W0xFrBAHBumYKd2sYGQKv9L
         wDVl5R21D6K8aGVC3F3P50k5ooljPP64fzLOn/r6wRpVjuutqvrGJ2Gpehj5f6cMB+0n
         6QpA==
X-Gm-Message-State: AJIora8EV2IiniD0qVv2ybghrg6+i9WTw4+M1uT62pbShP72v7HOI8yT
        elAGCIas34UIvLbIrKlUCfsLRdw8MGRMu+/jEFuNaQ==
X-Google-Smtp-Source: AGRyM1vjqOfkM3gFxn+FF0W4BzIQ7xP06PBMeEQaaW2pCXHKkSndV50Idup39Ub9p4mh3FZ51Qxe/TB3YvfQyT15Hlo=
X-Received: by 2002:a25:3b52:0:b0:665:f89b:708b with SMTP id
 i79-20020a253b52000000b00665f89b708bmr1048982yba.483.1655315945152; Wed, 15
 Jun 2022 10:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220614183723.328825625@linuxfoundation.org>
In-Reply-To: <20220614183723.328825625@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 15 Jun 2022 23:28:54 +0530
Message-ID: <CA+G9fYuikNPmQB-E045j10fWoR5jJBbOq6pGkFrs4Coji0px4g@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/20] 4.14.284-rc1 review
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

On Wed, 15 Jun 2022 at 00:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.284 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 16 Jun 2022 18:37:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.284-rc1.gz
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
* kernel: 4.14.284-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: bddb08ba46c857f280bca2f865bd7ef59ac8f90a
* git describe: v4.14.283-21-gbddb08ba46c8
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.283-21-gbddb08ba46c8

## Test Regressions (compared to v4.14.283)
No test regressions found.

## Metric Regressions (compared to v4.14.283)
No metric regressions found.

## Test Fixes (compared to v4.14.283)
No test fixes found.

## Metric Fixes (compared to v4.14.283)
No metric fixes found.

## Test result summary
total: 98364, pass: 87114, fail: 190, skip: 10024, xfail: 1036

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 293 total, 287 passed, 6 failed
* arm64: 52 total, 45 passed, 7 failed
* i386: 27 total, 23 passed, 4 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 16 total, 16 passed, 0 failed
* s390: 12 total, 9 passed, 3 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 49 total, 47 passed, 2 failed

## Test suites summary
* fwts
* igt-gpu-tools
* kunit
* kvm-unit-tests
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-cap_bounds-tests
* ltp-commands
* ltp-commands-tests
* ltp-containers
* ltp-containers-tests
* ltp-controllers
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests
* ltp-fcntl-locktests-tests
* ltp-filecaps
* ltp-filecaps-tests
* ltp-fs
* ltp-fs-tests
* ltp-fs_bind
* ltp-fs_bind-tests
* ltp-fs_perms_simple
* ltp-fs_perms_simple-tests
* ltp-fsx
* ltp-fsx-tests
* ltp-hugetlb
* ltp-hugetlb-tests
* ltp-io
* ltp-io-tests
* ltp-ipc
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty
* ltp-pty-tests
* ltp-sched
* ltp-sched-tests
* ltp-securebits
* ltp-securebits-tests
* ltp-smoke
* ltp-syscalls-tests
* ltp-tracing-tests
* network-basic-tests
* packetdrill
* rcutorture
* ssuite
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
