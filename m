Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B8257FC26
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiGYJQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiGYJQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:16:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88647B1D9;
        Mon, 25 Jul 2022 02:16:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D22CB80E17;
        Mon, 25 Jul 2022 09:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10D5C341C6;
        Mon, 25 Jul 2022 09:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658740602;
        bh=p1L9X4cr5nqGRrrGRZFIZCDJY5CTvNwUGBFNDHKqUyM=;
        h=Date:From:To:Cc:Subject:From;
        b=haA5zII9WcGZpv/gEH4xXYzX1HU65Ub9t1RI/Q9wvDse2rJCG65VjvL25A+4MK1OT
         SitFJmePdRGb45Bhw6Wa+ptiCz1AJhbsiUEH0wUutpnBEqyUnBIIzrjEMHHs2/UySG
         D2CJF169kadQdOnT0vQKSSWLXz3EE9fFF8N+pqmhMzxzfOg8kwCciV8k9V564wyBMP
         UdWkI+WlPCSp6OYl4/HwUN6mfw2qn/6ELL2ubmRli5c3huRDeKZX1fIr+YJAXJVpar
         5THT13aw98doWVXQZrRVdoX+gDjB300crPWUSkRpUrQjF1l3tlWxlVZN3NR+7PXxMl
         byTfd4ztdBTXA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oFuCq-0001wi-LP; Mon, 25 Jul 2022 11:16:52 +0200
Date:   Mon, 25 Jul 2022 11:16:52 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial updates for 5.20-rc1
Message-ID: <Yt5fhOsVMClQhuti@hovoldconsulting.com>
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

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.20-rc1

for you to fetch changes up to 688ee1d1785c1359f9040f615dd8e6054962bce2:

  USB: serial: fix tty-port initialized comments (2022-07-25 11:01:40 +0200)

----------------------------------------------------------------
USB-serial updates for 5.20-rc1

Here are the USB-serial updates for 5.20-rc1, including

 - a fix up of some tty-port initialized comments that had got
   truncated and obfuscated

Included are also various clean ups.

All but the final commit have been in linux-next and with no reported
issues.

----------------------------------------------------------------
Jiang Jian (1):
      USB: serial: fix repeated word "the" in comments

Johan Hovold (1):
      USB: serial: fix tty-port initialized comments

Slark Xiao (1):
      USB: serial: use kmemdup instead of kmalloc + memcpy

Zhang Jiaming (1):
      USB: serial: io_edgeport: fix spelling mistakes

 drivers/usb/serial/cypress_m8.c  | 2 +-
 drivers/usb/serial/garmin_gps.c  | 4 +---
 drivers/usb/serial/io_edgeport.c | 4 ++--
 drivers/usb/serial/mos7720.c     | 2 +-
 drivers/usb/serial/opticon.c     | 4 +---
 drivers/usb/serial/sierra.c      | 7 +++----
 drivers/usb/serial/usb-serial.c  | 2 +-
 drivers/usb/serial/usb_wwan.c    | 3 ++-
 8 files changed, 12 insertions(+), 16 deletions(-)
