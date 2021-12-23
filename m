Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C4047E788
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 19:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349790AbhLWSNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 13:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349756AbhLWSNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:13:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6297C061756;
        Thu, 23 Dec 2021 10:13:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 635AAB818A0;
        Thu, 23 Dec 2021 18:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32B97C36AEB;
        Thu, 23 Dec 2021 18:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640283193;
        bh=XGFOxNKl6UzVkCrzAi0UNTUcSKaRFSjfM3FEMD196CE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KMlXsMfWTaSX76K9YV5kFT/2Htm4IqdAhFi/Tq02x2qcT3bVSr6jErL/fKkxuxx+R
         2Knjpjzv5TrknlXbbfh10NGGcunMkVzD25mJhb7txvs3/9itlVd3FAefelTnMeRxAi
         wK0WU/PlH3AkjUhVpfwOtmbZuSrO6YUFGwOqcrnh43nK4JrhG0vLCaPWsDzZX3J9Fh
         9ShgWWuQ936PBON/XGUpojnsPP7sN7SVcRaGsRZtDVBC58vLJBqZtBn1sk3eW28BJ1
         E5PfQad1ekTDa+zZwayrm7hLxVM1kLdSAIFHB8cUpE+ojyfleknXjDXPcaBciq7A+T
         uxBGUhwDxbpkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22AC8EAC065;
        Thu, 23 Dec 2021 18:13:13 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v5.16-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211223162209.26870-1-brgl@bgdev.pl>
References: <20211223162209.26870-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211223162209.26870-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.16-rc7
X-PR-Tracked-Commit-Id: 3e4d9a485029aa9e172dab5420abe775fd86f8e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3bf6f013980a9cf255c52135b74339a8fc332dfc
Message-Id: <164028319313.29771.7185709258971409438.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Dec 2021 18:13:13 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Dec 2021 17:22:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.16-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3bf6f013980a9cf255c52135b74339a8fc332dfc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
