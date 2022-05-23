Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75460530F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbiEWLoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbiEWLov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:44:51 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED7650B09
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:44:50 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c2so12860569plh.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pPAlXHhDqChBHrBqU0G/1acbAR2YkJBCMWPYUQfEbE4=;
        b=IHUExjqACSkP5lWKMLd5p3mm5ZKqQuO2Lu9/IC2hMwCc95oXffnLAjnRqktqS/Bu8n
         CESWLLi7tIFH12SgqZlygzJ9plymIHs7KFKZ9l0TZnQ7pGLroPBUVm9oN9fnIeQAUvp2
         FeAw12NMvTd3rDOgbbUfB6ScOCbm/t60tjbPPlAiycSQLuzHN/PWGM+lJnJKJbse2/HZ
         lkvrWJJsyQQGAiB575hqUUcAOQTIPFmTVIri0z0YtbXkNzyyyP9n7Brcm6Qq9HPKqJ3K
         SZvk8aitD8xEVTTiS+RivPmYybg++g6UEWZTXJ1WfYuRCMucrtiIGWByy95O5j2cRNU7
         H+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pPAlXHhDqChBHrBqU0G/1acbAR2YkJBCMWPYUQfEbE4=;
        b=C5zdZJwGozQZDOtvycNHl0uviMA8hPpBWijqaclsCkC/o/eg8sDT+nmKFlqW5Qqq7J
         QUmJyHQbghWplkRgGmc6ZwdZJWgyi/BYurijH6rw05TE4zV+HH6Gi/VnrM+uX3GmwKUw
         PMcR+HuAf463S0SHJHkmBwTVsXunhPp83s1uiAI9aHRDh4TxJmps7n0BK2thKKFx2ioW
         2vAxDHkTlsHLeH1eXp/sqTM4O4iZGpTrHcd9BaSKu+/1jlyZ1MFN6ZntEWiJt9ngFDYO
         uygNkgPVWQLFrzxAIAgB6Y/ucVlffHJcP2EfmWe7QhLWk+4/x6PjvE3bcRkmUe4q5aFH
         YetA==
X-Gm-Message-State: AOAM531tkufcJevJw37TGBhwSayCpqmhTZtGVvucSFRgXOmAxjG67lXr
        nMzBayweyAbCEZfExHDJ3lyXlA==
X-Google-Smtp-Source: ABdhPJxahqiEPIYqzApAMogRGQCdscpkIttDCr4MtX6IMrV509dZKfy75djwLDPS1G/df2FJpUGMPA==
X-Received: by 2002:a17:903:2594:b0:162:125f:7966 with SMTP id jb20-20020a170903259400b00162125f7966mr8600361plb.103.1653306290125;
        Mon, 23 May 2022 04:44:50 -0700 (PDT)
Received: from localhost.localdomain ([103.125.161.241])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902b60500b0016213f0f9a1sm3498618pls.34.2022.05.23.04.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 04:44:49 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: Linux v5.18
Date:   Mon, 23 May 2022 17:14:38 +0530
Message-Id: <20220523114438.30160-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAHk-=wjiqyoH6qntYvYTjR1F2L-pHtgX9esZMRS13iktCOJ1zA@mail.gmail.com>
References: <CAHk-=wjiqyoH6qntYvYTjR1F2L-pHtgX9esZMRS13iktCOJ1zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.18.0
* git: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
* git branch: master
* git commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
* git describe: v5.18
* test details: https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v5.18

## Test Regressions (compared to v5.18-rc7-185-g978df3e15846)
No test regressions found.

## Metric Regressions (compared to v5.18-rc7-185-g978df3e15846)
No Metric regressions found.

## Test Fixes (compared to v5.18-rc7-185-g978df3e15846)
No test fixes found.

## Metric Fixes (compared to v5.18-rc7-185-g978df3e15846)
No metric fixes found.

## Test result summary
total: 95781, pass: 82937, fail: 698, skip: 11135, xfail: 1011

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 301 total, 295 passed, 6 failed
* arm64: 54 total, 52 passed, 2 failed
* i386: 49 total, 45 passed, 4 failed
* mips: 45 total, 38 passed, 7 failed
* parisc: 16 total, 16 passed, 0 failed
* powerpc: 70 total, 57 passed, 13 failed
* riscv: 37 total, 27 passed, 10 failed
* s390: 31 total, 25 passed, 6 failed
* sh: 28 total, 24 passed, 4 failed
* sparc: 16 total, 14 passed, 2 failed
* x86_64: 53 total, 50 passed, 3 failed

## Test suites summary
* fwts
* igt-gpu-tools
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers
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
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
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
* kunit
* kunit/15
* kunit/261
* kunit/3
* kunit/427
* kunit/90
* kvm-unit-tests
* libgpiod
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
* prep-inline/Zstd-perf.data-compression
* rcutorture
* ssuite
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
