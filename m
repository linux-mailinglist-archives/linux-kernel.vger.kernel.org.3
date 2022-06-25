Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C256F55AA9A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 15:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbiFYNqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 09:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiFYNp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 09:45:57 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2EA1DB
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 06:45:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id q6so10026498eji.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 06:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3gLtTzchzRCx6/L60HUIup56xodUwn+R20BOhxK/3E8=;
        b=Hw9D5MfsLsW4vDn7f79ZrICfbnge6gdTn+BSidUD+K4zSjfXBVUEWLHsEQGBleZYJZ
         HzABkNisShpuhh3blkrfo/U0mdl9I/UgcX0FBXFwLw0ILI9TmeYg5FMjXcXPFkmJ8FJx
         0qMe5rXagrHTn4ZWGBHCeBTNcC5lHEvOjUVmlV25N2eHeqF5Yu3h0XO1SKcjPUOSJvNJ
         89H2EcSCUX4aVDLH0PU+cPt8J490rHju4+5+G35AJ64Y0G3N+Lo36wn2u8/oBW5y58tF
         ftAKlw8jxo6oAylXodmuBgXAZtsGKQlIedrOXDyqom1EbkjIN6Ik7IsgunUM62OOByd8
         yTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3gLtTzchzRCx6/L60HUIup56xodUwn+R20BOhxK/3E8=;
        b=BhKyCzydXk28oRAbdAJfC891aIpBEy9SQithxlQlE6gx49Dli4zNfk0lwXM3MELX/q
         Lk4L5jKVCWWQ9IKVsEXT1OrhGBfoS59B5QeiBtLtgxr77PJZInQSoABTovDJhWhvE9AM
         GS/49DTu1ZFwypjh6Xzdd7RvnMhEBaANqRShMXp8P6Ongdd+HmI0yyZKsJ1SG+uexh0G
         pN/WN8vEnm0CWdkSo5CMjs7wPjoj6Xj5rvUgb6vCFhBqz7vbFHOClKSGJEdDhW/bTgC8
         x/2ADSiuFgYyv2UfFMslhE0HTc9Ly61ejHjyIsRi++SXdfzIbzXz277awpeQpJ6muOJi
         Kt2g==
X-Gm-Message-State: AJIora9xjMRkTwdt/X7plqRYQr9Ehl9cIOdfUFP8tDW9sFhp2EHGQ+Rg
        cMkms+5ID+gYkdcyiuSchK6/CPmqEeHSibjEMt7u6a0Rx/msDQ==
X-Google-Smtp-Source: AGRyM1sVdm9xPPOUXXaiAw2ZzfFLZnTrp/8MXLx5ZzISDZLw11SFqnfqQdIk6O+Ryed7ANLvOcwx7oyAVQp1dRgDDCc=
X-Received: by 2002:a17:906:7315:b0:711:db45:af4c with SMTP id
 di21-20020a170906731500b00711db45af4cmr3805903ejc.412.1656164755455; Sat, 25
 Jun 2022 06:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220623164343.042598055@linuxfoundation.org>
In-Reply-To: <20220623164343.042598055@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 25 Jun 2022 19:15:44 +0530
Message-ID: <CA+G9fYt2UpJwq3qq=YJsRMhmMYKxTwgqFm9YE6Mji3WFztR5zw@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/234] 4.19.249-rc1 review
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

On Thu, 23 Jun 2022 at 22:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.249 release.
> There are 234 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 Jun 2022 16:43:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.249-rc1.gz
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
* kernel: 4.19.249-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: 55129f5675729c290523b53fe49c144a07ad70c9
* git describe: v4.19.248-235-g55129f567572
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.248-235-g55129f567572

## Test Regressions (compared to v4.19.248-227-gc68bb5c7d26a)
No test regressions found.

## Metric Regressions (compared to v4.19.248-227-gc68bb5c7d26a)
No metric regressions found.

## Test Fixes (compared to v4.19.248-227-gc68bb5c7d26a)
No test fixes found.

## Metric Fixes (compared to v4.19.248-227-gc68bb5c7d26a)
No metric fixes found.

## Test result summary
total: 111187, pass: 98232, fail: 248, skip: 11338, xfail: 1369

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 298 total, 292 passed, 6 failed
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
* ltp-sched
* ltp-sched-tests
* ltp-securebits
* ltp-securebits-tests
* ltp-smoke
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
