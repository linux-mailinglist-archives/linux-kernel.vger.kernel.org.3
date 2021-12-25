Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6350947F47C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 22:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhLYVKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 16:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbhLYVKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 16:10:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C0AC061401;
        Sat, 25 Dec 2021 13:10:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 075C9B80D88;
        Sat, 25 Dec 2021 21:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC406C36AE9;
        Sat, 25 Dec 2021 21:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640466614;
        bh=ZmWjQMGGQocLzqM876tKGHWSeRHHb5x8dDwtlhPKg/k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=P04GJxOobVh/UrC/MdigcAAOuea+DnI2kr5SNfV5laC86QTfhYgu0Y6POphc2rtdP
         YdZz9pHyQtrwPbyswedgedqLg5lPOzPOZ4KStZfSst+3XbNLqM5qibdnJqiB8w/mvY
         7c+RT/QI8RzIXtw7Hvw1AB/KF9Y8+ggqK8MTWAW5R8Tjigq7rb0JvzZW0T+8/HM9Ek
         JTO/eUJbNqf/Mx1q8h27YdZOZfnyfjOwxfeCyWWv7Ouze8Nsss8AYtfiMhliE7Y/Dy
         w+m38E8zMcMzFf5vfCKkYIp88GVVOcX7bBjJDyoJrLPvleEy1zz9zBTiEmL9wivd6B
         ADq1KDPG3u4zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7C2AEAC06B;
        Sat, 25 Dec 2021 21:10:14 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v5.16-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211225160724.3120253-1-linux@roeck-us.net>
References: <20211225160724.3120253-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211225160724.3120253-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.16-rc7
X-PR-Tracked-Commit-Id: cdc5287acad9ede121924a9c9313544b80d15842
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2ae0d4a6b0ba461542f0fd0ba0b828658013e9f
Message-Id: <164046661474.5738.3881297464456118828.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Dec 2021 21:10:14 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Dec 2021 08:07:24 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.16-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2ae0d4a6b0ba461542f0fd0ba0b828658013e9f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
