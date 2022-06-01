Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88479539C91
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 07:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345048AbiFAFXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 01:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiFAFXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 01:23:14 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8A62F38A
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 22:23:13 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 3C31E201362;
        Wed,  1 Jun 2022 05:23:09 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id C1D8080129; Wed,  1 Jun 2022 07:23:03 +0200 (CEST)
Date:   Wed, 1 Jun 2022 07:23:03 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] pcmcia updates for v5.19
Message-ID: <Ypb3t6HB1D51+hfU@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

A few PCMCIA changes since commit 0457e5153e0e8420134f60921349099e907264ca:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2022-02-04 16:28:11 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next

for you to fetch changes up to 2ef4bb24ff39ae4af89b80bcc5d516f55368e8ae:

  pcmcia: Use platform_get_irq() to get the interrupt (2022-05-28 09:25:31 +0200)


A few odd cleanups and fixes, including a Kconfig fix to add a
required dependency on MIPS.


----------------------------------------------------------------
Minghao Chi (1):
      pcmcia: Use platform_get_irq() to get the interrupt

Randy Dunlap (1):
      pcmcia: db1xxx_ss: restrict to MIPS_DB1XXX boards

tangmeng (1):
      drivers/pcmcia: Fix typo in comment

 drivers/pcmcia/Kconfig          | 2 +-
 drivers/pcmcia/bcm63xx_pcmcia.c | 9 +++++----
 drivers/pcmcia/rsrc_nonstatic.c | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)
