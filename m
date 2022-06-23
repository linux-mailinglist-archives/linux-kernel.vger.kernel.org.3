Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E93558019
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiFWQkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiFWQku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:40:50 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 670B846C97;
        Thu, 23 Jun 2022 09:40:49 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1o4Psl-0004rv-00; Thu, 23 Jun 2022 18:40:39 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 3F66BC01EF; Thu, 23 Jun 2022 18:40:32 +0200 (CEST)
Date:   Thu, 23 Jun 2022 18:40:32 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS fixes vor v5.19
Message-ID: <20220623164032.GA14476@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_5.19_2

for you to fetch changes up to 3748d2185ac4c2c6f80989672253aad909ecaf95:

  mips: lantiq: Add missing of_node_put() in irq.c (2022-06-21 22:34:03 +0200)

----------------------------------------------------------------
- several refcount fixes
- added missing clock for ingenic
- fix wrong irq_err_count for vr41xx

----------------------------------------------------------------
Aidan MacDonald (1):
      mips: dts: ingenic: Add TCU clock to x1000/x1830 tcu device node

Liang He (7):
      arch: mips: generic: Add missing of_node_put() in board-ranchu.c
      mips: mti-malta: Fix refcount leak in malta-time.c
      mips: ralink: Fix refcount leak in of.c
      mips: lantiq: falcon: Fix refcount leak bug in sysctrl
      mips: lantiq: xway: Fix refcount leak bug in sysctrl
      mips/pic32/pic32mzda: Fix refcount leak bugs
      mips: lantiq: Add missing of_node_put() in irq.c

huhai (1):
      MIPS: Remove repetitive increase irq_err_count

 arch/mips/boot/dts/ingenic/x1000.dtsi | 5 +++--
 arch/mips/boot/dts/ingenic/x1830.dtsi | 5 +++--
 arch/mips/generic/board-ranchu.c      | 1 +
 arch/mips/lantiq/falcon/sysctrl.c     | 6 ++++++
 arch/mips/lantiq/irq.c                | 1 +
 arch/mips/lantiq/xway/sysctrl.c       | 4 ++++
 arch/mips/mti-malta/malta-time.c      | 2 ++
 arch/mips/pic32/pic32mzda/init.c      | 7 ++++++-
 arch/mips/pic32/pic32mzda/time.c      | 3 +++
 arch/mips/ralink/of.c                 | 2 ++
 arch/mips/vr41xx/common/icu.c         | 2 --
 drivers/gpio/gpio-vr41xx.c            | 2 --
 12 files changed, 31 insertions(+), 9 deletions(-)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
