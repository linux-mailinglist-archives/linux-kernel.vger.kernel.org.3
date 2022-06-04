Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9039B53D819
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 20:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239296AbiFDSbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 14:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiFDSbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 14:31:41 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9557D2CDD1
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 11:31:38 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id v22so19042364ybd.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 11:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b7Wzo4q6WiidWVfF6tif0mL6TBctH+VSiUVjalEqAqc=;
        b=XH8F4GRaPg4EKgzniBiglO9cLqDFXkKaM3tgKQT1ltHGLvTfB3ZMDu6LoYq9Pv9fP3
         w0IfSYbzMiCTj+kOttc40mX+CNQAhejs3faso+Q3SHyOF6xBb+X9Hde8bFiZ7a5e6XcO
         eZTdGkw1ktpzMP4UxydNUHiBvdoQJw+I6rrPd4muBc9kb3YV0d9G5+qE68fp196jR6P8
         UbrtgCVXrdjV/uoe4GDWxjdvdFMYcUtHjKh/wRyCKR3l5+o/IvjgEPkxUTrfFZAgcbu3
         WSsv6RPidzH34cZdSBKUNA7VGlwjOnziSRqXO7xfVhiMIG9p64/SV0JKBwtSCbe1913Y
         3+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b7Wzo4q6WiidWVfF6tif0mL6TBctH+VSiUVjalEqAqc=;
        b=B7Kp/+Pt+kmE9LkiR4tCa3KCRZDpJVS6bnnLqzOFA+3Uyyx5w9WNNS92zco0ENhQhw
         VIJQciq2N7bFYpM4tI8YtatO+MrWufnw9lLz6V23To7p9ZCpjd2RLEJiQBdPDr8VkP8L
         bFFTdJCBnSeu9Td+y4kDmyeiI/CZvgR6bYESvSVnvmIW533289qtDeC0z5kcQHbiQJj1
         U7UVDYaIJDaqeI/dljWDDBsfMfc3/huz0flz+bMgGTznCrXWVse3XDWuzA4I0QyAXELC
         fRpHokvlnlL3CzfbMOc9IgcF/xU5EnNYeFpZiroO/PuY9gldivf+WnFityNh5XaI5CBv
         hMMw==
X-Gm-Message-State: AOAM532oKGFy5hTSWPpnuusEKGFf9PwbYSN7EbGe7uh9OgTDQORfdPj2
        YHc67fZRMXB6HaLyErSVQV2K0YI2568wDrJc8S/75Q==
X-Google-Smtp-Source: ABdhPJzQLOiMhCIK0I8VZPo0aIc9wUXIcGROMra2UfpHRcDBFbp4npiMCJlbVSrBk3Q/TENSLjwexYqpzO/eA6WTNn0=
X-Received: by 2002:a25:4705:0:b0:65d:43f8:5652 with SMTP id
 u5-20020a254705000000b0065d43f85652mr16213201yba.389.1654367497556; Sat, 04
 Jun 2022 11:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220603173815.088143764@linuxfoundation.org>
In-Reply-To: <20220603173815.088143764@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 5 Jun 2022 00:01:25 +0530
Message-ID: <CA+G9fYvdXrmRCbGC1RFqv_-Kx4y6QSK3fz0AxBHPR1bCmLTLnA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/30] 4.19.246-rc1 review
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

On Fri, 3 Jun 2022 at 23:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.246 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 05 Jun 2022 17:38:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.246-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.246-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: 8d1c6d3581bb07a2ea5e34376791884a79ff4114
* git describe: v4.19.245-31-g8d1c6d3581bb
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.245-31-g8d1c6d3581bb

## Test Regressions (compared to v4.19.245)
No test regressions found.

## Metric Regressions (compared to v4.19.245)
No metric regressions found.

## Test Fixes (compared to v4.19.245)
No test fixes found.

## Metric Fixes (compared to v4.19.245)
No metric fixes found.

## Test result summary
total: 110351, pass: 98212, fail: 225, skip: 10998, xfail: 916

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 296 total, 290 passed, 6 failed
* arm64: 56 total, 54 passed, 2 failed
* i386: 27 total, 23 passed, 4 failed
* mips: 27 total, 27 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 55 total, 54 passed, 1 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 53 total, 51 passed, 2 failed

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
* rcutorture
* ssuite
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
