Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2494F4C5F07
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 22:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiB0VXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 16:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiB0VXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 16:23:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E03340E6F;
        Sun, 27 Feb 2022 13:22:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C252B80CE0;
        Sun, 27 Feb 2022 21:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3906DC340E9;
        Sun, 27 Feb 2022 21:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645996952;
        bh=MTqYAS65HsJ3kfgzcFKfvXWHBRR1fRMHt7ruXMD1vto=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=namUD+Gbu1XHfdj3Dt9OPLtEkAikwIMZ7Q981JAvFNi0DUhOqXaCh0sQhlRx0cpnL
         Utb4YgJqjHKFijFs77eLWkPt+g1rPpO6EXit6ZrHa8ia3CfgFfbAp21DSJWv3wVDEO
         mSCEX6nk1EQKSsg2T8mUcAh9Fg4TLZkQvMERxpomkbsbUWNkXFmse42S9sc4ODfAeR
         71uMcuiD4/3DDOCfA9P17PMbAPS49SdNS2GMX/EhhxyBLqJXozhTBDc69PcFef3bOO
         0FF0xQkJh4bZHG8gPoUrbJ1NQYg65/BjMKsk1AZ2Of5ta8W4OhjskoF6XJkzOm6bCq
         VqOFfOrDQCPcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23A9DE7BB08;
        Sun, 27 Feb 2022 21:22:32 +0000 (UTC)
Subject: Re: [GIT PULL] pin control fixes for the v5.17 series
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYM21hcH5d9rXyvjMPHQp429OZ1Zcy7uLU2tndoJcOmUQ@mail.gmail.com>
References: <CACRpkdYM21hcH5d9rXyvjMPHQp429OZ1Zcy7uLU2tndoJcOmUQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYM21hcH5d9rXyvjMPHQp429OZ1Zcy7uLU2tndoJcOmUQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5-17-3
X-PR-Tracked-Commit-Id: 486c2d15aa812d669bb27f8241aa5d5dafbac5b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6676ba2a6df6864a6b7b11f20166026e2201b627
Message-Id: <164599695213.31011.11563318777928459300.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Feb 2022 21:22:32 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Feb 2022 02:11:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5-17-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6676ba2a6df6864a6b7b11f20166026e2201b627

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
