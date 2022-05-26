Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654BF5355F4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 00:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349983AbiEZWFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 18:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349995AbiEZWE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 18:04:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8CAE64FE
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:04:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3773861BF5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 22:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75DBBC385A9;
        Thu, 26 May 2022 22:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653602694;
        bh=09wkpZbArQV5BEon669DlciyAj/pn5Mx2IlI0Lgl7kY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rMeKp9XZEA+dG1Ai1NrSgdzO/h2YREibBboyqB9XyraBQvvhm1TrXXM/5yruqCLHu
         umXvgj1MwI/jZ/30oNWiwMbPdPPtJ/cioIxZVT2yzhGncqBzKbN6We+KZxpPYQgINR
         Lsp89A1FcDW4mH6RdOfm1TIScnxX9bnlW1yubgWJc080cc7FyNJ9e7BgSo7ItDtJ5i
         8ndTRwHTukjliM3Miyg8Kyc6/cMJjKFU0GFc7t61u2HKmNjdN/djj5JSLHNEvt9HlH
         ZeCOq7tzeAErKeOozPfb8XWFpT4UETdsVDavNJ3ZAxbhzgQFJNUe7aeJg7j7wEsbMU
         XE1rOxC1tzUBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64B38F03942;
        Thu, 26 May 2022 22:04:54 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY24U_2uwebN_a1M+ABVp0eqBai1c4H7oM7e0mDaGmFi0Q@mail.gmail.com>
References: <CABb+yY24U_2uwebN_a1M+ABVp0eqBai1c4H7oM7e0mDaGmFi0Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY24U_2uwebN_a1M+ABVp0eqBai1c4H7oM7e0mDaGmFi0Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.19
X-PR-Tracked-Commit-Id: 79f9fbe303520d2c32b70f04f2bb02cc2baaa4c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cdeffe87f790dfd1baa193020411ce9a538446d7
Message-Id: <165360269440.24340.8900834683115393542.pr-tracker-bot@kernel.org>
Date:   Thu, 26 May 2022 22:04:54 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 25 May 2022 20:57:44 -0500:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cdeffe87f790dfd1baa193020411ce9a538446d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
