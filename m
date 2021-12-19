Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067AF47A215
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 21:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbhLSUee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 15:34:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44620 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236555AbhLSUea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 15:34:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71DCB60F03
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 20:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0E59C36AEB;
        Sun, 19 Dec 2021 20:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639946069;
        bh=Azb2PGcV1mCaWcM3vk72id+E7TweRUOd4/7ITm9fIuY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=URXgRW4A7Srks0ShLKigdj36H+03AGqutyG5El1lb6qNKaT2GTgL7xfT8CDA474/Q
         FcImaBW0AZao9HYplw9I9IQPs4DojGuWW5/3gk4zkzrz7oioBSzaXIJIZWKF8fhVTh
         XKCVKGLfaD/y99e11Rd+OBkThHGlaHhRAQVf+6oyhEvQt2GXYHlnQxtoPtHQs6QRy8
         Xqr+r8Mz421NduCajfQOAmujb7vCrzvaZkGwgoep4C9TYRuTPX/j/PFBaentTs2kpb
         gOHdMI0b1LxY7X1k7q1DdcdaFtYwklHuvuEKGIdhfMD41DmY8YziiDTcV0vz4vSGd6
         1ybAPrzJdn8PA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B6BDC60AA3;
        Sun, 19 Dec 2021 20:34:29 +0000 (UTC)
Subject: Re: [GIT PULL] timers/urgent for v5.16-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yb8542TP03zYwspz@zn.tnic>
References: <Yb8542TP03zYwspz@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yb8542TP03zYwspz@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v5.16_rc6
X-PR-Tracked-Commit-Id: 4e8c11b6b3f0b6a283e898344f154641eda94266
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1fe1b10e6aae5fb2df1c065e4fbe655c39e5065
Message-Id: <163994606974.11038.10774371356595065148.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Dec 2021 20:34:29 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Dec 2021 14:55:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v5.16_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1fe1b10e6aae5fb2df1c065e4fbe655c39e5065

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
