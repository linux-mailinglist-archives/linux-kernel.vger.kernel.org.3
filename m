Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319D24CD981
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbiCDQzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbiCDQzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:55:02 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08664C9909
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:54:14 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id k1so8093687pfu.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 08:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=NPdv2qezfS5eIhrJcLYFdVC8eeVfGqPS0eoMNFwlvYM=;
        b=eGrblmHXcrMIcuINQhyU6BpLqhr/HQ/U0bUzkLevSur4xldQ/HUX8W5kneWV7F1Bj2
         QIgPsHyY6Xe/9nF4x26c9lvRdlRD3eRMLRtUgUjr2tC6DIX9eQuE77XmhaaxSS8RfGm2
         mI6d8rzWdgMDfPmZq42MmT9ed6QB+kcajBrjpaJongd/oqJFOhhdHLuj9RVh7xhBSvWa
         dmuLijZNZBQu9AeCm9IGbzW2K6uEREQ4an9cKC0VB2qu+glvThvzAoOgBEWgduYpzc6E
         UZPNOh6bL48g39avxABV5dZw90lKXnEJW3OJDOGwCV8y5Qb54qeabBpmR/qlpBjeLQ4m
         /gGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=NPdv2qezfS5eIhrJcLYFdVC8eeVfGqPS0eoMNFwlvYM=;
        b=xjch5E024FMpWcOx/swp3I4HzkFIpMW/29/4uzsHtu5+geqyWysvV7f6n5sy7Lp4f1
         RPrwdftFLHEcIRxh2BmYHhvU0gR+S3HTx0wGmL4GOcnG0wpcDyykTtA8ty9glSxSFCC4
         wFticKg2OzGTdraNRK9gKb/2XO9qWXt6cTzK5RxoN1oXW/Koy/CmiRsjNkeHvtjricLe
         yoJPJL0aPawhn0zW10+lTKcJvbpaD5qS3RCvlhdRUSTgnjWFkBXHWhE/+NHF5iScIK3w
         UrqiIddJB4Swts5qHbI3c/50In9MSqvNAM0DE58lW96lFH8ZhyqM3JncHEB6HxcQfWZX
         7Qqg==
X-Gm-Message-State: AOAM533TyFNIt0zKaLFLI7ovyu6Ygkdjtao03Whr6Zan0xdUSZDtcAcY
        DvSuVlPekqWk7LmmzvTnTPyTyCezUGyFOA==
X-Google-Smtp-Source: ABdhPJySdDDgvfRGVHoX72W+Z4WBe0SWSF9l/t2aBvKgAB6CEJvR1IzSLpDyu9seWJOtupaMZQTgzA==
X-Received: by 2002:a63:4005:0:b0:373:9ac7:fec1 with SMTP id n5-20020a634005000000b003739ac7fec1mr34639092pga.12.1646412853295;
        Fri, 04 Mar 2022 08:54:13 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 63-20020a630942000000b00372a99c1821sm5039282pgj.21.2022.03.04.08.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 08:54:13 -0800 (PST)
Date:   Fri, 04 Mar 2022 08:54:13 -0800 (PST)
X-Google-Original-Date: Fri, 04 Mar 2022 08:54:05 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 5.17-rc7
CC:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-35bc28f8-875e-45d8-8c8d-869bb9efce61@palmer-mbp2014>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 22e2100b1b07d6f5acc71cc1acb53f680c677d77:

  riscv: fix oops caused by irqsoff latency tracer (2022-02-24 20:30:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.17-rc7

for you to fetch changes up to 74583f1b92cb3bbba1a3741cea237545c56f506c:

  riscv: dts: k210: fix broken IRQs on hart1 (2022-03-03 20:04:21 -0800)

----------------------------------------------------------------
RISC-V Fixes for 5.17-rc7

* Fixes for a handful of KASAN-related crashes.
* A fix to avoid a crash during boot for SPARSEMEM && !SPARSEMEM_VMEMMAP
  configurations.
* A fix to stop reporting some incorrect errors under DEBUG_VIRTUAL.
* A fix for the K210's device tree to properly populate the interrupt
  map, so hart1 will get interrupts again.

----------------------------------------------------------------
Alexandre Ghiti (6):
      riscv: Fix is_linear_mapping with recent move of KASAN region
      riscv: Fix config KASAN && SPARSEMEM && !SPARSE_VMEMMAP
      riscv: Fix DEBUG_VIRTUAL false warnings
      riscv: Fix config KASAN && DEBUG_VIRTUAL
      riscv: Move high_memory initialization to setup_bootmem
      riscv: Fix kasan pud population

Niklas Cassel (1):
      riscv: dts: k210: fix broken IRQs on hart1

 arch/riscv/boot/dts/canaan/k210.dtsi | 3 ++-
 arch/riscv/include/asm/page.h        | 2 +-
 arch/riscv/include/asm/pgtable.h     | 1 +
 arch/riscv/mm/Makefile               | 3 +++
 arch/riscv/mm/init.c                 | 2 +-
 arch/riscv/mm/kasan_init.c           | 8 +++++---
 arch/riscv/mm/physaddr.c             | 4 +---
 7 files changed, 14 insertions(+), 9 deletions(-)
