Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2635848A9C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbiAKIpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbiAKIpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:45:39 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37035C061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 00:45:39 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id e198so22484895ybf.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 00:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PYcl99Fm8/kZTZCIkQZdNWIBE3S2oaJ+VSNXHTVRIwo=;
        b=H0U0Q07m3cpI8hDorxRqBT+rRu5PmdW1iCUTWPBDQTReZB1bBrToy+E3VCGbRHjWnV
         gp6bbfCxQKTkTEwfJsUBa6qvU6pTfRGZLvraSMJURIse6SLpwiUVHKF1Lh5vltEbkS8h
         CHQWjGXtQGLza59ayqQgka+vJFRJKJDSM69kjrFU3kc7JExKGy32e3jksup07XW7yxog
         YJz7j1DDUzeZ+7hJaDUE6eTMyWFzXJEK+pRMdLoirigO90qbn598haN8H03P3jiCX3E/
         3dboSGVcmzyuBu9G7vmgX1FAqV4c5PA3dNqkETX21Qcs05v7X5nxy0og6sf4zbbsmp/h
         UN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PYcl99Fm8/kZTZCIkQZdNWIBE3S2oaJ+VSNXHTVRIwo=;
        b=I9jPy9I1SjYdTNxs6bGicMFkt/1UYfd1XACLdrWhN7j9drdbqnvgPbUfJu4AL/19/z
         +7IT4XjxpQnVjGnaSmZgF3CyCGfrOUNQZ3zc2QXnCVIenWujh2B+Keed/qGDjCdI7Z9R
         Y0ZrNcnxx1vKtQ4ITw/B0L2ygN42s6XFrY/nPoKh0dWpC0kJ9u1+V2FEjE3AYNr60E8Q
         X3vRHcVVWLMSLs1ih0knZEux2jdNoOv4FUj/UUzgKeaROQG5steldRnci8I3hz1F2UR+
         QK8ZI6MYeym0rGFM5uZcLp6BDzXTdmM+ae1HMerDBx6+mIajcqwsWOT01yZVNBDF2EK/
         Y/PQ==
X-Gm-Message-State: AOAM533QVqbhVQXPCro0C4lrNf9Of4ODJst9gkeX9WglyEowrAAG1Q7G
        Ru+qFQ7zF7fdAv8OkBVZv52Ie2P2DuieJJTIJrd0Rw==
X-Google-Smtp-Source: ABdhPJwEmN2GVa6cLp00OSGyI6rApxVwuBNwKQlgkhDs37nq+YaQYzkEoW9qbE+EDV0tPqJX0OGwh6Ta/v4Nl/G9iOg=
X-Received: by 2002:a25:a04a:: with SMTP id x68mr4676438ybh.200.1641890738325;
 Tue, 11 Jan 2022 00:45:38 -0800 (PST)
MIME-Version: 1.0
References: <20220110071811.779189823@linuxfoundation.org>
In-Reply-To: <20220110071811.779189823@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 11 Jan 2022 14:15:27 +0530
Message-ID: <CA+G9fYvfmWve_hf=n+myvzouq=ihJ2nt0qu8r6+XKCdQoiNQLQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/14] 4.4.299-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 at 12:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.299 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 12 Jan 2022 07:18:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.299-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.4.299-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.4.y
* git commit: 039b69cc9b1536ea691fb3f09f95f82e60cf96db
* git describe: v4.4.298-15-g039b69cc9b15
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.4.y/build/v4.4.2=
98-15-g039b69cc9b15

## Test Regressions (compared to v4.4.298)
No test regressions found.

## Metric Regressions (compared to v4.4.298)
No metric regressions found.

## Test Fixes (compared to v4.4.298)
No test fixes found.

## Metric Fixes (compared to v4.4.298)
No metric fixes found.

## Test result summary
total: 32657, pass: 26024, fail: 62, skip: 5888, xfail: 683

## Build Summary
* arm: 129 total, 129 passed, 0 failed
* arm64: 31 total, 31 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 30 total, 24 passed, 6 failed

## Test suites summary
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* packetdrill
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
