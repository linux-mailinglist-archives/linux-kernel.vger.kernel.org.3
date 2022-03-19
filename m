Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2CA4DE70F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 09:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241144AbiCSI26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 04:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbiCSI2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 04:28:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF3227CE28
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 01:27:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B01BB802C6
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 08:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309A4C340EC;
        Sat, 19 Mar 2022 08:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647678452;
        bh=ncW5rIe2wfuu/QW6kWbkl1mdxF4J4+6kUx7s//WVA3Y=;
        h=Date:From:To:Cc:Subject:From;
        b=hoblJkGdPnyhjIZA+NJ2+deiO+hZB9VWjgp+KRyvL4AfvclURn3U7OOtyzJA126iW
         dvHbAEvLf1CoFedzjQ0qgODKidDzDpJ1HjefMltXbW39wcAqtYYTcV1rKLnXV4wAO+
         zr1SGu/httyZFFq5qcRmy7tVZtbRhLnDLg9ICPsI=
Date:   Sat, 19 Mar 2022 09:27:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fix for 5.17-final
Message-ID: <YjWT8WkVKO9ykfey@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.17-final

for you to fetch changes up to 01b44ef2bf6bc83df8a4703029fd611fbfc31c60:

  counter: Stop using dev_get_drvdata() to get the counter device (2022-03-15 19:24:13 +0100)

----------------------------------------------------------------
Char/Misc driver fix for 5.17-final

Here is a single driver fix for 5.17-final that has been submitted many
times but I somehow missed it in my patch queue:
	- fix for counter sysfs code for reported problem.

This has been in linux-next all week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Uwe Kleine-König (1):
      counter: Stop using dev_get_drvdata() to get the counter device

 drivers/counter/counter-sysfs.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)
