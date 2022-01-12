Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3374748CC27
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357468AbiALTk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:40:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33988 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357380AbiALTkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:40:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 752AFB820DF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 19:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45020C36AEC;
        Wed, 12 Jan 2022 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642016406;
        bh=6PpuJzxX6ocSg9vNv7VN3S0KS23WcI9NaETzJ/y1BqM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=d24pzYp0vGfFzEENMl6cnDzngu67vlqwijRhfDWXHAoFJvSUUJyKdxlKI6NPbS7v6
         caUs6UUqvwNZ3xxpn2p6yBwPHg3az+iq81S1zFS3xO2fJDEFQzcDnLjmajU2iTSvpY
         4S8EnjekJIs68og5e02xBccrZIOxwpCf+F/qgR/ahKSc76/VlnTHn/kSwqYwBCzIxj
         hPdNb5+Q+2YUWbIXE4J44sZMzN0jM6HxQPtbIBYzx3UWxPsFmc4G8Z62xFMeiN4TOg
         MZcStbmAcmdASxy+wRT4uEkgWeHvyHVziaeoY2EVdsa0bOFsXRSuny9JQTS5DCiGw9
         xwu4Bsa0mUifA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32BA9F6078C;
        Wed, 12 Jan 2022 19:40:06 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver changes for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yd7d6/W1fYi0QGSF@kroah.com>
References: <Yd7d6/W1fYi0QGSF@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yd7d6/W1fYi0QGSF@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.17-rc1
X-PR-Tracked-Commit-Id: fa783154524a71ab74e293cd8251155e5971952b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22ef12195e13c5ec58320dbf99ef85059a2c0820
Message-Id: <164201640619.24328.2464065391407963815.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 19:40:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Jan 2022 14:55:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22ef12195e13c5ec58320dbf99ef85059a2c0820

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
