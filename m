Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF744C2C24
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbiBXMv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbiBXMvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:51:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274C11E2FEB;
        Thu, 24 Feb 2022 04:50:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3921618EE;
        Thu, 24 Feb 2022 12:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5FDC340E9;
        Thu, 24 Feb 2022 12:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645707055;
        bh=n605HSG0r5c7g9hGxY1ahwhO3mqEmcQZ6Pb773ajwMw=;
        h=Date:From:To:Cc:Subject:From;
        b=TVj4QacrP8aj4pBDB470ure0lkHkT0v80y3x1Xks0wZnoJO//dYSWju3fXKFw8b26
         YhSYPBVj4mY9F7vEDiUQ9Eq5DRo7sPu7v+R/ak1NMn7eGAcBUzu8v7xEfWwiBZQke1
         HsZVpNsIv4q2hpUnPHTDFYf+woZzJFEQQjXFeLOMA6kkC7g7EsSdlCwwqISBPI4j7J
         KxFslM+1MxkJQdaTIpoWHiSdJEhMV0R8UNBmWwl/IVUzbg74YZNrrx8KW/vt7xSQq8
         57jiclX+Qu6TdJSTVkwHZUW2ycfTtOizAuw4HiEc1eu3CgotWSXom5f1NPt7JYkJ1f
         lNHA250EGsX1w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nNDaB-0007zw-8X; Thu, 24 Feb 2022 13:50:55 +0100
Date:   Thu, 24 Feb 2022 13:50:55 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 5.17-rc6
Message-ID: <Yhd/L2uKGvBbuQUS@hovoldconsulting.com>
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

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.17-rc6

for you to fetch changes up to cfc4442c642d568014474b6718ccf65dc7ca6099:

  USB: serial: option: add Telit LE910R1 compositions (2022-02-21 10:20:26 +0100)

----------------------------------------------------------------
USB-serial fixes for 5.17-rc6

Here's a revert of a commit which erroneously added a device id used for
the EPP/MEM mode of ch341 devices.

Included are also some new modem device ids.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Daniele Palmas (1):
      USB: serial: option: add Telit LE910R1 compositions

Dmytro Bagrii (1):
      Revert "USB: serial: ch341: add new Product ID for CH341A"

Slark Xiao (1):
      USB: serial: option: add support for DW5829e

 drivers/usb/serial/ch341.c  |  1 -
 drivers/usb/serial/option.c | 12 ++++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)
