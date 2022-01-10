Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A01F489F42
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241734AbiAJS2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241613AbiAJS2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:28:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FDEC06175A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:27:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7065AB81757
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31781C36AF2;
        Mon, 10 Jan 2022 18:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641839276;
        bh=KCo142eLc3+66RDQf4KOs8q+bHNTLLYY1FEOJtZ0N+Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RS2fiEfkAl5nEXHV+Z11DC3L6Cs+iO3h8ypWJ0WBCRUx9i8sWrhNOiqUky9g2EcL8
         J4Cgngr/LuZx7A2HTqHpgWp4qHPU7k/ZXdeKobSdxLcylk1Za9gf3VD46moDuZVE3s
         OIolcNnObVgRqQP92fAxrc2sDTSsx552+pCNF0EXtjqv0+gpqinV97OuCl5cpcLrrM
         HyRFZEV26Ct4aJcv3BBpMJwIzxwfTfYRAVYM2MSngesw6DKesGgx0c1TUzKL0KzYMD
         lj3O8CBl+8DKTO3NL+KxJykgVl1vkn4hO/r44s6iWMhHPzF84XlmpLV7TOk1wFhlLt
         w74+TiMcBdRoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FDACF6078C;
        Mon, 10 Jan 2022 18:27:56 +0000 (UTC)
Subject: Re: [GIT PULL] x86/platform for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdwJAzTiMSIaGjsC@zn.tnic>
References: <YdwJAzTiMSIaGjsC@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdwJAzTiMSIaGjsC@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_v5.17_rc1
X-PR-Tracked-Commit-Id: 9e4d52a00a0217857fa40dc998971a375f861a61
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd36722d74733b748ae812e37dcfe035b420de67
Message-Id: <164183927612.9673.9004126221262032599.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 18:27:56 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 11:22:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_v5.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd36722d74733b748ae812e37dcfe035b420de67

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
