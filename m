Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74CB4D5E41
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347370AbiCKJUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243086AbiCKJUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:20:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6251BD048;
        Fri, 11 Mar 2022 01:19:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BA0A61F27;
        Fri, 11 Mar 2022 09:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0641C340E9;
        Fri, 11 Mar 2022 09:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646990373;
        bh=wuHe8NaXh4zJwIPauMCZkRknqC9dqhWaU0wygMAjDVg=;
        h=Date:From:To:Cc:Subject:From;
        b=HRmAO2ddpQxXLp72B4m1QgBy0/HxUOae4lHjp5lXlaQWTnAOLP6uNVS85mBVbZWa0
         7Bp9HAMuvsh7VIDW39YLgJvz6fx89UoE4FvNkeIBF19+qfo6OQnWR06Ww9HmSy84FR
         jrbdH17rca80IjsBTmc1BnvA6DV8pGiNrnWeN2aljMQ6tG4xZ9C0tzJp2enaz2oz//
         OL6OIA5nngrLdfQICFxsWZwz04s/7/UiwmCgS5QdwiKZnwFbUE7IUbnAMpDtL7TmLq
         6u9AVGuzJcjB/3RecSRBybKv44/7owEsEkH8a2kDTH7VVyr5vFiUeyNfhdiAf3iMh6
         p377W5O0Eo1xA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nSbQm-0001N9-B8; Fri, 11 Mar 2022 10:19:28 +0100
Date:   Fri, 11 Mar 2022 10:19:28 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial updates for 5.18-rc1
Message-ID: <YisUIF1uXOs5g/tw@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:

  Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.18-rc1

for you to fetch changes up to 4ac56b1f1ef8139dbfc5dab918aa235e8344ec4e:

  USB: serial: usb_wwan: remove redundant assignment to variable i (2022-03-08 18:51:02 +0100)

----------------------------------------------------------------
USB-serial updates for 5.18-rc1

Here are the USB-serial updates for 5.18-rc1, including:

 - a new "simple driver" for some Nokia phones
 - a fix for pl2303 GS type detection
 - another pl2303 device id

Included is also a clean up.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Colin Ian King (1):
      USB: serial: usb_wwan: remove redundant assignment to variable i

Eddie James (1):
      USB: serial: pl2303: add IBM device IDs

Johan Hovold (2):
      USB: serial: simple: add Nokia phone driver
      USB: serial: pl2303: fix GS type detection

 drivers/usb/serial/Kconfig             | 1 +
 drivers/usb/serial/pl2303.c            | 2 ++
 drivers/usb/serial/pl2303.h            | 3 +++
 drivers/usb/serial/usb-serial-simple.c | 7 +++++++
 drivers/usb/serial/usb_wwan.c          | 1 -
 5 files changed, 13 insertions(+), 1 deletion(-)
