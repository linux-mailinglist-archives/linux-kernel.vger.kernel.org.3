Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D224507196
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353782AbiDSPZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238145AbiDSPY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:24:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD33122B3F;
        Tue, 19 Apr 2022 08:22:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49023615DB;
        Tue, 19 Apr 2022 15:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53772C385A5;
        Tue, 19 Apr 2022 15:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650381735;
        bh=xnaUpM14CJ/l8hnaYAvN1U/KLWOVk/c/hfwpGLkCRjs=;
        h=From:To:Cc:Subject:Date:From;
        b=ruyPEMhIphNgTOBY3Hg2jMQ8wAxanfrNYJu6udG6yD/U6ggzeoCO0ZHQfD2l8iJI0
         RUHwtfH8yahQNnxECckJO1s41qjZpESS9iDVXzzmGIFDLycYBAi3/pIEfpYALnbBqN
         GQhwsiwh2RRzWcl+SlaeagRp07o7dhBe8ROy3hz4IKiMCcsdVGNUc8/GIAwvM4JvZH
         bdaXKlCgT0asaCPztXIULhj4H6koFyEds5hAWBOEL1/Mg8xo7jgCd2wJ+V10ru0ndy
         UIgw8Ash5AQFWyMrEUAqcS5mIXmkwHtmZflcgj8I1diNgD82Cwi21YAy+DRX3dBmxi
         7V3aBTpz/IAnA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.18-rc3
Date:   Tue, 19 Apr 2022 16:22:07 +0100
Message-Id: <20220419152215.53772C385A5@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2c7d1b281286c46049cd22b43435cecba560edde:

  spi: bcm-qspi: fix MSPI only access with bcm_qspi_exec_mem_op() (2022-04-06 15:50:11 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.18-rc3

for you to fetch changes up to 8c235cc25087495c4288d94f547e9d3061004991:

  spi: atmel-quadspi: Fix the buswidth adjustment between spi-mem and controller (2022-04-13 16:43:12 +0100)

----------------------------------------------------------------
spi: Fixes for v5.18

A few more fixes for SPI, plus one new PCI ID for another Intel chipset.
All device specific stuff.

----------------------------------------------------------------
Allen-KH Cheng (1):
      spi: spi-mtk-nor: initialize spi controller after resume

Matthias Schiffer (1):
      spi: cadence-quadspi: fix incorrect supports_op() return value

Mika Westerberg (1):
      spi: intel: Add support for Raptor Lake-S SPI serial flash

Tudor Ambarus (1):
      spi: atmel-quadspi: Fix the buswidth adjustment between spi-mem and controller

 drivers/spi/atmel-quadspi.c       |  3 +++
 drivers/spi/spi-cadence-quadspi.c | 19 +++++++++++++++++--
 drivers/spi/spi-intel-pci.c       |  1 +
 drivers/spi/spi-mtk-nor.c         | 12 +++++++++++-
 4 files changed, 32 insertions(+), 3 deletions(-)
