Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44FF5A9CD2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiIAQPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiIAQP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:15:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CE2220DD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:15:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27E8961F78
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 16:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8942DC433C1;
        Thu,  1 Sep 2022 16:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662048900;
        bh=kkJWnAECW2shhV7o/E4tny0315pPgUtNsb2VZGH5UUc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sO4+ds1/FTgg7WnhSbl15b/zUW3JuBOHvooNW84OyKx9zdb0EU7UN2PxLJWovz7r8
         iFeijy95i4XW2it23+Hduiz1MlqDphGaii/LnWtqjFRf5C8NA8IFwxK4Tjn09aVsef
         N5OH4wM41GAAOititeWp8/urQAnHuJnhr+MPI/FQCbEfcAL8HrzXFD11dApBHijisg
         0aK7Ke/IIiu3THNyG7HfYcRXRwDMyb7auqb6dN+8w/KTHIdOUTLQxgzS8F7z0Xb/Z7
         FZX4KFa3AUiShu3Pk0/ewKXudp4SJ7a7959qB0QdJ7P8AZgtbdDRnLAzO4430u9zFY
         kNSB6Fw+nLxFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73742E924D5;
        Thu,  1 Sep 2022 16:15:00 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.0-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <874jxrh5s7.wl-tiwai@suse.de>
References: <874jxrh5s7.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <874jxrh5s7.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.0-rc4
X-PR-Tracked-Commit-Id: 5f3d9e8161bb8cb23ab3b4678cd13f6e90a06186
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2880e1a175b9f31798f9d9482ee49187f61b5539
Message-Id: <166204890046.19752.14878926071050811043.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Sep 2022 16:15:00 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 01 Sep 2022 10:12:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2880e1a175b9f31798f9d9482ee49187f61b5539

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
