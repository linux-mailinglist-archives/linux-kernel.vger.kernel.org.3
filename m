Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4924C4622
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241182AbiBYNXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241213AbiBYNW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:22:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A63E194162;
        Fri, 25 Feb 2022 05:22:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B12361CD4;
        Fri, 25 Feb 2022 13:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA894C340E7;
        Fri, 25 Feb 2022 13:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645795344;
        bh=D7408mBI5G/gY3GzXDcCdga0z2k4yNjN62AjEuHKo54=;
        h=Date:From:To:Cc:Subject:From;
        b=1s8b17gtQYlZyrUT5HbFi8sQ8CRxNX1VpYk2O6lL2eaAyYLaX9E6LmnjTUOf8o0KH
         QhIVlL7S7cNbEchx9bV4LaA5WcsQTFgTAFCOvQyYSEaIqD1srp5TNMqGlVx4p52jJ9
         tJexPx2aQ1fsQ59i/xLlzu1Gk/7VdP+JJcn9zqb0=
Date:   Fri, 25 Feb 2022 14:22:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.17-rc6
Message-ID: <YhjYDWv9q/44eWZu@kroah.com>
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

The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.17-rc6

for you to fetch changes up to 19eae24b76c27dedfb166dc06a8c48e052cbc814:

  Merge tag 'usb-serial-5.17-rc6' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2022-02-24 14:51:45 +0100)

----------------------------------------------------------------
USB fixes for 5.17-rc6

Here are a number of small USB driver fixes for 5.17-rc6 to resolve
reported problems and add new device ids.  They include:
	- dwc3 device mapping fix
	- dwc3 new device ids
	- xhci driver fixes
	- dwc3 driver fixes
	- gadget driver fixes
	- usb-serial driver device id updates

All of these have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Daehwan Jung (1):
      usb: gadget: rndis: add spinlock for rndis response list

Daniele Palmas (1):
      USB: serial: option: add Telit LE910R1 compositions

Dmytro Bagrii (1):
      Revert "USB: serial: ch341: add new Product ID for CH341A"

Fabrice Gasnier (1):
      usb: dwc2: drd: fix soft connect when gadget is unconfigured

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-5.17-rc6' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Hans de Goede (2):
      usb: dwc3: pci: Add "snps,dis_u2_susphy_quirk" for Intel Bay Trail
      usb: dwc3: pci: Fix Bay Trail phy GPIO mappings

Heikki Krogerus (1):
      usb: dwc3: pci: add support for the Intel Raptor Lake-S

Hongyu Xie (1):
      xhci: Prevent futile URB re-submissions due to incorrect return value.

Jens Axboe (1):
      tps6598x: clear int mask on probe failure

Puma Hsu (1):
      xhci: re-initialize the HC during resume if HCE was set

Sebastian Andrzej Siewior (1):
      usb: dwc3: gadget: Let the interrupt handler disable bottom halves.

Slark Xiao (1):
      USB: serial: option: add support for DW5829e

Szymon Heidrich (1):
      USB: gadget: validate endpoint index for xilinx udc

 drivers/usb/dwc2/core.h             |  2 ++
 drivers/usb/dwc2/drd.c              |  6 ++++--
 drivers/usb/dwc3/dwc3-pci.c         | 21 ++++++++++++++++++---
 drivers/usb/dwc3/gadget.c           |  2 ++
 drivers/usb/gadget/function/rndis.c |  8 ++++++++
 drivers/usb/gadget/function/rndis.h |  1 +
 drivers/usb/gadget/udc/udc-xilinx.c |  6 ++++++
 drivers/usb/host/xhci.c             | 28 +++++++++++++++++++---------
 drivers/usb/serial/ch341.c          |  1 -
 drivers/usb/serial/option.c         | 12 ++++++++++++
 drivers/usb/typec/tipd/core.c       |  7 ++++---
 11 files changed, 76 insertions(+), 18 deletions(-)
