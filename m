Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35394E24CA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346542AbiCULAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbiCULAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:00:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6151E3CC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 03:59:25 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dr20so28660152ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 03:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Zzl3GYl80w+S9mI5wpD2NO28H32GyZAzJz9ChCnYhhk=;
        b=BOeG2vnZA3JGkd2zKOK8WvSEdIkop3CBOdorIGHuagbywfrRREEbfwjaL+moII1QoU
         kwxemH01uBlp6L5MKQCLgCYTU6Q4kNRQRSNmeY8yyNH3+Sfj+lh8IrDd/gpnbD3bt/x5
         i7ZJVSxZHhJKvjuJSgq203uPnnCZX5jF2tFdrJ8FwEF3jB74skE/RyC8IOMLBGNtjLVs
         YvBxyBgjs9y5yz5jg+5HPK4P5Ds17OXKP6+wfYE2xltgGNu1eJUZ6DOiCqvr6vbQ0K7T
         Jv/GDBWoqlfF15yb70RHK20dHIRwWaLKxwIW/w18aiA5aLd9u7m0QFHgZkw0pkAiidv4
         Eq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=Zzl3GYl80w+S9mI5wpD2NO28H32GyZAzJz9ChCnYhhk=;
        b=hkRr9Z7hTlFBBXzESSrfscZ6KoR6RjB09yuO1qzw7laKXd/IFAqBkiGp2Pf+H2cKX8
         qsqiUk62Z1NEVivvaFZATpywQmCkm6A3rZqUmxwArEuoFzADolF/8yxTNYMU9GdvOhwY
         76k8V7KdTMKZ5E3nQUUTzX+cyLfZjC0E3uGEaW8YkppAOCLXs/pg+cwqZm8cOVAf43TQ
         U1uHOtfSvNvlmHvrj950c7RjJoB22Tiq8UXlwq6txDkSpLaUKDAqgcuzLlSVFdQK6Ny0
         j+fRHvsnWG/BQeTKGsVpvrwkGAO9RLASZNIu5ZjRDaklMfO/G++tiU2KCRAuB6l63p4W
         s72w==
X-Gm-Message-State: AOAM532KD8tmpmaJALNSEEZMtNWAAllimvd+9eFa5WGBLRrJpviUz/l1
        ah4es7UjAzE2OIBsoAX7dbU=
X-Google-Smtp-Source: ABdhPJzFQJFSyfa9BJo3F9NHYbj9M7wkim3YSPp0uiJrjdxczNULqZJmdMtcLCF2Dpvd/9uOZJM60A==
X-Received: by 2002:a17:906:bb01:b0:6a7:df9:d67c with SMTP id jz1-20020a170906bb0100b006a70df9d67cmr19812804ejb.733.1647860364059;
        Mon, 21 Mar 2022 03:59:24 -0700 (PDT)
Received: from gmail.com (0526ECD0.dsl.pool.telekom.hu. [5.38.236.208])
        by smtp.gmail.com with ESMTPSA id fx3-20020a170906b74300b006daecedee44sm6744062ejb.220.2022.03.21.03.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 03:59:23 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 21 Mar 2022 11:59:21 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL] perf events changes for v5.18
Message-ID: <YjhaieorORDCnPvh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2022-03-21

   # HEAD: 02a08d78f5c429c7dc8e5b9417b4efb518b3d041 perf/x86/intel/uncore: Fix the build on !CONFIG_PHYS_ADDR_T_64BIT

Changes for this cycle were:

 - Fix address filtering for Intel/PT,ARM/CoreSight
 - Enable Intel/PEBS format 5
 - Allow more fixed-function counters for x86
 - Intel/PT: Enable not recording Taken-Not-Taken packets
 - Add a few branch-types

 Thanks,

	Ingo

------------------>
Adrian Hunter (5):
      perf/x86/intel/pt: Relax address filter validation
      x86: Share definition of __is_canonical_address()
      perf/core: Fix address filter parser for multiple filters
      perf/x86/intel/pt: Fix address filter config for 32-bit kernel
      perf/core: Allow kernel address filter when not filtering the kernel

Alexander Shishkin (2):
      perf/x86/intel/pt: Add a capability and config bit for event tracing
      perf/x86/intel/pt: Add a capability and config bit for disabling TNTs

Anshuman Khandual (1):
      perf: Add irq and exception return branch types

Ingo Molnar (1):
      perf/x86/intel/uncore: Fix the build on !CONFIG_PHYS_ADDR_T_64BIT

Kan Liang (2):
      perf/x86/intel: Enable PEBS format 5
      perf/x86/intel: Increase max number of the fixed counters

Steve Wahl (1):
      perf/x86/intel/uncore: Make uncore_discovery clean for 64 bit addresses

Wei Wang (1):
      KVM: x86: use the KVM side max supported fixed counter


 arch/x86/events/intel/core.c             | 40 +++++++++++++++++-
 arch/x86/events/intel/ds.c               | 14 +++++--
 arch/x86/events/intel/lbr.c              |  4 +-
 arch/x86/events/intel/pt.c               | 71 +++++++++++++++++++++++++-------
 arch/x86/events/intel/uncore_discovery.c | 16 +++++--
 arch/x86/events/intel/uncore_discovery.h |  2 -
 arch/x86/include/asm/intel_ds.h          |  5 ++-
 arch/x86/include/asm/intel_pt.h          |  2 +
 arch/x86/include/asm/kvm_host.h          |  3 +-
 arch/x86/include/asm/msr-index.h         |  2 +
 arch/x86/include/asm/page.h              | 10 +++++
 arch/x86/include/asm/perf_event.h        |  2 +-
 arch/x86/kvm/cpuid.c                     |  3 +-
 arch/x86/kvm/emulate.c                   |  4 +-
 arch/x86/kvm/pmu.h                       |  2 -
 arch/x86/kvm/vmx/pmu_intel.c             |  4 +-
 arch/x86/kvm/x86.c                       |  4 +-
 arch/x86/kvm/x86.h                       |  7 +---
 arch/x86/mm/maccess.c                    |  7 +---
 include/uapi/linux/perf_event.h          |  2 +
 kernel/events/core.c                     |  5 ++-
 tools/include/uapi/linux/perf_event.h    |  2 +
 tools/perf/util/branch.c                 |  4 +-
 23 files changed, 161 insertions(+), 54 deletions(-)
