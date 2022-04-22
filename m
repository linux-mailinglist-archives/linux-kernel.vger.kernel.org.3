Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6372050C19C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiDVWES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiDVWEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:04:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FE541A282
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:46:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DA4361E6E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 20:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA4F4C385A4;
        Fri, 22 Apr 2022 20:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650660405;
        bh=2Zhc64dfvR+fjBhKV+w2NFx9BXui1sx0Vw/Nr+IrOj8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VmdH1cmq1Zqo+KhPFDd7nH38wYyY96yzMmv3Sv7bsVrBwEK2sqOYu3790XaLjsAsj
         7AsEE8zhwYat58K9LMh3ZRmiwR2z85KtZozQzSWLFYhMhKB7OyqVlvaamExrvrl6WU
         93cFO0eWKr8A5LnA7fjOlSYZMHGMzNkpfSIHmKdr4pxjYqswwBk1Xf37eOksMPDsaY
         BEOX9inE4R/oWHniy0iy4jYi3IRJTjxxh0fcWCc5qQOpOgPUsrh/DH0GDxMgWxjUvj
         Bl6bbBson0CWkZF5+4uGWK9lBNfVxdWZMl2eEdWZZDoddsnbnSPO3VavX4epiN2FL4
         5Eoq3AE2mq1Mw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6D33E6D402;
        Fri, 22 Apr 2022 20:46:45 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.18-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hsfq5tydf.wl-tiwai@suse.de>
References: <s5hsfq5tydf.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hsfq5tydf.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.18-rc4
X-PR-Tracked-Commit-Id: 86222af07abf1f5f07a5873cc399c29ab8a9b8b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d230968ad0d15250af54c6ac70c5ae95db63c78
Message-Id: <165066040567.3510.7573736498306317463.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Apr 2022 20:46:45 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Apr 2022 08:39:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.18-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d230968ad0d15250af54c6ac70c5ae95db63c78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
