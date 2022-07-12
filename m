Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1314571535
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiGLI71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiGLI7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:59:24 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D1D31345
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:59:23 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id y3so7232403iof.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sG+7V/3ip991155uNUZ0zbm/oLWtU/YYZZD/N2zdjXA=;
        b=ze+8iFhyzcgFTWnxCo0j8sP0zH+lMb9WsHV+cOcY6xb5DalKSUvhSLcgi7SWqb/3x6
         elspNdg9ZPri7j30/sz/fikgZDzYsU0CGEdNaMJ+G9oORD0smaGrgJRynUCD7pki0xDX
         3bn2HNCn85BpAk1WBEqBRcjgpH3TIcCOCShOEkAb7BBNlJV+tZUE3By1ybHFY7WWy0+P
         vRpd6t8wCajizSnOcT66ajY6Sq/B7x7GNb0iVOfNURfHFjrwn6RNTTAsaTeHq4v+n07k
         3XZQyxCGtAxbKhn7uoGKBruZmm6dxkr+74/pktXgv3WmhX1zhh1eDSqQ2e3JZR30Z38Q
         q7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sG+7V/3ip991155uNUZ0zbm/oLWtU/YYZZD/N2zdjXA=;
        b=QyMQ7nBP7AOcEYWKL/BwRo/j2F78s28hJbbfA5QNfjqKZQOqL5htoKZucoQqoHVxaX
         5WsYts2ZGUZDbgk47bQy8VMR/L5lln+iiAywkh9BV8MEX3nn48jrg/LS0agPgmrrccT+
         s4s7Ss1QvvqDLWrUtmLikAG6PiBN0NI5FdA42zHPG9Vv0Xh0FBBAMvKYdwEFfwwaG/HV
         Oaea/kI0XOSlfo8JC/+Vc/mHX/nGdN4t3d5prN2bs6YprIsRs7D+VosLESbMYq/t6lWs
         bcz5mphlqzmSOZUddQxCWpzXeqARmrOtw8WJ7qvN5ahENI9KEe9Gzuk4NsgQsn+vN4Qf
         GQ2Q==
X-Gm-Message-State: AJIora+BGbp06NtxGOZ2X9c4KzmSd92C/auxp+QmCqUNbAKLgoWl1Zzc
        cYBnHV4ia+gRVq8uRYRpft6AArj43s55pt77rcyfcQ==
X-Google-Smtp-Source: AGRyM1tgVu8qDmag7XKjzKTHkBCkPk0K0mN15I+IaJE3sJ07kYsPOps0RH3De/uO7wRWYoXjfeORgikLcazxvVnkZqU=
X-Received: by 2002:a05:6638:2a9:b0:33f:2d29:7546 with SMTP id
 d9-20020a05663802a900b0033f2d297546mr12685969jaq.27.1657616361456; Tue, 12
 Jul 2022 01:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220711090535.517697227@linuxfoundation.org>
In-Reply-To: <20220711090535.517697227@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Jul 2022 14:29:10 +0530
Message-ID: <CA+G9fYuy5KTLHW2AG8tpiQH_8x6f=e3HG6XG40CuVwDMCq+Qgg@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/14] 4.9.323-rc1 review
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

On Mon, 11 Jul 2022 at 14:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.323 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 13 Jul 2022 09:05:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.323-rc1.gz
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
* kernel: 4.9.323-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.9.y
* git commit: 7df08530a33bb6dc5074e43d56c71476ca2b4455
* git describe: v4.9.322-15-g7df08530a33b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.y/build/v4.9.3=
22-15-g7df08530a33b

## Test Regressions (compared to v4.9.322)
No test regressions found.

## Metric Regressions (compared to v4.9.322)
No metric regressions found.

## Test Fixes (compared to v4.9.322)
No test fixes found.

## Metric Fixes (compared to v4.9.322)
No metric fixes found.

## Test result summary
total: 88746, pass: 78270, fail: 325, skip: 9033, xfail: 1118

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 254 total, 249 passed, 5 failed
* arm64: 50 total, 43 passed, 7 failed
* i386: 26 total, 23 passed, 3 failed
* mips: 33 total, 33 passed, 0 failed
* parisc: 12 total, 0 passed, 12 failed
* powerpc: 36 total, 16 passed, 20 failed
* s390: 12 total, 9 passed, 3 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 45 total, 44 passed, 1 failed

## Test suites summary
* fwts
* igt-gpu-tools
* kunit
* kvm-unit-tests
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
* ssuite
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
