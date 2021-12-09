Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0F146F050
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242205AbhLIRIL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Dec 2021 12:08:11 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:40201 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242614AbhLIRIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:08:02 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B5786E0003;
        Thu,  9 Dec 2021 17:04:25 +0000 (UTC)
Date:   Thu, 9 Dec 2021 18:04:24 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>
Subject: [GIT PULL] mtd: Fixes for 5.16-rc5
Message-ID: <20211209180424.689b70db@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is a fixes MTD PR for the next -rc.

Thanks,
Miquèl

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.16-rc5

for you to fetch changes up to 27a030e8729255b2068f35c1cd609b532b263311:

  mtd: dataflash: Add device-tree SPI IDs (2021-12-03 14:33:59 +0100)

----------------------------------------------------------------
MTD fixes:
* dataflash: Add device-tree SPI IDs to avoid new warnings

Raw NAND fixes:
* Fix nand_choose_best_timings() on unsupported interface
* Fix nand_erase_op delay (wrong unit)
* fsmc:
  - Fix timing computation
  - Take instruction delay into account
* denali:
  - Add the dependency on HAS_IOMEM to silence robots

----------------------------------------------------------------
Cai Huoqing (1):
      mtd: rawnand: denali: Add the dependency on HAS_IOMEM

Herve Codina (4):
      mtd: rawnand: Fix nand_erase_op delay
      mtd: rawnand: Fix nand_choose_best_timings() on unsupported interface
      mtd: rawnand: fsmc: Take instruction delay into account
      mtd: rawnand: fsmc: Fix timing computation

Jon Hunter (1):
      mtd: dataflash: Add device-tree SPI IDs

 drivers/mtd/devices/mtd_dataflash.c |  8 ++++++++
 drivers/mtd/nand/raw/Kconfig        |  2 +-
 drivers/mtd/nand/raw/fsmc_nand.c    | 36 ++++++++++++++++++++++++++++--------
 drivers/mtd/nand/raw/nand_base.c    |  6 +++---
 4 files changed, 40 insertions(+), 12 deletions(-)
