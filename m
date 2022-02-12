Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAD24B343C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 11:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiBLKbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 05:31:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiBLKbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 05:31:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD4426130
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 02:31:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B21B60B5A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFBFC340E7;
        Sat, 12 Feb 2022 10:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644661892;
        bh=W8C3px4Ho/2tSKsRI2O5MxXfZutbE8YDsLfIVKb3P3o=;
        h=Date:From:To:Cc:Subject:From;
        b=XGZQqpetQWZMdaGqP4pK+wxUO8dWF2JLo8nckcwv9wk4t4v5OAhChvTyD7A9uT5V/
         e4buUoAns3sbx6a0hMHoz0Yvrf8GbYhKkHONJiquxTbk8+RUG6NMHnl5h4jRiNfRu+
         1mo+Ize34gv4svOCwRw/FCmDHwpS6sWNnSLutskg=
Date:   Sat, 12 Feb 2022 11:31:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver changes for 5.17-rc4
Message-ID: <YgeMgTqMg82ZC7hA@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.17-rc4

for you to fetch changes up to 426aca16e903b387a0b0001d62207a745c67cfd3:

  staging: fbtft: Fix error path in fbtft_driver_module_init() (2022-01-25 16:36:49 +0100)

----------------------------------------------------------------
Staging driver fixes for 5.17-rc4

Here are 2 staging driver fixes for 5.17-rc4.  These are:
	- fbtft error path fix
	- vc04_services rcu dereference fix

Both of these have been in linux-next for a while with no reported
issues

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Padmanabha Srinivasaiah (1):
      staging: vc04_services: Fix RCU dereference check

Uwe Kleine-König (1):
      staging: fbtft: Fix error path in fbtft_driver_module_init()

 drivers/staging/fbtft/fbtft.h                        |  5 ++++-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c    | 20 ++++++++++++++++++--
 2 files changed, 22 insertions(+), 3 deletions(-)
