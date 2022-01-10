Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FB7489F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241741AbiAJS2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:28:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43716 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241585AbiAJS17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:27:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26C1AB81747
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF43DC36AF4;
        Mon, 10 Jan 2022 18:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641839276;
        bh=NnA1jGL26olsar5B+3+jzIQYwzzQU76YhCtdd+PgmUk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r6CU0txRinGz+5EoQJ4khx5rtsYNvJvv59QWU6lVIHdIQ3lm0+uA6X1LYRkZJRCXI
         PkTkPPBxs75/OPz4DJ0n0KJzQRyvupk5o1m+JoZ66n/FRunZKvTG6DckAojqnPvOcW
         woQgcav2BzyZgDdI1cdv892FuyWddR+DBEGOG5i5wnn8PuFeiXDXdefJOGRGX8c7zw
         K6egLD6XWvb8Z2GdEutgMOwwG+zBvDAWzbS5yOrnb8jFdaghTs/0WQGphpZEUNG/jM
         a/UegevBgTHxS5QAv06mg0IXE+EX15pdxK/QEwK9X7HlMIscrMQ8gCgC5qwtHlO6AK
         ZSNo5A3BtVAxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE2B7F6078B;
        Mon, 10 Jan 2022 18:27:55 +0000 (UTC)
Subject: Re: [GIT PULL] x86/fpu for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdwC58lduSOILPmq@zn.tnic>
References: <YdwC58lduSOILPmq@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdwC58lduSOILPmq@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fpu_for_v5.17_rc1
X-PR-Tracked-Commit-Id: 0fe4ff885f8a50082d9dc241b657472894caba16
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 191cf7fab9ef5f5d4a2b2ad0094ef76ba18a7439
Message-Id: <164183927590.9673.4621878165731622011.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 18:27:55 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 10:56:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fpu_for_v5.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/191cf7fab9ef5f5d4a2b2ad0094ef76ba18a7439

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
