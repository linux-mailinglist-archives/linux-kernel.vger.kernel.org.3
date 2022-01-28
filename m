Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3972849FAC6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348874AbiA1Nd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:33:57 -0500
Received: from elvis.franken.de ([193.175.24.41]:44030 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241847AbiA1Ndz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:33:55 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nDRNy-0004tH-00; Fri, 28 Jan 2022 14:33:54 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 84173C1D30; Fri, 28 Jan 2022 14:33:45 +0100 (CET)
Date:   Fri, 28 Jan 2022 14:33:45 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS fixes for v5.17
Message-ID: <20220128133345.GA10829@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes-5.17_1

for you to fetch changes up to fa62f39dc7e25fc16371b958ac59b9a6fd260bea:

  MIPS: Fix build error due to PTR used in more places (2022-01-27 09:04:19 +0100)

----------------------------------------------------------------
- build fix for allmodconfig

----------------------------------------------------------------
Thomas Bogendoerfer (1):
      MIPS: Fix build error due to PTR used in more places

 arch/mips/include/asm/asm.h            |   4 +-
 arch/mips/include/asm/ftrace.h         |   4 +-
 arch/mips/include/asm/r4kcache.h       |   4 +-
 arch/mips/include/asm/unaligned-emul.h | 176 ++++++++++++++++-----------------
 arch/mips/kernel/mips-r2-to-r6-emul.c  | 104 +++++++++----------
 arch/mips/kernel/r2300_fpu.S           |   6 +-
 arch/mips/kernel/r4k_fpu.S             |   2 +-
 arch/mips/kernel/relocate_kernel.S     |  22 ++---
 arch/mips/kernel/scall32-o32.S         |  10 +-
 arch/mips/kernel/scall64-n32.S         |   2 +-
 arch/mips/kernel/scall64-n64.S         |   2 +-
 arch/mips/kernel/scall64-o32.S         |  10 +-
 arch/mips/kernel/syscall.c             |   8 +-
 arch/mips/lib/csum_partial.S           |   4 +-
 arch/mips/lib/memcpy.S                 |   4 +-
 arch/mips/lib/memset.S                 |   2 +-
 arch/mips/lib/strncpy_user.S           |   4 +-
 arch/mips/lib/strnlen_user.S           |   2 +-
 18 files changed, 185 insertions(+), 185 deletions(-)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
