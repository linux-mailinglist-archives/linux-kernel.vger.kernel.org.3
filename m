Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DF05A92B1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbiIAJFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbiIAJEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:04:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19754BD2D;
        Thu,  1 Sep 2022 02:03:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46A6D61132;
        Thu,  1 Sep 2022 09:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ABDC433D6;
        Thu,  1 Sep 2022 09:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662023032;
        bh=AzHCgO/E2otj/+WzqrHgSLeQsmQDBQg/sQ7g3lI19jI=;
        h=Date:From:To:Cc:Subject:From;
        b=lK5L8GUkAnLhdseS8R407D5bMayLXlQpKEsxhlwm4z5huYYyHq+4q/C/qUCxvaHcT
         c6lj/90LLqY1i7ZyL6TooHph7/m3VrE4jxjToYemvJGhE8iC+wqqP9BAHxM2O6GHS5
         Vm/k7ZZDGmNE6aTdrxrKBmzLUoXHoTF86JVmt8GAgfFdAALlUwgp0Y31Dozs2Ow0k0
         GHaUgz7H3xt36O0pV+QOyJ3qT9qUnrMroUE/gaEJQmGcVhVUJ9lntI0GSitHoG+B5G
         gf3tlMz1ISv/P619csFPBaeBPg9qmk2RkkbKyMzWNhNo7UQYOeIJRPX586mZLXZUTm
         U5tRLn4T3uTuQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oTg77-0005T7-Dj; Thu, 01 Sep 2022 11:03:53 +0200
Date:   Thu, 1 Sep 2022 11:03:53 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 6.0-rc4
Message-ID: <YxB1eeDSKt+Ei5kf@hovoldconsulting.com>
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

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.0-rc4

for you to fetch changes up to 41ca302a697b64a3dab4676e01d0d11bb184737d:

  USB: serial: ch341: fix disabled rx timer on older devices (2022-08-31 15:51:06 +0200)

----------------------------------------------------------------
USB-serial fixes for 6.0-rc4

Here are a couple of fixes for two long-standing issues with some older
ch341 devices and a number of new device ids.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Johan Hovold (3):
      USB: serial: cp210x: add Decagon UCA device id
      USB: serial: ch341: fix lost character on LCR updates
      USB: serial: ch341: fix disabled rx timer on older devices

Niek Nooijens (1):
      USB: serial: ftdi_sio: add Omron CS1W-CIF31 device id

Slark Xiao (1):
      USB: serial: option: add support for Cinterion MV32-WA/WB RmNet mode

Yan Xinyu (1):
      USB: serial: option: add support for OPPO R11 diag port

Yonglin Tan (1):
      USB: serial: option: add Quectel EM060K modem

 drivers/usb/serial/ch341.c        | 16 ++++++++++++++--
 drivers/usb/serial/cp210x.c       |  1 +
 drivers/usb/serial/ftdi_sio.c     |  2 ++
 drivers/usb/serial/ftdi_sio_ids.h |  6 ++++++
 drivers/usb/serial/option.c       | 15 +++++++++++++++
 5 files changed, 38 insertions(+), 2 deletions(-)
