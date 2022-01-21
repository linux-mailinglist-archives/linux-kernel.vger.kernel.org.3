Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DC5495AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349147AbiAUHiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349100AbiAUHiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:38:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35CBC061574;
        Thu, 20 Jan 2022 23:38:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 450B0617B8;
        Fri, 21 Jan 2022 07:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADC09C340E1;
        Fri, 21 Jan 2022 07:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642750684;
        bh=IhR4gGamsSozOTTS9oSA3rLyrSVHqdC6bwMCVoXTykI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FvK5iWbrUe56LdrLXO/FhrTsH6X1pZOn2bNArqxGFPYouUv7dmPfe80o1WMFokpCg
         zQns1KP1rolnIstSSwbeG2YAtsYdgrwopdQpE+sqz+V+kxqxDGvCJNMAKSQRx6I3Xn
         G2tMZA3FJAzoQwGCDMh/UgqHoYk9pSGV398xWYq42n6S1bmcBbvSyK1lIKsn00Pq+R
         lwEENMCRkYDbzcFTnxM6KRKz+EJSlIWrX6NySxwUKlL2x3fpF9LRdWvVGbYOrkzbHr
         PpisXyNbRykoR1KZ4oI+d9vY3y5iBJLeO5IVBrja9zvgoGpojZNF2RN03itBKsmwIw
         jxCWSy21L3vtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9CAC4F60795;
        Fri, 21 Jan 2022 07:38:04 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for the merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220120205637.2234852-1-sboyd@kernel.org>
References: <20220120205637.2234852-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220120205637.2234852-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: b4966a7dc0725b2baa12b0aeb1489d52568a2aad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 39e77c484bcd1865ff6abdbde6b36eb91ee1ff33
Message-Id: <164275068462.15932.15816793662328397684.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jan 2022 07:38:04 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Jan 2022 12:56:37 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/39e77c484bcd1865ff6abdbde6b36eb91ee1ff33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
