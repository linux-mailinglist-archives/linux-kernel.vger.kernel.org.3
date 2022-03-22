Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44054E360B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbiCVBlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbiCVBlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:41:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822521408F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 18:39:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1328615F6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5670AC340EE;
        Tue, 22 Mar 2022 01:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647913189;
        bh=4YlVfWY1f6q0TCJGXupQXSgaW/J+hFm3bX84bVgdJrk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mswkzdUh8nrB0/N2TU4fGegCZ2ggRDMOWxHJ8P+IldegcYO65WdAWdUtcOoRAXuye
         fhu8HgGbnidP9sbopm3VOMRJZdLMrPp3LzSyJQjGk/2s8XCn9f3bV+o5VWVu1EFNzI
         qTveNVaf9/lwzcTSWEw5rPXiAusFGatfZQmRrPMYNO9T2UUOEFZriZDRqZH/656WS9
         SyntQEtdL4l8KfOw8WT3HDAufkF7hcu7XmJYPpCGx+XeNm7wxII+3M+pV2h/At6D20
         TtTpi8n/Tn8Ih1+Ga4yQsiN8E68oiWpny5OJ1LlZYRfsvD1rE9XIzS6O7O2j9jNIiE
         ijBoSjd92UEDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 428B7E6D44B;
        Tue, 22 Mar 2022 01:39:49 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220321123541.37912C340E8@smtp.kernel.org>
References: <20220321123541.37912C340E8@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220321123541.37912C340E8@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.18
X-PR-Tracked-Commit-Id: 0074f3f2b1e43d3cedd97e47fb6980db6d2ba79e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a50a8c3833864d959c18f742bf6aa1d38fbe28c9
Message-Id: <164791318926.2267.16572059139430382489.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 01:39:49 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 12:35:29 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a50a8c3833864d959c18f742bf6aa1d38fbe28c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
