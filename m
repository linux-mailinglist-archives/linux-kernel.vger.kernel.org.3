Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4FB59EDBF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiHWUsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiHWUsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:48:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51E42643;
        Tue, 23 Aug 2022 13:42:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D3F0B81CFE;
        Tue, 23 Aug 2022 20:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2803C433D6;
        Tue, 23 Aug 2022 20:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661287373;
        bh=wDJjUseLRfT7oG7UQoF2t2LQ+BUOGCdk2Xd7USJJ5l0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ERD9FvTYr73irBhJ8U3VPuUG1C9Vrc/Pxbjo5/32z5Z5e8wPPGG0BzpIrbKNfZpKR
         vJVfiVc9doGtP0SVdjBGB+RY7rzgfcTzcKt7DydjMEIrTPF56kNBpSNU759/SUKN8I
         PteLAGtLgbyumnU0+y9UM+L8QsUqwDjiT8rZ1PZ28g4yS/3yHH++GQETNO2Pskwntn
         K1582rAfAhDJUZotCQiCutCrQ20NTZagWl6WDhpwuhmhLW6JxxxI2VoFUbfKWsq5mT
         O/oRTokH4z1T75HxlGoPsjzoTriS466oIw8yaN+MlN8lAhtLY7Lv3tVD3gBvPp1+z/
         nzzOhMl3y6LqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1AD3C004EF;
        Tue, 23 Aug 2022 20:42:52 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220822170721.1e32635aaedb6f4c53933390@linux-foundation.org>
References: <20220822170721.1e32635aaedb6f4c53933390@linux-foundation.org>
X-PR-Tracked-List-Id: <mm-commits.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220822170721.1e32635aaedb6f4c53933390@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-08-22
X-PR-Tracked-Commit-Id: 9c80e79906b4ca440d09e7f116609262bb747909
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95607ad99b5a4e3e69e025621165753718a6ea98
Message-Id: <166128737291.14227.10483108215624279054.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Aug 2022 20:42:52 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 22 Aug 2022 17:07:21 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-08-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95607ad99b5a4e3e69e025621165753718a6ea98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
