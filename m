Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3FE471C84
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 20:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhLLTRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 14:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhLLTQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 14:16:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A7CC061714;
        Sun, 12 Dec 2021 11:16:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D22B7B80D77;
        Sun, 12 Dec 2021 19:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE8C5C341D1;
        Sun, 12 Dec 2021 19:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639336609;
        bh=0TKxMv5PJHHl3i26zutQq4DJRgmokU+3MXbGBuoAgp4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LbL1EPGgl+F0W67B0tI4rLEosPf77vWhYZjfbP4wLBKFuAn+up2dECmLfxilBSCCm
         X34fGR/wMYV/HCebnEMhH2/ELrW0Bz1+5m0SGV7fIme+jfcPcyZUxJkOQUYGUmElE6
         pFwhc6XO7LTNge4nCnNWLzJwkc0eYQmFTU33nP/2pBu/T8rqX4g6R3LOIQZ22IW6xH
         u7r1+S3qvJSXoJ9wkcOJNtKQtF4YbO1aYCAEJGrlpeg4+l7rbtngpt04rxO59g8yle
         k67PSq15u8EreRNOZ4fWm/MXavt4bviozq1CaKE6YN6cEvwq+uqObG8+69+TxZOPbL
         hCXYmFkNj5Tlw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9CEA160AA5;
        Sun, 12 Dec 2021 19:16:49 +0000 (UTC)
Subject: Re: [GIT PULL] USB fixes for 5.16-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YbYDDrBFYegNGQ7m@kroah.com>
References: <YbYDDrBFYegNGQ7m@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YbYDDrBFYegNGQ7m@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.16-rc5
X-PR-Tracked-Commit-Id: ca5737396927afd4d57b133fd2874bbcf3421cdb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90d9fbc16b691403a80a119d7094528721c03279
Message-Id: <163933660963.938.14152376833669228778.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Dec 2021 19:16:49 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Dec 2021 15:11:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.16-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90d9fbc16b691403a80a119d7094528721c03279

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
