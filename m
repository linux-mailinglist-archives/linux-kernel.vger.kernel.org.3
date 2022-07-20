Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B13057B4B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiGTKrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiGTKr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:47:26 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E256B74E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:47:25 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id tk8so20972586ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G1h5HG2+vqxnIBWwGhwq1fT3aCH3eVF1Bq0cjh5HIgE=;
        b=zm/Eu/bRB49zto7IXIpBzZc/wNdhHXkpCNptxd4i0dV/dMsEZjNM7TmXULN/B7Y6WK
         hN+mw0lq7bHVE7ARXuJ3IxpV5zdVCgDecD15u1HD3vXpECAozUKutVQWmRCf7Novg0RM
         4rRU8Ki+koHu6QySH4mDGV/WtDfZ3e4hobAARwbdEAdhLoYnNM7SbU1A3VMgH43oTSsw
         oQhoXlfokv0W1Kr7aIVqv5Zo7Njh4QhlBGot0AkGqXtfyo2R+8LrQ5dbo1A3vnEwwcp6
         llJKelauM/q4tHF3M0fbWd4GoiLGL4CVTn18Q8icFrfkao1iZm4JmtlLixnPUeXjIbfW
         cBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G1h5HG2+vqxnIBWwGhwq1fT3aCH3eVF1Bq0cjh5HIgE=;
        b=zAU+YV9smIMmXZaE28DxeIX6deO4W8BffsQwwZYPZr62NObiZKejd/vc49rydym47V
         VYzEUH85AhQeEHkNwPIlXI5VOGUdKX7EYDJqjiK6E15zGYxRA3yBSBCieUNDqxF+bi3t
         4GXn0W3IQN4nAbGL4Al5wDU9uk9sPnf8/ftWpOWOZ4KuWMQL5Gi4w8KtWz1hzt93xbak
         +9O9rGjad9wwFXUeOkh8WMpsY7rmNVx4Gid/2YVuO4AcsuL9mIALPf452k7IA15M86o8
         cK6ttYeUubdqF2zBIIg4atjZt5zRWSX1l8zCtPKOvIdhBNIrbz/KSZbeKS6TZRzLn7Vo
         fOdw==
X-Gm-Message-State: AJIora9Dd7bQgIPMyajKaqBSBBaqM0bGJizk2OsN62L2p+BX1jXYzpo1
        M1gvR9W8Zk5o3W6kVNCms5D2SEZalU76+Vmz++x4Wg==
X-Google-Smtp-Source: AGRyM1vQOJ04dwFoJLdJJ7c7BF//QAtWpw78JGEBaGUDuYnD+imzVesCidpq2AJk33vGE5WOR9ZNWld7OnbgKKt+YmE=
X-Received: by 2002:a17:907:7604:b0:72b:4ad5:b21c with SMTP id
 jx4-20020a170907760400b0072b4ad5b21cmr34040885ejc.412.1658314043586; Wed, 20
 Jul 2022 03:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220719114455.701304968@linuxfoundation.org>
In-Reply-To: <20220719114455.701304968@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 20 Jul 2022 16:17:12 +0530
Message-ID: <CA+G9fYtvRzyk+7J51d9rLSJDc0Nq1uS6ehQEz=g=k1bhdhrqPw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/28] 4.9.324-rc1 review
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

On Tue, 19 Jul 2022 at 17:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.324 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 21 Jul 2022 11:43:40 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.324-rc1.gz
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

## Build
* kernel: 4.9.324-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.9.y
* git commit: fc1589ab23915836383ec0460240b055fa41d304
* git describe: v4.9.323-29-gfc1589ab2391
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.y/build/v4.9.3=
23-29-gfc1589ab2391

## Test Regressions (compared to v4.9.323)
No test regressions found.

## Metric Regressions (compared to v4.9.323)
No metric regressions found.

## Test Fixes (compared to v4.9.323)
No test fixes found.

## Metric Fixes (compared to v4.9.323)
No metric fixes found.

## Test result summary
total: 99983, pass: 88018, fail: 339, skip: 10469, xfail: 1157

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 254 total, 249 passed, 5 failed
* arm64: 50 total, 43 passed, 7 failed
* i386: 26 total, 25 passed, 1 failed
* mips: 30 total, 30 passed, 0 failed
* parisc: 12 total, 0 passed, 12 failed
* powerpc: 36 total, 16 passed, 20 failed
* s390: 12 total, 9 passed, 3 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 45 total, 44 passed, 1 failed

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
