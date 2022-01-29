Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB5E4A2FEB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 14:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351543AbiA2Nyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 08:54:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38628 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351298AbiA2Nyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 08:54:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83275609AE;
        Sat, 29 Jan 2022 13:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA664C340E5;
        Sat, 29 Jan 2022 13:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643464487;
        bh=jdMmg61Uj/7zuXMm27/Q2s/KPQH0BjjCZOcFA861UUU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JFjZFT3bFIH6EN4zyFbXEJlYME+o7FKRXh/uE+IBMW8TK1mNLK9lfU71GQflVVcIc
         lofP3RxKBDqgxkM6xBGbdYD6IMDWjXLpXvUPVOl7jOishiPk4Jo/GbGXw/8XcdLQ06
         Y5g64pQge5CWcSvJHj5/8QA5YZscUitjHG3ruvr7U8ZKNQGdXsWJR+FNqxrfMTMyot
         OVn0/dV5Z0r4H3cJQODjl8LP6e6O+EgPuc3acugUVrImgiMbTGMYwVthl2/6pNp+xP
         2WKC2p7M/laCtISGlULrL26Q6kSkUxItKoAkyx+5cTSdV7u5eBnrRDVFBmOuLfC0nP
         R4JwXZb4EAYXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA1D2E5D084;
        Sat, 29 Jan 2022 13:54:46 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220129131808.46682-1-brgl@bgdev.pl>
References: <20220129131808.46682-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220129131808.46682-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v5.17-rc2
X-PR-Tracked-Commit-Id: 8aa0f94b0a8d5304ea1bd63bf1ed06f9e395e328
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4cd90083d32574e52ac839c6c7e4ff445ac4472c
Message-Id: <164346448688.28926.9977405184183787164.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jan 2022 13:54:46 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Jan 2022 14:18:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v5.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4cd90083d32574e52ac839c6c7e4ff445ac4472c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
