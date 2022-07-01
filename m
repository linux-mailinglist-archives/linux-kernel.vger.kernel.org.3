Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26A5562CC1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiGAHep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiGAHen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:34:43 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AA26B824
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 00:34:42 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id h5so918799ili.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 00:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EvgJ58H7F3gkoDfpj0yWyrX26Ig0srqrD7qFs1ohyr8=;
        b=Au0mH+xD+rnW4V+3aq4cVrFSHVa3DXxC/uZVho2VpQHR+a6sBZVsKSzDbLYR3adxGd
         XVL+4hmBZRTfQxeupl63mlfsksZjnlik3wuG04DSHPsCf91JlTC2o8ckkzKj//S0BNf+
         +7gFaweEJ2u7W8cZM9qfoj5qxOJsZRCdiiAM3imrqGXsi+Z9PzbzY3+FuQGcixokTInb
         uUWdzxFv26uk5okmpGAGlZNrbGEOLkbMEgA15asACj5u7cquloovWc8xUNl7Mk/Mc+I+
         qOQ1M/EKiP0tJlGYY/rL1pJavLorM5D110tu+gblCWGfEQh7ZW4lQgdh3VWQvCZU8pNN
         ApnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EvgJ58H7F3gkoDfpj0yWyrX26Ig0srqrD7qFs1ohyr8=;
        b=mqyWO26s1/c6DO8JAl/LzR7bDbsfE6NNACFgcEBX5c0VGqclE6DQm5hpDQrh9T5964
         2P5Isvoh5V2v5cSbs2SkI+iDWCQpeU40JgpjfEXKwHazsC7ho9a6mX7RbfTsP4xBvXYf
         7Jku/wfcF9XnFwuOXe+DPRPLiI4z0vAGW/5EYHfy4HsIZyIRrDt4xF/kxPJ0Po8b1Nab
         7lzbjI3cW17fFTCb7ZbA7cXiuR/+EhGpsORoE4zBx413ohkOHOMwzoaXdV870NFwQggQ
         9vYLu7C4lc79aeSirYZ+deziGsll08T13dl9WGvIoANftOAmOb0lUjdxlSvrlDCiPGM+
         EAEQ==
X-Gm-Message-State: AJIora+7pBWot+mJ13PhP4K4KSl4gzCABowzBH1DVdL7CexKDAD40pJb
        v3tfyQ7Qv33YCITiqsxkCpM+F9xhzgS94rSxRbIvXg==
X-Google-Smtp-Source: AGRyM1tYIwfJu+Q5i16ztNehsrAy0fbjXvFJXUncWPnfiXs6lepCzgbwArOR4n5XHK0eTWGD+vVkPkoL9MDgxDNqItM=
X-Received: by 2002:a05:6e02:170d:b0:2da:a903:4342 with SMTP id
 u13-20020a056e02170d00b002daa9034342mr8045748ill.92.1656660881260; Fri, 01
 Jul 2022 00:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220630133230.936488203@linuxfoundation.org>
In-Reply-To: <20220630133230.936488203@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 1 Jul 2022 13:04:30 +0530
Message-ID: <CA+G9fYv1C=oA7bO9rQJOGa2AS0UwYF3DsuyU_43me-R4cwG9Qg@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/16] 5.4.203-rc1 review
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

On Thu, 30 Jun 2022 at 19:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.203 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 02 Jul 2022 13:32:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.203-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.203-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 9e421f18b3874909b6cc412c2b93d30ed881c3c8
* git describe: v5.4.202-17-g9e421f18b387
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
02-17-g9e421f18b387

## Test Regressions (compared to v5.4.202)
No test regressions found.

## Metric Regressions (compared to v5.4.202)
No metric regressions found.

## Test Fixes (compared to v5.4.202)
No test fixes found.

## Metric Fixes (compared to v5.4.202)
No metric fixes found.

## Test result summary
total: 123566, pass: 110149, fail: 244, skip: 12178, xfail: 995

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 307 total, 307 passed, 0 failed
* arm64: 61 total, 59 passed, 2 failed
* i386: 28 total, 25 passed, 3 failed
* mips: 48 total, 48 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 54 total, 54 passed, 0 failed
* riscv: 27 total, 27 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 55 total, 54 passed, 1 failed

## Test suites summary
* fwts
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
* perf
* perf/Zstd-perf.data-compression
* rcutorture
* ssuite
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
