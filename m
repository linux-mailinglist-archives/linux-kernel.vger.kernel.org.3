Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B075747A214
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 21:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbhLSUec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 15:34:32 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44622 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbhLSUea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 15:34:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A5A360F05
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 20:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E275AC36AEC;
        Sun, 19 Dec 2021 20:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639946069;
        bh=zExZfyWy+kGh935UyKUdXArIbsosbi644XOF6CcQX3I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LtCB0WYfCl/BEqKJRJBRKMupb7DCHYcphGdeIm4iFZgzWzg77x8lnDWTnwfm0JUcS
         5zr5vokijd5xdh7ZTfurFFevihFz9tuoP0FvBYuLogBkEBPAGqRqI/1ME72XTiDZw+
         b19amSirN4SOb1hOOGEHGftQu+lOtjtD5nM4r7vxOAZanm0nED1qN3S5t0mL8TQzFb
         UBpHbeKMRupG13Q5eZ6Nf9GPhZNrHDkiffFvCMWNvwBuFkdJzq8u8YHz1qmXtya8T6
         zLdFuQuypHjn4Fqu1XOObEHZMEHrMdUsXucIkVja60njX9wrTjTLbAVOXmoUlPcbp8
         Oy/CsNO42AhFA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D0E3B60A27;
        Sun, 19 Dec 2021 20:34:29 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v5.16-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yb88yFbu5LkRigfz@zn.tnic>
References: <Yb88yFbu5LkRigfz@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yb88yFbu5LkRigfz@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.16_rc6
X-PR-Tracked-Commit-Id: 94185adbfad56815c2c8401e16d81bdb74a79201
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a76c3d035872bf390d2fd92d8e5badc5ee28b17d
Message-Id: <163994606985.11038.16303109465265467862.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Dec 2021 20:34:29 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Dec 2021 15:08:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.16_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a76c3d035872bf390d2fd92d8e5badc5ee28b17d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
