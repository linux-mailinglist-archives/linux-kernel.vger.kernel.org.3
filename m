Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DD248CC23
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357379AbiALTkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:40:31 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50432 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357365AbiALTj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:39:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AFF061AC4;
        Wed, 12 Jan 2022 19:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 831ECC36AE5;
        Wed, 12 Jan 2022 19:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642016396;
        bh=3XcXVesVtHywbKZSclcouPbb+f9R0+PMPQjUND7Ts28=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uZqdxLwOesfCgJzlQbDhbte8iRESh6WXA/s4mb3LYwCqUzdu3UxCyHf0EgiE3OwJ1
         +z6D/TOi+pEKGgEi5YBcIHfaDeBjz1mGEpMHRywZzLbWslDALtTCToLv11QBE0Pipb
         u+4UONFUjZH33ZIFuxeUX/ZH+3kcVuh+iPSpu75MEy4xFlbNaAW9EwLMbWNBwz1Qk3
         RCM/BUzayU+0q7+NROnDgu032cJ7SMLI/PJgKLygZP6XH8F7iqE4PHJPH30ihyy1rz
         /VUUPIDdgSO9XN112ZZh/0XJfKYvlxguX9zqkTqmmUQDCMLnb89XH1kFlcYzyea8no
         EK5N4XkS1UpvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72082F60796;
        Wed, 12 Jan 2022 19:39:56 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver changes for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yd7d/lD76eYkCjul@kroah.com>
References: <Yd7d/lD76eYkCjul@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yd7d/lD76eYkCjul@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.17-rc1
X-PR-Tracked-Commit-Id: 93a770b7e16772530196674ffc79bb13fa927dc6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 342465f5337f7bd5b8bd3b6f939ac12b620cbb43
Message-Id: <164201639645.24079.13394988719289621155.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 19:39:56 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Jan 2022 14:56:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/342465f5337f7bd5b8bd3b6f939ac12b620cbb43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
