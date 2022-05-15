Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A1352780F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 16:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbiEOO1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 10:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237157AbiEOO1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 10:27:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B312A26D;
        Sun, 15 May 2022 07:27:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F45DB80CFA;
        Sun, 15 May 2022 14:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83FEC385B8;
        Sun, 15 May 2022 14:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652624827;
        bh=nDUjVQrVdv4GW477qujXZY3cFAwB5uBxzIt6AfcP7lI=;
        h=Date:From:To:Cc:Subject:From;
        b=lkXSBWFbOcy6Bve1L1Hi4GtW8wVrnbgBWlndYqNEgAasFtrZZntqQBz9awmDWc+nY
         87bydvn44EpxOI3mV5D15CHsBQzv9/5Etf/KSEdWrAR/RWPzyV/gUEa1g29a5c8JXF
         bOT3t4y4vKO5D1hqcGHP7knPIH9UQY+ykvOg0S5M=
Date:   Sun, 15 May 2022 16:27:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.18-rc7
Message-ID: <YoENuIsPvWwfh3F7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:

  Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.18-rc7

for you to fetch changes up to 757b9f6e6a2070043e5f215ff4afe350ecfb2bf7:

  Merge tag 'usb-serial-5.18-rc7' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial (2022-05-13 08:29:40 +0200)

----------------------------------------------------------------
USB fixes for 5.18-rc7

Here are some small fixes for reported issues with some USB drivers.
They include:
	- xhci fixes for xhci-mtk platform driver
	- typec driver fixes for reported problems.
	- cdc-wdm read-stuck fix
	- gadget driver fix for reported race condition
	- new usb-serial driver ids

All of these have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
ChiYuan Huang (1):
      usb: typec: tcpci_mt6360: Update for BMC PHY setting

Chunfeng Yun (2):
      usb: xhci-mtk: fix fs isoc's transfer error
      usb: xhci-mtk: remove bandwidth budget table

Dan Vacura (1):
      usb: gadget: uvc: allow for application to cleanly shutdown

Ethan Yang (1):
      USB: serial: qcserial: add support for Sierra Wireless EM7590

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-5.18-rc7' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial

Schspa Shi (1):
      usb: gadget: fix race when gadget driver register via ioctl

Scott Chen (1):
      USB: serial: pl2303: add device id for HP LM930 Display

Sergey Ryazanov (1):
      usb: cdc-wdm: fix reading stuck on device close

Sven Schwermer (2):
      USB: serial: option: add Fibocom L610 modem
      USB: serial: option: add Fibocom MA510 modem

Uwe Kleine-König (1):
      usb: typec: tcpci: Don't skip cleanup in .remove() on error

 drivers/usb/class/cdc-wdm.c            |  1 +
 drivers/usb/gadget/function/f_uvc.c    | 25 ++++++++++
 drivers/usb/gadget/function/uvc.h      |  2 +
 drivers/usb/gadget/function/uvc_v4l2.c |  3 +-
 drivers/usb/gadget/legacy/raw_gadget.c |  2 +
 drivers/usb/host/xhci-mtk-sch.c        | 90 +++++++---------------------------
 drivers/usb/host/xhci-mtk.h            |  2 -
 drivers/usb/serial/option.c            |  4 ++
 drivers/usb/serial/pl2303.c            |  1 +
 drivers/usb/serial/pl2303.h            |  1 +
 drivers/usb/serial/qcserial.c          |  2 +
 drivers/usb/typec/tcpm/tcpci.c         |  2 +-
 drivers/usb/typec/tcpm/tcpci_mt6360.c  | 26 ++++++++++
 13 files changed, 86 insertions(+), 75 deletions(-)
