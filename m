Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AF253D806
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 19:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbiFDRXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 13:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiFDRX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 13:23:28 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AA62F01A
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 10:23:27 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id g4so18814363ybf.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W2HUDKbWCvAKF/JgWjZx/WrXOQmXx2WEfmReqO7/tjo=;
        b=rYrFYr65vEHDcFfj+samawF0Wq77CVBHnOaY7/K0wgGKik7zUlUi3Y4igLsnUni4Xy
         UX0DAu5J5UUbFjJCrH849/XvhAmIYfFaO5S5Nb7dCFbVzQtMAb6u58APzk8/dOjxEs63
         KbajCoNlCQdPNpq0kD/CBQWwCbGdlSeECI9DOVDOlKo181DsrsBvJWLnxfU26Hd+26ri
         FUqeNQF1h9GGG19tgYTVu+6DPIrfIZmkN+APQi3y1vJYPV+n5T1BuBBwRnQKa9qUVPBf
         MVNewSuJGgYhIupW/a4ECnRpjda97k8iA+vKyrScHGdii8f+SfNaSP0KQk7KN/+1ULQX
         VYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W2HUDKbWCvAKF/JgWjZx/WrXOQmXx2WEfmReqO7/tjo=;
        b=loDoK6p8LCx7UjczIF67Jraiwpe8ZzpT2LTMks/OimZ2vwQZMnXxlUG11IY/xzxbH+
         9jEhyr1IxtabtyG5CUx4xYCNA6gzb7Am7ABD4+dK5IJYwirxWyXZG87Vn09EXHiim/zq
         xtydsYdftsrdlXiu92jehiHeu4Z9YD9szdhR4FbvJEsATpRXTKPOA/grYAjIcWkAqtDj
         eNP02n+D9Lr+pgZdlMyJrrFhF/Xl1Lz0VrBKznorFQpSiyNLq4Xw0dgYPA9hBkt16rgc
         RDXIer1nzAky4GgWONG8viKhbrgZ2WG+PZraOW0Qcko3S+bykl2btL1WUhXXP6IiN1Jo
         /uMQ==
X-Gm-Message-State: AOAM5316RoWblKDReJydYNxTdWr3cA0X3vLZJeBnxh7mf3PO3b1vMtgb
        GG2UKCM9/MhELDXwxUXfvHAj++VVjX2UOIEckKpsqA==
X-Google-Smtp-Source: ABdhPJy/wyBgy5hASpqJbbcMiUrigF1QvG1I/OxG2wCgIFC/i3xocVRr5MRYM9dkJj05V8kvI9517AlY8KcgsRdyvqU=
X-Received: by 2002:a25:4c86:0:b0:663:4381:1675 with SMTP id
 z128-20020a254c86000000b0066343811675mr2537673yba.483.1654363406058; Sat, 04
 Jun 2022 10:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220603173818.716010877@linuxfoundation.org>
In-Reply-To: <20220603173818.716010877@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 4 Jun 2022 22:53:14 +0530
Message-ID: <CA+G9fYtRHKLkd2sP9csOunZ35aTvRhSrHrqiA4MNc3o5J=Pd1w@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/53] 5.10.120-rc1 review
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

On Fri, 3 Jun 2022 at 23:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.120 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 05 Jun 2022 17:38:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.120-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.120-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 22be67db7d5387c15529c9ea2b258d9ef440f324
* git describe: v5.10.118-218-g22be67db7d53
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.118-218-g22be67db7d53

## Test Regressions (compared to v5.10.118-213-gd3ff52320f4a)
No test regressions found.

## Metric Regressions (compared to v5.10.118-213-gd3ff52320f4a)
No metric regressions found.

## Test Fixes (compared to v5.10.118-213-gd3ff52320f4a)
No test fixes found.

## Metric Fixes (compared to v5.10.118-213-gd3ff52320f4a)
No metric fixes found.

## Test result summary
total: 135496, pass: 122646, fail: 200, skip: 11946, xfail: 704

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 314 total, 314 passed, 0 failed
* arm64: 58 total, 58 passed, 0 failed
* i386: 52 total, 49 passed, 3 failed
* mips: 37 total, 37 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 51 total, 51 passed, 0 failed
* riscv: 27 total, 27 passed, 0 failed
* s390: 21 total, 21 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 56 total, 55 passed, 1 failed

## Test suites summary
* fwt[
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
* perf/Zstd-perf.data-compression
* rcutorture
* ssuite
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
