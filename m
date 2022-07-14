Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332D55749D4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbiGNJ52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbiGNJ5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:57:08 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7F3D4C603;
        Thu, 14 Jul 2022 02:57:06 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oBvaj-0006rx-01; Thu, 14 Jul 2022 11:57:05 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 69F76C0493; Thu, 14 Jul 2022 11:55:06 +0200 (CEST)
Date:   Thu, 14 Jul 2022 11:55:06 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Remove VR41xx support
Message-ID: <20220714095506.GB10086@alpha.franken.de>
References: <20220705164632.97942-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705164632.97942-1-tsbogend@alpha.franken.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 06:46:25PM +0200, Thomas Bogendoerfer wrote:
> No (active) developer owns this hardware, so let's remove Linux support.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  arch/mips/Kbuild.platforms              |   1 -
>  arch/mips/Kconfig                       |  23 -
>  arch/mips/Makefile                      |   1 -
>  arch/mips/configs/capcella_defconfig    |  91 ---
>  arch/mips/configs/e55_defconfig         |  37 --
>  arch/mips/configs/mpc30x_defconfig      |  53 --
>  arch/mips/configs/tb0219_defconfig      |  76 ---
>  arch/mips/configs/tb0226_defconfig      |  71 ---
>  arch/mips/configs/tb0287_defconfig      |  84 ---
>  arch/mips/configs/workpad_defconfig     |  67 ---
>  arch/mips/include/asm/cpu-type.h        |  11 -
>  arch/mips/include/asm/cpu.h             |   3 +-
>  arch/mips/include/asm/mach-vr41xx/irq.h |   9 -
>  arch/mips/include/asm/mipsregs.h        |  14 -
>  arch/mips/include/asm/pgtable-32.h      |   5 -
>  arch/mips/include/asm/pgtable-64.h      |   5 -
>  arch/mips/include/asm/vermagic.h        |   2 -
>  arch/mips/include/asm/vr41xx/capcella.h |  30 -
>  arch/mips/include/asm/vr41xx/giu.h      |  41 --
>  arch/mips/include/asm/vr41xx/irq.h      |  97 ----
>  arch/mips/include/asm/vr41xx/mpc30x.h   |  24 -
>  arch/mips/include/asm/vr41xx/pci.h      |  77 ---
>  arch/mips/include/asm/vr41xx/siu.h      |  45 --
>  arch/mips/include/asm/vr41xx/tb0219.h   |  29 -
>  arch/mips/include/asm/vr41xx/tb0226.h   |  30 -
>  arch/mips/include/asm/vr41xx/tb0287.h   |  30 -
>  arch/mips/include/asm/vr41xx/vr41xx.h   | 148 -----
>  arch/mips/kernel/cpu-probe.c            |  40 --
>  arch/mips/lib/dump_tlb.c                |   8 -
>  arch/mips/mm/c-r4k.c                    |  44 --
>  arch/mips/mm/tlbex.c                    |  35 --
>  arch/mips/pci/Makefile                  |   6 -
>  arch/mips/pci/fixup-capcella.c          |  37 --
>  arch/mips/pci/fixup-mpc30x.c            |  36 --
>  arch/mips/pci/fixup-tb0219.c            |  38 --
>  arch/mips/pci/fixup-tb0226.c            |  73 ---
>  arch/mips/pci/fixup-tb0287.c            |  52 --
>  arch/mips/pci/ops-vr41xx.c              | 113 ----
>  arch/mips/pci/pci-vr41xx.c              | 309 ----------
>  arch/mips/pci/pci-vr41xx.h              | 141 -----
>  arch/mips/vr41xx/Kconfig                | 104 ----
>  arch/mips/vr41xx/Makefile               |   5 -
>  arch/mips/vr41xx/Platform               |  29 -
>  arch/mips/vr41xx/casio-e55/Makefile     |   6 -
>  arch/mips/vr41xx/casio-e55/setup.c      |  27 -
>  arch/mips/vr41xx/common/Makefile        |   6 -
>  arch/mips/vr41xx/common/bcu.c           | 210 -------
>  arch/mips/vr41xx/common/cmu.c           | 242 --------
>  arch/mips/vr41xx/common/giu.c           | 110 ----
>  arch/mips/vr41xx/common/icu.c           | 714 ------------------------
>  arch/mips/vr41xx/common/init.c          |  60 --
>  arch/mips/vr41xx/common/irq.c           | 106 ----
>  arch/mips/vr41xx/common/pmu.c           | 123 ----
>  arch/mips/vr41xx/common/rtc.c           | 105 ----
>  arch/mips/vr41xx/common/siu.c           | 142 -----
>  arch/mips/vr41xx/common/type.c          |  11 -
>  arch/mips/vr41xx/ibm-workpad/Makefile   |   6 -
>  arch/mips/vr41xx/ibm-workpad/setup.c    |  27 -
>  58 files changed, 1 insertion(+), 4068 deletions(-)
>  delete mode 100644 arch/mips/configs/capcella_defconfig
>  delete mode 100644 arch/mips/configs/e55_defconfig
>  delete mode 100644 arch/mips/configs/mpc30x_defconfig
>  delete mode 100644 arch/mips/configs/tb0219_defconfig
>  delete mode 100644 arch/mips/configs/tb0226_defconfig
>  delete mode 100644 arch/mips/configs/tb0287_defconfig
>  delete mode 100644 arch/mips/configs/workpad_defconfig
>  delete mode 100644 arch/mips/include/asm/mach-vr41xx/irq.h
>  delete mode 100644 arch/mips/include/asm/vr41xx/capcella.h
>  delete mode 100644 arch/mips/include/asm/vr41xx/giu.h
>  delete mode 100644 arch/mips/include/asm/vr41xx/irq.h
>  delete mode 100644 arch/mips/include/asm/vr41xx/mpc30x.h
>  delete mode 100644 arch/mips/include/asm/vr41xx/pci.h
>  delete mode 100644 arch/mips/include/asm/vr41xx/siu.h
>  delete mode 100644 arch/mips/include/asm/vr41xx/tb0219.h
>  delete mode 100644 arch/mips/include/asm/vr41xx/tb0226.h
>  delete mode 100644 arch/mips/include/asm/vr41xx/tb0287.h
>  delete mode 100644 arch/mips/include/asm/vr41xx/vr41xx.h
>  delete mode 100644 arch/mips/pci/fixup-capcella.c
>  delete mode 100644 arch/mips/pci/fixup-mpc30x.c
>  delete mode 100644 arch/mips/pci/fixup-tb0219.c
>  delete mode 100644 arch/mips/pci/fixup-tb0226.c
>  delete mode 100644 arch/mips/pci/fixup-tb0287.c
>  delete mode 100644 arch/mips/pci/ops-vr41xx.c
>  delete mode 100644 arch/mips/pci/pci-vr41xx.c
>  delete mode 100644 arch/mips/pci/pci-vr41xx.h
>  delete mode 100644 arch/mips/vr41xx/Kconfig
>  delete mode 100644 arch/mips/vr41xx/Makefile
>  delete mode 100644 arch/mips/vr41xx/Platform
>  delete mode 100644 arch/mips/vr41xx/casio-e55/Makefile
>  delete mode 100644 arch/mips/vr41xx/casio-e55/setup.c
>  delete mode 100644 arch/mips/vr41xx/common/Makefile
>  delete mode 100644 arch/mips/vr41xx/common/bcu.c
>  delete mode 100644 arch/mips/vr41xx/common/cmu.c
>  delete mode 100644 arch/mips/vr41xx/common/giu.c
>  delete mode 100644 arch/mips/vr41xx/common/icu.c
>  delete mode 100644 arch/mips/vr41xx/common/init.c
>  delete mode 100644 arch/mips/vr41xx/common/irq.c
>  delete mode 100644 arch/mips/vr41xx/common/pmu.c
>  delete mode 100644 arch/mips/vr41xx/common/rtc.c
>  delete mode 100644 arch/mips/vr41xx/common/siu.c
>  delete mode 100644 arch/mips/vr41xx/common/type.c
>  delete mode 100644 arch/mips/vr41xx/ibm-workpad/Makefile
>  delete mode 100644 arch/mips/vr41xx/ibm-workpad/setup.c

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
