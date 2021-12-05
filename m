Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CEF468C46
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 18:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbhLERFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 12:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbhLERFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 12:05:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFABEC061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 09:02:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78397610A7
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 17:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D885DC341C5;
        Sun,  5 Dec 2021 17:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638723724;
        bh=OLzSqLDoWBYukltums3DE7xW4SOiBrbZET5O2ez8ny8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bc5tZlnyP2HTXOvuTnvDbN725GBJ04G/F+LoQFNVsx8+yKxhzS5XlPqjOgK0x7WiJ
         u5avNQfyuvF8pNlsDXnLhLtCskkFlQhlYSBgWK/5+TMrXXps7V0qY8P1dNvP8qS4yE
         8otWOYU0QecZtTQi3aZRbFTRsn+NqYYZ4dtzLV2ATWOAU5DpinSAnv+hc92v9HgwCe
         uO8rLAkS8Rcwzu8TIpTiHvgs/4WXu4lBjg1MF98uOU1AsOIF+GvGtnKFECgSQA1EOJ
         Qbznvrz23kJKLP3fQliU8VE0mvS0WQii918mxV66DzASizkdV3zcR1ElYbVJQwLdh1
         WtYwulKek7FNg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BEBAF609FF;
        Sun,  5 Dec 2021 17:02:04 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v5.16-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YaylsgmYwXBK6qXf@zn.tnic>
References: <YaylsgmYwXBK6qXf@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YaylsgmYwXBK6qXf@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.16_rc4
X-PR-Tracked-Commit-Id: 315c4f884800c45cb6bd8c90422fad554a8b9588
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d213767dc6f594022e43b6b59c45e7e3c84c4de
Message-Id: <163872372477.18723.17732629740102490303.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Dec 2021 17:02:04 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 Dec 2021 12:42:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.16_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d213767dc6f594022e43b6b59c45e7e3c84c4de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
