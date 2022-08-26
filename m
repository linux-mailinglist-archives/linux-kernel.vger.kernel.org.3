Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1676F5A2BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbiHZQBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiHZQBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:01:30 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41DDD31FC
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 09:01:29 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id p185so1925574pfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 09:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:to:from:cc:subject:date:from:to:cc;
        bh=3q1mT4Zy/pS2V313QrcC7m04gHYm6T7l/MWl4Feqxmg=;
        b=URFDI939EmBa3SgnOxIChmOhkGfBhEfWzwvuZB4Ycp0skW/8zGQKscbKZTHwOjcXcD
         ecyI8To4SmSS6i03Kaw68b+0ixpJqAcCY0BUaOZ9ZrpyNvQZmTD/lNuCmWxZ566mXpUo
         6QhZNImwvVrJpjrG5w185yEoG5AFLalPCJ7vV3IwcraQCOi16c5u8qOyimESMNdHs6vD
         VriRouFqGOPy9sJNYjoxmaTK80lbOuYsd9KrHGbWnAwRksYlcGAANxD6s+Vx8QRygOjy
         2uB60UvN2GNb7qdq2VvnF5ZPv71gS5XQoW6JR34615rctNzClhzHtJ/CBFqdPR10dUpY
         qWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc;
        bh=3q1mT4Zy/pS2V313QrcC7m04gHYm6T7l/MWl4Feqxmg=;
        b=2YEdsiAkMFLhfe2v0bQAqjK0Zxqw5M2QbR5BhL6NHZJdmvVIacyGhjRQZllhl6Ir2z
         BqYQiwKEOqKLZVm6VmaHawDOkowoGrnX6cHFeO8yO8+W4h6tqEXn1tXvf68d4gNyL4Xf
         wcpmjCanqIq6M8mRXWmRKj1rXaveyIuN2R83/4+fMM6Ay3OYfLslHPInII1W0kwe2Zus
         mBhi2e56dsMje3MfTb9bpjeYU+l4j+y/CDfZ3Q26ZIUr6jXjUYYUuFMfXAZXd6CUJ6Iu
         2hXjeKN23gJA86hor5tFUnhcoNsDD6YYPiHMFJK1/cah5AGPSrhDEfd6qxtzReJHDeaM
         K7Qw==
X-Gm-Message-State: ACgBeo2w+jqzzkXSucxXMxOIyJym0YO51HdENMUvCtd2mOdcU2coF1np
        tFzV/3Vuam6wX6hf6e0U8s6Yw9j06/Mw0w==
X-Google-Smtp-Source: AA6agR5njmhZtIgm9xXzOQGOvZyrR3JhJAMUHehXwOk95RIGfGWL/+uMX5MZOlMDNszbIWDDrmqI7Q==
X-Received: by 2002:a65:68cd:0:b0:42b:4214:27 with SMTP id k13-20020a6568cd000000b0042b42140027mr3747290pgt.102.1661529689248;
        Fri, 26 Aug 2022 09:01:29 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p22-20020a1709028a9600b00172d0040b89sm1757675plo.132.2022.08.26.09.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 09:01:28 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:01:28 -0700 (PDT)
X-Google-Original-Date: Fri, 26 Aug 2022 09:01:18 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.0-rc3
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-b5674eda-e816-4e5a-aea2-22f8dc6617fd@palmer-mbp2014>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 96264230a6817bcd4a7ae0fc30c60bfb46499f68:

  perf: riscv legacy: fix kerneldoc comment warning (2022-08-18 14:19:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.0-rc3

for you to fetch changes up to 1709c70c31e05e6e87b2ffa0a2b4cc0da4b2c513:

  Merge branch 'riscv-variable_fixes_without_kvm' of git://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git into fixes (2022-08-25 16:38:01 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.0-rc3

* A handful of fixes for the Microchip device trees.
* A pair of fixes to eliminate build warnings.

----------------------------------------------------------------
Conor Dooley (6):
      riscv: signal: fix missing prototype warning
      riscv: traps: add missing prototype
      riscv: dts: microchip: mpfs: fix incorrect pcie child node name
      riscv: dts: microchip: mpfs: remove ti,fifo-depth property
      riscv: dts: microchip: mpfs: remove bogus card-detect-delay
      riscv: dts: microchip: mpfs: remove pci axi address translation property

Heinrich Schuchardt (1):
      riscv: dts: microchip: correct L2 cache interrupts

Palmer Dabbelt (2):
      Merge tag 'dt-fixes-for-palmer-6.0-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git into fixes
      Merge branch 'riscv-variable_fixes_without_kvm' of git://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git into fixes

 arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts |  3 ---
 arch/riscv/boot/dts/microchip/mpfs-polarberry.dts |  3 ---
 arch/riscv/boot/dts/microchip/mpfs.dtsi           |  5 ++---
 arch/riscv/include/asm/signal.h                   | 12 ++++++++++++
 arch/riscv/include/asm/thread_info.h              |  2 ++
 arch/riscv/kernel/signal.c                        |  1 +
 arch/riscv/kernel/traps.c                         |  3 ++-
 7 files changed, 19 insertions(+), 10 deletions(-)
 create mode 100644 arch/riscv/include/asm/signal.h
