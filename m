Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0DB5A3FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 00:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiH1WSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 18:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiH1WS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 18:18:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E3F2F3B4;
        Sun, 28 Aug 2022 15:18:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0696B80C98;
        Sun, 28 Aug 2022 22:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 851E0C433D6;
        Sun, 28 Aug 2022 22:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661725102;
        bh=BAVRjdZzgcJClMvrwwFumZM9rJCrJKpKbNMymrsRgyM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=boGxfnqlLCc640zcJVIUsCkNN98t53Joa9tbLaspC07j/ENTkEj/8HrCH1dN6KjNG
         GKsSfm9ITaZz2Xy6vVgHiAYhSwsYCoJUuNWLvLw5tGAHZu4rYHMm1YqY83Vz9VMpUo
         Wh1kvTQuEzwWTNsYEUIQ8QNXTK5rQtWGgb0Kuj/ICKA9t9zZNn1z/scnOeVO2BF72o
         SGCCSp5kHG0BRtNGrWW1sdcz/Wk0vF3FCS+tRqIltrIrqn9giljCv9z4WSZoSap8AW
         CxaS+Th8JHG466ufXPyBiR17j3GQnYhX5s09kGlp1xdWz6c5plUzG+3CqPQxVD5EWO
         ES/hBmOE0/yxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B501C5A8AF;
        Sun, 28 Aug 2022 22:18:22 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220828144219.618a26f33e0aae5407fadd88@linux-foundation.org>
References: <20220828144219.618a26f33e0aae5407fadd88@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20220828144219.618a26f33e0aae5407fadd88@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-08-28
X-PR-Tracked-Commit-Id: 0ebafe2ea879e97fef6bd97f72303a6ccf39f092
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b467192ec7070d2d6d14ab5e6774a8afdcc9e89d
Message-Id: <166172510240.7878.15841173402445943921.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Aug 2022 22:18:22 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Aug 2022 14:42:19 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-08-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b467192ec7070d2d6d14ab5e6774a8afdcc9e89d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
