Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E6B477CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241098AbhLPTvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:51:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50606 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbhLPTvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:51:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31DFBB8261A;
        Thu, 16 Dec 2021 19:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8112C36AE7;
        Thu, 16 Dec 2021 19:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639684268;
        bh=2pl8Enwxcl5nnaLkSULADaDvhyPSTnW1CzVHBoHpDVc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ila7bDqzOAT7sq6x/GHvTSs4ZyOq5Gn/zHdL7g8pBtXVX2DCWVgoL6SFZWX0MwzkS
         UI44zkxw1f38yb+eWXDJ7J1CCWkuHytVn3//S1S0Q4qqe75oS+2HFCixe2b/WZpEkn
         QooCBpia7eMBFWxNDbgnJAbZ7aYOeKL6h/kytnXwpBKOW5W1QF/BI7NuASz3jrgv0n
         rHsoPH6FmJ5PXiqoz8FgTiUQXEkqV3cPTAxFv2/OMzPoizssGoPOfrwUx38Ii1lDem
         m+peCRe/6xnjC5D9wDNOctYDsD/XVERmz4xrcw2M0MiJ0WHWeo2u0vZkcZu4GYA8mr
         UnfD3YtS1N3+A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B62D9609FE;
        Thu, 16 Dec 2021 19:51:08 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v5.16-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211216192148.1577380-1-sboyd@kernel.org>
References: <20211216192148.1577380-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211216192148.1577380-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 54baf56eaa40aa5cdcd02b3c20d593e4e1211220
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a52a8e9eaf4a12dd58953fc622bb2bc08fd1d32c
Message-Id: <163968426868.19386.17722804010777353831.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Dec 2021 19:51:08 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Dec 2021 11:21:48 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a52a8e9eaf4a12dd58953fc622bb2bc08fd1d32c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
