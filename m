Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22E8562E24
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbiGAI2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbiGAI1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:27:11 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738D571BD8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:25:01 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id y18so1590438iof.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bEdoV5oOIV2jl1vqJSPNJnU+QUv1YM4HTFdff/Y5WYc=;
        b=XBViev+T8VROoSE5N5VwARa9INMHX3+OEeAHAAtyH84hZ4BJHWck1y1pFBkVR3UvUY
         FbiRnMVxR4YNZEv+YmUTUSR7UlPgOxBRZNr5Bdn8e1e8Iqxt7ct9tZ9Dk8/0sRJy29Wm
         LSleNFr5Cp7naxS0LPp8b22PqonpfgQI5L0OQy7shTZtMuDDW1VtHNQFUuOXRWHPQhmW
         YXlDh47stfh8ylwg2oXVpAW22/WcNy1oeO/5p+2o2afXA1hC0pDP32y5d1uOZiah9jKx
         PANQ9DkTCXWk3w6lYNqns5XfML+iVVoy4/O9Gm44rLdPYagzZeFXTAoY9YyHoMntH6/h
         b47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bEdoV5oOIV2jl1vqJSPNJnU+QUv1YM4HTFdff/Y5WYc=;
        b=gV676euth9OdpJHOcP8dFUEQ3nPGWsArGCeMEFH9wPZcJUN4MKnVyU5F6m43rb5C28
         2Z7SWMVuUr0XhtrxWlAL1aloMIA4EM7op9s2Ouo9inLGrqLOQjYqtR3UYsyrmXvocKpV
         tJJjinApy1679omjbBhkPK70ILzhhLP0Q66QrPqTVY5+NvWUNgFRE2qbxu0EFKdh3vM4
         JirwuSneTepJx+wDpj6yxybmvZneSmfSJ5RPPWYOc1TY0s8vCO88Pdl5NiF9a2NnV/F6
         XwREtx3EtDezVBNtAyytFDerJi2DFsCyL+Uz/OlIGD5UjrY02W0ioIrnzy2/1zr6ppZY
         /JxQ==
X-Gm-Message-State: AJIora+xa5eFH0WZ/eoCVClDbrDTAPhQIiBqIKGrmMN49iUud0bm6Tjl
        2QUHdyPNsVl/9EpeL1BGbwsrciRR4SSrL3w3Vk1kjQ==
X-Google-Smtp-Source: AGRyM1s3bEkLQUNGZgvLldgF+fX9j1lbEFQ2V7hqYGtpEds1xMHNBeR51K21Tb4im1MuU6+fCkIfZnSAhfdleKCRdM4=
X-Received: by 2002:a05:6638:14d1:b0:339:e8ea:a7c4 with SMTP id
 l17-20020a05663814d100b00339e8eaa7c4mr8292127jak.309.1656663900400; Fri, 01
 Jul 2022 01:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220630133231.200642128@linuxfoundation.org>
In-Reply-To: <20220630133231.200642128@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 1 Jul 2022 13:54:48 +0530
Message-ID: <CA+G9fYsB-nKD+z4YehGG407ftJunFJ0f7rx1y7Aednf2pi79ng@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/29] 4.9.321-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com, Masahiro Yamada <masahiroy@kernel.org>
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

On Thu, 30 Jun 2022 at 19:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.321 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 02 Jul 2022 13:32:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.321-rc1.gz
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

NOTE:
while building arm and arm64 kernel Image the following warning noticed
on stable rc 4.19, 4.14 and 4.9 branches.

WARNING: modpost: Found 1 section mismatch(es).

Build link:
https://builds.tuxbuild.com/2BIbqrrHp8Y7QNMu8Qt7AmNY72K/

## Build
* kernel: 4.9.321-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.9.y
* git commit: 32e4012394718d2eabab7e19b3c5787f5d3cd368
* git describe: v4.9.320-30-g32e401239471
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.y/build/v4.9.3=
20-30-g32e401239471

## Test Regressions (compared to v4.9.320)
No test regressions found.

## Metric Regressions (compared to v4.9.320)
No metric regressions found.

## Test Fixes (compared to v4.9.320)
No test fixes found.

## Metric Fixes (compared to v4.9.320)
No metric fixes found.

## Test result summary
total: 92818, pass: 81590, fail: 194, skip: 9916, xfail: 1118

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 255 total, 249 passed, 6 failed
* arm64: 51 total, 43 passed, 8 failed
* i386: 27 total, 23 passed, 4 failed
* mips: 33 total, 33 passed, 0 failed
* parisc: 12 total, 0 passed, 12 failed
* powerpc: 36 total, 16 passed, 20 failed
* s390: 12 total, 9 passed, 3 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 46 total, 44 passed, 2 failed

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
