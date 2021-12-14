Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E1F473DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhLNIB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhLNIB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:01:28 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0DEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 00:01:28 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r11so59387579edd.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 00:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B3ObPEDvbNhMRSidj2AnG8dSMRHJAaonHYD5kHYlWk8=;
        b=W3W+Khx1r1BTsrQTXQ1n/aZnHbB7LEQfsCmhU9GaLh7y2DS2I5SxR4X1TmCJj/XZcK
         FrytQj9tJSxREuyBzItGLlTT4GMOQwCuawP8MGhBY8Kbu+fvvDl711m+fFjCjcZ2PQVl
         lL/xIOpmYLLUUBqjbIvHfO2G3KmRQNiHuwgQo1Gf44DmERkOl3oWYSezf0u7ByfSh7Tv
         xfXRike+/uuAwvfJrjdRJk+Nmm+fsqr0MJnEWe0uSga/7HdcwDTWh4UMsKQ/TKW7lFnF
         usYMG5pA/ZIfdyzc8W8+UuUqgYRakEMZI1wsNpOQuxjxRJfBxtsK0kL91uZanatmtjn3
         EQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B3ObPEDvbNhMRSidj2AnG8dSMRHJAaonHYD5kHYlWk8=;
        b=H+Im+pFpP/Qe9dLa3sFjwml4PQY1KktGNopV0GOQ8Y7dZ9WbZCUiFjo7r6jE1oO1dI
         3rgldaYLgw+miVxbtTDuj/RTINEMa+qmVG0z0vOSW6FE0sNc/ur9VjW0vkrcT7twEKtJ
         e2XiDDq6OrQR35pO9bXxJDM7yfAt66vTr0CTI6uddEtqxtPt2mkzRhWEB6XrwSvpl5nh
         cAT+NAxOmoPoUim3wiNFHFu+/3g+0a7mxAVAVMHuWzhmau73yIJqQCLWZZ2usfRZuPX0
         hkJtMocDpUj7aLTmIhUCVCUBZ8Sm3sCa4X3wYOjm1bXiViTOH9B3oUu5GFXNZypjqQeW
         QpmA==
X-Gm-Message-State: AOAM530wOnnvY+yAq6lVRlxvmIb23X9gAqv391agIMPyXMURAk1MQz2g
        wUy1Cf4GaJpHCF5jo+BCJsZrmtpbdm/iGI97B+3G9A==
X-Google-Smtp-Source: ABdhPJzf2F9jts1gqiQ5noRm02vgpLMJNYyXxYNM3xO40IeVF39ghjW37EXQjiRwdLYYoGMqDGNoA43404ffVVe1uus=
X-Received: by 2002:a17:906:300e:: with SMTP id 14mr4047316ejz.732.1639468886822;
 Tue, 14 Dec 2021 00:01:26 -0800 (PST)
MIME-Version: 1.0
References: <20211213092925.380184671@linuxfoundation.org>
In-Reply-To: <20211213092925.380184671@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 14 Dec 2021 13:31:15 +0530
Message-ID: <CA+G9fYsLZwRgxK0S5Xshv6zu9mgvq=naJQRVHPJpDDoARkktrg@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/37] 4.4.295-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        f.fainelli@gmail.com, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, pavel@denx.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 at 15:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.295 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 15 Dec 2021 09:29:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.295-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.4.295-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.4.y
* git commit: 597c1677683ab7609f1804211e824a3cab9802e9
* git describe: v4.4.294-38-g597c1677683a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.4.y/build/v4.4.2=
94-38-g597c1677683a

## No Test Regressions (compared to v4.4.294)

## No Test Fixes (compared to v4.4.294)

## Test result summary
total: 44585, pass: 36076, fail: 150, skip: 7382, xfail: 977

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
* fwts
* kselftest-android
* kselftest-bpf
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-efivarfs
* kselftest-filesystems
* kselftest-firmware
* kselftest-fpu
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-livepatch
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-vm
* kselftest-x86
* kselftest-zram
* kvm-unit-tests
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* network-basic-tests
* packetdrill
* perf
* ssuite
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
