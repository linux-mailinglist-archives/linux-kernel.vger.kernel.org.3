Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6581148A06B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244710AbiAJTsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:48:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49508 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244707AbiAJTsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:48:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 330C161194
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 19:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99CC4C36AEF;
        Mon, 10 Jan 2022 19:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641844110;
        bh=z7rgd1aqycZi24R0mpxEN3dC2UL9tecn6S5/4pPzIuk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H7S2miECL8hdHwNgPEL0Hnen9n5dZGnqwReg10WNijgZuumxOPd6lIhK/WtN02dkT
         JW2l1Bx68ohpVj2SVNKeFCAewOoobNGDGC0hbvPO03MC6hw0oCBGuD4drE9q+cmheg
         qdn0FJZIBZ4W19QzvKR1U0CACZwTngwGbqOXUp3m2WM7b1mBWW8Ux87oOA2fSP3fq2
         tmHrohZXeCsmwxQpOk5W9eDOb8lO6otQP6xNQZD0ys3DxQJ0Y1CB8dSzZ03ZRllP8R
         J9h0SNmHmnJFVV+h+4VFAsdf+RZ2lfxgGk/IQfhmyFt0zKHFKkAm78AAWSXgOASgxL
         5NVD/mVVQ3hxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87B66F6078D;
        Mon, 10 Jan 2022 19:48:30 +0000 (UTC)
Subject: Re: [GIT PULL] core/core for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdwUehYpPIp/0Zdd@zn.tnic>
References: <YdwUehYpPIp/0Zdd@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdwUehYpPIp/0Zdd@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/core_core_for_v5.17_rc1
X-PR-Tracked-Commit-Id: 5abb065dca7301de90b7c44bbcdc378e49e4d362
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ba13c1c4d848870ed4d25e411ac567c473686f0
Message-Id: <164184411055.23269.10920503238020596458.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 19:48:30 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 12:11:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/core_core_for_v5.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ba13c1c4d848870ed4d25e411ac567c473686f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
