Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABABD4A367F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 14:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354887AbiA3NbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 08:31:00 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43248 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354875AbiA3Na4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 08:30:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3976ECE0EE7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 13:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86853C340E4;
        Sun, 30 Jan 2022 13:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643549453;
        bh=ZE/+tIvEmMywsq8ePa6ZyFjdO4+Bw4U0Gctk+DUuySk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ekDC7a9+aBflcdKiqK4bu4yqQgjFfEi3Vo+oP3T0Al/oM5zRzAchAGpJgV0Zyl38t
         uEOdxSMxA8+qK2r/cuaGyk0gVjnatbQazwG98pe+4DSQfFTRtol4pJCpT0d9AQlb+J
         MACepb1HDSL1q+zgtoscxrzppua1k4QKkXc5Bt2wVsKBvv9zw4tUYGCcmouceqKx0r
         0VY6vAaOqM3CcQndjoO1M7uIjeKC7uevsh823iTr8D55rUKd8g+hNHe29/pt5fYItV
         p53b3fg0aief/TSTNONzfLLMk7vNYMKYnQ1lWefOgN6Iq0di5a59I5s72stiNN4z2w
         lugg0nP1wEtiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 744C5C395DE;
        Sun, 30 Jan 2022 13:30:53 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YfZzaI5/7OCaFBoh@zn.tnic>
References: <YfZzaI5/7OCaFBoh@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YfZzaI5/7OCaFBoh@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.17_rc2_p2
X-PR-Tracked-Commit-Id: c5de60cd622a2607c043ba65e25a6e9998a369f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27a96c4feb837093f6075bbd97c942260d26ef33
Message-Id: <164354945346.24404.10228993808871526637.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Jan 2022 13:30:53 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Jan 2022 12:15:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.17_rc2_p2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27a96c4feb837093f6075bbd97c942260d26ef33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
