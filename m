Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3908E48AEED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbiAKNyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:54:15 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:51922 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241065AbiAKNyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:54:14 -0500
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 81AC7201378;
        Tue, 11 Jan 2022 13:54:12 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id BE00A808C2; Tue, 11 Jan 2022 14:01:55 +0100 (CET)
Date:   Tue, 11 Jan 2022 14:01:55 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] pcmcia updates for v5.17
Message-ID: <Yd1/w23Z8J6O6Y7v@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

A few PCMCIA changes since commit 278218f6778bc7d6f8b67199446c56cec7ebb841:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input (2022-01-01 10:21:49 -0800)

are available in the Git repository at

  https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next

for you to fetch changes up to fbb3485f1f931102d8ba606f1c28123f5b48afa3:

  pcmcia: fix setting of kthread task states (2022-01-09 21:30:04 +0100)

A number of odd cleanups and fixes, including one for a small race in the
handling of the pccardd kernel thread.

Thanks,
	Dominik

----------------------------------------------------------------
Cai Huoqing (1):
      pcmcia: Make use of the helper macro SET_NOIRQ_SYSTEM_SLEEP_PM_OPS()

Dominik Brodowski (4):
      pcmcia: comment out unused exca_readw() function
      pcmcia: make pcmcia_release_io() void, as no-one is interested in return value
      pcmcia: use sysfs_emit{,_at} for sysfs output
      pcmcia: fix setting of kthread task states

Lukas Bulwahn (1):
      pcmcia: clean up dead drivers for CompuLab CM-X255/CM-X270 boards

Tom Saeger (1):
      MAINTAINERS: update PCMCIA tree

Zhou Qingyang (2):
      pcmcia: rsrc_nonstatic: Fix a NULL pointer dereference in __nonstatic_find_io_region()
      pcmcia: rsrc_nonstatic: Fix a NULL pointer dereference in nonstatic_find_mem_region()

 MAINTAINERS                      |   2 +-
 drivers/pcmcia/Kconfig           |   2 +-
 drivers/pcmcia/Makefile          |   2 -
 drivers/pcmcia/cs.c              |   8 +--
 drivers/pcmcia/ds.c              |  20 +++----
 drivers/pcmcia/pcmcia_resource.c |   5 +-
 drivers/pcmcia/pxa2xx_cm_x255.c  | 124 ---------------------------------------
 drivers/pcmcia/pxa2xx_cm_x270.c  | 103 --------------------------------
 drivers/pcmcia/pxa2xx_cm_x2xx.c  |  44 --------------
 drivers/pcmcia/rsrc_nonstatic.c  |  12 +++-
 drivers/pcmcia/socket_sysfs.c    |  18 +++---
 drivers/pcmcia/yenta_socket.c    |  23 ++++----
 12 files changed, 43 insertions(+), 320 deletions(-)
 delete mode 100644 drivers/pcmcia/pxa2xx_cm_x255.c
 delete mode 100644 drivers/pcmcia/pxa2xx_cm_x270.c
 delete mode 100644 drivers/pcmcia/pxa2xx_cm_x2xx.c
