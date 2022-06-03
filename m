Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7442753CD4A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243413AbiFCQdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241971AbiFCQdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:33:49 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4592A730
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 09:33:48 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id c12so5937072qvr.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 09:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=jmS9+muNRBp2jnRn4fOY2N20O9KfoqE+IiDXN9dcqrM=;
        b=UHz9NCtym8NegjyXl7gyK9SuR5nldXoPINn+bRik9fh0SLL8K7UIwOH6LBLp5myTpk
         wnTskz3ocPTRLxh6cr5Ez6O074AUwgNuQHlGM4IxmHw1EJkYPidUpxcJ7EFN73SBb0m7
         KI9SNvVlphbGJehjOnZq6i3fjGEEarEg2d8jhkRURC50UC82WfxWay63Kw7hx0RVHGfk
         2hMMV8I4mFIzT0QLHoTV6nRLh1GwCj95qpv7QZw4PcyPGKA6mJuVLx0qQmr+aJJJ6NEQ
         D60xd395cd2tQEE3INfQPRxFeZNh9AolJykywXzh4qcvhsbegc4UUZhic9rn15QbyI4g
         Aajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=jmS9+muNRBp2jnRn4fOY2N20O9KfoqE+IiDXN9dcqrM=;
        b=gAEu2a/oH1cnFSkZOnz2PL6Aun2hRC8qbkr/kBuPZNKLdO1Qnf8jNJGZXrbiXhLTb9
         QVFUl7nzgAahvBgEptHAFLPI6jtP7R5zqymBftEqRNGKkHzzKP8VSRLczBT505fH1Esd
         EzSjQyCLjhsn0PE1Mof6W6pzAjBiVp8ymwH5ffH9uz+tQzEo240v++0jjzdN7w1yMkl1
         5Ye3aE6gi6PArKR8QZA8csrV4WjworByj1OL1kramrUd6uO3G9G5L2r4H6bZq6eN+OYM
         LIqk5/5V0YTLmC3feSqTLewFZ9n3se4WNaJsJPOS6dKEzQlKX+lf1ZwEPVTly3tKP1Ou
         wBeQ==
X-Gm-Message-State: AOAM530PiUlfuGAREnJ+ECLiMSFRQup4AdZ1CB2Hz+5vj07sMURkSnHK
        kxJnE3xWorMNRJsPKKAK1DtciT7dRUB/ew==
X-Google-Smtp-Source: ABdhPJxZoE4jsbVPqtWPd5lko6Oa2FLNbG7wszeizLjMbpm+bug1FMywcdicUra99nZiJ1WeMZZDIw==
X-Received: by 2002:ad4:46ae:0:b0:467:db1b:f38b with SMTP id br14-20020ad446ae000000b00467db1bf38bmr4091953qvb.57.1654274027125;
        Fri, 03 Jun 2022 09:33:47 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id h9-20020ac85e09000000b002f93c5444e3sm5481315qtx.52.2022.06.03.09.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 09:33:46 -0700 (PDT)
Date:   Fri, 03 Jun 2022 09:33:46 -0700 (PDT)
X-Google-Original-Date: Fri, 03 Jun 2022 09:33:44 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 5.19 Merge Window, Part 2
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-98b420ef-9b28-4e40-971e-7275b8f7c6e8@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged tag 'riscv-for-linus-5.19-mw0'
The following changes since commit 35b51afd23c98e2f055ac563aca36173a12588b9:

  Merge tag 'riscv-for-linus-5.19-mw0' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2022-05-31 14:10:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-mw2

for you to fetch changes up to 61114e734ccb804bc12561ab4020745e02c468c2:

  riscv: Move alternative length validation into subsection (2022-06-02 15:55:22 -0700)

----------------------------------------------------------------
RISC-V Patches for the 5.19 Merge Window, Part 2

This is mostly some DT updates, but also a handful of cleanups and some
fixes.  The most user-visible of those are:

