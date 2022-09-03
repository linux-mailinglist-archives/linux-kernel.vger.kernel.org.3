Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99ADF5ABD78
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 08:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiICGej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 02:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiICGeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 02:34:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FA91C104
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 23:34:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F173B82E80
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 06:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665FAC433D6;
        Sat,  3 Sep 2022 06:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662186870;
        bh=qIryOSkgNbM7AVmMMg3eIYDfrnzRdTzTcuVH3brBIwE=;
        h=Date:From:To:Cc:Subject:From;
        b=vtcYWniZu4/0foGlk441ZFvBzjrrpCgUcQNqbvmT7BtVmd7iMXCRzz4r2MfLrmFSU
         /HCXR0szqNFRTFZtV4FrSvXwDbJO3D6vd3ziyvTY2wCZdDECNNECd4RGM6qMpqiDe6
         jee0+5J4Zzxiud3qpfBt5HTtM3P8yVYpZ9eeSj9I=
Date:   Sat, 3 Sep 2022 08:34:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver fixes for 6.0-rc4
Message-ID: <YxL1iR5/c+tl60ja@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.0-rc4

for you to fetch changes up to e230a4455ac3e9b112f0367d1b8e255e141afae0:

  staging: rtl8712: fix use after free bugs (2022-08-30 17:15:16 +0200)

----------------------------------------------------------------
Staging driver fixes for 6.0-rc4

Here are 3 small staging driver fixes for 6.0-rc4 that resolve some
reported problems and add some a device id:
  - new device id for r8188eu driver
  - use-after-free bugfixes for the rtl8712 driver
  - fix up firmware dependency problem for the r8188eu driver

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dan Carpenter (1):
      staging: rtl8712: fix use after free bugs

Grzegorz Szymaszek (1):
      staging: r8188eu: add firmware dependency

Larry Finger (1):
      staging: r8188eu: Add Rosewill USB-N150 Nano to device tables

 drivers/staging/r8188eu/os_dep/os_intfs.c |  1 +
 drivers/staging/r8188eu/os_dep/usb_intf.c |  1 +
 drivers/staging/rtl8712/rtl8712_cmd.c     | 36 -------------------------------
 3 files changed, 2 insertions(+), 36 deletions(-)
