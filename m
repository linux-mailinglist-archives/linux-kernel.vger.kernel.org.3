Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2328B48BC82
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347846AbiALBf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:35:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54808 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347831AbiALBfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:35:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40AE5B81D53;
        Wed, 12 Jan 2022 01:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF197C36AF4;
        Wed, 12 Jan 2022 01:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641951352;
        bh=VTsbrSDESN0qyaQW2AMLxvrfq7SYOMSMobPts2mldiY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YdFOAJJ140SkrsY8oPfinicFPiCGzG50+bY7iEzLN3TZPNuDMq7iTmnuSyv0TPurl
         IViQ9QgTFJwmWP4Bcp3BM8xsoT0GwaskoAdWf/VAcIyN+ZJ4Joa2Gg+up2E4Z7Cr+L
         rvRRALkFyH0vcgq1JDZsp3o8VZX+fE+Hwe5K57kktkuQYzVtAiT7f2hvEjTQ9K55Qt
         gclaiQIl0AnS16r36oyvgXLZzd4ptS6+8NnHca5j6dt8HRCb5SWy2gjLCNpGuctsNA
         XfvTGCd611ienN/qIc4orHD9/0TJfQ1ob5SIQQK/CSItQpBIeVwABfttt0diqFIZhn
         +VlU1LLfE+amg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCC82F60793;
        Wed, 12 Jan 2022 01:35:51 +0000 (UTC)
Subject: Re: [GIT PULL] Enable -Wcast-function-type for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220111193855.GA13612@embeddedor>
References: <20220111193855.GA13612@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220111193855.GA13612@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wcast-function-type-5.17-rc1
X-PR-Tracked-Commit-Id: 552a23a0e5d0a84cecd4687043d8030673981d30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01367e86e90948b1ae8f66b2c23aadd7e8374e34
Message-Id: <164195135189.30057.7166660733779506774.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 01:35:51 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Jan 2022 13:38:55 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wcast-function-type-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01367e86e90948b1ae8f66b2c23aadd7e8374e34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
