Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE7E5962F2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 21:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbiHPTPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 15:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiHPTP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:15:29 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204707CABA
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 12:15:28 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x21so14744147edd.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 12:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lbIiXZwxXW+M91c5+qpLyzzgZJutGrzbcfgyiGVtLXo=;
        b=DkCrTb0plSVczGLD++l1FQ3s/SzSdF7EiY8XFdhhTnxZH8Gbr4jXqH8wrtezrjMnWj
         HpRhp7vt/Hkuu+Wa7IvyNGh1ykcifw7QKxQTXwEh6jRaGKE+/1vstD0utPb1bRVhdtip
         118REcer5Gxwt5yH/5yDFHz7/WsqB2gLh7sT2xgSfEvdT3aW+i3I3HM2TaYB584gEzJa
         T34iOISwIZDYwW8UuAJWYsLWcrBz/ef4CIf4FvtUID6afHuVE2x+che7dkzfhwKA9vrp
         9iu73vRevjiDxlNab58mKxDaC6ZhI8gpBDYIPR5wRmq0mRuEJuAIBVfUozpVKHMdFkAg
         b/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lbIiXZwxXW+M91c5+qpLyzzgZJutGrzbcfgyiGVtLXo=;
        b=7d3306AG7zuI1sFgnQT4cvHnSbzam5pOq+UoHfCp6aPxFXaY5rjLXYmmNX1HFesGSC
         u3uoMM+nX47GVtIv27hb1Yh2Zs+/gaCVvc3tTpgvU/hPIY5K4+eXIQQIAY/hZ6UIFCSO
         HYTitIlxGLDCwXig7JmVNz1t8kBkPBqSsNtoHAprHKJ1IoLaafMqljvN6YcEvUUPPlV4
         dtd93AlcSsxgxZkT5Vhfxl30A+LzIqbrTi+9bHoT2UatTevo4TRJKQRwJf8KtzBKPB0S
         uxuwHgmp8bbxp/mlc5J5BbRJMUZ4YuWo2HDtnEcxj+1wTi1Ah2p4n1rYtXGhZeGvip5p
         1Hrw==
X-Gm-Message-State: ACgBeo3nUPKNTtKDqT3Ve8DxtsJW9OAQTljJsELFVTgw034/1R4c4ulj
        DcT/CjqU16QVzbp1CNa+ShgQjEGYZ6Thr21tevOhZQ==
X-Google-Smtp-Source: AA6agR6O6e3VfxJuLJEbFc+rVrjoYZuFsoP4MB85PERgE9WEZQOdg0r8DXw9BVI7yQafzURkruqjTju7dOsSDTPc8/k=
X-Received: by 2002:a05:6402:32a8:b0:43e:5490:295f with SMTP id
 f40-20020a05640232a800b0043e5490295fmr19926443eda.193.1660677326493; Tue, 16
 Aug 2022 12:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220816124604.978842485@linuxfoundation.org>
In-Reply-To: <20220816124604.978842485@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 17 Aug 2022 00:45:14 +0530
Message-ID: <CA+G9fYuhJw5vW7A8Wsqe_+fNK4pWCGdQ+0zfkNyd3y7_X0=CBA@mail.gmail.com>
Subject: Re: [PATCH 5.18 0000/1094] 5.18.18-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com, Maxime Ripard <maxime@cerno.tech>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
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

On Tue, 16 Aug 2022 at 18:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.18.18 release.
> There are 1094 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Aug 2022 12:43:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.18.18-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
Following warning found on both 5.19 and 5.18 on Rpi4 device
Which was already reported by on mainline kernel on June 30.

WARNING: CPU: 0 PID: 246 at drivers/gpu/drm/vc4/vc4_hdmi_regs.h:487
vc5_hdmi_reset+0x1f0/0x240 [vc4]

 - https://lore.kernel.org/all/CA+G9fYve16J7=4f+WAVrTUspxkKA+3BonHzGyk8VP=U+D9irOQ@mail.gmail.com/
 - https://lists.freedesktop.org/archives/dri-devel/2022-June/362244.html

## Build
* kernel: 5.18.18-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.18.y
* git commit: 8e2f0ee8f479ff0a9978613fd90b3f3fc9b9c6d3
* git describe: v5.18.17-1095-g8e2f0ee8f479
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.18.y/build/v5.18.17-1095-g8e2f0ee8f479

## No test Regressions (compared to v5.18.16-36-g732bf05a92ab)

## No metric Regressions (compared to v5.18.16-36-g732bf05a92ab)

## No test Fixes (compared to v5.18.16-36-g732bf05a92ab)

## No metric Fixes (compared to v5.18.16-36-g732bf05a92ab)

## Test result summary
total: 136961, pass: 122301, fail: 928, skip: 12808, xfail: 924

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 306 total, 302 passed, 4 failed
* arm64: 68 total, 66 passed, 2 failed
* i386: 57 total, 51 passed, 6 failed
* mips: 50 total, 47 passed, 3 failed
* parisc: 14 total, 14 passed, 0 failed
* powerpc: 65 total, 56 passed, 9 failed
* riscv: 32 total, 27 passed, 5 failed
* s390: 23 total, 20 passed, 3 failed
* sh: 26 total, 24 passed, 2 failed
* sparc: 14 total, 14 passed, 0 failed
* x86_64: 61 total, 59 passed, 2 failed

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
* rcutorture
* ssuite
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
