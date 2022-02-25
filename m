Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3AF4C4E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbiBYTIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbiBYTIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:08:18 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE86076E0F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:07:44 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id g7-20020a17090a708700b001bb78857ccdso9250329pjk.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=zpMabozdXcRokZfdlJzt+ws6ExMNsrdAdHkkZUquN1w=;
        b=VRLzrXR32w6gT3MUs9irseczDlJWURgLmHvrMkOITutuSwWerF9SJmRkCpeA5pbW0n
         TOyo2grAI1ji5iAXM0kTHr0d0fy7gRpkjkuMWgZkwN6lVNjOBMKnIsxvO51Ejgj+2mpF
         mpNnItqN0xinJ6RvcaDAPYaZVBClhdr3JFlATqXN7lE5cx7q0p6jU9sRx9uNB9MLPqoC
         QUun37HOMOaKIS/pmNwxw72OxUY+F0yPLdasDEoNBmdIESYVNdXkLQWpu3rMTtbbGpog
         qKNYFWvbQxBuTZGOsZBsO7U/H+zjtct/T0a4qleYvtcej3/ZcztnuUrt/NwL8ciOQQUC
         7tQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=zpMabozdXcRokZfdlJzt+ws6ExMNsrdAdHkkZUquN1w=;
        b=qQM1D/PvNatIhOfN0xSUhLmZKTyQZoUXNewlGJzAXH0yk9J1SZdKAtUtQ1p+GfK1mQ
         Bv3QeJ+HFDPsjI1mX8iJxfK2QCXNetbRNaLlHxu01LYau3kkN79tOCDg0xdTIOV/1YGC
         mMRTuFAdYRazfVDsQEEsKeoBo+4SksF4BBjhxes3jcXwdBqLs0XxsNvK2dbjuwFyPi82
         BcPczL77F9p+JAJQiEqgWMc+KpJ8mo5VK/q13e2PkVLRnILeeo+cDG8/IOQ5zPOKCc2U
         r4pvBfKMyJJ6DncfP28yeomlwp+Ov6V8EFuvRij9OqKqmmPLJl9ThZ+QSChFos/WaEAo
         VkTg==
X-Gm-Message-State: AOAM531nFp0c0WVr2ZAtA+IPkkZObQPqmGdA2MEf2sF+3RamsrnkHc5e
        MEW72H6NO6xx4VumdsHXWSfnnBH9n8tjFA==
X-Google-Smtp-Source: ABdhPJwby3wVdcaCbcaIUzrzguXTNnOLQykwmZ+ciJKkvT7LpNhT5ch915A+NG0cvJNsJpw2UdHqHA==
X-Received: by 2002:a17:902:ee42:b0:14f:c36e:6558 with SMTP id 2-20020a170902ee4200b0014fc36e6558mr9089122plo.118.1645816064184;
        Fri, 25 Feb 2022 11:07:44 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id h14-20020a63384e000000b00366ba5335e7sm3203024pgn.72.2022.02.25.11.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:07:43 -0800 (PST)
Date:   Fri, 25 Feb 2022 11:07:43 -0800 (PST)
X-Google-Original-Date: Fri, 25 Feb 2022 11:07:39 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 5.17-rc6
CC:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-673458fa-1596-4318-ae4b-b0275abc5d23@palmer-mbp2014>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5feef64f4c67068c49f5409d43c67cabf2327f66:

  RISC-V: Fix IPI/RFENCE hmask on non-monotonic hartid ordering (2022-02-14 12:27:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.17-rc6

for you to fetch changes up to 22e2100b1b07d6f5acc71cc1acb53f680c677d77:

  riscv: fix oops caused by irqsoff latency tracer (2022-02-24 20:30:30 -0800)

----------------------------------------------------------------
RISC-V Fixes for 5.17-rc6

* A fix for the K210 sdcard defconfig, to avoid using a fixed delay for
  the root FS.
* A fix to make sure there's a proper call frame for
  trace_hardirqs_{on,off}().

---

There are a handful of additional fixes in flight, but not for this
week.

----------------------------------------------------------------
Changbin Du (1):
      riscv: fix oops caused by irqsoff latency tracer

Damien Le Moal (1):
      riscv: fix nommu_k210_sdcard_defconfig

 arch/riscv/configs/nommu_k210_sdcard_defconfig |  2 +-
 arch/riscv/kernel/Makefile                     |  2 ++
 arch/riscv/kernel/entry.S                      | 10 +++++-----
 arch/riscv/kernel/trace_irq.c                  | 27 ++++++++++++++++++++++++++
 arch/riscv/kernel/trace_irq.h                  | 11 +++++++++++
 5 files changed, 46 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/kernel/trace_irq.c
 create mode 100644 arch/riscv/kernel/trace_irq.h
