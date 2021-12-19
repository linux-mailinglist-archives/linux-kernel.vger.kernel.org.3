Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6CD47A218
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 21:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236601AbhLSUeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 15:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236564AbhLSUed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 15:34:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA07BC06173E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 12:34:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 666D0B80DA4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 20:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B58CBC36AEA;
        Sun, 19 Dec 2021 20:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639946069;
        bh=5YjXlQjYO7hvmSqG2eAE7dCg5gsqvB9Ev79wqZeI4E8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gL3pLrVzajx5lXD9oE9GP84usyOQY6+NhYpRUXfEVkfglWmf2cuewjHKCppTG2fzI
         eImrbS1gTibcYSk4NlQ4DHSD+o+ibv6hijOnSVcqPVEqlhb8PI6t6ZIjdO6Ljgpklp
         kYz5jHCB3GWS6p0feWMOkwGyQmQjN9Qctlt+qowkQpDMbEhkRvs67nlp5b9zzpnXOB
         +UG4BILZ/Qee97OhNXZ2idzzaFLevpx1C2l9wDvYEukX3h0YFGmE2FFKOvaxI2dnhL
         XzDhsQt3C+AQh5TO0AqgMcenz+ZlRegnkqcVcsMKJ1hq4TyJ/Eq7xpEUsDhPc3p8E/
         4ISlb16rRLjhA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9F2F860A27;
        Sun, 19 Dec 2021 20:34:29 +0000 (UTC)
Subject: Re: [GIT PULL] locking/urgent for v5.16-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yb83oF7xlfqqblGt@zn.tnic>
References: <Yb83oF7xlfqqblGt@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yb83oF7xlfqqblGt@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.16_rc6
X-PR-Tracked-Commit-Id: 8f556a326c93213927e683fc32bbf5be1b62540a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 909e1d166ca807e52ffba57a1a63cef0cf517338
Message-Id: <163994606964.11038.11063361303331398916.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Dec 2021 20:34:29 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Dec 2021 14:46:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.16_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/909e1d166ca807e52ffba57a1a63cef0cf517338

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
