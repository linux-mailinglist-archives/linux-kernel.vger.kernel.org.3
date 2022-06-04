Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245B353D7EA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 18:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbiFDQlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 12:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbiFDQlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 12:41:05 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E045E4F9EF
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 09:41:00 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2f83983782fso108849917b3.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 09:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W34zkTcAGXMCI+JYzK3DXat6suzXaOqaAFFGw9mj4EI=;
        b=zhtV/uN5ODIHUpVFbr2+YjzGJPKoATO59r27UZFDVstqIYGhKQMrtx2+gCsTUlVSr/
         /y7R6Fyy33eFPz8AqsYWkNiV3PTb/NV3dYznmpuK9gqSUzzCWBWF51GKMWKKGvjRChUX
         qLzM/rwQfkU6riBCC4n4120f34pjVQnKU/1V6Y7A9IRBmHAPnaJBwpZ7ockeF29gX3Ou
         Vv6xmX1McEUbGFePYajUCCiaEspFpR8cHW2PqU4X2Qq4Apll4Htqg0OR1Jko6cLSrXv/
         mUnqM9lS2LG9TwMTtm215Du5VRBU1I7Yk00cHWyDRQPhPvGp4J9UCs4i65RhcvnG/3d0
         syeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W34zkTcAGXMCI+JYzK3DXat6suzXaOqaAFFGw9mj4EI=;
        b=SLB2gyApf8RQr2Tynh+gY6yDTaS7OjLFGwYuR67BOFZnb5Rf5gg7+8DRXVeI4U5+0U
         hGQQRvdB1f1swoc5d5e0jTBBVr6/bmmmqB89Blkx4XjDcotTNjpWz1yome3te7yw/qBK
         YyfHBF0LLuxJIIVjDIpqPVrjGwmI8h4miGi8PvcVu9Fm1UNqfc8qcd5/+PXJ81P5ZLRP
         Qd3xACiHBACjAVUw/TxbTQcAaI1Ov4ApEAF3O5bh1st0FOVauxx+aW91QGr4KTMJMYR7
         xzMX/3qqUd+eAgwJ202VJ4sEc+JWk+RbZRvqhf+IWkIeb7BTDmLgMMeQnIErvIDf36C2
         4sUw==
X-Gm-Message-State: AOAM532Q68qt0ENycGiyJro4HS64c75Yh0zvBspXjrsnpPJ0sdjubQZ5
        QZdE2JSgsoZFB6BC52FbIhmFrx0f/nXoHTthNkMNTQ==
X-Google-Smtp-Source: ABdhPJyEp6zlhFtYLvUw8xR94hLkxEz9OazTl40HzB2Aw544cSnfZXqh1Q4u4Z3i5daY9y0zrI6Wf9VGmIjw46c7Rj0=
X-Received: by 2002:a81:1a43:0:b0:30c:78b1:f23d with SMTP id
 a64-20020a811a43000000b0030c78b1f23dmr17352064ywa.166.1654360859976; Sat, 04
 Jun 2022 09:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220603173821.749019262@linuxfoundation.org>
In-Reply-To: <20220603173821.749019262@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 4 Jun 2022 22:10:48 +0530
Message-ID: <CA+G9fYvFvMZvogpf6WwKA0Eb-4y2x7wwJ72=5pVsSDTFu8xiXQ@mail.gmail.com>
Subject: Re: [PATCH 5.17 00/75] 5.17.13-rc1 review
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

On Fri, 3 Jun 2022 at 23:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.17.13 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 05 Jun 2022 17:38:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.17.13-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.17.13-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.17.y
* git commit: 30200667e823559c51baeb2bd95c14b144cd8e5c
* git describe: v5.17.11-188-g30200667e823
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.17.y/build/v5.17=
.11-188-g30200667e823

## Test Regressions (compared to v5.17.11-112-g118948632858)
No test regressions found.

## Metric Regressions (compared to v5.17.11-112-g118948632858)
No metric regressions found.

## Test Fixes (compared to v5.17.11-112-g118948632858)
No test fixes found.

## Metric Fixes (compared to v5.17.11-112-g118948632858)
No metric fixes found.

## Test result summary
total: 135943, pass: 122628, fail: 435, skip: 12050, xfail: 830

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 314 total, 314 passed, 0 failed
* arm64: 58 total, 58 passed, 0 failed
* i386: 52 total, 49 passed, 3 failed
* mips: 37 total, 37 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 54 total, 54 passed, 0 failed
* riscv: 22 total, 22 passed, 0 failed
* s390: 21 total, 21 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 56 total, 55 passed, 1 failed

## Test suites summary
* fwts
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-cap_bounds-tests
* ltp-commands
* ltp-commands-tests
* ltp-containers
* ltp-containers-tests
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
* ltp-sched-tests
* ltp-securebits
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
