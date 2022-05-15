Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6384F527813
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 16:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbiEOO2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 10:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237385AbiEOO1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 10:27:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E555D2AC49
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 07:27:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EB72B80D0E
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 14:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3449C385B8;
        Sun, 15 May 2022 14:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652624866;
        bh=t804RpIYnWcjF/lfKACrQrSZIkb6NHAI4OQAWijCIT8=;
        h=Date:From:To:Cc:Subject:From;
        b=Lw1DeR+sRxp9P6gqvf4SngAnPoXpJ70u2pb+vqkKPfNqk9uWOozqwLlWmLjJBpqff
         8+emS158IoD/6vpekj12JrTe4HN2L8n0dXwo1Y5MMx3ya2u3xWghvaUVO0R5e5tc3w
         ph5jeqBwzvuByK3mxzuM9/XMyz4vK0SX1SkvNjmQ=
Date:   Sun, 15 May 2022 16:27:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fixes for 5.18-rc7
Message-ID: <YoEN35dp8yUoKcDA@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:

  Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.18-rc7

for you to fetch changes up to 575f00edea0a7117e6a4337800ebf62e2a1d09d6:

  Documentation/process: Update ARM contact for embargoed hardware issues (2022-05-10 19:10:16 +0200)

----------------------------------------------------------------
Driver core fixes for 5.18-rc7

Here is one fix, and 3 documentation updates for 5.18-rc7.

The fix is for the firmware loader which resolves a long-reported
problem where the credentials of the firmware loader could be set to a
userspace process without enough permissions to actually load the
firmware image.  Many Android vendors have been reporting this for quite
some time.

The documentation updates are for the embargoed-hardware-issues.rst file
to add a new entry, change an existing one, and sort the list to make
changes easier in the future.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Catalin Marinas (1):
      Documentation/process: Update ARM contact for embargoed hardware issues

Darren Hart (2):
      Documentation/process: Make groups alphabetical and use tabs consistently
      Documentation/process: Add embargoed HW contact for Ampere Computing

Thiébaud Weksteen (1):
      firmware_loader: use kernel credentials when reading firmware

 Documentation/process/embargoed-hardware-issues.rst |  7 ++++---
 drivers/base/firmware_loader/main.c                 | 17 +++++++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)
