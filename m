Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E591854F296
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380391AbiFQIOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380002AbiFQIOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:14:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C145060A83;
        Fri, 17 Jun 2022 01:14:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54E3A61FA8;
        Fri, 17 Jun 2022 08:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D76C3411B;
        Fri, 17 Jun 2022 08:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655453678;
        bh=oXIanLHIRcl8toSGd0XD80ERDEnuuIhwGerWOBVeryU=;
        h=Date:From:To:Cc:Subject:From;
        b=FwN0+4ItjCIoDAkk/QdF+7PY3lkt66mV/c0PFayIuWC8kPVcMOI5Cl8ArkkdEc2Bm
         GkwMlewGIVfLFuel6WO8a0K7sWv+HGmpqcBy768BwWn/kOwI9TLbQObZZkRdeUrGbK
         EFvGNz0gpl9kGxId8/bBxpCoSM0YC4ilMKJk0ER8=
Date:   Fri, 17 Jun 2022 10:14:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.19-rc3
Message-ID: <Yqw361X4Szdht3HF@kroah.com>
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

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.19-rc3

for you to fetch changes up to 0698f0209d8032e8869525aeb68f65ee7fde12ad:

  usb: gadget: f_fs: change ep->ep safe in ffs_epfile_io() (2022-06-10 14:45:38 +0200)

----------------------------------------------------------------
USB driver fixes for 5.19-rc3

Here are some small USB driver fixes and new device ids for 5.19-rc3

They include:
	- new usb-serial driver device ids
	- usb gadget driver fixes for reported problems
	- cdnsp driver fix
	- dwc3 driver fixes for reported problems
	- dwc3 driver fix for merge problem that I caused in 5.18
	- xhci driver fixes
	- dwc2 memory leak fix

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-5.19-rc2' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Jing Leng (1):
      usb: cdnsp: Fixed setting last_trb incorrectly

Linyu Yuan (2):
      usb: gadget: f_fs: change ep->status safe in ffs_epfile_io()
      usb: gadget: f_fs: change ep->ep safe in ffs_epfile_io()

Marian Postevca (1):
      usb: gadget: u_ether: fix regression in setting fixed MAC address

Mathias Nyman (1):
      xhci: Fix null pointer dereference in resume if xhci has only one roothub

Miaoqian Lin (2):
      usb: dwc2: Fix memory leak in dwc2_hcd_init
      usb: gadget: lpc32xx_udc: Fix refcount leak in lpc32xx_udc_probe

Robert Eckelmann (1):
      USB: serial: io_ti: add Agilent E5805A support

Slark Xiao (1):
      USB: serial: option: add support for Cinterion MV31 with new baseline

Stephan Gerhold (1):
      usb: dwc3: pci: Restore line lost in merge conflict resolution

Stephen Rothwell (1):
      USB: fixup for merge issue with "usb: dwc3: Don't switch OTG -> peripheral if extcon is present"

Wesley Cheng (1):
      usb: dwc3: gadget: Fix IN endpoint max packet size allocation

 drivers/usb/cdns3/cdnsp-ring.c        | 19 ++++++++++-------
 drivers/usb/dwc2/hcd.c                |  2 +-
 drivers/usb/dwc3/core.c               |  9 ++------
 drivers/usb/dwc3/dwc3-pci.c           |  1 +
 drivers/usb/dwc3/gadget.c             | 26 +++++++++++++----------
 drivers/usb/gadget/function/f_fs.c    | 40 ++++++++++++++++++++++-------------
 drivers/usb/gadget/function/u_ether.c | 12 +++++++++--
 drivers/usb/gadget/udc/lpc32xx_udc.c  |  1 +
 drivers/usb/host/xhci.c               | 15 +++++--------
 drivers/usb/serial/io_ti.c            |  2 ++
 drivers/usb/serial/io_usbvend.h       |  1 +
 drivers/usb/serial/option.c           |  6 ++++++
 12 files changed, 80 insertions(+), 54 deletions(-)
