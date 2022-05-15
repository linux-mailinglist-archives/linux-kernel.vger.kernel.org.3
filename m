Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA9652785E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 17:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbiEOPLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 11:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237394AbiEOPLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 11:11:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60D2D10E;
        Sun, 15 May 2022 08:11:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDC25B80D1F;
        Sun, 15 May 2022 15:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D092C385B8;
        Sun, 15 May 2022 15:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652627460;
        bh=GtWmqi6Upufs82YfoP7HEO9Kwl++yQfUHG1Tk8cbhnU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TyqqQmEoXtdLsIbAT+GAwJyoGE0h7Nt+3z90cO7S5v7LXaM8s+XvolkpBejZYBejs
         7CKCEPfDiULVhFJA2BcX31fC3bF5xMPD9SbGuGJUIaI2I5U+Go7f8tvLeUgGu2gibd
         T+rhtdz7c57Pm+1C5xIaBh9yInhs0Wqx+GtXbUBeKqgT8yvwq72ps2SCaGxe2oxCo2
         AnBUdwkrWPdR+N6m9giG515A20F5i5wj34XFO4+XsbzqMzodbBDb0eHj22pCjl4Pdz
         IoKPKWLLKXF1So9vUtFayQoRKpVa77XjYlQB4MzQx3To82SkMB0wqeiWKfNp6yW742
         GSH6+Vb85hH5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78CBEE8DD69;
        Sun, 15 May 2022 15:11:00 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 5.18-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YoENuIsPvWwfh3F7@kroah.com>
References: <YoENuIsPvWwfh3F7@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YoENuIsPvWwfh3F7@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.18-rc7
X-PR-Tracked-Commit-Id: 757b9f6e6a2070043e5f215ff4afe350ecfb2bf7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc49583cdb2c8d5dc7dc626b80c8852478cb3383
Message-Id: <165262746048.2129.1449706902942438369.pr-tracker-bot@kernel.org>
Date:   Sun, 15 May 2022 15:11:00 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 May 2022 16:27:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.18-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc49583cdb2c8d5dc7dc626b80c8852478cb3383

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
