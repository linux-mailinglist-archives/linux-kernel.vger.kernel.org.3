Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C21C57B413
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbiGTJnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiGTJnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:43:12 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7791564E27
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:43:11 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id o16-20020a9d4110000000b0061cac66bd6dso5281161ote.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hF1cdP0fG4ahpcF1th7ce9yHarDJkEwd60OZI8Yz/JM=;
        b=SjKWZuuQRB2pwP7vDhTo+KDBg5Yi5pSxrwyC/ATBKTO7WIRDGizOo1JQdrT1PU0ohS
         tcLiYjfZsMdsh6xLK6SZtoGXB+w5K0HOj2FJkIPG0GrU1nOBF8cmMi3R8xkoO/x1mXfj
         hcttI/ijFd+jn7iPrd1QmewFsxL0Jkwnj4HPzAiHo/qvVUcCO1yexdryA4o0jC4d5OqP
         caEutWl9pwEUYG2n+TIct8O+v4q3CtK7qsb0xja69Q8fnMv+E/VYd+SRNLe2eALoMxVG
         OV2VraUgQW+IbKi2kjs7hMpqnwyKD/oJpAFqGZqJbv2YIQt5U840qA0KDk/gmrcBbIEM
         w7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hF1cdP0fG4ahpcF1th7ce9yHarDJkEwd60OZI8Yz/JM=;
        b=s61W6Hrz6tIM3j1cwCgDBLzqmPLhxbtFZdpQ4xjNWj8jj9ThMU1KZoLu7hRiwtzHDh
         PGToVCNNmX0EtmXtqdqjkDqyZhLgYvlOM81nQV5UegXjtXfr5x6YZVW550zEgINHj3wS
         jBmFaZi/YTvpdJBuwj51lnccJwOTFUon0LrmoveTrfnJmN/Rpxi68FtBgS90G8G/vIv7
         Pt2YhoKX7Di17KGtaZtEeayIutq3ZbRBsTG/JjrBXk34E+mWMFI7/zGhh3iqvMqwxM5/
         C84tvI6YufmIrKMF5idwdUf40VecY3E2IljuvowMwB8CuFXVyHGRNeqGtotOCSvt/gBi
         BdMA==
X-Gm-Message-State: AJIora98OBQnDJ1JASTvYQoNDzH3Oc1hQ+RxAObiayGrfPQ/jt4zK5RN
        /UdLwD2dzWxJvGzpEwPsxezMDj6tJMpXRC88yKOF0xKzAr/PgQ==
X-Google-Smtp-Source: AGRyM1sUYW8Q7/QlM8hj0ix520Ikjh2NGngg+x3SfVBwcQuDW18v58eaB1hdSzbEONcDJVQjdFasufWYM4tMo1VBtBw=
X-Received: by 2002:a9d:6ace:0:b0:61c:8270:a04a with SMTP id
 m14-20020a9d6ace000000b0061c8270a04amr10680774otq.134.1658310190663; Wed, 20
 Jul 2022 02:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220719114552.477018590@linuxfoundation.org>
In-Reply-To: <20220719114552.477018590@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 20 Jul 2022 15:12:59 +0530
Message-ID: <CA+G9fYubQWYWQLp6oSeLcX62mmgs2JJwxBdSdRDMr5QP1EjftQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/71] 5.4.207-rc1 review
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 at 17:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.207 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 21 Jul 2022 11:43:40 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.207-rc1.gz
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
* kernel: 5.4.207-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 0b5688944207ade9aea3eabc48e296ff5a72a529
* git describe: v5.4.206-72-g0b5688944207
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
06-72-g0b5688944207

## Test Regressions (compared to v5.4.206)
No test regressions found.

## Metric Regressions (compared to v5.4.206)
No metric regressions found.

## Test Fixes (compared to v5.4.206)
No test fixes found.

## Metric Fixes (compared to v5.4.206)
No metric fixes found.

## Test result summary
total: 126185, pass: 112707, fail: 727, skip: 11723, xfail: 1028

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 307 total, 307 passed, 0 failed
* arm64: 61 total, 57 passed, 4 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 45 total, 45 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 54 total, 54 passed, 0 failed
* riscv: 27 total, 27 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 55 total, 53 passed, 2 failed

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
* perf
* perf/Zstd-perf.data-compression
* rcutorture
* ssuite
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
