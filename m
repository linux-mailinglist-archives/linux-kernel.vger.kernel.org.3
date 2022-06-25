Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCB555AB0E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 16:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiFYOmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 10:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbiFYOl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 10:41:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4064D1A3;
        Sat, 25 Jun 2022 07:41:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 39CAACE0B2B;
        Sat, 25 Jun 2022 14:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCDBC3411C;
        Sat, 25 Jun 2022 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656168114;
        bh=fvytuOzKz8+Hgfrzl0n5EyY1atFGuwiHQUBiCMoc5as=;
        h=Date:From:To:Cc:Subject:From;
        b=TKEEW+sQ7qjwGRKjbL+FrecAmKbTkHP5YHbBA7WBLQhP2IUYjgy1EF0ftl/v9FXB8
         yWHOMR8iPEnm1tAPMExdGIBgnh1FwVzXAjXtTXByx1+yjyDc0XYYT2XYNpImv3cWGt
         cCREzkFQcwa9xIzNeMRM+gokyEtn6ie4cZ5/zCYQ=
Date:   Sat, 25 Jun 2022 16:41:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.19-rc4
Message-ID: <YrcerztKA0mJxjVh@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.19-rc4

for you to fetch changes up to b24346a240b36cfc4df194d145463874985aa29b:

  usb: chipidea: udc: check request status before setting device address (2022-06-24 13:45:23 +0200)

----------------------------------------------------------------
USB driver fixes for 5.19-rc4

Here are some small USB driver fixes and new device ids for 5.19-rc4 for
a few small reported issues.  They include:
	- new usb-serial driver ids
	- MAINTAINERS file update to properly catch the USB dts files
	- dt-bindings fixes for reported build warnings
	- xhci driver fixes for reported problems
	- typec Kconfig dependancy fix
	- raw_gadget fuzzing fixes found by syzbot
	- chipidea driver bugfix
	- usb gadget uvc bugfix

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (2):
      usb: gadget: Fix non-unique driver names in raw-gadget driver
      USB: gadget: Fix double-free bug in raw_gadget driver

Andy Shevchenko (1):
      usb: typec: wcove: Drop wrong dependency to INTEL_SOC_PMIC

Carlo Lobrano (1):
      USB: serial: option: add Telit LE910Cx 0x1250 composition

Dan Vacura (1):
      usb: gadget: uvc: fix list double add in uvcg_video_pump

Geert Uytterhoeven (2):
      dt-bindings: usb: ohci: Increase the number of PHYs
      dt-bindings: usb: ehci: Increase the number of PHYs

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-5.19-rc4' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Hongyu Xie (1):
      xhci: Keep interrupt disabled in initialization until host is running.

Johan Hovold (1):
      USB: serial: pl2303: add support for more HXN (G) types

Lukas Bulwahn (1):
      MAINTAINERS: add include/dt-bindings/usb to USB SUBSYSTEM

Macpaul Lin (1):
      USB: serial: option: add Quectel RM500K module support

Mathias Nyman (1):
      xhci: turn off port power in shutdown

Tanveer Alam (1):
      xhci-pci: Allow host runtime PM as default for Intel Raptor Lake xHCI

Utkarsh Patel (1):
      xhci-pci: Allow host runtime PM as default for Intel Meteor Lake xHCI

Xu Yang (1):
      usb: chipidea: udc: check request status before setting device address

Yonglin Tan (1):
      USB: serial: option: add Quectel EM05-G modem

 .../devicetree/bindings/usb/generic-ehci.yaml      |  3 +-
 .../devicetree/bindings/usb/generic-ohci.yaml      |  3 +-
 MAINTAINERS                                        |  1 +
 drivers/usb/chipidea/udc.c                         |  3 ++
 drivers/usb/gadget/function/uvc_video.c            |  3 ++
 drivers/usb/gadget/legacy/raw_gadget.c             | 63 ++++++++++++++++------
 drivers/usb/host/xhci-hub.c                        |  2 +-
 drivers/usb/host/xhci-pci.c                        |  6 ++-
 drivers/usb/host/xhci.c                            | 50 +++++++++++------
 drivers/usb/host/xhci.h                            |  2 +
 drivers/usb/serial/option.c                        |  6 +++
 drivers/usb/serial/pl2303.c                        | 29 +++++-----
 drivers/usb/typec/tcpm/Kconfig                     |  1 -
 13 files changed, 124 insertions(+), 48 deletions(-)
