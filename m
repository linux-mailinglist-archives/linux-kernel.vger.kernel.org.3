Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D5F4A80AB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 09:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349626AbiBCI4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 03:56:12 -0500
Received: from elvis.franken.de ([193.175.24.41]:54799 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233411AbiBCI4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:56:11 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nFXuT-0002mf-00; Thu, 03 Feb 2022 09:56:09 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 0C783C20D9; Thu,  3 Feb 2022 09:56:03 +0100 (CET)
Date:   Thu, 3 Feb 2022 09:56:02 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS fixes for v5.17
Message-ID: <20220203085602.GA5364@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fa62f39dc7e25fc16371b958ac59b9a6fd260bea:

  MIPS: Fix build error due to PTR used in more places (2022-01-27 09:04:19 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes-5.17_2

for you to fetch changes up to 2161ba070999a709f975910b6b9ad6b51cd6f120:

  MIPS: KVM: fix vz.c kernel-doc notation (2022-02-01 08:36:27 +0100)

----------------------------------------------------------------
- fix missed change for PTR->PTR_WD conversion
- kernel-doc fixes

----------------------------------------------------------------
Randy Dunlap (1):
      MIPS: KVM: fix vz.c kernel-doc notation

Thomas Bogendoerfer (1):
      MIPS: octeon: Fix missed PTR->PTR_WD conversion

 arch/mips/cavium-octeon/octeon-memcpy.S |  2 +-
 arch/mips/kvm/vz.c                      | 12 +++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
