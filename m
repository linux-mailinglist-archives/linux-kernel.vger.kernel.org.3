Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924995ABF04
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 14:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiICMvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 08:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiICMvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 08:51:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFA1326C8
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 05:51:33 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id h5so8672477ejb.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 05:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=eJUE8vueEQi2OhFeNkiz80OzcqrMw11t867XDorKxv0=;
        b=ujev9nfmVmJRkKfLJ1a2/bFhFj9xjDNMHRhZe0bqeFk21rubFtUk/pPtQCd7/5nQI3
         zzM9kS7jpA6q6lPR/wAywsZ0xAT4IVI3gt8Rvt7PEheqawp8W9rPvc1JLW0Yg2r+La+W
         jM5wssp6f3IIilsruwM/Zyy84ci/2uu3TfRa8RfkqSCrCoxwoijxD+z4GiiUe2zfpcCU
         BZFNN86h99lPBeNikUrFXorCWjakH5tx9lLRCpFUZCTKpYj91qybAihEjTgsxBK9wb7w
         064xZVVHVaNNaiPE2pLp4KYKZlEERfEzaULITGQByVsdDzgNpHMCO4/H1sCdWJ/TqF5a
         TY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=eJUE8vueEQi2OhFeNkiz80OzcqrMw11t867XDorKxv0=;
        b=KfMURqnbGuvFF8qohahQHhr9KGArpxOEF+0Bu7KkgGIRqwncLwMPnkhjRxNtSzVHMt
         Ea8ivrsp9kNqEcBtABHVqvf8aKiYVOrNl6EDA91WJRQKARsd6VBwtznON+iwA3Ybwn0G
         jQINfAJA4bzqNG5umEeYkTXbYakaPiFo6sTWCUypUGWWZNlVFMo5oxrGQGL1Sgk3CBbI
         05FMZuITUGgQTkpGVVDiaXav4S9+XYJBaJxpuoC7dE6pENSXHhZUJrm425qQt6AZ+tas
         IXJk3qxpo9XxYG2jAIn/41vuLSdBaIhLL0NpExB7ZpDSjw+7D2FR/MSns5IPkYVnD6aQ
         7ATw==
X-Gm-Message-State: ACgBeo05ZDRtLf8OO3OEiCg9zVUhG14FT00Ailo4bl+Yk/NK5ymemQ1y
        A/6Q0JrqgyGHmLSPZXg2gL7dPVWIf7q9SHPcAnyvjw==
X-Google-Smtp-Source: AA6agR61gtKPi6mnWauptBbFoGVShAZvKDU0puKpNic5/NRQ8bUTdqoVfwbWCmH49rTkRqRoksPlqF+5hSEiWKHZQog=
X-Received: by 2002:a17:907:3188:b0:741:4bf7:ec1a with SMTP id
 xe8-20020a170907318800b007414bf7ec1amr24090392ejb.448.1662209491887; Sat, 03
 Sep 2022 05:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220902121400.219861128@linuxfoundation.org>
In-Reply-To: <20220902121400.219861128@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 3 Sep 2022 18:21:20 +0530
Message-ID: <CA+G9fYtiKCOZSrR+KFNGQ5n6P8jkwVhbd79Loxz2Vc9nkFWQ+Q@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/56] 4.19.257-rc1 review
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

On Fri, 2 Sept 2022 at 17:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.257 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 04 Sep 2022 12:13:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.257-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.257-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: 56ebf961480f5507db5b5ff29f49ab7c03b05a24
* git describe: v4.19.256-57-g56ebf961480f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.256-57-g56ebf961480f

## No test Regressions (compared to v4.19.256)

## No metric Regressions (compared to v4.19.256)

## No test Fixes (compared to v4.19.256)

## No metric Fixes (compared to v4.19.256)

## Test result summary
total: 84836, pass: 74060, fail: 668, skip: 9690, xfail: 418

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 291 total, 286 passed, 5 failed
* arm64: 58 total, 57 passed, 1 failed
* i386: 26 total, 25 passed, 1 failed
* mips: 35 total, 35 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 54 total, 54 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 52 total, 51 passed, 1 failed

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
