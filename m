Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4646B514F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378301AbiD2PYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241558AbiD2PYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:24:30 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8388B4CD48
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:21:11 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id y2so15043737ybi.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Y9ZcDqJuLqa5JXE44N2GTKKL7QLt6s4hAdWbOVk4GKA=;
        b=Ui44ujrM/Zb0gG6w993gsGhOHJJo4hJpMy5YNqMlQ1UBxypMqUeZmQ0vQR7zv43aoq
         ysDTzwPOaXcMJdAgaQ75aaFaKccNh9YzoWgUyuBazDKHo05B72uXLnf6GOuFGr+YjOhb
         CqmBqnbFsKscTmFpZomlQtNTgyCMw6ijgNKi9RtxOdjwtTfEQZUtxW5GY0kFI7vmbPEd
         iyQjLd93QR48gkJfiDsyihFfeFvPeCdY0ygAs4xaGmcwpoglEDViVmR2LTurXIY2q4cB
         4yV5cGfoba+QxaXmO6t+ligH1pohAdpq21zsLB0z5rlHCgxpRDTt3W3Lre8Dxe82rSsU
         +OFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Y9ZcDqJuLqa5JXE44N2GTKKL7QLt6s4hAdWbOVk4GKA=;
        b=TG9IYhE8YNYcQqrzuJxr2ZTHbTOc3czNZELJ6WEkpsZ7fBDcRTqXWajicJNGwXgG3/
         1HnRO4/+gbU/gCTiN3snm55Ds1cjBanhCgyBcHqByuStKmK+ypSXAIRIBICJf6dlljro
         LQo45hvr3qa2S0Hm7br0Ac8zDduPOkHAyLgkC11OXlYcflnorZ1wRPNVTgXS9GPin6vl
         K1rTgyReUvXi/8Ee1FrilRXfaEkp86p5JEnyL+hqKcMdgr3zImfqVR92vZ3bVE89om1G
         Xq59qEH56NyMr1esyylmi9AacinZnoQfvQboX1GfsX+bIE8nE11pEf6r6wDUcSsdPTb4
         x6ew==
X-Gm-Message-State: AOAM532KbWPM67Of4PruFN9KK8Xr4PgJSqkAn3LQXywg881fs0YDNmak
        zzSF50Y2AlESm8IqeiVb/H8Ep5ZyYBo5Cvo1pY8IMw==
X-Google-Smtp-Source: ABdhPJwLCCaV2PcxMcgGMdB0/M2/IvKlelR9da+uyTInErh3cDr6csPbgJ1kHhRHPIcQAkVXAy/BgNTq4VYaz6VK/f4=
X-Received: by 2002:a25:9909:0:b0:624:57e:d919 with SMTP id
 z9-20020a259909000000b00624057ed919mr36075867ybn.494.1651245670446; Fri, 29
 Apr 2022 08:21:10 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 29 Apr 2022 20:50:59 +0530
Message-ID: <CA+G9fYu2kS0wR4WqMRsj2rePKV9XLgOU1PiXnMvpT+Z=c2ucHA@mail.gmail.com>
Subject: [next] i386: kunit: ASSERTION FAILED at mm/kfence/kfence_test.c:547
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following kernel regressions have been noticed on Linux next-20220426
(till date) on qemu_i386. This is a special build with KFENCE and KUNIT enabled
but not KASAN on i386.

snippet of Kconfigs from the build:
    CONFIG_CC_HAS_KASAN_GENERIC=y
    CONFIG_KFENCE=y
    CONFIG_KFENCE_KUNIT_TEST=y
    CONFIG_KUNIT=y
    CONFIG_KUNIT_DEBUGFS=y
    CONFIG_KUNIT_TEST=y
    CONFIG_KUNIT_EXAMPLE_TEST=y
    CONFIG_KUNIT_ALL_TESTS=y

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on qemu_i386;:

   - kunit/test_free_bulk
   - kunit/test_memcache_typesafe_by_rcu
   - kunit/test_out_of_bounds_read-memcache
   - kunit/test_invalid_access
   - kunit/test_krealloc
   - kunit/test_invalid_addr_free
   - kunit/test_gfpzero
   - kunit/test_kmalloc_aligned_oob_write
   - kunit/kfence
   - kunit/test_out_of_bounds_read
   - kunit/test_out_of_bounds_write
   - kunit/test_invalid_addr_free-memcache
   - kunit/test_double_free
   - kunit/test_corruption-memcache
   - kunit/test_use_after_free_read-memcache
   - kunit/test_corruption
   - kunit/test_use_after_free_read
   - kunit/test_shrink_memcache
   - kunit/test_double_free-memcache
   - kunit/test_out_of_bounds_write-memcache
   - kunit/test_kmalloc_aligned_oob_read


full test log link [1]

snippet of test log:
[    4.168302]     # test_free_bulk: test_alloc: size=271, gfp=cc0,
policy=right, cache=0
[    4.271599]     # test_free_bulk: test_alloc: size=271, gfp=cc0,
policy=none, cache=0
[    4.271611]     # test_free_bulk: test_alloc: size=271, gfp=cc0,
policy=left, cache=0
[    4.687568]     # test_free_bulk: test_alloc: size=271, gfp=cc0,
policy=none, cache=0
[    4.687581]     # test_free_bulk: test_alloc: size=271, gfp=cc0,
policy=none, cache=0
[    4.687616]     # test_free_bulk: ASSERTION FAILED at
mm/kfence/kfence_test.c:547
[    4.687616]     Expected report_available() to be false, but is true
[    4.687789]     not ok 13 - test_free_bulk
...
[   33.294007]     # test_memcache_typesafe_by_rcu: EXPECTATION FAILED
at mm/kfence/kfence_test.c:687
[   33.294007]     Expected report_matches(&expect) to be true, but is false
[   33.294182]     not ok 23 - test_memcache_typesafe_by_rcu
[   33.294183] kunit_try_catch (209) used greatest stack depth: 5840 bytes left
[   33.294619]     # test_krealloc: test_alloc: size=32, gfp=cc0,
policy=any, cache=0
[   33.391637]     # test_krealloc: ASSERTION FAILED at
mm/kfence/kfence_test.c:724
[   33.391637]     Expected report_available() to be false, but is true
[   33.391658]     not ok 24 - test_krealloc
[   33.391902]     # test_memcache_alloc_bulk: setup_test_cache:
size=32, ctor=0x0
[   33.495801]     ok 25 - test_memcache_alloc_bulk
[   33.495808] # kfence: pass:3 fail:20 skip:2 total:25
[   33.495817] # Totals: pass:3 fail:20 skip:2 total:25
[   33.495833] not ok 1 - kfence


metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 088fb7eff3496e0f61fdf68bda89b81a4d0a4434
  git_describe: next-20220426
  kernel-config: https://builds.tuxbuild.com/28KafYBlDWOxI3qyNmGDwb63GuX/config

--
Linaro LKFT
https://lkft.linaro.org

[1] https://lkft.validation.linaro.org/scheduler/job/4950383#L770
[2] https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220426/testrun/9235043/suite/kunit/test/test_use_after_free_read/log
