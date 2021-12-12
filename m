Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F25B471C85
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 20:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhLLTRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 14:17:02 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43238 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhLLTQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 14:16:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 80DEDCE0D8B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 19:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEF92C341D2;
        Sun, 12 Dec 2021 19:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639336609;
        bh=sx8I+WPNjjXHelHq/lFsaxDcypKEsoDdh2AXadXOJO0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jek+BMil8uueKIIoseJGpuG1eX20k70npMLsbAENv+kzmV1E4XcpF/He4PZqZpCn0
         uNCbdNjK5eSMwGUOTUFFTbBAzX/i3CdkO0bvwJB4tHiIITE/0ddEMiZmWbZYwGJRkc
         zRYtNK2oPrSWe7hlko5NK6ZVb9Mv3AuAbOJCxd3GP0jKjRgcWl/oqkast1+ugpF7xi
         cYKAZmeeCQPcqOusXJPKc6Vxegy2fLntINBzLLW3baoJFHFyUfIiU6q6uT+IqdApGq
         KkR91XooooW0kvGTxjl7wiBvwDg4htfqUtxdIfJFeYcLlo6LMvn/Vr9qe1c6lH0qJd
         kBg0xleNzzi1Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8CFC160A3C;
        Sun, 12 Dec 2021 19:16:49 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.16-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YbYC6DvAa2m9Hg0i@kroah.com>
References: <YbYC6DvAa2m9Hg0i@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YbYC6DvAa2m9Hg0i@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.16-rc5
X-PR-Tracked-Commit-Id: cab2d3fd6866e089b5c50db09dece131f85bfebd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d7ed10410d53453305e4f8673c50085d607fa80
Message-Id: <163933660957.938.7579303131338348379.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Dec 2021 19:16:49 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Dec 2021 15:10:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.16-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d7ed10410d53453305e4f8673c50085d607fa80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
