Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40510489F41
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241713AbiAJS2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241611AbiAJS2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:28:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BCEC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:27:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C51E6B8175A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EFB3C36AF9;
        Mon, 10 Jan 2022 18:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641839276;
        bh=EqGsZewAcUV+7kO/g2/qTnDO0qm6+d8jeh7IK6rQHig=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E1/p10jkpKF6X5WBimZp1eKybXjOa4DkpQ3TvhCpF/XhUZnybBYCaRqQJeWSWpEJx
         03p7Jq0PpfSC4SKwMHFq0B76/vU6KQu638OXa5ePBS/n6cAY4p/GD7BxgSza+UhLub
         gu4zqjM6Hc+93S8nZLbpQ3Zs6vP1ZRI9B4waWLKQSU0IlAZf8VslHnFz1sFlRKDjkY
         PD+21JXE1zEVqeKwEhyUFIx1PJL7bN2alLdqRF5YhcQiW9PjZxzsNN5exPrhasUu7n
         /tRNFMyQuuVrvjY4dcRANMHR6n1c4kTARzm/bFqeHaCkgRrdactmNdbvBZ9puTRgz6
         FKhvQQqvCu/3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 694DCF6078F;
        Mon, 10 Jan 2022 18:27:56 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cache for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdwMGuBeYMVjL4rB@zn.tnic>
References: <YdwMGuBeYMVjL4rB@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdwMGuBeYMVjL4rB@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v5.17_rc1
X-PR-Tracked-Commit-Id: df0114f1f8711dbf481324c44cf5a8349130b913
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3c20bfb74935e31e47fe979a9d3d74c6d9c9040
Message-Id: <164183927641.9673.3834820372248838865.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 18:27:56 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 11:36:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v5.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3c20bfb74935e31e47fe979a9d3d74c6d9c9040

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
