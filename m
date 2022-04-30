Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC32515EE7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 17:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242961AbiD3P4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 11:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237837AbiD3P4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 11:56:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AA249F92;
        Sat, 30 Apr 2022 08:52:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A0F6B80025;
        Sat, 30 Apr 2022 15:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8865AC385AD;
        Sat, 30 Apr 2022 15:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651333967;
        bh=KJ1PGr1+rrkqVSLLv17OIsMpsvOeGRPfd4RQ4I2cOU4=;
        h=Date:From:To:Cc:Subject:From;
        b=jhQrjW66KxlXNAQzMH+frmD8XqyiUUDUxkn/yGQBtujS4yV3N9tDl2tc64gZeW9wS
         Gom9uurQ7gqNzY0MHQ0FeoGFOfnK4TDtVwi2kmbRj/LpI/Ad1eKDXB63MjUOPPUc+F
         zKJfajolVFqBQDQI1/vxDxT3cSEs2n5AkcdK4YNY=
Date:   Sat, 30 Apr 2022 17:52:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.18-rc5
Message-ID: <Ym1bTC/HwRF70D+S@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.18-rc5

for you to fetch changes up to 03e607cbb2931374db1825f371e9c7f28526d3f4:

  usb: phy: generic: Get the vbus supply (2022-04-26 14:10:54 +0200)

----------------------------------------------------------------
USB fixes for 5.18-rc5

Here are a number of small USB driver fixes for 5.18-rc5 for some
reported issues and new quirks.  They include:
	- dwc3 driver fixes
	- xhci driver fixes
	- typec driver fixes
	- new usb-serial driver ids
	- added new USB devices to existing quirk tables
	- other tiny fixes

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Borislav Petkov (1):
      usb: typec: tcpm: Fix undefined behavior due to shift overflowing the constant

Bruno Thomsen (1):
      USB: serial: cp210x: add PIDs for Kamstrup USB Meter Reader

Christophe JAILLET (1):
      usb: misc: eud: Fix an error handling path in eud_probe()

Dan Vacura (1):
      usb: gadget: uvc: Fix crash when encoding data for usb request

Daniele Palmas (1):
      USB: serial: option: add Telit 0x1057, 0x1058, 0x1075 compositions

Evan Green (1):
      xhci: Enable runtime PM on second Alderlake controller

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-5.18-rc4' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Hangyu Hua (1):
      usb: misc: fix improper handling of refcount in uss720_probe()

Heikki Krogerus (3):
      usb: typec: ucsi: Fix reuse of completion structure
      usb: typec: ucsi: Fix role swapping
      usb: dwc3: pci: add support for the Intel Meteor Lake-P

Henry Lin (1):
      xhci: stop polling roothubs after shutdown

Kees Cook (1):
      USB: serial: whiteheat: fix heap overflow in WHITEHEAT_GET_DTR_RTS

Krzysztof Kozlowski (1):
      dt-bindings: usb: samsung,exynos-usb2: add missing required reg

Macpaul Lin (1):
      usb: mtu3: fix USB 3.0 dual-role-switch from device to host

Mathias Nyman (1):
      xhci: increase usb U3 -> U0 link resume timeout from 100ms to 500ms

Oliver Neukum (2):
      USB: quirks: add a Realtek card reader
      USB: quirks: add STRING quirk for VCOM device

Pawel Laszczak (1):
      usb: cdns3: Fix issue for clear halt endpoint

Peter Geis (1):
      usb: dwc3: fix backwards compat with rockchip devices

Ren Zhijie (1):
      usb: typec: rt1719: Fix build error without CONFIG_POWER_SUPPLY

Sean Anderson (1):
      usb: phy: generic: Get the vbus supply

Slark Xiao (1):
      USB: serial: option: add support for Cinterion MV32-WA/MV32-WB

Sven Peter (1):
      usb: dwc3: Try usb-role-switch first in dwc3_drd_init

Tasos Sahanidis (1):
      usb: core: Don't hold the device lock while sleeping in do_proc_control()

Thinh Nguyen (3):
      usb: dwc3: core: Fix tx/rx threshold settings
      usb: dwc3: core: Only handle soft-reset in DCTL
      usb: dwc3: gadget: Return proper request status

Vijayavardhan Vennapusa (1):
      usb: gadget: configfs: clear deactivation flag in configfs_composite_unbind()

Weitao Wang (1):
      USB: Fix xhci event ring dequeue pointer ERDP update issue

Weitao Wango (1):
      USB: Fix ehci infinite suspend-resume loop issue in zhaoxin

zhangqilong (1):
      usb: xhci: tegra:Fix PM usage reference leak of tegra_xusb_unpowergate_partitions

 .../bindings/usb/samsung,exynos-usb2.yaml          |  1 +
 drivers/usb/cdns3/cdns3-gadget.c                   |  7 +++--
 drivers/usb/core/devio.c                           | 14 +++++----
 drivers/usb/core/quirks.c                          |  6 ++++
 drivers/usb/dwc3/core.c                            | 34 ++++++++++++++++++----
 drivers/usb/dwc3/drd.c                             | 11 ++++---
 drivers/usb/dwc3/dwc3-pci.c                        |  8 +++++
 drivers/usb/dwc3/gadget.c                          | 31 +++++++++++++++++++-
 drivers/usb/gadget/configfs.c                      |  2 ++
 drivers/usb/gadget/function/uvc_queue.c            |  2 ++
 drivers/usb/host/ehci-hcd.c                        | 23 +++++++++++++++
 drivers/usb/host/ehci-pci.c                        |  4 +++
 drivers/usb/host/ehci.h                            |  1 +
 drivers/usb/host/xhci-hub.c                        |  2 +-
 drivers/usb/host/xhci-pci.c                        |  4 ++-
 drivers/usb/host/xhci-ring.c                       |  1 +
 drivers/usb/host/xhci-tegra.c                      |  4 +--
 drivers/usb/host/xhci.c                            | 11 +++++++
 drivers/usb/misc/qcom_eud.c                        | 10 +++----
 drivers/usb/misc/uss720.c                          |  3 +-
 drivers/usb/mtu3/mtu3_dr.c                         |  6 ++--
 drivers/usb/phy/phy-generic.c                      |  7 +++++
 drivers/usb/serial/cp210x.c                        |  2 ++
 drivers/usb/serial/option.c                        | 12 ++++++++
 drivers/usb/serial/whiteheat.c                     |  5 ++--
 drivers/usb/typec/Kconfig                          |  1 +
 drivers/usb/typec/ucsi/ucsi.c                      | 24 ++++++++++-----
 include/linux/usb/pd_bdo.h                         |  2 +-
 28 files changed, 193 insertions(+), 45 deletions(-)
