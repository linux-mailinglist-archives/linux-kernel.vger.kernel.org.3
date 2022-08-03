Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8B558853A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 02:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbiHCA6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 20:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbiHCA5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 20:57:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23A94D4CC
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 17:57:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73C7BB82010
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 00:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2837EC433C1;
        Wed,  3 Aug 2022 00:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659488262;
        bh=5QXtuoePxRS824DTLfNDDNbL4FO2QlSLY4zyPTSiKdQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BHvPG8MentQzX17+Le/734HhtupnxT9uTrck2NjRuiHmhuY/a5RgvPVJykq437vbm
         3B9my/1Np0F3HtMeL9L8V3SWZqFbwdnYmtEqPcJUau0rlhUsH/8qUKBCS2yUFZwtd0
         z+wwcz5LIyav83+kBRHXUEJPKCXQ0ABnqr591KIMdG+DlPLNwGVRr3eDQs/E/u8RL4
         TNg/lNORW9ZZQj6z/UxCKgbIoImSr3rYLxJfG7ZKZiVite2WIwUHH3TmGFPuYJ+FZM
         3fGpwLWaPJUHIz3KjOVdSSrKeBfLWcMGEkBgdw2RXSAEJW2TzlI8Jk+DH7hsKKqqNd
         pE6XdRVy0dwmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18B25C43142;
        Wed,  3 Aug 2022 00:57:42 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator updates for 6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220731232428.2219258-1-Jason@zx2c4.com>
References: <20220731232428.2219258-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220731232428.2219258-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.0-rc1-for-linus
X-PR-Tracked-Commit-Id: 7f637be4d46029bd7700c9f244945a42dbd976fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0b09f2d6f30723e1008bd9ddb504e302e329f81
Message-Id: <165948826209.18250.10988782973816315303.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Aug 2022 00:57:42 +0000
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  1 Aug 2022 01:24:28 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.0-rc1-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0b09f2d6f30723e1008bd9ddb504e302e329f81

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
