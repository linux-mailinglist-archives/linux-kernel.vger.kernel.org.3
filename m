Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3B853D7F9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 19:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbiFDRLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 13:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238936AbiFDRLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 13:11:35 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B3213D26
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 10:11:34 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id e184so18816446ybf.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 10:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pyZHwPc7YrU8dREd74Yltn1iWLZudPge1vYIfnUYTII=;
        b=k9KDmA915yTehX1RPgUdARsjp1afpUljW4i58PPws5HkX9xid+jwYQxH8Zug1hXDG6
         SzB2gdE7KlqR9zvmJ97XifjqG8w8kWYJtJdZ5ZH06DRW+gOSYIiomSSk9WaQpWoK2oQW
         ghrUn+y9f2jX80TfywstExRAfjovPAV1U4LAt6yIzKj8/WEuHZAegEf9cnm4MLzuod84
         OxMfJhMFXv4yVRsCFzS2gkEwSkZYdugU31TupuJkT/+gStu/jvnbeU7+4HFTAw0yCOg2
         ItRtfSS5nSQi20FiNqBvpwgXrACcYvAadW/1TBQTAM+ReF8h/gJHRFmnTk2oZ/6oaT/v
         iH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pyZHwPc7YrU8dREd74Yltn1iWLZudPge1vYIfnUYTII=;
        b=QFfqJ+OHFin1YeYjKK1wfNBQSw40/19a91xcQztOuCKLPRYCSIA29lLaenE6UKOqzr
         RmeJFUe0pEQspXZVBimOV12uhJDttC8zgup5K/AM1UbQWr+XEI3KBn6GOgolAQaeX3Rb
         QHPdwrgYY75my+kGRbIc/e117stIfZBZjExZOQfl57oqN9WkLm1a7ectX1Bk60YvXJ7G
         8TdsV1cnH+QS4GWLvJe0263+RdPpbdq36tJXeOLh1gi3y1sXJMlmKwC8Q6EVHhFDqRnQ
         OKG723ithSPS7PYA9UxLRKoS2bCkADlQA35dDRjzIByZZFRSb/LKBQT1F2EzmDzLmQLR
         fQCw==
X-Gm-Message-State: AOAM533FJxPfFx9HqbGNQRfvZceGpkURPaZ7/e44QKp60ch5C+vVlrjO
        iHuurxChhh4+J2WX+zstqlnRN3B7JzATiHbphvGFKQg+JzB5dg==
X-Google-Smtp-Source: ABdhPJwS2ALavKiTl7PmoWl3wb6mBv3NQIFpEOu12J/H9NOsRdyOAgrQZ8njknEsKqVms/6SkM/+Vr1Zi6z/+YSNIH0=
X-Received: by 2002:a25:4c2:0:b0:65b:a2f7:f39 with SMTP id 185-20020a2504c2000000b0065ba2f70f39mr17276476ybe.592.1654362693213;
 Sat, 04 Jun 2022 10:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220603173820.663747061@linuxfoundation.org>
In-Reply-To: <20220603173820.663747061@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 4 Jun 2022 22:41:21 +0530
Message-ID: <CA+G9fYv8AVoFcu9eg8soTEWu4GJPk=kQPRSNbP8iLvuL3vydmw@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/66] 5.15.45-rc1 review
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

On Fri, 3 Jun 2022 at 23:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.45 release.
> There are 66 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 05 Jun 2022 17:38:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.45-rc1.gz
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
* kernel: 5.15.45-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: c5d3dc2dfc027824f60e0e6913265b16296eceec
* git describe: v5.15.43-213-gc5d3dc2dfc02
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.43-213-gc5d3dc2dfc02

## Test Regressions (compared to v5.15.43-146-g510d04da560c)
No test regressions found.

## Metric Regressions (compared to v5.15.43-146-g510d04da560c)
No metric regressions found.

## Test Fixes (compared to v5.15.43-146-g510d04da560c)
No test fixes found.

## Metric Fixes (compared to v5.15.43-146-g510d04da560c)
No metric fixes found.

## Test result summary
total: 135772, pass: 123116, fail: 230, skip: 11846, xfail: 580

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
* perf/Zstd-perf.data-compression
* rcutorture
* ssuite
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
