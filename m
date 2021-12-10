Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DEC470B37
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243771AbhLJUC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:02:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56714 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbhLJUCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:02:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3126B8298F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 19:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8142FC341C7;
        Fri, 10 Dec 2021 19:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639166326;
        bh=Uh3s5LlypjVF/2Sv5gozpLVvOgxFs3qkOf1Mxad+KUY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R2G/iIqPfcpjYtWa9BySteUjrXJXPBR+Ls4iXGRuIincapNsH+7rrDxMrLBJ1o6Km
         IGLM6GKhmosFB8TigQhqOlzBooTVKH5kTdL+pCYO4CjejoGaZO5EAPV3fuI8u0Nw33
         C3drgHHVbC7/f4jjRykjxuFDewjy44W7xIx8bUJWhoWPeFoL0HIQS5isGSxDBnNuLf
         lpjVj3MxSoK3TnLJhO2GCvMWEqHih5j6C9NkBWepOUDBQRl18/8zLcxIF11ujmjcVI
         6Xl/ktQPC/aX9j0yQpqaZzmRrCTF0wj5dtt01xfcBhZgA56VY63/GQBdLkJX0NkxBK
         QrhxwVUtJLSaQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6FDAD609EB;
        Fri, 10 Dec 2021 19:58:46 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.16-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hzgp8hlv5.wl-tiwai@suse.de>
References: <s5hzgp8hlv5.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hzgp8hlv5.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.16-rc5
X-PR-Tracked-Commit-Id: d7f32791a9fcf0dae8b073cdea9b79e29098c5f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b46fb03839712772107eae2b817bbf860b58ac7
Message-Id: <163916632645.27955.13541834193044815756.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Dec 2021 19:58:46 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Dec 2021 10:04:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.16-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b46fb03839712772107eae2b817bbf860b58ac7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
