Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2478457F619
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 19:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiGXRBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 13:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbiGXRBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 13:01:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D572211C1D;
        Sun, 24 Jul 2022 10:00:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83D57B80D8C;
        Sun, 24 Jul 2022 17:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36834C3411E;
        Sun, 24 Jul 2022 17:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658682056;
        bh=z7Gquf+0wz651sKDt6/qleTIpxs2uK3551QZAZKWkKk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SkwLtxLRvjLdIhbrJ3euTuSOqMdGwGLY+im5wzpatFBqpxA92ASKIVhiaAI9jEXxW
         db0JyNz0vrwWQOAS11phdE9KFh8GvbzSLNSUdoa2VSDBS4EZbHijsSh+QwAzBriC1C
         9QnX+j5BCTUur1voNc6iJ14mnRPs5xFfy4eETBbh5m+UpHLML8LpX6Mhai+RfQPrOJ
         i6pkTnDz4ujSPmiovS3+2OGNNUpW4V6dfhvwpRpa0otS5hxif/Q81ZqMdwnmYYWv97
         xgg0VVZOhuFC0Q+LZSjbiNTeiK8dY67v3MJuzKdJwDI13JC+kodPssOD3YeKxFYJw8
         cqVyDpNey/NYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22910E451AD;
        Sun, 24 Jul 2022 17:00:56 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220724065909.1484190-1-sboyd@kernel.org>
References: <20220724065909.1484190-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220724065909.1484190-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 25c2a075eb6a3031813b6051bd10dfc22c36a2a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 714b82c18ba0d2e76e9c3fd7785ff5a060f5980b
Message-Id: <165868205613.25283.993300011168008308.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Jul 2022 17:00:56 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 Jul 2022 23:59:09 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/714b82c18ba0d2e76e9c3fd7785ff5a060f5980b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
