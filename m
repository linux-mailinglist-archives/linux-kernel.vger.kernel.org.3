Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF19258BC2C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 19:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbiHGR6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 13:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbiHGR5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 13:57:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFB9BED;
        Sun,  7 Aug 2022 10:57:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7174FB80D80;
        Sun,  7 Aug 2022 17:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13950C433D6;
        Sun,  7 Aug 2022 17:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659895070;
        bh=IiojY1fohh7qBhT3uB0IQOBvuLHX5CnT1CnOH98VRGg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Oa1ipcZVbiagIvlXyV9zskHwkvblLCbHxO+YHq2mHpsUw5MBabnTr+eE5v3ZjC89s
         nQk1RqTsNAGD2oT+hgmsEAKeXcFCb6299GgZ7zu8sD3xJulSbnkB8G9bjdsKXQSsGi
         m10SDM8HPqJt5u3nBH05Y3W9mW5g5+DyWZDxbnXFX8U56Bydt+QP5weqjp20/N6caN
         7ScmE5ofxGdfhkEonGYFl7sqHP3hoHYq14X0XYBR+++SxHomWzDZrqVHWsr6/mTvlj
         I/k1+rNh4b2UkD+kZ9TUyoXrNHyOC7pBV3fLP3Blzjr8HPWhQ4ncYR2CNWA390CRXd
         pHb+RnzNUt1PQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 029B2C43142;
        Sun,  7 Aug 2022 17:57:50 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev updates & fixes for v5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yu7J2Yj6UyAiE2Ne@ls3530>
References: <Yu7J2Yj6UyAiE2Ne@ls3530>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yu7J2Yj6UyAiE2Ne@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/for-5.20/fbdev-1
X-PR-Tracked-Commit-Id: 6ba592fa014f21f35a8ee8da4ca7b95a018f13e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5a8466d37d30cfcc8015789f4a3f0c44b6c7bc6
Message-Id: <165989507000.6057.14562247245315787705.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Aug 2022 17:57:50 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Zheyu Ma <zheyuma97@gmail.com>,
        Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Aug 2022 22:06:49 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/for-5.20/fbdev-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5a8466d37d30cfcc8015789f4a3f0c44b6c7bc6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
