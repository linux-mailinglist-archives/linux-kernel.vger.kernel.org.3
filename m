Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0162548EBCC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241897AbiANOjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241883AbiANOjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:39:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60AEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 06:39:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4202461E50
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 14:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3018C36AEA;
        Fri, 14 Jan 2022 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642171159;
        bh=4C38YhUgb/KZQ/qjGcuGXVtS6g87CnQILQHxKeBF1uo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NJ9X8WgDTvkR8cvC/u8G6EHugo8xT5eLhnOS3vxSM9194pibXiK2XPMZbDY79Xul3
         5CMXVD4oFbZO4lkkauW1HwWOpDXW7Yuu+trOnLBiKNU8S2YPmqwtMp4SoRSL6Zo2kV
         TMPWpUqG938GC3KEW8uUseVaZsEtOSEKkfLyQJ1bVpxvC7nk/tT2fG7flo0ZT+RyQ4
         B9zK7kNaJfxWHUkC4uTevy+9WER8x2tdfciY5HZI415N8ggdecqk46NbUZbEfNZ2tu
         rfdm8mNUro2tU/uUaC+iy4gs1Yj+9OHp5+IRftMYoKuRIkeb809c1TLOqjWP+by5lB
         MT0ikNFIgMboQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 924E7F60797;
        Fri, 14 Jan 2022 14:39:19 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hwnj24p6x.wl-tiwai@suse.de>
References: <s5hwnj24p6x.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hwnj24p6x.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.17-rc1
X-PR-Tracked-Commit-Id: 081c73701ef0c2a4f6a127da824a641ae6505fbe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ceff4ea07410763d5d4cccd60349bf7691e7e61
Message-Id: <164217115959.3976.7859271880368210587.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Jan 2022 14:39:19 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Jan 2022 10:55:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ceff4ea07410763d5d4cccd60349bf7691e7e61

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
