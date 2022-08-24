Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B043D59F3B7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbiHXGoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 02:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbiHXGn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:43:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357EA85FD1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:43:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u15so22958570ejt.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ydivvUQcDWHH/FLO6NNb72Cm7e6SYijKKw7aBMSJCtE=;
        b=Xa/sQDDmG9nUciyjYbCNexIgOWKzsVCgcJXu7DBX0i4SnZ1w/Wz25ojfR33hmX1kHO
         HzJHFZlkCeTajeTWjNV38Fj++x+lDcUSv3398OEcCv3rHViwUB3dgWOltdLECavT0EpC
         OcM53Cm3sql9XWdwM0u3sMSb7pYmpNjoCgDk7ymP5oz4rCJSmKxnP8mzTywnPMYekJ/N
         RWxVrXVrlFadpD8cFBfobHhf3iEQsOZ4k9Q3GHsXNToAzqFKpIXa5IdA00QM9/AL+alD
         efAGx1sDmT0Zm8tg1dErsPcLJNTH5pq9vDvSVDuYlAQnOiQ6dEchm+/+x7BODDQgYVJe
         CWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ydivvUQcDWHH/FLO6NNb72Cm7e6SYijKKw7aBMSJCtE=;
        b=k27iecsBj1NFs4lQ0/tO13B5XBjmXX8c6M4i2PL5FVOR6OFY/haK46UFRdlgT/l+2Z
         sK499x7fIPTiKupW2uCNWZyuqnTX7dqNQ/wt63QkHIteP+PdST+xepLBgmzp5i9KabFW
         sWATNEqqD4GsFNjhUonZgLv9eiXVs9V+0VKUyvICekR0Q68w1o7WgHKzT5256vUNqxiG
         P7cAS2iM002E49Eya+s4ON86Rkhl4TwsmTnfhyoL8vzP5DUna/Lu5sovy5OLgY7nDgUZ
         tS5IMQqxscmgSnDKTKkZzgUrhapP2By3RJLOqdp+msHMdhwZLRgZIIWeQt3bb23RzdsO
         v8Kw==
X-Gm-Message-State: ACgBeo17BPS23mJHgAsdki9RPEi9E61xdZXvdGcGvuze0eRNrNj01MVP
        3DsaG5CJHmjFcZFO8G7zUQn/oCgIl/jJWyaDq0fBUQ==
X-Google-Smtp-Source: AA6agR7uzdwANJpUYenscEQMkqs/AEydClKKlKYLe9g7i1z27DuSwuXbl+z31oXGEtW9ZiY4Llai117Ou5HMHWUMJcU=
X-Received: by 2002:a17:907:e8c:b0:73d:8146:9aa1 with SMTP id
 ho12-20020a1709070e8c00b0073d81469aa1mr1901406ejc.253.1661323434561; Tue, 23
 Aug 2022 23:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220823080100.268827165@linuxfoundation.org>
In-Reply-To: <20220823080100.268827165@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 24 Aug 2022 12:13:42 +0530
Message-ID: <CA+G9fYtfphkbm4nM0_UFqqA8LDfZ7A4i1YLvnQzf=4dNwyYfXQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/287] 4.19.256-rc1 review
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022 at 14:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.256 release.
> There are 287 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Aug 2022 08:00:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.256-rc1.gz
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
* kernel: 4.19.256-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: 9901269a16d1de19c9264e1d333ac7cb74c0cbeb
* git describe: v4.19.255-288-g9901269a16d1
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.255-288-g9901269a16d1

## No test Regressions (compared to v4.19.255)

## No metric Regressions (compared to v4.19.255)

## No test Fixes (compared to v4.19.255)

## No metric Fixes (compared to v4.19.255)

## Test result summary
total: 118642, pass: 106812, fail: 962, skip: 10495, xfail: 373

## Build Summary
* arc: 20 total, 20 passed, 0 failed
* arm: 581 total, 571 passed, 10 failed
* arm64: 116 total, 114 passed, 2 failed
* i386: 52 total, 50 passed, 2 failed
* mips: 70 total, 70 passed, 0 failed
* parisc: 24 total, 24 passed, 0 failed
* powerpc: 108 total, 108 passed, 0 failed
* s390: 24 total, 24 passed, 0 failed
* sh: 48 total, 48 passed, 0 failed
* sparc: 24 total, 24 passed, 0 failed
* x86_64: 104 total, 102 passed, 2 failed

## Test suites summary
* fwts
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
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
