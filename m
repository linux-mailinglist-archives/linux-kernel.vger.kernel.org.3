Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550FF4B343D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 11:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiBLKbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 05:31:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbiBLKbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 05:31:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D976826130
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 02:31:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7515360B22
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A1DC340E7;
        Sat, 12 Feb 2022 10:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644661906;
        bh=zDmB0X+00j+oAV/3d9buv2ybfTEYi6ektx6lroaqTAY=;
        h=Date:From:To:Cc:Subject:From;
        b=bhZN8958JkcxHpLjeT2KghvXeHeqKn2LypAd3ISR75EzSp3+e2QRpj9L0FwT/h40q
         hf3y9FBByEobG+S829nH08ulHG0ZCs5PPaVHigyS2CP2BCPL6/ugrqPY+ZQcXO06gM
         LpcESuznyD9r553ZwvWkkZPQmK0sKt3LsKkpot0k=
Date:   Sat, 12 Feb 2022 11:31:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.17-rc4
Message-ID: <YgeMkKpZpeMO4hNj@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.17-rc4

for you to fetch changes up to c72ea20503610a4a7ba26c769357d31602769c01:

  iio: buffer: Fix file related error handling in IIO_BUFFER_GET_FD_IOCTL (2022-02-11 12:13:22 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 5.17-rc4

Here are a small number of char/misc driver fixes for 5.17-rc4 for
reported issues.  They contain:
	- phy driver fixes
	- iio driver fix
	- eeprom driver fix
	- speakup regression fix
	- fastrpc fix

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Al Cooper (2):
      phy: usb: Leave some clocks running during suspend
      phy: broadcom: Kconfig: Fix PHY_BRCM_USB config option

Dan Carpenter (2):
      phy: cadence: Sierra: fix error handling bugs in probe()
      phy: stm32: fix a refcount leak in stm32_usbphyc_pll_enable()

Greg Kroah-Hartman (1):
      Merge tag 'phy-fixes-5.17' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy into char-misc-next

Jonas Malaco (1):
      eeprom: ee1004: limit i2c reads to I2C_SMBUS_BLOCK_MAX

Kishon Vijay Abraham I (1):
      phy: ti: Fix missing sentinel for clk_div_table

Liu Ying (1):
      phy: dphy: Correct clk_pre parameter

Mathias Krause (2):
      misc: fastrpc: avoid double fput() on failed usercopy
      iio: buffer: Fix file related error handling in IIO_BUFFER_GET_FD_IOCTL

Robert Hancock (1):
      phy: xilinx: zynqmp: Fix bus width setting for SGMII

Samuel Thibault (1):
      speakup-dectlk: Restore pitch setting

Slark Xiao (2):
      bus: mhi: pci_generic: Add mru_default for Foxconn SDX55
      bus: mhi: pci_generic: Add mru_default for Cinterion MV31-W

Wan Jiabing (1):
      phy: phy-mtk-tphy: Fix duplicated argument in phy-mtk-tphy

 drivers/accessibility/speakup/speakup_dectlk.c   |  1 +
 drivers/bus/mhi/pci_generic.c                    |  2 ++
 drivers/gpu/drm/bridge/nwl-dsi.c                 | 12 ++++----
 drivers/iio/industrialio-buffer.c                | 14 +++++++--
 drivers/misc/eeprom/ee1004.c                     |  3 ++
 drivers/misc/fastrpc.c                           |  9 +++++-
 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c    |  3 +-
 drivers/phy/broadcom/Kconfig                     |  3 +-
 drivers/phy/broadcom/phy-brcm-usb.c              | 38 ++++++++++++++++++++++++
 drivers/phy/cadence/phy-cadence-sierra.c         | 35 +++++++++++++---------
 drivers/phy/mediatek/phy-mtk-tphy.c              |  2 +-
 drivers/phy/phy-core-mipi-dphy.c                 |  4 +--
 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c |  3 +-
 drivers/phy/st/phy-stm32-usbphyc.c               |  2 +-
 drivers/phy/ti/phy-j721e-wiz.c                   |  1 +
 drivers/phy/xilinx/phy-zynqmp.c                  | 11 +++----
 16 files changed, 105 insertions(+), 38 deletions(-)