* A device tree for the Sundance Polarberry, along with a handful of
  fixes and clenups to the PolarFire SOC device trees and bindings.
* The memfd_secret syscall number is now visible to userspace,
* Some improvements to the vm layout dump, which really should have
  followed shortly after the sv48 patches but I missed.

----------------------------------------------------------------
Alexandre Ghiti (3):
      Documentation: riscv: Add sv48 description to VM layout
      riscv: Initialize thread pointer before calling C functions
      riscv: Improve virtual kernel memory layout dump

Conor Dooley (10):
      riscv: dts: microchip: remove icicle memory clocks
      riscv: dts: microchip: move sysctrlr out of soc bus
      riscv: dts: microchip: remove soc vendor from filenames
      dt-bindings: riscv: microchip: document icicle reference design
      riscv: dts: microchip: make the fabric dtsi board specific
      dt-bindings: vendor-prefixes: add Sundance DSP
      dt-bindings: riscv: microchip: add polarberry compatible string
      riscv: dts: microchip: add the sundance polarberry
      riscv: microchip: icicle: readability fixes
      riscv: dts: icicle: sort nodes alphabetically

Jisheng Zhang (1):
      riscv: mm: init: make pt_ops_set_[early|late|fixmap] static

Masahiro Yamada (1):
      riscv: move errata/ and kvm/ builds to arch/riscv/Kbuild

Nathan Chancellor (1):
      riscv: Move alternative length validation into subsection

Palmer Dabbelt (2):
      RISC-V: PolarFire SoC Device Tree Updates
      RISC-V: Only default to spinwait on SBI-0.1 and M-mode

Samuel Holland (1):
      riscv: Fix irq_work when SMP is disabled

Tobias Klauser (1):
      riscv: Wire up memfd_secret in UAPI header

Xianting Tian (1):
      RISC-V: Mark IORESOURCE_EXCLUSIVE for reserved mem instead of IORESOURCE_BUSY

 .../devicetree/bindings/riscv/microchip.yaml       |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 Documentation/riscv/vm-layout.rst                  |  36 +++++++
 arch/riscv/Kbuild                                  |   2 +
 arch/riscv/Kconfig                                 |   8 +-
 arch/riscv/Makefile                                |   3 -
 arch/riscv/boot/dts/microchip/Makefile             |   3 +-
 ...pfs-fabric.dtsi => mpfs-icicle-kit-fabric.dtsi} |   2 +
 ...hip-mpfs-icicle-kit.dts => mpfs-icicle-kit.dts} | 105 +++++++++++----------
 .../boot/dts/microchip/mpfs-polarberry-fabric.dtsi |  16 ++++
 arch/riscv/boot/dts/microchip/mpfs-polarberry.dts  |  99 +++++++++++++++++++
 .../microchip/{microchip-mpfs.dtsi => mpfs.dtsi}   |  11 +--
 arch/riscv/include/asm/alternative-macros.h        |   4 +-
 arch/riscv/include/asm/irq_work.h                  |   2 +-
 arch/riscv/include/asm/unistd.h                    |   1 -
 arch/riscv/include/uapi/asm/unistd.h               |   1 +
 arch/riscv/kernel/head.S                           |   1 +
 arch/riscv/kernel/setup.c                          |   4 +-
 arch/riscv/mm/init.c                               |  72 ++++++++++----
 19 files changed, 287 insertions(+), 87 deletions(-)
 rename arch/riscv/boot/dts/microchip/{microchip-mpfs-fabric.dtsi => mpfs-icicle-kit-fabric.dtsi} (91%)
 rename arch/riscv/boot/dts/microchip/{microchip-mpfs-icicle-kit.dts => mpfs-icicle-kit.dts} (95%)
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
 rename arch/riscv/boot/dts/microchip/{microchip-mpfs.dtsi => mpfs.dtsi} (98%)
