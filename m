Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDFC545E43
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347195AbiFJIMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347182AbiFJIMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:12:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5B821FBFD;
        Fri, 10 Jun 2022 01:12:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 250FCB832AF;
        Fri, 10 Jun 2022 08:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF737C34114;
        Fri, 10 Jun 2022 08:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654848731;
        bh=PxOuTxz1K0pas/zBuMk+JU2ropTEuO522REQcdhSMZ8=;
        h=Date:From:To:Cc:Subject:From;
        b=EE7bqOY9MvsjtwxIcdJHLZSi6O1Gmw+asPpuNngLGSaMIVK2aXpuzH14slbY+/kod
         g4HskJGyHk2JA2NM/ZdekZl1jJ4T7KV6y22X/ErBbTYRMIf4kqOf+fk/VUHnq4h+yF
         9ZJV3kxWzdKPXLAR2CSFw9riiuCAb62cNKhcaRddeYqN2NWQTmT0/pCaIylvUC2RSZ
         7Vi35LIralek60oMe9TNBTXspfnzm255pwsZKpTtRvBJGKU/ukaVIWHej1LV+KZ8Jm
         VglW5uLRJg5zMLqHUjo0fUUJU0qBEMvF/N61fMQJUCnNcPnSL38AAH5MS8diJZGf4p
         c8OBsDUZNbXjA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nzZkV-0007L0-DD; Fri, 10 Jun 2022 10:12:07 +0200
Date:   Fri, 10 Jun 2022 10:12:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 5.19-rc2
Message-ID: <YqL81+c9KxC2y7tD@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.19-rc2

for you to fetch changes up to 158f7585bfcea4aae0ad4128d032a80fec550df1:

  USB: serial: option: add support for Cinterion MV31 with new baseline (2022-06-09 14:32:42 +0200)

----------------------------------------------------------------
USB-serial fixes for 5.19-rc2

Here are some new device ids for a modem and an Edgeport device.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Robert Eckelmann (1):
      USB: serial: io_ti: add Agilent E5805A support

Slark Xiao (1):
      USB: serial: option: add support for Cinterion MV31 with new baseline

 drivers/usb/serial/io_ti.c      | 2 ++
 drivers/usb/serial/io_usbvend.h | 1 +
 drivers/usb/serial/option.c     | 6 ++++++
 3 files changed, 9 insertions(+)
