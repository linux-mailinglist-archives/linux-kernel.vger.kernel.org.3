Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3320B54F29C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380812AbiFQIPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380002AbiFQIPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:15:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B251668321
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:15:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45B9A61ECB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53885C3411B;
        Fri, 17 Jun 2022 08:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655453736;
        bh=dUMiEbwFX3RN0LBwxHoVKxNIvOxIqcq0tzlOBtAruXQ=;
        h=Date:From:To:Cc:Subject:From;
        b=r8lhC75yIdIiisOdMupbIdV+SAUga7D+2/3T1ejsezxFbCt5iFYxfmTofuk6ChP7l
         jOP3LY+4jEEfPAcwn+u8azHMXPIPBqeAmAT6tUptvm0f4zSCI8I4bJnPA+mRCVS5C+
         GcVDS/z+nZWzYFsIzHipeoodBXaTvnHg2qG0hCR0=
Date:   Fri, 17 Jun 2022 10:15:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes 5.19-rc3
Message-ID: <Yqw4Jujzz5ZzZ2Wg@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.19-rc3

for you to fetch changes up to 0a35780c755ccec097d15c6b4ff8b246a89f1689:

  eeprom: at25: Split reads into chunks and cap write size (2022-06-10 16:42:48 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 5.19-rc3

Here are some small char/misc driver fixes for 5.19-rc3 that resolve
some reported issues.

They include:
	- mei driver fixes
	- comedi driver fix
	- rtsx build warning fix
	- fsl-mc-bus driver fix

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Brad Bishop (1):
      eeprom: at25: Split reads into chunks and cap write size

Miaoqian Lin (1):
      misc: atmel-ssc: Fix IRQ check in ssc_probe

Shreenidhi Shedi (1):
      char: lp: remove redundant initialization of err

 drivers/char/lp.c          |  2 +-
 drivers/misc/atmel-ssc.c   |  4 +-
 drivers/misc/eeprom/at25.c | 93 ++++++++++++++++++++++++++--------------------
 3 files changed, 56 insertions(+), 43 deletions(-)
