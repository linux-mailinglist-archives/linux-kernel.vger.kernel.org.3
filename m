Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4362448D004
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 02:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiAMBMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 20:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiAMBKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 20:10:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CC8C02982C;
        Wed, 12 Jan 2022 17:10:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F22261BBD;
        Thu, 13 Jan 2022 01:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6246DC36AF4;
        Thu, 13 Jan 2022 01:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642036217;
        bh=T9Qq55WQrHWF9sQ1Uxxv3PAAf4TtllewskzHNndyiJc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mMo0P1sakbJJ8/1zYvMV39nFwB3+B9wbsAi+dGvEwTOuDbUKhYqo+Ljk7bhRTkXPM
         b4wsrdjurK3kH8X17YjAiZC/68ku6JUuUe5QT4pScIfmEIPvguXyZ6v5S/P8r4WlUl
         1m+I8sK37Stz1Tk93zHglN6mtisPBLWLRm67+Tn5msS5MQUmReaFb2cn0z08Nm/C5l
         hGD0kIEZYbgNl5LKnWTBqznX/Nbnb96rnZ/0xDm1v5Bk22CawKxO+ap7bMdObi3DSi
         1t9sqTlT3OIE5Ml3CKDwCiTgSimNJ/sG4s7TL7fPldj5RpKknUjV8R/g5FhB3CCSD6
         h4/8OyDIE67fw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F02AF60794;
        Thu, 13 Jan 2022 01:10:17 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220112212853.2401468-1-sboyd@kernel.org>
References: <20220112212853.2401468-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220112212853.2401468-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: 4afd2a9355a9deb16ea42b896820dacf49843a8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 455e73a07f6e288b0061dfcf4fcf54fa9fe06458
Message-Id: <164203621731.494.17049301406769409601.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jan 2022 01:10:17 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Jan 2022 13:28:53 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/455e73a07f6e288b0061dfcf4fcf54fa9fe06458

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
