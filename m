Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9E948FEF9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 22:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbiAPVGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 16:06:13 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:40095 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiAPVGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 16:06:11 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4E0321BF207;
        Sun, 16 Jan 2022 21:06:10 +0000 (UTC)
Date:   Sun, 16 Jan 2022 22:06:09 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] I3C changes for 5.17
Message-ID: <YeSIwUuZHPeBcAKR@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the i3c subsystem pull request for 5.17. Those are mostly non
urgent fixes and a few improvement of the Silvaco driver.

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.17

for you to fetch changes up to 13462ba1815db5a96891293a9cfaa2451f7bd623:

  i3c: master: dw: check return of dw_i3c_master_get_free_pos() (2022-01-13 02:05:50 +0100)

----------------------------------------------------------------
I3C for 5.17

Drivers:
 - svc: runtime pm suport

----------------------------------------------------------------
Christophe JAILLET (1):
      i3c/master/mipi-i3c-hci: Fix a potentially infinite loop in 'hci_dat_v1_get_index()'

Clark Wang (8):
      i3c: master: svc: move module reset behind clk enable
      i3c: master: svc: fix atomic issue
      i3c: master: svc: separate err, fifo and disable interrupt of reset function
      i3c: master: svc: add support for slave to stop returning data
      i3c: master: svc: set ODSTOP to let I2C device see the STOP signal
      i3c: master: svc: add runtime pm support
      i3c: master: svc: add the missing module device table
      i3c: master: svc: enable the interrupt in the enable ibi function

Jamie Iles (1):
      i3c: fix incorrect address slot lookup on 64-bit

Len Baker (2):
      i3c/master/mipi-i3c-hci: Prefer struct_size over open coded arithmetic
      i3c/master/mipi-i3c-hci: Prefer kcalloc over open coded arithmetic

Lukas Bulwahn (1):
      i3c: master: mipi-i3c-hci: correct the config reference for endianness

Tom Rix (1):
      i3c: master: dw: check return of dw_i3c_master_get_free_pos()

 drivers/i3c/master.c                     |   3 +-
 drivers/i3c/master/dw-i3c-master.c       |   4 +
 drivers/i3c/master/mipi-i3c-hci/core.c   |   2 +-
 drivers/i3c/master/mipi-i3c-hci/dat_v1.c |   4 +-
 drivers/i3c/master/mipi-i3c-hci/dma.c    |   2 +-
 drivers/i3c/master/mipi-i3c-hci/hci.h    |   2 +-
 drivers/i3c/master/svc-i3c-master.c      | 341 ++++++++++++++++++++++---------
 7 files changed, 260 insertions(+), 98 deletions(-)

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
