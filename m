Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF9B468C48
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 18:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhLERFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 12:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236137AbhLERFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 12:05:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD2FC061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 09:02:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26FC2B80EC9
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 17:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3B09C341CD;
        Sun,  5 Dec 2021 17:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638723724;
        bh=AtDrsB9yQpE71m/IiLMVvfDzWdNX294WF7+ozhWbnNA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=d0S+ZMNzu05o+7erMIuB9L7ZLcz/mNRAlGiizrjpFHqks9LMAsJ0oFY8XNizbD+Wt
         YVJeU98z0inmPyT5Q3NrphODVDdizpN/KDvZgnJ0XlMTSkybEQouORJ77kDFKg8Fsk
         UNmCI3+p11Wzu+Q9T+X0uijCMJvgRmlFpOMzJRQ+TExWpgGX+utYjBZQPWMf8rT7eL
         bypF1/UrjyBl2BXybU9OHGDVKAHk2P0V9makAnQ39cUFFel5dB/LFKMGkNdrYMbwFC
         1yfPyVk9QhIlJTJgfhajPM3H18dH1wiLICIkAf+9eiRNOKaOVlgErCW2qhoI6LJcPj
         2NlNWVhHzHMZA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CC3BC6008E;
        Sun,  5 Dec 2021 17:02:04 +0000 (UTC)
Subject: Re: [GIT PULL] timers/urgent for v5.16-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YaypnuP+OlCi41w7@zn.tnic>
References: <YaypnuP+OlCi41w7@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YaypnuP+OlCi41w7@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v5.16_rc4
X-PR-Tracked-Commit-Id: 53e87e3cdc155f20c3417b689df8d2ac88d79576
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7587a4a5a4f66293e13358285bcbc90cc9bddb31
Message-Id: <163872372483.18723.16275130331608781734.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Dec 2021 17:02:04 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 Dec 2021 12:59:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v5.16_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7587a4a5a4f66293e13358285bcbc90cc9bddb31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
