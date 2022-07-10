Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F06A56D03D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 18:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiGJQyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 12:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiGJQyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 12:54:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCF09FEF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 09:54:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 784E160AC3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 16:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB95DC341CB;
        Sun, 10 Jul 2022 16:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657472073;
        bh=RJe/F30zDTkTLJyR+NnWcBME6RAAeRXwMeQamdFA1sA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DbLupJAw0EbQoES8OOX7gmWtkXDk+GPNrP8VPviYPq4yOmWDgZp7vg9CqB69myB+B
         0rV3BPKZSHYx8/KKdF6HlYEL6rn4JvUudEoJPauysRE7rnl6LhjgoI+eqR95ubaRD6
         YwulSd8from3Ws/CbgyrhFvOzTUzY+U2q/0t7gobN6VT4F6+Dk9fUG7+cZ9LwZEuvA
         MwM9ifekfjWPX37VgRIVa2Jn4WYil9YHQFz7/mSfy0CyrEaeM7I5lGEcBy6eM4lXmw
         d+ZU10FWf+p0l0/O8MNoNvY1u0a6A/GhFoLX30qLrRJA1MZUFuhlU5K+IM4JMdy9Uo
         xS8O1mNH6ZqGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4BF3E45BDE;
        Sun, 10 Jul 2022 16:54:33 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fix for 5.19-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YsrujMflc51TazvD@kroah.com>
References: <YsrujMflc51TazvD@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YsrujMflc51TazvD@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.19-rc6
X-PR-Tracked-Commit-Id: ee6c6e7342471d468096a16bee9f89b5a6c1e39d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5867f3b88bb54016c42cdde510c184255488a12b
Message-Id: <165747207380.29896.8445048268539269693.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Jul 2022 16:54:33 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Jul 2022 17:21:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.19-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5867f3b88bb54016c42cdde510c184255488a12b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
