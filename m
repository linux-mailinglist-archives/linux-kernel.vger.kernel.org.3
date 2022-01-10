Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5146489BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbiAJPBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:01:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58752 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiAJPBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:01:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14BFE612E5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 15:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75273C36AE5;
        Mon, 10 Jan 2022 15:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641826872;
        bh=chLPcOsfhco0xkJ/aJbDSk8HiD7VNC73iOy8eSfn9Dw=;
        h=Date:From:To:Cc:Subject:From;
        b=ABKKVgVwNLlna44GJxLxCXBaxXybnlRxFB4dBBpkRIOJhVUxQ37MrEu3UA9Akp2Xg
         xeza6vpbBC1sNz3mwSGKepUbcxFdKYHgKkxGwgocxJo/1eh39XrcdfHwHsAQNldeKk
         8ipG18cInQzN7a6nCi2MQrOSLkc1DJA7Zmz4tk+sn8jHRt3DVa7pnD5cTF2kQZXUct
         7TYhzBK6QdRbWRTiDFvPnsbNYdyhY4DEvG9fT2dq6L4G8M49UV4xASqTPk/Xp4iLeZ
         33rHBC3ID9SIEKQ/xMHvZyUmv45Ulz/HgcNMFzQdkcYB9jiczCBU0YNT5KXg+E+E9f
         ML7d05geykR1g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1n6wAX-0000cB-Ab; Mon, 10 Jan 2022 16:01:09 +0100
Date:   Mon, 10 Jan 2022 16:01:09 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] GNSS updates for 5.17-rc1
Message-ID: <YdxKNTuKaZK0m9nl@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git tags/gnss-5.17-rc1

for you to fetch changes up to 547d2167c5c3cd879ed5e86e88cfa7daaf1228a5:

  gnss: usb: add support for Sierra Wireless XM1210 (2021-12-22 15:38:12 +0100)

----------------------------------------------------------------
GNSS updates for 5.17-rc1

Here are the GNSS updates for 5.17-rc1, including:

 - support for GNSS receivers with USB interface
 - support for Sierra Wireless XM1210

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Johan Hovold (3):
      gnss: drop stray semicolons
      gnss: add USB support
      gnss: usb: add support for Sierra Wireless XM1210

 drivers/gnss/Kconfig  |  11 +++
 drivers/gnss/Makefile |   3 +
 drivers/gnss/mtk.c    |   2 +-
 drivers/gnss/serial.c |   2 +-
 drivers/gnss/sirf.c   |   2 +-
 drivers/gnss/ubx.c    |   2 +-
 drivers/gnss/usb.c    | 214 ++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 232 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gnss/usb.c
