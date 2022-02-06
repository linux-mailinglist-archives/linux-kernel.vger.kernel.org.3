Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E8C4AB151
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 19:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346987AbiBFSix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 13:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346633AbiBFSij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 13:38:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B96FC043184
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 10:38:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FE3BB80CF1
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 18:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BC56C340F3;
        Sun,  6 Feb 2022 18:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644172717;
        bh=nAzasQy+yFdt+Rb++93ZRQwGigW3bx8w2GJQbE6pIi0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KQehkQjD0NvjQhqORcpypUVp4EC2Vj38Dzt6FvCFpEVpDmyzYmlB+iHIwcQeRHYwt
         octCY2ADldiiaXw46HuQ0VACQkIKXx41L9dDpXNkzw4hgjXxZ4oG0pvE6jJW+Xstqy
         UL6jk0hdyhfl2phumPBwoLThxwx4Bo6yb8fNxXoOSgRE6omruunsOgXYr9ou6bW29U
         Jzk0RHvVcCy0OeGr9qEt3SmTEvcjIlqG3kagPPHJGFKE58mPDN5b6oWegqlM53ImqG
         n5eZDQL1Cncu9cUGtIy9jdDM5sxs3agI72fKpABuHljKsHafq4isbi8UCjEVeq7s/d
         stPOAQuhvHnQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37330E6D44F;
        Sun,  6 Feb 2022 18:38:37 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v5.17-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yf+/XCkzFQ5s3IHN@zn.tnic>
References: <Yf+/XCkzFQ5s3IHN@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yf+/XCkzFQ5s3IHN@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.17_rc3
X-PR-Tracked-Commit-Id: 1d9093457b243061a9bba23543c38726e864a643
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3bf8a14408ad2b84fe48246fa66d1459480ee6b
Message-Id: <164417271722.9246.12921460693731547096.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Feb 2022 18:38:37 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 6 Feb 2022 13:30:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.17_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3bf8a14408ad2b84fe48246fa66d1459480ee6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
