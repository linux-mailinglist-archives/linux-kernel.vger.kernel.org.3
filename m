Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC77947A042
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 11:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhLSKzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 05:55:05 -0500
Received: from elvis.franken.de ([193.175.24.41]:55000 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229801AbhLSKzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 05:55:04 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mytqI-0008N1-00; Sun, 19 Dec 2021 11:55:02 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 25C34C09A3; Sun, 19 Dec 2021 11:54:55 +0100 (CET)
Date:   Sun, 19 Dec 2021 11:54:55 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS fixes for v5.16
Message-ID: <20211219105455.GA3372@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_5.16_3

for you to fetch changes up to 09d97da660ff77df20984496aa0abcd6b88819f2:

  MIPS: Only define pci_remap_iospace() for Ralink (2021-12-09 10:22:24 +0100)

----------------------------------------------------------------
- only enable pci_remap_iospace() for Ralink devices

----------------------------------------------------------------
Tiezhu Yang (1):
      MIPS: Only define pci_remap_iospace() for Ralink

 arch/mips/include/asm/mach-ralink/spaces.h | 2 ++
 arch/mips/include/asm/pci.h                | 4 ----
 arch/mips/pci/pci-generic.c                | 2 ++
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
