Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4FA55B330
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 19:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiFZRgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 13:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiFZRgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 13:36:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F23E0AE;
        Sun, 26 Jun 2022 10:36:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FFEBB80DF7;
        Sun, 26 Jun 2022 17:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11008C341CC;
        Sun, 26 Jun 2022 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656264973;
        bh=ieXD1kQhGxRYJgHXHobMXM0t1RkB4M49pmPO8Yk4F6E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UF6Dx05iyTTxFzyYfDE1erUZlX85evU7VZOd76Jo4ik5djYWq7GBrVgvKfGU2Gjvv
         9DJwCjVDfPKN+2JVybni5LoWhYz1rLSK3E9l8y+o3KJ2+/02GVX3io5l9qvKN7tbcc
         yMJb3GXmYfOTVXYKIVc50/adO3o65X2E2BD1zzRVmRqdCJtaJRV2G4xSk9qSOvxs7i
         OVB00b196gGOf8yIzgJYum3UTMhNGRNRWYzhVdcB89Z7BClaEyGwtOFXzweBCYGZJ2
         vwNAIhBOHZFPzGYh5lIjzRHlhVc3o4K2ECh9fKnsLZHF0gG7w3NVIIS3+7rsvDSjS8
         FPgm5o20L2VSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8646E73875;
        Sun, 26 Jun 2022 17:36:12 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNARjq-x+8rdXfkVt2YEoJsjnZNntxurYTwOqEaAX71m04w@mail.gmail.com>
References: <CAK7LNARjq-x+8rdXfkVt2YEoJsjnZNntxurYTwOqEaAX71m04w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kbuild.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNARjq-x+8rdXfkVt2YEoJsjnZNntxurYTwOqEaAX71m04w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.19-2
X-PR-Tracked-Commit-Id: ff139766764675b9df12bcbc8928a02149b7ba95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 393ed5d85e8e07021d8db07d7c8348dd928349d7
Message-Id: <165626497294.22456.4474691021180489498.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Jun 2022 17:36:12 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Jun 2022 07:15:35 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.19-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/393ed5d85e8e07021d8db07d7c8348dd928349d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
